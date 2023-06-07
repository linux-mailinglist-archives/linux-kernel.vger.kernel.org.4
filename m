Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E9725EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbjFGMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbjFGMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:18:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE01FC1;
        Wed,  7 Jun 2023 05:18:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357BlIW9004954;
        Wed, 7 Jun 2023 12:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VHE8w+ShAqFQJicL/pWh6KAKyy97L6DwKhrLaJOzP84=;
 b=XD+IRKlDjwT7E5qWRTxji1l+l1TmoqUOV/IQxWzJsBXDosy89x10O/A1bvPKG0nOyNSM
 dTKdKQefc4Ck6U6hj/IkqzM22iv8ohptB5pnxnOGGKOE4OW/llTfwNl5EhJ93IwSCFes
 kykeHBU4znzWeWZSxk6fL6D+m1u6nOHVdYUcGjqI8L7Y+sJ/L11/9JmuyIfTmb8bVcOh
 ozetSsK2a25GXd38219+y2osqXtSm0m88SfmQMXRA5bUPvxJ+YnXlCPVm0qveAmmPa/j
 SifPVVA2Yeec92FDRJ7eY2ZYm4UzRpY6ZVmYd0hOfbQUPPbxbF+pP7vXp9x8Yjr2nI7k lA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a9t9rqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 12:18:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357CI5wY019704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 12:18:05 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 05:18:01 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH 2/2] rpmsg: glink: change intent work queue type
Date:   Wed, 7 Jun 2023 17:47:31 +0530
Message-ID: <20230607121731.26958-3-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0qrEEyXrMliSlsA-jatLlxTXYqgs9687
X-Proofpoint-GUID: 0qrEEyXrMliSlsA-jatLlxTXYqgs9687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

QDSP6 will clear heap memory once it's received
RX_DONE event from APPS. Under heavy cpu load
intent worker thread not able to get cpu slot
because it's bound to kernel global work queue.
Due to this QDSP6 firmware faces OOM and it leads
to Q6 crash. Changing intent work queue type to
UNBOUND workqueue ensures intent worker thread
will be executed as early as possible.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 6f9a439e5046..c3e076bb863f 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -140,6 +140,7 @@ enum {
  * @liids:	idr of all local intents
  * @riids:	idr of all remote intents
  * @intent_work: worker responsible for transmitting rx_done packets
+ * @intent_wq:	work queue of intent_work
  * @done_intents: list of intents that needs to be announced rx_done
  * @buf:	receive buffer, for gathering fragments
  * @buf_offset:	write offset in @buf
@@ -169,6 +170,7 @@ struct glink_channel {
 	struct idr liids;
 	struct idr riids;
 	struct work_struct intent_work;
+	struct workqueue_struct *intent_wq;
 	struct list_head done_intents;
 
 	struct glink_core_rx_intent *buf;
@@ -231,6 +233,14 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 	INIT_LIST_HEAD(&channel->done_intents);
 	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
 
+	channel->intent_wq = alloc_workqueue("intent_wq", WQ_UNBOUND, 1);
+	if (!channel->intent_wq) {
+		pr_err("failed to create %s channel intent work queue\n",
+		       channel->name);
+		kfree(channel);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	idr_init(&channel->liids);
 	idr_init(&channel->riids);
 	kref_init(&channel->refcount);
@@ -270,6 +280,7 @@ static void qcom_glink_channel_release(struct kref *ref)
 	idr_destroy(&channel->riids);
 	spin_unlock_irqrestore(&channel->intent_lock, flags);
 
+	destroy_workqueue(channel->intent_wq);
 	kfree(channel->name);
 	kfree(channel);
 }
@@ -573,7 +584,7 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
 	list_add_tail(&intent->node, &channel->done_intents);
 	spin_unlock(&channel->intent_lock);
 
-	schedule_work(&channel->intent_work);
+	queue_work(channel->intent_wq, &channel->intent_work);
 }
 
 /**
-- 
2.17.1

