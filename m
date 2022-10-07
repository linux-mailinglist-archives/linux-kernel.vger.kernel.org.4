Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BA5F795D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJGOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJGOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:01:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A746863;
        Fri,  7 Oct 2022 07:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42CF9B82368;
        Fri,  7 Oct 2022 14:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44117C433C1;
        Fri,  7 Oct 2022 14:01:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eMCVtSIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665151283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gc+CTi0hqBE3lv4NHtn9VPsuSbCsIec3x1VhFKhhbrM=;
        b=eMCVtSIAFSVzWvb99HpdTXgmU0BBpUkV95Gs9m2hWOhSiO03vj/K0wS3A0qjE65faEY4w3
        SOm5LT6ctH/uviYCmYsc1Fagrc3RKmUY4eUsErD8BhzNz/YJ9wIthFNa2V2k+NBp83FEsm
        MxBpYBslAxVsUjdJVFrjmpcSq8fPfw0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 49238bd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Oct 2022 14:01:23 +0000 (UTC)
Date:   Fri, 7 Oct 2022 08:01:20 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 2/2] random: spread out jitter callback to different CPUs
Message-ID: <Y0AxMObsOLfqEjLt@zx2c4.com>
References: <20220930231050.749824-1-Jason@zx2c4.com>
 <20220930231050.749824-2-Jason@zx2c4.com>
 <YzgGmh6EQtWzO4HV@zx2c4.com>
 <Yz2+UsgVGRSm+o7W@linutronix.de>
 <Yz3yQzaNUcdIuUMX@zx2c4.com>
 <Yz55w4gNtZn8JzmG@linutronix.de>
 <Yz7JXEaTFWa1VLKJ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7JXEaTFWa1VLKJ@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 06:26:04AM -0600, Jason A. Donenfeld wrote:
> On Thu, Oct 06, 2022 at 08:46:27AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2022-10-05 23:08:19 [+0200], Jason A. Donenfeld wrote:
> > > Hi Sebastian,
> > Hi Jason,
> > 
> > > On Wed, Oct 05, 2022 at 07:26:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > > That del_timer_sync() at the end is what you want. If the timer is
> > > > pending (as in enqueued in the timer wheel) then it will be removed
> > > > before it is invoked. If the timer's callback is invoked then it will
> > > > spin until the callback is done.
> > > 
> > > del_timer_sync() is not guaranteed to succeed with add_timer_on() being
> > > used in conjunction with timer_pending() though. That's why I've
> > > abandoned this.
> > 
> > But why? The timer is added to a timer-base on a different CPU. Should
> > work.
> 
> So it's easier to talk about, I'll number a few lines:
> 
>  1 while (conditions) {
>  2     if (!timer_pending(&stack.timer))
>  3         add_timer_on(&stack.timer, some_next_cpu);
>  4 }
>  5 del_timer_sync(&stack.timer);
> 
> 
> Then, steps to cause UaF:
> 
> a) add_timer_on() on line 3 is called from CPU 1 and pends the timer on
>    CPU 2.
> 
> b) Just before the timer callback runs, not after, timer_pending() is
>    made false, so the condition on line 2 holds true again.
> 
> c) add_timer_on() on line 3 is called from CPU 1 and pends the timer on
>    CPU 3.
> 
> d) The conditions on line 1 are made false, and the loop breaks.
> 
> e) del_timer_sync() on line 5 is called, and its `base->running_timer !=
>    timer` check is false, because of step (c).
> 
> f) `stack.timer` gets freed / goes out of scope.
> 
> g) The callback scheduled from step (b) runs, and we have a UaF.

Here's a reproducer of this flow, which prints out:

    [    4.157610] wireguard: Stack on cpu 1 is corrupt

diff --git a/drivers/net/wireguard/main.c b/drivers/net/wireguard/main.c
index ee4da9ab8013..5c61f49918f2 100644
--- a/drivers/net/wireguard/main.c
+++ b/drivers/net/wireguard/main.c
@@ -17,10 +17,40 @@
 #include <linux/genetlink.h>
 #include <net/rtnetlink.h>

+struct state {
+	struct timer_list timer;
+	char valid[8];
+};
+
+static void fire(struct timer_list *timer)
+{
+	struct state *stack = container_of(timer, struct state, timer);
+	mdelay(1000);
+	pr_err("Stack on cpu %d is %s\n", raw_smp_processor_id(), stack->valid);
+}
+
+static void do_the_thing(struct work_struct *work)
+{
+	struct state stack = { .valid = "valid" };
+	timer_setup_on_stack(&stack.timer, fire, 0);
+	stack.timer.expires = jiffies;
+	add_timer_on(&stack.timer, 1);
+	while (timer_pending(&stack.timer))
+		cpu_relax();
+	stack.timer.expires = jiffies;
+	add_timer_on(&stack.timer, 2);
+	del_timer_sync(&stack.timer);
+	memcpy(&stack.valid, "corrupt", 8);
+}
+
+static DECLARE_DELAYED_WORK(reproducer, do_the_thing);
+
 static int __init wg_mod_init(void)
 {
 	int ret;

+	schedule_delayed_work_on(0, &reproducer, HZ * 3);
+
 	ret = wg_allowedips_slab_init();
 	if (ret < 0)
 		goto err_allowedips;

