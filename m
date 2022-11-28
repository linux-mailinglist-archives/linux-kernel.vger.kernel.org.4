Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAF639F35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiK1CHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1CHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:07:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB61021;
        Sun, 27 Nov 2022 18:07:38 -0800 (PST)
X-UUID: d1ef2638688e4c00813f811a0d5d5e61-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Vx9r4K8c2AmypEnlXhjtUj3PToclJWeeeHtuSZMQl/0=;
        b=dAllR7dtiduK1fbYK88xkooh17LMapd6qeLL49sWQjvVDX2uU+lCbLlJ4K/a5vjPgBCjAGjcgNdAb4KG1BlFXZl+gSGfNS7bfUKUxwriG56IY8GEzPE6+gVGhSJu4LCfp0yYPo55kBtCJVPny+VROj1Ay/IFk66bocigb141PIA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:c3c7bd27-98d3-4498-b1d3-d64d44e37aa0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:8615f72f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d1ef2638688e4c00813f811a0d5d5e61-20221128
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 398116809; Mon, 28 Nov 2022 10:07:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 28 Nov 2022 10:07:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 28 Nov 2022 10:07:30 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>
Subject: [PATCH 0/9] Add MediaTek MT7986 SPI NAND and ECC support
Date:   Mon, 28 Nov 2022 10:06:04 +0800
Message-ID: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch series add MediaTek MT7986 SPI NAND and ECC controller
support, split ECC engine with rawnand controller in bindings and
change to YAML schema.

Xiangsheng Hou (9):
  spi: mtk-snfi: add snfi support for mt7986 IC
  spi: mtk-snfi: change default page format to setup default setting
  spi: mtk-snfi: add optional nfi_hclk which needed for mt7986
  mtd: nand: ecc-mtk: add ecc support fot mt7986 IC
  dt-bindings: spi: mtk-snfi: add mt7986 IC snfi bindings
  spi: mtk-snfi: add snfi sample delay and read latency adjustment
  dt-bindings: spi: mtk-snfi: add two timing delay property
  dt-bindings: mtd: Split ECC engine with rawnand controller
  dt-bindings: mtd: ecc-mtk: add mt7986 IC ecc bindings

 .../bindings/mtd/mtk,nand-ecc-engine.yaml     |  61 ++++++
 .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
 .../devicetree/bindings/mtd/mtk-nand.yaml     |  92 +++++++++
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |  22 +++
 drivers/mtd/nand/ecc-mtk.c                    |  18 ++
 drivers/spi/spi-mtk-snfi.c                    |  63 ++++++-
 6 files changed, 252 insertions(+), 180 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.yaml

-- 
2.25.1

