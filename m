Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA88609F69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJXKzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJXKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:40 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39516B7CD;
        Mon, 24 Oct 2022 03:54:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82E1B61D7C;
        Mon, 24 Oct 2022 12:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608270; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ScROC3sGA4GWsZP9jfPmNdGSmAv/ip4dlZ5Qh/Mh1f4=;
        b=yKdjvmL0NaVsQKuw4uS6ES5CgxzRLTabK1AaP+a2OzH/14AW0ZofPSNn5zT0hgv4hbi51D
        Z//IK1Kc1oeoBrgkGvsMZ7rbfn6p1tvDY+qKEqbM9VgxEPSMLsHvNV4swoHLlQY6pmi60a
        bh54YY162QKwbNpbul750XTDSFu99iAlejmGfI/otbTzjcf8QVLJh92A618XNbdfTLtfnN
        NoA/CrtYXha+JjJ7e0hZKg+4PVkzyqFM5G7AfI65cj2FGM2RtVyi425jye2h7HK9BG+7Dc
        k25egpUEaorjGV69IL0vEOoVcf+j5FufnKi7J+0byextGew23S9LllviW5VPFQ==
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
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 3/9] local_lock: Provide INIT_LOCAL_LOCK().
Date:   Mon, 24 Oct 2022 12:44:19 +0200
Message-Id: <20221024104425.16423-4-wagi@monom.org>
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


The original code was using INIT_LOCAL_LOCK() and I tried to sneak
around it and forgot that this code also needs to compile on !RT
platforms.

Provide INIT_LOCAL_LOCK() to initialize properly on RT and do nothing on
!RT. Let random.c use which is the only user so far and oes not compile
on !RT otherwise.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/all/YzcEIU17EIZ7ZIF5@linutronix.de/
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 drivers/char/random.c     | 4 ++--
 include/linux/locallock.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0fd0462054bd..a7b345c47d1f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -235,7 +235,7 @@ struct crng {
 
 static DEFINE_PER_CPU(struct crng, crngs) = {
 	.generation = ULONG_MAX,
-	.lock.lock = __SPIN_LOCK_UNLOCKED(crngs.lock.lock),
+	.lock =  INIT_LOCAL_LOCK(crngs.lock),
 };
 
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
@@ -514,7 +514,7 @@ struct batch_ ##type {								\
 };										\
 										\
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
-	.lock.lock = __SPIN_LOCK_UNLOCKED(batched_entropy_ ##type.lock.lock),	\
+	.lock = INIT_LOCAL_LOCK(batched_entropy_ ##type.lock),			\
 	.position = UINT_MAX							\
 };										\
 										\
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 81c89d87723b..7964ee6b998c 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -23,6 +23,8 @@ struct local_irq_lock {
 	unsigned long		flags;
 };
 
+#define INIT_LOCAL_LOCK(lvar)			{ .lock = __SPIN_LOCK_UNLOCKED((lvar).lock.lock) }
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)					\
 	DEFINE_PER_CPU(struct local_irq_lock, lvar) = {			\
 		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
@@ -241,6 +243,9 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #else /* PREEMPT_RT_BASE */
 
+struct local_irq_lock { };
+#define INIT_LOCAL_LOCK(lvar)			{ }
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)		__typeof__(const int) lvar
 #define DECLARE_LOCAL_IRQ_LOCK(lvar)		extern __typeof__(const int) lvar
 
-- 
2.38.0

