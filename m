Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1215E7115
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiIWBHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiIWBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:07:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DA61166E7;
        Thu, 22 Sep 2022 18:07:25 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MNuQrd018256;
        Fri, 23 Sep 2022 01:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Bc9T747Ii1/zQ1gV+dQIubIY434gh+YQjMpm3+fERLY=;
 b=V0nNOVJsOosUS+FfGMR+6RSMc5KZbnARfuL2GSKTCjUwqzWkXmV4jWUFYbL4rMQqF6Dz
 me02yv8BwbwhiVN7bx08FGC+cg6VTEB6wI7a1gnuFOa49EtW21iMmf/jEY+qm3sHg5WY
 9XxvcavuQS7q1MmyAOAiwgmdkQdMz4yJWM6m4Px7eL5LAuUQWcO5uW0yZvFGqRhvRKtO
 zUjiBPwsc3crpexly+tObQIk5M4j3nPsm3J4QHEjIzgpfyA7sKcdHZHHyONlVLvLdW4i
 KeWsW882yBBoiDSzY7Gn8rPDLWrW3/FNXwdDtfd8tSIfi/adkGkxLAyuKSfjr42pcqnQ QQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrqjd9w91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:06:54 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N16rJj008242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:06:53 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 18:06:52 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <mani@kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_richardp@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 05/16] ufs: core: mcq: Configure resource regions
Date:   Thu, 22 Sep 2022 18:05:12 -0700
Message-ID: <4d4df6ad6353b93253fb22deefb772dc59f5c84e.1663894792.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663894792.git.quic_asutoshd@quicinc.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tpF9uJH_JI-hxf4r_d2XRcQ58Wlp60er
X-Proofpoint-ORIG-GUID: tpF9uJH_JI-hxf4r_d2XRcQ58Wlp60er
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_16,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufs-mcq.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-
 include/ufs/ufshcd.h       |  28 +++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 934556f..e5cc7ab 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -17,6 +17,12 @@
 #define UFS_MCQ_MIN_READ_QUEUES 0
 #define UFS_MCQ_MIN_POLL_QUEUES 0
 
+#define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
+#define MCQ_QCFGPTR_UNIT	0x200
+#define MCQ_SQATTR_OFFSET(c) \
+	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
+#define MCQ_QCFG_SIZE	0x40
+
 static unsigned int dev_cmd_queue = 1;
 
 static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
@@ -85,6 +91,96 @@ module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues,
 		 "Number of poll queues used for r/w. Default value is 1");
 
+/* Resources */
+static const struct ufshcd_res_info_t ufshcd_res_info[RES_MAX] = {
+	{.name = "ufs_mem", .resource = NULL, .base = NULL},
+	{.name = "mcq", .resource = NULL, .base = NULL},
+	/* Submission Queue DAO */
+	{.name = "mcq_sqd", .resource = NULL, .base = NULL},
+	/* Submission Queue Interrupt Status */
+	{.name = "mcq_sqis", .resource = NULL, .base = NULL},
+	/* Completion Queue DAO */
+	{.name = "mcq_cqd", .resource = NULL, .base = NULL},
+	/* Completion Queue Interrupt Status */
+	{.name = "mcq_cqis", .resource = NULL, .base = NULL},
+	/* MCQ vendor specific */
+	{.name = "mcq_vs", .resource = NULL, .base = NULL},
+};
+
+static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
+{
+	struct platform_device *pdev = to_platform_device(hba->dev);
+	struct ufshcd_res_info_t *res;
+	struct resource *res_mem, *res_mcq;
+	int i, ret = 0;
+
+	memcpy(hba->res, ufshcd_res_info, sizeof(ufshcd_res_info));
+
+	for (i = 0; i < RES_MAX; i++) {
+		res = &hba->res[i];
+		res->resource = platform_get_resource_byname(pdev,
+							     IORESOURCE_MEM,
+							     res->name);
+		if (!res->resource) {
+			dev_info(hba->dev, "Resource %s not provided\n", res->name);
+			if (i == RES_MEM)
+				return -ENOMEM;
+			continue;
+		} else if (i == RES_MEM) {
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
+	res = &hba->res[RES_MCQ];
+	/* MCQ resource provided in DT */
+	if (res->base)
+		goto out;
+
+	/* Manually allocate MCQ resource */
+	res_mcq = res->resource;
+	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
+	if (!res_mcq) {
+		dev_err(hba->dev, "Failed to alloate MCQ resource\n");
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
+		dev_err(hba->dev, "Failed to insert MCQ resource %d\n", ret);
+		return ret;
+	}
+
+	res->base = devm_ioremap_resource(hba->dev, res_mcq);
+	if (IS_ERR(res->base)) {
+		dev_err(hba->dev, "Map MCQ registers failed, err=%d\n",
+			(int)PTR_ERR(res->base));
+		ret = PTR_ERR(res->base);
+		res->base = NULL;
+		return ret;
+	}
+
+out:
+	hba->mcq_base = res->base;
+	return 0;
+}
+
 static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 {
 	int i, rem;
@@ -126,7 +222,9 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	int ret;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
-
+	if (ret)
+		return ret;
+	ret = ufshcd_mcq_config_resource(hba);
 	return ret;
 }
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 298e103..54d742a 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -720,6 +720,30 @@ struct ufs_hba_monitor {
 };
 
 /**
+ * struct ufshcd_res_info_t - MCQ related resource regions
+ *
+ * @name: resource name
+ * @resource: pointer to resource region
+ * @base: register base address
+ */
+struct ufshcd_res_info_t {
+	const char *name;
+	struct resource *resource;
+	void __iomem *base;
+};
+
+enum ufshcd_res {
+	RES_MEM,
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
@@ -829,6 +853,8 @@ struct ufs_hba_monitor {
  * @mcq_sup: is mcq supported by UFSHC
  * @nr_hw_queues: number of hardware queues configured
  * @nr_queues: number of Queues of different queue types
+ * @res: array of resource info of MCQ registers
+ * @mcq_base: Multi circular queue registers base address
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -981,6 +1007,8 @@ struct ufs_hba {
 	bool mcq_sup;
 	unsigned int nr_hw_queues;
 	unsigned int nr_queues[HCTX_MAX_TYPES];
+	struct ufshcd_res_info_t res[RES_MAX];
+	void __iomem *mcq_base;
 };
 
 static inline bool is_mcq_supported(struct ufs_hba *hba)
-- 
2.7.4

