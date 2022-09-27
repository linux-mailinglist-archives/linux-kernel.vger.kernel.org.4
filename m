Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46A5EC01C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiI0Kte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiI0KtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4920110AB36
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:49:23 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664275761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9SpVBT+ySsAWzeFgnz/SGjnqeQN8tYraD5LwJEmXBQ=;
        b=REqW9t/hsttkyPCWE93aLKiLfaaEU2n/FliWuUiXe88zwNNro6HXswbJuL5yIqk4Ywnk2/
        KfJuMcR6PSMdYohU88OSK1wIJVoFZRQK6IDUVY/GqFfnwnYVV6aklCtHAtjUQQGpIPuMty
        D8sSy4zTfiu5WnfQu6rwN13cDKh49RBEEBpzmrBLXy2SeR4nQYTIFxHzothJoA13RntKYG
        Qpf/rlRcDMZFTzpQeyQok7B9c8aYT5J//F0jkXNAg8QXL/QI/4TWtovctR5BIuL/rbgrUq
        UOfo+udumfpRVPYWD7m0PQvku1GKI+vKnupwOmS24TUXnojvIhqpt01iVFX8mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664275761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9SpVBT+ySsAWzeFgnz/SGjnqeQN8tYraD5LwJEmXBQ=;
        b=aTqzidwARTeDTTG+/DGSJEkOzWBOFIwm78p1ehIVXT5/rmreI4ZGsVVYsXOKLoO9AGZZ7M
        4SGLNENEeE80IcCw==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash once the random core is ready.
Date:   Tue, 27 Sep 2022 12:49:12 +0200
Message-Id: <20220927104912.622645-3-bigeasy@linutronix.de>
In-Reply-To: <20220927104912.622645-1-bigeasy@linutronix.de>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk code invokes vnsprintf in order to compute the complete
string before adding it into its buffer. This happens in an IRQ-off
region which leads to a warning on PREEMPT_RT in the random code if the
format strings contains a %p for pointer printing. This happens because
the random core acquires locks which become sleeping locks on PREEMPT_RT
which must not be acquired with disabled interrupts and or preemption
disabled.
By default the pointers are hashed which requires a random value on the
first invocation (either by printk or another user which comes first.

One could argue that there is no need for printk to disable interrupts
during the vsprintf() invocation which would fix the just mentioned
problem. However printk itself can be invoked in a context with
disabled interrupts which would lead to the very same problem.

Move the initialization of ptr_key into a worker and schedule it from
subsys_initcall(). This happens early but after the workqueue subsystem
is ready. Use get_random_bytes() to retrieve the random value if the RNG
core is ready, otherwise schedule a worker in two seconds and try again.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/vsprintf.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index bce63cbf23779..44b39ba56b796 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -751,31 +751,39 @@ static int __init debug_boot_weak_hash_enable(char *s=
tr)
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
=20
 static bool filled_random_ptr_key __read_mostly;
+static siphash_key_t ptr_key __read_mostly;
+static void fill_ptr_key_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
+
+static void fill_ptr_key_workfn(struct work_struct *work)
+{
+	if (!rng_is_initialized()) {
+		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
+		return;
+	}
+
+	get_random_bytes(&ptr_key, sizeof(ptr_key));
+
+	/* Pairs with smp_rmb() before reading ptr_key. */
+	smp_wmb();
+	WRITE_ONCE(filled_random_ptr_key, true);
+}
+
+static int __init vsprintf_init_hashval(void)
+{
+	fill_ptr_key_workfn(NULL);
+	return 0;
+}
+subsys_initcall(vsprintf_init_hashval)
=20
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval=
_out)
 {
-	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
=20
-	if (!READ_ONCE(filled_random_ptr_key)) {
-		static bool filled =3D false;
-		static DEFINE_SPINLOCK(filling);
-		unsigned long flags;
+	if (!READ_ONCE(filled_random_ptr_key))
+		return -EBUSY;
=20
-		if (!rng_is_initialized() ||
-		    !spin_trylock_irqsave(&filling, flags))
-			return -EAGAIN;
-
-		if (!filled) {
-			get_random_bytes(&ptr_key, sizeof(ptr_key));
-			/* Pairs with smp_rmb() before reading ptr_key. */
-			smp_wmb();
-			WRITE_ONCE(filled_random_ptr_key, true);
-			filled =3D true;
-		}
-		spin_unlock_irqrestore(&filling, flags);
-	}
 	/* Pairs with smp_wmb() after writing ptr_key. */
 	smp_rmb();
=20
--=20
2.37.2

