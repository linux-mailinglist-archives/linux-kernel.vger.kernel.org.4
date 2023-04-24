Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CEB6ECB49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjDXLZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjDXLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:25:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8A10E;
        Mon, 24 Apr 2023 04:25:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7128B66032D6;
        Mon, 24 Apr 2023 12:25:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682335532;
        bh=P3MJW20eoG0YoMr+L3S8LawJAlojmTn59Fmy2F+6Ey4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePQrKoJuHA6iR92JJnfcq4N2llCQx4eiVTdBBFAHz7cJjxqWCI5MZ50u5LgO1HP6I
         /w49XbKbeOpILRKFgvL2/CvNqFxULx/YD43Qzj7xA3yKJhVzVXoowS7H3CLWojGLSM
         9XQDUpdxzKzSvJwO9mb9r9EbD23nOXoZTwv3jqz09ynPXh67ABD2ZgxAv9o9KO+5sv
         aOAPCYmNp1JSzyKzw4FD+BljEKxodvV47jdPvtL5J1ihHrjC0WfGnm/xmDkLTyApRW
         4dg9FGHleF8jaUUQuQ805TYVfNEqqsKpRmzBdYlezhhiwn0dqKedicYUvpL84zleJg
         cqK5CAKMLNt6g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 4/4] arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi
Date:   Mon, 24 Apr 2023 13:25:23 +0200
Message-Id: <20230424112523.1436926-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index adbda4dccdd5..eca5df85fe33 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -565,6 +565,13 @@ flash@0 {
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
@@ -959,6 +966,24 @@ pins-vreg-en {
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

