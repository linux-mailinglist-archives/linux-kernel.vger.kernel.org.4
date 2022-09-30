Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5B5F0E55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiI3PBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiI3PAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:00:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC2C1EB7;
        Fri, 30 Sep 2022 07:58:45 -0700 (PDT)
Date:   Fri, 30 Sep 2022 16:58:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664549923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+spfYMCZZ1hiMsyKYMRyJJWw3SbhydAe67QIBjklrI=;
        b=UwQW8Ez+JlwCgQWm8ahL5evfpnXszfMqY8BYqTeELuVOPeRXxLQ61z3gEazZjg8WcaMDht
        /SAoOhYq+MwW+3WRnMSPXa79scUTtgjDodhoEuIzyGMkBxZPdzh3E4dXKO7HmJ31FVoXY6
        Sc13a/wxo1C3vM9AMcKe9vyH0W4wT0hO9k817z1XqQ+PR7H3WD9gwpF9F4XJqUOkJAGbFO
        +H30nRvYNGRTenFlsd3yHDOFvkZPi/zpEHQWMLKs2lB9wnkeFCtkMVebNuHJi9z1sdqHFp
        bmq6nOEMtuWQ6RR6jnhDq7L926WEwhAJX1JBIrT3z1TlBtoy3YlS07Qh0lcGsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664549923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+spfYMCZZ1hiMsyKYMRyJJWw3SbhydAe67QIBjklrI=;
        b=QqNy0wkxgzQjkkMp5aI8qz6QB0OO1+QZGMscurUMslt9nboZdp/vDsRKf+3sASYWEP6IWt
        W72sjcPR6dRdGqBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Gross <markgross@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>
Subject: Re: [ANNOUNCE] 4.9.327-rt197
Message-ID: <YzcEIU17EIZ7ZIF5@linutronix.de>
References: <165222469651.210737.17409564443317121708@T470>
 <Yy4ShVWORi6XNhCv@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy4ShVWORi6XNhCv@T470>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-23 13:09:41 [-0700], Mark Gross wrote:
> > As this was a tricky one I request people to give a good look over.

You did good. I not so much. If you could please add the following patch
on top, then it will compile also on !RT.

Thank you for work.

------->8----------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 30 Sep 2022 16:55:34 +0200
Subject: [PATCH] local_lock: Provide INIT_LOCAL_LOCK().

The original code was using INIT_LOCAL_LOCK() and I tried to sneak
around it and forgot that this code also needs to compile on !RT
platforms.

Provide INIT_LOCAL_LOCK() to initialize properly on RT and do nothing on
!RT. Let random.c use which is the only user so far and oes not compile
on !RT otherwise.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c     | 4 ++--
 include/linux/locallock.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index daea466812fed..86c475f70343d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -236,7 +236,7 @@ struct crng {
 
 static DEFINE_PER_CPU(struct crng, crngs) = {
 	.generation = ULONG_MAX,
-	.lock.lock = __SPIN_LOCK_UNLOCKED(crngs.lock.lock),
+	.lock = INIT_LOCAL_LOCK(crngs.lock),
 };
 
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
@@ -515,7 +515,7 @@ struct batch_ ##type {								\
 };										\
 										\
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
-	.lock.lock = __SPIN_LOCK_UNLOCKED(batched_entropy_ ##type.lock.lock),	\
+	.lock = INIT_LOCAL_LOCK(batched_entropy_ ##type.lock),			\
 	.position = UINT_MAX							\
 };										\
 										\
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 0c3ff5b23f6a1..70af9a177197e 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -22,6 +22,8 @@ struct local_irq_lock {
 	unsigned long		flags;
 };
 
+#define INIT_LOCAL_LOCK(lvar)			{ .lock = __SPIN_LOCK_UNLOCKED((lvar).lock.lock) }
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)					\
 	DEFINE_PER_CPU(struct local_irq_lock, lvar) = {			\
 		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
@@ -256,6 +258,9 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #else /* PREEMPT_RT_BASE */
 
+struct local_irq_lock { };
+#define INIT_LOCAL_LOCK(lvar)			{ }
+
 #define DEFINE_LOCAL_IRQ_LOCK(lvar)		__typeof__(const int) lvar
 #define DECLARE_LOCAL_IRQ_LOCK(lvar)		extern __typeof__(const int) lvar
 
-- 
2.37.2


Sebastian
