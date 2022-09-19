Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC05BD1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiISQDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiISQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:02:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB63C8E1;
        Mon, 19 Sep 2022 09:00:56 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDBTj9025635;
        Mon, 19 Sep 2022 16:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ij81E1OQlgZvSM3xquEVml12KCb9/5N2KS1Kns1QJh4=;
 b=QQTycDRpUQGkJC2MG7+dufSJkAUUfAHxXkCo/VnTXRcM52fFWAC2m38z8C5ZhzhlDb80
 7wKd5SxZ/YqqUX0hQ3A+cC/iYHWkmuBPKSSVr1LfHEOCKftHd7ArU1E/HXEsw3QPpQI0
 x58FlqkHgvI2WXaZs5BG6nX2CFXlV6lDqNhBLjSMF7TdAx1ohv+JUF81aK95KoTXrz2s
 ryXTgZfrpQFiVSeFxkInARGdo9r41cWz9f+yHw3d9LCcaLjHtKILTpSVZ+6vwWx6Q+N7
 8qF9WBhpSMu7c5LkzNuWH6TAKo1DCLOm/01Ksj/BCry2rGPaY2mSijpcqFCNFf/K18JI aA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn7dsd5ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:00:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JG0oil023813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:00:50 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 09:00:50 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v1 1/3] remoteproc: qcom: q6v5: Send subdevice notifications before panic
Date:   Mon, 19 Sep 2022 09:00:38 -0700
Message-ID: <842a6b6307d26874959d29f2065aad544ff0b86c.1662995608.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1662995608.git.quic_gokukris@quicinc.com>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 08IetkVuAK_U1fBnlTzCOGE1fyxrxxy4
X-Proofpoint-GUID: 08IetkVuAK_U1fBnlTzCOGE1fyxrxxy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subdevice notifications after a remoteproc has crashed are useful to any
clients that might want to preserve data pertaining to the driver after the
remoteproc crashed. Sending subdevice notifications before triggering a
kernel panic gives these drivers the time to do collect this information.

Change-Id: Id6e55fb038b70f54ff5854d2adff72b74b6a9570
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5.c | 31 +++++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 497acfb..89f5384 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -15,6 +15,7 @@
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/remoteproc.h>
+#include <linux/delay.h>
 #include "qcom_common.h"
 #include "qcom_q6v5.h"
 
@@ -94,6 +95,29 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
 
+static void qcom_q6v5_crash_handler_work(struct work_struct *work)
+{
+	struct qcom_q6v5 *q6v5 = container_of(work, struct qcom_q6v5, crash_handler);
+	struct rproc *rproc = q6v5->rproc;
+	struct rproc_subdev *subdev;
+
+	mutex_lock(&rproc->lock);
+
+	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->stop)
+			subdev->stop(subdev, true);
+	}
+
+	mutex_unlock(&rproc->lock);
+
+	/*
+	 * Temporary workaround until ramdump userspace application calls
+	 * sync() and fclose() on attempting the dump.
+	 */
+	msleep(100);
+	panic("Panicking, remoteproc %s crashed\n", q6v5->rproc->name);
+}
+
 static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 {
 	struct qcom_q6v5 *q6v5 = data;
@@ -113,6 +137,9 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 		dev_err(q6v5->dev, "watchdog without message\n");
 
 	q6v5->running = false;
+	if (q6v5->rproc->recovery_disabled)
+		schedule_work(&q6v5->crash_handler);
+
 	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
 
 	return IRQ_HANDLED;
@@ -134,6 +161,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 		dev_err(q6v5->dev, "fatal error without message\n");
 
 	q6v5->running = false;
+	if (q6v5->rproc->recovery_disabled)
+		schedule_work(&q6v5->crash_handler);
+
 	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
 
 	return IRQ_HANDLED;
@@ -354,6 +384,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	if (IS_ERR(q6v5->path))
 		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
 				     "failed to acquire interconnect path\n");
+	INIT_WORK(&q6v5->crash_handler, qcom_q6v5_crash_handler_work);
 
 	return 0;
 }
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 5a859c4..b1654be 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -29,6 +29,8 @@ struct qcom_q6v5 {
 	int handover_irq;
 	int stop_irq;
 
+	struct work_struct crash_handler;
+
 	bool handover_issued;
 
 	struct completion start_done;
-- 
2.7.4

