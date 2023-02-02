Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E468830A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBBPsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBBPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:48:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F162C7D9BF;
        Thu,  2 Feb 2023 07:47:44 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312DQonP007852;
        Thu, 2 Feb 2023 15:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=e0FvsPYibgBEabS+IwF1w2XYW1r9Mf34lD/7oUyb4Tg=;
 b=BBLIC96XdidqSzZHLA4ytRPFTLI+hoO3t/CoAU9oPk7WxyTbRL6r0n9hewUN9SLGjviw
 /JFs0NQ7017hu+2De3Tj9oYB28nJw8CE3zC649LtiWU3AJVWJGyXMGcnz5Fc8VRlKJrp
 +fMW3Jv/F1ZsPGswKReYMzVWpv61c8+YWu6pvBiWv5mCik2TXInAvgKStjoZ2Jw7thHu
 kOlat9TutMJFkGUHcGvH1ElXWvmj/R61TZjsHAU4qO+bvjtXcv0skMLB6R/Moy7cm6Lq
 Zm0wcNg4xxD22x4IVLzGYTivegRumrC6VCXZmhuTzrM5tK0MgYR9c9tXpddi9KPR83YY Rg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfm9g3gfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 15:47:16 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312FlFWb028327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 15:47:15 GMT
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 07:47:10 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v4 1/1] scsi: ufs: Add hibernation callbacks
Date:   Thu, 2 Feb 2023 21:16:14 +0530
Message-ID: <20230202154614.31433-2-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202154614.31433-1-quic_ahari@quicinc.com>
References: <20230202154614.31433-1-quic_ahari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7JvFWAe-UCAd30eYSzPFxFP2fQgMt6jU
X-Proofpoint-GUID: 7JvFWAe-UCAd30eYSzPFxFP2fQgMt6jU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/ufs/ufshcd.h        |  7 +++++
 3 files changed, 65 insertions(+), 1 deletion(-)

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
index 681da3ea7154..057753ed2915 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1714,10 +1714,16 @@ MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
 #endif
 
 static const struct dev_pm_ops ufs_qcom_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
 	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
+#ifdef CONFIG_PM_SLEEP
 	.complete	 = ufshcd_resume_complete,
+	.suspend         = ufshcd_system_suspend,
+	.resume          = ufshcd_system_resume,
+	.freeze          = ufshcd_system_freeze,
+	.restore         = ufshcd_system_restore,
+	.thaw            = ufshcd_system_thaw,
+#endif
 };
 
 static struct platform_driver ufs_qcom_pltform = {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 6d26ff0cc07e..aff5fe64631c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1073,6 +1073,9 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+
+	/* Distinguish between resume and restore */
+	bool restore;
 };
 
 /**
@@ -1278,8 +1281,12 @@ extern int ufshcd_runtime_resume(struct device *dev);
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

