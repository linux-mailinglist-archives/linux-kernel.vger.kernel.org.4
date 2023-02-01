Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB53685D34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBACPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBACPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:15:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48BC4A1FE;
        Tue, 31 Jan 2023 18:15:11 -0800 (PST)
X-UUID: 3ddae158a1d611ed945fc101203acc17-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/YTk/4myQC/KyrxLyPo1I1KSJqbfhccuiIeb+TgIHG0=;
        b=A98zsQmVV1zG/UELvowoBSywEgiKopakSPM81a997WykRzN14lPDjRx9iYvJsDh5jMhvqlkmvpRQsdx0ekDMJlC4dUU+tx2QGFQYBgIgvoHNrohG3mnujrR6iw+nEpUl/RhKgoae+ecimluMcJfMPfguu17hP6IwAFB3i63V4pU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6d50dbd6-a550-490b-858a-b9c7867c363a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.18,REQID:6d50dbd6-a550-490b-858a-b9c7867c363a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:3ca2d6b,CLOUDID:f56eea55-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230201101507ST7Q5VMN,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 3ddae158a1d611ed945fc101203acc17-20230201
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 494620218; Wed, 01 Feb 2023 10:15:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 10:15:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 10:15:02 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benliang.zhao@mediatek.com>,
        <bin.zhang@mediatek.com>
Subject: [PATCH v6 0/5] Add MediaTek MT7986 NAND ECC engine support
Date:   Wed, 1 Feb 2023 10:14:55 +0800
Message-ID: <20230201021500.26769-1-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series split from bellow series which pick-up mtd relevant patches
https://lore.kernel.org/all/20230130030656.12127-1-xiangsheng.hou@mediatek.com.
This series add MediaTek MT7986 NAND ECC controller support, split ECC engine
with rawnand controller in bindings and change to YAML schema.

Changes since V5:
 - Split from previous series V4.
 - Fix warning by change mtk-nand.txt references to new yaml file.

Changes since V4:
 - Split arm and arm64 dts patch for fix existing NAND controller node name.

Changes since V3:
 - Correct mediatek,mtk-nfc.yaml dt-bindings.

Changes since V2:
 - Change ECC err_mask value with GENMASK macro.
 - Change snfi mediatek,rx-latch-latency to mediatek,rx-latch-latency-ns.
 - Add a separate patch for DTS change.
 - Move common description to top-level pattern properties.
 - Drop redundant parts in dt-bindings.

Changes since V1:
 - Improve and perfect dt-bindings documentation.
 - Change existing node name to match NAND controller DT bingings.
 - Fix issues reported by dt_binding_check.
 - Fix issues reported by dtbs_check.

Xiangsheng Hou (5):
  dt-bindings: mtd: Split ECC engine with rawnand controller
  arm64: dts: mediatek: Fix existing NAND controller node name
  arm: dts: mediatek: Fix existing NAND controller node name
  dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986
  mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC

 .../bindings/mtd/mediatek,mtk-nfc.yaml        | 155 +++++++++++++++
 .../mtd/mediatek,nand-ecc-engine.yaml         |  63 +++++++
 .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/mt2701.dtsi                 |   2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   2 +-
 drivers/mtd/nand/ecc-mtk.c                    |  28 ++-
 8 files changed, 247 insertions(+), 183 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt

-- 
2.25.1

