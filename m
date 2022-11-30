Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBE63E62D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiLAAIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiLAAGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:06:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E9A95812;
        Wed, 30 Nov 2022 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669852946; x=1701388946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/saQ8HdqSwrP9Ikuh+6P+rYv50pHaQco2YVGANbtHrg=;
  b=L6mtyBYAD/Wb07cr9qdL9/8Uvz7fsHNKQSS6lZhSLGyNUiiIPATjkwJM
   3Jdc12IDaqlVERNwgA2tzePNyEaar0lEaM59yThk9nmmlX7yzkV+YAbBX
   8/p9RhXZNzF/sAYfk0iWyQZGrIPwap87QfXcdgtsCWF5JKwzPiaLS6aTc
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Nov 2022 16:02:26 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:02:25 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 16:02:25 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 12/16] ufs: core: mcq: Find hardware queue to queue request
Date:   Wed, 30 Nov 2022 15:50:44 -0800
Message-ID: <7642a9345da1d53fcefcad279b7e82edcc2c7afb.1669850856.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669850856.git.quic_asutoshd@quicinc.com>
References: <cover.1669850856.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support to find the hardware queue on which the request
would be queued.
Since the very first queue is to serve device commands, an offset
of 1 is added to the index of the hardware queue.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c     | 19 +++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  3 +++
 drivers/ufs/core/ufshcd.c      |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 0c40fe2..151caf3 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -93,6 +93,25 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
 }
 
 /**
+ * ufshcd_mcq_req_to_hwq - find the hardware queue on which the
+ * request would be issued.
+ * @hba - per adapter instance
+ * @req - pointer to the request to be issued
+ *
+ * Returns the hardware queue instance on which the request would
+ * be queued.
+ */
+struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
+					 struct request *req)
+{
+	u32 utag = blk_mq_unique_tag(req);
+	u32 hwq = blk_mq_unique_tag_to_hwq(utag);
+
+	/* uhq[0] is used to serve device commands */
+	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+}
+
+/**
  * ufshcd_mcq_decide_queue_depth - decide the queue depth
  * @hba - per adapter instance
  *
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d295be4..a07f85e 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -67,7 +67,10 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
 void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
+struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
+					   struct request *req);
 
+#define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1639a97..b0b0f2c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2921,6 +2921,9 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		goto out;
 	}
 
+	if (is_mcq_enabled(hba))
+		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+
 	ufshcd_send_command(hba, tag, hwq);
 
 out:
-- 
2.7.4

