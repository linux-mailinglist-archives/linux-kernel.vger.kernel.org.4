Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82466642327
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiLEG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLEG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:58:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B792646B;
        Sun,  4 Dec 2022 22:58:11 -0800 (PST)
X-UUID: a3a80874b9d341eaa3ea2d482bba77fb-20221205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=87AgBQA4Kxp3UrxJ6BvkvJGYQQbPRDGXT5DDNc+MxfM=;
        b=V5gDgz/utsO8vaEu3GIjZW/f6OfsmM3TClU7R9C2IAzbeXn3CJLu1RwQRv/dl/iDcNy55+oFTzoJP1iF52egcYQcuaEdZCnV6H7hLMJn7Gl0vAuaFZxc3aQfAMASvdMIaxEcsGjM3FN4yZYa3h4cyujubx53AJWndlIEP8ZN7Ys=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:5976dcb3-6b79-448e-a262-19113ac1c6a3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:063aae30-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a3a80874b9d341eaa3ea2d482bba77fb-20221205
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1266026694; Mon, 05 Dec 2022 14:58:08 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Dec 2022 14:58:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 5 Dec 2022 14:58:07 +0800
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
Subject: [PATCH v2 0/9] Add MediaTek MT7986 SPI NAND and ECC support
Date:   Mon, 5 Dec 2022 14:57:47 +0800
Message-ID: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
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
hange to YAML schema.

Changes since V1:
 - Use existing sample delay property.
 - Add restricting for optional nfi_hclk.
 - Improve and perfect dt-bindings documentation.
 - Change existing node name to match NAND controller DT bingings.
 - Fix issues reported by dt_binding_check.
 - Fix issues reported by dtbs_check.

Xiangsheng Hou (9):
  spi: mtk-snfi: Add snfi support for MT7986 IC
  spi: mtk-snfi: Change default page format to setup default setting
  spi: mtk-snfi: Add optional nfi_hclk which needed for MT7986
  mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
  dt-bindings: spi: mtk-snfi: Add compatible for MT7986
  spi: mtk-snfi: Add snfi sample delay and read latency adjustment
  dt-bindings: spi: mtk-snfi: Add read latch latency property
  dt-bindings: mtd: Split ECC engine with rawnand controller
  dt-bindings: mtd: ecc-mtk: Add compatible for MT7986

 .../bindings/mtd/mediatek,mtk-nfc.yaml        | 171 +++++++++++++++++
 .../mtd/mediatek,nand-ecc-engine.yaml         |  63 +++++++
 .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |  58 +++++-
 arch/arm/boot/dts/mt2701.dtsi                 |   2 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   2 +-
 drivers/mtd/nand/ecc-mtk.c                    |  18 ++
 drivers/spi/spi-mtk-snfi.c                    |  66 ++++++-
 9 files changed, 366 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt

-- 
2.25.1

