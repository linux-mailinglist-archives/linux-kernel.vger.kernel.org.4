Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BC7310E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245014AbjFOHgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245030AbjFOHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:34:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DA2967
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:34:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b50394a7f2so9491795ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686814449; x=1689406449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5HbPVR3QtNXxU1oKHkD/V666BtdibNb7IDtcLf2Zqk=;
        b=KIN1D7FID2JoNlDH8zGF4bkh2OCtJTdH1POzUKXCdInIE6fpu38dhi8pwZLanO/eFa
         VzXCrDUEf5hhdTHu0TZr3iVwRi9OQtSumjS9PKZSj6A5UdojcJHtY/wWY+mPfWQQ7jrW
         sopEXgToYFzpCh9PQzUgj+/aDA85niWpcabbBpemUrsdbIqb7ViqrdFweXQAyoad1W+c
         /1jGNK4aqPvp5yjD1NOAsrMDtFr7lEO5JnraRTPPIwynEFPZLUa3b32r/mAiL4YeIjcG
         yJjNaG4gmSXWsO+tvWLUiE1jFsDIZ2UigSbTJnmRztc653D4YDyIVLdxTeqiN8JiXFH3
         sQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814449; x=1689406449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5HbPVR3QtNXxU1oKHkD/V666BtdibNb7IDtcLf2Zqk=;
        b=KCJexsiMV79H7rz8x5Zh9EEsoLLFbQbbrXV4UoMzvlCJjXSvRpsLesJQ4RY+2kqwEJ
         Z2xisEAbIY2av3cdpF0y0XHK6H8NEGvv+qn1GbPQ/yDHKjAxBcjtUomOkR5qDXnwqV+/
         04t0jhY+hKRrfvX/RHgVDL3kkrlvZceC72x4qLFInE4L6PJDh5YQPT1PWj3n5rgqiqrh
         hLbFjuZ7BYpW4arcxsRenl5RIFcSwmmgTdopgh1wV7eI3XC61kh40Wt6jSENE0H+t9mH
         dISkBwGOWpBQ8hgIwWPAy1wRK4T6MqriNnsN1a5ODILG4RhFK0j/gpEsS8fCT0RKk9zr
         GwAg==
X-Gm-Message-State: AC+VfDx4RVTNEKG4u4Q+s4YhXhUa2G2yQdf7HGSCIHhHEsdubzQPIO0c
        YVpI5kwII3trwJ4IoEyA3gHMtQ==
X-Google-Smtp-Source: ACHHUZ4WHHdbev9KkvtpUlC2u1yPsievjxeS0pSrfXL0jG8l30ecmSB7b61z1U+MRLZr4dJIybMHtg==
X-Received: by 2002:a17:902:7597:b0:1b3:bbe3:25a8 with SMTP id j23-20020a170902759700b001b3bbe325a8mr10233865pll.55.1686814449238;
        Thu, 15 Jun 2023 00:34:09 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm8049855plb.86.2023.06.15.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:34:08 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 02/10] RISC-V: KVM: Add IMSIC related defines
Date:   Thu, 15 Jun 2023 13:03:45 +0530
Message-Id: <20230615073353.85435-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615073353.85435-1-apatel@ventanamicro.com>
References: <20230615073353.85435-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add IMSIC related defines in a separate header so that different
parts of KVM code can share it. Once AIA drivers are merged will
have a common IMSIC header shared by both KVM and IRQCHIP driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_aia_imsic.h | 38 ++++++++++++++++++++++++++
 arch/riscv/kvm/aia.c                   |  3 +-
 2 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_aia_imsic.h

diff --git a/arch/riscv/include/asm/kvm_aia_imsic.h b/arch/riscv/include/asm/kvm_aia_imsic.h
new file mode 100644
index 000000000000..da5881d2bde0
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_aia_imsic.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __KVM_RISCV_AIA_IMSIC_H
+#define __KVM_RISCV_AIA_IMSIC_H
+
+#include <linux/types.h>
+#include <asm/csr.h>
+
+#define IMSIC_MMIO_PAGE_SHIFT		12
+#define IMSIC_MMIO_PAGE_SZ		(1UL << IMSIC_MMIO_PAGE_SHIFT)
+#define IMSIC_MMIO_PAGE_LE		0x00
+#define IMSIC_MMIO_PAGE_BE		0x04
+
+#define IMSIC_MIN_ID			63
+#define IMSIC_MAX_ID			2048
+
+#define IMSIC_EIDELIVERY		0x70
+
+#define IMSIC_EITHRESHOLD		0x72
+
+#define IMSIC_EIP0			0x80
+#define IMSIC_EIP63			0xbf
+#define IMSIC_EIPx_BITS			32
+
+#define IMSIC_EIE0			0xc0
+#define IMSIC_EIE63			0xff
+#define IMSIC_EIEx_BITS			32
+
+#define IMSIC_FIRST			IMSIC_EIDELIVERY
+#define IMSIC_LAST			IMSIC_EIE63
+
+#define IMSIC_MMIO_SETIPNUM_LE		0x00
+#define IMSIC_MMIO_SETIPNUM_BE		0x04
+
+#endif
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 1cee75a8c883..c78c06d99e39 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -15,6 +15,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <asm/hwcap.h>
+#include <asm/kvm_aia_imsic.h>
 
 struct aia_hgei_control {
 	raw_spinlock_t lock;
@@ -364,8 +365,6 @@ static int aia_rmw_iprio(struct kvm_vcpu *vcpu, unsigned int isel,
 	return KVM_INSN_CONTINUE_NEXT_SEPC;
 }
 
-#define IMSIC_FIRST	0x70
-#define IMSIC_LAST	0xff
 int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
 				unsigned long *val, unsigned long new_val,
 				unsigned long wr_mask)
-- 
2.34.1

