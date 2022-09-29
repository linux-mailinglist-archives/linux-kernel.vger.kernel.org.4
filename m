Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CD5EF4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiI2Lqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiI2Lql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:46:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E7112666;
        Thu, 29 Sep 2022 04:46:35 -0700 (PDT)
X-UUID: 9a6424274c814cd4bc489c8d6aad0c69-20220929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rLy55ox0mqF8121Buqk4aymTEF8+D74q/C0Yb4uXas8=;
        b=QyKqGegNKOigxlq2xTRnReS4xVo1ghgKtxTBiu1x8oEhJkGyDj/9+s/ifjmH1rx0T6aWV+dGps4P5TbDAUzBwzmJKWskzvHwudHE/y/vDnrUy3NzfH7oC3Y88rV+JuFetdSEQsQFNboB6yPjddifzbh9GTJLsRlfDSKF4LG+OkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:2d663e78-22f6-4992-879c-fdde8247ef9d,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:abd080a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9a6424274c814cd4bc489c8d6aad0c69-20220929
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 722265442; Thu, 29 Sep 2022 19:46:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 29 Sep 2022 19:46:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 29 Sep 2022 19:46:29 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <kuan-hsin.lee@mediatek.com>, <yu-chang.wang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v3 0/4] Introduce MediaTek frequency hopping driver
Date:   Thu, 29 Sep 2022 19:46:20 +0800
Message-ID: <20220929114624.16809-1-johnson.wang@mediatek.com>
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

The purpose of this serie is to enhance frequency hopping and spread spectrum
clocking feature for MT8186.
We introduce new PLL register APIs and some helpers for FHCTL hardware control.
For MT8186 PLL driver, we replace mtk_clk_register_plls() with newly added API
to support frequency hopping and SSC function for specific PLLs.

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
  dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency
    hopping
  clk: mediatek: Add new clock driver to handle FHCTL hardware
  clk: mediatek: Change PLL register API for MT8186

 .../arm/mediatek/mediatek,mt8186-fhctl.yaml   |  53 ++++
 drivers/clk/mediatek/Kconfig                  |   8 +
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-fhctl.c              | 244 ++++++++++++++++
 drivers/clk/mediatek/clk-fhctl.h              |  26 ++
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |  66 ++++-
 drivers/clk/mediatek/clk-pll.c                |  84 +++---
 drivers/clk/mediatek/clk-pll.h                |  56 ++++
 drivers/clk/mediatek/clk-pllfh.c              | 268 ++++++++++++++++++
 drivers/clk/mediatek/clk-pllfh.h              |  82 ++++++
 10 files changed, 835 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-fhctl.yaml
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h
 create mode 100644 drivers/clk/mediatek/clk-pllfh.c
 create mode 100644 drivers/clk/mediatek/clk-pllfh.h

-- 
2.18.0

