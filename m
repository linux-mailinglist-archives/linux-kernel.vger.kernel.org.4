Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5B165C739
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjACTQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbjACTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:38 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCE14019;
        Tue,  3 Jan 2023 11:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1672773264; x=1704309264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9sWwTbia7dLn0fuNVUfv2sfte8/C2vXGJ8QdAOouZ8I=;
  b=vP8HXmApToOnyDg9jW89VSSQMgblrRcqge7ZhUrVEb1OULya+ztVM/mh
   wJnyzLq9aUEgs1zI4xir7TOurTCgEhPCelero14s0vX1TXlRWtO8ZwL4k
   PvbFPFSyyZMCWhSKBor3lN1hHN3a2RH01PN2diB0xZJ8VtEPmb2Z1ldlb
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jan 2023 11:14:23 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:14:23 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 3 Jan 2023 11:14:21 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v12 15/15] ufs: core: mcq: Enable Multi Circular Queue
Date:   Tue, 3 Jan 2023 11:09:34 -0800
Message-ID: <c96ebc8e039edd73b504a5e3ef7d89cab303eeac.1672771664.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1672771664.git.quic_asutoshd@quicinc.com>
References: <cover.1672771664.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MCQ in the Host Controller.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4d31131..8fae2ce 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8455,6 +8455,12 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
 
 	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
 	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
+
+	/* Select MCQ mode */
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
+		      REG_UFS_MEM_CFG);
+	hba->mcq_enabled = true;
+
 	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
 		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
 		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
-- 
2.7.4

