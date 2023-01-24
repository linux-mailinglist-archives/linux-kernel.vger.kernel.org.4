Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D16797A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjAXMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjAXMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:19:31 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6637F02;
        Tue, 24 Jan 2023 04:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674562770; x=1706098770;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=crltBwfloSo7xnyTSz7Z0uQPe7RMWKQQnz7Q2pXv6UI=;
  b=cJeSFbOzYz3p+neORcnu8Kud5i7n7aw8qnorST6OEQP5jTqO4KhItDaa
   toNY2PKkcMQnSdzRYcwy+k121kWZ7T1Hap99KuLp/2iNowMchkNoJ1k1m
   /DR4CIzgmEYNDuwPRcku/Rpl0hlzBh+EyFqyZrdp5xGY3WXWcSHBrFql0
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jan 2023 04:19:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 04:19:29 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 04:19:27 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH] firmware: qcom_scm: modify qcom_scm_set_download_mode()
Date:   Tue, 24 Jan 2023 17:49:15 +0530
Message-ID: <1674562755-5378-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify qcom_scm_set_download_mode() such that it can support
multiple modes. There is no functional change with this change.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 17 ++++++++---------
 include/linux/qcom_scm.h    |  5 +++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54..712bb03 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -400,22 +400,22 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
-static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
+static int __qcom_scm_set_dload_mode(struct device *dev, enum qcom_download_mode mode)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_BOOT,
 		.cmd = QCOM_SCM_BOOT_SET_DLOAD_MODE,
 		.arginfo = QCOM_SCM_ARGS(2),
-		.args[0] = QCOM_SCM_BOOT_SET_DLOAD_MODE,
+		.args[0] = mode,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
+	desc.args[1] = mode;
 
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 
-static void qcom_scm_set_download_mode(bool enable)
+static void qcom_scm_set_download_mode(enum qcom_download_mode mode)
 {
 	bool avail;
 	int ret = 0;
@@ -424,10 +424,9 @@ static void qcom_scm_set_download_mode(bool enable)
 					     QCOM_SCM_SVC_BOOT,
 					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
 	if (avail) {
-		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
+		ret = __qcom_scm_set_dload_mode(__scm->dev, mode);
 	} else if (__scm->dload_mode_addr) {
-		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+		ret = qcom_scm_io_writel(__scm->dload_mode_addr, mode);
 	} else {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
@@ -1410,7 +1409,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	 * disabled below by a clean shutdown/reboot.
 	 */
 	if (download_mode)
-		qcom_scm_set_download_mode(true);
+		qcom_scm_set_download_mode(QCOM_DOWNLOAD_FULLDUMP);
 
 	return 0;
 }
@@ -1419,7 +1418,7 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
 	if (download_mode)
-		qcom_scm_set_download_mode(false);
+		qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f833564..f9bc84e 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -14,6 +14,11 @@
 #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
 #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
 
+enum qcom_download_mode {
+	QCOM_DOWNLOAD_NODUMP    = 0x00,
+	QCOM_DOWNLOAD_FULLDUMP  = 0x10,
+};
+
 struct qcom_scm_hdcp_req {
 	u32 addr;
 	u32 val;
-- 
2.7.4

