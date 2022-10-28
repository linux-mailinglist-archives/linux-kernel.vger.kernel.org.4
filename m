Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF261068F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiJ0XzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiJ0XzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:55:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664512B196
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F1D9B82146
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129A2C433D7;
        Thu, 27 Oct 2022 23:54:54 +0000 (UTC)
Date:   Thu, 27 Oct 2022 19:55:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221027195509.6fb3793c@gandalf.local.home>
In-Reply-To: <20221027232442.GA279073@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
        <20221027222404.GA3123386@roeck-us.net>
        <20221027185859.1087d3ca@gandalf.local.home>
        <20221027232442.GA279073@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 16:24:42 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > This is probably just missing a switch to shutdown.
> >   
> Wild shot, and I don't really know what I am doing,
> but I'll try
> 
> iff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e71b3b43927c..6c1cb4a219f0 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -767,6 +767,8 @@ static void blk_release_queue(struct kobject *kobj)
> 
>         might_sleep();
> 
> +       del_timer_shutdown(&q->timeout);
> +
>         percpu_ref_exit(&q->q_usage_counter);
> 
>         if (q->poll_stat)

Or perhaps this:

-- Steve

diff --git a/block/blk-core.c b/block/blk-core.c
index 17667159482e..69b1daa2e91a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -227,7 +227,7 @@ const char *blk_status_to_str(blk_status_t status)
  */
 void blk_sync_queue(struct request_queue *q)
 {
-	del_timer_sync(&q->timeout);
+	del_timer_shutdown(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
 }
 EXPORT_SYMBOL(blk_sync_queue);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..12a1e46536ed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -769,6 +769,8 @@ static void blk_release_queue(struct kobject *kobj)
 
 	percpu_ref_exit(&q->q_usage_counter);
 
+	blk_sync_queue(q);
+
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
