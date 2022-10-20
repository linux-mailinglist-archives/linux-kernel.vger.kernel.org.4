Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662EA60583F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJTHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiJTHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:18:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026081119CC;
        Thu, 20 Oct 2022 00:18:16 -0700 (PDT)
X-UUID: c7ecf2bc78014888a779a2e7cd010958-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=k3wALfF9tSu/uQt3PB2kfmMFgLVgF9FHrguRjLAl7tE=;
        b=PN3JbO9TEs//MXcwtV9FqXF3SMT4WPkUuLg1gKf42gQPPMnLXKJBbcV1G9bHvda1kGQOQfYuEqire5GvncplIiy2sMidd7ebj8Y7QYM9+S4ZG2Al18M8elVF4gMcl8I3QX8jJeCy0ymmopFPvY5sD9DXozHOSXo7LUtDPosnUSQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:ee553859-6a14-4662-a602-68066d9113af,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:c2d065a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c7ecf2bc78014888a779a2e7cd010958-20221020
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 285565856; Thu, 20 Oct 2022 15:18:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 20 Oct 2022 15:18:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 15:18:01 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v3 0/3] Fix error handling for MDP3
Date:   Thu, 20 Oct 2022 15:17:57 +0800
Message-ID: <20221020071800.20487-1-moudy.ho@mediatek.com>
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

Changes since v2:
- Rebase on v6.1-rc1.
- Merge with the following series:
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=683526

Changes since v1:
- Rename goto label in mdp_comp_clock_on() from "err_unwind"
  to "err_revert" to make more readable.

Hi,
This series fixes some error handling in MDP3 in response to the bug report
submitted by Dan Carpenter (Message ID = YxB1E00e8D6P4W2e@kili)

Moudy Ho (3):
  media: platform: mtk-mdp3: fix error handling in mdp_cmdq_send()
  media: platform: mtk-mdp3: fix error handling about components
    clock_on
  media: platform: mtk-mdp3: fix error handling in mdp_probe()

 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 51 ++++++++++---------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 24 ++++++---
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 15 +++---
 3 files changed, 53 insertions(+), 37 deletions(-)

-- 
2.18.0

