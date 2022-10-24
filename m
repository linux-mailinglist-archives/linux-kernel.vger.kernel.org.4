Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE90609F63
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJXKyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJXKyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:36 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7378C65D5;
        Mon, 24 Oct 2022 03:54:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C9E561D80;
        Mon, 24 Oct 2022 12:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608273; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=BOoIY9WJFmBt1PSHlkPpnZQdqGiT4O4onH5CW/obUpI=;
        b=aO0uZ3v90bbg6mi3ImXFlkzhdHX/g0FQCi0pycvauxRpctXYkmPO+cOdvY0LbEcCXZLkUr
        N1k7H6QO3ImFEEKEkU5ghTkU6tbR/35k1X9QQV1e84adehoMye5oeTX9kxZoatKYbcSGNm
        D4teRsHUUeE7lzcA4nVfOSJwEisS1Qz3AqbJCYaF6Q43b6E2GoKjcAKa7V1/7/0DsSlxad
        moM8HgLNk2F63w+h80FgwXG66xSu15BqOxhktjyb7sqhBwJRh0bhvDo+skJfp4vPMKhQHS
        jsVBy+gfqOonqQGMg8wexjfk+tMuWi7380sqd13iw/QmD5V8OBf8yecVVUYhuQ==
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
Subject: [PATCH RT 6/9] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
Date:   Mon, 24 Oct 2022 12:44:22 +0200
Message-Id: <20221024104425.16423-7-wagi@monom.org>
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
References: <20221024104425.16423-1-wagi@monom.org>
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

v4.19.255-rt114-rc1 stable review patch.
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

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103190937.hga67rqhvknki3tp@linutronix.de
[bigeasy: The logic in v4.19 is slightly different but the outcome is the
   same as we must not sleep while waiting for the irqsafe timer to
   complete. The IRQSAFE timer can not be preempted.
   The "lockdep annotation" is not available and has been replaced with
   might_sleep()]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 kernel/time/timer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3e2c0bd03004..0a6d60b3e67c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1272,6 +1272,9 @@ static int __del_timer_sync(struct timer_list *timer)
 		if (ret >= 0)
 			return ret;
 
+		if (READ_ONCE(timer->flags) & TIMER_IRQSAFE)
+			continue;
+
 		/*
 		 * When accessing the lock, timers of base are no longer expired
 		 * and so timer is no longer running.
@@ -1336,6 +1339,12 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * __del_timer_sync().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		might_sleep();
 
 	return __del_timer_sync(timer);
 }
-- 
2.38.0

