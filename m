Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42136067CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJTSGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJTSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:06:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10D108DD1;
        Thu, 20 Oct 2022 11:06:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KBSjK9010690;
        Thu, 20 Oct 2022 18:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=G6kyQR567U3avWjeDezm2Dj2d3VhuldOJAXGWiCkzzg=;
 b=R6yJZV14tOFsI535zPZurJWhnUBwTm/AxAIgDV3tBkDQioz1H0zKzYOXdB3T7SSufAZ3
 h3/8mK17J0ZoIhIu/uUbFjKnxjOabnEdMLmH/oU4Z+GL0Rg7zt4Z0EdkkC9Wy+ZKqBjq
 xzlgI9BPIuDZrn2zl1JaFJznLuGM+QKdhnEauJcXMCSDY/mV6yXhPrqdhJtdBv6xmQPu
 jgZzGO/cKwnL0lSFUZ3kFG74hGIGh9QJGa4Kgm9aqGXJreOlweATJ/TBvbu8hV8wNfjw
 NkrtXbbMk31Y6piMeXU3X/uARuur9Xgc1j0t2vAcnnIyDmI1HQENojdQzihG+TVacx7O +A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kavq1ae63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:05:50 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KI5nWa021041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:05:49 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 11:05:49 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <quic_richardp@quicinc.com>,
        "Asutosh Das" <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Date:   Thu, 20 Oct 2022 11:03:36 -0700
Message-ID: <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1666288432.git.quic_asutoshd@quicinc.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S0Zo575ZFDhI88ibBcuc45zbGJASg8io
X-Proofpoint-ORIG-GUID: S0Zo575ZFDhI88ibBcuc45zbGJASg8io
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/ufs/core/ufs-mcq.c     | 34 ++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
 drivers/ufs/core/ufshcd.c      |  9 ++++++++-
 drivers/ufs/host/ufs-qcom.c    |  8 ++++++++
 include/ufs/ufs.h              |  2 ++
 include/ufs/ufshcd.h           |  2 ++
 include/ufs/ufshci.h           |  1 +
 7 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 6a34e0f..c0b37d3 100644
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
@@ -88,6 +90,38 @@ static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
 	{.name = "mcq_vs",},
 };
 
+/**
+ * ufshcd_mcq_decide_queue_depth - decide the queue depth
+ * @hba - per adapter instance
+ *
+ * MAC - Max. Active Command of the Host Controller (HC)
+ * HC wouldn't send more than this commands to the device.
+ * The default MAC is 32, but the max. value may vary with
+ * vendor implementation.
+ * Calculates and adjusts the queue depth based on the depth
+ * supported by the HC and ufs device.
+ */
+u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
+{
+	u32 qd, val;
+	int mac;
+
+	mac = ufshcd_mcq_vops_get_hba_mac(hba);
+	if (mac < 0) {
+		val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
+		mac = FIELD_GET(MCQ_CFG_MAC_MASK, val);
+	}
+
+	/*  MAC is a 0 based value. */
+	mac += 1;
+	/* max. value of bqueuedepth = 256, mac is host dependent */
+	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
+	if (!qd)
+		qd = mac;
+
+	return qd;
+}
+
 static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
 {
 	struct platform_device *pdev = to_platform_device(hba->dev);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index cf6bdd8e..6d16beb 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -51,6 +51,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, u8 index, bool *flag_res);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
 int ufshcd_mcq_init(struct ufs_hba *hba);
+u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
@@ -216,6 +217,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
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
index c83dcb95..b928ed8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7762,6 +7762,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	/* getting Specification Version in big endian format */
 	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
 	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
@@ -8178,10 +8179,16 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 {
 	int ret;
+	int old_nutrs = hba->nutrs;
 
+	hba->nutrs = ufshcd_mcq_decide_queue_depth(hba);
 	ret = ufshcd_mcq_init(hba);
+	if (ret) {
+		hba->nutrs = old_nutrs;
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 473fad8..5dc824f 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -25,6 +25,7 @@
 #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
 	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
 
+#define MAX_SUPP_MAC 63
 enum {
 	TSTBUS_UAWM,
 	TSTBUS_UARM,
@@ -1424,6 +1425,12 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
+{
+	/* Default is 32, but Qualcomm HC supports upto 64 */
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
index 6749c5b..2ddf88d 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -293,6 +293,7 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @get_hba_mac: called to get vendor specific mac value
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -331,6 +332,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	int	(*get_hba_mac)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index ef5c3a8..ca7db49d 100644
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

