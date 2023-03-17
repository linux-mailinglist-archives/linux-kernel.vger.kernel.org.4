Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4696BE47A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCQI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCQI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:56:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F96A9E4;
        Fri, 17 Mar 2023 01:55:54 -0700 (PDT)
X-UUID: 83704abcc4a111ed91027fb02e0f1d65-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HK6jXpbP8L8/LEWjHAidc1nyc9oWHOpCfxw/41IYs64=;
        b=QkQbVtPinI/H0TkZKgTMpubRkBO0ctMLWVVU66yRKHGfWwDcwzQwjmYqYuucr2cGchOdYdxFWp5Os7j5MD2yFECyHFPkI0xFMbC/fQzPcLOhYF/cUD50HBMbmXC8QJYyfBMYDfU8LdVkKYaKIdKhNs8WN6NmXnp+dtnhCv8xVy4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:5dcd4cfc-5702-451d-a1de-fc61f9b613df,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:83295aa,CLOUDID:1d381cf6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 83704abcc4a111ed91027fb02e0f1d65-20230317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1163237211; Fri, 17 Mar 2023 16:55:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 16:55:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 16:55:47 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <iommu@lists.linux.dev>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>,
        <chengci.xu@mediatek.com>
Subject: [PATCH v9 0/7] MT8188 IOMMU SUPPORT
Date:   Fri, 17 Mar 2023 16:55:34 +0800
Message-ID: <20230317085541.20447-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8188 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW
is for infra-master, like PCIe.

About the 2 MM IOMMU HW, the connection could be something like this:

        IOMMU(VDO)          IOMMU(VPP)
           |                   |
      SMI_COMMON(VDO)      SMI_COMMON(VPP)
      ---------------     ----------------
      |      |   ...      |      |     ...
    larb0 larb2  ...    larb1 larb3    ...

INFRA IOMMU does not have SMI, the master connects to IOMMU directly.

Although multiple banks supported in MT8188, we only use one of them,
which means PCIe is put in bank0 of INFRA IOMMU.

So we have two pgtable for MT8188, specifically, these two MM IOMMU HW
share a pgtable while INFRA IOMMU HW use a independent pgtable.

Another change is that we add some SMC command for INFRA master to 
enable/disable INFRA IOMMU in ATF considering security concerns.

We also adjust the flow of mtk_iommu_config to reduce indention.

change since v9:
  - Move the patch about setting set_dma_mask out from this patchset.
  - Add a MAINTAINER patch since the header file was added a prefix "mediatek,"

change since v8:
    https://lore.kernel.org/linux-mediatek/20230307080555.14399-1-yong.wu@mediatek.com/
  - Base on v6.3-rc1 and mtk-iommu-dma-range-v5:
    https://lore.kernel.org/linux-mediatek/20230307023507.13306-1-yong.wu@mediatek.com/
  - Add a new patch set_dma_mask about since mt8188 support the PA of pgtable 35bits.

changes since v7:
    https://lore.kernel.org/linux-mediatek/20230216053322.11596-1-yong.wu@mediatek.com/
  - Base on mtk-iommu-dma-range-v4:
    https://lore.kernel.org/linux-mediatek/20230215062544.8677-1-yong.wu@mediatek.com/
  - Add a new patch for two IOMMU share pagetable issue.
  - Add a new patch for adding iova_region_larb_msk for mt8188.
  - Add the comment in the dt-binding header file about larb index.
    This is for readable when updating the iova_region_larb_msk.
    
    Since there is something wrong for chengci's mail account when sending
    to devicetree mail list, we don't know why. I help send this patchset.
    https://lore.kernel.org/linux-mediatek/5a916595-12ee-92e6-d380-84146dd75218@linaro.org/

changes since v6:
    https://lore.kernel.org/linux-mediatek/20221223101439.494-1-chengci.xu@mediatek.com/
  - base on tag: next-20221220.
  - update commit message of patch[2/4].

changes since v5:
  - base on tag: next-20221205.
  - add flag PGTABLE_PA_35_EN for all IOMMU in MT8188.
  - modify the type of "portid_msk" from "u32" to "unsigned long".

changes since v4:
  - base on tag: next-20221018.
  - add patch[2/4] to reduce indention by adjust mtk_iommu_config flow.

changes since v3:
  - base on tag: next-20220916.
  - use license "GPL-2.0-only OR BSD-2-Clause" in bingings head file.
  - drop redundant "portid" assignment when configure infra master.
  - reduce indentation by using "else if" when config infra master.
  - update probe flow about "pericfg" for CFG_IFA_MASTER_IN_ATF.
  - drop unused "pericfg_comp_str" in mt8188_data_infra.
  - drop words like "This commit/patch".

changes since v2:
  - base on tag: next-20220831.
  - rename "mt8188-memory-port.h" to "mediatek,mt8188-memory-port.h".
  - use dual-license in "mediatek,mt8188-memory-port.h"
  - remove unnecessary "()" when define SMI_LARB_ID

changes since v1:
  - base on tag: next-20220803.
  - adds MT8188 IOMMU support.

Chengci.Xu (5):
  dt-bindings: mediatek: mt8188: Add binding for MM & INFRA IOMMU
  iommu/mediatek: Fix two IOMMU share pagetable issue
  iommu/mediatek: Adjust mtk_iommu_config flow
  iommu/mediatek: Add enable IOMMU SMC command for INFRA masters
  iommu/mediatek: Add MT8188 IOMMU Support

Yong Wu (2):
  iommu/mediatek: mt8188: Add iova_region_larb_msk
  MAINTAINERS: iommu/mediatek: Update the header file name

 .../bindings/iommu/mediatek,iommu.yaml        |  12 +-
 MAINTAINERS                                   |   2 +-
 drivers/iommu/mtk_iommu.c                     | 151 ++++--
 .../memory/mediatek,mt8188-memory-port.h      | 489 ++++++++++++++++++
 include/soc/mediatek/smi.h                    |   1 +
 5 files changed, 622 insertions(+), 33 deletions(-)
 create mode 100644 include/dt-bindings/memory/mediatek,mt8188-memory-port.h

-- 
2.18.0


