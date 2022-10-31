Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09878613DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJaStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJaSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB8D2C8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73DFC6140F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA4C433C1;
        Mon, 31 Oct 2022 18:48:53 +0000 (UTC)
Date:   Mon, 31 Oct 2022 14:48:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 6.0.x / 6.1.x] NULL dereferencing at tracing
Message-ID: <20221031144850.5522b036@rorschach.local.home>
In-Reply-To: <87h6zklb6n.wl-tiwai@suse.de>
References: <87h6zklb6n.wl-tiwai@suse.de>
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

On Mon, 31 Oct 2022 08:11:28 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Hi Steven,
> 
> we've got a bug report indicating the NULL dereference at the recent
> tracing changes, showing at the start of KDE.  The details including
> the dmesg are found at:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1204705
> 
> It was reported at first for 6.0.3, and confirmed that the problem
> persists with 6.1-rc, too.
> 
> The culprit seems to be the commit
> f3ddb74ad0790030c9592229fb14d8c451f4e9a8
>     tracing: Wake up ring buffer waiters on closing of the file
> and reverting it seems fixing the problem.
> 
> Could you take a look?
> 
>

Can you apply this to see if it fixes it?

I'm guessing there's a path to the release of the file descriptor where
the ring buffer isn't allocated (and this expected it to be).

I'll investigate further to see if I can find that path.

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 199759c73519..c1c7ce4c6ddb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -937,6 +937,9 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct rb_irq_work *rbwork;
 
+	if (!buffer)
+		return;
+
 	if (cpu == RING_BUFFER_ALL_CPUS) {
 
 		/* Wake up individual ones too. One level recursion */
