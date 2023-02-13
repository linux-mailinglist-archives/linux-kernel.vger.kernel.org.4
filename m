Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CC694BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBMPwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjBMPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:52:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989C91C301;
        Mon, 13 Feb 2023 07:52:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DBShpb012809;
        Mon, 13 Feb 2023 15:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VcqFULgVhVbKYIwb9/gECQ7n6Hj5FbUbs9YRybQAdXY=;
 b=mU0jjs/JXg2Iv9EHeC/wvfN/2FBZABUB4gpFq+M66zJh9uTAqu2v2XcoUCIYykc1dIzY
 GCYanenxlbbGvErVUIhXDlcGiFbIOL7v8Dxqz318Kujh/UxmNKuskXUsnVSKzSJDJt4V
 xF0dMHqYiYYO8h1PzcrQLjS8g9cIqW5hXTGo3Xa/wuFa004EQt+b3WwowhN5odufCeYD
 Hqf50hcy3aYe0iQJ+D2TSHkGGEHWytX7srnMlWBCD9mD6k5u4I+j6hvqVUgg5IqoVPvB
 wEA9qSkuNt6q6zmUp+J4KtVaKorHaRXvtcpcQB8p1gFOTm9pbxKVmRKu5eJFpX2cCeSE Sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np389vb6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DFqM6Q026003
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
Subject: [PATCH v2 5/6] rpmsg: glink: Fail qcom_glink_tx() once remove has been initiated
Date:   Mon, 13 Feb 2023 07:52:14 -0800
Message-ID: <20230213155215.1237059-6-quic_bjorande@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lJcsnstAYr6Cq-tr40_Y9vaykdnXWeUj
X-Proofpoint-GUID: lJcsnstAYr6Cq-tr40_Y9vaykdnXWeUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_10,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=903 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon removing the glink edge, communication is at best one-way. This
means that the very common scenario of glink requesting intents will not
be possible to serve.

Typically a successful transmission results in the client waiting for a
response, with some timeout and a mechanism for aborting that timeout.

Because of this, once the glink edge is defunct once removal is
commenced it's better to fail transmissions fast.

Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Added ',' after "edge" in commit message.

 drivers/rpmsg/qcom_glink_native.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 8dd8cf033b2d..946128c343f3 100644
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
2.25.1

