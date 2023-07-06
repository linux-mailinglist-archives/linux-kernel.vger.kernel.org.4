Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9F7498D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGFJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjGFJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:58:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B7199E;
        Thu,  6 Jul 2023 02:58:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D6B1660585C;
        Thu,  6 Jul 2023 10:58:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688637528;
        bh=kSDkPuyPb2t/JH+C79C1IUs7iSlEMd5QU2QZxBnRzjg=;
        h=From:To:Cc:Subject:Date:From;
        b=VrxAzq+T6v6gG1CSsHla+ctqoqAOgTx+nHsxbn/BLDMVwG7eC/KC9SJCSyNrgjB2B
         W+IZJOwKW1xyggoG3Wq6WqwMzwF083PAVWJqgiAsRTlJ3Zhv3N02Jr0qBhyaxpprYy
         uEqMxZhlfsr/7rkAmOTeK8rusLo17P9hZLmiXtIbQ8+ntt62CS4GU8CbK+uiIT7QcU
         +Id9PIfe9Egl5JugoipJ/55dfncmt2osxQMtUet281ZSLzxisQ0FwJ0VhpkcBfyO3u
         JRmt++euLLmnmJopWNxOgMaI6FHe1KCwkyQh2cyS/Xhcl5RJd20q9GMYkIZyYAAuTC
         48m6kplJGwZmw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, yong.wu@mediatek.com,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8195: Fix PM suspend/resume with venc clocks
Date:   Thu,  6 Jul 2023 11:58:41 +0200
Message-Id: <20230706095841.109315-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
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

Before suspending the LARBs we're making sure that any operation is
done: this never happens because we are unexpectedly unclocking the
LARB20 before executing the suspend handler for the MediaTek Smart
Multimedia Interface (SMI) and the cause of this is incorrect clocks
on this LARB.

Fix this issue by changing the Local Arbiter 20 (used by the video
encoder secondary core) apb clock to CLK_VENC_CORE1_VENC;
furthermore, in order to make sure that both the PM resume and video
encoder operation is stable, add the CLK_VENC(_CORE1)_LARB clock to
the VENC (main core) and VENC_CORE1 power domains, as this IP cannot
communicate with the rest of the system (the AP) without local
arbiter clocks being operational.

Fixes: 3b5838d1d82e ("arm64: dts: mt8195: Add iommu and smi nodes")
Fixes: 2b515194bf0c ("arm64: dts: mt8195: Add power domains controller")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 95bd058d6083..5c670fce1e47 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -626,6 +626,8 @@ power-domain@MT8195_POWER_DOMAIN_VDEC1 {
 
 					power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
 						reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
+						clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>;
+						clock-names = "venc1-larb";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
@@ -688,6 +690,8 @@ power-domain@MT8195_POWER_DOMAIN_VDEC2 {
 
 						power-domain@MT8195_POWER_DOMAIN_VENC {
 							reg = <MT8195_POWER_DOMAIN_VENC>;
+							clocks = <&vencsys CLK_VENC_LARB>;
+							clock-names = "venc0-larb";
 							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
@@ -3094,7 +3098,7 @@ larb20: larb@1b010000 {
 			reg = <0 0x1b010000 0 0x1000>;
 			mediatek,larb-id = <20>;
 			mediatek,smi = <&smi_common_vpp>;
-			clocks = <&vencsys_core1 CLK_VENC_CORE1_LARB>,
+			clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>,
 				 <&vencsys_core1 CLK_VENC_CORE1_GALS>,
 				 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
 			clock-names = "apb", "smi", "gals";
-- 
2.40.1

