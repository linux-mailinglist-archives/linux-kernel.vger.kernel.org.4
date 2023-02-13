Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34F693CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBMDiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBMDiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:38:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF447CA0A;
        Sun, 12 Feb 2023 19:38:07 -0800 (PST)
X-UUID: d27f60d6ab4f11ed945fc101203acc17-20230213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YUWJmyhlDYB5cTBSBlmb/D5Ily8/sKkqH6+pupsZkfY=;
        b=bnaYg+n/PGL0nVTsUBsTRi6bAoL38bxplqG56f72vZmfrFLEVajOpu43ESZVvuC1bnrv9HE9wlGEuFhM+4dMOK7zNhkYMLd5dc5hHIPIq8cUjGutlYTDCOBqUSesqhHj7ndD0QK8YaHUrbsyf53kYjUo52sPn7oBQYo7DZozaQo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:8b1c1efd-67f2-4610-8f54-21c36f3631e0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:ff6dad8e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: d27f60d6ab4f11ed945fc101203acc17-20230213
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1625518390; Mon, 13 Feb 2023 11:38:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Feb 2023 11:38:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 13 Feb 2023 11:38:02 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6 00/12] Add support for MT8195 SCP 2nd core
Date:   Mon, 13 Feb 2023 11:37:46 +0800
Message-ID: <20230213033758.16681-1-tinghan.shen@mediatek.com>
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

The mediatek remoteproc driver currently only allows bringing up a 
single core SCP, e.g. MT8183. It also only bringing up the 1st 
core in SoCs with a dual-core SCP, e.g. MT8195. This series support 
to bring-up the 2nd core of the dual-core SCP.

v5 -> v6:
1. move the mtk_scp_of_regs structure from mtk_common.h to mtk_scp.c
2. rename the SCP core 0 label from 'scp' to 'scp_c0'

v4 -> v5:
1. move resource release actions to the platform driver remove operation 
2. fix dual-core watchdog handling

v3 -> v4:
1. change the representation of dual-core SCP in dts file and update SCP yaml
2. rewrite SCP driver to reflect the change of dts node
3. drop 'remove redundant call of rproc_boot for SCP' in v3 for further investigation

v2 -> v3:
1. change the representation of dual-core SCP in dts file and update SCP yaml
2. rewrite SCP driver to reflect the change of dts node
3. add SCP core 1 node to mt8195.dtsi
4. remove redundant call of rproc_boot for SCP
5. refine IPI error message

v1 -> v2:
1. update dt-binding property description
2. remove kconfig for scp dual driver
3. merge mtk_scp_dual.c and mtk_scp_subdev.c to mtk_scp.c

Tinghan Shen (12):
  dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
    definition
  arm64: dts: mediatek: mt8183-kukui: Update the node name of SCP rpmsg
    subnode
  dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
  remoteproc: mediatek: Add SCP core 1 register definitions
  remoteproc: mediatek: Add MT8195 SCP core 1 operations
  remoteproc: mediatek: Extract remoteproc initialization flow
  remoteproc: mediatek: Probe multi-core SCP
  remoteproc: mediatek: Control SCP core 1 by rproc subdevice
  remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
  remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
  remoteproc: mediatek: Refine ipi handler error message
  arm64: dts: mediatek: mt8195: Add SCP 2nd core

 .../bindings/remoteproc/mtk,scp.yaml          | 176 +++++++-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   6 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  32 +-
 drivers/remoteproc/mtk_common.h               |  40 ++
 drivers/remoteproc/mtk_scp.c                  | 399 ++++++++++++++++--
 6 files changed, 596 insertions(+), 59 deletions(-)

-- 
2.18.0

