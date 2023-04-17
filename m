Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19A6E413D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDQHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDQHhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:37:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA8944A6;
        Mon, 17 Apr 2023 00:36:18 -0700 (PDT)
X-UUID: 87f254c2dcf211edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WSGsGsyZmAAWE39HbT7EAIDHhqghH7oH+F9PicR6RAE=;
        b=OUAR/DcwqrYj7gBePI3X4WeRYcvK/PBlCTlvZqXZ/fv77DWDEeSS0OWqH2Z/JeyUoF5rENdJ0jQTlFkCsJiVHGtiNCPlhjpvBRdRmItkQEHr7sQ8F0XXz+KUqCI3sXhV5w/m0g7soeW1gvqzyEZxOyHQulY4pmNYy693wK0bP80=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:5dfb19fe-78e0-4213-ae9f-17074e0353de,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:5dfb19fe-78e0-4213-ae9f-17074e0353de,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:00854c84-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230417153614MLNXS07L,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 87f254c2dcf211edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 613524037; Mon, 17 Apr 2023 15:36:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 15:36:12 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 15:36:11 +0800
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
Subject: [PATCH v10 0/7] MT8188 IOMMU SUPPORT
Date:   Mon, 17 Apr 2023 15:35:59 +0800
Message-ID: <20230417073606.25729-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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

Change in v10:
  - Add a Fixes tag for [2/7].
  - Rebase on mtk-iommu-dma-range-v7:
    https://lore.kernel.org/linux-mediatek/20230411093144.2690-1-yong.wu@mediatek.com/

change since v9:
  https://lore.kernel.org/linux-mediatek/20230317085541.20447-1-yong.wu@mediatek.com/
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


