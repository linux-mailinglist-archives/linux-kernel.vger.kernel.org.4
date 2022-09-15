Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC905B980A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiIOJsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIOJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:47:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD460692;
        Thu, 15 Sep 2022 02:46:47 -0700 (PDT)
X-UUID: 683d22a59c5a464fb2d8d47b4de456c0-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aleWP+Qc0EQlETQZQ8wzJbVsDpW6Hr549VkiF5sGFxs=;
        b=FhblS9C2WgOiwFLScPeAtq1uox9E2UO4DFv3t91pYsPZZlntKzuSDQUE4o+xBz6JZbs9Z46QhEhWqeuPuTkho+C86gJermM0Anpsky0/bfZ8D1E93hKhb0n/+gL9y5/RDoSySkKl+Q7MWyKYet3gEAPrAn7owtDI67fb0dgzgMA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0e3605fd-3b8f-46b1-abbb-d8b13a090c3f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:4900be7b-ea28-4199-b57e-003c7d60873a,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 683d22a59c5a464fb2d8d47b4de456c0-20220915
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1630742314; Thu, 15 Sep 2022 17:46:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 15 Sep 2022 17:46:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 15 Sep 2022 17:46:41 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 4/4] arm64: dts: mediatek: cherry: Add edptx and dptx support
Date:   Thu, 15 Sep 2022 17:46:40 +0800
Message-ID: <20220915094640.5571-5-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
References: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cherry projects, we use edptx as the internal display interface
and use dptx as the external display interface. To support this, we
need to add more properties.

- Add pinctrls for edptx and dptx.
- Add ports for edptx and dptx.

The port connections for the internal and external display:
dp-intf0 -> edptx -> panel
dp-intf1 -> dptx

Because it lacks port of panel, so we keep empty remote-endpoint for
port1@edptx.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 303dc32c64dc..560103e29017 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -125,6 +125,7 @@
 
 	port {
 		dp_intf0_out: endpoint {
+			remote-endpoint = <&edp_in>;
 		};
 	};
 };
@@ -134,6 +135,59 @@
 
 	port {
 		dp_intf1_out: endpoint {
+			remote-endpoint = <&dptx_in>;
+		};
+	};
+};
+
+&edp_tx {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edptx_pins_default>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			edp_in: endpoint {
+				remote-endpoint = <&dp_intf0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			edp_out: endpoint {
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&dp_tx {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dptx_pin>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dptx_in: endpoint {
+				remote-endpoint = <&dp_intf1_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dptx_out: endpoint {
+				data-lanes = <0 1 2 3>;
+			};
 		};
 	};
 };
@@ -497,6 +551,20 @@
 		};
 	};
 
+	edptx_pins_default: edptx-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO7__FUNC_EDP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
+	dptx_pin: dptx-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO18__FUNC_DP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
 	i2c0_pins: i2c0-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
-- 
2.18.0

