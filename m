Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276C6CA818
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC0Oqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjC0Oqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:46:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5104035AA;
        Mon, 27 Mar 2023 07:46:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RD0ILr006606;
        Mon, 27 Mar 2023 14:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Vkj+E/rQa+jSFrNsC1JhMXlaXuA4XMqJZFoCbosbPB4=;
 b=GhOEwdnCClJPZxpzxGygpDCM3TDmtdvmLdRyurWOEuPU0slM5RrDcHXQYawExqC7qSLj
 rjnMz5Mz0AyW/PWdocd9iLNAyR/j4ePekxLg8zsBOxswLgd83QkH/pmNhQetYRGqfwhE
 4XOoCVGWw6HYWK6e/EhmyiAUKZWlP9XG6RufbTWOGzUWU7upPiCOa2RPBCrFM0wyevND
 1eyJWwKEC9qoAcxGd8CcZGuT9WHQD8ydbkc44E511kAvraF429++j2BUAaDOrlhFelPU
 O803vg2mgLRB6Yzs+qxewOBQaO7iMCnmteASwYfvagjCrlN2NdXVxMqO1ppCC7IKQ2PB og== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkbmyr80r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 14:46:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32REkNep031496
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
Subject: [PATCH 2/2] rpmsg: glink: Wait for intent, not just request ack
Date:   Mon, 27 Mar 2023 07:46:17 -0700
Message-ID: <20230327144617.3134175-3-quic_bjorande@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZOzYgBpIjOH3qPsHxAvZJVdyTp2OAb6B
X-Proofpoint-GUID: ZOzYgBpIjOH3qPsHxAvZJVdyTp2OAb6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270117
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some implementations of the remote firmware, an intent request
acknowledgement is sent when it's determined if the intent allocation
will be fulfilled, but then the intent is queued after the
acknowledgement.

The result is that upon receving a granted allocation request, the
search for the newly allocated intent will fail and an additional
request will be made. This will at best waste memory, but if the second
request is rejected the transaction will be incorrectly rejected.

Take the incoming intent into account in the wait to mitigate this
problem.

The above scenario can still happen, in the case that, on that same
channel, an unrelated intent is delivered prior to the request
acknowledgement and a separate process enters the send path and picks up
the intent. Given that there's no relationship between the
acknowledgement and the delivered (or to be delivered intent), there
doesn't seem to be a solution to this problem.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index e3494de7dce8..3055e0a473e8 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -146,6 +146,7 @@ enum {
  * @open_req:	completed once open-request has been received
  * @intent_req_lock: Synchronises multiple intent requests
  * @intent_req_result: Result of intent request
+ * @intent_received: flag indicating that an intent has been received
  * @intent_req_wq: wait queue for intent_req signalling
  */
 struct glink_channel {
@@ -177,6 +178,7 @@ struct glink_channel {
 
 	struct mutex intent_req_lock;
 	int intent_req_result;
+	bool intent_received;
 	wait_queue_head_t intent_req_wq;
 };
 
@@ -420,13 +422,13 @@ static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
 		return;
 	}
 
-	channel->intent_req_result = granted;
+	WRITE_ONCE(channel->intent_req_result, granted);
 	wake_up_all(&channel->intent_req_wq);
 }
 
 static void qcom_glink_intent_req_abort(struct glink_channel *channel)
 {
-	channel->intent_req_result = 0;
+	WRITE_ONCE(channel->intent_req_result, 0);
 	wake_up_all(&channel->intent_req_wq);
 }
 
@@ -757,6 +759,11 @@ static void qcom_glink_handle_rx_done(struct qcom_glink *glink,
 		kfree(intent);
 	}
 	spin_unlock_irqrestore(&channel->intent_lock, flags);
+
+	if (reuse) {
+		WRITE_ONCE(channel->intent_received, true);
+		wake_up_all(&channel->intent_req_wq);
+	}
 }
 
 /**
@@ -994,6 +1001,9 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
 			dev_err(glink->dev, "failed to store remote intent\n");
 	}
 
+	WRITE_ONCE(channel->intent_received, true);
+	wake_up_all(&channel->intent_req_wq);
+
 	kfree(msg);
 	qcom_glink_rx_advance(glink, ALIGN(msglen, 8));
 }
@@ -1273,6 +1283,7 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
 	mutex_lock(&channel->intent_req_lock);
 
 	WRITE_ONCE(channel->intent_req_result, -1);
+	WRITE_ONCE(channel->intent_received, false);
 
 	cmd.id = GLINK_CMD_RX_INTENT_REQ;
 	cmd.cid = channel->lcid;
@@ -1283,7 +1294,8 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
 		goto unlock;
 
 	ret = wait_event_timeout(channel->intent_req_wq,
-				 READ_ONCE(channel->intent_req_result) >= 0,
+				 READ_ONCE(channel->intent_req_result) >= 0 &&
+				 READ_ONCE(channel->intent_received),
 				 10 * HZ);
 	if (!ret) {
 		dev_err(glink->dev, "intent request timed out\n");
-- 
2.25.1

