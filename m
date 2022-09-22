Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA05E5C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIVH34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiIVH3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:29:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A171A1276F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:29:36 -0700 (PDT)
X-UUID: 17fa7c5976a74fefaaf17d8f306b348e-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=t9i+wVl5X4uEc74qZNXqDhZZNxCJi8MHlEGSvqYNcqA=;
        b=rBIRMJqtnAou4Dam3Pvw7htyXeYuBUyf3SOVVp2KktYeLWFQgJZCwHGdrbGXXe5PXa03k21lXz3JVfgdOiMn4G2VK1ucJFyrqW0EGCuZRIWkREYzUUL1m0np+bqod0DIRLZHhr3ugZyaqOr5XyHAJkmZxc/eSt3p8gOxpNY7ZHE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:6a4fc610-a780-43c8-8be9-45eabe187a2f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:1d41b5a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 17fa7c5976a74fefaaf17d8f306b348e-20220922
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1770898571; Thu, 22 Sep 2022 15:29:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 22 Sep 2022 15:29:27 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 22 Sep 2022 15:29:26 +0800
From:   <xinlei.lee@mediatek.com>
To:     <matthias.bgg@gmail.com>, <jason-jh.lin@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <rex-bc.chen@mediatek.com>, <ck.hu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v7,0/3] Add dpi output format control for MT8186
Date:   Thu, 22 Sep 2022 15:29:21 +0800
Message-ID: <1663831764-18169-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Base on the branch of ck-linux-next/mediatek-drm-fixes.

Changes since v6:
1. Different from other ICs, when mt8186 DPI changes the output format,
the mmsys_base+400 register needs to be set to be valid at the same
time.
   In this series, all the situations that mmsys need to be set up are
perfected (not necessarily used in practice).
2. Put the value that controls the mmsys function in mtk-mmsys.h.
3. Encountered the sink ic switched between dual edge and single edge,
perfected setting and clearing mmsys bit operations in mtk_dpi.c.

Changes since v5:
1. Separate the patch that adds edge_cfg_in_mmsys from the patch that
adds mt8186 dpi support.
2. Move the mmsys register definition to mmsys driver.
 
Changes since v4:
1. This series of cancellations is based on the following patches:
   [1] Add MediaTek SoC(vdosys1) support for mt8195
   https://patchwork.kernel.org/project/linux-mediatek/cover/20220711075245.10492-1-nancy.lin@mediatek.com/
   [2] Add MediaTek SoC DRM (vdosys1) support for mt8195
   https://patchwork.kernel.org/project/linux-mediatek/cover/20220804072827.22383-1-nancy.lin@mediatek.com/
2. Added mtk_mmsys_update_bits function in mtk-mmsys.c;
3. MMSYS 0x400 register is modified to MT8186_MMSYS_DPI_OUTPUT_FORMAT;
4. Fix formatting issues.

Changes since v3:
1. Fix formatting issues;
2. Modify the edge output control name & description;
3. Fix the threading problem.

Changes since v2:
1. Modify key nouns in the description;
2. Add the label of jitao to Co-developed-by;
3. Macro definition address lowercase problem and function naming;
4. Add missing a description of this property in the mtk_dpi_conf.

Change since v1:
1. Modify mt8186 compatiable location.
2. Modify MT8186_DPI_OUTPUT_FORMAT name.

When MT8186 outputs dpi signal, it is necessary to add dual edge output
format control in mmsys.

Xinlei Lee (3):
  soc: mediatek: Add mmsys func to adapt to dpi output for
    MT8186
  drm: mediatek: Adjust the dpi output format to MT8186
  drm: mediatek: Add mt8186 dpi compatible to mtk_dpi.c

 drivers/gpu/drm/mediatek/mtk_dpi.c     | 32 ++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
 drivers/soc/mediatek/mt8186-mmsys.h    |  8 +++++++
 drivers/soc/mediatek/mtk-mmsys.c       | 32 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  9 ++++++++
 5 files changed, 83 insertions(+)

-- 
2.18.0

