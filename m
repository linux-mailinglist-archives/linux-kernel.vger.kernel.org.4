Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48BF5BE12C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiITJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiITJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:00:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECE6C741
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:00:49 -0700 (PDT)
X-UUID: a969d42e5bd643a89975026f374740a3-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xz74ODjKzLI1kd5AQq6NQuh8A0wWpa/ATv1pXW7SzHE=;
        b=Gt2+gBF4epAPeHAoaGbP+IrpEeIcSy4WiAc3SRxP+srcYXIGvednipnlT0VWj/hXHUU4jqVcuBh8s7qBUD4IsBS9L3a09tY3qHS5zTGZr0o8yjtomGpfN33UxKSZVHdr7MijZxWpeVv1GRmDU0VevH39Ch1dGGdsMAVswF5fV+Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:6fb545d5-9429-4d58-9445-66d009f0eac1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:6ce1435e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a969d42e5bd643a89975026f374740a3-20220920
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2061648772; Tue, 20 Sep 2022 17:00:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 17:00:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 17:00:39 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 00/18] unify register access and macros
Date:   Tue, 20 Sep 2022 17:00:20 +0800
Message-ID: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to define new macros to generate bits, mask and bitfield, use
common ones instead, e.g. BIT, GENMASK and FIELD_PREP etc.
Due to common register access helpers are defined for MediaTek's phy
drivers, the similar helpers defined by ufs, hdmi and mipi phy drivers
can be removed.

Chunfeng Yun (18):
  phy: mediatek: add a new helper to update bitfield
  phy: mediatek: tphy: remove macros to prepare bitfield value
  phy: mediatek: xsphy: remove macros used to prepare bitfield value
  phy: mediatek: ufs: use common register access helpers
  phy: mediatek: pcie: use new helper to update register bits
  phy: mediatek: hdmi: mt2701: use GENMASK and BIT to generate mask and
    bits
  phy: mediatek: hdmi: mt2701: use FIELD_PREP to prepare bits field
  phy: mediatek: hdmi: mt2701: use common helper to access registers
  phy: mediatek: hdmi: mt8173: use GENMASK to generate bits mask
  phy: mediatek: hdmi: mt8173: use FIELD_PREP to prepare bits field
  phy: mediatek: hdmi: mt8173: use common helper to access registers
  phy: mediatek: hdmi: remove register access helpers
  phy: mediatek: mipi: mt8173: use GENMASK to generate bits mask
  phy: mediatek: mipi: mt8173: use FIELD_PREP to prepare bits field
  phy: mediatek: mipi: mt8173: use common helper to access registers
  phy: mediatek: mipi: mt8183: use GENMASK to generate bits mask
  phy: mediatek: mipi: mt8183: use common helper to access registers
  phy: mediatek: mipi: remove register access helpers

 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c    | 238 ++++++++---------
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c    | 246 ++++++++----------
 drivers/phy/mediatek/phy-mtk-hdmi.c           |  33 ---
 drivers/phy/mediatek/phy-mtk-hdmi.h           |   7 -
 drivers/phy/mediatek/phy-mtk-io.h             |   7 +
 .../phy/mediatek/phy-mtk-mipi-dsi-mt8173.c    | 164 ++++++------
 .../phy/mediatek/phy-mtk-mipi-dsi-mt8183.c    |  74 +++---
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c       |  24 --
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h       |   5 -
 drivers/phy/mediatek/phy-mtk-pcie.c           |  17 +-
 drivers/phy/mediatek/phy-mtk-tphy.c           | 193 +++++---------
 drivers/phy/mediatek/phy-mtk-ufs.c            |  78 ++----
 drivers/phy/mediatek/phy-mtk-xsphy.c          |  46 ++--
 13 files changed, 465 insertions(+), 667 deletions(-)

-- 
2.18.0

