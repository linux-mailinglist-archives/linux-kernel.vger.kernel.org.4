Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC21663427
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbjAIWkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbjAIWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:40:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3013DD2;
        Mon,  9 Jan 2023 14:40:13 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309LaGkU011502;
        Mon, 9 Jan 2023 22:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Glrtv76v1bUv28bnY+eZovy/+aP3haJt+dyyflPqbj4=;
 b=lCtRi4+f1azhFm3NYPuzOdrU2NgHeyxLxNmrCkMKXR1+bFu67su1ys4jnraIzYRAKoxc
 TaVKCIIFgXsMchmLDC/pUDtTcJ9OLwNaZxHzEGAaMWzGX3MIjflFPrSJ3ys6q/mKkJUm
 fyfAEDKCgRWi2GJHuEykeaTbt4A0Vr9SXkmASEhf8OfiRvRAQGx+AfTSLnE/zXRmUC0m
 tUlXlbimTeHhYMWk+j/IzIbc5vm5ooswfSx3bfVuYXiX2oScT9nSEAobB+DjIajAxY/4
 9sO8b7A8NwK04TMxP1hSWvuCo4ea8f/GGvqNJ0bm/zue3sgeBECWYt1YjZsOW/UwQapm tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0u147fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:40:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309Me88L027303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:40:08 GMT
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
Subject: [PATCH 5/6] rpmsg: glink: Fail qcom_glink_tx() once remove has been initiated
Date:   Mon, 9 Jan 2023 14:40:00 -0800
Message-ID: <20230109224001.1706516-6-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: BFabGhtaB_nTNpYI2eFPRkM3WKEDJ2Rl
X-Proofpoint-ORIG-GUID: BFabGhtaB_nTNpYI2eFPRkM3WKEDJ2Rl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=808
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon removing the glink edge communication is at best one-way. This
means that the very common scenario of glink requesting intents will not
be possible to serve.

Typically a successful transmission results in the client waiting for a
response, with some timeout and a mechanism for aborting that timeout.

Because of this, once the glink edge is defunct once removal is
commenced it's better to fail transmissions fast.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index db5d946d5901..d81d0729493e 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -90,6 +90,7 @@ struct glink_core_rx_intent {
  * @intentless:	flag to indicate that there is no intent
  * @tx_avail_notify: Waitqueue for pending tx tasks
  * @sent_read_notify: flag to check cmd sent or not
+ * @abort_tx:	flag indicating that all tx attempts should fail
  */
 struct qcom_glink {
 	struct device *dev;
@@ -111,6 +112,8 @@ struct qcom_glink {
 	bool intentless;
 	wait_queue_head_t tx_avail_notify;
 	bool sent_read_notify;
+
+	bool abort_tx;
 };
 
 enum {
@@ -326,12 +329,22 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 
 	spin_lock_irqsave(&glink->tx_lock, flags);
 
+	if (glink->abort_tx) {
+		ret = -EIO;
+		goto out;
+	}
+
 	while (qcom_glink_tx_avail(glink) < tlen) {
 		if (!wait) {
 			ret = -EAGAIN;
 			goto out;
 		}
 
+		if (glink->abort_tx) {
+			ret = -EIO;
+			goto out;
+		}
+
 		if (!glink->sent_read_notify) {
 			glink->sent_read_notify = true;
 			qcom_glink_send_read_notify(glink);
@@ -1763,11 +1776,18 @@ static int qcom_glink_remove_device(struct device *dev, void *data)
 void qcom_glink_native_remove(struct qcom_glink *glink)
 {
 	struct glink_channel *channel;
+	unsigned long flags;
 	int cid;
 	int ret;
 
 	qcom_glink_cancel_rx_work(glink);
 
+	/* Fail all attempts at sending messages */
+	spin_lock_irqsave(&glink->tx_lock, flags);
+	glink->abort_tx = true;
+	wake_up_all(&glink->tx_avail_notify);
+	spin_unlock_irqrestore(&glink->tx_lock, flags);
+
 	ret = device_for_each_child(glink->dev, NULL, qcom_glink_remove_device);
 	if (ret)
 		dev_warn(glink->dev, "Can't remove GLINK devices: %d\n", ret);
-- 
2.37.3

