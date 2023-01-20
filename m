Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B0675378
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjATLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjATLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:34:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA478B777;
        Fri, 20 Jan 2023 03:34:15 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KA43FO019181;
        Fri, 20 Jan 2023 11:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WCYTJSpE35+Sa1YmBKm2HNex9der1g/+lhYmfY7WFuQ=;
 b=JNZnYHZZ6oVyYQR+aDccqD8Z599lbVMCC3BT/XpOzswWoRhvgtq3Dp6XPDnXLtyfHVpW
 CxsSDa4CUzXeFAtsGmsXM+v3JsjOelLiAQLUWV7WkSlldiSkAVgqDjOEt3LW7CLVdx3H
 2A+Lx6Ll8cbVtO5PfvdBcHfWnnazP0zfAyGfH7sJnFGT+39wRs/1ivX4xKyamk5oZobA
 7NlpZU0H/FBGtHyv3OTlv8gAC4j6egdFarK33+M5YZPPfeRkZEZ9iFiYlg/w4eNwax8P
 /nKWZarY3HHNyLFGNHCGIQmyNfACftuCzjyXyXWeu5iBnw6ZDAxtVUrlQh1WLfmd04uf VQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7c28hg76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:33:52 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KBXpuX021337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:33:51 GMT
Received: from hu-ahari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 03:33:46 -0800
From:   Anjana Hari <quic_ahari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Subject: [PATCH v3 1/1] scsi: ufs: Add hibernation callbacks
Date:   Fri, 20 Jan 2023 17:03:21 +0530
Message-ID: <20230120113321.30433-2-quic_ahari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230120113321.30433-1-quic_ahari@quicinc.com>
References: <20230120113321.30433-1-quic_ahari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pjdF5PuJ2tzWRaLdNuJWJdi9lHDgTlIE
X-Proofpoint-ORIG-GUID: pjdF5PuJ2tzWRaLdNuJWJdi9lHDgTlIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_07,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200109
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
 drivers/ufs/core/ufshcd.c   | 62 +++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c |  6 +++-
 include/ufs/ufshcd.h        |  8 +++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fcd46251f7a8..d68222bb73ad 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9826,11 +9826,36 @@ static int ufshcd_resume(struct ufs_hba *hba)
 
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
+		/* Make sure that UTRL and UTMRL base address registers
+		 * are updated with the latest queue addresses. Only after
+		 * updating these addresses, we can queue the new commands.
+		 */
+		mb();
+	}
+
+	/* Resuming from hibernate, assume that link was OFF */
+	if (hba->restore)
+		ufshcd_set_link_off(hba);
+
 	goto out;
 
 disable_vreg:
 	ufshcd_vreg_set_lpm(hba);
 out:
+	if (hba->restore)
+		hba->restore = false;
+
 	if (ret)
 		ufshcd_update_evt_hist(hba, UFS_EVT_RESUME_ERR, (u32)ret);
 	return ret;
@@ -9989,6 +10014,43 @@ void ufshcd_remove(struct ufs_hba *hba)
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_freeze);
+
+int ufshcd_system_restore(struct device *dev)
+{
+
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	hba->restore = true;
+	return ufshcd_system_resume(dev);
+
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_restore);
+
+int ufshcd_system_thaw(struct device *dev)
+{
+	return ufshcd_system_resume(dev);
+}
+EXPORT_SYMBOL_GPL(ufshcd_system_thaw);
+
 /**
  * ufshcd_dealloc_host - deallocate Host Bus Adapter (HBA)
  * @hba: pointer to Host Bus Adapter (HBA)
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 681da3ea7154..c92e041c5361 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1714,10 +1714,14 @@ MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
 #endif
 
 static const struct dev_pm_ops ufs_qcom_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_system_suspend, ufshcd_system_resume)
 	SET_RUNTIME_PM_OPS(ufshcd_runtime_suspend, ufshcd_runtime_resume, NULL)
 	.prepare	 = ufshcd_suspend_prepare,
 	.complete	 = ufshcd_resume_complete,
+	.suspend         = ufshcd_system_suspend,
+	.resume          = ufshcd_system_resume,
+	.freeze          = ufshcd_system_freeze,
+	.restore         = ufshcd_system_restore,
+	.thaw            = ufshcd_system_thaw,
 };
 
 static struct platform_driver ufs_qcom_pltform = {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 1779238d8a56..6f50390ca262 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1071,6 +1071,9 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+
+	/* Distinguish between resume and restore */
+	bool restore;
 };
 
 /**
@@ -1278,6 +1281,11 @@ extern int ufshcd_system_suspend(struct device *dev);
 extern int ufshcd_system_resume(struct device *dev);
 #endif
 extern int ufshcd_shutdown(struct ufs_hba *hba);
+
+extern int ufshcd_system_freeze(struct device *dev);
+extern int ufshcd_system_thaw(struct device *dev);
+extern int ufshcd_system_restore(struct device *dev);
+
 extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 				      int agreed_gear,
 				      int adapt_val);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

