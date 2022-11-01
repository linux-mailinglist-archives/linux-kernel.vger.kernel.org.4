Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBE614A91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKAMZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAMZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DE17A90
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B9C60F7B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DB5C433C1;
        Tue,  1 Nov 2022 12:25:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F145xF3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667305540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtfQi2pNPpPZAq4SXqmk5xdo+UCS3l6ora/p900eBzs=;
        b=F145xF3/7SR6VO8DVAkXaj/S/hnwyBS8+kUCvMKlb9HvLm4LrEtK8Irs3tnBzfS8WY4n1C
        dxYKdpF55h22TK2Sjl/Jp6vi0D6ziMHg7pcvTIx87ExdNZNMtrcfokJoewfDAPLArGMO1s
        nyNMnev/vi5W06XLiILhg7gZf7gZ9FQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b5b19abf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 12:25:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v5] random: remove early archrandom abstraction
Date:   Tue,  1 Nov 2022 13:25:28 +0100
Message-Id: <20221101122527.323843-1-Jason@zx2c4.com>
In-Reply-To: <20221101115616.232884-1-Jason@zx2c4.com>
References: <20221101115616.232884-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_get_random*_early() abstraction is not completely useful and
adds complexity, because it's not a given that there will be no calls to
arch_get_random*() between random_init_early(), which uses
arch_get_random*_early(), and init_cpu_features(). During that gap,
crng_reseed() might be called, which uses arch_get_random*(), since it's
mostly not init code.

Instead we can test whether we're in the early phase in
arch_get_random*() itself, and in doing so avoid all ambiguity about
where we are. Fortunately, the only architecture that currently
implements arch_get_random*_early() also has an alternatives-based cpu
feature system, one flag of which determines whether the other flags
have been initialized. This makes it possible to do the early check with
zero cost once the system is initialized.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v4->v5:
- Use this_cpu_has_cap() to make codegen for the cold path smaller.
- Add manual unlikely() to make the coldpath that's patched out even
  further away.

Changes v3->v4:
- Use !preemptible() rather than early_boot_irqs_disabled.

 arch/arm64/include/asm/archrandom.h | 48 ++++++-----------------------
 drivers/char/random.c               |  4 +--
 include/linux/random.h              | 20 ------------
 3 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index 109e2a4454be..2f5f3da34782 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -5,6 +5,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/irqflags.h>
 #include <asm/cpufeature.h>
 
 #define ARM_SMCCC_TRNG_MIN_VERSION	0x10000UL
@@ -58,6 +59,13 @@ static inline bool __arm64_rndrrs(unsigned long *v)
 	return ok;
 }
 
+static __always_inline bool __cpu_has_rng(void)
+{
+	if (unlikely(!system_capabilities_finalized() && !preemptible()))
+		return this_cpu_has_cap(ARM64_HAS_RNG);
+	return cpus_have_const_cap(ARM64_HAS_RNG);
+}
+
 static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
 {
 	/*
@@ -66,7 +74,7 @@ static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t
 	 * cpufeature code and with potential scheduling between CPUs
 	 * with and without the feature.
 	 */
-	if (max_longs && cpus_have_const_cap(ARM64_HAS_RNG) && __arm64_rndr(v))
+	if (max_longs && __cpu_has_rng() && __arm64_rndr(v))
 		return 1;
 	return 0;
 }
@@ -108,7 +116,7 @@ static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, s
 	 * reseeded after each invocation. This is not a 100% fit but good
 	 * enough to implement this API if no other entropy source exists.
 	 */
-	if (cpus_have_const_cap(ARM64_HAS_RNG) && __arm64_rndrrs(v))
+	if (__cpu_has_rng() && __arm64_rndrrs(v))
 		return 1;
 
 	return 0;
@@ -121,40 +129,4 @@ static inline bool __init __early_cpu_has_rndr(void)
 	return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
 }
 
-static inline size_t __init __must_check
-arch_get_random_seed_longs_early(unsigned long *v, size_t max_longs)
-{
-	WARN_ON(system_state != SYSTEM_BOOTING);
-
-	if (!max_longs)
-		return 0;
-
-	if (smccc_trng_available) {
-		struct arm_smccc_res res;
-
-		max_longs = min_t(size_t, 3, max_longs);
-		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, max_longs * 64, &res);
-		if ((int)res.a0 >= 0) {
-			switch (max_longs) {
-			case 3:
-				*v++ = res.a1;
-				fallthrough;
-			case 2:
-				*v++ = res.a2;
-				fallthrough;
-			case 1:
-				*v++ = res.a3;
-				break;
-			}
-			return max_longs;
-		}
-	}
-
-	if (__early_cpu_has_rndr() && __arm64_rndr(v))
-		return 1;
-
-	return 0;
-}
-#define arch_get_random_seed_longs_early arch_get_random_seed_longs_early
-
 #endif /* _ASM_ARCHRANDOM_H */
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9d016ac181fa..5da120f10a67 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -813,13 +813,13 @@ void __init random_init_early(const char *command_line)
 #endif
 
 	for (i = 0, arch_bits = sizeof(entropy) * 8; i < ARRAY_SIZE(entropy);) {
-		longs = arch_get_random_seed_longs_early(entropy, ARRAY_SIZE(entropy) - i);
+		longs = arch_get_random_seed_longs(entropy, ARRAY_SIZE(entropy) - i);
 		if (longs) {
 			_mix_pool_bytes(entropy, sizeof(*entropy) * longs);
 			i += longs;
 			continue;
 		}
-		longs = arch_get_random_longs_early(entropy, ARRAY_SIZE(entropy) - i);
+		longs = arch_get_random_longs(entropy, ARRAY_SIZE(entropy) - i);
 		if (longs) {
 			_mix_pool_bytes(entropy, sizeof(*entropy) * longs);
 			i += longs;
diff --git a/include/linux/random.h b/include/linux/random.h
index 182780cafd45..2bdd3add3400 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -153,26 +153,6 @@ declare_get_random_var_wait(long, unsigned long)
 
 #include <asm/archrandom.h>
 
-/*
- * Called from the boot CPU during startup; not valid to call once
- * secondary CPUs are up and preemption is possible.
- */
-#ifndef arch_get_random_seed_longs_early
-static inline size_t __init arch_get_random_seed_longs_early(unsigned long *v, size_t max_longs)
-{
-	WARN_ON(system_state != SYSTEM_BOOTING);
-	return arch_get_random_seed_longs(v, max_longs);
-}
-#endif
-
-#ifndef arch_get_random_longs_early
-static inline bool __init arch_get_random_longs_early(unsigned long *v, size_t max_longs)
-{
-	WARN_ON(system_state != SYSTEM_BOOTING);
-	return arch_get_random_longs(v, max_longs);
-}
-#endif
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.38.1

