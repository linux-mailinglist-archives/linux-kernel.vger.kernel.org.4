Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11F66A473
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjAMUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAMUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:50:53 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283B6C079;
        Fri, 13 Jan 2023 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673643052; x=1705179052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0kiLjROtxQYUY2/1WbO8053RNyPqhhWEiGvj7qJuDm8=;
  b=VWaAu8gFTMxXtCI0l9XDPDTJXbTd8Xu3c4EXYJ5idYdHvws0HNKnjxll
   gplkyz3IYHRVn2lr1BGqMAL4JqScCiYFfghxiP2l/XAXNP+ydgf1Ip70Z
   1vEqO9cxsHbXXoBQy0iguECl4ze6hURzSqICOaDJVlv1z1jk2HjmpT3gV
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jan 2023 12:50:52 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 12:50:51 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 12:50:51 -0800
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 03/15] ufs: core: Defer adding host to scsi if mcq is supported
Date:   Fri, 13 Jan 2023 12:48:40 -0800
Message-ID: <beadf5c0e71976f976e680770961f1aac999e86e.1673557949.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1673557949.git.quic_asutoshd@quicinc.com>
References: <cover.1673557949.git.quic_asutoshd@quicinc.com>
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

If MCQ support is present, enabling it after MCQ support
has been configured would require reallocating tags and memory.
It would also free up the already allocated memory in
Single Doorbell Mode. So defer invoking scsi_add_host() until
MCQ is configured.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 24 ++++++++++++++++++++----
 include/ufs/ufshcd.h      |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 64e0461..2cb05a6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -95,6 +95,11 @@
 /* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
 static bool use_mcq_mode = true;
 
+static bool is_mcq_supported(struct ufs_hba *hba)
+{
+	return hba->mcq_sup && use_mcq_mode;
+}
+
 static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
 {
 	int ret;
@@ -8292,6 +8297,7 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 {
 	int ret;
+	struct Scsi_Host *host = hba->host;
 
 	hba->ufshcd_state = UFSHCD_STATE_RESET;
 
@@ -8326,6 +8332,14 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 		ret = ufshcd_device_params_init(hba);
 		if (ret)
 			return ret;
+		if (is_mcq_supported(hba) && !hba->scsi_host_added) {
+			ret = scsi_add_host(host, hba->dev);
+			if (ret) {
+				dev_err(hba->dev, "scsi_add_host failed\n");
+				return ret;
+			}
+			hba->scsi_host_added = true;
+		}
 	}
 
 	ufshcd_tune_unipro_params(hba);
@@ -9964,10 +9978,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		hba->is_irq_enabled = true;
 	}
 
-	err = scsi_add_host(host, hba->dev);
-	if (err) {
-		dev_err(hba->dev, "scsi_add_host failed\n");
-		goto out_disable;
+	if (!is_mcq_supported(hba)) {
+		err = scsi_add_host(host, hba->dev);
+		if (err) {
+			dev_err(hba->dev, "scsi_add_host failed\n");
+			goto out_disable;
+		}
 	}
 
 	hba->tmf_tag_set = (struct blk_mq_tag_set) {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 514687d..a343bd4 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -996,6 +996,7 @@ struct ufs_hba {
 	u32 luns_avail;
 	bool complete_put;
 	bool ext_iid_sup;
+	bool scsi_host_added;
 	bool mcq_sup;
 };
 
-- 
2.7.4

