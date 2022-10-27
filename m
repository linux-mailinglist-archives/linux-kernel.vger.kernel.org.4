Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018660FC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiJ0Pwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiJ0Pwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:52:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C40191D7E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C791B825E3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0488C433C1;
        Thu, 27 Oct 2022 15:52:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WtWWBbcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666885947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+H28lmnZqvVSaZ6SeDzfPSiOhLfyOeKgyNf7Ph37nzk=;
        b=WtWWBbcKFbUgBeLMEa8+Ymqux0SUU5z/tb1MqAE5y24F3O7huK0wC/jzyYJc1hpJ9ULNej
        nLfIyhCUH8f61NXhs319LndlR0uweCHZ4AdAbZJdrO9X1D6H1vfriTJtO+hVz5I3uvOUpa
        /66loI+gBIdZOjyVF8TSQnKqmU7Ay3Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9028b15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Oct 2022 15:52:26 +0000 (UTC)
Date:   Thu, 27 Oct 2022 17:52:21 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <Y1qpNZuoIyvT5Edj@zx2c4.com>
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221027150525.753064657@goodmis.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:05:25AM -0400, Steven Rostedt wrote:
>    We are hitting a common bug were a timer is being triggered after it is
>    freed. This causes a corruption in the timer link list and crashes the
>    kernel. Unfortunately it is not easy to know what timer it was that was
>    freed. Looking at the code, it appears that there are several cases that
>    del_timer() is used when del_timer_sync() should have been.
> 
>    Add a del_timer_free() that not only does a del_timer_sync() but will mark
>    the timer as freed in case it gets rearmed, it will trigger a WARN_ON. The
>    del_timer_free() is more likely to be used by developers that are about to
>    free a timer, then using del_timer_sync() as the latter is not as obvious
>    to being needed for freeing. Having the word "free" in the name of the
>    function will hopefully help developers know that that function needs to
>    be called before freeing.
> 
>    The added bonus is the marking of the timer as being freed such that it
>    will trigger a warning if it gets rearmed. At least that way if the system
>    crashes on a freed timer, at least we may see which timer it was that was
>    freed.

FYI, there's a related issue with add_timer_on(), currently without a
straight forward solution, in case you're curious, discussed with
Sebastian and Sultan a few weeks ago. Pasting from that thread, the
issue is:

 1 while (conditions) {
 2     if (!timer_pending(&stack.timer))
 3         add_timer_on(&stack.timer, some_next_cpu);
 4 }
 5 del_timer_sync(&stack.timer);

a) add_timer_on() on line 3 is called from CPU 1 and pends the timer on
   CPU 2.

b) Just before the timer callback runs, not after, timer_pending() is
   made false, so the condition on line 2 holds true again.

c) add_timer_on() on line 3 is called from CPU 1 and pends the timer on
   CPU 3.

d) The conditions on line 1 are made false, and the loop breaks.

e) del_timer_sync() on line 5 is called, and its `base->running_timer !=
   timer` check is false, because of step (c).

f) `stack.timer` gets freed / goes out of scope.

g) The callback scheduled from step (b) runs, and we have a UaF.

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

It would be interesting if your patch fixed this case too. But maybe the
above is unfixable (and rather niche anyway).

Jason
