Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A07405E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjF0VrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjF0Vqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:46:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C399297D;
        Tue, 27 Jun 2023 14:46:39 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E6BA660716C;
        Tue, 27 Jun 2023 22:46:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687902397;
        bh=khyVQY+Nu/Z4EDKrg96abLDsAid37RZNAFA7dJoh+K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEmknKh9uXv6AKN+kRQcmsKlfxopmDPOGU9wtjVeDOZByqNTKWgbBrpoNoUI/tJ/o
         JpCg6mqBUt8NpYy0cSQujxUuCgPiNI3k/w+SlZjOFZQA73DrJK7NKQNNUvLNnzMKIh
         okq1nDuFjUBiz8c3QC38vE2njRckaIzgmn5iKFiGOlClmGv1JXBoem+gJEo8SmLlgt
         s6UXFaOjHpIM10NU4NDzidkVlCX00STy5mojjPJmz999jEU4XsYr84LXg81DzHNPs8
         VzyCm1mPcA+vQlPjma5/jMcJoS0Ec11mnN6yePr+MifjF3aj6FVbQMbvN3tdkBo7lr
         kvPOrsasFsA7g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 6/7] arm64: dts: mediatek: mt8173: Drop VDEC_SYS reg from decoder
Date:   Tue, 27 Jun 2023 17:45:56 -0400
Message-ID: <20230627214615.1503901-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627214615.1503901-1-nfraprado@collabora.com>
References: <20230627214615.1503901-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the VDEC_SYS register space from the decoder, so that the node
address becomes that of VDEC_MISC, solving the long-standing conflicting
addresses between this node and the vdecsys clock-controller node:

arch/arm64/boot/dts/mediatek/mt8173.dtsi:1365.38-1369.5: Warning (unique_unit_address_if_enabled): /soc/clock-controller@16000000: duplicate unit-address (also used in node /soc/vcodec@16000000)

The driver makes use of this register space, however, so also add a
phandle to the VDEC_SYS syscon to maintain functionality.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v4:
- Added this commit

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c47d7d900f28..cac4cd0a0320 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1368,10 +1368,9 @@ vdecsys: clock-controller@16000000 {
 			#clock-cells = <1>;
 		};
 
-		vcodec_dec: vcodec@16000000 {
+		vcodec_dec: vcodec@16020000 {
 			compatible = "mediatek,mt8173-vcodec-dec";
-			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
-			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
+			reg = <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
 			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
 			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
 			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
@@ -1382,6 +1381,8 @@ vcodec_dec: vcodec@16000000 {
 			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
+			reg-names = "misc", "ld", "top", "cm", "ad", "av", "pp",
+				    "hwd", "hwq", "hwb", "hwg";
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
 			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
@@ -1392,6 +1393,7 @@ vcodec_dec: vcodec@16000000 {
 				 <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_VLD2_EXT>;
 			mediatek,vpu = <&vpu>;
+			mediatek,vdecsys = <&vdecsys>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_VDEC>;
 			clocks = <&apmixedsys CLK_APMIXED_VCODECPLL>,
 				 <&topckgen CLK_TOP_UNIVPLL_D2>,
-- 
2.41.0

