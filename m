Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7692B7106C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjEYHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjEYHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:50:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EAD1B4;
        Thu, 25 May 2023 00:50:20 -0700 (PDT)
X-UUID: c9d424aafad011ed9cb5633481061a41-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=luYV5Df8eNuIySHoKHf25sYz2ZzHfnSxqh4z/3Ay/Hg=;
        b=BIfWl0LrldnNUJP3Mf80ubkQnWhS7IylqZ/WtxJoIv6mRFN983sLhNdjBivnUvlzet8sU8F1UYS+GD4D8WwNOU9CqBmewwckojejH8MFK6wGb+DFMZcJywSRTFshBeJW7zyg1QXpYW2xr737JuQHhkIs29RKrcn7IB3MO2El2vs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:0cca4045-b06a-4cb5-8c72-aae01365cf8a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:1505833c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c9d424aafad011ed9cb5633481061a41-20230525
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1563581199; Thu, 25 May 2023 15:50:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 15:50:15 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 15:50:14 +0800
From:   Runyang Chen <runyang.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [PATCH v4 0/2] Add infra_ao reset support for MT8188 Soc
Date:   Thu, 25 May 2023 15:50:09 +0800
Message-ID: <20230525075011.7032-1-runyang.chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on tag: next-20230524, linux-next/master

v4:
1. Remove the attribute constant for infra_ao_rst_ofs and infra_ao_idx_map
since the reset controller driver will modifiy them.

v3:
1. The infra_ao_rst_ofs, infra_ao_idx_map and infra_ao_rst_desc are not
modified by the driver, so constify them.

v2:
1. Modify SoB to match author name.

v1:
1. Add thermal reset bit for MT8188.
2. Add infra_ao reset support for MT8188. 

Runyang Chen (2):
  dt-bindings: reset: mt8188: add thermal reset control bit
  clk: mediatek: reset: add infra_ao reset support for MT8188

 drivers/clk/mediatek/clk-mt8188-infra_ao.c | 24 ++++++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h  |  5 +++++
 2 files changed, 29 insertions(+)

-- 
2.18.0

