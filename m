Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA15E713F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiIWBNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiIWBMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:12:54 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012AD5F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1663895573; x=1695431573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NZ6IfY9jNlmhkngETTwjymbps/pTn0EE8CD/gheX568=;
  b=Xu69TY6YeFr9iShlFRedwgOoHuB/QjovUDoID0NpsqEDRa7GsJEkaJab
   whNDVbufG769Cahhe50MDPDMgmZbMC5YMl5rEaOdG7jQZu2018VoMXQ1p
   9/ki3VBqS+xUGDG9aKefeTgvV32Wcz7BQU6CmU5M4imVZClyw1Qht1Okv
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Sep 2022 18:06:46 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 18:06:46 -0700
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 18:06:46 -0700
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
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 04/16] ufs: core: mcq: Introduce Multi Circular Queue
Date:   Thu, 22 Sep 2022 18:05:11 -0700
Message-ID: <e0ae0fccc579fa17b6cfcf3b8bcf963f5ebe67fa.1663894792.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663894792.git.quic_asutoshd@quicinc.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce multi-circular queue (MCQ) which has been added
in UFSHC v4.0 standard in addition to the Single Doorbell mode.
The MCQ mode supports multiple submission and completion queues.
Add support to configure the number of queues.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/Makefile      |   2 +-
 drivers/ufs/core/ufs-mcq.c     | 132 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |   1 +
 drivers/ufs/core/ufshcd.c      |  12 ++++
 include/ufs/ufshcd.h           |   4 ++
 5 files changed, 150 insertions(+), 1 deletion(-)
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
index 0000000..934556f
--- /dev/null
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -0,0 +1,132 @@
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
+#define UFS_MCQ_MIN_RW_QUEUES 2
+#define UFS_MCQ_MIN_READ_QUEUES 0
+#define UFS_MCQ_MIN_POLL_QUEUES 0
+
+static unsigned int dev_cmd_queue = 1;
+
+static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int n;
+	int ret;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret)
+		return ret;
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
+	unsigned int n;
+	int ret;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret)
+		return ret;
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
+	unsigned int n;
+	int ret;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret)
+		return ret;
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
+	int i, rem;
+	u32 hbaq_cap, cmp, tot_queues;
+	struct Scsi_Host *host = hba->host;
+
+	hbaq_cap = hba->mcq_capabilities & 0xff;
+
+	if (!rw_queues)
+		rw_queues = num_possible_cpus();
+
+	tot_queues = dev_cmd_queue + read_queues + poll_queues + rw_queues;
+	if (hbaq_cap < tot_queues) {
+		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
+			tot_queues, hbaq_cap);
+		return -EOPNOTSUPP;
+	}
+
+	rem = hbaq_cap - dev_cmd_queue;
+	cmp = rem;
+	hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(cmp, rw_queues,
+						 num_possible_cpus());
+	rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
+	cmp = rem;
+	hba->nr_queues[HCTX_TYPE_POLL] = min(cmp, poll_queues);
+	rem -= hba->nr_queues[HCTX_TYPE_POLL];
+	cmp = rem;
+	hba->nr_queues[HCTX_TYPE_READ] = min(cmp, read_queues);
+
+	for (i = 0; i < HCTX_MAX_TYPES; i++)
+		host->nr_hw_queues += hba->nr_queues[i];
+
+	hba->nr_hw_queues = host->nr_hw_queues + dev_cmd_queue;
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
index 8f67db2..cf6bdd8e 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -50,6 +50,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, u8 index, bool *flag_res);
 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
+int ufshcd_mcq_init(struct ufs_hba *hba);
 
 #define SD_ASCII_STD true
 #define SD_RAW false
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 426867b..f4bb402 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8172,6 +8172,15 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	return ret;
 }
 
+static int ufshcd_config_mcq(struct ufs_hba *hba)
+{
+	int ret;
+
+	ret = ufshcd_mcq_init(hba);
+
+	return ret;
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize it
  * @hba: per-adapter instance
@@ -8221,6 +8230,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 			goto out;
 
 		if (is_mcq_supported(hba)) {
+			ret = ufshcd_config_mcq(hba);
+			if (ret)
+				goto out;
 			ret = scsi_add_host(host, hba->dev);
 			if (ret) {
 				dev_err(hba->dev, "scsi_add_host failed\n");
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index da7ec0c..298e103 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -827,6 +827,8 @@ struct ufs_hba_monitor {
  *	ufshcd_resume_complete()
  * @ext_iid_sup: is EXT_IID is supported by UFSHC
  * @mcq_sup: is mcq supported by UFSHC
+ * @nr_hw_queues: number of hardware queues configured
+ * @nr_queues: number of Queues of different queue types
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -977,6 +979,8 @@ struct ufs_hba {
 	bool complete_put;
 	bool ext_iid_sup;
 	bool mcq_sup;
+	unsigned int nr_hw_queues;
+	unsigned int nr_queues[HCTX_MAX_TYPES];
 };
 
 static inline bool is_mcq_supported(struct ufs_hba *hba)
-- 
2.7.4

