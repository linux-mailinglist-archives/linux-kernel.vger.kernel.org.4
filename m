Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1717725EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbjFGMSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbjFGMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:18:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E26E65;
        Wed,  7 Jun 2023 05:18:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357B0LMb006329;
        Wed, 7 Jun 2023 12:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ilmTk6Qn4laTQ5e/YbI/igcb8obrPaVeYG5KEfh+b7U=;
 b=OlmAecR9gDPNxcZvFH8iDv/2mhFbuBp7FsjX5nYyrdXX2rILKH/TP9gg4dB9bnQ9pfpA
 BYvI1FWZmfJcuVQ9atrH+TYbzYAuaeQGoCACGGiwOeAEs+J41cNc2z9IlaInRccqobIm
 Xh03Y9EF1JMMJMgrHiBAHqDOencarFfym5EVwBeIwi1sXVDZpDC+51sT07QJOI0e44Hl
 +X1QkBV4RfKFsEFJjKsG3pKIAvpV9WGW6H6S/QwwYvy/k71e9omwJozjxpTQ6J6/iBs2
 /3sYH5PNoxzckwP0IuOmLoHqpmTlb5HrP+iPkDKhtCHIhu5+KKpT3LdHJcbzWmo7oaCI 7w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a9thr32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 12:18:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357CI0GO006993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 12:18:00 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 05:17:56 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH 1/2] rpmsg: glink: change rx work queue type
Date:   Wed, 7 Jun 2023 17:47:30 +0530
Message-ID: <20230607121731.26958-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
References: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mpJym5lT85MU-tRfY1XOmWapXmxG-Byq
X-Proofpoint-ORIG-GUID: mpJym5lT85MU-tRfY1XOmWapXmxG-Byq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of heavy cpu load, rx worker thread
not able to get cpu slot because it's bound
to kernel global work queue.

Glink client drivers will return timeout
error if they didn't receive response
within stipulated duration. Changing rx
work queue type to UNBOUND workqueue
ensures rx worker thread will be executed
as early as possible.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 1beb40a1d3df..6f9a439e5046 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -81,6 +81,7 @@ struct glink_core_rx_intent {
  * @rx_pipe:	pipe object for receive FIFO
  * @tx_pipe:	pipe object for transmit FIFO
  * @rx_work:	worker for handling received control messages
+ * @rx_wq:	work queue of rx_work
  * @rx_lock:	protects the @rx_queue
  * @rx_queue:	queue of received control messages to be processed in @rx_work
  * @tx_lock:	synchronizes operations on the tx fifo
@@ -100,6 +101,7 @@ struct qcom_glink {
 	struct qcom_glink_pipe *tx_pipe;
 
 	struct work_struct rx_work;
+	struct workqueue_struct *rx_wq;
 	spinlock_t rx_lock;
 	struct list_head rx_queue;
 
@@ -822,7 +824,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 	list_add_tail(&dcmd->node, &glink->rx_queue);
 	spin_unlock(&glink->rx_lock);
 
-	schedule_work(&glink->rx_work);
+	queue_work(glink->rx_wq, &glink->rx_work);
 	qcom_glink_rx_advance(glink, sizeof(dcmd->msg) + extra);
 
 	return 0;
@@ -1665,6 +1667,8 @@ static void qcom_glink_cancel_rx_work(struct qcom_glink *glink)
 	/* cancel any pending deferred rx_work */
 	cancel_work_sync(&glink->rx_work);
 
+	destroy_workqueue(glink->rx_wq);
+
 	list_for_each_entry_safe(dcmd, tmp, &glink->rx_queue, node)
 		kfree(dcmd);
 }
@@ -1750,6 +1754,10 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	INIT_WORK(&glink->rx_work, qcom_glink_work);
 	init_waitqueue_head(&glink->tx_avail_notify);
 
+	glink->rx_wq = alloc_workqueue("glink_rx_wq", WQ_UNBOUND, 1);
+	if (!glink->rx_wq)
+		return ERR_PTR(-ENOMEM);
+
 	spin_lock_init(&glink->idr_lock);
 	idr_init(&glink->lcids);
 	idr_init(&glink->rcids);
-- 
2.17.1

