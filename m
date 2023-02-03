Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F75689735
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjBCKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:46:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984A4FCFC;
        Fri,  3 Feb 2023 02:46:18 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31399Crh004649;
        Fri, 3 Feb 2023 10:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OgCD+eDmUwSr0tq+6IKW/wdRsh3zCLJKVgwLN+2BJ8Q=;
 b=pObvpSZ5Ml6vPRXfko2W1AGqSFXAPa3xSqsY85rX1kogXeLHIa9Lpu2fQtF/tBJenlye
 S+sq0QYpm8sXSHXH0RRqdPvdULH9cPbNEETQ/1iJ09seNP4y+SpIjJZ6TJGldSEu65Dn
 539ttG+fblpcWCMeDiWm+AnRqqjIs9pynxvyWoj6vPIxOzI+vMGfe7VeWgbtf+NxNTs7
 YTm1R60pNR+fm8HlZ1IGU585RQKv77c+ep+SuY8cgunOdI+E/BoWzmaBMzEmbXm76ubs
 L2UTp3dsnWYQUS48wrFfjoPd7ySEE+38sENp+Kpsub+8vQdi8/PT6yJYOk4lgXtEp/zB 2A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns2h7t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 10:19:02 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313AJ2n6015179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 10:19:02 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 3 Feb 2023 02:18:59 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2] firmware: qcom_scm: modify qcom_scm_set_download_mode()
Date:   Fri, 3 Feb 2023 15:47:15 +0530
Message-ID: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nnpK-Hl9mq6EX3d5Zhjq5PMxtybwU71k
X-Proofpoint-ORIG-GUID: nnpK-Hl9mq6EX3d5Zhjq5PMxtybwU71k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_06,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
Changes in v2:
  - Stop changing legacy scm id for dload mode.

 drivers/firmware/qcom_scm.c | 15 +++++++--------
 include/linux/qcom_scm.h    |  5 +++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54..6245b97 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -400,7 +400,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
-static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
+static int __qcom_scm_set_dload_mode(struct device *dev, enum qcom_download_mode mode)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_BOOT,
@@ -410,12 +410,12 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
+	desc.args[1] = mode ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
 
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

