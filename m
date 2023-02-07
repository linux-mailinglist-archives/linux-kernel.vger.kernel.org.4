Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1568CC4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBGBsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBGBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:48:18 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE786B1;
        Mon,  6 Feb 2023 17:48:09 -0800 (PST)
X-UUID: 759efe32a68911ed945fc101203acc17-20230207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xfJdDHYM1kIjZH2oKMPB4Dv9VCfW1IAMgum+diCywO0=;
        b=JlsUz3jqlcpktPVP7ZsYLFi9uhriH2E7uV+sCeJNtEWWDPBLWwY0tr5M1L0hvh61+Oyzowjtk5uvFKXYbE/nQEBgwBMn/3qA+Y3muEpRx/D2gDh/rOq5S3lknV4oLqsMEhFeyK9bbTir8Fhi8PQ9Uqrlk99Q8Y3yTK5GDgD0vRk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:fdc50af1-e261-475c-9bc0-12e6779c7c13,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:f7437f56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 759efe32a68911ed945fc101203acc17-20230207
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1120567926; Tue, 07 Feb 2023 09:48:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Feb 2023 09:48:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 7 Feb 2023 09:48:01 +0800
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
Subject: [PATCH v7 0/1] Migrate MT8195 VPPSYS 0/1 to mtk-mmsys drive
Date:   Tue, 7 Feb 2023 09:47:59 +0800
Message-ID: <20230207014800.7619-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v6:
- Rebase on linux-next.
- Drop applied patches [1/4], [2/4] and [4/4].
- In response to the API changes of "mtk_clk_register_gates" and
  "mtk_alloc_clk_data", the patch [3/4] has been modified accordingly.

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

Moudy Ho (1):
  clk: mediatek: remove MT8195 vppsys/0/1 simple_probe

 drivers/clk/mediatek/clk-mt8195-vpp0.c | 58 +++++++++++++++++++-------
 drivers/clk/mediatek/clk-mt8195-vpp1.c | 58 +++++++++++++++++++-------
 2 files changed, 86 insertions(+), 30 deletions(-)

-- 
2.18.0

