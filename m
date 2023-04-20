Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C606E8E78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjDTJqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjDTJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:45:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506C35BF;
        Thu, 20 Apr 2023 02:44:48 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24D7866032AA;
        Thu, 20 Apr 2023 10:44:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681983887;
        bh=eTPRbfdJLpoEovWoX9DFmWEwQag9cVc/gZKE80xSx8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPcMTMMTPEKj7UALYhV/RuKy/DVHmACu/w3/QLiIQtaLqq6cvKauICdVEvF9G9FXn
         zveAEUZ0Wcskp/hXOQMFDr4AmO08BIWq0XrFoEV11JxbP+75k3EFSgWJ++qqdTxYrP
         n4PNjHCh8QBxJ3JO9ncNmOyTwpVJDcHRDJ3EviNSJIylW1jka3q38n1xgBIojFWflo
         Zzs2nre7OU5BsDCzqgRyAs3bHjh1vGUXFO1d5uC60vLbFMMvvodhnMmRoJiFwU3RwT
         4LhK52kfGdMpL4BdHREU+bUjxaQZBkyN+wH4HC2/Jnuo0cGssoMchkCmbVjMovwLWw
         hD2Tuy9PRyFkQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/5] arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi
Date:   Thu, 20 Apr 2023 11:44:32 +0200
Message-Id: <20230420094433.42794-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 46f1c8091498..9e2bc363c9cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -567,6 +567,13 @@ flash@0 {
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
@@ -961,6 +968,24 @@ pins-vreg-en {
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
2.40.0

