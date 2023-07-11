Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FAF74E88A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGKH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGKH7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:59:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090CAF;
        Tue, 11 Jul 2023 00:59:37 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6pTJL025624;
        Tue, 11 Jul 2023 07:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=8Aw0Oyz2bMNGD9OgN2Nx4X90OOnin3v3pJwSa1hCECw=;
 b=a3kYwRFrbZK3C1Am9DMHot5sh/zruMaUlxmPpHBe5XKf3n0zH0Dah3dlVZVtwb1ezIpb
 +nZraqPZ6GRQBwGTHveXfihJZvAdpeyhYS4FyUEX9Fs/EVsI1QwcqLU5rS2aP7AaZFkc
 w4RJF2YzYi1QNZPA1C6ZmIgZrDm9vjsx8nEIXr4XqXC0JdnOjQ3K9yLsZk7Ct9tiOToT
 fR7QoxKKyO11ZdToq1dn3JuAp+3nfQcJ5jNtF4kE2NIeDLoyO4cTXDn1E/RQDBiodVPI
 jzWzGsT0vStf6wMHiUTWM2nH4dYDuK2kA+kTWVVF0hSGcsJnEu60iXu+sn7t9b5d+tmc aA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0kpg92r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 07:59:16 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B7xD5N014626;
        Tue, 11 Jul 2023 07:59:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vknt8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 07:59:13 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B7xD2H014621;
        Tue, 11 Jul 2023 07:59:13 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 36B7xCDg014620;
        Tue, 11 Jul 2023 07:59:13 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id 09FD84A95; Tue, 11 Jul 2023 15:59:12 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_ziqichen@quicinc.com, quic_nitirawa@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] scsi: ufs: qcom: Get queue ID from MSI index in ESI handler
Date:   Tue, 11 Jul 2023 15:59:08 +0800
Message-Id: <1689062349-77385-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kexr2B-IjMc2Y8jzM2WvGhlNgFfjgP2o
X-Proofpoint-ORIG-GUID: Kexr2B-IjMc2Y8jzM2WvGhlNgFfjgP2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110069
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_msi_domain_alloc_irqs() does not always get consecutive
IRQ numbers, hence queue IDs calculated out from IRQ numbers may
be incorrect if we assume IRQ numbers are consecutive. Fix it by
passing msi_desc to ESI handler to use msi_desc->msi_index as
queue ID.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 25 ++++++++++---------------
 drivers/ufs/host/ufs-qcom.h |  1 -
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8d6fd4c..f36bcdb 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1643,11 +1643,13 @@ static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	ufshcd_mcq_config_esi(hba, msg);
 }
 
-static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *__hba)
+static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 {
-	struct ufs_hba *hba = __hba;
+	struct msi_desc *desc = data;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	u32 id = irq - host->esi_base;
+	u32 id = desc->msi_index;
 	struct ufs_hw_queue *hwq = &hba->uhq[id];
 
 	ufshcd_mcq_write_cqis(hba, 0x1, id);
@@ -1665,8 +1667,6 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 
 	if (host->esi_enabled)
 		return 0;
-	else if (host->esi_base < 0)
-		return -EINVAL;
 
 	/*
 	 * 1. We only handle CQs as of now.
@@ -1675,16 +1675,15 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
 	ret = platform_msi_domain_alloc_irqs(hba->dev, nr_irqs,
 					     ufs_qcom_write_msi_msg);
-	if (ret)
+	if (ret) {
+		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
 		goto out;
+	}
 
 	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-		if (!desc->msi_index)
-			host->esi_base = desc->irq;
-
 		ret = devm_request_irq(hba->dev, desc->irq,
 				       ufs_qcom_mcq_esi_handler,
-				       IRQF_SHARED, "qcom-mcq-esi", hba);
+				       IRQF_SHARED, "qcom-mcq-esi", desc);
 		if (ret) {
 			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err = %d\n",
 				__func__, desc->irq, ret);
@@ -1712,12 +1711,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	}
 
 out:
-	if (ret) {
-		host->esi_base = -1;
-		dev_warn(hba->dev, "Failed to request Platform MSI %d\n", ret);
-	} else {
+	if (!ret)
 		host->esi_enabled = true;
-	}
 
 	return ret;
 }
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 6289ad5..7292403 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -226,7 +226,6 @@ struct ufs_qcom_host {
 
 	u32 hs_gear;
 
-	int esi_base;
 	bool esi_enabled;
 };
 
-- 
2.7.4

