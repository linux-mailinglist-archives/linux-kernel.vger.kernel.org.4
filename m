Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC267E354
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjA0Law (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjA0L37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7479E7AE40
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:29:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649FC1692;
        Fri, 27 Jan 2023 03:29:29 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265293F64C;
        Fri, 27 Jan 2023 03:28:45 -0800 (PST)
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
Subject: [RFC PATCH 14/14] HACK: Accept prototype RSI version
Date:   Fri, 27 Jan 2023 11:27:58 +0000
Message-Id: <20230127112758.37891-15-steven.price@arm.com>
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

The upstream RMM currently advertises the major version of an internal
prototype (v12.0) rather than the expected version from the RMM
architecture specification (v1.0).

Add a config option to enable support for the prototype RSI v12.0.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/rsi_smc.h | 2 ++
 arch/arm64/kernel/rsi.c          | 5 +++++
 arch/arm64/kvm/Kconfig           | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index bc0cdd83f164..baf07f905353 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -29,6 +29,8 @@
 #define RSI_ABI_VERSION			((RSI_ABI_VERSION_MAJOR << 16) | \
 					 RSI_ABI_VERSION_MINOR)
 
+#define RSI_LEGACY_ABI_VERSION		0xc0000
+
 #define RSI_ABI_VERSION_GET_MAJOR(_version) ((_version) >> 16)
 #define RSI_ABI_VERSION_GET_MINOR(_version) ((_version) & 0xFFFF)
 
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 1cc292826f2b..45b26f23e706 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -41,6 +41,11 @@ static bool rsi_version_matches(void)
 		RSI_ABI_VERSION_GET_MAJOR(ver),
 		RSI_ABI_VERSION_GET_MINOR(ver));
 
+#ifdef CONFIG_RME_USE_PROTOTYPE_HACKS
+	if (ver == RSI_LEGACY_ABI_VERSION)
+		return true;
+#endif
+
 	return (ver >= RSI_ABI_VERSION &&
 		RSI_ABI_VERSION_GET_MAJOR(ver) == RSI_ABI_VERSION_MAJOR);
 }
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 05da3c8f7e88..13858a5047fd 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -58,6 +58,14 @@ config NVHE_EL2_DEBUG
 
 	  If unsure, say N.
 
+config RME_USE_PROTOTYPE_HACKS
+	bool "Allow RMM prototype version numbers"
+	default y
+	help
+	  For compatibility with the the current RMM code allow versions
+	  numbers from a prototype implementation as well as the expected
+	  version number from the RMM specification.
+
 config PROTECTED_NVHE_STACKTRACE
 	bool "Protected KVM hypervisor stacktraces"
 	depends on NVHE_EL2_DEBUG
-- 
2.34.1

