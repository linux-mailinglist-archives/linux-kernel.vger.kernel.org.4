Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E068D615BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKBFbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKBFbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:31:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D272714C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:31:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b5so15326562pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc4GmW9txqDoA8MM/0Y4l6ly3F19+LNl4kUujoracOw=;
        b=fcc3IYhEBjiQBC8ASnv7gGOQddgn7OPoqKGdhWmfOqf1K1FMaq1yps33s857m3UQBr
         W0+SJrYJ/UFB02MiPTDYoSwFgbdg31zRVMkTDqKsU4MVSrqO5DP5QBXFe3deOUy862t9
         A5EdF8rE+MttgJqFimTnMaqLmkfxMX7sTQhGiulNkSrSAC2V5QgLwoKguPIR5Bnjdcuh
         ++ulJS8L0YNcwkc8mED5XbrnRyACqzhVyCOUzYWbV+9xpuBdjxEr8s0of6B/Fy4KODIh
         hBnl/0mAln78BFAIpbb7y8XjbZwrp/X8oFd6alaTPjKiAq65Q9SbHpoqE9VJedw1imUn
         upOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc4GmW9txqDoA8MM/0Y4l6ly3F19+LNl4kUujoracOw=;
        b=ZUgcCugVkcwyx+bpJLrm9yT2yOeh5SEiH1YYWryiMFsIqEdmkakEUoJ0eEyO9dxcBI
         slCLjy/r/3FqfyiwBDcUV4pfFrfy0mre69ak7RLl0U7iHQQcN+CHb5qI9OA6k5E/iGE3
         GwmlbJMX8gzNMiiKhIVHRpuafuoD6BhVXapKwcxOtZpTH1/qUlr7h+2oaN5dVEL2yFQ2
         jndiljOM1UvVt8k9RptcBycRUnXaYs7sVWBKoHY0920A5Tm3O/Oa15R+B30/CQEy5Rn3
         uJmdnBB6vFuSxR8LLQJdzlkg+PSKP8lOg+VIPHrdgTwNTFm2LAQffIWwiZWlrvKKTEV6
         QL8g==
X-Gm-Message-State: ACrzQf3LQVaojBh3lWendBTabqnjYaTU4G5g76Mr1oFQtnbzPnt4SGGF
        yqJjPJX9i6O3nuWVQM/Ryj5X9g==
X-Google-Smtp-Source: AMsMyM41497Ku2kkIH2pBsgMV+rlqBd7gmrbqLYbGO57+tFsGah3avd2yLGWEcY0XyhtwY6pLJJkLQ==
X-Received: by 2002:a63:f47:0:b0:46a:e00c:24c7 with SMTP id 7-20020a630f47000000b0046ae00c24c7mr20321723pgp.239.1667367095360;
        Tue, 01 Nov 2022 22:31:35 -0700 (PDT)
Received: from ubuntu18.mioffice.cn ([2408:8607:1b00:7:9e7b:efff:fe41:a22a])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b00186b69157ecsm7276367plg.202.2022.11.01.22.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:31:35 -0700 (PDT)
From:   Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: [RESEND PATCH 3/4] scsi:ufs:add FBO module
Date:   Wed,  2 Nov 2022 13:30:57 +0800
Message-Id: <20221102053058.21021-4-lijiaming3@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijiaming3 <lijiaming3@xiaomi.com>

add fbo module, determine whether the device supports
the FBO function and initialize FBO related info

Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
---
 drivers/ufs/core/Kconfig  |  12 ++++
 drivers/ufs/core/Makefile |   1 +
 drivers/ufs/core/ufsfbo.c | 120 ++++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufsfbo.h |  23 ++++++++
 drivers/ufs/core/ufshcd.c |   4 ++
 include/ufs/ufs.h         |   3 +
 include/ufs/ufshcd.h      |   1 +
 7 files changed, 164 insertions(+)
 create mode 100644 drivers/ufs/core/ufsfbo.c
 create mode 100644 drivers/ufs/core/ufsfbo.h

diff --git a/drivers/ufs/core/Kconfig b/drivers/ufs/core/Kconfig
index e11978171403..30d3b6f07f5b 100644
--- a/drivers/ufs/core/Kconfig
+++ b/drivers/ufs/core/Kconfig
@@ -58,3 +58,15 @@ config SCSI_UFS_HWMON
 	  a hardware monitoring device will be created for the UFS device.
 
 	  If unsure, say N.
+
+config SCSI_UFS_FBO
+	bool "Support UFS File-based Optimization"
+	depends on SCSI_UFSHCD
+	help
+	  The UFS FBO feature improves sequential read performance. The host send
+	  the LBA info to device first. And then instrut the device to analyse the
+	  LBA fragment info. After the analysis, the host can instruct the device to
+	  return the LBA's fragmented state. Then the host can decide whether to
+	  optimize based on the fragmentation status. After the	defragmentation is
+	  concluded, it is expected that the sequential read performance will be
+	  improved.
diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
index 62f38c5bf857..af7870126815 100644
--- a/drivers/ufs/core/Makefile
+++ b/drivers/ufs/core/Makefile
@@ -8,3 +8,4 @@ ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
 ufshcd-core-$(CONFIG_SCSI_UFS_HPB)	+= ufshpb.o
 ufshcd-core-$(CONFIG_SCSI_UFS_FAULT_INJECTION) += ufs-fault-injection.o
 ufshcd-core-$(CONFIG_SCSI_UFS_HWMON)	+= ufs-hwmon.o
+ufshcd-core-$(CONFIG_SCSI_UFS_FBO)	+= ufsfbo.o
\ No newline at end of file
diff --git a/drivers/ufs/core/ufsfbo.c b/drivers/ufs/core/ufsfbo.c
new file mode 100644
index 000000000000..81326fd2fb3d
--- /dev/null
+++ b/drivers/ufs/core/ufsfbo.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Universal Flash Storage File-based Optimization
+ *
+ * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
+ *
+ * Authors:
+ *		lijiaming <lijiaming3@xiaomi.com>
+ */
+
+#include "ufshcd-priv.h"
+#include "ufsfbo.h"
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <asm/unaligned.h>
+
+/**
+ * struct ufsfbo_dev_info - FBO device related info
+ * @fbo_version: UFS file-based optimization Version
+ * @fbo_rec_lrs: Recommended LBA Range Size In Bytes
+ * @fbo_max_lrs: The Max LBA Range Size To Be Used By The Host
+ * @fbo_min_lrs: The Min LBA Range Size To Be Used By The Host
+ * @fbo_max_lrc: The Max Number Of LBA Ranges Supported By Read/Write Buffer Cmd
+ * @fbo_lra: Alignment Requirement. 0 Means No Align Requirement
+ * @fbo_exec_threshold: the execute level of UFS file-based optimization
+ */
+struct ufsfbo_dev_info {
+	u16 fbo_version;
+	u32 fbo_rec_lrs;
+	u32 fbo_max_lrs;
+	u32 fbo_min_lrs;
+	int fbo_max_lrc;
+	int fbo_lra;
+	u8  fbo_exec_threshold;
+};
+/**
+ * struct ufsfbo_ctrl - FBO ctrl structure
+ * @hba: Per adapter private structure
+ * @fbo_dev_info: FBO device related info
+ * @fbo_lba_cnt: Number of LBA required to do FBO
+ */
+struct ufsfbo_ctrl {
+	struct ufs_hba *hba;
+	struct ufsfbo_dev_info fbo_dev_info;
+	int fbo_lba_cnt;
+};
+
+static int ufsfbo_get_dev_info(struct ufs_hba *hba, struct ufsfbo_ctrl *fbo_ctrl)
+{
+	int ret;
+	u32 val;
+	u8 *desc_buf;
+	int buf_len;
+	struct ufsfbo_dev_info *fbo_info = &fbo_ctrl->fbo_dev_info;
+
+	buf_len = hba->desc_size[QUERY_DESC_IDN_FBO];
+	desc_buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!desc_buf)
+		return -ENOMEM;
+
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+					QUERY_DESC_IDN_FBO, 0, 0, desc_buf, &buf_len);
+	if (ret) {
+		dev_err(hba->dev, "%s: Failed reading FBO Desc. ret = %d\n",
+				__func__, ret);
+		goto out;
+	}
+
+	fbo_info->fbo_version = get_unaligned_be16(desc_buf + FBO_DESC_PARAM_VERSION);
+	fbo_info->fbo_rec_lrs = get_unaligned_be32(desc_buf + FBO_DESC_PARAM_REC_LBA_RANGE_SIZE);
+	fbo_info->fbo_max_lrs = get_unaligned_be32(desc_buf + FBO_DESC_PARAM_MAX_LBA_RANGE_SIZE);
+	fbo_info->fbo_min_lrs = get_unaligned_be32(desc_buf + FBO_DESC_PARAM_MIN_LBA_RANGE_SIZE);
+	fbo_info->fbo_max_lrc = desc_buf[FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT];
+	fbo_info->fbo_lra = get_unaligned_be16(desc_buf + FBO_DESC_PARAM_MAX_LBA_RANGE_ALIGNMENT);
+
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				QUERY_ATTR_IDN_FBO_LEVEL_EXE, 0, 0, &val);
+	if (ret) {
+		dev_err(hba->dev, "%s: Failed reading FBO Attr. ret = %d\n",
+				__func__, ret);
+		goto out;
+	}
+
+	fbo_info->fbo_exec_threshold = val;
+
+out:
+	kfree(desc_buf);
+	return ret;
+}
+
+int ufsfbo_probe(struct ufs_hba *hba, const u8 *desc_buf)
+{
+	struct ufsfbo_ctrl *fbo_ctrl;
+	u32 ext_ufs_feature;
+
+	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+
+	if (!(ext_ufs_feature & UFS_DEV_FBO_SUP))
+		return -EOPNOTSUPP;
+
+	fbo_ctrl = kzalloc(sizeof(struct ufsfbo_ctrl), GFP_KERNEL);
+	if (!fbo_ctrl)
+		return -ENOMEM;
+
+	if (ufsfbo_get_dev_info(hba, fbo_ctrl))
+		return -EOPNOTSUPP;
+
+	hba->fbo_ctrl = fbo_ctrl;
+	fbo_ctrl->hba = hba;
+
+	return 0;
+}
+
+void ufsfbo_remove(struct ufs_hba *hba)
+{
+	if (!hba->fbo_ctrl)
+		return;
+
+	kfree(hba->fbo_ctrl);
+}
diff --git a/drivers/ufs/core/ufsfbo.h b/drivers/ufs/core/ufsfbo.h
new file mode 100644
index 000000000000..843fa8a75c2c
--- /dev/null
+++ b/drivers/ufs/core/ufsfbo.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Universal Flash Storage File-based Optimization
+ *
+ * Copyright (C) 2022 Xiaomi Mobile Software Co., Ltd
+ *
+ * Authors:
+ *		lijiaming <lijiaming3@xiaomi.com>
+ */
+
+#ifndef _UFSFBO_H_
+#define _UFSFBO_H_
+
+#ifdef CONFIG_SCSI_UFS_FBO
+int ufsfbo_probe(struct ufs_hba *hba, const u8 *desc_buf);
+void ufsfbo_remove(struct ufs_hba *hba);
+extern const struct attribute_group ufs_sysfs_fbo_param_group;
+#else
+static inline int ufsfbo_probe(struct ufs_hba *hba, const u8 *desc_buf) {}
+static inline void ufsfbo_remove(struct ufs_hba *hba) {}
+#endif
+
+#endif /* _UFSFBO_H_ */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4bc5b8563a62..f769fcb72392 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -35,6 +35,7 @@
 #include "ufs_bsg.h"
 #include "ufshcd-crypto.h"
 #include "ufshpb.h"
+#include "ufsfbo.h"
 #include <asm/unaligned.h>
 
 #define CREATE_TRACE_POINTS
@@ -7778,6 +7779,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_wb_probe(hba, desc_buf);
 
+	ufsfbo_probe(hba, desc_buf);
+
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
 	/*
@@ -9534,6 +9537,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufs_hwmon_remove(hba);
 	ufs_bsg_remove(hba);
 	ufshpb_remove(hba);
+	ufsfbo_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	blk_mq_destroy_queue(hba->tmf_queue);
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index c3fd954ce005..2ab79760dafe 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -165,6 +165,9 @@ enum attr_idn {
 	QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       = 0x1D,
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
+	QUERY_ATTR_IDN_FBO_CONTROL		= 0x31,
+	QUERY_ATTR_IDN_FBO_LEVEL_EXE		= 0X32,
+	QUERY_ATTR_IDN_FBO_PROG_STATE		= 0x33,
 };
 
 /* Descriptor idn for Query requests */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9f28349ebcff..5c7367a54bbb 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -973,6 +973,7 @@ struct ufs_hba {
 	struct delayed_work debugfs_ee_work;
 	u32 debugfs_ee_rate_limit_ms;
 #endif
+	struct ufsfbo_ctrl *fbo_ctrl;
 	u32 luns_avail;
 	bool complete_put;
 };
-- 
2.38.1

