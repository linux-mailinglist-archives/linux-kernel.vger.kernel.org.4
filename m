Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D847571F3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFAUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjFAUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:32:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37A134;
        Thu,  1 Jun 2023 13:32:35 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF4F16605838;
        Thu,  1 Jun 2023 21:32:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685651553;
        bh=5WpcqO9ifnLpSK4823RMglaY7WU6LjX8KXsVqXcIo4s=;
        h=From:To:Cc:Subject:Date:From;
        b=XZFdNEPRwzkK2c5Oc4RvBoc0pm4d2VDuObQZiOdl+YUlaUSGN3S3wjtBaWk7E2myv
         ToqDaqY3d+NW969Pl+e/oZQbpuNQ+18gHeB1Z4xzy6JAODnKrRCssCfoz5aIQD4Smt
         1fXf/2iLWd6Q+HqkZxVvG4TAVe0bQ2U0pCwq+s/dq1aqap29BbfbXpiYTbftZFmzNz
         cPpMl8Jf984hJL4GyH5DwY2I6Icb18pdJ4W0Qco5/LfTpNKAcSpBXVAC4ym1r0C+OC
         xGMWFCVov/SMe2PVuLhNdsVFNv6Dsy60sYtzDJ5QI6cOHYgHH4UkSKmQe5h9Yn+bX7
         gD7pFqr85ZPCA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Yong Wu <yong.wu@mediatek.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: mt8192: Add missing dma-ranges to soc node
Date:   Thu,  1 Jun 2023 16:32:21 -0400
Message-Id: <20230601203221.3675915-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the series "Adjust the dma-ranges for MTK IOMMU", the mtk-iommu
driver was adapted to separate the iova range based on the larb used,
and a dma-ranges property was added to the soc node in the devicetree of
the affected SoCs allowing the whole 16GB iova range to be used. Except
that for mt8192, there was no patch adding dma-ranges.

Add the missing dma-ranges property to the soc node like was done for
mt8195 and mt8186. This fixes the usage of the vcodec, which would
otherwise trigger iommu faults.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Matthias,

this is a very simple but important fix for the vcodec functionality.
Since the vcodec node for mt8192 was just merged, can we please get this
in in this merge window as well?

Thanks,
Nícolas

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 7ff183c35494..a3612de8e9d1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -401,6 +401,7 @@ soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
+		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 		ranges;
 
 		gic: interrupt-controller@c000000 {
-- 
2.40.1

