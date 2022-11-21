Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9563221A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiKUMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiKUMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:30:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559AB7E9D;
        Mon, 21 Nov 2022 04:30:09 -0800 (PST)
X-UUID: b8a7040ecb154a14ab771569cd2a09d6-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZwqPOKoKMm0AWKiPPVru/YWszwi30e2Q4/lpqb4TXBM=;
        b=aJesibmmBc6DTGGWcMFwhOlKXxyp53JSU62EUnpYuDLjHanHmgAHzEYeL4nFHIf3X0IeYCEqNAIS4A/6SKYoS3OUgS3nt9q2Es9FKVvXOLwv6B4g6rWidHaDXofBa2UljKk8bTtyAzR+x5sP7cjzA+dXPkmsFRUmrPFZ9FhGZW4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:fadf2fbd-4ac3-495f-84bd-c2231dfc2789,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d12e911,CLOUDID:bb1f622f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b8a7040ecb154a14ab771569cd2a09d6-20221121
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1144589622; Mon, 21 Nov 2022 20:30:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 20:29:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 20:29:58 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v5 0/4] Introduce MediaTek frequency hopping driver
Date:   Mon, 21 Nov 2022 20:29:53 +0800
Message-ID: <20221121122957.21611-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
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

The purpose of this serie is to enhance frequency hopping and spread spectrum
clocking feature for MT8186.
We introduce new PLL register APIs and some helpers for FHCTL hardware control.
For MT8186 PLL driver, we replace mtk_clk_register_plls() with newly added API
to support frequency hopping and SSC function for specific PLLs.

Changes in v5:
- Add the reviewed-by tags.
- Move binding document to bindings/clock folder.
- change some coding style in clk-pllfh.c

Changes in v4:
- Fixup iospace error in the binding.
- Use GENMASK marco and remove extra line.

Changes in v3:
- Change binding file name.
- Add some constraints for properties.
- Rename "mediatek,hopping-ssc-percents" to "mediatek,hopping-ssc-percent".
- Add new config symbol.

Changes in v2:
- Use SoC-specific compatible instead of generic one.
- Use standard clocks property and vendor-specific property in dt-binding.
- Remove some unused arguments and fix some coding style.

Johnson Wang (4):
  clk: mediatek: Export PLL operations symbols
  dt-bindings: clock: mediatek: Add new bindings of MediaTek frequency
    hopping
  clk: mediatek: Add new clock driver to handle FHCTL hardware
  clk: mediatek: Change PLL register API for MT8186

 .../bindings/clock/mediatek,mt8186-fhctl.yaml |  53 ++++
 drivers/clk/mediatek/Kconfig                  |   8 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-fhctl.c              | 244 ++++++++++++++++
 drivers/clk/mediatek/clk-fhctl.h              |  26 ++
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |  66 ++++-
 drivers/clk/mediatek/clk-pll.c                |  84 +++---
 drivers/clk/mediatek/clk-pll.h                |  55 ++++
 drivers/clk/mediatek/clk-pllfh.c              | 275 ++++++++++++++++++
 drivers/clk/mediatek/clk-pllfh.h              |  82 ++++++
 10 files changed, 841 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h
 create mode 100644 drivers/clk/mediatek/clk-pllfh.c
 create mode 100644 drivers/clk/mediatek/clk-pllfh.h

-- 
2.18.0

