Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDB6A038E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjBWIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBWIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:13:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7630498A7;
        Thu, 23 Feb 2023 00:13:21 -0800 (PST)
X-UUID: ece20870b35111eda06fc9ecc4dadd91-20230223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YLIxiEb1cilPuX9DuE8E0rsewYeVs5NMW4uGMqSO9Ws=;
        b=TC5M2eFhr9Erunh+8rZLGQsPm/+TJCqIb83ZLfl6g4r6iAE9WS7gPRAJMt3WCm2XPWRvOMYG68tj/y4IUErDXhVfGXsGoPEhNYrHscHR3GUzxrdGMiT+ikDK6AzpaOCywFsf3GqHcdv18VkZaEUk+pvjzSLTbEiv6PYfvSa9IfE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:949de6f6-45f4-4cd9-9fb3-52f0458d3741,IP:0,U
        RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-30
X-CID-META: VersionHash:25b5999,CLOUDID:2a0159b1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: ece20870b35111eda06fc9ecc4dadd91-20230223
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1655896104; Thu, 23 Feb 2023 16:13:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 23 Feb 2023 16:13:15 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 23 Feb 2023 16:13:14 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: [V1,0/7] Fixes jpeg crash issue in cuj test
Date:   Thu, 23 Feb 2023 16:13:05 +0800
Message-ID: <20230223081312.29296-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: kyrie wu <kyrie.wu@mediatek.com>

This series is used to fix jpeg dec & enc crash in cuj test.
The problem was found frequently that executing CUJ
ui.EverydayMultiTaskingCUJ.*_ytmusic test cases on Tomato/Dojo
devices with the HW jpeg decoder enabled. Firstly the single core
and multi-core judgment methods were modified to make the driver
compatible with both cases. Secondly, the jpeg dec & enc worker
initialization method and the timing issue of remove buffer
were corrected, eliminating crash problems. Finally, some variables
and hw dev initialization methods are refactored to reduce code
redundancy and improve program robustness. 

This series has been tested with MT8195 & MT8188.
Jpeg encoding and decoding worked for these devices.

Patch 1 fixes single core and multi-core judgment methods.

Patch 2 optimized jpeg single core initial methods.

Patch 3 optimized sw flow of jpeg enc&dec worker to remove buffer.

Patch 4 reconstructs the initialization mode of worker.

Patch 5 Remove some unnecessary variables.

Patch 6 refactor some variables.

Patch 7 refactor hw dev initializaiton sw flow.

kyrie wu (7):
  media: mtk-jpeg: Fixes jpeghw multi-core judgement
  media: mtk-jpeg: add jpeg single core initial function
  media: mtk-jpeg: Fixes jpeg enc&dec worker sw flow
  media: mtk-jpeg: reconstructs the initialization mode of worker
  media: mtk-jpeg: Remove some unnecessary variables
  media: mtk-jpeg: refactor some variables
  media: mtk-jpeg: refactor hw dev initializaiton

 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 130 +++++++++++-------
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  28 ++--
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |  43 ++----
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  |  38 ++---
 4 files changed, 113 insertions(+), 126 deletions(-)

-- 
2.18.0

