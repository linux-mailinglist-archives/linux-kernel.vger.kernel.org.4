Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB46A0C43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjBWOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjBWOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:54:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF83853295;
        Thu, 23 Feb 2023 06:54:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2AAD56602217;
        Thu, 23 Feb 2023 14:54:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677164075;
        bh=r1iG8jDPuaedm/CyEheNxI1t1kS8LDRLHJXYGo1C1oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2Qw7uaKoarbfSpT2X7FiJ21QT6UUJdak/MAff4DhFgjRfqWMPOuJKVz1InWreYDT
         Qky9OzsU22SRt/iWayRt0EOgnFd72XXq82HfSQkNlpLwEFC7kxietNn10TZwjypv6P
         PlCZFHQ0DkUd1dNgfNsv1PAcEX5OX1G5woVvW3YVGIsWlDWwO626OFxN12x35rkd7+
         XCE+AxIswCRNKi5SqhNXybHS1pSUU32G/I24hni3fJ2a93OMM46AeSqMzU6KGViHrQ
         K/aidOSGZGq9PAURMbcWacrhkzZpEQ4ZZt3WAfYaBRQAXbhfrizbgggNTn1Xwu16B1
         NaQda17tZO68Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 2/4] arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi
Date:   Thu, 23 Feb 2023 15:54:24 +0100
Message-Id: <20230223145426.193590-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
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

On the Cherry platform, a MT7621 WiFi+Bluetooth combo is connected
over PCI-Express (for WiFi) and USB (for BT): enable the PCIe ports
to enable enumerating this chip.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  7 ++++++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 2d5e8f371b6d..11fc83ddf236 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -20,6 +20,13 @@ &sound {
 	model = "mt8195_r1019_5682";
 };
 
+&pcie0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+};
+
 &ts_10 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index ae2052a7160d..d679a04207d8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -553,6 +553,13 @@ flash@0 {
 	};
 };
 
+&pcie1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins_default>;
+};
+
 &pio {
 	mediatek,rsel-resistance-in-si-unit;
 	pinctrl-names = "default";
@@ -934,6 +941,24 @@ pins-cs {
 		};
 	};
 
+	pcie0_pins_default: pcie0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
+				 <PINMUX_GPIO20__FUNC_PERSTN>,
+				 <PINMUX_GPIO21__FUNC_CLKREQN>;
+				 bias-pull-up;
+		};
+	};
+
+	pcie1_pins_default: pcie1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO22__FUNC_PERSTN_1>,
+				 <PINMUX_GPIO23__FUNC_CLKREQN_1>,
+				 <PINMUX_GPIO24__FUNC_WAKEN_1>;
+				 bias-pull-up;
+		};
+	};
+
 	pio_default: pio-default-pins {
 		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
-- 
2.39.2

