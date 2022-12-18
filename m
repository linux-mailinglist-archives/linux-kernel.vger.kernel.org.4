Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7164FDBB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLRFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiLRFPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:15:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF2DC0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so6067496pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbku2iGSL/iRdowGqnTtMdWjwk//SMim4nWmdRDxnMs=;
        b=123/KLCj3LYyn7rqztkvM6x2AeqkXLK9bCMFJRafssVwqlH+yC/0Sec+Z9u5yN86hV
         E9SHypw+xwWcprb2R7QAMbw8bNosbbo653zRWRSkrKWkmNzlbElAXrX6qOUnflJ+cHDW
         v+aOruOljFuRajGzX90eIbOg9g6ZYWFP+2+dF7G6VOvkAf6UBT0nU532pY3Ye366bWBF
         CHemz3sLKDVpy6JltRaNfIYvf/INHt6prddtEpMHz1eywXgnqQCUTA6Gc8eoe63aOEZI
         pwEncdhARLzxG5coAckvqDxpWoMzyhk0H9t+vVV5aCqN2aqYqTBYbS+0HC6oK+RAkVfX
         Hu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbku2iGSL/iRdowGqnTtMdWjwk//SMim4nWmdRDxnMs=;
        b=TGeY5rJWX7zV4bKD3HC/27yAaairrSCOZa3qGBeU3BksFXkT1fm3feDopDaR+bkhcR
         bZVSrWaGNJG6AW4ZqM0RcoORHqhNDah8i4BraYX8HNLrhqQiUX774dK4CWorlhErvnQz
         eFKrgkr/vCSGGk3dsdhcYAfNQnykjtV0y6BJMRQFR6GxPILi/ISrxbqBX16xKUYFmt4Y
         s4UtQUFM3AuXv4yM/ZAktpCz3fAk+LuBw4qsZwQIqqMlBxQ/s07FX1PMy3p5P20TolD7
         LzDmm+3wrAuSj85sflbHry4gzpzedPNOugdzGPsus3HLSCu3AGjoChqvx1/kQ3nYLmZi
         lT0g==
X-Gm-Message-State: ANoB5pk95F5eWr4mZW8hHWvaF24u5iIVG/OWODY7McZ+PhOmxB8sH+4I
        BvGOCYXUsMk7YOY4gRnJc7OELA==
X-Google-Smtp-Source: AA0mqf47GW9wCDSTklj2Bvuc8AJ8IgjIZXIJkwM9/dZgQRSZQMCLTY55T8L/SnveaWRUwRQn4MdOPg==
X-Received: by 2002:a17:90a:a04:b0:219:bd62:f048 with SMTP id o4-20020a17090a0a0400b00219bd62f048mr38770743pjo.4.1671340544122;
        Sat, 17 Dec 2022 21:15:44 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a6ac100b002139459e121sm7002417pjm.27.2022.12.17.21.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:15:43 -0800 (PST)
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
Subject: [PATCH v3 5/7] KVM: arm64: Allow user to set CCSIDR_EL1
Date:   Sun, 18 Dec 2022 14:14:10 +0900
Message-Id: <20221218051412.384657-6-akihiko.odaki@daynix.com>
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

Allow the userspace to set CCSIDR_EL1 so that if the kernel changes the
default values of CCSIDR_EL1, the userspace can restore the old values
from an old saved VM context.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/kvm_host.h |   3 +
 arch/arm64/kvm/reset.c            |   1 +
 arch/arm64/kvm/sys_regs.c         | 116 ++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index cc2ede0eaed4..cfc6930efe1b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -417,6 +417,9 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+
+	/* Per-vcpu CCSIDR override or NULL */
+	u32 *ccsidr;
 };
 
 /*
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ae18472205a..7980983dbad7 100644
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
index f4a7c5abcbca..f48a3cc38d24 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -87,11 +87,27 @@ static u32 cache_levels;
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 14
 
+static u8 get_min_cache_line_size(u32 csselr)
+{
+	u64 ctr_el0;
+	int field;
+
+	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
+	field = csselr & CSSELR_EL1_InD ? CTR_EL0_IminLine_SHIFT : CTR_EL0_DminLine_SHIFT;
+
+	return cpuid_feature_extract_unsigned_field(ctr_el0, field) - 2;
+}
+
 /* Which cache CCSIDR represents depends on CSSELR value. */
-static u32 get_ccsidr(u32 csselr)
+static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 {
+	u32 ccsidr_index = csselr & (CSSELR_EL1_Level | CSSELR_EL1_InD);
 	u32 ccsidr;
 
+	if (vcpu->arch.ccsidr && is_valid_cache(ccsidr_index) &&
+	    !(kvm_has_mte(vcpu->kvm) && (csselr & CSSELR_EL1_TnD)))
+		return vcpu->arch.ccsidr[ccsidr_index];
+
 	/* Make sure noone else changes CSSELR during this! */
 	local_irq_disable();
 	write_sysreg(csselr, csselr_el1);
@@ -102,6 +118,61 @@ static u32 get_ccsidr(u32 csselr)
 	return ccsidr;
 }
 
+static bool is_valid_cache(u32 val)
+{
+	u32 level, ctype;
+
+	if (val >= CSSELR_MAX)
+		return false;
+
+	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
+	level = (val >> 1);
+	ctype = (cache_levels >> (level * 3)) & 7;
+
+	switch (ctype) {
+	case 0: /* No cache */
+		return false;
+	case 1: /* Instruction cache only */
+		return (val & 1);
+	case 2: /* Data cache only */
+	case 4: /* Unified cache */
+		return !(val & 1);
+	case 3: /* Separate instruction and data caches */
+		return true;
+	default: /* Reserved: we can't know instruction or data. */
+		return false;
+	}
+}
+
+static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
+{
+	u8 line_size = (val & CCSIDR_EL1_LineSize) >> CCSIDR_EL1_LineSize_SHIFT;
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
+			if (is_valid_cache(i))
+				ccsidr[i] = get_ccsidr(vcpu, i);
+
+		vcpu->arch.ccsidr = ccsidr;
+	}
+
+	ccsidr[csselr] = val;
+
+	return 0;
+}
+
 /*
  * See note at ARMv7 ARM B1.14.4 (TL;DR: S/W ops are not easily virtualized).
  */
@@ -1300,7 +1371,7 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return write_to_read_only(vcpu, p, r);
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
-	p->regval = get_ccsidr(csselr);
+	p->regval = get_ccsidr(vcpu, csselr);
 
 	/*
 	 * Guests should not be doing cache operations by set/way at all, and
@@ -2660,33 +2731,7 @@ static int set_invariant_sys_reg(u64 id, u64 __user *uaddr)
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
@@ -2705,13 +2750,13 @@ static int demux_c15_get(u64 id, void __user *uaddr)
 		if (!is_valid_cache(val))
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
@@ -2733,10 +2778,7 @@ static int demux_c15_set(u64 id, void __user *uaddr)
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
@@ -2773,7 +2815,7 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_get(reg->id, uaddr);
+		return demux_c15_get(vcpu, reg->id, uaddr);
 
 	err = get_invariant_sys_reg(reg->id, uaddr);
 	if (err != -ENOENT)
@@ -2817,7 +2859,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_set(reg->id, uaddr);
+		return demux_c15_set(vcpu, reg->id, uaddr);
 
 	err = set_invariant_sys_reg(reg->id, uaddr);
 	if (err != -ENOENT)
-- 
2.38.1

