Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8897C6401DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiLBISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiLBISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:18:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A51ABA1F;
        Fri,  2 Dec 2022 00:17:05 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B28Dv2n015942;
        Fri, 2 Dec 2022 08:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=XyOJIMJLrukixYZyXffRB/uMBNyS/MdzUFxolzrOKuU=;
 b=VUxfg3EqxNcHqAp1ZSVfGoicptRPgAjXNs4RWhFmVow7QQ2oNWRDjTU45RnfKnanbSqr
 VzZ8OYAij6CrnY945OXhwTFuy5LqEMIBFI9hie6cqTyutaNoNa0RfIcf5I59ecT+xxTp
 nzSoteG8IrcbiX6J/W1HUBAMSgf52zgzEoFSmPQPbQ42edmzt9W6oID1wPrPf+4romfA
 KyVdijkUjJEOKKgbxGZVOiu4wGEvw8VKFij+K9ADH7+IwI7tGOKN1y1sP46gR/d0oZa/
 CkmMzB+TSzgKVXK++FETUiTsGQYNc9akwnCkMjZYzbor1ZNTwEjBWULCrVdvd62MPUGx kg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7b82rm9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 08:16:49 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2B28GmlG029542;
        Fri, 2 Dec 2022 08:16:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3m6j6ucj38-1;
        Fri, 02 Dec 2022 08:16:48 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B28Gm4e029537;
        Fri, 2 Dec 2022 08:16:48 GMT
Received: from stor-presley.qualcomm.com (stor-presley.qualcomm.com [192.168.140.85])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 2B28Gm8t029534;
        Fri, 02 Dec 2022 08:16:48 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 1675720DAF; Fri,  2 Dec 2022 00:16:48 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Can Guo <quic_cang@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ufs-host: qcom: Add MCQ ESI config vendor specific ops
Date:   Fri,  2 Dec 2022 00:15:07 -0800
Message-Id: <1669968909-33021-4-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669968909-33021-1-git-send-email-quic_cang@quicinc.com>
References: <1669968909-33021-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X-cFrFXxf-NxC3dU_kfrfRh02wvoBQYI
X-Proofpoint-GUID: X-cFrFXxf-NxC3dU_kfrfRh02wvoBQYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020062
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MCQ ESI config vendor specific ops.

Co-developed-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.h |  5 +++
 2 files changed, 104 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 96a58b4..18bdece 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1568,6 +1568,103 @@ static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
 	return 0;
 }
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	ufshcd_mcq_config_esi(hba, msg);
+}
+
+static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *__hba)
+{
+	struct ufs_hba *hba = __hba;
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	u32 id = irq - host->esi_base;
+	struct ufs_hw_queue *hwq = &hba->uhq[id];
+
+	ufshcd_mcq_write_cqis(hba, 0x1, id);
+	ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+
+	return IRQ_HANDLED;
+}
+
+static int ufs_qcom_config_esi(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct msi_desc *desc;
+	struct msi_desc *failed_desc = NULL;
+	u32 reg;
+	int nr_irqs, ret;
+
+	if (host->esi_enabled)
+		return 0;
+	else if (host->esi_base < 0)
+		return -EINVAL;
+
+	/*
+	 * 1. We only handle CQs as of now.
+	 * 2. Poll queues do not need ESI.
+	 */
+	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	ret = platform_msi_domain_alloc_irqs(hba->dev, nr_irqs,
+					     ufs_qcom_write_msi_msg);
+	if (ret)
+		goto out;
+
+	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
+		if (!desc->msi_index)
+			host->esi_base = desc->irq;
+
+		ret = devm_request_irq(hba->dev, desc->irq,
+				       ufs_qcom_mcq_esi_handler,
+				       IRQF_SHARED, "qcom-mcq-esi", hba);
+		if (ret) {
+			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err = %d\n",
+				__func__, desc->irq, ret);
+			failed_desc = desc;
+			break;
+		}
+	}
+
+	if (ret) {
+		/* Rewind */
+		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
+			if (desc == failed_desc)
+				break;
+			devm_free_irq(hba->dev, desc->irq, hba);
+		}
+		platform_msi_domain_free_irqs(hba->dev);
+	} else {
+		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+		    host->hw_ver.step == 0) {
+			reg = ufshcd_readl(hba, REG_UFS_CFG3);
+			reg |= 0x1F000;
+			ufshcd_writel(hba, reg, REG_UFS_CFG3);
+			reg = ufshcd_readl(hba, REG_UFS_CFG3);
+		}
+		ufshcd_mcq_enable_esi(hba);
+	}
+
+out:
+	if (ret) {
+		host->esi_base = -1;
+		dev_warn(hba->dev, "Failed to request Platform MSI %d\n", ret);
+	} else {
+		host->esi_enabled = true;
+	}
+
+	return ret;
+}
+
+#else
+static int ufs_qcom_config_esi(struct ufs_hba *hba)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1595,6 +1692,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
 	.op_runtime_config	= ufs_qcom_op_runtime_config,
 	.get_outstanding_cqs	= ufs_qcom_get_outstanding_cqs,
+	.config_esi		= ufs_qcom_config_esi,
 };
 
 /**
@@ -1628,6 +1726,7 @@ static int ufs_qcom_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_remove(hba);
+	platform_msi_domain_free_irqs(hba->dev);
 	return 0;
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 6912bdf..7937b41 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -54,6 +54,8 @@ enum {
 	 * added in HW Version 3.0.0
 	 */
 	UFS_AH8_CFG				= 0xFC,
+
+	REG_UFS_CFG3				= 0x271C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
@@ -226,6 +228,9 @@ struct ufs_qcom_host {
 	struct reset_controller_dev rcdev;
 
 	struct gpio_desc *device_reset;
+
+	int esi_base;
+	bool esi_enabled;
 };
 
 static inline u32
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

