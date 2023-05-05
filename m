Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8993A6F826F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjEEMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjEEMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:01:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1D1A63F;
        Fri,  5 May 2023 05:01:15 -0700 (PDT)
X-UUID: 87387a68eb3c11edb20a276fd37b9834-20230505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=luAbm/cIf5DEjsuZn9nfRPhegMwL+AJHD3PniRM34VE=;
        b=KR/+bcp61QlUR5OeosRVygtHBWKYPt/882cl7tgij11yW++IsPXoksva6ErcI9HuSWztPOQufnMDQ0/PfaDWSNDTLctCRYQtKwnPPJr+KRz4oc3caazuWUi/S3QUf1+Pss0sAaA7BNDfnTNw+8rDYEoAiYDlZZP5/sJmmwXQcc0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:22f102bc-0398-402f-be35-4ebf1c4b3e6a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:68aedd30-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 87387a68eb3c11edb20a276fd37b9834-20230505
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1281634735; Fri, 05 May 2023 20:01:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 May 2023 20:01:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 5 May 2023 20:01:10 +0800
From:   Runyang Chen <runyang.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [PATCH 0/2] Add infra_ao reset support for MT8188 Soc
Date:   Fri, 5 May 2023 20:01:06 +0800
Message-ID: <20230505120108.26603-1-runyang.chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on tag: next-20230504, linux-next/master

1. Add thermal reset bit for MT8188.
2. Add infra_ao reset support for MT8188.

Runyang Chen (2):
  dt-bindings: reset: mt8188: add thermal reset control bit
  clk: mediatek: reset: add infra_ao reset support for  MT8188

 drivers/clk/mediatek/clk-mt8188-infra_ao.c | 24 ++++++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h  |  5 +++++
 2 files changed, 29 insertions(+)

-- 
2.18.0

