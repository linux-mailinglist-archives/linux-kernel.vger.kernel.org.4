Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85B26A6A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAJzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCAJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ADC20562;
        Wed,  1 Mar 2023 01:55:31 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5B6F660211B;
        Wed,  1 Mar 2023 09:55:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664530;
        bh=k3mmKlq0xAU4ScRTgH//jypGEajEo18Py+VrtVaBBbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xf4GrQUd18VtRsYjNDhI6iPGwpLLUBmOHp/idd/SAF4TenUvPKPuoNjQK0Fz5zZlB
         U1vMbfBLlstWasR/g8cupFzaRiy6HWAB0I0coRTMjyXD2Q4ZPsqechcdm3LzdvnKwv
         jQIyFVdO/8uZC/WgW7nq45PCBAP8I6y5AZHHclDVx4nxDx/Jzw1DlKLVbCv/HqpEZ5
         NHXM/4J/es2w8GrIrvnCZpDOrG5CefOR2HuRV8jjoMEFVwTfQ6771wUIpRuR4Z2bvJ
         WLQpjKZFKvDr8XRt8lJZJDrZxxhvyN4RXNmdEhjA+YTerirCmgYmftsEFJbExnjwWg
         mWWZ5gAPvJieA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v4 02/19] arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu constraints
Date:   Wed,  1 Mar 2023 10:55:06 +0100
Message-Id: <20230301095523.428461-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
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

Override the PMIC-default voltage constraints for VGPU and VSRAM_GPU
with the platform specific vmin/vmax for the highest possible SoC
binning.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index de9778c85b94..63952c1251df 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -401,6 +401,9 @@ &mt6358codec {
 };
 
 &mt6358_vgpu_reg {
+	regulator-min-microvolt = <625000>;
+	regulator-max-microvolt = <900000>;
+
 	regulator-coupled-with = <&mt6358_vsram_gpu_reg>;
 	regulator-coupled-max-spread = <100000>;
 };
@@ -416,6 +419,9 @@ &mt6358_vsim2_reg {
 };
 
 &mt6358_vsram_gpu_reg {
+	regulator-min-microvolt = <850000>;
+	regulator-max-microvolt = <1000000>;
+
 	regulator-coupled-with = <&mt6358_vgpu_reg>;
 	regulator-coupled-max-spread = <100000>;
 };
-- 
2.39.2

