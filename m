Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB26E7422
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjDSHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjDSHit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:38:49 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AAC3AB8;
        Wed, 19 Apr 2023 00:38:45 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 19 Apr 2023
 15:39:58 +0800
From:   =Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Date:   Wed, 19 Apr 2023 15:38:33 +0800
Message-ID: <20230419073834.972273-2-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

The C series SoCs are designed for smart IP camera
applications, which does not belong to Meson series.
So, Add ARCH_AMLIPC for the new series.

There are now multiple amlogic SoC seies supported, so group them under
their own menu. we can easily add new platforms there in the future.
Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.

No functional changes introduced.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 arch/arm64/configs/defconfig |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..bfbc817eef8f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -162,12 +162,24 @@ config ARCH_MEDIATEK
 	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
 	  & MT81xx ARMv8 SoCs
 
+menuconfig ARCH_AMLOGIC
+	bool "NXP SoC support"
+
+if ARCH_AMLOGIC
+
 config ARCH_MESON
 	bool "Amlogic Platforms"
 	help
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+config ARCH_AMLIPC
+	bool "Amlogic IPC Platforms"
+	help
+	  This enables support for the arm64 based Amlogic IPC SoCs
+	  such as the C302X, C308L
+endif
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..f231bd1723fd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -46,7 +46,9 @@ CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_KEEMBAY=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_AMLOGIC=y
 CONFIG_ARCH_MESON=y
+CONFIG_ARCH_AMLIPC=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_NXP=y
 CONFIG_ARCH_LAYERSCAPE=y
-- 
2.37.1

