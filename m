Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0F6A0ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjBWNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjBWNn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:43:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0564E5C4;
        Thu, 23 Feb 2023 05:43:57 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1486F6602208;
        Thu, 23 Feb 2023 13:43:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159836;
        bh=1V2jxX0ANAEWX9LhnlvthMdf0fZsDfORdoxEzmZYOWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqxbLCz8YHPHJZ9kauVlS3ft33uV+Tec6ZhPT1U3ATczFXnqwSLCJHvz4cyADKVND
         bwPjNx21ZnZ3Ks6QJtzE0J24frRwjmTRWZRmxcDPPANbFp5paKF6fGPg1/rl+CmpgW
         obPMTF3+HXqjminUq1KC3eXFDOsjy4DUWcHS2zFA1ZFYlu43RS0RA8EWwZXOGRBvbT
         7MbWgwnGO0h34kVEV2xqBwxc8vPuh6uRxAlqa+eABVfwfvPPY3Re4ssUOvTv1imOwo
         pKR9zaTuTXMDmX12RZXxBSMWAJK1Z1yl+bSzYC6EG9wToiHXiFO0g+Zt5leCqvoYn2
         JKR4BvnpgMkaA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 01/16] arm64: dts: mediatek: mt8183-kukui: Couple VGPU and VSRAM_GPU regulators
Date:   Thu, 23 Feb 2023 14:43:30 +0100
Message-Id: <20230223134345.82625-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
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

Add coupling for these regulators, as they have a strict voltage output
relation to satisfy in order to ensure GPU stable operation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index fbe14b13051a..de9778c85b94 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -294,7 +294,6 @@ dsi_out: endpoint {
 
 &gpu {
 	mali-supply = <&mt6358_vgpu_reg>;
-	sram-supply = <&mt6358_vsram_gpu_reg>;
 };
 
 &i2c0 {
@@ -401,6 +400,11 @@ &mt6358codec {
 	Avdd-supply = <&mt6358_vaud28_reg>;
 };
 
+&mt6358_vgpu_reg {
+	regulator-coupled-with = <&mt6358_vsram_gpu_reg>;
+	regulator-coupled-max-spread = <100000>;
+};
+
 &mt6358_vsim1_reg {
 	regulator-min-microvolt = <2700000>;
 	regulator-max-microvolt = <2700000>;
@@ -411,6 +415,11 @@ &mt6358_vsim2_reg {
 	regulator-max-microvolt = <2700000>;
 };
 
+&mt6358_vsram_gpu_reg {
+	regulator-coupled-with = <&mt6358_vgpu_reg>;
+	regulator-coupled-max-spread = <100000>;
+};
+
 &pio {
 	aud_pins_default: audiopins {
 		pins_bus {
-- 
2.39.2

