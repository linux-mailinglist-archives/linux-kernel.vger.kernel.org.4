Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB736F6F51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEDPpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjEDPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:45:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9EB199E;
        Thu,  4 May 2023 08:45:10 -0700 (PDT)
X-UUID: 9f97f7a0ea9211ed9cb5633481061a41-20230504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6nZpUG2z8o8BhlSwQn2P1A3JTPzryx4nQ3sH/JpQWvY=;
        b=gsCcHM6dwo1RQOoO/xiCHcz14H3Mmu2RRQnZDgGzkBqTekLdu8jek97P8gjai09S+bH/e/hUw2sZf43nJ3KzDApivW9cAMEwatYn27RSayYDbjHyZ1i3i/bKEvx+IIBeDSx3t0WJgJkLwNTwKQ+mW/AROnHNdTq1PqtYoPp8dXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:d6e37119-6dd3-4ad7-adb2-511a5a0ca0c0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:697ab71,CLOUDID:e57bcebf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 9f97f7a0ea9211ed9cb5633481061a41-20230504
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2008017879; Thu, 04 May 2023 23:44:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 May 2023 23:44:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 May 2023 23:44:56 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: [PATCH v6 0/3] Several UFS MCQ Code Changes
Date:   Thu, 4 May 2023 23:44:48 +0800
Message-ID: <20230504154454.26654-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6
- Also fix call to sizeof_utp_transfer_cmd_desc() in 
`ufshcd_release_sdb_queue()` as suggested by Stanley Chu

v4 -> v5
- Send MTK driver MCQ support as independent patch and address Bart's 
comment there
    "[PATCH v1 0/2] Add MCQ support for MTK platform"

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

Po-Wen Kao (3):
  scsi: ufs: core: Fix mcq tag calcualtion
  scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()
  scsi: ufs: core: Fix mcq nr_hw_queues

 drivers/ufs/core/ufs-mcq.c |  5 +++--
 drivers/ufs/core/ufshcd.c  | 10 +++++-----
 include/ufs/ufshcd.h       |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.18.0

