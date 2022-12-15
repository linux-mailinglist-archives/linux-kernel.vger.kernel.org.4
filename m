Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55B464DF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiLORCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiLORBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:01:31 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC292790B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:01:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3267847pjd.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGBOR0tyzQoeNONlBW3uFBaSGhMbwn7WNuQR1Zb0GQc=;
        b=b1J2YZqiSzN5uw7EnpFFB32xL9nOiwrVzxyZOPFjLinJ1c1MrpzPyZ/YHyn0Wp6UXp
         DrCHpT43vc/rYZIDC7M8EwFJAGT5ORpjNFZj7lXMf/ZC3l/dUNlIiPrpw6AM//ZuVOsG
         vwUTlv6fAm0f70HujypFJGQnnRJGjxzI+G+XeJRyOhB2aCSpXO/78w+awPK+2BQnOsNR
         2RqAheYiuz/EHG+KO4TUob083jCPfob3IzMlFyiISd7CFgeN2AStHOW7Oi7Dx2kDGekm
         e1FwDOfg72/BLQvey7lCXtqGrpaoO0jL1OSGGx+FhFvvEpUwxdcog/UTOTJOHEL51w29
         16jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGBOR0tyzQoeNONlBW3uFBaSGhMbwn7WNuQR1Zb0GQc=;
        b=5nYEqput69KdWPwE5gCoMmt/NEWdBXmJuwrcS0g7IOyRyhNWLSHJaNfrpCKHrT/kKN
         FTUPK1zg0l9zzW5c2WOJy9atRlf08YUe4fzPxqHL+5bMpWCE9Y1qKY9BhhcAFnKXQ2mR
         p/t3nN28Em0k2HN+xhp4+7sTmwXfnNPZEoBDtJJViNoiMQ61CzQuxqPyYh9tGQt2OnNE
         G6ph47pdUJgUGgunraqrRjju/H4PDHOtbKUt+ozIvJXwKk0z3Z9xJ85ysm2Yfzwo2pXD
         i5m6QQbzvNIK1lE9p7Rrq449a88s4B1Jfe0qYGEno+KBcl/e0dn9JG+nfvaORLO0N28r
         C4Ug==
X-Gm-Message-State: ANoB5pmDxrFlrJbyzu7R38F6RhKOkTU5swAz0SuFRaSdawolyzuEFp5T
        PjhBa5/WGx6l3XsWhdVPpMEggYFo3W2qfDKS
X-Google-Smtp-Source: AA0mqf4zkiG3mUjhsNTKfM4UvwyFLXZuCHUspb39Hpcj1DA0kiPwFevN5T/RbLs0WftLs3fJ+RMGFw==
X-Received: by 2002:a17:903:268f:b0:189:dfb0:d380 with SMTP id jf15-20020a170903268f00b00189dfb0d380mr30497363plb.33.1671123679851;
        Thu, 15 Dec 2022 09:01:19 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b001897bfc9800sm4067449pll.53.2022.12.15.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 09:01:19 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Eric Lin <eric.lin@sifive.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 07/11] RISC-V: KVM: Add SBI PMU extension support
Date:   Thu, 15 Dec 2022 09:00:42 -0800
Message-Id: <20221215170046.2010255-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215170046.2010255-1-atishp@rivosinc.com>
References: <20221215170046.2010255-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI PMU extension allows KVM guests to configure/start/stop/query about
the PMU counters in virtualized enviornment as well.

In order to allow that, KVM implements the entire SBI PMU extension.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/Makefile       |  2 +-
 arch/riscv/kvm/vcpu_sbi.c     | 11 +++++
 arch/riscv/kvm/vcpu_sbi_pmu.c | 86 +++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kvm/vcpu_sbi_pmu.c

diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 5de1053..278e97c 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -25,4 +25,4 @@ kvm-y += vcpu_sbi_base.o
 kvm-y += vcpu_sbi_replace.o
 kvm-y += vcpu_sbi_hsm.o
 kvm-y += vcpu_timer.o
-kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o
+kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o vcpu_sbi_pmu.o
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 50c5472..3b8b84e8 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -20,6 +20,16 @@ static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01 = {
 };
 #endif
 
+#ifdef CONFIG_RISCV_PMU_SBI
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu;
+#else
+static const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu = {
+	.extid_start = -1UL,
+	.extid_end = -1UL,
+	.handler = NULL,
+};
+#endif
+
 static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
 	&vcpu_sbi_ext_v01,
 	&vcpu_sbi_ext_base,
@@ -28,6 +38,7 @@ static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
 	&vcpu_sbi_ext_rfence,
 	&vcpu_sbi_ext_srst,
 	&vcpu_sbi_ext_hsm,
+	&vcpu_sbi_ext_pmu,
 	&vcpu_sbi_ext_experimental,
 	&vcpu_sbi_ext_vendor,
 };
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
new file mode 100644
index 0000000..223752f
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Rivos Inc
+ *
+ * Authors:
+ *     Atish Patra <atishp@rivosinc.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <asm/csr.h>
+#include <asm/sbi.h>
+#include <asm/kvm_vcpu_sbi.h>
+
+static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				   struct kvm_vcpu_sbi_ext_data *edata,
+				   struct kvm_cpu_trap *utrap)
+{
+	int ret = 0;
+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	unsigned long funcid = cp->a6;
+	uint64_t temp;
+
+	/* Return not supported if PMU is not initialized */
+	if (!kvpmu->init_done)
+		return -EINVAL;
+
+	switch (funcid) {
+	case SBI_EXT_PMU_NUM_COUNTERS:
+		ret = kvm_riscv_vcpu_pmu_num_ctrs(vcpu, edata);
+		break;
+	case SBI_EXT_PMU_COUNTER_GET_INFO:
+		ret = kvm_riscv_vcpu_pmu_ctr_info(vcpu, cp->a0, edata);
+		break;
+	case SBI_EXT_PMU_COUNTER_CFG_MATCH:
+#if defined(CONFIG_32BIT)
+		temp = ((uint64_t)cp->a5 << 32) | cp->a4;
+#else
+		temp = cp->a4;
+#endif
+		ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
+						       cp->a2, cp->a3, temp, edata);
+		break;
+	case SBI_EXT_PMU_COUNTER_START:
+#if defined(CONFIG_32BIT)
+		temp = ((uint64_t)cp->a4 << 32) | cp->a3;
+#else
+		temp = cp->a3;
+#endif
+		ret = kvm_riscv_vcpu_pmu_ctr_start(vcpu, cp->a0, cp->a1, cp->a2,
+						   temp, edata);
+		break;
+	case SBI_EXT_PMU_COUNTER_STOP:
+		ret = kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1, cp->a2, edata);
+		break;
+	case SBI_EXT_PMU_COUNTER_FW_READ:
+		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, edata);
+		break;
+	default:
+		edata->err_val = SBI_ERR_NOT_SUPPORTED;
+	}
+
+
+	return ret;
+}
+
+unsigned long kvm_sbi_ext_pmu_probe(struct kvm_vcpu *vcpu, unsigned long extid)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+
+	/*
+	 * PMU Extension is only available to guests if privilege mode filtering
+	 * is available. Otherwise, guest will always count events while the
+	 * execution is in hypervisor mode.
+	 */
+	return kvpmu->init_done && riscv_isa_extension_available(NULL, SSCOFPMF);
+}
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu = {
+	.extid_start = SBI_EXT_PMU,
+	.extid_end = SBI_EXT_PMU,
+	.handler = kvm_sbi_ext_pmu_handler,
+	.probe = kvm_sbi_ext_pmu_probe,
+};
-- 
2.25.1

