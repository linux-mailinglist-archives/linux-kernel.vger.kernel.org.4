Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFB634EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiKWEND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiKWEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:12:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28465F2;
        Tue, 22 Nov 2022 20:12:37 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN40Dhr011307;
        Wed, 23 Nov 2022 04:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=N7G6kQBaCs3y2fDYKHxpPiHi84MomEbXfEAhHOE8GJI=;
 b=lh+cCEk2wti/iLHLl92KpVT+d9my8E+sLH4tZd9de02a2Cf6NIQ+T12xoNbgjwVd77Xa
 nN0OMY4s4yha1DfYPDSmc7IilLaC4v8SYELvy7POK+aK/ckN4vp3z07oT3ENq3XQw2KX
 ZBWA+4zh5PCIzvUfUoVVKaW2iOfdweRypW/JwHivBrzINNpTZcH7EEI74h6CrBjpnUQY
 aWEhmfkknIXAzc4N+xHrVeiHgKP9NxIF0V6Uf5h+WXiA0pN7ITee6H1HhGghNIZ0cqe0
 fPqiES11ZVTZKIJheM9FfzsCS0wAFHIz9K7xGpmC7kDL3fX472q31Xxv8p8TMrhwUZOV aw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0q6xb8b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 04:12:25 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AN4COut031184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 04:12:24 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 22 Nov 2022 20:12:24 -0800
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
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/16] ufs: core: mcq: Configure resource regions
Date:   Tue, 22 Nov 2022 20:10:19 -0800
Message-ID: <05400727c8a82b7ef85a576c1fa2d9bd81458e9a.1669176158.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669176158.git.quic_asutoshd@quicinc.com>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: weJRo3dCUFg8ZhcheiRzJGYadtwY1RB2
X-Proofpoint-ORIG-GUID: weJRo3dCUFg8ZhcheiRzJGYadtwY1RB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufs-mcq.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h       |  28 ++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 3818f45..4aaa6aa 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -18,6 +18,11 @@
 #define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
 #define UFS_MCQ_MIN_POLL_QUEUES 0
 
+#define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
+#define MCQ_QCFGPTR_UNIT	0x200
+#define MCQ_SQATTR_OFFSET(c) \
+	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
+#define MCQ_QCFG_SIZE	0x40
 
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
 {
@@ -67,6 +72,102 @@ module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues,
 		 "Number of poll queues used for r/w. Default value is 1");
 
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
+static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
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
 static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 {
 	int i;
@@ -119,7 +220,10 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	int ret;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
+	if (ret)
+		return ret;
 
+	ret = ufshcd_mcq_config_resource(hba);
 	return ret;
 }
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index dee0b37..7bf7599 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -724,6 +724,30 @@ struct ufs_hba_monitor {
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
@@ -835,6 +859,8 @@ struct ufs_hba_monitor {
  * @mcq_sup: is mcq supported by UFSHC
  * @nr_hw_queues: number of hardware queues configured
  * @nr_queues: number of Queues of different queue types
+ * @res: array of resource info of MCQ registers
+ * @mcq_base: Multi circular queue registers base address
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -988,6 +1014,8 @@ struct ufs_hba {
 	bool mcq_sup;
 	unsigned int nr_hw_queues;
 	unsigned int nr_queues[HCTX_MAX_TYPES];
+	struct ufshcd_res_info res[RES_MAX];
+	void __iomem *mcq_base;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.7.4

