Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA766B617
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjAPDWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjAPDWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:22:04 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816A7AA8;
        Sun, 15 Jan 2023 19:21:59 -0800 (PST)
X-UUID: e9febf54954c11ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Gg8bWb1FimtqSa/S00NIuzeLTb9/WRlCLgNfTbeYtTQ=;
        b=GegkSOE3BVrFVCR/+ZcmVyEIegrTkGp1d5pv/4ZVDVe2lByQokq6nX8ayna6DauoxSv3KyRQtjY3cIXyCYj3bO5VjQkI0mvEGh8LOwvbT9XRCwVa34Pz836xkd3eVQnKm2cDAsM4jw39t+pu2HBViTmk/KYZZhPQUiGsKfxCtP0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:11ef97df-90e9-4b33-8953-f021eb2027b9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:543e81c,CLOUDID:e0f7ba54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: e9febf54954c11ed945fc101203acc17-20230116
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1624900539; Mon, 16 Jan 2023 11:21:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 16 Jan 2023 11:21:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 11:21:48 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [RESEND v3 00/13] add support MDP3 on MT8195 platform
Date:   Mon, 16 Jan 2023 11:21:34 +0800
Message-ID: <20230116032147.23607-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Depend on :
  [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711592
  [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711618
- Suggested by Rob to revise MDP3 bindings to pass dtbs check
- Add parallel paths feature.
- Add blended components settings.

Changes since v1:
- Depend on :
  [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/?series=698872
  [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=684959
- Fix compilation failure due to use of undeclared identifier in file "mtk-mdp3-cmdq.c"

Hello,

This patch is used to add support for MDP3 on the MT8195 platform that
contains more picture quality components, and can arrange more pipelines
through two sets of MMSYS and MUTEX respectively.

Moudy Ho (13):
  dt-binding: mediatek: add bindings for MediaTek mt8195 MDP3 components
  arm64: dts: mediatek: mt8195: add MDP3 nodes
  media: platform: mtk-mdp3: add support second sets of MMSYS
  media: platform: mtk-mdp3: add support second sets of MUTEX
  media: platform: mtk-mdp3: introduce more MDP3 components
  media: platform: mtk-mdp3: add checks for dummy components
  media: platform: mtk-mdp3: avoid multiple driver registrations
  media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
  media: platform: mtk-mdp3: add the blend of component in MUTEX MOD
  media: platform: mtk-mdp3: add mt8195 platform configuration
  media: platform: mtk-mdp3: add mt8195 shared memory configurations
  media: platform: mtk-mdp3: add mt8195 MDP3 component settings
  media: platform: mtk-mdp3: add support for parallel pipe to improve
    FPS

 .../bindings/media/mediatek,mdp3-aal.yaml     |  63 ++
 .../bindings/media/mediatek,mdp3-color.yaml   |  63 ++
 .../bindings/media/mediatek,mdp3-fg.yaml      |  63 ++
 .../bindings/media/mediatek,mdp3-hdr.yaml     |  62 ++
 .../bindings/media/mediatek,mdp3-merge.yaml   |  63 ++
 .../bindings/media/mediatek,mdp3-ovl.yaml     |  63 ++
 .../bindings/media/mediatek,mdp3-pad.yaml     |  63 ++
 .../bindings/media/mediatek,mdp3-rdma.yaml    |  30 +-
 .../bindings/media/mediatek,mdp3-rsz.yaml     |  11 +-
 .../bindings/media/mediatek,mdp3-split.yaml   |  75 ++
 .../bindings/media/mediatek,mdp3-stitch.yaml  |  63 ++
 .../bindings/media/mediatek,mdp3-tcc.yaml     |  62 ++
 .../bindings/media/mediatek,mdp3-tdshp.yaml   |  63 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 420 +++++++++
 .../platform/mediatek/mdp3/mdp_reg_aal.h      |  25 +
 .../platform/mediatek/mdp3/mdp_reg_color.h    |  31 +
 .../media/platform/mediatek/mdp3/mdp_reg_fg.h |  23 +
 .../platform/mediatek/mdp3/mdp_reg_hdr.h      |  31 +
 .../platform/mediatek/mdp3/mdp_reg_merge.h    |  25 +
 .../platform/mediatek/mdp3/mdp_reg_ovl.h      |  25 +
 .../platform/mediatek/mdp3/mdp_reg_pad.h      |  21 +
 .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  24 +
 .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   2 +
 .../platform/mediatek/mdp3/mdp_reg_tdshp.h    |  34 +
 .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   8 +
 .../mediatek/mdp3/mt8183/mdp3-plat-mt8183.h   |  38 +-
 .../mediatek/mdp3/mt8195/mdp3-comp-mt8195.h   | 283 ++++++
 .../mediatek/mdp3/mt8195/mdp3-plat-mt8195.h   | 669 ++++++++++++++
 .../platform/mediatek/mdp3/mtk-img-ipi.h      |   4 +
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 453 +++++++---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 834 +++++++++++++++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  92 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 115 ++-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  33 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 +
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
 39 files changed, 3791 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-aal.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-color.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-fg.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-hdr.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-merge.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-ovl.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-pad.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-split.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-stitch.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tcc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-tdshp.yaml
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8195/mdp3-comp-mt8195.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mt8195/mdp3-plat-mt8195.h

-- 
2.18.0

