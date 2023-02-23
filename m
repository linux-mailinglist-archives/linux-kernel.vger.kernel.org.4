Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E236A0AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjBWNog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjBWNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:44:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1357084;
        Thu, 23 Feb 2023 05:44:03 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0062F660220E;
        Thu, 23 Feb 2023 13:44:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159842;
        bh=h6g8JhUl3ByKknKJO0h/z+EUOf6qSWsVNOP7Ves+YLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXXezOP7iroYHgJ5QMenpkLXPgbwhwSRXrI92ZKNC5kUhf9L42eJmE3UMGA/OqMnN
         9xoLpSZjqinDokBsC1plasL3onf3Y/Qty6G+GX4Hd8ACLjp0pDokk8AKlWHfVHPkNl
         eE0g6DmSE7nxs3nZPvLzAW1NM/Jian7xm1rt5olOCsuo/3+5oIoTn0PteZ3/ORxoTe
         qLJ0d7K38s7jrag7Jn7EU4tAJACVLw33kfMT9KfEXQX/ZTkVsrabRUxElVRC/LSix1
         DSb6qlAbxPrRFus5VAA6PGv6mr/yMqkB8jR3gEcc/cl8EZXEWJdGaLkkdeXjHBEBbC
         04nJIgj9k1d6w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 10/16] arm64: dts: mediatek: mt8192-asurada: Assign sram supply to MFG1 pd
Date:   Thu, 23 Feb 2023 14:43:39 +0100
Message-Id: <20230223134345.82625-11-angelogioacchino.delregno@collabora.com>
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

Add a phandle to the MT8192_POWER_DOMAIN_MFG1 power domain and
assign the GPU VSRAM supply to this in mt8192-asurada: this allows to
keep the sram powered up while the GPU is used.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index ec013d5ef157..df477eb89f21 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -384,6 +384,10 @@ &mfg0 {
 	domain-supply = <&mt6315_7_vbuck1>;
 };
 
+&mfg1 {
+	domain-supply = <&mt6359_vsram_others_ldo_reg>;
+};
+
 &mipi_tx0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index d536fe5f33a0..91b63060ec7c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -506,7 +506,7 @@ mfg0: power-domain@MT8192_POWER_DOMAIN_MFG0 {
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
-					power-domain@MT8192_POWER_DOMAIN_MFG1 {
+					mfg1: power-domain@MT8192_POWER_DOMAIN_MFG1 {
 						reg = <MT8192_POWER_DOMAIN_MFG1>;
 						mediatek,infracfg = <&infracfg>;
 						#address-cells = <1>;
-- 
2.39.2

