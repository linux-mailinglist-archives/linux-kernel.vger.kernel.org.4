Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3768E7AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBHFhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBHFhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:37:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596098A4F;
        Tue,  7 Feb 2023 21:36:58 -0800 (PST)
X-UUID: 991216d0a77211eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=X3cBszW/NxbtABNnIy79YxFnHPtmZaYNwTC7ihSL/WU=;
        b=rpWyBQqTOG6hLXSVFRs0rYMmHaAm9xONxK2jeV4Yp+WdKNjb8gyMMhHV32CTc7dcvVbCbfUJy8ji9mdrsxb0r6VJxESzKo2tmi5XfgvZTOxyYG3iKPqAezwhNMVb2Iv0xA+OAxs8cQuCnRnjHUZCAMgXcjHUt6oenREYx62l/BI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:06012837-cbf9-4a0b-8ffc-2a5c0a495f49,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:520b3e8e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 991216d0a77211eda06fc9ecc4dadd91-20230208
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 68293331; Wed, 08 Feb 2023 13:36:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 13:36:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 13:36:53 +0800
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
        <libo.kang@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>
Subject: [PATCH v2 00/10] Adjust the dma-ranges for MTK IOMMU
Date:   Wed, 8 Feb 2023 13:36:33 +0800
Message-ID: <20230208053643.28249-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
v2:
   a) Base on next-20230206 since mt8195 jpeg node was applied which
      affect this patchset.
   b) Reword the commit message [1/10][2/10] to explain effect.

v1: https://lore.kernel.org/linux-mediatek/20230113060133.9394-1-yong.wu@mediatek.com/
   Base on v6.2-rc3.

Yong Wu (10):
  dt-bindings: media: mediatek,vcodec: Remove dma-ranges property
  dt-bindings: media: mediatek,jpeg: Remove dma-ranges property
  iommu/mediatek: Get regionid from larb/port id
  iommu/mediatek: mt8195: Add larb_region_msk
  iommu/mediatek: mt8186: add larb_region_msk
  iommu/mediatek: mt8192: add larb_region_msk
  iommu/mediatek: Add a gap for the iova regions
  arm64: dts: mt8195: Add dma-ranges for the parent "soc" node
  arm64: dts: mt8195: Remove the unnecessary dma-ranges
  arm64: dts: mt8186: Add dma-ranges for the parent "soc" node

 .../media/mediatek,mt8195-jpegdec.yaml        |  7 --
 .../media/mediatek,mt8195-jpegenc.yaml        |  7 --
 .../media/mediatek,vcodec-decoder.yaml        |  5 -
 .../media/mediatek,vcodec-encoder.yaml        |  5 -
 .../media/mediatek,vcodec-subdev-decoder.yaml |  7 --
 .../bindings/media/mediatek-jpeg-encoder.yaml |  5 -
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  4 +-
 drivers/iommu/mtk_iommu.c                     | 95 ++++++++++++++-----
 9 files changed, 72 insertions(+), 64 deletions(-)

-- 
2.18.0


