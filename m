Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38FD616861
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiKBQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiKBQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:20:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E93136F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:14:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk15so25227694wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6tj+7sNHNnTbkzs8ZeKL5miL5fHgtHHC3d2WQTSFbE=;
        b=KuAbtL9XTBizhGI/s9UKTASCs9n5mCuzpUBAjDKPpPPbTBikgNbBtzoyDhdJz3rdNU
         mmnuIzpAEBxAKkL+DSU3LgSNMu7c5yAJmdwZrv3aqDlQYsO7Ila4V+71ZfNrywCdFHeQ
         qz+K94xhrzF57uJqLYDnlI27OVmAWXosKtVna3HQNbDzOffVPx8/KVkDFCHIYs+85RoB
         2pIindGfcIhgS8XCYFTKhsqqN5wJwSPlJEbGfiTQOJ2fr0OI9nBwpHz9KNF4c4QZfMYH
         1imRxckHe24zPJoQfARJnpU3RhMO+dr1NG35zgb/SwU0IahY+x1Gdzd60NEOPYSKZ5Il
         VTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6tj+7sNHNnTbkzs8ZeKL5miL5fHgtHHC3d2WQTSFbE=;
        b=G7sFD6WcoZYLY4bSYnCxyEgJSeaNwh/A6UFExLOGoKxv/h9jzW304/5m+2EgCdk7K9
         v5IbYvmjIEMrEtvyikWiGpY+Cp7lLkC2UOFmz6geW97R2Wjb5yrUGs7+gdcnWg+CVHpT
         HpEE0xcjdDeH3ruUtq3wBeW4xCXXb4hV6+PM7pIUlIvq+3ENX3ya6knUfFkdTzzIQHjk
         h6eueKnNSpDkJlLOdrQsThI1AGYBNfPgeBCTGwwAK/A/BVmNamNy7jSwFiTdnrBSRPHc
         Kam1LlO41iW4Fk/0UNQHFVlSfEt9oKFF1bz0/0FlnCrKz9IyhbdmDzWzCxiP3fTUZ98Z
         B96w==
X-Gm-Message-State: ACrzQf1TFq+LD0qnCaaQbOK4cz2O5/HL/RweDbXbNEWZLOMjfvmfv62J
        dpWb3B8GzkOb1Oxdnq8QOvNh4SyJ9BFMmho9
X-Google-Smtp-Source: AMsMyM7D3GBwOzz5QAuoLmf+oB2TmG0p9ILQukZoZQKCpczeNQrlwRKtrJtUrLcSObIcUbD2rOZ3WQ==
X-Received: by 2002:a5d:5410:0:b0:236:fe1:bb74 with SMTP id g16-20020a5d5410000000b002360fe1bb74mr15694845wrv.512.1667405660181;
        Wed, 02 Nov 2022 09:14:20 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b4d7:0:6a08:9b26:ab04:7065])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d56d1000000b0022cc6b8df5esm13230923wrw.7.2022.11.02.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:14:19 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux@armlinux.org.uk,
        yezengruan@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        maz@kernel.org, steven.price@arm.com, mark.rutland@arm.com
Cc:     fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [RFC 2/6] KVM: arm64: Add SMCCC paravirtualised lock calls
Date:   Wed,  2 Nov 2022 16:13:36 +0000
Message-Id: <20221102161340.2982090-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102161340.2982090-1-usama.arif@bytedance.com>
References: <20221102161340.2982090-1-usama.arif@bytedance.com>
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

Add two new SMCCC compatible hypercalls for PV lock features:
  PV_LOCK_FEATURES:   0xC6000020
  PV_LOCK_PREEMPTED:  0xC6000021

Also add the header file which defines the ABI for the paravirtualized
lock features we're about to add.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/arm64/include/asm/pvlock-abi.h | 17 +++++++++++++++++
 include/linux/arm-smccc.h           | 13 +++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/include/asm/pvlock-abi.h

diff --git a/arch/arm64/include/asm/pvlock-abi.h b/arch/arm64/include/asm/pvlock-abi.h
new file mode 100644
index 000000000000..3f4574071679
--- /dev/null
+++ b/arch/arm64/include/asm/pvlock-abi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2019 Huawei Technologies Co., Ltd
+ * Author: Zengruan Ye <yezengruan@huawei.com>
+ *         Usama Arif <usama.arif@bytedance.com>
+ */
+
+#ifndef __ASM_PVLOCK_ABI_H
+#define __ASM_PVLOCK_ABI_H
+
+struct pvlock_vcpu_state {
+	__le64 preempted;
+	/* Structure must be 64 byte aligned, pad to that size */
+	u8 padding[56];
+} __packed;
+
+#endif
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..6360333e0f64 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -151,6 +151,19 @@
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+/* Paravirtualised lock calls */
+#define ARM_SMCCC_HV_PV_LOCK_FEATURES				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,		\
+			   0x20)
+
+#define ARM_SMCCC_HV_PV_LOCK_PREEMPTED				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,		\
+			   0x21)
+
 /* TRNG entropy source calls (defined by ARM DEN0098) */
 #define ARM_SMCCC_TRNG_VERSION					\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
-- 
2.25.1

