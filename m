Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880DE64FDBD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiLRFQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiLRFQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:16:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF772DF9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so9950217pjr.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJmzgqWbYjXHayt1fVUjbpZdSQg9mlJmebSHfVtOk/w=;
        b=slrgCkBu4hD5xxrdTty9DB5h0GOnqA6WFBWTs+nuJEmU57fuUCTwWCunetECMIaccs
         Bvq1JsRDiqX/GAki+Hyvv4/xotRwAKB7Ldb3nL9TT5S9gRI620O+s7OH1gnJUGr3z5dG
         1jGY8MpaLCm/x6f52w+ze4oJFZVT6dfqYbTWnO05Li6GrtBVrCCow+A2tXae5yhCxMl1
         ybOwwhNTrsq1szvHo7kagpV+MtIvULI8qMf+wLU1zBLe6FlJb/HfxU1e01jyr5AMiBEs
         cfz04wmEfOjiUXByOIRHAC26OaZJlQzfrZfLT+ZmrA428iX96jPS1h8mMX15uALgbUa2
         xV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJmzgqWbYjXHayt1fVUjbpZdSQg9mlJmebSHfVtOk/w=;
        b=dnDy/lCexJYA01lc86mqYHbUJ9+ktEAFVFi0oQ/2dnckaVgNUkZJIULcVa5rqbUF2J
         3em0EF4Y+ZsSaPWEhSkuiUPohT2zpKgglDjzFxfESVdKQARYyd6b5yd+usrgHTKnKBAk
         nAOrOuCDGycLk5vfivJ5Ww3eXtMbGdB/jPGlasOJEJHXyFPhpJn9c3JdO8t3oefKWX06
         u6J+sewFWUyr2C2gfnzFUpGwtTES81wpXrZCNMXWhxAncVvCKsfMjlApCTzVbE1MLINu
         3rpfH0IH5DEp8paZej88nB3CJ853pCRBcHuzU+p0JL6xvXpxBHxgBHjVMsfQoEm7uEAJ
         D+Bw==
X-Gm-Message-State: ANoB5pluQr/bmiPnSmQBNFrPQ0cpJYLf5MFgFImzQlFkDI5j1m74n9n8
        EibHOvUGBUyoI4Mr/Y21wkpiMQ==
X-Google-Smtp-Source: AA0mqf4E49x4lUAbvX6a61HO3fXfHcqIeoGOvrf+PT79bhPCUz7EMHic4yOOVOM2Of91ArtZ1uqEPA==
X-Received: by 2002:a17:90a:ac07:b0:219:aa58:77ba with SMTP id o7-20020a17090aac0700b00219aa5877bamr39470299pjq.25.1671340551960;
        Sat, 17 Dec 2022 21:15:51 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a6ac100b002139459e121sm7002417pjm.27.2022.12.17.21.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:15:51 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 7/7] KVM: arm64: Normalize cache configuration
Date:   Sun, 18 Dec 2022 14:14:12 +0900
Message-Id: <20221218051412.384657-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221218051412.384657-1-akihiko.odaki@daynix.com>
References: <20221218051412.384657-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, the cache configuration of the physical CPU was
exposed to vcpus. This is problematic because the cache configuration a
vcpu sees varies when it migrates between vcpus with different cache
configurations.

Fabricate cache configuration from the sanitized value, which holds the
CTR_EL0 value the userspace sees regardless of which physical CPU it
resides on.

CLIDR_EL1 is now writable from the userspace so that the VMM can
restore the values saved with the old kernel.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/cache.h    |   3 +
 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/kvm/sys_regs.c         | 183 +++++++++++++++---------------
 3 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index ab7133654a72..a51e6e8f3171 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -22,6 +22,9 @@
 #define CLIDR_CTYPE(clidr, level)	\
 	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
 
+/* Ttypen, bits [2(n - 1) + 34 : 2(n - 1) + 33], for n = 1 to 7 */
+#define CLIDR_TTYPE_SHIFT(level)	(2 * ((level) - 1) + CLIDR_EL1_Ttypen_SHIFT)
+
 /*
  * Memory returned by kmalloc() may be used for DMA, so we must make
  * sure that all such allocations are cache aligned. Otherwise,
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cfc6930efe1b..27abf81c6910 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -178,6 +178,7 @@ struct kvm_vcpu_fault_info {
 enum vcpu_sysreg {
 	__INVALID_SYSREG__,   /* 0 is reserved as an invalid value */
 	MPIDR_EL1,	/* MultiProcessor Affinity Register */
+	CLIDR_EL1,	/* Cache Level ID Register */
 	CSSELR_EL1,	/* Cache Size Selection Register */
 	SCTLR_EL1,	/* System Control Register */
 	ACTLR_EL1,	/* Auxiliary Control Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a7199f34e321..9fd0b28e29bd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -11,6 +11,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bsearch.h>
+#include <linux/cacheinfo.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/printk.h>
@@ -81,9 +82,6 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 	 __vcpu_sys_reg(vcpu, reg) = val;
 }
 
-/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
-static u32 cache_levels;
-
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
@@ -101,47 +99,36 @@ static u8 get_min_cache_line_size(u32 csselr)
 /* Which cache CCSIDR represents depends on CSSELR value. */
 static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 {
-	u32 ccsidr_index = csselr & (CSSELR_EL1_Level | CSSELR_EL1_InD);
-	u32 ccsidr;
-
-	if (vcpu->arch.ccsidr && is_valid_cache(ccsidr_index) &&
-	    !(kvm_has_mte(vcpu->kvm) && (csselr & CSSELR_EL1_TnD)))
-		return vcpu->arch.ccsidr[ccsidr_index];
-
-	/* Make sure noone else changes CSSELR during this! */
-	local_irq_disable();
-	write_sysreg(csselr, csselr_el1);
-	isb();
-	ccsidr = read_sysreg(ccsidr_el1);
-	local_irq_enable();
-
-	return ccsidr;
-}
-
-static bool is_valid_cache(u32 val)
-{
-	u32 level, ctype;
+	u64 ctr_el0;
+	int field;
 
-	if (val >= CSSELR_MAX)
-		return false;
+	if (vcpu->arch.ccsidr)
+		return vcpu->arch.ccsidr[csselr];
 
-	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
-	level = (val >> 1);
-	ctype = (cache_levels >> (level * 3)) & 7;
+	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	field = csselr & CSSELR_EL1_InD ? CTR_EL0_IminLine_SHIFT : CTR_EL0_DminLine_SHIFT;
 
-	switch (ctype) {
-	case 0: /* No cache */
-		return false;
-	case 1: /* Instruction cache only */
-		return (val & 1);
-	case 2: /* Data cache only */
-	case 4: /* Unified cache */
-		return !(val & 1);
-	case 3: /* Separate instruction and data caches */
-		return true;
-	default: /* Reserved: we can't know instruction or data. */
-		return false;
-	}
+	/*
+	 * Fabricate a CCSIDR value as the overriding value does not exist.
+	 * The real CCSIDR value will not be used as it can vary by the
+	 * physical CPU which the vcpu currently resides in.
+	 *
+	 * The line size is determined with arm64_ftr_reg_ctrel0.sys_val, which
+	 * should be valid for all CPUs even if they have different cache
+	 * configuration.
+	 *
+	 * The associativity bits are cleared, meaning the geometry of all data
+	 * and unified caches (which are guaranteed to be PIPT and thus
+	 * non-aliasing) are 1 set and 1 way.
+	 * Guests should not be doing cache operations by set/way at all, and
+	 * for this reason, we trap them and attempt to infer the intent, so
+	 * that we can flush the entire guest's address space at the appropriate
+	 * time. The exposed geometry minimizes the number of the traps.
+	 * [If guests should attempt to infer aliasing properties from the
+	 * geometry (which is not permitted by the architecture), they would
+	 * only do so for virtually indexed caches.]
+	 */
+	return get_min_cache_line_size(csselr) << CCSIDR_EL1_LineSize_SHIFT;
 }
 
 static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
@@ -162,8 +149,7 @@ static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
 			return -ENOMEM;
 
 		for (i = 0; i < CSSELR_MAX; i++)
-			if (is_valid_cache(i))
-				ccsidr[i] = get_ccsidr(vcpu, i);
+			ccsidr[i] = get_ccsidr(vcpu, i);
 
 		vcpu->arch.ccsidr = ccsidr;
 	}
@@ -1352,10 +1338,64 @@ static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
-	p->regval = read_sysreg(clidr_el1);
+	p->regval = __vcpu_sys_reg(vcpu, r->reg);
 	return true;
 }
 
+/*
+ * Fabricate a CLIDR_EL1 value instead of using the real value, which can vary
+ * by the physical CPU which the vcpu currently resides in.
+ */
+static void reset_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 clidr;
+	u8 loc;
+
+	if ((ctr_el0 & CTR_EL0_IDC) || cpus_have_const_cap(ARM64_HAS_STAGE2_FWB)) {
+		/*
+		 * Data cache clean to the PoU is not required so LoUU and LoUIS
+		 * will not be set and a unified cache, which will be marked as
+		 * LoC, will be added.
+		 *
+		 * If not DIC, let the unified cache L2 so that an instruction
+		 * cache can be added as L1 later.
+		 */
+		loc = (ctr_el0 & CTR_EL0_DIC) ? 1 : 2;
+		clidr = CACHE_TYPE_UNIFIED << CLIDR_CTYPE_SHIFT(loc);
+	} else {
+		/*
+		 * Data cache clean to the PoU is required so let L1 have a data
+		 * cache and mark it as LoUU and LoUIS. As L1 has a data cache,
+		 * it can be marked as LoC too.
+		 */
+		loc = 1;
+		clidr = 1 << CLIDR_LOUU_SHIFT;
+		clidr |= 1 << CLIDR_LOUIS_SHIFT;
+		clidr |= CACHE_TYPE_DATA << CLIDR_CTYPE_SHIFT(1);
+	}
+
+	/*
+	 * Instruction cache invalidation to the PoU is required so let L1 have
+	 * an instruction cache. If L1 already has a data cache, it will be
+	 * CACHE_TYPE_SEPARATE.
+	 */
+	if (!(ctr_el0 & CTR_EL0_DIC))
+		clidr |= CACHE_TYPE_INST << CLIDR_CTYPE_SHIFT(1);
+
+	clidr |= loc << CLIDR_LOC_SHIFT;
+
+	/*
+	 * Add tag cache unified to data cache. Allocation tags and data are
+	 * unified in a cache line so that it looks valid even if there is only
+	 * one cache line.
+	 */
+	if (kvm_has_mte(vcpu->kvm))
+		clidr |= 2 << CLIDR_TTYPE_SHIFT(loc);
+
+	__vcpu_sys_reg(vcpu, r->reg) = clidr;
+}
+
 static bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
@@ -1377,22 +1417,12 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return write_to_read_only(vcpu, p, r);
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
+	csselr &= CSSELR_EL1_Level | CSSELR_EL1_InD;
+	if (csselr >= CSSELR_MAX)
+		return undef_access(vcpu, p, r);
+
 	p->regval = get_ccsidr(vcpu, csselr);
 
-	/*
-	 * Guests should not be doing cache operations by set/way at all, and
-	 * for this reason, we trap them and attempt to infer the intent, so
-	 * that we can flush the entire guest's address space at the appropriate
-	 * time.
-	 * To prevent this trapping from causing performance problems, let's
-	 * expose the geometry of all data and unified caches (which are
-	 * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
-	 * [If guests should attempt to infer aliasing properties from the
-	 * geometry (which is not permitted by the architecture), they would
-	 * only do so for virtually indexed caches.]
-	 */
-	if (!(csselr & 1)) // data or unified cache
-		p->regval &= ~GENMASK(27, 3);
 	return true;
 }
 
@@ -1681,7 +1711,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
-	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
@@ -2693,7 +2723,6 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
 
 FUNCTION_INVARIANT(midr_el1)
 FUNCTION_INVARIANT(revidr_el1)
-FUNCTION_INVARIANT(clidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
 static void get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
@@ -2705,7 +2734,6 @@ static void get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
 static struct sys_reg_desc invariant_sys_regs[] = {
 	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
 	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
-	{ SYS_DESC(SYS_CLIDR_EL1), NULL, get_clidr_el1 },
 	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
 	{ SYS_DESC(SYS_CTR_EL0), NULL, get_ctr_el0 },
 };
@@ -2758,7 +2786,7 @@ static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 			return -ENOENT;
 		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
 			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (!is_valid_cache(val))
+		if (val >= CSSELR_MAX)
 			return -ENOENT;
 
 		return put_user(get_ccsidr(vcpu, val), uval);
@@ -2783,7 +2811,7 @@ static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 			return -ENOENT;
 		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
 			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (!is_valid_cache(val))
+		if (val >= CSSELR_MAX)
 			return -ENOENT;
 
 		if (get_user(newval, uval))
@@ -2882,13 +2910,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 
 static unsigned int num_demux_regs(void)
 {
-	unsigned int i, count = 0;
-
-	for (i = 0; i < CSSELR_MAX; i++)
-		if (is_valid_cache(i))
-			count++;
-
-	return count;
+	return CSSELR_MAX;
 }
 
 static int write_demux_regids(u64 __user *uindices)
@@ -2898,8 +2920,6 @@ static int write_demux_regids(u64 __user *uindices)
 
 	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
 	for (i = 0; i < CSSELR_MAX; i++) {
-		if (!is_valid_cache(i))
-			continue;
 		if (put_user(val | i, uindices))
 			return -EFAULT;
 		uindices++;
@@ -3001,7 +3021,6 @@ int kvm_sys_reg_table_init(void)
 {
 	bool valid = true;
 	unsigned int i;
-	struct sys_reg_desc clidr;
 
 	/* Make sure tables are unique and in order. */
 	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);
@@ -3018,23 +3037,5 @@ int kvm_sys_reg_table_init(void)
 	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
 		invariant_sys_regs[i].reset(NULL, &invariant_sys_regs[i]);
 
-	/*
-	 * CLIDR format is awkward, so clean it up.  See ARM B4.1.20:
-	 *
-	 *   If software reads the Cache Type fields from Ctype1
-	 *   upwards, once it has seen a value of 0b000, no caches
-	 *   exist at further-out levels of the hierarchy. So, for
-	 *   example, if Ctype3 is the first Cache Type field with a
-	 *   value of 0b000, the values of Ctype4 to Ctype7 must be
-	 *   ignored.
-	 */
-	get_clidr_el1(NULL, &clidr); /* Ugly... */
-	cache_levels = clidr.val;
-	for (i = 0; i < 7; i++)
-		if (((cache_levels >> (i*3)) & 7) == 0)
-			break;
-	/* Clear all higher bits. */
-	cache_levels &= (1 << (i*3))-1;
-
 	return 0;
 }
-- 
2.38.1

