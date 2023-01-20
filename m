Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C83675515
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjATM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:57:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F95FFF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:57:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so5788469wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoV8ostgSDbK08VdIZJMHvJGHyPcf5FjWF2t6GC4OEg=;
        b=I+2h2nB4eC17X95+rn5I4LjsNEODeuLd/RstVgSYO9B2D0iPkpnYaJvdIdryMAT1EO
         CU5FIeSMPKBW9fVMRpzL+IOLy9wCpHpyqT4JWPVxeEjGfO0IEBspkhA5UJcsPP05Ntfd
         rV1LO9WfmcPB8z+8of3kfcC8Qiqk1770+UjG/QY6zRB2aDJBcReLfNOHefGUoqPO7Iga
         VaFSdp2S5tlSKZZztCPhgRwp05yXyUkVmqmkuU65yyVBXnHQ6N2P6ho/wHUBV0YYv5vP
         JfWl3INAMhagIgOCA+Qjd+eSHo1Yo9YWD238XpPKHtNWXfy5o3JbPFOvjW1b+h7nds4G
         mMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoV8ostgSDbK08VdIZJMHvJGHyPcf5FjWF2t6GC4OEg=;
        b=BUZ5qDHLVl+nD+fWHfhJ9lo1RmmF+zInie999EPCv0dLtieSkpHBwDSHCIVvEnSjyB
         8VH78dihdWvLSrkBnFA3aKk+fuiHZus7AL1g97WuOMWAG7r6muer5ByEXSWJsxBk9DIF
         BN3c+YZt5Uk0e+59+Di3GO0bLJ802PMkmitFz5AFOm/PXeSIbxW51fFJ/6p4z7FnHT9o
         /QjBS5AetbN2K63RsqrlKevbqNsKrAFJ8FZmSGsZ1t42flA2RtiZaW68eh0dnmBnUUbT
         WtTfn4Lcugryc3WE0dORc8lqN8jh63Wv85WH8pV5qpMf15AQKWa9y+t4gNYIk2IWNuP1
         2XbA==
X-Gm-Message-State: AFqh2koy4NZp5IQQIWdQyHqhIzNEXn39W2e4NI2foyuvrSxeqR/kkWXB
        bJmF8MetRR/NdAqBQwrWENkhhw==
X-Google-Smtp-Source: AMrXdXvkIjdx5y0alBmce8ylnRgIDUjnzn/rTeXMSskipMsEgmlz4JbfeRubh4n53lBnOQIWrz2B4Q==
X-Received: by 2002:a05:600c:1d22:b0:3da:f66c:795d with SMTP id l34-20020a05600c1d2200b003daf66c795dmr14361504wms.9.1674219446983;
        Fri, 20 Jan 2023 04:57:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003d35acb0fd7sm2229002wmb.34.2023.01.20.04.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:57:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: drop redundant "ARMv8" from Kconfig option title
Date:   Fri, 20 Jan 2023 13:57:22 +0100
Message-Id: <20230120125722.270722-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these platforms are ARMv8 or newer and choosing the platforms in
menuconfig is much easier if the titles start with something specific.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/Kconfig.platforms | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1970adf80ab..165e544aa7f9 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -95,7 +95,7 @@ config ARCH_BITMAIN
 	  This enables support for the Bitmain SoC Family.
 
 config ARCH_EXYNOS
-	bool "ARMv8 based Samsung Exynos SoC family"
+	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
 	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
@@ -108,7 +108,7 @@ config ARCH_EXYNOS
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
 config ARCH_SPARX5
-	bool "ARMv8 based Microchip Sparx5 SoC family"
+	bool "Microchip Sparx5 SoC family"
 	select PINCTRL
 	select DW_APB_TIMER_OF
 	help
@@ -199,13 +199,13 @@ menuconfig ARCH_NXP
 if ARCH_NXP
 
 config ARCH_LAYERSCAPE
-	bool "ARMv8 based Freescale Layerscape SoC family"
+	bool "Freescale Layerscape SoC family"
 	select EDAC_SUPPORT
 	help
 	  This enables support for the Freescale Layerscape SoC family.
 
 config ARCH_MXC
-	bool "ARMv8 based NXP i.MX SoC family"
+	bool "NXP i.MX SoC family"
 	select ARM64_ERRATUM_843419
 	select ARM64_ERRATUM_845719 if COMPAT
 	select IMX_GPCV2
@@ -296,7 +296,7 @@ config ARCH_TEGRA
 	  This enables support for the NVIDIA Tegra SoC family.
 
 config ARCH_TESLA_FSD
-	bool "ARMv8 based Tesla platform"
+	bool "Tesla platform"
 	depends on ARCH_EXYNOS
 	help
 	  Support for ARMv8 based Tesla platforms.
-- 
2.34.1

