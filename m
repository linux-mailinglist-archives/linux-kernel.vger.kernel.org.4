Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971FA63E1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiK3U32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiK3U3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:29:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D160F5132F;
        Wed, 30 Nov 2022 12:29:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUK8QuM007194;
        Wed, 30 Nov 2022 20:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qoNczxWKn7OWA6oOtPlIoQ05gd3AruxeCbhc1tsdva0=;
 b=jWQwEFo8o+bSDt7Y2os4Evr6RdMtZEsGKlJcdOivrNVmE6WXikXB5P8AWJhYzFzJAQHH
 tIZYhOxdsGgBL4xcuIlScjE5CHW7EBgimHUQDzkTfaLnxKlFJL8pmAbbZtWpM+pu10qf
 25kool8civmitNk76OxoJ7SO9hWsnKfKkAfWJL6opcJ9yv2zxrf/WGdgG5Ay0IzCoyRw
 NjEHfTzF1HVogNKdQ/IAhZCWztaQ8cKv9ja46PaxLdsLB9JvVCOsVpiy/D0bZRzHmmD6
 GnABDU2ywcqDUjocsvdzEPXEmFUzxizEtCumJq+qD2th7aG9YeY3+NHwlBz+aDy0n44B nw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6dxx81n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:28:47 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AUKSkdK010619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:28:46 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 12:28:46 -0800
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 05/16] ufs: core: mcq: Add support to allocate multiple queues
Date:   Wed, 30 Nov 2022 12:27:46 -0800
Message-ID: <c5b8081775bfd0f26ea70ace77ccd54ac007e196.1669839847.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669839847.git.quic_asutoshd@quicinc.com>
References: <cover.1669839847.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9uIQSDUlzPLf1WyFPCzO0qhcpPGNWfkD
X-Proofpoint-GUID: 9uIQSDUlzPLf1WyFPCzO0qhcpPGNWfkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-circular queue (MCQ) has been added in UFSHC v4.0
standard in addition to the Single Doorbell mode.
The MCQ mode supports multiple submission and completion queues.
Add support to allocate and configure the queues.
Add module parameters support to configure the queues.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/Makefile      |   2 +-
 drivers/ufs/core/ufs-mcq.c     | 125 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |   1 +
 drivers/ufs/core/ufshcd.c      |  12 ++++
 include/ufs/ufshcd.h           |   4 ++
 5 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ufs/core/ufs-mcq.c

diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
index 62f38c5..4d02e0f 100644
--- a/drivers/ufs/core/Makefile
+++ b/drivers/ufs/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SCSI_UFSHCD)		+= ufshcd-core.o
-ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
+ufshcd-core-y				+= ufshcd.o ufs-sysfs.o ufs-mcq.o
 ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
 ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
new file mode 100644
index 0000000..bf08ec5
--- /dev/null
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center. All rights reserved.
+ *
+ * Authors:
+ *	Asutosh Das <quic_asutoshd@quicinc.com>
+ *	Can Guo <quic_cang@quicinc.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "ufshcd-priv.h"
+
+#define MAX_QUEUE_SUP GENMASK(7, 0)
+#define UFS_MCQ_MIN_RW_QUEUES 2
+#define UFS_MCQ_MIN_READ_QUEUES 0
+#define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
+#define UFS_MCQ_MIN_POLL_QUEUES 0
+
+static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
+				     num_possible_cpus());
+}
+
+static const struct kernel_param_ops rw_queue_count_ops = {
+	.set = rw_queue_count_set,
+	.get = param_get_uint,
+};
+
+static unsigned int rw_queues;
+module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
+MODULE_PARM_DESC(rw_queues,
+		 "Number of interrupt driven I/O queues used for rw. Default value is nr_cpus");
+
+static int read_queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_READ_QUEUES,
+				     num_possible_cpus());
+}
+
+static const struct kernel_param_ops read_queue_count_ops = {
+	.set = read_queue_count_set,
+	.get = param_get_uint,
+};
+
+static unsigned int read_queues;
+module_param_cb(read_queues, &read_queue_count_ops, &read_queues, 0644);
+MODULE_PARM_DESC(read_queues,
+		 "Number of interrupt driven read queues used for read. Default value is 0");
+
+static int poll_queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_POLL_QUEUES,
+				     num_possible_cpus());
+}
+
+static const struct kernel_param_ops poll_queue_count_ops = {
+	.set = poll_queue_count_set,
+	.get = param_get_uint,
+};
+
+static unsigned int poll_queues = 1;
+module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
+MODULE_PARM_DESC(poll_queues,
+		 "Number of poll queues used for r/w. Default value is 1");
+
+static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
+{
+	int i;
+	u32 hba_maxq, rem, tot_queues;
+	struct Scsi_Host *host = hba->host;
+
+	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
+
+	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
+			rw_queues;
+
+	if (hba_maxq < tot_queues) {
+		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
+			tot_queues, hba_maxq);
+		return -EOPNOTSUPP;
+	}
+
+	rem = hba_maxq - UFS_MCQ_NUM_DEV_CMD_QUEUES;
+
+	if (rw_queues) {
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = rw_queues;
+		rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		rw_queues = num_possible_cpus();
+	}
+
+	if (poll_queues) {
+		hba->nr_queues[HCTX_TYPE_POLL] = poll_queues;
+		rem -= hba->nr_queues[HCTX_TYPE_POLL];
+	}
+
+	if (read_queues) {
+		hba->nr_queues[HCTX_TYPE_READ] = read_queues;
+		rem -= hba->nr_queues[HCTX_TYPE_READ];
+	}
+
+	if (!hba->nr_queues[HCTX_TYPE_DEFAULT])
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(rem, rw_queues,
+							 num_possible_cpus());
+
+	for (i = 0; i < HCTX_MAX_TYPES; i++)
+		host->nr_hw_queues += hba->nr_queues[i];
+
+	hba->nr_hw_queues = host->nr_hw_queues + UFS_MCQ_NUM_DEV_CMD_QUEUES;
+	return 0;
+}
+
+int ufshcd_mcq_init(struct ufs_hba *hba)
+{
+	int ret;
+
+	ret = ufshcd_mcq_config_nr_queues(hba);
+
+	return ret;
+}
+
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index a9e8e1f..9368ba2 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -61,6 +61,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, u8 index, bool *flag_res);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
+int ufshcd_mcq_init(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3c2220c..9b78814 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8220,6 +8220,11 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	return ret;
 }
 
+static int ufshcd_alloc_mcq(struct ufs_hba *hba)
+{
+	return ufshcd_mcq_init(hba);
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize it
  * @hba: per-adapter instance
@@ -8269,6 +8274,13 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 			goto out;
 
 		if (is_mcq_supported(hba)) {
+			ret = ufshcd_alloc_mcq(hba);
+			if (ret) {
+				/* Continue with SDB mode */
+				use_mcq_mode = false;
+				dev_err(hba->dev, "MCQ mode is disabled, err=%d\n",
+					 ret);
+			}
 			ret = scsi_add_host(host, hba->dev);
 			if (ret) {
 				dev_err(hba->dev, "scsi_add_host failed\n");
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 70c0f9f..146b613 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -829,6 +829,8 @@ struct ufs_hba_monitor {
  *	ee_ctrl_mask
  * @luns_avail: number of regular and well known LUNs supported by the UFS
  *	device
+ * @nr_hw_queues: number of hardware queues configured
+ * @nr_queues: number of Queues of different queue types
  * @complete_put: whether or not to call ufshcd_rpm_put() from inside
  *	ufshcd_resume_complete()
  * @ext_iid_sup: is EXT_IID is supported by UFSHC
@@ -981,6 +983,8 @@ struct ufs_hba {
 	u32 debugfs_ee_rate_limit_ms;
 #endif
 	u32 luns_avail;
+	unsigned int nr_hw_queues;
+	unsigned int nr_queues[HCTX_MAX_TYPES];
 	bool complete_put;
 	bool ext_iid_sup;
 	bool mcq_sup;
-- 
2.7.4

