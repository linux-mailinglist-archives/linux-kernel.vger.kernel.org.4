Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1540669E288
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjBUOkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjBUOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:40:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C3628D1E;
        Tue, 21 Feb 2023 06:40:08 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDZRmB001877;
        Tue, 21 Feb 2023 14:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=IwZRW6l6jcYWknvtnXsL53z2sTmEbJH1YXShJA0h5bs=;
 b=c7Ctk13AI+M4m6CO6tiPMDBaAuo/sq/5uEAFU5IMoM9NggLsvSaakBI4uaEV0ICpgRt2
 9VKUhCpDwbdAkv0ZigFe6W9u95ECFKu5F6xGbhuUH9QMmVWeLEGYTlqhacyLQ/VEIE8h
 SaTTP5SXgv61xOfIsgRp2SC7kHqrJ70eFd8DhrJvWblmbX1ZaysAJYza3Z9FnuHPQdsk
 Pw0UWUoT9B6G4+uaYdN6PkNcUV6bpmJV/opBoAKGeTjzrCZ0JkBPgjpl2UI8JoZXw2Si
 aOhMO02ht6A43xhsWJca8bm0Cz4UKO0Oll6edvgRT4+leQifHG/1XCQVxAUluj0RcVA/ XQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvn8r9fh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:40:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LEe31L009009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:40:03 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 06:40:01 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH 3/4] firmware: qcom_scm: Refactor code to support multiple download mode
Date:   Tue, 21 Feb 2023 20:09:40 +0530
Message-ID: <1676990381-18184-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
References: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q2MuaXBZa5fxC0UqRbflHwrWp1IRLlId
X-Proofpoint-ORIG-GUID: Q2MuaXBZa5fxC0UqRbflHwrWp1IRLlId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on Qualcomm SoC, download_mode is enabled if
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected. Refactor
the code such that it supports multiple download modes and
drop the config.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/Kconfig    | 11 -----------
 drivers/firmware/qcom_scm.c | 45 +++++++++++++++++++++++++++++++++++++++------
 include/linux/qcom_scm.h    |  4 ++++
 3 files changed, 43 insertions(+), 17 deletions(-)

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
index c376ba8..4975d3c 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,8 +20,43 @@
 
 #include "qcom_scm.h"
 
-static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
-module_param(download_mode, bool, 0);
+static unsigned int download_mode;
+static struct qcom_scm *__scm;
+static void qcom_scm_set_download_mode(bool enable);
+static int set_dload_mode(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	int old_mode = download_mode;
+
+	ret = param_set_int(val, kp);
+	if (ret)
+		return ret;
+
+	switch (download_mode) {
+	case QCOM_DOWNLOAD_FULLDUMP:
+		if (__scm)
+			qcom_scm_set_download_mode(true);
+		break;
+	case QCOM_DOWNLOAD_NODUMP:
+		if (__scm)
+			qcom_scm_set_download_mode(false);
+		break;
+	default:
+		pr_err("unknown download mode\n");
+		download_mode = old_mode;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct kernel_param_ops dload_mode_param_ops = {
+	.set = set_dload_mode,
+	.get = param_get_hexint,
+};
+module_param_cb(download_mode, &dload_mode_param_ops, &download_mode, 0644);
+MODULE_PARM_DESC(download_mode,
+		 "Download mode: 0x0=no dump mode (default), 0x10=full dump mode");
 
 #define SCM_HAS_CORE_CLK	BIT(0)
 #define SCM_HAS_IFACE_CLK	BIT(1)
@@ -70,8 +105,6 @@ static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_LEGACY] = "smc legacy",
 };
 
-static struct qcom_scm *__scm;
-
 static int qcom_scm_clk_enable(void)
 {
 	int ret;
@@ -435,8 +468,8 @@ static void qcom_scm_set_download_mode(bool enable)
 		}
 
 		ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
-				dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
-				dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
+				((dload_addr_val & ~QCOM_DOWNLOAD_MODE_MASK) | download_mode) :
+				dload_addr_val & ~QCOM_DOWNLOAD_MODE_MASK);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f833564..dd6aced 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -14,6 +14,10 @@
 #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
 #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
 
+#define QCOM_DOWNLOAD_MODE_MASK 0x30
+#define QCOM_DOWNLOAD_NODUMP	0x0
+#define QCOM_DOWNLOAD_FULLDUMP	0x10
+
 struct qcom_scm_hdcp_req {
 	u32 addr;
 	u32 val;
-- 
2.7.4

