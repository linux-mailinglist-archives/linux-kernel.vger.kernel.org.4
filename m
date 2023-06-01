Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF271964F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjFAJDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjFAJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:03:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C710C4;
        Thu,  1 Jun 2023 02:02:47 -0700 (PDT)
X-UUID: fa776718005a11eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nmPyA18HFmF7VUllxvu4R1sfBOHplruxD5sH3Nf1XfU=;
        b=T4VwWdLz80+UY+bVAR/884z6xR3v5RyxEqyBCAx6U44Xxvo6810pdCMdrXBIZOdfIv69Iz7MIHbo7/a0sAFEdEaDJupYxOywrweEyJvKClH6SBWXS6qeBVWfMg5LOZhp1dIbpu5SSG6w02CTcmlnWUTlMjsnBRC8oVcVYURhNYU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:dc36925c-7000-461f-b339-20e579be72b6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:dc36925c-7000-461f-b339-20e579be72b6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:f6dc0e3d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230601170207E6QTFJR0,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: fa776718005a11eeb20a276fd37b9834-20230601
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1831319348; Thu, 01 Jun 2023 17:02:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 17:02:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 17:02:03 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <stanley.chu@mediatek.com>
Subject: [PATCH v1] ufs: core: Remove the nolock version of ufshcd_mcq_poll_cqe()
Date:   Thu, 1 Jun 2023 17:02:02 +0800
Message-ID: <20230601090202.27035-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ufshcd_mcq_poll_cqe_nolock() is no longer used by any users,
it should be removed.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 920eb954f594..785fc9762cad 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -307,11 +307,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 }
 
-static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
-						struct ufs_hw_queue *hwq)
+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+				       struct ufs_hw_queue *hwq)
 {
 	unsigned long completed_reqs = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&hwq->cq_lock, flags);
 	ufshcd_mcq_update_cq_tail_slot(hwq);
 	while (!ufshcd_mcq_is_cq_empty(hwq)) {
 		ufshcd_mcq_process_cqe(hba, hwq);
@@ -321,17 +323,6 @@ static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 
 	if (completed_reqs)
 		ufshcd_mcq_update_cq_head(hwq);
-
-	return completed_reqs;
-}
-
-unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
-				       struct ufs_hw_queue *hwq)
-{
-	unsigned long completed_reqs, flags;
-
-	spin_lock_irqsave(&hwq->cq_lock, flags);
-	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 
 	return completed_reqs;
-- 
2.18.0

