Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A95FDD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJMPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJMPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:22:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F410F8A1;
        Thu, 13 Oct 2022 08:22:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3D44660236A;
        Thu, 13 Oct 2022 16:22:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665674541;
        bh=1Hsa+hCs6ujNKDF0QPMj+cm7hvP4DZ+oiE2dgapkeCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9uzIrSVYtl3sc0lo308WxbTghFY6HMyxmml2wdtHPXM7CfuzgUIaaV1dfej+p1E9
         QQjdZPn3ygu79WPsAVEmN+fLbdDVnTYFJgdjOfl6s55EgOmCIYkY6wcOpZSDQYbB8K
         L3Vp5D9eMFzLsVTK87zYMhosBF1+4nezr3W79Kaw14yPl1ZiVbG8B/zJ/3BtVYJErO
         EkSZkBp0/iGIWkkFeDVNbDyzMfjrjmIorejmTplHDBZXIsd1YM7EfK2z2k47AuR1hf
         cXxC7tGHNM7bqU+EQLNtdEm6J5Rc4D5xJ17UyD4p7cdpAbZFY3YnyO4vsAqCjnc4bY
         vFPX6E9nz15zQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sam.shih@mediatek.com, hanks.chen@mediatek.com,
        weiyi.lu@mediatek.com, zhiyong.tao@mediatek.com,
        andrew-sh.cheng@mediatek.com, viresh.kumar@linaro.org,
        chunfeng.yun@mediatek.com, fparent@baylibre.com,
        mars.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/8] arm64: dts: mt6779: Fix devicetree build warnings
Date:   Thu, 13 Oct 2022 17:22:06 +0200
Message-Id: <20221013152212.416661-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
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

Rename fixed-clock oscillators to oscillator-26m and oscillator-32k
and remove the unit address to fix the unit_address_vs_reg warning;
fix the unit address for interrupt and intpol controllers by
removing a leading zero in their unit address.

This commit fixes the following warnings:

(unit_address_vs_reg): /oscillator@0: node has a unit name, but
no reg or ranges property
(unit_address_vs_reg): /oscillator@1: node has a unit name, but
no reg or ranges property
(simple_bus_reg): /soc/interrupt-controller@0c000000: simple-bus
unit address format error, expected "c000000"
(simple_bus_reg): /soc/intpol-controller@0c53a650: simple-bus
unit address format error, expected "c53a650"

Fixes: 4c7a6260775d ("arm64: dts: add dts nodes for MT6779")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 9bdf5145966c..dde9ce137b4f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -88,14 +88,14 @@ pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW 0>;
 	};
 
-	clk26m: oscillator@0 {
+	clk26m: oscillator-26m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 		clock-output-names = "clk26m";
 	};
 
-	clk32k: oscillator@1 {
+	clk32k: oscillator-32k {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
@@ -117,7 +117,7 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
-		gic: interrupt-controller@0c000000 {
+		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <4>;
 			interrupt-parent = <&gic>;
@@ -138,7 +138,7 @@ ppi_cluster1: interrupt-partition-1 {
 
 		};
 
-		sysirq: intpol-controller@0c53a650 {
+		sysirq: intpol-controller@c53a650 {
 			compatible = "mediatek,mt6779-sysirq",
 				     "mediatek,mt6577-sysirq";
 			interrupt-controller;
-- 
2.37.2

