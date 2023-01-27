Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7B67E34B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjA0LaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjA0L3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8924D234E5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:28:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B031576;
        Fri, 27 Jan 2023 03:29:04 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1EC93F64C;
        Fri, 27 Jan 2023 03:28:19 -0800 (PST)
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
Subject: [RFC PATCH 04/14] arm64: realm: Query IPA size from the RMM
Date:   Fri, 27 Jan 2023 11:27:48 +0000
Message-Id: <20230127112758.37891-5-steven.price@arm.com>
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

The top bit of the configured IPA size is used as an attribute to
control whether the address is protected or shared. Query the
configuration from the RMM to assertain which bit this is.

Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 2 ++
 arch/arm64/include/asm/rsi_cmds.h     | 8 ++++++++
 arch/arm64/kernel/rsi.c               | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9b165117a454..3f24080d6cc9 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -33,7 +33,9 @@
 #include <asm/pgtable-types.h>
 
 extern bool arm64_use_ng_mappings;
+extern unsigned long prot_ns_shared;
 
+#define PROT_NS_SHARED		((prot_ns_shared))
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index ee0df00efd87..e13f702de6c2 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -46,6 +46,14 @@ static inline void invoke_rsi_fn_smc_with_res(unsigned long function_id,
 	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, 0, 0, 0, res);
 }
 
+static inline unsigned long rsi_get_realm_config(struct realm_config *cfg)
+{
+	struct arm_smccc_res res;
+
+	invoke_rsi_fn_smc_with_res(SMC_RSI_REALM_CONFIG, virt_to_phys(cfg), 0, 0, 0, &res);
+	return res.a0;
+}
+
 static inline unsigned long rsi_set_addr_range_state(phys_addr_t start,
 						     phys_addr_t end,
 						     enum ripas state,
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index b354ac661c9d..9c63ee1c6979 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -7,6 +7,11 @@
 #include <linux/memblock.h>
 #include <asm/rsi.h>
 
+struct realm_config __attribute((aligned(PAGE_SIZE))) config;
+
+unsigned long prot_ns_shared;
+EXPORT_SYMBOL(prot_ns_shared);
+
 DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
 
 static bool rsi_version_matches(void)
@@ -45,6 +50,9 @@ void __init arm64_rsi_init(void)
 {
 	if (!rsi_version_matches())
 		return;
+	if (rsi_get_realm_config(&config))
+		return;
+	prot_ns_shared = BIT(config.ipa_bits - 1);
 
 	static_branch_enable(&rsi_present);
 }
-- 
2.34.1

