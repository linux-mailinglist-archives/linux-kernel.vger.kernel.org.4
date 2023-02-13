Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787B694BED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBMQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjBMQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:01:04 -0500
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFE6170B;
        Mon, 13 Feb 2023 08:00:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBEF3BFBAC;
        Mon, 13 Feb 2023 17:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676304051; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=64grUIMOl3DlMA5X19kZ/0poE7psMX9YME1d/5PcVes=;
        b=L1VOGI7OPRvZoeEBiIL1YvtAeloc7cXo3N7YfGaR5Hi1zjjfZ5jesKbiFzSvYqAhnI9AZF
        5OSEmWIZIcsKIWFFN1UTBEljQoqM3M9ZjYKXJTZu8ycyPP/T0eusqmZKlgyWhMVdos9mwR
        fE20FwWJbTN6Ez+EuVTv2B5PcQuHrgdQVCaWncDr6laHOVhuIT0B/UcFZa2qdvp/KupjFm
        Qqcdwu+SFZDcrbZwnyl4oHCjvhMzQ1tm++X+d+hm01mV/d8Qcc0An/a2Ua9m7jkCZDR8W0
        mbch8+RupRbo5WEChlWVcAwnBvBRaMVywoVog+751zcBgsztjq5hR2bBeTPk8g==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal
Date:   Mon, 13 Feb 2023 16:58:24 +0100
Message-Id: <20230213155833.1644366-7-frieder@fris.de>
In-Reply-To: <20230213155833.1644366-1-frieder@fris.de>
References: <20230213155833.1644366-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This fixes the LDO5 regulator handling of the pca9450 driver by
taking the status of the SD_VSEL into account to determine which
configuration register is used for the voltage setting.

Even without this change there is no functional issue, as the code
for switching the voltage in sdhci.c currently switches both, the
VSELECT/SD_VSEL signal and the regulator voltage at the same time
and doesn't run into an invalid corner case.

We should still make sure, that we always use the correct register
when controlling the regulator. At least in U-Boot this fixes an
actual bug where the wrong IO voltage is used.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts       | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   | 1 +
 arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi      | 1 +
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 8b16bd68576c..bdcd9cd843c7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -344,7 +344,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
 		>;
 	};
 
@@ -357,7 +357,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
 		>;
 	};
 
@@ -370,7 +370,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index a079322a3793..ba2a4491cf31 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -321,7 +321,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
 		>;
 	};
 
@@ -334,7 +334,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
 		>;
 	};
 
@@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 5172883717d1..90daaf54e704 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
 				regulator-name = "NVCC_SD (LDO5)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 1f8326613ee9..7468a8aa771d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -195,6 +195,7 @@ reg_nvcc_sd: LDO5 {
 				regulator-name = "NVCC_SD (LDO5)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			};
 		};
 	};
-- 
2.39.1

