Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8726B67ED73
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjA0S0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjA0S0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:26:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4407C327
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:21 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jm10so5833414plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZBj71qSb3+Aqnn9b5ZzRJQhfdhAJ0+/w4jzSKSrSG0=;
        b=aNBa46TcUSAaIYzEsEXoxK+K6UaJ27trR2LRtWhlroeZP8+4qMn4qHDpVUaLXyOqqS
         SsxYp5Ild2HPTcXbRh+qJZ9WgicgtHl2E1GbkiuBr0GDbj8CCl6SqD8SYOAKx6pczEjl
         MJ3iCXE43O9o1sqIYxImQvfN0UiiNGNKiGDPWPn0gzNqDbF5ouyQdT911q2Pk/OZ6YQT
         2FoeisVf6i+eAomU9JIxZ9t/5x7aksViIfhATp/SNSCFNmn4q1xjP4Iad/sCTGyRkA/T
         hYmUwi3atuAJmSBf8bh0NqKY9uFcp05HGs3LpQZ1vpGQ/FeXTNC7LFoqO/Afpc57xcL5
         4pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZBj71qSb3+Aqnn9b5ZzRJQhfdhAJ0+/w4jzSKSrSG0=;
        b=zhh5oBfJtk3J/gE1bUv2U/pbGS4mayN4FG1WA/1XJlDtVMGk3evXSDNnl3xrKlLCC3
         CvoGObGbW+nx1ToIlIJVp3h4BKc5kLw8EuTP1iQHxf3JDTD0HBWmtTMLRwG2gz47BcRx
         ucP5674mHpc3Dv1YZec5qivGmeDs1zki2Vh937/oVfSRRT11AUKF9gDZr8rn7EFvdnC7
         UqtyN09NGBBluJ2Q+nVE5dVTrBNP0wmoL/KSdxP/odX6ZVbKK2htEzWIkWJxqEc/iYl6
         BWkEjfC1TXCd7oAnx9aq5OY5Vu+iFaaeiyZZwF0JqLCzH3FR9j3S2bX26rPJBdaddp7j
         TCoA==
X-Gm-Message-State: AFqh2kqW+ntRUOXVoDQEadJr7r9gvqBEgLQMZ6etfJM/gRJJJr8aNmIT
        qdTcp4b6BAyOWZ4KuMgnrBeV3VIR+ecFM35+
X-Google-Smtp-Source: AMrXdXuFU4CliLgiqYcpuV5y49cJy2dQOPdEQpLWatH40jjemOVctQNIrj/jMPv+twKCdl6e5nlWmA==
X-Received: by 2002:a17:902:8b83:b0:194:ab28:3268 with SMTP id ay3-20020a1709028b8300b00194ab283268mr34680188plb.34.1674843980961;
        Fri, 27 Jan 2023 10:26:20 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jc5-20020a17090325c500b00189d4c666c8sm3195219plb.153.2023.01.27.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:26:20 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 08/14] RISC-V: KVM: Add SBI PMU extension support
Date:   Fri, 27 Jan 2023 10:25:52 -0800
Message-Id: <20230127182558.2416400-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127182558.2416400-1-atishp@rivosinc.com>
References: <20230127182558.2416400-1-atishp@rivosinc.com>
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
index aa42da6..04a3b4b 100644
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
index 0000000..73aab30
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Rivos Inc
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
+		/*
+		 * This can fail if perf core framework fails to create an event.
+		 * Forward the error to the user space because its an error happened
+		 * within host kernel. The other option would be convert this to
+		 * an SBI error and forward to the guest.
+		 */
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
+	return ret;
+}
+
+unsigned long kvm_sbi_ext_pmu_probe(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+
+	return kvpmu->init_done;
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

