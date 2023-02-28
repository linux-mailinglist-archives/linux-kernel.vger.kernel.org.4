Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBDB6A571F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjB1Ksx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjB1KsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:48:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A102885F;
        Tue, 28 Feb 2023 02:47:59 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 065186602FDE;
        Tue, 28 Feb 2023 10:47:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677581278;
        bh=smKRDmDdu68lnpbPgqG4z/RTkzBSVrXMEAsrpvTEOiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ar5wQuJ/4XMRO/fhjH1erUDGVxa2IrETJPY3HYhhDkbOnhBN49QpB+RSCUpUm98je
         Q+BV1ivVx6kqXx0wLmg8mmMOSczH3bJvWN0rC7Oh1cnvgvLdB/+ErTkRxlZxgzNEO7
         +6xFd570rLl1/a4f7Adtx+49khPcOLZMYPMFKIohalxbMFBPmR63g++cMg+MCU4tXv
         kaAnEtO3YCbMh4VdX6cTfIoGULFgNjj2TfBUtHArpxkuWtIGrx6AfDu88xcSQIO6tb
         UXOwEArS1zdQ5wbUwPYx4UfqIQsEdV2YKIKKLRFABBr7/nXntCkTxVDKzCvYSSnF7y
         4pstYL5APJD9Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v3 14/18] arm64: dts: mt8195: Add panfrost node for Mali-G57 Valhall Natt GPU
Date:   Tue, 28 Feb 2023 11:47:37 +0100
Message-Id: <20230228104741.717819-15-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPU support through panfrost for the Mali-G57 GPU on MT8195
with its OPP table but keep it in disabled state.

This is expected to be enabled only on boards which make use of
the GPU.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 90 ++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d116830d6af3..0e4ee7713c30 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -333,6 +333,76 @@ performance: performance-controller@11bc10 {
 		#performance-domain-cells = <1>;
 	};
 
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-390000000 {
+			opp-hz = /bits/ 64 <390000000>;
+			opp-microvolt = <625000>;
+		};
+		opp-410000000 {
+			opp-hz = /bits/ 64 <410000000>;
+			opp-microvolt = <631250>;
+		};
+		opp-431000000 {
+			opp-hz = /bits/ 64 <431000000>;
+			opp-microvolt = <631250>;
+		};
+		opp-473000000 {
+			opp-hz = /bits/ 64 <473000000>;
+			opp-microvolt = <637500>;
+		};
+		opp-515000000 {
+			opp-hz = /bits/ 64 <515000000>;
+			opp-microvolt = <637500>;
+		};
+		opp-556000000 {
+			opp-hz = /bits/ 64 <556000000>;
+			opp-microvolt = <643750>;
+		};
+		opp-598000000 {
+			opp-hz = /bits/ 64 <598000000>;
+			opp-microvolt = <650000>;
+		};
+		opp-640000000 {
+			opp-hz = /bits/ 64 <640000000>;
+			opp-microvolt = <650000>;
+		};
+		opp-670000000 {
+			opp-hz = /bits/ 64 <670000000>;
+			opp-microvolt = <662500>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <675000>;
+		};
+		opp-730000000 {
+			opp-hz = /bits/ 64 <730000000>;
+			opp-microvolt = <687500>;
+		};
+		opp-760000000 {
+			opp-hz = /bits/ 64 <760000000>;
+			opp-microvolt = <700000>;
+		};
+		opp-790000000 {
+			opp-hz = /bits/ 64 <790000000>;
+			opp-microvolt = <712500>;
+		};
+		opp-820000000 {
+			opp-hz = /bits/ 64 <820000000>;
+			opp-microvolt = <725000>;
+		};
+		opp-850000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			opp-microvolt = <737500>;
+		};
+		opp-880000000 {
+			opp-hz = /bits/ 64 <880000000>;
+			opp-microvolt = <750000>;
+		};
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupt-parent = <&gic>;
@@ -1790,6 +1860,26 @@ ufsphy: ufs-phy@11fa0000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@13000000 {
+			compatible = "mediatek,mt8195-mali", "mediatek,mt8192-mali",
+				     "arm,mali-valhall-jm";
+			reg = <0 0x13000000 0 0x4000>;
+
+			clocks = <&mfgcfg CLK_MFG_BG3D>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "job", "mmu", "gpu";
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_MFG2>,
+					<&spm MT8195_POWER_DOMAIN_MFG3>,
+					<&spm MT8195_POWER_DOMAIN_MFG4>,
+					<&spm MT8195_POWER_DOMAIN_MFG5>,
+					<&spm MT8195_POWER_DOMAIN_MFG6>;
+			power-domain-names = "core0", "core1", "core2", "core3", "core4";
+			status = "disabled";
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt8195-mfgcfg";
 			reg = <0 0x13fbf000 0 0x1000>;
-- 
2.39.2

