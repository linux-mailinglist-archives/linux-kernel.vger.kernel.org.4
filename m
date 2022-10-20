Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340C56067E9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJTSIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJTSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:07:32 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74F1805BE;
        Thu, 20 Oct 2022 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666289242; x=1697825242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vpEtP0QDBIcHYXrDKh14KUolY8Al3Y1CLPBeELNmbQI=;
  b=o30H1/3fXqhhBFDav9UGUrv/IPVrTEzi5QWavcr+46O4tmle3HBln0w8
   Hpmb0no4Awdathu+BZdmIC6ZnXLJB94g5d/bFZk9t98du2Dw8EuGEe0rk
   tjiRSEygRV+6R2z+QKHmj3U5R8lI7li4Hgnu4tl/0sKaxeyZZERbJzwLk
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Oct 2022 11:07:21 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:07:21 -0700
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 11:07:20 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <quic_richardp@quicinc.com>,
        "Asutosh Das" <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 15/17] ufs: core: mcq: Add completion support in poll
Date:   Thu, 20 Oct 2022 11:03:44 -0700
Message-ID: <4422b890dd7cb2f4c396669012c4247467c7b8e2.1666288432.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1666288432.git.quic_asutoshd@quicinc.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete cqe requests in poll. Assumption is that
several poll completion may happen in different CPUs
for the same Completion Queue. Hence a spin lock
protection is added.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 13 +++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  2 ++
 drivers/ufs/core/ufshcd.c      |  7 +++++++
 include/ufs/ufshcd.h           |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 7bf5f80..b51ba35 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -379,6 +379,18 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 	return completed_reqs;
 }
 
+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+				       struct ufs_hw_queue *hwq)
+{
+	unsigned long completed_reqs;
+
+	spin_lock(&hwq->cq_lock);
+	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+	spin_unlock(&hwq->cq_lock);
+
+	return completed_reqs;
+}
+
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 {
 	struct ufs_hw_queue *hwq;
@@ -472,6 +484,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 		hwq = &hba->uhq[i];
 		hwq->max_entries = hba->nutrs;
 		spin_lock_init(&hwq->sq_lock);
+		spin_lock_init(&hwq->cq_lock);
 	}
 
 	/* The very first HW queue is to serve device command */
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 417e2ca..6e9bec6 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -64,6 +64,8 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 					 struct ufs_hw_queue *hwq);
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
+				       struct ufs_hw_queue *hwq);
 
 #define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index af1f99e..aaade38 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5439,6 +5439,13 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct ufs_hba *hba = shost_priv(shost);
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
+	struct ufs_hw_queue *hwq;
+
+	if (is_mcq_enabled(hba)) {
+		hwq = &hba->uhq[queue_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+
+		return ufshcd_mcq_poll_cqe_lock(hba, hwq);
+	}
 
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ba4ef0a..506fc6e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1062,6 +1062,7 @@ struct ufs_hba {
  * @sq_lock: serialize submission queue access
  * @cq_tail_slot: current slot to which CQ tail pointer is pointing
  * @cq_head_slot: current slot to which CQ head pointer is pointing
+ * @cq_lock: Synchronize between multiple polling instances
  */
 struct ufs_hw_queue {
 	void __iomem *mcq_sq_head;
@@ -1079,6 +1080,7 @@ struct ufs_hw_queue {
 	spinlock_t sq_lock;
 	u32 cq_tail_slot;
 	u32 cq_head_slot;
+	spinlock_t cq_lock;
 };
 
 static inline bool is_mcq_enabled(struct ufs_hba *hba)
-- 
2.7.4

