Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F26D3FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDCJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjDCJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:14:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF44EC5;
        Mon,  3 Apr 2023 02:13:54 -0700 (PDT)
X-UUID: d5148bbad1ff11edb6b9f13eb10bd0fe-20230403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YO7m4iZSxuMCZDbG0DFv2mMLjjrs2tfy545wzpqEnAA=;
        b=j1jlJ9aKbJ0SmeyRIBSz1UWbDBwoSodvUSmG++bPC89Aj97nxtT1h8TcwCqO9BvJSe4EDLS+FtC4J1vf0mmaMBoG8zwwJ/F71kxOtLTELTnDSh1cW6DrowPf+S7MFWps2v3ehlhadr+6EZfP7bfbBaa08R098X2UKe2zouO7Y3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:08fc4d27-9bb6-4141-af31-f0d17847a0d1,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:3894b1f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d5148bbad1ff11edb6b9f13eb10bd0fe-20230403
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1745957318; Mon, 03 Apr 2023 17:13:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 3 Apr 2023 17:13:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 3 Apr 2023 17:13:41 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <jianjiao.zeng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>
Subject: [PATCH v6 00/14] Adjust the dma-ranges for MTK IOMMU
Date:   Mon, 3 Apr 2023 17:13:23 +0800
Message-ID: <20230403091337.26745-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
controllers"), the dma-ranges is not allowed for dts leaf node.
but we still would like to separate the different masters into
different iova regions. Thus we adjust the internal flow, separate
the 16GB iova range by the master HW larbid/portid and add the
dma-ranges property in the parent "soc" node. This also could avoid
the users forget/abuse the iova regions.

The commit f1ad5338a4d5 did affect the mt8195 venc, But it is not
a fatal issue, it could also work well at 0-4GB iova. thus I don't
add "Fixes:" tag.

In this series, I add functions for mt8192/mt8195/mt8186, mt8188 will
be in its special patchset. and the previous mt8173/mt8183...support
0-4GB only, no need this function.

Change note:
v6: Add three patches[9/10/11] for set dma-mask for iommu master devices.

v5: Nothing change. Just rebase on v6.3-rc1.

v4: https://lore.kernel.org/linux-mediatek/20230215062544.8677-1-yong.wu@mediatek.com/
    Improve the comment in the code from AngeloGioacchino.

v3: https://lore.kernel.org/linux-mediatek/20230214031114.926-1-yong.wu@mediatek.com/
   Add a new patch only for comment more in the code.

v2: https://lore.kernel.org/linux-mediatek/20230208053643.28249-1-yong.wu@mediatek.com/
   a) Base on next-20230206 since mt8195 jpeg node is applied which affect
      this patch.
   b) Reword the commit message [1/10][2/10] to explain effect.

v1: https://lore.kernel.org/linux-mediatek/20230113060133.9394-1-yong.wu@mediatek.com/
   Base on v6.2-rc3.

Yong Wu (14):
  dt-bindings: media: mediatek,vcodec: Remove dma-ranges property
  dt-bindings: media: mediatek,jpeg: Remove dma-ranges property
  iommu/mediatek: Improve comment for the current region/bank
  iommu/mediatek: Get regionid from larb/port id
  iommu/mediatek: mt8192: Add iova_region_larb_msk
  iommu/mediatek: mt8195: Add iova_region_larb_msk
  iommu/mediatek: mt8186: Add iova_region_larb_msk
  iommu/mediatek: Add a gap for the iova regions
  iommu/mediatek: Set dma_mask for the master devices
  media: mtk-jpegdec: Remove the setting for dma_mask
  media: mediatek: vcodec: Remove the setting for dma_mask
  arm64: dts: mt8195: Remove the unnecessary dma-ranges
  arm64: dts: mt8195: Add dma-ranges for the parent "soc" node
  arm64: dts: mt8186: Add dma-ranges for the parent "soc" node

 .../media/mediatek,mt8195-jpegdec.yaml        |   7 -
 .../media/mediatek,mt8195-jpegenc.yaml        |   7 -
 .../media/mediatek,vcodec-decoder.yaml        |   5 -
 .../media/mediatek,vcodec-encoder.yaml        |   5 -
 .../media/mediatek,vcodec-subdev-decoder.yaml |   7 -
 .../bindings/media/mediatek-jpeg-encoder.yaml |   5 -
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   4 +-
 drivers/iommu/mtk_iommu.c                     | 145 ++++++++++++++----
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   3 -
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   8 -
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   3 -
 12 files changed, 117 insertions(+), 83 deletions(-)

-- 
2.18.0


