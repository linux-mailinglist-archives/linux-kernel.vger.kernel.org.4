Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1335D607554
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJUKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJUKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:48:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B969F25F1F7;
        Fri, 21 Oct 2022 03:48:13 -0700 (PDT)
X-UUID: b00653b77ee447afa4044856913d0c72-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DbI+VFEpwZQBeOIPO4jcqRrPafQmJp0JARcLwtkfCNY=;
        b=tRxGjD1q6KdYTofUgVF8TCEV/cd+LsdFL+mQ/4j+Ub8CdwfXVA7J5e0lCyCSOIU5D+GTT+z6EtiXJS8tYXUeaZT8WwLjP0A0xQ37hPzJ6Hbv2Eu3Wt2fU0JoPnSOSvi78VbMBQd1quT/DDzzzVYiwjOjvgOT1ndOJt+sDKVTIp8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b4e9910a-738f-4f65-9370-4145e7d6cc33,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:b4e9910a-738f-4f65-9370-4145e7d6cc33,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:cbbe47c8-03ab-4171-989e-341ab5339257,B
        ulkID:221021184808BN2AFONI,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b00653b77ee447afa4044856913d0c72-20221021
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1798439068; Fri, 21 Oct 2022 18:48:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 18:48:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 18:48:05 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <miles.chen@mediatek.com>,
        <wenst@chromium.org>, <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v6 0/3] Move mediatek system clock reset to reset folder
Date:   Fri, 21 Oct 2022 18:48:01 +0800
Message-ID: <20221021104804.21391-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
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

This series move mediatek system clock reset to drivers/reset/mediatek.

Changes for v6:
1. Separate patches.
   a. Move data and drivers to reset/mediatek.
   b. Implement auxiliary bus driver in clk/mediatek/clk-mtk.c.
   c. Implement auxiliary bus interface in reset/mediatek.
2. This version is based on 6.1-rc1.

Changes for v5:
1. Replace reset-mtxxxx.h with reset-mtxxxx.c and after using this,
   we don't need to add many "#if #endif" in reset-mediatek-sysclk.c.
2. Use mediatek clock common KConfig to control whether to build in
   reset-mtxxxx.c.
3. Rebased on linux-next-1007.

Changes for v4:
1. Rebased oo linux-next-1004.
2. Move reset data which are scattered around the mediatek drivers to
   reset-mtxxxx.h.
3. Add reset data of mt6795.

Version for this series:
v5 : https://lore.kernel.org/all/20221007104842.13164-1-rex-bc.chen@mediatek.com/
v4 : https://lore.kernel.org/all/20221005051145.29676-1-rex-bc.chen@mediatek.com/
v3 : https://lore.kernel.org/all/20220929121031.17523-1-rex-bc.chen@mediatek.com/
v2 : https://lore.kernel.org/all/20220923045738.2027-1-rex-bc.chen@mediatek.com/
v1 : https://lore.kernel.org/all/20220922141107.10203-1-rex-bc.chen@mediatek.com/
RFC: https://lore.kernel.org/all/20220527090355.7354-1-rex-bc.chen@mediatek.com/

Bo-Chen Chen (3):
  reset: mediatek: Move MediaTek system clock reset to reset/mediatek
  clk: mediatek: Add auxiliary bus support for sysclk reset
  reset: mediatek: Add auxiliary bus support for sysclk

 drivers/clk/mediatek/Kconfig                  |   2 +
 drivers/clk/mediatek/Makefile                 |   2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701.c             |  22 +-
 drivers/clk/mediatek/clk-mt2712.c             |  22 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c    |  22 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c     |  20 +-
 drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt7622.c             |  22 +-
 drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt8135.c             |  23 +-
 drivers/clk/mediatek/clk-mt8173.c             |  22 +-
 drivers/clk/mediatek/clk-mt8183.c             |  15 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c    |  23 +-
 drivers/clk/mediatek/clk-mt8192.c             |  27 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  28 +-
 drivers/clk/mediatek/clk-mtk.c                |  62 ++-
 drivers/clk/mediatek/clk-mtk.h                |   8 +-
 drivers/clk/mediatek/reset.c                  | 233 -----------
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/mediatek/Kconfig                |   6 +
 drivers/reset/mediatek/Makefile               |  13 +
 .../reset/mediatek/reset-mediatek-sysclk.c    | 389 ++++++++++++++++++
 drivers/reset/mediatek/reset-mt2701.c         | 102 +++++
 drivers/reset/mediatek/reset-mt2712.c         |  42 ++
 drivers/reset/mediatek/reset-mt6795.c         |  61 +++
 drivers/reset/mediatek/reset-mt7622.c         |  91 ++++
 drivers/reset/mediatek/reset-mt7629.c         |  62 +++
 drivers/reset/mediatek/reset-mt8135.c         |  43 ++
 drivers/reset/mediatek/reset-mt8173.c         |  43 ++
 drivers/reset/mediatek/reset-mt8183.c         |  31 ++
 drivers/reset/mediatek/reset-mt8186.c         |  39 ++
 drivers/reset/mediatek/reset-mt8192.c         |  43 ++
 drivers/reset/mediatek/reset-mt8195.c         |  44 ++
 .../linux/reset/reset-mediatek-sysclk.h       |  61 +--
 40 files changed, 1142 insertions(+), 557 deletions(-)
 delete mode 100644 drivers/clk/mediatek/reset.c
 create mode 100644 drivers/reset/mediatek/Kconfig
 create mode 100644 drivers/reset/mediatek/Makefile
 create mode 100644 drivers/reset/mediatek/reset-mediatek-sysclk.c
 create mode 100644 drivers/reset/mediatek/reset-mt2701.c
 create mode 100644 drivers/reset/mediatek/reset-mt2712.c
 create mode 100644 drivers/reset/mediatek/reset-mt6795.c
 create mode 100644 drivers/reset/mediatek/reset-mt7622.c
 create mode 100644 drivers/reset/mediatek/reset-mt7629.c
 create mode 100644 drivers/reset/mediatek/reset-mt8135.c
 create mode 100644 drivers/reset/mediatek/reset-mt8173.c
 create mode 100644 drivers/reset/mediatek/reset-mt8183.c
 create mode 100644 drivers/reset/mediatek/reset-mt8186.c
 create mode 100644 drivers/reset/mediatek/reset-mt8192.c
 create mode 100644 drivers/reset/mediatek/reset-mt8195.c
 rename drivers/clk/mediatek/reset.h => include/linux/reset/reset-mediatek-sysclk.h (60%)

-- 
2.18.0

