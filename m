Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F06AD7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCGGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCGGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:55:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE994D284;
        Mon,  6 Mar 2023 22:55:24 -0800 (PST)
X-UUID: 051e482ebcb511ed945fc101203acc17-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sYDNQt8w5f/hpcyHLM6tkzNVvP8hC8vvC4a39yv5l74=;
        b=X2a2vdl5eitw7Mk1iy4WrWq8HVy0mfgHZRIymFnzA3cHWcO2LAPTVHktD6jh6ul75/Fc/yVVpUSfEZQBouSiXTBQuBkSOcd5YJN/55Zh8CIrLhrBY/FTOB8AbC9Gi0Fnqx7fGoQ3cJQkQDvBW2cVxsL64cxyRN0XES/Ul4usQbM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:32ecddb0-8eed-451c-afac-243e60c9563d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:fefb9027-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 051e482ebcb511ed945fc101203acc17-20230307
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1384182238; Tue, 07 Mar 2023 14:55:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 14:55:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 14:55:16 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>, <mason.zhang@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Subject: [PATCH v4 0/5] Several UFS MCQ Code Changes 
Date:   Tue, 7 Mar 2023 14:54:41 +0800
Message-ID: <20230307065448.15279-1-powen.kao@mediatek.com>
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

v3 -> v4
- Rebase on latest scsi-next/staging
- Drop "scsi: ufs: core: Remove redundant check" since it's already fixed
- Improve commit message as suggested by Manivannan Sadhasivam
- Fix patch check error

v2 -> v3
- Remove "scsi: ufs: core: Add hwq print for debug". 
	send later when error handling is ready.
- Rename patch title to match convention "scsi: ufs: ufs-mediatek:..."
- Add explanation for (nr_hw_queues = MAXQ + 1)
- Remove dummy line

v1 -> v2:
- Add 2 new patches
	- Update MTK driver for mcq
	- Export symbols for MTK driver
- Fix commit message in "scsi: ufs: core: Fix mcq nr_hw_queues"
- Split name change and fix into two patches

Po-Wen Kao (5):
  scsi: ufs: core: Fix mcq tag calcualtion
  scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()
  scsi: ufs: core: Fix mcq nr_hw_queues
  scsi: ufs: core: Export symbols for MTK driver module
  scsi: ufs: ufs-mediatek: Add MCQ support for MTK platform

 drivers/ufs/core/ufs-mcq.c      |   8 +-
 drivers/ufs/core/ufshcd-priv.h  |   2 -
 drivers/ufs/core/ufshcd.c       |  11 +-
 drivers/ufs/host/ufs-mediatek.c | 192 +++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-mediatek.h |  33 ++++++
 include/ufs/ufshcd.h            |   7 +-
 6 files changed, 241 insertions(+), 12 deletions(-)

-- 
2.18.0

