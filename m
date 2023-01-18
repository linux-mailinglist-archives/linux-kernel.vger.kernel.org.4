Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B667E6711A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjARDPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjARDP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:15:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2244FCD8;
        Tue, 17 Jan 2023 19:15:18 -0800 (PST)
X-UUID: 517e419496de11eda06fc9ecc4dadd91-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VYyGa98n/lDxtXIVrq/pkqd0oUm89Hudm4lrrG5jFYc=;
        b=tpekYALEOL5rkAc8cDUde3O3hZm5be/DqVQV5BceKbkgopGlSWNbG1PbvYzQmVCQeGG8TnaPDd3dkP7lGFGS4jZCjcEpb88dxoGCLBkP9DbTQiqEF5xX6fjJ0o0HpRo/dVAZCAo4ewPkeLgm4SZhAE68o+SJ0zGSuMod0t+Cyro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:56a4447a-bb4a-44c8-afb2-34260f8966f9,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:6deb1ff6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 517e419496de11eda06fc9ecc4dadd91-20230118
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 503731731; Wed, 18 Jan 2023 11:15:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 11:15:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 11:15:10 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 0/4] Migrate MT8195 VPPSYS 0/1 to mtk-mmsys driver
Date:   Wed, 18 Jan 2023 11:15:05 +0800
Message-ID: <20230118031509.29834-1-moudy.ho@mediatek.com>
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

Change since v5:
- Rebase on linux-next.
- Correct the compatible enumeration order in "mediatek,mmsys.yaml".

Hi,

This series splits patches from the original mailing list below:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=711592

Refer to the comments of 0/8 and 1/8 in the following series:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=702518
All about the MT8195 VPPSYS 0/1 should be probed from the "mtk-mmsys"
driver, which then starts its own clock driver as the platform driver.

Moudy Ho (3):
  dt-bindings: arm: mediatek: migrate MT8195 vppsys0/1 to mtk-mmsys
    driver
  dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS
  clk: mediatek: remove MT8195 vppsys/0/1 simple_probe

Roy-CW.Yeh (1):
  soc: mediatek: mmsys: add support for MT8195 VPPSYS

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |  2 +
 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 16 -----
 drivers/clk/mediatek/clk-mt8195-vpp0.c        | 58 ++++++++++++++-----
 drivers/clk/mediatek/clk-mt8195-vpp1.c        | 58 ++++++++++++++-----
 drivers/soc/mediatek/mtk-mmsys.c              | 22 +++++++
 drivers/soc/mediatek/mtk-mmsys.h              |  1 +
 6 files changed, 111 insertions(+), 46 deletions(-)

-- 
2.18.0

