Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDAD5BD1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiISQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiISQCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:02:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AD3CBF2;
        Mon, 19 Sep 2022 09:01:09 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JEe8QN010929;
        Mon, 19 Sep 2022 16:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uIUmkWWChmCj4RYxmInTFl1FXN/vdFc07v8DqwHSnI4=;
 b=j5r2GywuDTxVGe1u7XNqhZOo/CWbS6zA3C87dFEEyGP7QeRO0wP6js/AL/JOilWqK+bo
 3tmqEfYl0eMIVayLGzQTHWoYlhXNj72gOo3eyiRdQGJZ/h9hR4aKxdbtVpXJrENwSTCD
 NBa7mLz9OC99LBs3/CU6RQDEqCtvptWJP7dM1vxYumqURqmYYG0PnjenQhDnGrH9GZeI
 TkTm9NMVXbnWkctocd8RVpRNkc3+gzOsPtWSkJYL3KCDCfLCXEy+3ZlCeFmpfgULZNjz
 9ftuwKpOMxcQep3fQI52jDAuBsPzMl6M77AJyfdfvZT4mwmN9I4szaGkhznDcH3Pwksf gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6qkvud1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:00:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JG0q1X013146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:00:52 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 09:00:52 -0700
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
Subject: [PATCH v1 2/3] remoteproc: qcom: q6v5: Do not report crash if SSR is disabled
Date:   Mon, 19 Sep 2022 09:00:39 -0700
Message-ID: <1a548f4e7373c12159f8d866dc0e12d224460036.1662995608.git.quic_gokukris@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HGA1xbbZ1u1PYxzws-ESBRPuTNw9xOwx
X-Proofpoint-GUID: HGA1xbbZ1u1PYxzws-ESBRPuTNw9xOwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=915 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case recovery is disabled, do not report the rproc crash
to the framework. If recovery is enabled after we start the
crash handler we may end up in a weird state by informing
clients of a crash twice, resulting in undefined behaviour.

Change-Id: If0d9bf5aa2c6f9e25adcefaca14b2de60fcb1a7a
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 89f5384..1b9e1e1 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -103,6 +103,8 @@ static void qcom_q6v5_crash_handler_work(struct work_struct *work)
 
 	mutex_lock(&rproc->lock);
 
+	rproc->state = RPROC_CRASHED;
+
 	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
 		if (subdev->stop)
 			subdev->stop(subdev, true);
@@ -139,8 +141,8 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 	q6v5->running = false;
 	if (q6v5->rproc->recovery_disabled)
 		schedule_work(&q6v5->crash_handler);
-
-	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
+	else
+		rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
 
 	return IRQ_HANDLED;
 }
@@ -163,8 +165,8 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 	q6v5->running = false;
 	if (q6v5->rproc->recovery_disabled)
 		schedule_work(&q6v5->crash_handler);
-
-	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
+	else
+		rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

