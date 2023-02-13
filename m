Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC324694BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBMPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBMPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:52:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21691A665;
        Mon, 13 Feb 2023 07:52:26 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DERs62001670;
        Mon, 13 Feb 2023 15:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=np/Fh/isAkZqVk4IGvOaJu01AVx1Edn4bZ3eEoznThM=;
 b=CILJ3Plmnsa89OEgsZQZFaeSmgyAexUlueFuRDTvgXyznbSHgkZRa/Kt3C5qpMwJd2/4
 5nSanxtYk7Xkn1/HuQWvaUaExoB3nC55huTSfg/xpR655fJtnfulo40VVYrd9BKLkGBS
 B9vY6QXGRkq7h8+lIHhTU5fDIlsTwpsUacoqxQF06uZhMSUSKZSypu6i0kLzOGSS3KBY
 zdqYTZaoUD5PWvy1hI4hggpB8lSu5RKPr9U1anYCm6j5U3LIdOc4BKVDD1ItEM3GRg2S
 Z84sZrby2kpwkExbdiUoLG9oNMqQtcs6gEtFb+Dz5bagu2vcvzN8MZWFaOYKUhs6VbhE Ig== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0qpvgs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DFqM5V021292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 07:52:22 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] rpmsg: glink: Cancel pending intent requests at removal
Date:   Mon, 13 Feb 2023 07:52:15 -0800
Message-ID: <20230213155215.1237059-7-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
References: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8-3SoyprBJlUMxkUWbNgAHOG3qokxnBO
X-Proofpoint-ORIG-GUID: 8-3SoyprBJlUMxkUWbNgAHOG3qokxnBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_10,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=848
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- None

 drivers/rpmsg/qcom_glink_native.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 946128c343f3..324c75d59a6f 100644
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
2.25.1

