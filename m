Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658D63EE6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLAKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiLAKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:50:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5713E85
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:49:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o12so1481539pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d6GIsRnHRwJeo4c8vwktBHVtkrfvERt/xtyaBPDy4o=;
        b=UF7drim7moVNa+AO0IAYUNeTBgBFvWm60+kHGmRNakQh4mdoH4iKggMg+4EuZZ3MXB
         IT1R1Ry/USDLKLT9/zJlCeUXXIfUngZFtUHVN+I4fjNpX4kQh0hfFESY+fgXXpr1TQE7
         ymN49ybc4SPnqqpomMNQe4FB6r84YZphIB6HwgMx8a7LtOnhQZnRJQHD8vPEpswTT91J
         7tJ0YRJwil8e/laIxfg1mJzooYKONCPnhl9QWxKHixN10B0cqzp0zcNwS9kOBOM+7fUN
         8G2jD408lr4K+wH5xpIub+G6cQ2K/qp8zKvZips9UrraQ0mE9zP237bys0iNHMbGAAHT
         4paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d6GIsRnHRwJeo4c8vwktBHVtkrfvERt/xtyaBPDy4o=;
        b=v9HYl1aha8qAgAD6r7v3Xg1l9/INtU2l9hyUEZVfJPBKwAynEflcpVw1TW22mHo8iO
         G7YrsIAWQfF2ruK2Ppy0YheL5JuoTyXsrshU0i0j7O7+NinHUikTPiva9AlyVjl62qbt
         knhgbp8HCZ0Jti6oQTCJnD2me4YL+FbyXck9oJh2VllktxTaiwMLOuGusKLVcpfOtZNf
         xsnNbTD3GjfCLD6IZTMuEu0Do3wUjC7UYDlOMJI8EQMxS8raE5Cg0q3Qr0jJZ9qeELOk
         W6cbwtkq5OkDyNoVngQks+T6xgUzREvhqjiKHPhWOvUBHFHUJrckaNwRkDyql+9nMB21
         WYAQ==
X-Gm-Message-State: ANoB5pmTWIE1OqMqtGCDk3r7WHJPs82pMrNwQYb3MnyFgGO4GsU3Im1M
        ODGygikcQ8tt9uO58mHp98AxGP4RiB6typdy
X-Google-Smtp-Source: AA0mqf5I7QVq0C0CSAaOPDG0zKpfuEuQQ+mRZCxYhiDAqNchwNBAU9nCqkYFzRdnVyrzfG7tR327QQ==
X-Received: by 2002:a17:902:ab89:b0:185:3659:1ce9 with SMTP id f9-20020a170902ab8900b0018536591ce9mr44908324plr.26.1669891790333;
        Thu, 01 Dec 2022 02:49:50 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id 4-20020a630804000000b004785a63b44bsm2320580pgi.43.2022.12.01.02.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:49:50 -0800 (PST)
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
Subject: [PATCH 1/3] KVM: arm64: Make CCSIDRs consistent
Date:   Thu,  1 Dec 2022 19:49:12 +0900
Message-Id: <20221201104914.28944-2-akihiko.odaki@daynix.com>
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

A vCPU sees masked CCSIDRs when the physical CPUs has mismatched
cache types or the vCPU has 32-bit EL1. Perform the same masking for
ioctls too so that ioctls shows values consistent with the values the
vCPU actually sees.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  9 ++++--
 arch/arm64/kvm/sys_regs.c            | 45 ++++++++++++++--------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 9bdba47f7e14..b45cf8903190 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -61,6 +61,12 @@ static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
 }
 #endif
 
+static inline bool vcpu_cache_overridden(struct kvm_vcpu *vcpu)
+{
+	return cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
+	       vcpu_el1_is_32bit(vcpu);
+}
+
 static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
@@ -88,8 +94,7 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	if (vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
 
-	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
-	    vcpu_el1_is_32bit(vcpu))
+	if (vcpu_cache_overridden(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID2;
 
 	if (kvm_has_mte(vcpu->kvm))
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f4a7c5abcbca..273ed1aaa6b3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -88,7 +88,7 @@ static u32 cache_levels;
 #define CSSELR_MAX 14
 
 /* Which cache CCSIDR represents depends on CSSELR value. */
-static u32 get_ccsidr(u32 csselr)
+static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 {
 	u32 ccsidr;
 
@@ -99,6 +99,21 @@ static u32 get_ccsidr(u32 csselr)
 	ccsidr = read_sysreg(ccsidr_el1);
 	local_irq_enable();
 
+	/*
+	 * Guests should not be doing cache operations by set/way at all, and
+	 * for this reason, we trap them and attempt to infer the intent, so
+	 * that we can flush the entire guest's address space at the appropriate
+	 * time.
+	 * To prevent this trapping from causing performance problems, let's
+	 * expose the geometry of all data and unified caches (which are
+	 * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
+	 * [If guests should attempt to infer aliasing properties from the
+	 * geometry (which is not permitted by the architecture), they would
+	 * only do so for virtually indexed caches.]
+	 */
+	if (vcpu_cache_overridden(vcpu) && !(csselr & 1)) // data or unified cache
+		ccsidr &= ~GENMASK(27, 3);
+
 	return ccsidr;
 }
 
@@ -1300,22 +1315,8 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		return write_to_read_only(vcpu, p, r);
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
-	p->regval = get_ccsidr(csselr);
+	p->regval = get_ccsidr(vcpu, csselr);
 
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
 
@@ -2686,7 +2687,7 @@ static bool is_valid_cache(u32 val)
 	}
 }
 
-static int demux_c15_get(u64 id, void __user *uaddr)
+static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 {
 	u32 val;
 	u32 __user *uval = uaddr;
@@ -2705,13 +2706,13 @@ static int demux_c15_get(u64 id, void __user *uaddr)
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
@@ -2734,7 +2735,7 @@ static int demux_c15_set(u64 id, void __user *uaddr)
 			return -EFAULT;
 
 		/* This is also invariant: you can't change it. */
-		if (newval != get_ccsidr(val))
+		if (newval != get_ccsidr(vcpu, val))
 			return -EINVAL;
 		return 0;
 	default:
@@ -2773,7 +2774,7 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_get(reg->id, uaddr);
+		return demux_c15_get(vcpu, reg->id, uaddr);
 
 	err = get_invariant_sys_reg(reg->id, uaddr);
 	if (err != -ENOENT)
@@ -2817,7 +2818,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
-		return demux_c15_set(reg->id, uaddr);
+		return demux_c15_set(vcpu, reg->id, uaddr);
 
 	err = set_invariant_sys_reg(reg->id, uaddr);
 	if (err != -ENOENT)
-- 
2.38.1

