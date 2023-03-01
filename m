Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4086A6A52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCAJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCAJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:58:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6817A24C9D;
        Wed,  1 Mar 2023 01:58:09 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3216cMNk023643;
        Wed, 1 Mar 2023 09:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+FZpNfLkdDyqzXjB0eX1M8JOxdfTOmA1cb8JAzLa99k=;
 b=WuIgQgno2nNL01qXMDjmXqPbspQIqvsBlPe9THAHNlNvvQw2uWmGKFViEBi7nPHXITyM
 5NcYfmppbS7vntS8UdFwDyZUdepCwTL2DpNuvjv3UMvg0LOSwx79tA1SNfIh5ZAEw+fZ
 knCYz5Il10YPWtty90pv4FLUSemA3qTcNglVmmAS3TuZ1VKn+V/U3J60vGmnIPzkAxV2
 5rK5vHFNX50pS8OBwstu1UTNdQ4X8n6BPEdVx+YKQbIvuH+l+bkKmZUxmDzDDxHJTg0z
 xamArhkQOha+ANpTuXBqiSR+2jFfhNACTdqlp0ZLKj+n8TEmGTmEjAbkiciPlYfCeDXv 0Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1mwxaj2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 09:57:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3219v4oO016400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 09:57:04 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 01:57:02 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 3/4] firmware: qcom_scm: Refactor code to support multiple download mode
Date:   Wed, 1 Mar 2023 15:25:54 +0530
Message-ID: <1677664555-30191-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ny4qEyvpBspzvwLmvwo7XbcKuNe-Ky78
X-Proofpoint-GUID: Ny4qEyvpBspzvwLmvwo7XbcKuNe-Ky78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
 - Passed download mode as parameter
 - Accept human accepatable download mode string.
 - enable = !!dload_mode
 - Shifted module param callback to somewhere down in
   the file so that it no longer need to know the
   prototype of qcom_scm_set_download_mode()
 - updated commit text.

 drivers/firmware/Kconfig    | 11 --------
 drivers/firmware/qcom_scm.c | 65 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 20 deletions(-)

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
index c9f1fad..ca07208 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -17,17 +17,22 @@
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
 #include <linux/arm-smccc.h>
+#include <linux/kstrtox.h>
 
 #include "qcom_scm.h"
 
-static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
-module_param(download_mode, bool, 0);
-
 #define SCM_HAS_CORE_CLK	BIT(0)
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
+#define QCOM_DOWNLOAD_FULLDUMP	0x10
+#define QCOM_DOWNLOAD_NODUMP	0x0
+
+#define MAX_DLOAD_LEN	8
+
+static char download_mode[] = "off";
+static u32 dload_mode;
 
 struct qcom_scm {
 	struct device *dev;
@@ -417,8 +422,9 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 
-static void qcom_scm_set_download_mode(bool enable)
+static void qcom_scm_set_download_mode(u32 dload_mode)
 {
+	bool enable = !!dload_mode;
 	bool avail;
 	int ret = 0;
 	u32 val;
@@ -438,7 +444,7 @@ static void qcom_scm_set_download_mode(bool enable)
 
 		val &= ~QCOM_DOWNLOAD_MODE_MASK;
 		if (enable)
-			val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
+			val |= dload_mode;
 
 		ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
 	} else {
@@ -1338,6 +1344,47 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
+static int set_dload_mode(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	if (!strncmp(val, "full", strlen("full"))) {
+		dload_mode = QCOM_DOWNLOAD_FULLDUMP;
+	} else if (!strncmp(val, "off", strlen("off"))) {
+		dload_mode = QCOM_DOWNLOAD_NODUMP;
+	} else {
+		if (kstrtouint(val, 0, &dload_mode) ||
+		     !(dload_mode == 0 || dload_mode == 1)) {
+			pr_err("unknown download mode\n");
+			return -EINVAL;
+		}
+
+	}
+
+	ret = param_set_copystring(val, kp);
+	if (ret)
+		return ret;
+
+	if (__scm)
+		qcom_scm_set_download_mode(dload_mode);
+
+	return 0;
+}
+
+static const struct kernel_param_ops dload_mode_param_ops = {
+	.set = set_dload_mode,
+	.get = param_get_string,
+};
+
+static struct kparam_string dload_mode_param = {
+	.string = download_mode,
+	.maxlen = MAX_DLOAD_LEN,
+};
+
+module_param_cb(download_mode, &dload_mode_param_ops, &dload_mode_param, 0644);
+MODULE_PARM_DESC(download_mode,
+		 "Download mode: off/full or 0/1/off/on for existing users");
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
@@ -1418,12 +1465,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__get_convention();
 
 	/*
-	 * If requested enable "download mode", from this point on warmboot
+	 * If download mode is requested, from this point on warmboot
 	 * will cause the boot stages to enter download mode, unless
 	 * disabled below by a clean shutdown/reboot.
 	 */
-	if (download_mode)
-		qcom_scm_set_download_mode(true);
+	if (dload_mode)
+		qcom_scm_set_download_mode(dload_mode);
 
 	return 0;
 }
@@ -1431,7 +1478,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-- 
2.7.4

