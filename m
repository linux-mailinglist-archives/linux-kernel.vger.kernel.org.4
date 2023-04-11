Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68D6DD6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDKJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDKJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:32:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0183DE44;
        Tue, 11 Apr 2023 02:31:58 -0700 (PDT)
X-UUID: b067f868d84b11eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TUhFV/OivPCm2+hbj7TWhmkeiC431eZC9aTNqEGVSwE=;
        b=KLYOVVJj/2e8Unc12MkSs9MiKPI8jWQPvcbJhQibXRTn1K3Wnfrh+HDFgyj3IxXRdmA+ArEkDhXscXR7SsjwLSZlq/b3ol8K6tUz9PeuCJLuW88Xf1fKRi8+qUxWPQnS7m5Rrs1UBwxmUF3E8Ua+UcLDhQDdaGZ3FOjZVdB+f/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d84e3266-280f-49bc-b338-03c1cc37fda7,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:0760ae83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b067f868d84b11eda9a90f0bb45854f4-20230411
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1087849141; Tue, 11 Apr 2023 17:31:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 17:31:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 17:31:48 +0800
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
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <jianjiao.zeng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>
Subject: [PATCH v7 00/14] Adjust the dma-ranges for MTK IOMMU
Date:   Tue, 11 Apr 2023 17:31:30 +0800
Message-ID: <20230411093144.2690-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
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
v7: Remove the change about mediatek,vcodec-subdev-decoder.yaml since
    this was merged at:
    https://lore.kernel.org/all/98c48690-631d-1086-9b7c-004c61cc8dbb@xs4all.nl/

v6: https://lore.kernel.org/linux-mediatek/20230403091337.26745-1-yong.wu@mediatek.com/
   Add three patches for set dma-mask for iommu master devices.

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
 .../bindings/media/mediatek-jpeg-encoder.yaml |   5 -
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |   4 +-
 drivers/iommu/mtk_iommu.c                     | 145 ++++++++++++++----
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   3 -
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   8 -
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   3 -
 11 files changed, 117 insertions(+), 76 deletions(-)

-- 
2.18.0


