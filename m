Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495146F5CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjECRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjECRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:06:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB67A84;
        Wed,  3 May 2023 10:05:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343DICht030849;
        Wed, 3 May 2023 17:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TcGExpkNVAKfPkIom5yVtMwcamlW4zFdCnQ1qI8g5Cg=;
 b=QQbDL9gqnDSzsiMazhE6SagRtHuYAMfYfI0wdli5HkaV/nG/kg2fX5EZeKTtsnE9HAAC
 cqvQUYYILNHgMsClh/qhygo3XNEYXILLU9vu8gURw7NLXMAT5AolCEqr9jGJ96sL73LJ
 1+PFYiNoaovsEai3oqekmrSFnrlp26U6dSSpZ0cK82sE+abSFvMgtNfyPQAPdkVmFWj+
 VrzlAfiYLHzC828JXhe5Fz5T83Lu8CyQGPZpob6O91qEIyDFXdNl5erWFyWY5EhIweVv
 LaHTJIoXd3XazGBWKpQQJoiFxrZwE6mVCvASeG3LW/L5SXlDz9uoYG6cNEFfqqWQoKsb pQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbjwn9971-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:04:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H4Zlo004836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:04:35 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:04:29 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 17/18] firmware: qcom_scm: Refactor code to support multiple download mode
Date:   Wed, 3 May 2023 22:32:31 +0530
Message-ID: <1683133352-10046-18-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ReaFtwFdu3iYyzqu5eWcJvSg8A06psLn
X-Proofpoint-ORIG-GUID: ReaFtwFdu3iYyzqu5eWcJvSg8A06psLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/firmware/qcom_scm.c | 60 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 19 deletions(-)

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
index 775ac68..4e8fd4e 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,11 +20,11 @@
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
@@ -32,6 +32,7 @@ module_param(download_mode, bool, 0);
 
 #define QCOM_DOWNLOAD_MODE_MASK 0x30
 #define QCOM_DOWNLOAD_FULLDUMP	0x1
+#define QCOM_DOWNLOAD_NODUMP	0x0
 
 struct qcom_scm {
 	struct device *dev;
@@ -440,8 +441,9 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 
-static void qcom_scm_set_download_mode(bool enable)
+static void qcom_scm_set_download_mode(u32 download_mode)
 {
+	bool enable = !!download_mode;
 	bool avail;
 	int ret = 0;
 
@@ -452,8 +454,7 @@ static void qcom_scm_set_download_mode(bool enable)
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
 	} else if (__scm->dload_mode_addr) {
 		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
-				QCOM_DOWNLOAD_MODE_MASK,
-				enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
+				QCOM_DOWNLOAD_MODE_MASK, download_mode);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
@@ -1421,6 +1422,49 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+
+static int get_download_mode(char *buffer, const struct kernel_param *kp)
+{
+	int len = 0;
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
+	u32 old = download_mode;
+
+	if (sysfs_streq(val, "full")) {
+		download_mode = QCOM_DOWNLOAD_FULLDUMP;
+	} else if (sysfs_streq(val, "off")) {
+		download_mode = QCOM_DOWNLOAD_NODUMP;
+	} else if (kstrtouint(val, 0, &download_mode) ||
+		   !(download_mode == 0 || download_mode == 1)) {
+		download_mode = old;
+		pr_err("qcom_scm: unknown download mode: %s\n", val);
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
@@ -1514,12 +1558,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
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
@@ -1527,7 +1571,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
-- 
2.7.4

