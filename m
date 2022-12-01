Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46663EE6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLAKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:50:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7534D5C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:49:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y4so1289701plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzHwXsUVcNKW6PtJQ1J0+WaE2jc/6muUSDkeS4NHJ3A=;
        b=zaJLFADO9dpcOwd8VIhLCtDevcWu59j47Ph4/0tK9r6GAyRUKtSxenx+7EClnbg6fr
         6IyGsDvGPi5Z+IAfrS0dw4dnH9lCGonGwIRhn9f88nTNTV1+KB1+LSQPoH7H9q/qui0X
         0DhFOb/5MLv/+3qfOvNXPBTPp9I1oLOYHVV9vsVBn201NcZ1pBZ1q9pDEmfnqn6s67z5
         A+768GnVUJyzWP3tPFdo0KWGx9LaROqLzgKLpFIXFSO1e4nU3p2rR8hjlFq5Jwbbgehj
         9kAyQ9K601ktg6ACOKCWSXqfMOevNCZ3XnL9r7jGSCSK6/6ZL070AydGSLUbthFtRTBz
         iIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzHwXsUVcNKW6PtJQ1J0+WaE2jc/6muUSDkeS4NHJ3A=;
        b=ryEq3rtdNere3EKwNdQK23kaBMeJPI9plAf+r5r0C2SMd88UyFrs8ZJpbOYR9qudtW
         RMGPlr8vpMnJ4rVex3K7456ILkJU9egoOXA25K01IhOo0l8XIPCL6ik6ngBkHD1LXHhe
         hP0AbQIBoE9csxz41Gu4BOohyF7PjKUmJweEmT8Eynhx0Lj2t9fvcXwJDZobQgseWAuC
         yA7U1a4PYXVFquugu5J3sHevfCHXuTIWiRVUIjOBdS8t6W3mcsi6oJEwxfIRTuCS+Lzo
         eUzmPMiwzDMruiIzljl+s+CfGjb03Ga4NMcpGDshTaJ6gl566xbID2fUH1sthKanUBnP
         j7IA==
X-Gm-Message-State: ANoB5pkEPiO6uVzLK9rKPiY6lR7r5myOSF98uDocyPtbbI2dA0Lx3OVc
        WpMh3ACRwQR/uNtmOQlb/aqS7bnFwVb2GuAu
X-Google-Smtp-Source: AA0mqf5ReIh59TFhDLI1b4fbtC++P8aYNKOnfrq/q12L+UGEiXe5pO5lFhjAZ+SxS6tvsWAlH5LMiw==
X-Received: by 2002:a17:903:cc:b0:189:7441:1ada with SMTP id x12-20020a17090300cc00b0018974411adamr26762017plc.13.1669891794164;
        Thu, 01 Dec 2022 02:49:54 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id 4-20020a630804000000b004785a63b44bsm2320580pgi.43.2022.12.01.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:49:53 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 2/3] arm64: errata: Check for mismatched cache associativity
Date:   Thu,  1 Dec 2022 19:49:13 +0900
Message-Id: <20221201104914.28944-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201104914.28944-1-akihiko.odaki@daynix.com>
References: <20221201104914.28944-1-akihiko.odaki@daynix.com>
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

M2 MacBook Air has mismatched CCSIDR associativity bits, which makes the
bits a KVM vCPU sees inconsistent when migrating. Record such mismatches
so that KVM can use the information later to avoid the problem.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/cache.h      |  3 ++
 arch/arm64/include/asm/cpu.h        |  1 +
 arch/arm64/include/asm/cpufeature.h |  8 +++++
 arch/arm64/include/asm/sysreg.h     |  7 ++++
 arch/arm64/kernel/cacheinfo.c       |  4 +--
 arch/arm64/kernel/cpu_errata.c      | 52 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      |  4 +++
 arch/arm64/kernel/cpuinfo.c         | 30 +++++++++++++++++
 arch/arm64/kvm/sys_regs.c           |  4 +--
 arch/arm64/tools/cpucaps            |  1 +
 10 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index c0b178d1bb4f..eeab2b8c7e71 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -72,6 +72,8 @@ static inline u32 cache_type_cwg(void)
 
 #define __read_mostly __section(".data..read_mostly")
 
+#define MAX_CACHE_LEVEL	7	/* Max 7 level supported */
+
 static inline int cache_line_size_of_cpu(void)
 {
 	u32 cwg = cache_type_cwg();
@@ -80,6 +82,7 @@ static inline int cache_line_size_of_cpu(void)
 }
 
 int cache_line_size(void);
+enum cache_type get_cache_type(int level);
 
 /*
  * Read the effective value of CTR_EL0.
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index fd7a92219eea..b8d4f31ed59b 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -41,6 +41,7 @@ struct cpuinfo_arm64 {
 	struct cpu	cpu;
 	struct kobject	kobj;
 	u64		reg_ctr;
+	struct ccsidr	reg_ccsidr[MAX_CACHE_LEVEL + 1];
 	u64		reg_cntfrq;
 	u64		reg_dczid;
 	u64		reg_midr;
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f73f11b55042..104483151362 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -7,6 +7,7 @@
 #define __ASM_CPUFEATURE_H
 
 #include <asm/alternative-macros.h>
+#include <asm/cache.h>
 #include <asm/cpucaps.h>
 #include <asm/cputype.h>
 #include <asm/hwcap.h>
@@ -917,6 +918,13 @@ extern struct arm64_ftr_override id_aa64isar2_override;
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
 
+struct ccsidr {
+	u64 data;
+	u64 inst;
+};
+
+extern struct ccsidr ccsidr[MAX_CACHE_LEVEL + 1];
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7d301700d1a9..e796f14fdc2a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -941,6 +941,13 @@
 #define HFGxTR_EL2_nSMPRI_EL1_SHIFT	54
 #define HFGxTR_EL2_nSMPRI_EL1_MASK	BIT_MASK(HFGxTR_EL2_nSMPRI_EL1_SHIFT)
 
+/* CCSIDR_EL1 bit definitions */
+#define CCSIDR_ASSOCIATIVITY_BITS_MASK	GENMASK(27, 3)
+
+/* CSSELR_EL1 */
+#define CSSELR_IN		1
+#define CSSELR_LEVEL_SHIFT	1
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Create a mask for the feature bits of the specified feature. */
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 97c42be71338..2e808ccc15bf 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -10,7 +10,6 @@
 #include <linux/cacheinfo.h>
 #include <linux/of.h>
 
-#define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
 /* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
 #define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
 #define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
@@ -26,7 +25,7 @@ int cache_line_size(void)
 }
 EXPORT_SYMBOL_GPL(cache_line_size);
 
-static inline enum cache_type get_cache_type(int level)
+enum cache_type get_cache_type(int level)
 {
 	u64 clidr;
 
@@ -35,6 +34,7 @@ static inline enum cache_type get_cache_type(int level)
 	clidr = read_sysreg(clidr_el1);
 	return CLIDR_CTYPE(clidr, level);
 }
+EXPORT_SYMBOL_GPL(get_cache_type);
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
 			 enum cache_type type, unsigned int level)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 89ac00084f38..5caccf602fc0 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -8,6 +8,8 @@
 #include <linux/arm-smccc.h>
 #include <linux/types.h>
 #include <linux/cpu.h>
+#include <linux/cacheinfo.h>
+#include <asm/cache.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
@@ -87,6 +89,50 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 	return (ctr_real != sys) && (ctr_raw != sys);
 }
 
+static bool
+has_mismatched_cache_associativity(const struct arm64_cpu_capabilities *entry,
+				   int scope)
+{
+	u64 mask = CCSIDR_ASSOCIATIVITY_BITS_MASK;
+	u64 real;
+	bool mismatched = false;
+	enum cache_type cache_type;
+	unsigned int i;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	local_irq_disable();
+
+	for (i = 0; i <= MAX_CACHE_LEVEL; i++) {
+		cache_type = get_cache_type(i);
+
+		if ((cache_type & (CACHE_TYPE_DATA | CACHE_TYPE_UNIFIED))) {
+			write_sysreg(i << CSSELR_LEVEL_SHIFT, csselr_el1);
+			isb();
+			real = read_sysreg(ccsidr_el1);
+			if ((ccsidr[i].data & mask) != (real & mask)) {
+				mismatched = true;
+				break;
+			}
+		}
+
+		if ((cache_type & CACHE_TYPE_INST)) {
+			write_sysreg((i << CSSELR_LEVEL_SHIFT) | CSSELR_IN,
+				     csselr_el1);
+			isb();
+			real = read_sysreg(ccsidr_el1);
+			if ((ccsidr[i].inst & mask) != (real & mask)) {
+				mismatched = true;
+				break;
+			}
+		}
+	}
+
+	local_irq_enable();
+
+	return mismatched;
+}
+
 static void
 cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *cap)
 {
@@ -499,6 +545,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(cavium_erratum_30115_cpus),
 	},
 #endif
+	{
+		.desc = "Mismatched cache associativity",
+		.capability = ARM64_MISMATCHED_CACHE_ASSOCIATIVITY,
+		.matches = has_mismatched_cache_associativity,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+	},
 	{
 		.desc = "Mismatched cache type (CTR_EL0)",
 		.capability = ARM64_MISMATCHED_CACHE_TYPE,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b3f37e2209ad..ef259396aa4c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -930,6 +930,8 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	reg->user_mask = user_mask;
 }
 
+struct ccsidr ccsidr[MAX_CACHE_LEVEL + 1];
+
 extern const struct arm64_cpu_capabilities arm64_errata[];
 static const struct arm64_cpu_capabilities arm64_features[];
 
@@ -1039,6 +1041,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * after we have initialised the CPU feature infrastructure.
 	 */
 	setup_boot_cpu_capabilities();
+
+	memcpy(ccsidr, info->reg_ccsidr, sizeof(ccsidr));
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 28d4f442b0bc..b1ea276b9d10 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/cacheinfo.h>
 #include <linux/compat.h>
 #include <linux/elf.h>
 #include <linux/init.h>
@@ -47,6 +48,34 @@ static inline const char *icache_policy_str(int l1ip)
 	}
 }
 
+static void read_ccsidr(struct ccsidr *ccsidr)
+{
+	enum cache_type cache_type;
+	unsigned int i;
+
+	local_irq_disable();
+
+	for (i = 0; i <= MAX_CACHE_LEVEL; i++) {
+		cache_type = get_cache_type(i);
+
+		if ((cache_type & (CACHE_TYPE_DATA | CACHE_TYPE_UNIFIED))) {
+			write_sysreg(i << CSSELR_LEVEL_SHIFT, csselr_el1);
+			isb();
+			ccsidr[i].data = read_sysreg(ccsidr_el1);
+			break;
+		}
+
+		if ((cache_type & CACHE_TYPE_INST)) {
+			write_sysreg((i << CSSELR_LEVEL_SHIFT) | CSSELR_IN,
+				     csselr_el1);
+			isb();
+			ccsidr[i].inst = read_sysreg(ccsidr_el1);
+		}
+	}
+
+	local_irq_enable();
+}
+
 unsigned long __icache_flags;
 
 static const char *const hwcap_str[] = {
@@ -440,6 +469,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		__cpuinfo_store_cpu_32bit(&info->aarch32);
 
+	read_ccsidr(info->reg_ccsidr);
 	cpuinfo_detect_icache_policy(info);
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 273ed1aaa6b3..1f0cb015e81c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -111,8 +111,8 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 	 * geometry (which is not permitted by the architecture), they would
 	 * only do so for virtually indexed caches.]
 	 */
-	if (vcpu_cache_overridden(vcpu) && !(csselr & 1)) // data or unified cache
-		ccsidr &= ~GENMASK(27, 3);
+	if (vcpu_cache_overridden(vcpu) && !(csselr & CSSELR_IN)) // data or unified cache
+		ccsidr &= ~CCSIDR_ASSOCIATIVITY_BITS_MASK;
 
 	return ccsidr;
 }
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index f1c0347ec31a..061c93319295 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -44,6 +44,7 @@ HAS_VIRT_HOST_EXTN
 HAS_WFXT
 HW_DBM
 KVM_PROTECTED_MODE
+MISMATCHED_CACHE_ASSOCIATIVITY
 MISMATCHED_CACHE_TYPE
 MTE
 MTE_ASYMM
-- 
2.38.1

