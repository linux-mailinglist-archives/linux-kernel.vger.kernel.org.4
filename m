Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75E663418
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbjAIWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbjAIWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:40:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5F13FA6;
        Mon,  9 Jan 2023 14:40:14 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309Maet2015718;
        Mon, 9 Jan 2023 22:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BY0U/IfBBmjexzqkP5sEll4FvdKK3LgbuOw30SuZ9hE=;
 b=NZ9Qk5arFonnNXYATWjh6w5EirdQuiGHRPsCDeALkQiG2iOZ8i6s7QvlBtiphZbGbgOQ
 9Aex3DpPfXHArYf7ZyV8wdFfCz/2prOi/CzcOHG3sW9uMxdEXmlZoDuQ6WnbFbMCKdeo
 8MN8TWJQzFwpW81HrlSJDHVpxYjlI7aKpSCuq2MLlBW9gHP/BxCNEbWiainB6n8J0n/I
 3diP69QomN7KxkUFHscheswdTx9eDLotIdL3F/nw/tWAvSSE+ammzDAqmJ7zZ74rMxKS
 mzmmNX2YZMSKdiEO0QKlFors35GURIEBEH2vxMtyVDT21TGZJt4a+yVRLJuNJn72qseO nQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my1wu452d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:40:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309MeBbH003685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:40:11 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:40:08 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] rpmsg: glink: Cancel pending intent requests at removal
Date:   Mon, 9 Jan 2023 14:40:01 -0800
Message-ID: <20230109224001.1706516-7-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OMw4aFvjcilatTXB6ds_brK0IJd9sMuF
X-Proofpoint-GUID: OMw4aFvjcilatTXB6ds_brK0IJd9sMuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=749
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During removal of the glink edge interrupts are disabled and no more
incoming messages are being serviced. In addition to the remote endpoint
being defunct that means that any outstanding requests for intents will
not be serviced, and qcom_glink_request_intent() will blindly wait for
up to 10 seconds.

Mark the intent request as not granted and complete the intent request
completion to fail the waiting client immediately.

Once the current intent request is failed, any potential clients waiting
for the intent request mutex will not enter the same wait, as the
qcom_glink_tx() call will fail fast.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index d81d0729493e..bb14e7edeadc 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -423,6 +423,12 @@ static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
 	complete(&channel->intent_req_comp);
 }
 
+static void qcom_glink_intent_req_abort(struct glink_channel *channel)
+{
+	channel->intent_req_result = 0;
+	complete(&channel->intent_req_comp);
+}
+
 /**
  * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
  * @glink: Ptr to the glink edge
@@ -1788,6 +1794,12 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
 	wake_up_all(&glink->tx_avail_notify);
 	spin_unlock_irqrestore(&glink->tx_lock, flags);
 
+	/* Abort any senders waiting for intent requests */
+	spin_lock_irqsave(&glink->idr_lock, flags);
+	idr_for_each_entry(&glink->lcids, channel, cid)
+		qcom_glink_intent_req_abort(channel);
+	spin_unlock_irqrestore(&glink->idr_lock, flags);
+
 	ret = device_for_each_child(glink->dev, NULL, qcom_glink_remove_device);
 	if (ret)
 		dev_warn(glink->dev, "Can't remove GLINK devices: %d\n", ret);
-- 
2.37.3

