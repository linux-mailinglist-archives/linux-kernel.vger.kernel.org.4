Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8A666901
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjALCj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjALCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DAB48580
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w3so18821108ply.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyvYKyatzjSFSXMERxCSdmgp11HgFiCL+ESPI5jKkx4=;
        b=A2e+hamNTsUtZKNzkrSBliFUiDp1C7lsOOYKawjkDfmemncLDyfINC4nZwvEymuPT0
         tBqI24xffy7XxHMRftGd4f2R2YFK+dYCGMd3kGZOhYiUvwIjetaOp6uyRd1iUi5Yy6Cs
         VlhEajUfcmr7HzcEm3p2umhWl824T2qezPOXWLb6ESiz+ZHvaku08Lz+kx6xKVg5lgTz
         5mc9gQfj8YKqp4OpoC8grxxKa9fNAhQxJPvtC/Qps2+xo6CH+pV1Nv11OjcblUJtgcJl
         DmCXf3CcXhaeTwSVdU6cmKbF7oN21XB0jYtYHMVHWNT8mk/OE80artm4Wh1l91NCOlah
         j4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyvYKyatzjSFSXMERxCSdmgp11HgFiCL+ESPI5jKkx4=;
        b=Q63lz38czKwXv4KZnG63esIl/fP8+Axbs7uyZTdZw3SOH1+rZ6PR57VURsTG0TEjkN
         pWrC8GXwYCXZPmdjCFpuMQp9MoXrHd01GGMC6R4mC5f2LeTBTLPAcWpVWcQFWAb/Oaz7
         d7Ge5V2XVXwNJVoL6mtwyy3ZlrBpJPxPqffBYFLbf5z0ZITH+Kkxw3xXgdaUJowhmedU
         8VIUxVd4b1CXm+uRewLDMita60p0Bgzf7Qaa1XNmtfGpz05TVmxm8igtRAJjQrke86QY
         ToZOchv8nY+TCO6wq1Y4xbxpjZpQqfNu0Ylz+747mf3Kr/+9/TvNmK3jwspfn5TYYxMN
         6Slg==
X-Gm-Message-State: AFqh2kp0EeHAi7/AXKLVm4T22xR3EWgQzZftzoxpDh+wXIod+wkMdg1U
        +v+7QqStDny2HPw2zF5bDBIdAQ==
X-Google-Smtp-Source: AMrXdXso81F/nxUNJ9mSBdE422QfkOcy50n+Xn7wWBqvZqxz8ZWXI2Izc02IPylpmwR4E/WBPof3kg==
X-Received: by 2002:a17:902:ceca:b0:192:b386:8f72 with SMTP id d10-20020a170902ceca00b00192b3868f72mr7000174plg.2.1673491175747;
        Wed, 11 Jan 2023 18:39:35 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:35 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v7 7/7] KVM: arm64: Normalize cache configuration
Date:   Thu, 12 Jan 2023 11:38:52 +0900
Message-Id: <20230112023852.42012-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112023852.42012-1-akihiko.odaki@daynix.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
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

CLIDR_EL1 and CCSIDR_EL1 are now writable from the userspace so that
the VMM can restore the values saved with the old kernel.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/cache.h    |   3 +
 arch/arm64/include/asm/kvm_host.h |   4 +
 arch/arm64/kvm/reset.c            |   1 +
 arch/arm64/kvm/sys_regs.c         | 263 +++++++++++++++++++-----------
 4 files changed, 175 insertions(+), 96 deletions(-)

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
index 374390a9212e..496602e0b299 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -252,6 +252,7 @@ struct kvm_vcpu_fault_info {
 enum vcpu_sysreg {
 	__INVALID_SYSREG__,   /* 0 is reserved as an invalid value */
 	MPIDR_EL1,	/* MultiProcessor Affinity Register */
+	CLIDR_EL1,	/* Cache Level ID Register */
 	CSSELR_EL1,	/* Cache Size Selection Register */
 	SCTLR_EL1,	/* System Control Register */
 	ACTLR_EL1,	/* Auxiliary Control Register */
@@ -501,6 +502,9 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+
+	/* Per-vcpu CCSIDR override or NULL */
+	u32 *ccsidr;
 };
 
 /*
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e0267f672b8a..dc235ddc6172 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -157,6 +157,7 @@ void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	if (sve_state)
 		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
 	kfree(sve_state);
+	kfree(vcpu->arch.ccsidr);
 }
 
 static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5617de916c80..459e6d358dab 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -11,6 +11,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bsearch.h>
+#include <linux/cacheinfo.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/printk.h>
@@ -81,25 +82,96 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 	 __vcpu_sys_reg(vcpu, reg) = val;
 }
 
-/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
-static u32 cache_levels;
-
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
+/*
+ * Returns the minimum line size for the selected cache, expressed as
+ * Log2(bytes).
+ */
+static u8 get_min_cache_line_size(bool icache)
+{
+	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u8 field;
+
+	if (icache)
+		field = SYS_FIELD_GET(CTR_EL0, IminLine, ctr);
+	else
+		field = SYS_FIELD_GET(CTR_EL0, DminLine, ctr);
+
+	/*
+	 * Cache line size is represented as Log2(words) in CTR_EL0.
+	 * Log2(bytes) can be derived with the following:
+	 *
+	 * Log2(words) + 2 = Log2(bytes / 4) + 2
+	 * 		   = Log2(bytes) - 2 + 2
+	 * 		   = Log2(bytes)
+	 */
+	return field + 2;
+}
+
 /* Which cache CCSIDR represents depends on CSSELR value. */
-static u32 get_ccsidr(u32 csselr)
+static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
+{
+	u8 line_size;
+
+	if (vcpu->arch.ccsidr)
+		return vcpu->arch.ccsidr[csselr];
+
+	line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);
+
+	/*
+	 * Fabricate a CCSIDR value as the overriding value does not exist.
+	 * The real CCSIDR value will not be used as it can vary by the
+	 * physical CPU which the vcpu currently resides in.
+	 *
+	 * The line size is determined with get_min_cache_line_size(), which
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
+	 *
+	 * We don't check if the cache level exists as it is allowed to return
+	 * an UNKNOWN value if not.
+	 */
+	return SYS_FIELD_PREP(CCSIDR_EL1, LineSize, line_size - 4);
+}
+
+static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
 {
-	u32 ccsidr;
+	u8 line_size = FIELD_GET(CCSIDR_EL1_LineSize, val);
+	u32 *ccsidr = vcpu->arch.ccsidr;
+	u32 i;
+
+	if ((val & CCSIDR_EL1_RES0) || line_size < get_min_cache_line_size(csselr))
+		return -EINVAL;
+
+	if (!ccsidr) {
+		if (val == get_ccsidr(vcpu, csselr))
+			return 0;
+
+		ccsidr = kmalloc_array(CSSELR_MAX, sizeof(u32), GFP_KERNEL);
+		if (!ccsidr)
+			return -ENOMEM;
+
+		for (i = 0; i < CSSELR_MAX; i++)
+			ccsidr[i] = get_ccsidr(vcpu, i);
+
+		vcpu->arch.ccsidr = ccsidr;
+	}
 
-	/* Make sure noone else changes CSSELR during this! */
-	local_irq_disable();
-	write_sysreg(csselr, csselr_el1);
-	isb();
-	ccsidr = read_sysreg(ccsidr_el1);
-	local_irq_enable();
+	ccsidr[csselr] = val;
 
-	return ccsidr;
+	return 0;
 }
 
 /*
@@ -1391,10 +1463,78 @@ static bool access_clidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
+	if ((ctr_el0 & CTR_EL0_IDC)) {
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
+static int set_clidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		      u64 val)
+{
+	u64 ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	u64 idc = !CLIDR_LOC(val) || (!CLIDR_LOUIS(val) && !CLIDR_LOUU(val));
+
+	if ((val & CLIDR_EL1_RES0) || (!(ctr_el0 & CTR_EL0_IDC) && idc))
+		return -EINVAL;
+
+	__vcpu_sys_reg(vcpu, rd->reg) = val;
+
+	return 0;
+}
+
 static bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
@@ -1416,22 +1556,10 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return write_to_read_only(vcpu, p, r);
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
-	p->regval = get_ccsidr(csselr);
+	csselr &= CSSELR_EL1_Level | CSSELR_EL1_InD;
+	if (csselr < CSSELR_MAX)
+		p->regval = get_ccsidr(vcpu, csselr);
 
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
 
@@ -1723,7 +1851,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
-	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
+	  .set_user = set_clidr },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
@@ -2735,7 +2864,6 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
 
 FUNCTION_INVARIANT(midr_el1)
 FUNCTION_INVARIANT(revidr_el1)
-FUNCTION_INVARIANT(clidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
 static void get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
@@ -2747,7 +2875,6 @@ static void get_ctr_el0(struct kvm_vcpu *v, const struct sys_reg_desc *r)
 static struct sys_reg_desc invariant_sys_regs[] = {
 	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
 	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
-	{ SYS_DESC(SYS_CLIDR_EL1), NULL, get_clidr_el1 },
 	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
 	{ SYS_DESC(SYS_CTR_EL0), NULL, get_ctr_el0 },
 };
@@ -2784,33 +2911,7 @@ static int set_invariant_sys_reg(u64 id, u64 __user *uaddr)
 	return 0;
 }
 
-static bool is_valid_cache(u32 val)
-{
-	u32 level, ctype;
-
-	if (val >= CSSELR_MAX)
-		return false;
-
-	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
-	level = (val >> 1);
-	ctype = (cache_levels >> (level * 3)) & 7;
-
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
-}
-
-static int demux_c15_get(u64 id, void __user *uaddr)
+static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 {
 	u32 val;
 	u32 __user *uval = uaddr;
@@ -2826,16 +2927,16 @@ static int demux_c15_get(u64 id, void __user *uaddr)
 			return -ENOENT;
 		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
 			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (!is_valid_cache(val))
+		if (val >= CSSELR_MAX)
 			return -ENOENT;
 
-		return put_user(get_ccsidr(val), uval);
+		return put_user(get_ccsidr(vcpu, val), uval);
 	default:
 		return -ENOENT;
 	}
 }
 
-static int demux_c15_set(u64 id, void __user *uaddr)
+static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 {
 	u32 val, newval;
 	u32 __user *uval = uaddr;
@@ -2851,16 +2952,13 @@ static int demux_c15_set(u64 id, void __user *uaddr)
 			return -ENOENT;
 		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
 			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (!is_valid_cache(val))
+		if (val >= CSSELR_MAX)
 			return -ENOENT;
 
 		if (get_user(newval, uval))
 			return -EFAULT;
 
-		/* This is also invariant: you can't change it. */
-		if (newval != get_ccsidr(val))
-			return -EINVAL;
-		return 0;
+		return set_ccsidr(vcpu, val, newval);
 	default:
 		return -ENOENT;
 	}
@@ -2897,7 +2995,7 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_get(reg->id, uaddr);
+		return demux_c15_get(vcpu, reg->id, uaddr);
 
 	err = get_invariant_sys_reg(reg->id, uaddr);
 	if (err != -ENOENT)
@@ -2941,7 +3039,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_set(reg->id, uaddr);
+		return demux_c15_set(vcpu, reg->id, uaddr);
 
 	err = set_invariant_sys_reg(reg->id, uaddr);
 	if (err != -ENOENT)
@@ -2953,13 +3051,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 
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
@@ -2969,8 +3061,6 @@ static int write_demux_regids(u64 __user *uindices)
 
 	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
 	for (i = 0; i < CSSELR_MAX; i++) {
-		if (!is_valid_cache(i))
-			continue;
 		if (put_user(val | i, uindices))
 			return -EFAULT;
 		uindices++;
@@ -3072,7 +3162,6 @@ int kvm_sys_reg_table_init(void)
 {
 	bool valid = true;
 	unsigned int i;
-	struct sys_reg_desc clidr;
 
 	/* Make sure tables are unique and in order. */
 	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);
@@ -3089,23 +3178,5 @@ int kvm_sys_reg_table_init(void)
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
2.39.0

