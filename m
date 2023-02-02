Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AD86883D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBBQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjBBQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:11:17 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579B2112;
        Thu,  2 Feb 2023 08:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675354270; x=1706890270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SufDP/AJCHjlP/7LfIT9IK/Dd2f8511HXeJ8pQMG/Bg=;
  b=mWumcvKmhhcGgW6zblzpKpJuh6u2t9JCAEBqDgb7mo0pC3tbO/hwpTOR
   921OlSDirZEqEtDBJQJbA9V4rbnam+mmW0zibIWecrEr6R/U6LxfTLnVl
   havO2ZgMx64Z2/ksgxN3kU2zam8SejVxrq2RVJJV2AvHUqCXnWG0L2/Br
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Feb 2023 08:11:10 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 08:11:10 -0800
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:11:05 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v5 1/1] scsi: ufs: Add hibernation callbacks
Date:   Thu, 2 Feb 2023 21:40:45 +0530
Message-ID: <20230202161045.3956-2-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202161045.3956-1-quic_ahari@quicinc.com>
References: <20230202161045.3956-1-quic_ahari@quicinc.com>
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

Adds freeze, thaw and restore callbacks for hibernate and restore
functionality.

Signed-off-by: Anjana Hari <quic_ahari@quicinc.com>
---
 drivers/ufs/core/ufshcd.c   | 51 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c |  8 +++++-
 include/ufs/ufshcd.h        |  4 +++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ec732e4bbbf4..cabe0b4c0138 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9825,6 +9825,7 @@ static int ufshcd_resume(struct ufs_hba *hba)
 
 	/* enable the host irq as host controller would be active soon */
 	ufshcd_enable_irq(hba);
+
 	goto out;
 
 disable_vreg:
@@ -9988,6 +9989,56 @@ void ufshcd_remove(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_remove);
 
+#ifdef CONFIG_PM_SLEEP
+int ufshcd_system_freeze(struct device *dev)
+{
+
+	return ufshcd_system_suspend(dev);
+
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_freeze);
+
+int ufshcd_system_restore(struct device *dev)
+{
+
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ufshcd_system_resume(dev);
+	if (ret)
+		return ret;
+
+	/* Configure UTRL and UTMRL base address registers */
+	ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
+			REG_UTP_TRANSFER_REQ_LIST_BASE_L);
+	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
+			REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
+			REG_UTP_TASK_REQ_LIST_BASE_L);
+	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
+			REG_UTP_TASK_REQ_LIST_BASE_H);
+	/*
+	 * Make sure that UTRL and UTMRL base address registers
+	 * are updated with the latest queue addresses. Only after
+	 * updating these addresses, we can queue the new commands.
+	 */
+	mb();
+
+	/* Resuming from hibernate, assume that link was OFF */
+	ufshcd_set_link_off(hba);
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_restore);
+
+int ufshcd_system_thaw(struct device *dev)
+{
+	return ufshcd_system_resume(dev);
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_thaw);
+#endif /* CONFIG_PM_SLEEP  */
+
 /**
  * ufshcd_dealloc_host - deallocate Host Bus Adapter (HBA)
  * @hba: pointer to Host Bus Adapter (HBA)
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 681da3ea7154..a5243acc1bc8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1714,10 +1714,16 @@ MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
 #endif
 
 static const struct dev_pm_ops ufs_qcom_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
 	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
+#ifdef CONFIG_PM_SLEEP
+	.suspend         = ufshcd_system_suspend,
+	.resume          = ufshcd_system_resume,
+	.freeze          = ufshcd_system_freeze,
+	.restore         = ufshcd_system_restore,
+	.thaw            = ufshcd_system_thaw,
+#endif
 };
 
 static struct platform_driver ufs_qcom_pltform = {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 6d26ff0cc07e..431c3afb2ce0 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1278,8 +1278,12 @@ extern int ufshcd_runtime_resume(struct device *dev);
 #ifdef CONFIG_PM_SLEEP
 extern int ufshcd_system_suspend(struct device *dev);
 extern int ufshcd_system_resume(struct device *dev);
+extern int ufshcd_system_freeze(struct device *dev);
+extern int ufshcd_system_thaw(struct device *dev);
+extern int ufshcd_system_restore(struct device *dev);
 #endif
 extern int ufshcd_shutdown(struct ufs_hba *hba);
+
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
 				      int adapt_val);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

