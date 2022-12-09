Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31D6480E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLIKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLIKYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:24:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751761BB3;
        Fri,  9 Dec 2022 02:24:37 -0800 (PST)
X-UUID: 6c3d77e6b1064e0abe357d627789c462-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3vmtq1hOZ3NbQLZ244kSlJ++oJfu1QbFDSzp2jnz5lg=;
        b=pQeAKZL++xkmnWz6QI4rhUdZO85/w+oEHf0wygBtuR+wpxi069ZOEOHjrRn1yaFa/Zis0OE2mcLi3JhndusAfHycjZ5oPPZS6jKYs9244RU241bHuA/+Wn3uC8Gj/mQbBGs9aveSQ83ve8CRiG7mSlQQHI97d59RfbPg/kYkkgw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e801ffaf-6d7a-4de4-ae1f-3979c914b0ab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:d15d22d2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6c3d77e6b1064e0abe357d627789c462-20221209
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 991881881; Fri, 09 Dec 2022 18:24:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 18:24:21 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 9 Dec 2022 18:24:20 +0800
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Wang <peter.wang@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        <wsd_upstream@mediatek.com>, Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH v3 1/1] scsi: ufs: core: fix device management cmd timeout flow
Date:   Fri, 9 Dec 2022 18:13:22 +0800
Message-ID: <20221209101321.30671-1-mason.zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Zhang <Mason.Zhang@mediatek.com>

In ufs error handler flow, host will send device management cmd(NOP OUT)
to device for recovery link. If cmd response timeout, and clear doorbell
fail, ufshcd_wait_for_dev_cmd will do nothing and return,
hba->dev_cmd.complete struct not set to null.

In this time, if cmd has been responsed by device, then it will
call complete() in __ufshcd_transfer_req_compl, because of complete
struct is alloced in stack, then the KE will occur.

Fix the following crash:
  ipanic_die+0x24/0x38 [mrdump]
  die+0x344/0x748
  arm64_notify_die+0x44/0x104
  do_debug_exception+0x104/0x1e0
  el1_dbg+0x38/0x54
  el1_sync_handler+0x40/0x88
  el1_sync+0x8c/0x140
  queued_spin_lock_slowpath+0x2e4/0x3c0
  __ufshcd_transfer_req_compl+0x3b0/0x1164
  ufshcd_trc_handler+0x15c/0x308
  ufshcd_host_reset_and_restore+0x54/0x260
  ufshcd_reset_and_restore+0x28c/0x57c
  ufshcd_err_handler+0xeb8/0x1b6c
  process_one_work+0x288/0x964
  worker_thread+0x4bc/0xc7c
  kthread+0x15c/0x264
  ret_from_fork+0x10/0x30

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
changes since v2:
* Modified comment after clear doorbell.
  Updated the patch in v3.
changes since v1:
* Remove change id.
---
 drivers/ufs/core/ufshcd.c | 46 ++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b1f59a5fe632..6fe51b8d41f9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2979,35 +2979,31 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		err = -ETIMEDOUT;
 		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
 			__func__, lrbp->task_tag);
-		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
+		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0)
 			/* successfully cleared the command, retry if needed */
 			err = -EAGAIN;
+		/*
+		 * in case of an error, after clearing the doorbell,
+		 * we also need to clear the task tag bit from the
+		 * outstanding_reqs variable.
+		 */
+		spin_lock_irqsave(&hba->outstanding_lock, flags);
+		pending = test_bit(lrbp->task_tag,
+				   &hba->outstanding_reqs);
+		if (pending) {
+			hba->dev_cmd.complete = NULL;
+			__clear_bit(lrbp->task_tag,
+				    &hba->outstanding_reqs);
+		}
+		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+
+		if (!pending) {
 			/*
-			 * Since clearing the command succeeded we also need to
-			 * clear the task tag bit from the outstanding_reqs
-			 * variable.
+			 * The completion handler ran while we tried to
+			 * clear the command.
 			 */
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			pending = test_bit(lrbp->task_tag,
-					   &hba->outstanding_reqs);
-			if (pending) {
-				hba->dev_cmd.complete = NULL;
-				__clear_bit(lrbp->task_tag,
-					    &hba->outstanding_reqs);
-			}
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-			if (!pending) {
-				/*
-				 * The completion handler ran while we tried to
-				 * clear the command.
-				 */
-				time_left = 1;
-				goto retry;
-			}
-		} else {
-			dev_err(hba->dev, "%s: failed to clear tag %d\n",
-				__func__, lrbp->task_tag);
+			time_left = 1;
+			goto retry;
 		}
 	}
 
-- 
2.18.0

