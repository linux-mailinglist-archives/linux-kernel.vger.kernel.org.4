Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFD63B70E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiK2BVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiK2BVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:21:40 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DA40911;
        Mon, 28 Nov 2022 17:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669684898; x=1701220898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2SzJ0jwsuCZJlIrXRCEL6A2GLsxcfWhau5MzV93JaM0=;
  b=vLzDdfqQdwFowWwE2p/X9kw2rspPABnNQNNNC7ZYKU9x4yoZXKMO0+39
   4MfzuF0e0FjtczDCHUCk0BQsy8PrXDG2uCcPWvedR6F9XkdbKHdMfHM1r
   MdJtGslH4Dedk59/JGlisP/o+GMY/DLEy3OtrjU3VXUhxEfxvECj3luTL
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Nov 2022 17:21:37 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 17:21:37 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 17:21:36 -0800
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 04/16] ufs: core: Defer adding host to scsi if mcq is supported
Date:   Mon, 28 Nov 2022 17:20:45 -0800
Message-ID: <cc28100c0e3037bb07eeaa24d48f64d4b6198c2e.1669684648.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669684648.git.quic_asutoshd@quicinc.com>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
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
---
 drivers/ufs/core/ufshcd.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index eca15b0..3c2220c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -92,6 +92,11 @@
 /* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
 static bool use_mcq_mode = true;
 
+static bool is_mcq_supported(struct ufs_hba *hba)
+{
+        return hba->mcq_sup && use_mcq_mode;
+}
+
 static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
 {
 	int ret;
@@ -8227,6 +8232,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	int ret;
 	unsigned long flags;
 	ktime_t start = ktime_get();
+	struct Scsi_Host *host = hba->host;
 
 	hba->ufshcd_state = UFSHCD_STATE_RESET;
 
@@ -8261,6 +8267,14 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 		ret = ufshcd_device_params_init(hba);
 		if (ret)
 			goto out;
+
+		if (is_mcq_supported(hba)) {
+			ret = scsi_add_host(host, hba->dev);
+			if (ret) {
+				dev_err(hba->dev, "scsi_add_host failed\n");
+				goto out;
+			}
+		}
 	}
 
 	ufshcd_tune_unipro_params(hba);
@@ -9857,10 +9871,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
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
-- 
2.7.4

