Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB76534C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLURNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiLURN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:13:29 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEBDF3B;
        Wed, 21 Dec 2022 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671642772; x=1703178772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8IOTuB+8Ad2/OGIgq5ka1v1MJ4sGiD2XFigPFJRuK+c=;
  b=t/+PR99XzmCjK3WHWp7nRMLJ8MpnEesxhxwZz/oaSRsxwGtCIoRwUFHj
   uivoHV3f8IppVzvHFC8UONeeBulwUDMog210jzbq8CX1kVRVoJjPmCtAI
   yr/4tPR+0ZyCRkqTMWjvsI3ryayKqAoUpOWFBT5CFCG5O88mC3VQTfWdJ
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Dec 2022 09:12:51 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 09:12:51 -0800
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 09:12:47 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH 1/2] scsi: ufs: core: Add hibernation callbacks
Date:   Wed, 21 Dec 2022 22:42:21 +0530
Message-ID: <20221221171222.19699-2-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221221171222.19699-1-quic_ahari@quicinc.com>
References: <20221221171222.19699-1-quic_ahari@quicinc.com>
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

Add hibernation call backs - freeze, restore and thaw.
Add the respective prototypes.

Signed-off-by: Anjana Hari <quic_ahari@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 80 +++++++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h      |  6 +++
 2 files changed, 86 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bda61be5f035..c216a97dc1dd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9453,6 +9453,25 @@ static int ufshcd_resume(struct ufs_hba *hba)
 
 	/* enable the host irq as host controller would be active soon */
 	ufshcd_enable_irq(hba);
+
+	if (hba->restore) {
+		/* Configure UTRL and UTMRL base address registers */
+		ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
+			      REG_UTP_TRANSFER_REQ_LIST_BASE_L);
+		ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
+			      REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+		ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
+			      REG_UTP_TASK_REQ_LIST_BASE_L);
+		ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
+			      REG_UTP_TASK_REQ_LIST_BASE_H);
+		/* Commit the registers */
+		mb();
+	}
+
+	/* Resuming from hibernate, assume that link was OFF */
+	if (hba->restore)
+		ufshcd_set_link_off(hba);
+
 	goto out;
 
 disable_vreg:
@@ -9616,6 +9635,67 @@ void ufshcd_remove(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_remove);
 
+int ufshcd_system_freeze(struct device *dev)
+{
+
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	int ret = 0;
+
+	/*
+	 * Run time resume the controller to make sure
+	 * the PM work queue threads do not try to resume
+	 * the child (scsi host), which leads to errors as
+	 * the controller is not yet resumed.
+	 */
+	pm_runtime_get_sync(hba->dev);
+	ret = ufshcd_system_suspend(dev);
+	pm_runtime_put_sync(hba->dev);
+
+	/*
+	 * Ensure no runtime PM operations take
+	 * place in the hibernation and restore sequence
+	 * on successful freeze operation.
+	 */
+	if (!ret)
+		pm_runtime_disable(hba->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_freeze);
+
+int ufshcd_system_restore(struct device *dev)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	int ret = 0;
+
+	hba->restore = true;
+	ret = ufshcd_system_resume(dev);
+
+	/*
+	 * Now any runtime PM operations can be
+	 * allowed on successful restore operation
+	 */
+	if (!ret)
+		pm_runtime_enable(hba->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_restore);
+
+int ufshcd_system_thaw(struct device *dev)
+{
+
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = ufshcd_system_resume(dev);
+	if (!ret)
+		pm_runtime_enable(hba->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_thaw);
+
 /**
  * ufshcd_dealloc_host - deallocate Host Bus Adapter (HBA)
  * @hba: pointer to Host Bus Adapter (HBA)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 5cf81dff60aa..dadb3c732be4 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -978,6 +978,9 @@ struct ufs_hba {
 #endif
 	u32 luns_avail;
 	bool complete_put;
+
+	/* Distinguish between resume and restore */
+	bool restore;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -1101,6 +1104,9 @@ extern int ufshcd_runtime_resume(struct device *dev);
 extern int ufshcd_system_suspend(struct device *dev);
 extern int ufshcd_system_resume(struct device *dev);
 #endif
+extern int ufshcd_system_freeze(struct device *dev);
+extern int ufshcd_system_thaw(struct device *dev);
+extern int ufshcd_system_restore(struct device *dev);
 extern int ufshcd_shutdown(struct ufs_hba *hba);
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

