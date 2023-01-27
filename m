Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1570367E346
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjA0L3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjA0L3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84D4772640
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:28:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF7481595;
        Fri, 27 Jan 2023 03:28:58 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DEBC3F64C;
        Fri, 27 Jan 2023 03:28:14 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev
Subject: [RFC PATCH 02/14] arm64: rsi: Add RSI definitions
Date:   Fri, 27 Jan 2023 11:27:46 +0000
Message-Id: <20230127112758.37891-3-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127112758.37891-1-steven.price@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127112758.37891-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The RMM (Realm Management Monitor) provides functionality that can be
accessed by a realm guest through SMC (Realm Services Interface) calls.

The SMC definitions are based on DEN0137[1] version A-bet0.

[1] https://developer.arm.com/documentation/den0137/latest

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/rsi_cmds.h |  57 +++++++++++++
 arch/arm64/include/asm/rsi_smc.h  | 130 ++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 arch/arm64/include/asm/rsi_cmds.h
 create mode 100644 arch/arm64/include/asm/rsi_smc.h

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
new file mode 100644
index 000000000000..a0b3c1bd786a
--- /dev/null
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#ifndef __ASM_RSI_CMDS_H
+#define __ASM_RSI_CMDS_H
+
+#include <linux/arm-smccc.h>
+
+#include <asm/rsi_smc.h>
+
+enum ripas {
+	RSI_RIPAS_EMPTY,
+	RSI_RIPAS_RAM,
+};
+
+static inline unsigned long rsi_get_version(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_RSI_ABI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long invoke_rsi_fn_smc(unsigned long function_id,
+					      unsigned long arg0,
+					      unsigned long arg1,
+					      unsigned long arg2,
+					      unsigned long arg3)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, 0, 0, 0, &res);
+	return res.a0;
+}
+
+static inline void invoke_rsi_fn_smc_with_res(unsigned long function_id,
+					      unsigned long arg0,
+					      unsigned long arg1,
+					      unsigned long arg2,
+					      unsigned long arg3,
+					      struct arm_smccc_res *res)
+{
+	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, 0, 0, 0, res);
+}
+
+static inline unsigned long rsi_set_addr_range_state(phys_addr_t start,
+						     phys_addr_t end,
+						     enum ripas state)
+{
+	return invoke_rsi_fn_smc(SMC_RSI_IPA_STATE_SET,
+				 start, (end - start), state, 0);
+}
+
+#endif
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
new file mode 100644
index 000000000000..bc0cdd83f164
--- /dev/null
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#ifndef __SMC_RSI_H_
+#define __SMC_RSI_H_
+
+/*
+ * This file describes the Realm Services Interface (RSI) Application Binary
+ * Interface (ABI) for SMC calls made from within the Realm to the RMM and
+ * serviced by the RMM.
+ */
+
+#define SMC_RSI_CALL_BASE		0xC4000000
+
+/*
+ * The major version number of the RSI implementation.  Increase this whenever
+ * the binary format or semantics of the SMC calls change.
+ */
+#define RSI_ABI_VERSION_MAJOR		1
+
+/*
+ * The minor version number of the RSI implementation.  Increase this when
+ * a bug is fixed, or a feature is added without breaking binary compatibility.
+ */
+#define RSI_ABI_VERSION_MINOR		0
+
+#define RSI_ABI_VERSION			((RSI_ABI_VERSION_MAJOR << 16) | \
+					 RSI_ABI_VERSION_MINOR)
+
+#define RSI_ABI_VERSION_GET_MAJOR(_version) ((_version) >> 16)
+#define RSI_ABI_VERSION_GET_MINOR(_version) ((_version) & 0xFFFF)
+
+#define RSI_SUCCESS			0
+#define RSI_ERROR_INPUT			1
+#define RSI_ERROR_STATE			2
+#define RSI_INCOMPLETE			3
+
+#define SMC_RSI_FID(_x)			(SMC_RSI_CALL_BASE + (_x))
+
+#define SMC_RSI_ABI_VERSION			SMC_RSI_FID(0x190)
+
+/*
+ * arg1 == The IPA of token buffer
+ * arg2 == Challenge value, bytes:  0 -  7
+ * arg3 == Challenge value, bytes:  7 - 15
+ * arg4 == Challenge value, bytes: 16 - 23
+ * arg5 == Challenge value, bytes: 24 - 31
+ * arg6 == Challenge value, bytes: 32 - 39
+ * arg7 == Challenge value, bytes: 40 - 47
+ * arg8 == Challenge value, bytes: 48 - 55
+ * arg9 == Challenge value, bytes: 56 - 63
+ * ret0 == Status / error
+ */
+#define SMC_RSI_ATTESTATION_TOKEN_INIT		SMC_RSI_FID(0x194)
+
+/*
+ * arg1 == The IPA of token buffer
+ * ret0 == Status / error
+ * ret1 == Size of completed token in bytes
+ */
+#define SMC_RSI_ATTESTATION_TOKEN_CONTINUE	SMC_RSI_FID(0x195)
+
+/*
+ * arg1  == Index, which measurements slot to extend
+ * arg2  == Size of realm measurement in bytes, max 64 bytes
+ * arg3  == Measurement value, bytes:  0 -  7
+ * arg4  == Measurement value, bytes:  7 - 15
+ * arg5  == Measurement value, bytes: 16 - 23
+ * arg6  == Measurement value, bytes: 24 - 31
+ * arg7  == Measurement value, bytes: 32 - 39
+ * arg8  == Measurement value, bytes: 40 - 47
+ * arg9  == Measurement value, bytes: 48 - 55
+ * arg10 == Measurement value, bytes: 56 - 63
+ * ret0  == Status / error
+ */
+#define SMC_RSI_MEASUREMENT_EXTEND		SMC_RSI_FID(0x193)
+
+/*
+ * arg1 == Index, which measurements slot to read
+ * ret0 == Status / error
+ * ret1 == Measurement value, bytes:  0 -  7
+ * ret2 == Measurement value, bytes:  7 - 15
+ * ret3 == Measurement value, bytes: 16 - 23
+ * ret4 == Measurement value, bytes: 24 - 31
+ * ret5 == Measurement value, bytes: 32 - 39
+ * ret6 == Measurement value, bytes: 40 - 47
+ * ret7 == Measurement value, bytes: 48 - 55
+ * ret8 == Measurement value, bytes: 56 - 63
+ */
+#define SMC_RSI_MEASUREMENT_READ		SMC_RSI_FID(0x192)
+
+#ifndef __ASSEMBLY__
+
+struct realm_config {
+	unsigned long ipa_bits; /* Width of IPA in bits */
+};
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * arg1 == struct realm_config addr
+ * ret0 == Status / error
+ */
+#define SMC_RSI_REALM_CONFIG			SMC_RSI_FID(0x196)
+
+/*
+ * arg1 == IPA address of target region
+ * arg2 == size of target region in bytes
+ * arg3 == RIPAS value
+ * ret0 == Status / error
+ * ret1 == Top of modified IPA range
+ */
+#define SMC_RSI_IPA_STATE_SET			SMC_RSI_FID(0x197)
+
+/*
+ * arg1 == IPA of target page
+ * ret0 == Status / error
+ * ret1 == RIPAS value
+ */
+#define SMC_RSI_IPA_STATE_GET			SMC_RSI_FID(0x198)
+
+/*
+ * arg1 == IPA of host call structure
+ * ret0 == Status / error
+ */
+#define SMC_RSI_HOST_CALL			SMC_RSI_FID(0x199)
+
+#endif /* __SMC_RSI_H_ */
-- 
2.34.1

