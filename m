Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB106CFAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjC3Fbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC3Fbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:31:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F90B2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 22:31:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o11so17088884ple.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 22:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680154307; x=1682746307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYfff0Zf1lxUCbJ2nrqYJ8/mKtECEZ2GKO3QQowmo0w=;
        b=b7S+LPDd7Hvt86RLSzYqZ4GZsU/AknAz3cGanMzkIeCLHxRjDPzRXgVy7GAy/Qe3SE
         seWFzZ0WOcv4z6UnawMNV2zZpqhKO0FMrlpYfcKKNPM+Npzf2YR2UyxIovOnC/vFDugY
         9t2BIQbS35J5L9olpYFJH3zl0gYw8KV05nsdBZ3DpZZ0FrEeDz1m4LzJ3RwzMgzRg4gj
         LY2xVb5u52L9EEhZO1IKxBEf6uo1ClHbpMjsPCOcMKLR9YuQyzIGkHSKzQ591CZ3VYTX
         wrzcgyXVDlnBfnzl+3NdSD7XmyG/ApCv33pDPIBnn5pt1xsEstreUVmphQLww/Fj7rJf
         3zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680154307; x=1682746307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYfff0Zf1lxUCbJ2nrqYJ8/mKtECEZ2GKO3QQowmo0w=;
        b=Hzw8tGU8nhTXBW/8juPeKIvlc1IDmGzFo9zXUuLk+chDIbW6+o5NKBNV0IE4HmFuS1
         +IXWX5AX6ztRP1dhPVc0pB+g3wkRDKBsqVrKJT5yrXThBTmH0kzbdTGcAAb76H+ojJt7
         JZMU7spYpTxPmaVRuBiUR8i0cKF/RVLsV8xlzQygxSWRgIsNQuv0uma15rdJqk1xN9lw
         yylFALZKc06/dOCT7XAbFrvX30jd/W28npUPThu7eNmlTNxKOchXsfZjyQuELAaJkifI
         Sd7Mm0DdLQgtrgHxfLdY0aCWxaZfu6V5LAm2gD9hslZ1lmW2ELFVaSQY1k29oU4q0Gu/
         zVLg==
X-Gm-Message-State: AAQBX9dP9GlmkBb12MoHHFRLE6LjcoAd3ranJdpGcl1lUvvdHURtQWGi
        K7MV1c0gS44OqczK2kyjFUHMyQ==
X-Google-Smtp-Source: AKy350YQBkdQX4AmdFekpxXAC2nXRbNnhNWSMNrXUc8W6PG87LflXR6+Or9JExtgLP75iPcok72lZw==
X-Received: by 2002:a17:902:cf4e:b0:1a2:1922:985b with SMTP id e14-20020a170902cf4e00b001a21922985bmr17195587plg.59.1680154306611;
        Wed, 29 Mar 2023 22:31:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.30])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b0019339f3368asm24045679plo.3.2023.03.29.22.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 22:31:46 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 1/1] RISC-V: KVM: Add ONE_REG interface to enable/disable SBI extensions
Date:   Thu, 30 Mar 2023 11:01:35 +0530
Message-Id: <20230330053135.1686577-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330053135.1686577-1-apatel@ventanamicro.com>
References: <20230330053135.1686577-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add ONE_REG interface to enable/disable SBI extensions (just
like the ONE_REG interface for ISA extensions). This allows KVM
user-space to decide the set of SBI extension enabled for a Guest
and by default all SBI extensions are enabled.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |   8 +-
 arch/riscv/include/uapi/asm/kvm.h     |  20 ++++
 arch/riscv/kvm/vcpu.c                 |   2 +
 arch/riscv/kvm/vcpu_sbi.c             | 150 +++++++++++++++++++++++---
 arch/riscv/kvm/vcpu_sbi_base.c        |   2 +-
 5 files changed, 163 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 8425556af7d1..4278125a38a5 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -16,6 +16,7 @@
 
 struct kvm_vcpu_sbi_context {
 	int return_handled;
+	bool extension_disabled[KVM_RISCV_SBI_EXT_MAX];
 };
 
 struct kvm_vcpu_sbi_return {
@@ -45,7 +46,12 @@ void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
 				     struct kvm_run *run,
 				     u32 type, u64 flags);
 int kvm_riscv_vcpu_sbi_return(struct kvm_vcpu *vcpu, struct kvm_run *run);
-const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(unsigned long extid);
+int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
+				   const struct kvm_one_reg *reg);
+int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
+				   const struct kvm_one_reg *reg);
+const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
+				struct kvm_vcpu *vcpu, unsigned long extid);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
 #ifdef CONFIG_RISCV_SBI_V01
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 92af6f3f057c..33c3457b94e7 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -108,6 +108,23 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
+/*
+ * SBI extension IDs specific to KVM. This is not the same as the SBI
+ * extension IDs defined by the RISC-V SBI specification.
+ */
+enum KVM_RISCV_SBI_EXT_ID {
+	KVM_RISCV_SBI_EXT_V01 = 0,
+	KVM_RISCV_SBI_EXT_TIME,
+	KVM_RISCV_SBI_EXT_IPI,
+	KVM_RISCV_SBI_EXT_RFENCE,
+	KVM_RISCV_SBI_EXT_SRST,
+	KVM_RISCV_SBI_EXT_HSM,
+	KVM_RISCV_SBI_EXT_PMU,
+	KVM_RISCV_SBI_EXT_EXPERIMENTAL,
+	KVM_RISCV_SBI_EXT_VENDOR,
+	KVM_RISCV_SBI_EXT_MAX,
+};
+
 /* Possible states for kvm_riscv_timer */
 #define KVM_RISCV_TIMER_STATE_OFF	0
 #define KVM_RISCV_TIMER_STATE_ON	1
@@ -152,6 +169,9 @@ enum KVM_RISCV_ISA_EXT_ID {
 /* ISA Extension registers are mapped as type 7 */
 #define KVM_REG_RISCV_ISA_EXT		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
 
+/* SBI extension registers are mapped as type 8 */
+#define KVM_REG_RISCV_SBI_EXT		(0x08 << KVM_REG_RISCV_TYPE_SHIFT)
+
 #endif
 
 #endif /* __LINUX_KVM_RISCV_H */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 7d010b0be54e..311fd347c5a8 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -601,6 +601,8 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 						 KVM_REG_RISCV_FP_D);
 	case KVM_REG_RISCV_ISA_EXT:
 		return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
+	case KVM_REG_RISCV_SBI_EXT:
+		return kvm_riscv_vcpu_set_reg_sbi_ext(vcpu, reg);
 	default:
 		break;
 	}
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 15fde15f9fb8..bedd7d78a5f0 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -30,17 +30,52 @@ static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu = {
 };
 #endif
 
-static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
-	&vcpu_sbi_ext_v01,
-	&vcpu_sbi_ext_base,
-	&vcpu_sbi_ext_time,
-	&vcpu_sbi_ext_ipi,
-	&vcpu_sbi_ext_rfence,
-	&vcpu_sbi_ext_srst,
-	&vcpu_sbi_ext_hsm,
-	&vcpu_sbi_ext_pmu,
-	&vcpu_sbi_ext_experimental,
-	&vcpu_sbi_ext_vendor,
+struct kvm_riscv_sbi_extension_entry {
+	enum KVM_RISCV_SBI_EXT_ID dis_idx;
+	const struct kvm_vcpu_sbi_extension *ext_ptr;
+};
+
+static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_V01,
+		.ext_ptr = &vcpu_sbi_ext_v01,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_MAX, /* Can't be disabled */
+		.ext_ptr = &vcpu_sbi_ext_base,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_TIME,
+		.ext_ptr = &vcpu_sbi_ext_time,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_IPI,
+		.ext_ptr = &vcpu_sbi_ext_ipi,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_RFENCE,
+		.ext_ptr = &vcpu_sbi_ext_rfence,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_SRST,
+		.ext_ptr = &vcpu_sbi_ext_srst,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_HSM,
+		.ext_ptr = &vcpu_sbi_ext_hsm,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_PMU,
+		.ext_ptr = &vcpu_sbi_ext_pmu,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
+		.ext_ptr = &vcpu_sbi_ext_experimental,
+	},
+	{
+		.dis_idx = KVM_RISCV_SBI_EXT_VENDOR,
+		.ext_ptr = &vcpu_sbi_ext_vendor,
+	},
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
@@ -99,14 +134,95 @@ int kvm_riscv_vcpu_sbi_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 0;
 }
 
-const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(unsigned long extid)
+int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
+				   const struct kvm_one_reg *reg)
+{
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    KVM_REG_RISCV_SBI_EXT);
+	unsigned long i, reg_val;
+	const struct kvm_riscv_sbi_extension_entry *sext = NULL;
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+		return -EINVAL;
+
+	if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	if (reg_num >= KVM_RISCV_SBI_EXT_MAX ||
+	    (reg_val != 1 && reg_val != 0))
+		return -EINVAL;
+
+	if (vcpu->arch.ran_atleast_once)
+		return -EBUSY;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		if (sbi_ext[i].dis_idx == reg_num) {
+			sext = &sbi_ext[i];
+			break;
+		}
+	}
+	if (!sext)
+		return -ENOENT;
+
+	scontext->extension_disabled[sext->dis_idx] = !reg_val;
+
+	return 0;
+}
+
+int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
+				   const struct kvm_one_reg *reg)
+{
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    KVM_REG_RISCV_SBI_EXT);
+	unsigned long i, reg_val;
+	const struct kvm_riscv_sbi_extension_entry *sext = NULL;
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+		return -EINVAL;
+
+	if (reg_num >= KVM_RISCV_SBI_EXT_MAX)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
+		if (sbi_ext[i].dis_idx == reg_num) {
+			sext = &sbi_ext[i];
+			break;
+		}
+	}
+	if (!sext)
+		return -ENOENT;
+
+	reg_val = !scontext->extension_disabled[sext->dis_idx];
+	if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	return 0;
+}
+
+const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
+				struct kvm_vcpu *vcpu, unsigned long extid)
 {
-	int i = 0;
+	int i;
+	const struct kvm_riscv_sbi_extension_entry *sext;
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
 
 	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
-		if (sbi_ext[i]->extid_start <= extid &&
-		    sbi_ext[i]->extid_end >= extid)
-			return sbi_ext[i];
+		sext = &sbi_ext[i];
+		if (sext->ext_ptr->extid_start <= extid &&
+		    sext->ext_ptr->extid_end >= extid) {
+			if (sext->dis_idx < KVM_RISCV_SBI_EXT_MAX &&
+			    scontext->extension_disabled[sext->dis_idx])
+				return NULL;
+			return sbi_ext[i].ext_ptr;
+		}
 	}
 
 	return NULL;
@@ -126,7 +242,7 @@ int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	};
 	bool ext_is_v01 = false;
 
-	sbi_ext = kvm_vcpu_sbi_find_ext(cp->a7);
+	sbi_ext = kvm_vcpu_sbi_find_ext(vcpu, cp->a7);
 	if (sbi_ext && sbi_ext->handler) {
 #ifdef CONFIG_RISCV_SBI_V01
 		if (cp->a7 >= SBI_EXT_0_1_SET_TIMER &&
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 9945aff34c14..5bc570b984f4 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -44,7 +44,7 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			kvm_riscv_vcpu_sbi_forward(vcpu, run);
 			retdata->uexit = true;
 		} else {
-			sbi_ext = kvm_vcpu_sbi_find_ext(cp->a0);
+			sbi_ext = kvm_vcpu_sbi_find_ext(vcpu, cp->a0);
 			*out_val = sbi_ext && sbi_ext->probe ?
 					   sbi_ext->probe(vcpu) : !!sbi_ext;
 		}
-- 
2.34.1

