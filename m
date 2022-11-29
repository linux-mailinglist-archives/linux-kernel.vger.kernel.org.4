Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AA63B71C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiK2BW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiK2BWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:22:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260642F78;
        Mon, 28 Nov 2022 17:22:24 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT1779q028887;
        Tue, 29 Nov 2022 01:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=27F05B+0fmnXnQP9G3lxnKQ7kQ+bOumQJqtlYfbBkzQ=;
 b=CeLJhL9hTjqWuJQMToCTBEta7EVBRsEpbzLMBhnZCh88D81LP02Crbr71YP8eURlQOQQ
 nA5LDMS6dAIWJ9+GIIijTY3DhR02Dqd4gMk+f3Vti1qHwARcR7ZEVJvTE5Ud4+oaogF4
 CxfQwYP1RdfUlySjGnmWK13i7V5dAl7NAhZ0Y+1f7ka6zCKkAlr1K9i/hYvGHpWRt75K
 byZRC75oouWWlgvSP9lLafyRHZ5fwAYodVDNyovGxrDtymj5g2M2qjMN+/LGWBH6+b8v
 R+B3n+GHcN3Nc3KfLT+XCYiLVu7jqQUCOb8rIhStEVqJSlsxQs7B236J9Cww2x0k3KMR 6Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3ad95g24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 01:22:08 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AT1M7hR031331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 01:22:07 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 17:22:06 -0800
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
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 06/16] ufs: core: mcq: Configure resource regions
Date:   Mon, 28 Nov 2022 17:20:47 -0800
Message-ID: <63d8921f95c3ee2678bf8b580f0bd12e93b38cde.1669684648.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669684648.git.quic_asutoshd@quicinc.com>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pEmtgSFOydfB-OK6lxveZLUwfGoyD_40
X-Proofpoint-GUID: pEmtgSFOydfB-OK6lxveZLUwfGoyD_40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211290006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the mcq resources and add support to ioremap
the resource regions.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     |   3 ++
 drivers/ufs/core/ufshcd-priv.h |   8 ++++
 drivers/ufs/host/ufs-qcom.c    | 103 +++++++++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h           |  30 ++++++++++++
 4 files changed, 144 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index bf08ec5..d6807e3 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -119,7 +119,10 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	int ret;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
+	if (ret)
+		return ret;
 
+	ret = ufshcd_vops_mcq_config_resource(hba);
 	return ret;
 }
 
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 9368ba2..74cb17b9 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -227,6 +227,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline int ufshcd_vops_mcq_config_resource(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->mcq_config_resource)
+		hba->vops->mcq_config_resource(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8ad1415..6bea541 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -25,6 +25,12 @@
 #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
 	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
 
+#define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
+#define MCQ_QCFGPTR_UNIT	0x200
+#define MCQ_SQATTR_OFFSET(c) \
+	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
+#define MCQ_QCFG_SIZE	0x40
+
 enum {
 	TSTBUS_UAWM,
 	TSTBUS_UARM,
@@ -1424,6 +1430,102 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+/* Resources */
+static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
+	{.name = "ufs_mem",},
+	{.name = "mcq",},
+	/* Submission Queue DAO */
+	{.name = "mcq_sqd",},
+	/* Submission Queue Interrupt Status */
+	{.name = "mcq_sqis",},
+	/* Completion Queue DAO */
+	{.name = "mcq_cqd",},
+	/* Completion Queue Interrupt Status */
+	{.name = "mcq_cqis",},
+	/* MCQ vendor specific */
+	{.name = "mcq_vs",},
+};
+
+static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
+{
+	struct platform_device *pdev = to_platform_device(hba->dev);
+	struct ufshcd_res_info *res;
+	struct resource *res_mem, *res_mcq;
+	int i, ret = 0;
+
+	memcpy(hba->res, ufs_res_info, sizeof(ufs_res_info));
+
+	for (i = 0; i < RES_MAX; i++) {
+		res = &hba->res[i];
+		res->resource = platform_get_resource_byname(pdev,
+							     IORESOURCE_MEM,
+							     res->name);
+		if (!res->resource) {
+			dev_info(hba->dev, "Resource %s not provided\n", res->name);
+			if (i == RES_UFS)
+				return -ENOMEM;
+			continue;
+		} else if (i == RES_UFS) {
+			res_mem = res->resource;
+			res->base = hba->mmio_base;
+			continue;
+		}
+
+		res->base = devm_ioremap_resource(hba->dev, res->resource);
+		if (IS_ERR(res->base)) {
+			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
+					 res->name, (int)PTR_ERR(res->base));
+			res->base = NULL;
+			ret = PTR_ERR(res->base);
+			return ret;
+		}
+	}
+
+	/* MCQ resource provided in DT */
+	res = &hba->res[RES_MCQ];
+	/* Bail if MCQ resource is provided */
+	if (res->base)
+		goto out;
+
+	/* Explicitly allocate MCQ resource from ufs_mem */
+	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
+	if (!res_mcq) {
+		dev_err(hba->dev, "Failed to allocate MCQ resource\n");
+		return ret;
+	}
+
+	res_mcq->start = res_mem->start +
+			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
+	res_mcq->end = res_mcq->start + hba->nr_hw_queues * MCQ_QCFG_SIZE - 1;
+	res_mcq->flags = res_mem->flags;
+	res_mcq->name = "mcq";
+
+	ret = insert_resource(&iomem_resource, res_mcq);
+	if (ret) {
+		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
+			ret);
+		goto insert_res_err;
+	}
+
+	res->base = devm_ioremap_resource(hba->dev, res_mcq);
+	if (IS_ERR(res->base)) {
+		dev_err(hba->dev, "MCQ registers mapping failed, err=%d\n",
+			(int)PTR_ERR(res->base));
+		ret = PTR_ERR(res->base);
+		goto ioremap_err;
+	}
+
+out:
+	hba->mcq_base = res->base;
+	return 0;
+ioremap_err:
+	res->base = NULL;
+	remove_resource(res_mcq);
+insert_res_err:
+	devm_kfree(hba->dev, res_mcq);
+	return ret;
+}
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1447,6 +1549,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 };
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 146b613..0e21a6a 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @mcq_config_resource: called to configure MCQ platform resources
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -335,6 +336,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	int	(*mcq_config_resource)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
@@ -724,6 +726,30 @@ struct ufs_hba_monitor {
 };
 
 /**
+ * struct ufshcd_res_info_t - MCQ related resource regions
+ *
+ * @name: resource name
+ * @resource: pointer to resource region
+ * @base: register base address
+ */
+struct ufshcd_res_info {
+	const char *name;
+	struct resource *resource;
+	void __iomem *base;
+};
+
+enum ufshcd_res {
+	RES_UFS,
+	RES_MCQ,
+	RES_MCQ_SQD,
+	RES_MCQ_SQIS,
+	RES_MCQ_CQD,
+	RES_MCQ_CQIS,
+	RES_MCQ_VS,
+	RES_MAX,
+};
+
+/**
  * struct ufs_hba - per adapter private structure
  * @mmio_base: UFSHCI base register address
  * @ucdl_base_addr: UFS Command Descriptor base address
@@ -835,6 +861,8 @@ struct ufs_hba_monitor {
  *	ufshcd_resume_complete()
  * @ext_iid_sup: is EXT_IID is supported by UFSHC
  * @mcq_sup: is mcq supported by UFSHC
+ * @res: array of resource info of MCQ registers
+ * @mcq_base: Multi circular queue registers base address
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -988,6 +1016,8 @@ struct ufs_hba {
 	bool complete_put;
 	bool ext_iid_sup;
 	bool mcq_sup;
+	struct ufshcd_res_info res[RES_MAX];
+	void __iomem *mcq_base;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.7.4

