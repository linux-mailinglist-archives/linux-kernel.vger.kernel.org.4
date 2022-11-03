Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56C617824
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiKCH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKCH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:18 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE8C5FEC;
        Thu,  3 Nov 2022 00:55:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AB2861E22;
        Thu,  3 Nov 2022 08:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1667462154; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ZxhjYU0O0vxXngLgbF21571m+6DO7DnQnlwU/VKcYWA=;
        b=l9EmVc+WeSb+UvTMwVrqzYARLhTPxntmczs/zvkZtqfZWpqVzdgGB3/8iajkWfVFM4XiU6
        nqPYAqBUXdSuxXK0Wr971eDapJQJdU8KJaaLNCwGS3IV0pEMHKJ4pO8udXx3C+F3kA+qs4
        /WfaK1n5RBXWVN3CeSSB+JQNeU9stZfTXI2juTt3Z5ybdrDTFFEIKQL7TlysZM0vC0meJX
        shpw+bIByCt5toSOT6gHP7f74HCY2D5Sgdzgy3Id/CX3eapDYkNMZwtcui8pwIBYLMnPyY
        lxYS4KYAX64B83Vh2pJFPkjA/NK9QYHIoMMPa+DFf+BpYq4rYFq9bB+Zp02AGg==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Mike Galbraith <efault@gmx.de>, Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 3/4] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
Date:   Thu,  3 Nov 2022 08:55:47 +0100
Message-Id: <20221103075548.6477-4-wagi@monom.org>
In-Reply-To: <20221103075548.6477-1-wagi@monom.org>
References: <20221103075548.6477-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.255-rt114-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit c725dafc95f1b37027840aaeaa8b7e4e9cd20516

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a livelock in
the case that the task waiting for the callback completion preempted the
callback.

This cannot be done for timers flagged with TIMER_IRQSAFE. These timers can
be canceled from an interrupt disabled context even on RT kernels.

The expiry callback of such timers is invoked with interrupts disabled so
there is no need to use the expiry lock mechanism because obviously the
callback cannot be preempted even on RT kernels.

Do not use the timer_base::expiry_lock mechanism when waiting for a running
callback to complete if the timer is flagged with TIMER_IRQSAFE.

Also add a lockdep assertion for RT kernels to validate that the expiry
lock mechanism is always invoked in preemptible context.

[ bigeasy: Dropping that lockdep_assert_preemption_enabled() check in
           backport ]

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103190937.hga67rqhvknki3tp@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 kernel/time/timer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 603985720f54..8c7bfcee9609 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1304,7 +1304,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1388,6 +1388,15 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+#if 0
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+#endif
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
-- 
2.38.0

