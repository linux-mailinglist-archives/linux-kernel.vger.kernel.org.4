Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30D7609F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJXKzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJXKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:58 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8B613F34;
        Mon, 24 Oct 2022 03:54:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D116061D78;
        Mon, 24 Oct 2022 12:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608269; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=OO8ivmGitwcKDyAkmI+pQE3XfdhYBWotXa3wVqMIHE4=;
        b=OVscYbQBs3+pgCis9WTsKntYC4FUwkJhmodaQtdp/Ujq7AL2cze7YucRBBlPBRyWtk39FW
        skrs6X8tG7lzd6HPwuRtF/V0O5BCnvhjxWgYyjxaFz+TmiysVlBpxA+bqG7qGsR0m4jjJT
        5CYIS8ae1T1it1DBGHa2736TDV94gwjMjETQqpabaH8MtlliOGOtJxkiW6dGqbvFtGeqHI
        L7qpzbzQ1qgw5ME9vi7reGiE4u/Q76PdL6TbVJFDdLg/Xr0IfG2MhfsfLdk4VSdYVoTBgr
        CgJ8bpBvW8TsRRj3asXaJpZflnO7hByW+Axx8VnTGUwNlTUMhAHtgcgfL/tNPg==
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
Subject: [PATCH RT 1/9] Revert "random: Use local locks for crng context access"
Date:   Mon, 24 Oct 2022 12:44:17 +0200
Message-Id: <20221024104425.16423-2-wagi@monom.org>
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

v4.19.255-rt114-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This reverts commit af5469c6f4f85f60f3ecc9bd541adfb6bdbeaff2.
---
 drivers/char/random.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c06705a32246..2be38780a7f7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,7 +53,6 @@
 #include <linux/uaccess.h>
 #include <linux/siphash.h>
 #include <linux/uio.h>
-#include <linux/locallock.h>
 #include <crypto/chacha20.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -235,7 +234,6 @@ struct crng {
 static DEFINE_PER_CPU(struct crng, crngs) = {
 	.generation = ULONG_MAX
 };
-DEFINE_LOCAL_IRQ_LOCK(crngs_lock);
 
 /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
 static void extract_entropy(void *buf, size_t len);
@@ -364,7 +362,7 @@ static void crng_make_state(u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)],
 	if (unlikely(crng_has_old_seed()))
 		crng_reseed();
 
-	local_lock_irqsave(crngs_lock, flags);
+	local_irq_save(flags);
 	crng = raw_cpu_ptr(&crngs);
 
 	/*
@@ -389,7 +387,7 @@ static void crng_make_state(u32 chacha_state[CHACHA20_BLOCK_SIZE / sizeof(u32)],
 	 * should wind up here immediately.
 	 */
 	crng_fast_key_erasure(crng->key, chacha_state, random_data, random_data_len);
-	local_unlock_irqrestore(crngs_lock, flags);
+	local_irq_restore(flags);
 }
 
 static void _get_random_bytes(void *buf, size_t len)
@@ -514,7 +512,6 @@ struct batch_ ##type {								\
 static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
 	.position = UINT_MAX							\
 };										\
-static DEFINE_LOCAL_IRQ_LOCK(batched_entropy_lock_ ##type);			\
 										\
 type get_random_ ##type(void)							\
 {										\
@@ -530,7 +527,7 @@ type get_random_ ##type(void)							\
 		return ret;							\
 	}									\
 										\
-	local_lock_irqsave(batched_entropy_lock_ ##type, flags);		\
+	local_irq_save(flags);		\
 	batch = raw_cpu_ptr(&batched_entropy_##type);				\
 										\
 	next_gen = READ_ONCE(base_crng.generation);				\
@@ -544,7 +541,7 @@ type get_random_ ##type(void)							\
 	ret = batch->entropy[batch->position];					\
 	batch->entropy[batch->position] = 0;					\
 	++batch->position;							\
-	local_unlock_irqrestore(batched_entropy_lock_ ##type, flags);		\
+	local_irq_restore(flags);		\
 	return ret;								\
 }										\
 EXPORT_SYMBOL(get_random_ ##type);
-- 
2.38.0

