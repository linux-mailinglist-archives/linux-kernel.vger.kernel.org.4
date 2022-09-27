Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F85EB81A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiI0C7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiI0C7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:59:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55149A6AC9;
        Mon, 26 Sep 2022 19:56:33 -0700 (PDT)
X-UUID: ff0e6cd1f32f41ea899edde8d680b114-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SGV4Mh7EE7zp++AbZ62Qr7GojYfsLp9od1ijjZk+9Z0=;
        b=uAU8reRiRyNr+OB05uqjAtfQbeqGqJyw0HUAKWo5vskweTc7Xm8eak4nGPjwCi410L+nBp4TtYRnP0f9MTlVu7ePN32QVZcjiGgzTbTXFEkSe1yg9WiPNmxT47Gtvq4b3unFlMF3q2zG8UkHst4w3SzWigBKE+bigZwmGXJz1oc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f2b4fce9-de70-4ac1-8c06-4702e3962c20,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:f2b4fce9-de70-4ac1-8c06-4702e3962c20,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:bb2b51e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220927105630LRPANMO4,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: ff0e6cd1f32f41ea899edde8d680b114-20220927
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1169113129; Tue, 27 Sep 2022 10:56:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 27 Sep 2022 10:56:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 10:56:26 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH v3 09/11] remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
Date:   Tue, 27 Sep 2022 10:56:04 +0800
Message-ID: <20220927025606.26673-10-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220927025606.26673-1-tinghan.shen@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because MT8195 SCP core 0 and core 1 both boot from head of SRAM and
have the same viewpoint of SRAM, SCP has a "Core 1 SRAM offset"
to control the viewpoint of SCP core 1 to allow core 1 boot
from different SRAM location.

The "Core 1 SRAM offset" configuration is composed by specifying a range
and an offset. When SCP core 1 accesses a SRAM address located in the
configured range, SCP bus adds the configured offset to the address to
shift the final physical destination on SCP SRAM. This shift is
transparent to the software running on SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_scp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 2d43338b96da..0f1b587f8502 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -477,6 +477,8 @@ static int mt8195_scp_before_load(struct mtk_scp *scp)
 
 static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
 {
+	u32 sec_ctrl;
+
 	scp_sram_power_on(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
 
 	/* hold SCP in reset while loading FW. */
@@ -485,6 +487,27 @@ static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
 	/* enable MPU for all memory regions */
 	writel(0xff, scp->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
 
+	/* The value of SRAM offset range is from the viewpoint of SCP core 1.
+	 * This configuration adds an offset on SCP bus when SCP core 1 accesses SCP SRAM
+	 * to solve the SCP core 0 and core 1 both fetch the 1st instruction from the same
+	 * SRAM address.
+	 *
+	 * Because SCP core 0 and core 1 both boot from the head of sram, this must be
+	 * configured before boot SCP core 1.
+	 *
+	 * Configure the range of SRAM addresses will be added offset.
+	 */
+	writel(0, scp->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_LOW);
+	writel(scp->sram_size, scp->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_HIGH);
+
+	/* configure the offset value */
+	writel(scp->sram_phys - scp->main_scp->sram_phys, scp->reg_base + MT8195_L2TCM_OFFSET);
+
+	/* enable adding sram offset when fetching instruction and data */
+	sec_ctrl = readl(scp->reg_base + MT8195_SEC_CTRL);
+	sec_ctrl |= MT8195_CORE_OFFSET_ENABLE_I | MT8195_CORE_OFFSET_ENABLE_D;
+	writel(sec_ctrl, scp->reg_base + MT8195_SEC_CTRL);
+
 	return 0;
 }
 
-- 
2.18.0

