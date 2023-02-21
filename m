Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6499C69D7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjBUBaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBUBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:30:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC018212BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:30:05 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PLM6K2Kx0zJrDg;
        Tue, 21 Feb 2023 09:25:13 +0800 (CST)
Received: from huawei.com (10.67.175.33) by kwepemi500026.china.huawei.com
 (7.221.188.247) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 21 Feb
 2023 09:30:02 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <kristina.martsenko@arm.com>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <maz@kernel.org>, <linyujun809@huawei.com>,
        <ardb@kernel.org>, <samitolvanen@google.com>,
        <andreyknvl@gmail.com>, <masahiroy@kernel.org>,
        <joey.gouly@arm.com>, <anshuman.khandual@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH -next] arm64: Optimize the comparison of unsigned expressions to avoid compiling error
Date:   Tue, 21 Feb 2023 09:27:40 +0800
Message-ID: <20230221012740.2929481-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while compile arch/arm64/include/asm/cpufeature.h with
-Werror=type-limits enabled, errors shown as below:

./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_4kb_granule':
./arch/arm64/include/asm/cpufeature.h:653:14: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
  return (val >= ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN) &&
              ^~
./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_64kb_granule':
./arch/arm64/include/asm/cpufeature.h:666:14: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
  return (val >= ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN) &&
              ^~
Modify the return judgment statement, use
"((val - min) < (val - max - 1))" to confirm that returns
true in “min <= val <= max” cases, false in other cases.

Fixes: 79d82cbcbb3d ("arm64/kexec: Test page size support with new TGRAN range values")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 03d1c9d7af82..0a6bda025141 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -54,6 +54,9 @@ enum ftr_type {
 #define FTR_VISIBLE_IF_IS_ENABLED(config)		\
 	(IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
 
+#define IN_RANGE_INCLUSIVE(val, min, max)		\
+	(((val) - (min)) < ((val) - (max) - 1))
+
 struct arm64_ftr_bits {
 	bool		sign;	/* Value is signed ? */
 	bool		visible;
@@ -693,8 +696,9 @@ static inline bool system_supports_4kb_granule(void)
 	val = cpuid_feature_extract_unsigned_field(mmfr0,
 						ID_AA64MMFR0_EL1_TGRAN4_SHIFT);
 
-	return (val >= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN) &&
-	       (val <= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
+	return IN_RANGE_INCLUSIVE(val,
+		ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN,
+		ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
 }
 
 static inline bool system_supports_64kb_granule(void)
@@ -706,8 +710,9 @@ static inline bool system_supports_64kb_granule(void)
 	val = cpuid_feature_extract_unsigned_field(mmfr0,
 						ID_AA64MMFR0_EL1_TGRAN64_SHIFT);
 
-	return (val >= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN) &&
-	       (val <= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
+	return IN_RANGE_INCLUSIVE(val,
+		ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN,
+		ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
 }
 
 static inline bool system_supports_16kb_granule(void)
@@ -719,8 +724,9 @@ static inline bool system_supports_16kb_granule(void)
 	val = cpuid_feature_extract_unsigned_field(mmfr0,
 						ID_AA64MMFR0_EL1_TGRAN16_SHIFT);
 
-	return (val >= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN) &&
-	       (val <= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
+	return IN_RANGE_INCLUSIVE(val,
+		ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN,
+		ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
 }
 
 static inline bool system_supports_mixed_endian_el0(void)
-- 
2.34.1

