Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B4634EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbiKWEOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiKWENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:13:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22E28724;
        Tue, 22 Nov 2022 20:13:01 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN2lpVO019313;
        Wed, 23 Nov 2022 04:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Nnexj46zckYhkIIlAsUcDW1Jh9spb81+Z4A4e8a2c8c=;
 b=LpHTsDsRzavmxd5CgteFOuZtw/YbLTBPrSl6VkofH230MoYdDcAC22thNAeW/ggeMDJc
 UuZk12LohaYIiBp07Ii9qhyGT7y7dVUgXHe4jWpCdKz5TelG00FLjWaQuWxfjaoAouEt
 12MY52VBF4UV4lJ/9RqmgfXKF8+1etcnayAkMpFQSsp1vGilfNA3t4y5R5oQzYOO/D1b
 f9jsIsCQmPbkwhcVYWIE9rBlCy8NF8szUp8aoipY64aFPQqSojlNlJV/ooKrb08+UwqF
 1Y9thI6Or5hZJNzu/S1a5MlZm0tx7+vIN9cKIoC5xftpIadf3j5aTlxd6vB1s/DEPQAQ 9A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m13ps144c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 04:12:43 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AN4CgWf031773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 04:12:42 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 22 Nov 2022 20:12:41 -0800
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 07/16] ufs: core: mcq: Calculate queue depth
Date:   Tue, 22 Nov 2022 20:10:20 -0800
Message-ID: <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
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
X-Proofpoint-GUID: dTkouwJhHqkUZnxhxi7G3eUuTzWCEOEM
X-Proofpoint-ORIG-GUID: dTkouwJhHqkUZnxhxi7G3eUuTzWCEOEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_01,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211230030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ufs device defines the supported queuedepth by
bqueuedepth which has a max value of 256.
The HC defines MAC (Max Active Commands) that define
the max number of commands that in flight to the ufs
device.
Calculate and configure the nutrs based on both these
values.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 32 ++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
 drivers/ufs/core/ufshcd.c      | 17 ++++++++++++++++-
 drivers/ufs/host/ufs-qcom.c    |  8 ++++++++
 include/ufs/ufs.h              |  2 ++
 include/ufs/ufshcd.h           |  2 ++
 include/ufs/ufshci.h           |  1 +
 7 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 4aaa6aa..e95f748 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -18,6 +18,8 @@
 #define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
 #define UFS_MCQ_MIN_POLL_QUEUES 0
 
+#define MAX_DEV_CMD_ENTRIES	2
+#define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
 #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
 #define MCQ_QCFGPTR_UNIT	0x200
 #define MCQ_SQATTR_OFFSET(c) \
@@ -88,6 +90,36 @@ static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
 	{.name = "mcq_vs",},
 };
 
+/**
+ * ufshcd_mcq_decide_queue_depth - decide the queue depth
+ * @hba - per adapter instance
+ *
+ * MAC - Max. Active Command of the Host Controller (HC)
+ * HC wouldn't send more than this commands to the device.
+ * It is mandatory to implement get_hba_mac() to enable MCQ mode.
+ * Calculates and adjusts the queue depth based on the depth
+ * supported by the HC and ufs device.
+ */
+int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
+{
+	int mac;
+
+	/* Mandatory to implement get_hba_mac() */
+	mac = ufshcd_mcq_vops_get_hba_mac(hba);
+	if (mac < 0) {
+		dev_err(hba->dev, "Failed to get mac, err=%d\n", mac);
+		return mac;
+	}
+
+	WARN_ON(!hba->dev_info.bqueuedepth);
+	/*
+	 * max. value of bqueuedepth = 256, mac is host dependent.
+	 * It is mandatory for UFS device to define bQueueDepth if
+	 * shared queuing architecture is enabled.
+	 */
+	return min_t(int, mac, hba->dev_info.bqueuedepth);
+}
+
 static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
 {
 	struct platform_device *pdev = to_platform_device(hba->dev);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 9368ba2..9f40fa5 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -62,6 +62,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, u8 index, bool *flag_res);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 int ufshcd_mcq_init(struct ufs_hba *hba);
+int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -227,6 +228,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->get_hba_mac)
+		return hba->vops->get_hba_mac(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0c4cd8f..ae065da 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7783,6 +7783,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	/* getting Specification Version in big endian format */
 	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
 	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
@@ -8198,7 +8199,21 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 
 static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 {
-	return ufshcd_mcq_init(hba);
+	int ret;
+	int old_nutrs = hba->nutrs;
+
+	ret = ufshcd_mcq_decide_queue_depth(hba);
+	if (ret < 0)
+		return ret;
+
+	hba->nutrs = ret;
+	ret = ufshcd_mcq_init(hba);
+	if (ret) {
+		hba->nutrs = old_nutrs;
+		return ret;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8ad1415..7bd3c37 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -25,6 +25,7 @@
 #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
 	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
 
+#define MAX_SUPP_MAC 64
 enum {
 	TSTBUS_UAWM,
 	TSTBUS_UARM,
@@ -1424,6 +1425,12 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
+{
+	/* Qualcomm HC supports up to 64 */
+	return MAX_SUPP_MAC;
+}
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1447,6 +1454,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.get_hba_mac		= ufs_qcom_get_hba_mac,
 };
 
 /**
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index ba2a1d8..5112418 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -591,6 +591,8 @@ struct ufs_dev_info {
 	u8	*model;
 	u16	wspecversion;
 	u32	clk_gating_wait_us;
+	/* Stores the depth of queue in UFS device */
+	u8	bqueuedepth;
 
 	/* UFS HPB related flag */
 	bool	hpb_enabled;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7bf7599..e03b310 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -335,6 +336,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	int	(*get_hba_mac)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 4d4da06..67fcebd 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -57,6 +57,7 @@ enum {
 	REG_UFS_CCAP				= 0x100,
 	REG_UFS_CRYPTOCAP			= 0x104,
 
+	REG_UFS_MCQ_CFG				= 0x380,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
 
-- 
2.7.4

