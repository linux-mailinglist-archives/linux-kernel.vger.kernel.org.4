Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA0725573
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbjFGHWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbjFGHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:22:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12190E6B;
        Wed,  7 Jun 2023 00:22:32 -0700 (PDT)
X-UUID: 0cc1019c050411eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DugwERicVNZQtD6ohWt/9kDbzxXZd6riohBGwe5iSKc=;
        b=EFM9QT9j1w4RuGTJZBwZCWnp91IaRtDGGY490mY5SOFAOS7YKl8d4EePhnc260XcV+7/ZtD1cUK+41dZMBJzZStFK87GUkxagApzhL17AbnV7RH3KpSzF3Amrng9OKV7hv4HIqCkTkDcD0tQdjoAHJK0FRBtp197YxDerG/hOUQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:2bba9d7c-e0cb-4d67-ab1b-a59077ab65bf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:135cd63d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0cc1019c050411eeb20a276fd37b9834-20230607
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2082849782; Wed, 07 Jun 2023 15:22:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 15:22:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 15:22:23 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Tinghan Shen" <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v13 00/11] Add support for MT8195 SCP 2nd core
Date:   Wed, 7 Jun 2023 15:22:11 +0800
Message-ID: <20230607072222.8628-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mediatek remoteproc driver currently only allows bringing up a 
single core SCP, e.g. MT8183. It also only bringing up the 1st 
core in SoCs with a dual-core SCP, e.g. MT8195. This series support 
to bring-up the 2nd core of the dual-core SCP.

v12 -> v13:
1. replace subdevice with new mediatek scp operations in patchset 7 
2. add review tag to patchset 3
3. modify mediatek,scp phandle name of video-codec@18000000 at patchset 11

v11 -> v12:
1. add scp_add_single/multi_core() to patchset 6
2. remove unused comment in patchset 6
3. rename list name from mtk_scp_cluster to mtk_scp_list
4. rewrite the multi-core probe flow 
5. disable rproc->autoboot and boot rproc by request_firmware_nowait at patchset 7 
6. remove patchset 7 review tag  

v10 -> v11:
1. rewrite patchset 5 to probe single-core SCP with the cluster list
2. Also in patchset 5, move the pointer of mtk_scp object from the
   platform data property to the driver data property 
3. move the appearance of mtk_scp cluster property to patcheset 7

v9 -> v10:
1. move the global mtk_scp list into the platform device driver data structure
2. remove an unnecessary if() condition

v8 -> v9:
1. initialize l1tcm_size/l1tcm_phys at patchset 05/11 
2. rewrite patchset 06/11 to unify the flow and remove hacks

v7 -> v8:
1. update the node name of mt8192 asurada SCP rpmsg subnode
2. squash register definitions into driver patches
3. initialize local variables on the declaration at patch v8 06/11 

v6 -> v7:
1. merge the mtk_scp_cluster struct into the mtk_scp structure
   at the "Probe multi-core SCP" patch

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


Tinghan Shen (11):
  dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
    definition
  arm64: dts: mediatek: Update the node name of SCP rpmsg subnode
  dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
  remoteproc: mediatek: Add MT8195 SCP core 1 operations
  remoteproc: mediatek: Introduce cluster on single-core SCP
  remoteproc: mediatek: Probe multi-core SCP
  remoteproc: mediatek: Add scp_boot_peers and scp_shutdown_peers
    operations
  remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
  remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
  remoteproc: mediatek: Refine ipi handler error message
  arm64: dts: mediatek: mt8195: Add SCP 2nd core

 .../bindings/remoteproc/mtk,scp.yaml          | 176 +++++++-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |   2 +-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   6 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  32 +-
 drivers/remoteproc/mtk_common.h               |  26 ++
 drivers/remoteproc/mtk_scp.c                  | 425 ++++++++++++++++--
 7 files changed, 594 insertions(+), 75 deletions(-)

-- 
2.18.0

