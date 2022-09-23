Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF95E711B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiIWBIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIWBIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:08:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D81166F3;
        Thu, 22 Sep 2022 18:07:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N0uk6D025186;
        Fri, 23 Sep 2022 01:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=id9l19Li96n4yPyjxroHmuz6OAVG903EkUAs3nE1OUo=;
 b=i8yMY60JhC4yApE1LZ/pQJMEvQCepFLf42Du0Vu+LQwTcjYm8Q+Sw1qWcPP9EPX+do7z
 PVhgHWqr2Vq6kAbeF9AR0RellXrre20ZOpvAsn5ix1YPaLnsYch86vnLS8IqoEgWplug
 RprV3b0ojaUtWhDgJLQLiDUn0SmX1c5WxD0pfRftcGmEntbYEMAsYoEmlD/Y/2unv3Gt
 Bh+DztFXnYlQGQbtGaLPma7RXvmmn8SB1yWfQx7j6eJ19zdV22AUXqEpR0jR/OrqgPgK
 gPL5/TNrdhCLB19HfbXQzpNN9iQ/YudJAPb9aQIbBuFi1+qE+K/xgq74MDT5J/PDXuHb gA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrm0vtj2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:07:41 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N17eQj032591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:07:40 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 18:07:39 -0700
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
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 08/16] ufs: core: mcq: Configure operation and runtime interface
Date:   Thu, 22 Sep 2022 18:05:15 -0700
Message-ID: <443c6e943efcb1894168ad18b6c6d88d448b5067.1663894792.git.quic_asutoshd@quicinc.com>
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
X-Proofpoint-GUID: mMlmEGLWsVv0Ngg0HNAv_S9XqxwQe9w_
X-Proofpoint-ORIG-GUID: mMlmEGLWsVv0Ngg0HNAv_S9XqxwQe9w_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_16,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runtime and operation registers are defined per Submission
and Completion queue.
The location of these registers is not defined in the spec;
meaning the offsets and stride may vary for different
HC vendors. Establish the stride, base address and doorbell
address offsets from vendor host driver and program it.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 102 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  11 +++++
 drivers/ufs/core/ufshcd.c      |  17 +++++++
 drivers/ufs/host/ufs-qcom.c    |  24 ++++++++++
 include/ufs/ufshcd.h           |  52 +++++++++++++++++++++
 include/ufs/ufshci.h           |  31 +++++++++++++
 6 files changed, 237 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index e2854a3..7e57e7e 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -16,6 +16,8 @@
 #define UFS_MCQ_MIN_RW_QUEUES 2
 #define UFS_MCQ_MIN_READ_QUEUES 0
 #define UFS_MCQ_MIN_POLL_QUEUES 0
+#define QUEUE_EN_OFFSET 31
+#define QUEUE_ID_OFFSET 16
 
 #define MCQ_CFG_MAC_OFFSET	8
 #define MCQ_CFG_MAC_MASK	UFS_MASK(0x1ff, MCQ_CFG_MAC_OFFSET)
@@ -24,6 +26,7 @@
 #define MCQ_SQATTR_OFFSET(c) \
 	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
 #define MCQ_QCFG_SIZE	0x40
+#define MCQ_ENTRY_SIZE_IN_DWORD	8
 
 static unsigned int dev_cmd_queue = 1;
 
@@ -141,6 +144,24 @@ u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
 	return qd;
 }
 
+/**
+ * ufshcd_mcq_config_mac - Set the #Max Activ Cmds.
+ * @hba - per adpater instance
+ * @max_active_cmds - maximum # of active commands to the device at any time.
+ *
+ * The controller wouldn't send more than the max_active_cmds to the device at
+ * any time.
+ */
+void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
+{
+	u32 val;
+
+	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
+	val &= ~MCQ_CFG_MAC_MASK;
+	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
+	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
+}
+
 static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
 {
 	struct platform_device *pdev = to_platform_device(hba->dev);
@@ -283,6 +304,81 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
 	return 0;
 }
 
+/* Operation and runtime registers configuration */
+#define MCQ_CFG_n(r, i) \
+	((r) + MCQ_QCFG_SIZE * (i))
+#define MCQ_OPR_OFFSET_n(p, i) \
+	(hba->mcq_opr[(p)].offset + hba->mcq_opr[(p)].stride * (i))
+
+static void __iomem *mcq_opr_base(struct ufs_hba *hba,
+					 enum ufshcd_mcq_opr n, int i)
+{
+	struct ufshcd_mcq_opr_info_t *opr = &hba->mcq_opr[n];
+
+	return opr->base + opr->stride * i;
+}
+
+void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
+{
+	struct ufs_hw_queue *hwq;
+	u16 qsize;
+	int i;
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		hwq = &hba->uhq[i];
+		hwq->id = i;
+		qsize = hwq->max_entries * MCQ_ENTRY_SIZE_IN_DWORD - 1;
+
+		/* Submission Queue Lower Base Address */
+		ufsmcq_writelx(hba, lower_32_bits(hwq->sqe_dma_addr),
+			      MCQ_CFG_n(REG_SQLBA, i));
+		/* Submission Queue Upper Base Address */
+		ufsmcq_writelx(hba, upper_32_bits(hwq->sqe_dma_addr),
+			      MCQ_CFG_n(REG_SQUBA, i));
+		/* Submission Queue Doorbell Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_SQD, i),
+			      MCQ_CFG_n(REG_SQDAO, i));
+		/* Submission Queue Interrupt Status Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_SQIS, i),
+			      MCQ_CFG_n(REG_SQISAO, i));
+
+		/* Completion Queue Lower Base Address */
+		ufsmcq_writelx(hba, lower_32_bits(hwq->cqe_dma_addr),
+			      MCQ_CFG_n(REG_CQLBA, i));
+		/* Completion Queue Upper Base Address */
+		ufsmcq_writelx(hba, upper_32_bits(hwq->cqe_dma_addr),
+			      MCQ_CFG_n(REG_CQUBA, i));
+		/* Completion Queue Doorbell Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_CQD, i),
+			      MCQ_CFG_n(REG_CQDAO, i));
+		/* Completion Queue Interrupt Status Address Offset */
+		ufsmcq_writelx(hba, MCQ_OPR_OFFSET_n(OPR_CQIS, i),
+			      MCQ_CFG_n(REG_CQISAO, i));
+
+		/* Save the base addresses for quicker access */
+		hwq->mcq_sq_head = mcq_opr_base(hba, OPR_SQD, i) + REG_SQHP;
+		hwq->mcq_sq_tail = mcq_opr_base(hba, OPR_SQD, i) + REG_SQTP;
+		hwq->mcq_cq_head = mcq_opr_base(hba, OPR_CQD, i) + REG_CQHP;
+		hwq->mcq_cq_tail = mcq_opr_base(hba, OPR_CQD, i) + REG_CQTP;
+
+		/* Enable Tail Entry Push Status interrupt only for non-poll queues */
+		if (i < hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
+			writel(1, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIE);
+
+		/* Completion Queue Enable|Size to Completion Queue Attribute */
+		ufsmcq_writel(hba, (1 << QUEUE_EN_OFFSET) | qsize,
+			      MCQ_CFG_n(REG_CQATTR, i));
+
+		/*
+		 * Submission Qeueue Enable|Size|Completion Queue ID to
+		 * Submission Queue Attribute
+		 */
+		ufsmcq_writel(hba, (1 << QUEUE_EN_OFFSET) | qsize |
+			      (i << QUEUE_ID_OFFSET),
+			      MCQ_CFG_n(REG_SQATTR, i));
+	}
+}
+
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
 	int ret, i;
@@ -295,6 +391,12 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
+	ret = ufshcd_mcq_vops_op_runtime_config(hba);
+	if (ret) {
+		dev_err(hba->dev, "Operation runtime config failed, ret=%d\n",
+			ret);
+		return ret;
+	}
 	hba->uhq = devm_kmalloc(hba->dev,
 				hba->nr_hw_queues * sizeof(struct ufs_hw_queue),
 				GFP_KERNEL);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f624682..01026e3 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -53,6 +53,9 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 int ufshcd_mcq_init(struct ufs_hba *hba);
 u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
+void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
+void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
+void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -226,6 +229,14 @@ static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_mcq_vops_op_runtime_config(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->op_runtime_config)
+		return hba->vops->op_runtime_config(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5fc1e5e..b1af85c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -42,6 +42,12 @@
 #define UFSHCD_ENABLE_INTRS	(UTP_TRANSFER_REQ_COMPL |\
 				 UTP_TASK_REQ_COMPL |\
 				 UFSHCD_ERROR_MASK)
+
+#define UFSHCD_ENABLE_MCQ_INTRS	(UTP_TASK_REQ_COMPL |\
+				 UFSHCD_ERROR_MASK |\
+				 MCQ_CQ_EVENT_STATUS)
+
+
 /* UIC command timeout, unit: ms */
 #define UIC_CMD_TIMEOUT	500
 
@@ -8214,6 +8220,17 @@ static int ufshcd_config_mcq(struct ufs_hba *hba)
 	if (ret)
 		goto err;
 
+	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
+	ufshcd_mcq_make_queues_operational(hba);
+	ufshcd_mcq_config_mac(hba, hba->nutrs);
+
+	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
+	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
+	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
+		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
+		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
+		 hba->nutrs);
+
 	return 0;
 err:
 	hba->nutrs = old_nutrs;
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 643a915..598c08d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1425,6 +1425,29 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+static int ufs_qcom_op_runtime_config(struct ufs_hba *hba)
+{
+	struct ufshcd_mcq_opr_info_t *opr;
+	struct ufshcd_res_info_t *mem_res, *sqdao_res;
+	int i;
+
+	mem_res = &hba->res[RES_MEM];
+	sqdao_res = &hba->res[RES_MCQ_SQD];
+
+	if (!mem_res->base || !sqdao_res->base)
+		return -EINVAL;
+
+	for (i = 0; i < OPR_MAX; i++) {
+		opr = &hba->mcq_opr[i];
+		opr->offset = sqdao_res->resource->start -
+			      mem_res->resource->start + 0x40 * i;
+		opr->stride = 0x100;
+		opr->base = sqdao_res->base + 0x40 * i;
+	}
+
+	return 0;
+}
+
 static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
 {
 	/* Default is 32, but Qualcomm HC supports upto 64 */
@@ -1455,6 +1478,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
+	.op_runtime_config	= ufs_qcom_op_runtime_config,
 };
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index e54d624..8c44d5d0 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -294,6 +294,7 @@ struct ufs_pwr_mode_info {
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
  * @get_hba_mac: called to get vendor specific mac value
+ * @op_runtime_config: called to config Operation and runtime regs Pointers
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -333,6 +334,7 @@ struct ufs_hba_variant_ops {
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
 	int	(*get_hba_mac)(struct ufs_hba *hba);
+	int	(*op_runtime_config)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
@@ -746,6 +748,27 @@ enum ufshcd_res {
 };
 
 /**
+ * struct ufshcd_mcq_opr_info_t - Operation and Runtime registers
+ *
+ * @offset: Doorbell Address Offset
+ * @stride: Steps proportional to queue [0...31]
+ * @base: base address
+ */
+struct ufshcd_mcq_opr_info_t {
+	unsigned long offset;
+	unsigned long stride;
+	void __iomem *base;
+};
+
+enum ufshcd_mcq_opr {
+	OPR_SQD,
+	OPR_SQIS,
+	OPR_CQD,
+	OPR_CQIS,
+	OPR_MAX,
+};
+
+/**
  * struct ufs_hba - per adapter private structure
  * @mmio_base: UFSHCI base register address
  * @ucdl_base_addr: UFS Command Descriptor base address
@@ -853,6 +876,7 @@ enum ufshcd_res {
  *	ufshcd_resume_complete()
  * @ext_iid_sup: is EXT_IID is supported by UFSHC
  * @mcq_sup: is mcq supported by UFSHC
+ * @mcq_enabled: is mcq ready to accept requests
  * @nr_hw_queues: number of hardware queues configured
  * @nr_queues: number of Queues of different queue types
  * @res: array of resource info of MCQ registers
@@ -1009,29 +1033,47 @@ struct ufs_hba {
 	bool complete_put;
 	bool ext_iid_sup;
 	bool mcq_sup;
+	bool mcq_enabled;
 	unsigned int nr_hw_queues;
 	unsigned int nr_queues[HCTX_MAX_TYPES];
 	struct ufshcd_res_info_t res[RES_MAX];
 	void __iomem *mcq_base;
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
+	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
 };
 
 /**
+ * @mcq_sq_head: base address of submission queue head pointer
+ * @mcq_sq_tail: base address of submission queue tail pointer
+ * @mcq_cq_head: base address of completion queue head pointer
+ * @mcq_cq_tail: base address of completion queue tail pointer
  * @sqe_base_addr: submission queue entry base address
  * @sqe_dma_addr: submission queue dma address
  * @cqe_base_addr: completion queue base address
  * @cqe_dma_addr: completion queue dma address
  * @max_entries: max number of slots in this hardware queue
+ * @id: hardware queue ID
  */
 struct ufs_hw_queue {
+	void __iomem *mcq_sq_head;
+	void __iomem *mcq_sq_tail;
+	void __iomem *mcq_cq_head;
+	void __iomem *mcq_cq_tail;
+
 	void *sqe_base_addr;
 	dma_addr_t sqe_dma_addr;
 	struct cq_entry *cqe_base_addr;
 	dma_addr_t cqe_dma_addr;
 	u32 max_entries;
+	u32 id;
 };
 
+static inline bool is_mcq_enabled(struct ufs_hba *hba)
+{
+	return hba->mcq_enabled;
+}
+
 static inline bool is_mcq_supported(struct ufs_hba *hba)
 {
 	return hba->mcq_sup && (hba->caps & UFSHCD_CAP_MCQ_EN);
@@ -1087,6 +1129,16 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
+#define ufsmcq_writel(hba, val, reg)	\
+	writel((val), (hba)->mcq_base + (reg))
+#define ufsmcq_readl(hba, reg)	\
+	readl((hba)->mcq_base + (reg))
+
+#define ufsmcq_writelx(hba, val, reg)	\
+	writel_relaxed((val), (hba)->mcq_base + (reg))
+#define ufsmcq_readlx(hba, reg)	\
+	readl_relaxed((hba)->mcq_base + (reg))
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 7fa8faf..3d455e1 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -57,6 +57,7 @@ enum {
 	REG_UFS_CCAP				= 0x100,
 	REG_UFS_CRYPTOCAP			= 0x104,
 
+	REG_UFS_MEM_CFG				= 0x300,
 	REG_UFS_MCQ_CFG				= 0x380,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
@@ -78,6 +79,35 @@ enum {
 	MASK_EXT_IID_SUPPORT = 0x00000400,
 };
 
+enum {
+	REG_SQATTR		= 0x0,
+	REG_SQLBA		= 0x4,
+	REG_SQUBA		= 0x8,
+	REG_SQDAO		= 0xC,
+	REG_SQISAO		= 0x10,
+
+	REG_CQATTR		= 0x20,
+	REG_CQLBA		= 0x24,
+	REG_CQUBA		= 0x28,
+	REG_CQDAO		= 0x2C,
+	REG_CQISAO		= 0x30,
+};
+
+enum {
+	REG_SQHP		= 0x0,
+	REG_SQTP		= 0x4,
+};
+
+enum {
+	REG_CQHP		= 0x0,
+	REG_CQTP		= 0x4,
+};
+
+enum {
+	REG_CQIS		= 0x0,
+	REG_CQIE		= 0x4,
+};
+
 #define UFS_MASK(mask, offset)		((mask) << (offset))
 
 /* UFS Version 08h */
@@ -134,6 +164,7 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define CONTROLLER_FATAL_ERROR			0x10000
 #define SYSTEM_BUS_FATAL_ERROR			0x20000
 #define CRYPTO_ENGINE_FATAL_ERROR		0x40000
+#define MCQ_CQ_EVENT_STATUS			0x100000
 
 #define UFSHCD_UIC_HIBERN8_MASK	(UIC_HIBERNATE_ENTER |\
 				UIC_HIBERNATE_EXIT)
-- 
2.7.4

