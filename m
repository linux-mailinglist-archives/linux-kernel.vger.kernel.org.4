Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A46CA81C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjC0Oqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjC0Oqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:46:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408FC3A80;
        Mon, 27 Mar 2023 07:46:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RDOXPV026255;
        Mon, 27 Mar 2023 14:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Z1bJzc4D3JMag2G7V3DvVM/nIOKutYm2LEJBhLjaYCY=;
 b=NuWwLpk+in65weluGtttia+D9R6xbLIywoW6X6xPvtMTlP7NXReSGxozncba1KRNyi++
 O55GnNTnIRz417vb9ArufHKb1Shkvp4NhcLUfuT7OhO20T8+Eb/X1X8zDk902WbzvqJ8
 vSYj2T0/n5EA7Ds9NlQ/TlNaSF0uoib4PBmwLdcUIr606HqIcUPrVMm6ZioJyL7purQ7
 5T5/wUvNHSxsOs5ejWTEK7Ey0FVjeaf5s1Wgf/uo2ifhga1YqqZ93dwxoxg3jqjonTcO
 W782pjLpsR22KHhjcC2O3u3J216ERRv+JG/TtdAGiAoFQUg0nIfIPtYhDUQRKjj3c56j cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsqqmnx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 14:46:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32REkN14004819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 14:46:23 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 07:46:23 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] rpmsg: glink: Transition intent request signaling to wait queue
Date:   Mon, 27 Mar 2023 07:46:16 -0700
Message-ID: <20230327144617.3134175-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327144617.3134175-1-quic_bjorande@quicinc.com>
References: <20230327144617.3134175-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 10OTkJSbsFrSjB0zTGn7Lz_iT1aGNcxE
X-Proofpoint-ORIG-GUID: 10OTkJSbsFrSjB0zTGn7Lz_iT1aGNcxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270116
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transition the intent request acknowledgement to use a wait queue so
that it's possible, in the next commit, to extend the wait to also wait
for an incoming intent.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 082cf7f4888e..e3494de7dce8 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -16,6 +16,7 @@
 #include <linux/rpmsg.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/mailbox_client.h>
 
@@ -145,7 +146,7 @@ enum {
  * @open_req:	completed once open-request has been received
  * @intent_req_lock: Synchronises multiple intent requests
  * @intent_req_result: Result of intent request
- * @intent_req_comp: Completion for intent_req signalling
+ * @intent_req_wq: wait queue for intent_req signalling
  */
 struct glink_channel {
 	struct rpmsg_endpoint ept;
@@ -175,8 +176,8 @@ struct glink_channel {
 	struct completion open_req;
 
 	struct mutex intent_req_lock;
-	bool intent_req_result;
-	struct completion intent_req_comp;
+	int intent_req_result;
+	wait_queue_head_t intent_req_wq;
 };
 
 #define to_glink_channel(_ept) container_of(_ept, struct glink_channel, ept)
@@ -221,7 +222,7 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 
 	init_completion(&channel->open_req);
 	init_completion(&channel->open_ack);
-	init_completion(&channel->intent_req_comp);
+	init_waitqueue_head(&channel->intent_req_wq);
 
 	INIT_LIST_HEAD(&channel->done_intents);
 	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
@@ -420,13 +421,13 @@ static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
 	}
 
 	channel->intent_req_result = granted;
-	complete(&channel->intent_req_comp);
+	wake_up_all(&channel->intent_req_wq);
 }
 
 static void qcom_glink_intent_req_abort(struct glink_channel *channel)
 {
 	channel->intent_req_result = 0;
-	complete(&channel->intent_req_comp);
+	wake_up_all(&channel->intent_req_wq);
 }
 
 /**
@@ -1271,7 +1272,7 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
 
 	mutex_lock(&channel->intent_req_lock);
 
-	reinit_completion(&channel->intent_req_comp);
+	WRITE_ONCE(channel->intent_req_result, -1);
 
 	cmd.id = GLINK_CMD_RX_INTENT_REQ;
 	cmd.cid = channel->lcid;
@@ -1281,12 +1282,14 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
 	if (ret)
 		goto unlock;
 
-	ret = wait_for_completion_timeout(&channel->intent_req_comp, 10 * HZ);
+	ret = wait_event_timeout(channel->intent_req_wq,
+				 READ_ONCE(channel->intent_req_result) >= 0,
+				 10 * HZ);
 	if (!ret) {
 		dev_err(glink->dev, "intent request timed out\n");
 		ret = -ETIMEDOUT;
 	} else {
-		ret = channel->intent_req_result ? 0 : -ECANCELED;
+		ret = READ_ONCE(channel->intent_req_result) ? 0 : -ECANCELED;
 	}
 
 unlock:
-- 
2.25.1

