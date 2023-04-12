Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C66DF392
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjDLL3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjDLL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611898694;
        Wed, 12 Apr 2023 04:28:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 992EB660328C;
        Wed, 12 Apr 2023 12:28:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298890;
        bh=udYJL7+D0nU6SsvUw/ySN6/rdg1po5P1pPwUOP6NJ6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRVBOn4mP7A1tf5caIZVGKmwr24CaJNDm/AbiTnyf7L9hCauZ+fKHDnUCvpnlh2Gu
         hCLw6+5k9fn1t0edotlNf/dR1l6epND/bmS641hTNUfYEPSt2dgZoDLcmHxL1UE1Vr
         naKfvmShNyWBfXVB5qx2KZXnCOUqNcZ3VwTWYaSb8ig7dvXi/CBcw5HfmqJLg6HIWU
         qSFlSsB5xi4n+GdRG3N6WFbdYgA63kBtxZ85d5V97ynMiZ04EK2HkDhncPjrxM2gg9
         GhM2i8GMulrF35oLSgxcJxz62pQNvA0zZ6uGfgbuyMBhw+06Eyiz3Q7lEQP+u1cQQt
         bjjb7seRYMYkg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 18/27] arm64: dts: mediatek: mt6795: Add support for IOMMU and LARBs
Date:   Wed, 12 Apr 2023 13:27:30 +0200
Message-Id: <20230412112739.160376-19-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the multimedia IOMMU and its LARBs: this includes all but
the MJC LARB, which cannot currently be used and will be added later.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index a8b2c4517e79..9cfa02085f61 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mediatek,mt6795-clk.h>
 #include <dt-bindings/gce/mediatek,mt6795-gce.h>
+#include <dt-bindings/memory/mt6795-larb-port.h>
 #include <dt-bindings/pinctrl/mt6795-pinfunc.h>
 #include <dt-bindings/power/mt6795-power.h>
 #include <dt-bindings/reset/mediatek,mt6795-resets.h>
@@ -390,6 +391,17 @@ systimer: timer@10200670 {
 			clock-names = "clk13m";
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt6795-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_M4U>;
+			clock-names = "bclk";
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0 &larb1 &larb2 &larb3>;
+			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
+			#iommu-cells = <1>;
+		};
+
 		apmixedsys: syscon@10209000 {
 			compatible = "mediatek,mt6795-apmixedsys", "syscon";
 			reg = <0 0x10209000 0 0x1000>;
@@ -648,16 +660,64 @@ mmsys: syscon@14000000 {
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
 		};
 
+		larb0: larb@14021000 {
+			compatible = "mediatek,mt6795-smi-larb";
+			reg = <0 0x14021000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&mmsys CLK_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+			mediatek,smi = <&smi_common>;
+			mediatek,larb-id = <0>;
+			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
+		};
+
+		smi_common: smi@14022000 {
+			compatible = "mediatek,mt6795-smi-common";
+			reg = <0 0x14022000 0 0x1000>;
+			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
+			clocks = <&infracfg CLK_INFRA_SMI>, <&mmsys CLK_MM_SMI_COMMON>;
+			clock-names = "apb", "smi";
+		};
+
+		larb2: larb@15001000 {
+			compatible = "mediatek,mt6795-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&infracfg CLK_INFRA_SMI>;
+			clock-names = "apb", "smi";
+			mediatek,smi = <&smi_common>;
+			mediatek,larb-id = <2>;
+			power-domains = <&spm MT6795_POWER_DOMAIN_ISP>;
+		};
+
 		vdecsys: clock-controller@16000000 {
 			compatible = "mediatek,mt6795-vdecsys";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb1: larb@16010000 {
+			compatible = "mediatek,mt6795-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			mediatek,larb-id = <1>;
+			clocks = <&vdecsys CLK_VDEC_CKEN>, <&vdecsys CLK_VDEC_LARB_CKEN>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT6795_POWER_DOMAIN_VDEC>;
+		};
+
 		vencsys: clock-controller@18000000 {
 			compatible = "mediatek,mt6795-vencsys";
 			reg = <0 0x18000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb3: larb@18001000 {
+			compatible = "mediatek,mt6795-smi-larb";
+			reg = <0 0x18001000 0 0x1000>;
+			clocks = <&vencsys CLK_VENC_VENC>, <&vencsys CLK_VENC_LARB>;
+			clock-names = "apb", "smi";
+			mediatek,smi = <&smi_common>;
+			mediatek,larb-id = <3>;
+			power-domains = <&spm MT6795_POWER_DOMAIN_VENC>;
+		};
 	};
 };
-- 
2.40.0

