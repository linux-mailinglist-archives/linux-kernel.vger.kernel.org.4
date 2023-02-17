Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4378069B1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBQRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBQRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:30:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6636F3D7;
        Fri, 17 Feb 2023 09:30:26 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:30:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676655024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7lH9zWlDYBELps4o96iLqp5tF7DCuj9GJk/BC4jFn4c=;
        b=BNOhYiI982P04PLbj8/ZUFlARiMwv8ZeGbXDgV3t7O1bAVf8qD7mZ2V6MIR5SskSZvbn6J
        fZEkt16lsO4Os/vr9xE+cRQoYti9WHyH6atjAJIjYitDK6rmKWRO0NdfmlqdQV5r8IjF6y
        F0AFnlOgsiZ5HkCutWvXAqOT88n2IeY02rMEvwMXy4l3bil07Gza2meF7DnrdkoEumfkX6
        i4qjnMmCw20/7TGBbfPJ9A1OgzgojMrsEXYGzlSyyGteljdBWQOdIE0+cxb9wwySw0X389
        vSdMGYO75ffHW52xMSJJ8wC1fIOON+EnTM8caRfqviNRhR1mMUCkXOj+TkCq6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676655024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7lH9zWlDYBELps4o96iLqp5tF7DCuj9GJk/BC4jFn4c=;
        b=bAGR3N4sibHQtaXTEQCF0vlUYlG1B5EHiy8oMXFu9AFZ9i7DUgK5cY7YfEM2v0Yl1tH6I6
        Y1pG5/IhTktU+WAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Junxiao Chang <junxiao.chang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, hock.zhang.peh@intel.com
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
Message-ID: <Y++5ry75hEI2NWrK@linutronix.de>
References: <20221208075604.811710-1-junxiao.chang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208075604.811710-1-junxiao.chang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-08 15:56:04 [+0800], Junxiao Chang wrote:
> Occiaionally timer interrupt might be triggered in softirq context,
> ktimer thread should be woken up with RT kernel, or else ktimer
> thread might stay in sleep state although timer interrupt has been
> triggered.
> 
> This change fixes a latency issue that timer handler is delayed for
> more than 4ms in network related test.

Sorry for keeping you waiting. Your observation and patch is correct. I'm
going to apply a slightly modified version of the patch (see below)
after I reworded the commit message on Monday.

diff --git a/kernel/softirq.c b/kernel/softirq.c
index ab1fe34326bab..82f3e68fbe220 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -664,13 +664,12 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt()) {
-		if (local_softirq_pending())
-			invoke_softirq();
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers())
-			wake_timersd();
-	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers() &&
+	    !(in_nmi() | in_hardirq()))
+		wake_timersd();
 
 	tick_irq_exit();
 }

Sebastian
