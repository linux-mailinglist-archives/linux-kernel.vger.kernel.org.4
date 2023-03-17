Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8F6BEE46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCQQ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCQQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:28:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE7DCF76;
        Fri, 17 Mar 2023 09:28:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HAfq7p030994;
        Fri, 17 Mar 2023 16:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=aerBElR0OWPtvzZ+1tMvlDh88Zwd/vflrfx/dyJBImM=;
 b=ADz4mRGxO5r5s8W/WRRYdlE6JMh8Oyo/ubDtrEOJa10OzYM018yL/RgLSePFuM+2ZnK2
 FzLlqogI7nS8DtN1txOKPI9oK6uUv9cckxz4ePbQ6FAMTy1+5ULSys4UYK2+TERIlaRz
 SLSDf6e9yuiKPD/5z8oqHM+ONgHDS5rKE30N5aaaPW17XmnyNhtD1zFNHZFULONVH2+J
 SDKpxanRjsdpv3PEDG2TA7Mg67zoQdT3e8dpjQRIX3OwRF/atqb2D+reWNDBHHKtflFI
 ZN/xeGLBOOE95iW2s66wYMnn7LiorPlfktSRSyyBXxAWvtewwDnn1eREdxORe4TxCPP8 AQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc4vvc5pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:38 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HGSb9p031454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:37 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 09:28:34 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3 4/5] firmware: qcom_scm: Refactor code to support multiple download mode
Date:   Fri, 17 Mar 2023 21:58:01 +0530
Message-ID: <1679070482-8391-5-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TgN3fZrI7ffSd-HiPQZs5ofVJRhxtOEX
X-Proofpoint-GUID: TgN3fZrI7ffSd-HiPQZs5ofVJRhxtOEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on Qualcomm SoC, download_mode is enabled if
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.

Refactor the code such that it supports multiple download
modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
instead, give interface to set the download mode from
module parameter.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/Kconfig    | 11 ---------
 drivers/firmware/qcom_scm.c | 57 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e304..ff7e9f3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -215,17 +215,6 @@ config MTK_ADSP_IPC
 config QCOM_SCM
 	tristate
 
-config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
-	bool "Qualcomm download mode enabled by default"
-	depends on QCOM_SCM
-	help
-	  A device with "download mode" enabled will upon an unexpected
-	  warm-restart enter a special debug mode that allows the user to
-	  "download" memory content over USB for offline postmortem analysis.
-	  The feature can be enabled/disabled on the kernel command line.
-
-	  Say Y here to enable "download mode" by default.
-
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index eb491da..69f864d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,17 +20,19 @@
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
 #include <linux/arm-smccc.h>
+#include <linux/kstrtox.h>
 
 #include "qcom_scm.h"
 
-static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
-module_param(download_mode, bool, 0);
+static u32 download_mode;
 
 #define SCM_HAS_CORE_CLK	BIT(0)
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
+#define QCOM_DOWNLOAD_FULLDUMP	0x10
+#define QCOM_DOWNLOAD_NODUMP	0x0
 
 struct qcom_scm {
 	struct device *dev;
@@ -439,8 +441,9 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 
-static void qcom_scm_set_download_mode(bool enable)
+static void qcom_scm_set_download_mode(u32 download_mode)
 {
+	bool enable = !!download_mode;
 	bool avail;
 	int ret = 0;
 
@@ -452,7 +455,7 @@ static void qcom_scm_set_download_mode(bool enable)
 	} else if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
 				QCOM_DOWNLOAD_MODE_MASK,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+				enable ? download_mode : 0);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
@@ -1418,6 +1421,46 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+
+static int get_download_mode(char *buffer, const struct kernel_param *kp)
+{
+	int len;
+
+	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
+		len = sysfs_emit(buffer, "full\n");
+	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
+		len = sysfs_emit(buffer, "off\n");
+
+	return len;
+}
+
+static int set_download_mode(const char *val, const struct kernel_param *kp)
+{
+	if (!strncmp(val, "full", strlen("full"))) {
+		download_mode = QCOM_DOWNLOAD_FULLDUMP;
+	} else if (!strncmp(val, "off", strlen("off"))) {
+		download_mode = QCOM_DOWNLOAD_NODUMP;
+	} else if (kstrtouint(val, 0, &download_mode) ||
+		   !(download_mode == 0 || download_mode == 1)) {
+		pr_err("unknown download mode\n");
+		return -EINVAL;
+	}
+
+	if (__scm)
+		qcom_scm_set_download_mode(download_mode);
+
+	return 0;
+}
+
+static const struct kernel_param_ops download_mode_param_ops = {
+	.get = get_download_mode,
+	.set = set_download_mode,
+};
+
+module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
+MODULE_PARM_DESC(download_mode,
+		 "Download mode: off/full or 0/1 for existing users");
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
@@ -1511,12 +1554,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__get_convention();
 
 	/*
-	 * If requested enable "download mode", from this point on warmboot
+	 * If "download mode" is requested, from this point on warmboot
 	 * will cause the boot stages to enter download mode, unless
 	 * disabled below by a clean shutdown/reboot.
 	 */
 	if (download_mode)
-		qcom_scm_set_download_mode(true);
+		qcom_scm_set_download_mode(download_mode);
 
 	return 0;
 }
@@ -1524,7 +1567,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-- 
2.7.4

