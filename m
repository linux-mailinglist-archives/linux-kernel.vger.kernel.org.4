Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE75EC01A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiI0Kt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiI0KtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492ED115A67
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:49:23 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664275761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjHYpXrjzW1rmVIilucq4/ssa0Amaz+1GwZoY2Y89Iw=;
        b=zFTpq95r4D5NqlkmuN9pEhscWPE7cPO2fN5uED3CsSQbzHXGGmqMcOhy/J3PXruBdiULco
        oSktp/Mh8ZspyuF6Sri7gdxareiwoFR64PsBO5/vKh42DOVNCgx2D4y7BpogBlShXGBVcF
        2NQ/gw4CWGF8ojCSjcKW7wCxTpiy4sM+wXCWtiotwkKWEkm5HEoNmRFItcZSvwpKEPP/ps
        4vnoaxltzTxIY2g4Ga3WF1aDv6LHzG9BcUFlFdwLaDjGnAsbabyeCtZFTunC6ZGFRYp+/v
        P32+lNzyuZbql5az2tViepYqZJjWDfT7h5fupUNmmxxesrewrXtANoL9cpYT1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664275761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjHYpXrjzW1rmVIilucq4/ssa0Amaz+1GwZoY2Y89Iw=;
        b=pPVlaCGpLDTtzDN3jwnlsTTQGdk+Xt9bp0TLbyOwS/0tiKM7QWz6zPFoBeIzMoFuBQNswb
        8Rm3QAAXtuZ64rDg==
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
Subject: [PATCH v4 1/2] lib/vsprintf: Remove static_branch_likely() from __ptr_to_hashval().
Date:   Tue, 27 Sep 2022 12:49:11 +0200
Message-Id: <20220927104912.622645-2-bigeasy@linutronix.de>
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

Using static_branch_likely() to signal that ptr_key has been filled is a
bit much given that it is not a fast path.

Replace static_branch_likely() with bool for condition and a memory
barrier for ptr_key.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/vsprintf.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c09..bce63cbf23779 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -750,12 +750,7 @@ static int __init debug_boot_weak_hash_enable(char *st=
r)
 }
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
=20
-static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
-
-static void enable_ptr_key_workfn(struct work_struct *work)
-{
-	static_branch_enable(&filled_random_ptr_key);
-}
+static bool filled_random_ptr_key __read_mostly;
=20
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval=
_out)
@@ -763,24 +758,26 @@ static inline int __ptr_to_hashval(const void *ptr, u=
nsigned long *hashval_out)
 	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
=20
-	if (!static_branch_likely(&filled_random_ptr_key)) {
+	if (!READ_ONCE(filled_random_ptr_key)) {
 		static bool filled =3D false;
 		static DEFINE_SPINLOCK(filling);
-		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
 		unsigned long flags;
=20
-		if (!system_unbound_wq || !rng_is_initialized() ||
+		if (!rng_is_initialized() ||
 		    !spin_trylock_irqsave(&filling, flags))
 			return -EAGAIN;
=20
 		if (!filled) {
 			get_random_bytes(&ptr_key, sizeof(ptr_key));
-			queue_work(system_unbound_wq, &enable_ptr_key_work);
+			/* Pairs with smp_rmb() before reading ptr_key. */
+			smp_wmb();
+			WRITE_ONCE(filled_random_ptr_key, true);
 			filled =3D true;
 		}
 		spin_unlock_irqrestore(&filling, flags);
 	}
-
+	/* Pairs with smp_wmb() after writing ptr_key. */
+	smp_rmb();
=20
 #ifdef CONFIG_64BIT
 	hashval =3D (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
--=20
2.37.2

