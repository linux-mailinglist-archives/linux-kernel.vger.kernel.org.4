Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A339609F70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJXKzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJXKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:55:05 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6C1B79B;
        Mon, 24 Oct 2022 03:54:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F6E061D77;
        Mon, 24 Oct 2022 12:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608269; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=3wa0f+zrOtFlna7a224EJfMKkCUy+rnhosyUNwJXajU=;
        b=t6jrHgifm7euHqYxcpmUyTMRqj8Wj+Y7OApKKa7oEPARDPsxnQos35MzpkLtHAUiUuPWOf
        ggwoRrnup5iR1V8pw4reDw7zFAM7qhucPYJLW97ByT8TeqfDuvPhO5kP8pzKHbnmpveiZa
        0AmqKeh1K/Wm7DwA0d4PPF9LbjNBmlKiVYXCgDFm8hvYPnOaKq/htN1Nj9fzgnE7F+61ZH
        5UObSt24gzejAgZgrcUMiq7Bpj+Tl0y0L/Nwtkg47AbuZuHMfn5XHDqfUmMPmU7ihaq8ZU
        OvXC1RgQbfyB7Wh9DLoSiKRTywBapiSZ/fmo2M3DM1KEOFo/JN8D4VglxL9Vfg==
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
Cc:     Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RT 2/9] random: Bring back the local_locks
Date:   Mon, 24 Oct 2022 12:44:18 +0200
Message-Id: <20221024104425.16423-3-wagi@monom.org>
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


As part of the backports the random code lost its local_lock_t type and
the whole operation became a local_irq_{disable|enable}() simply because
the older kernel did not provide those primitives.

RT as of v4.9 has a slightly different variant of local_locks.
Replace the local_irq_*() operations with matching local_lock_irq*()
operations which were there as part of commit
   77760fd7f7ae3 ("random: remove batched entropy locking")

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/all/20220819092446.980320-2-bigeasy@linutronix.de/
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/char/random.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2be38780a7f7..0fd0462054bd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,6 +53,7 @@
 #include <linux/uaccess.h>
 #include <linux/siphash.h>
 #include <linux/uio.h>
+#include <linux/locallock.h>
 #include <crypto/chacha20.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -229,10 +230,12 @@ static struct {
 struct crng {
 	u8 key[CHACHA20_KEY_SIZE];
 	unsigned long generation;
+	struct local_irq_lock lock;
 };
 
 static DEFINE_PER_CPU(struct crng, crngs) = {
-	.generation = ULONG_MAX
+	.generation = ULONG_MAX,
+	.lock.lock = __SPIN_LOCK_UNLOCKED(crngs.lock.lock),
 };
 
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
@@ -362,7 +365,7 @@ static void crng_make_state(u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)],
 	if (unlikely(crng_has_old_seed()))
 		crng_reseed();
 
-	local_irq_save(flags);
+	local_lock_irqsave(crngs.lock, flags);
 	crng = raw_cpu_ptr(&crngs);
 
 	/*
@@ -387,7 +390,7 @@ static void crng_make_state(u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)],
 	 * should wind up here immediately.
 	 */
 	crng_fast_key_erasure(crng->key, chacha_state, random_data, random_data_len);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(crngs.lock, flags);
 }
 
 static void _get_random_bytes(void *buf, size_t len)
@@ -505,11 +508,13 @@ struct batch_ ##type {								\
 	 * formula of (integer_blocks + 0.5) * CHACHA20_BLOCK_SIZE.		\
 	 */									\
 	type entropy[CHACHA20_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
+	struct local_irq_lock lock;						\
 	unsigned long generation;						\
 	unsigned int position;							\
 };										\
 										\
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
+	.lock.lock = __SPIN_LOCK_UNLOCKED(batched_entropy_ ##type.lock.lock),	\
 	.position = UINT_MAX							\
 };										\
 										\
@@ -527,7 +532,7 @@ type get_random_ ##type(void)							\
 		return ret;							\
 	}									\
 										\
-	local_irq_save(flags);		\
+	local_lock_irqsave(batched_entropy_ ##type.lock, flags);		\
 	batch = raw_cpu_ptr(&batched_entropy_##type);				\
 										\
 	next_gen = READ_ONCE(base_crng.generation);				\
@@ -541,7 +546,7 @@ type get_random_ ##type(void)							\
 	ret = batch->entropy[batch->position];					\
 	batch->entropy[batch->position] = 0;					\
 	++batch->position;							\
-	local_irq_restore(flags);		\
+	local_unlock_irqrestore(batched_entropy_ ##type.lock, flags);		\
 	return ret;								\
 }										\
 EXPORT_SYMBOL(get_random_ ##type);
-- 
2.38.0

