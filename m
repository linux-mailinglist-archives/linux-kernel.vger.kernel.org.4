Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912B64CA49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiLNNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbiLNNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:11:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438E2181F;
        Wed, 14 Dec 2022 05:11:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D6156602C47;
        Wed, 14 Dec 2022 13:11:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671023491;
        bh=43IMkVml1qImsFp1W7CKhzsHSHE25K/j0gQkN5BQMew=;
        h=From:To:Cc:Subject:Date:From;
        b=BFkQpN0SqGcGnkvpz31sUKD/KvLZwpXwFibIJ7pudAGxtfMv2894u8cwykZPJtm0S
         fSum//QYOk3K23y6Eo7gUndJNccZkl+1RRRPBXebSmUHxYspR2x2tzfiZH8Zli23hW
         8KBPoLu6X2wFWw76hWBliN4Gtt7Cu/nzLWrQmD4fQo+2NrfDjpIqFNlGHkfCe6ysDJ
         WhVPyk4DO4pztht9KtRciLt9oT/lSQXfkk15zXaPggfZ4W92AUabMf7GBjCAJn/KLr
         TRIEFimYkWnE09zHZ8g6RIQb1ARWsUI/w4gaGg7EoUho2OqBDX0ccHL82RtvSxVJSB
         5phAas90/aOcg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8195: Use P1 clocks for PCIe1 controller
Date:   Wed, 14 Dec 2022 14:11:16 +0100
Message-Id: <20221214131117.108008-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
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

Despite there being some flexibility regarding the P0/P1 connections,
especially for TL and PERI, we must use P1 clocks on pcie1 otherwise
we'll be dealing with unclocked access.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d31536f4c48..e61944510b8e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1258,9 +1258,9 @@ pcie1: pcie@112f8000 {
 
 			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
 				 <&clk26m>,
-				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>,
 				 <&clk26m>,
-				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
+				 <&infracfg_ao CLK_INFRA_AO_PCIE_P1_PERI_26M>,
 				 /* Designer has connect pcie1 with peri_mem_p0 clock */
 				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
 			clock-names = "pl_250m", "tl_26m", "tl_96m",
-- 
2.38.1

