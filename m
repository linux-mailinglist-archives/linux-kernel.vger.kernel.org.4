Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74E76C70E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjCWTQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjCWTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:16:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42E9EEA;
        Thu, 23 Mar 2023 12:16:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NJFHFs002308;
        Thu, 23 Mar 2023 19:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Z651w3Zr09wKIQBW4iFS4x7U8CUJKlv+nPJ1dwbKYMA=;
 b=EYgFbn7+9ceF/F6+D7Qsbz3ORFndurxbOSE4uhenGSx+Y/J++5c7iWi2l2Hl6vXNZALC
 D+Yn6yq31yP339Aa4Q6nxK/Lshw4FsefAzCab189oBcyuKrVz1Hnq3C2Tyjmp3ajvBb0
 juA6RKuhgYM3HCPjnufLuiQ6827rH8t/r3CqOr5FnXNxbla+LPWv4MjTwZdJVI3KYqjU
 j03AOtoHSbLs7DwSSgm1kLVpnx7A8FFcEqJfGIPByRSTxFtFGbW5kQknPHYtLIMqpFIu
 M2CZ5hIKN60AVevDVQCLl6v8siYrxZxNa/T+ktGiNw9ws+gJLjCJGSIPnUR8IrcPHeaA yA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgfv6a42h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 19:16:07 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NJG6sV019372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 19:16:06 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 12:16:06 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 1/3] mailbox: Allow direct registration to a channel
Date:   Thu, 23 Mar 2023 12:15:25 -0700
Message-ID: <20230323191527.1472695-2-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323191527.1472695-1-quic_eberman@quicinc.com>
References: <20230323191527.1472695-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jMBalDA7of7syKMZqJw2ti_Cdso3AFJJ
X-Proofpoint-ORIG-GUID: jMBalDA7of7syKMZqJw2ti_Cdso3AFJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_12,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=980 malwarescore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230141
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support virtual mailbox controllers and clients which are not platform
devices or come from the devicetree by allowing them to match client to
channel via some other mechanism.

Tested-by: Sudeep Holla <sudeep.holla@arm.com> (pcc)
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
 include/linux/mailbox_client.h |  1 +
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..adf36c05fa43 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -317,6 +317,71 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 }
 EXPORT_SYMBOL_GPL(mbox_flush);
 
+static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
+{
+	struct device *dev = cl->dev;
+	unsigned long flags;
+	int ret;
+
+	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
+		dev_dbg(dev, "%s: mailbox not free\n", __func__);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->msg_free = 0;
+	chan->msg_count = 0;
+	chan->active_req = NULL;
+	chan->cl = cl;
+	init_completion(&chan->tx_complete);
+
+	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
+		chan->txdone_method = TXDONE_BY_ACK;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	if (chan->mbox->ops->startup) {
+		ret = chan->mbox->ops->startup(chan);
+
+		if (ret) {
+			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
+			mbox_free_channel(chan);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * mbox_bind_client - Request a mailbox channel.
+ * @chan: The mailbox channel to bind the client to.
+ * @cl: Identity of the client requesting the channel.
+ *
+ * The Client specifies its requirements and capabilities while asking for
+ * a mailbox channel. It can't be called from atomic context.
+ * The channel is exclusively allocated and can't be used by another
+ * client before the owner calls mbox_free_channel.
+ * After assignment, any packet received on this channel will be
+ * handed over to the client via the 'rx_callback'.
+ * The framework holds reference to the client, so the mbox_client
+ * structure shouldn't be modified until the mbox_free_channel returns.
+ *
+ * Return: 0 if the channel was assigned to the client successfully.
+ *         <0 for request failure.
+ */
+int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
+{
+	int ret;
+
+	mutex_lock(&con_mutex);
+	ret = __mbox_bind_client(chan, cl);
+	mutex_unlock(&con_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mbox_bind_client);
+
 /**
  * mbox_request_channel - Request a mailbox channel.
  * @cl: Identity of the client requesting the channel.
@@ -340,7 +405,6 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	struct mbox_controller *mbox;
 	struct of_phandle_args spec;
 	struct mbox_chan *chan;
-	unsigned long flags;
 	int ret;
 
 	if (!dev || !dev->of_node) {
@@ -372,33 +436,9 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 		return chan;
 	}
 
-	if (chan->cl || !try_module_get(mbox->dev->driver->owner)) {
-		dev_dbg(dev, "%s: mailbox not free\n", __func__);
-		mutex_unlock(&con_mutex);
-		return ERR_PTR(-EBUSY);
-	}
-
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	init_completion(&chan->tx_complete);
-
-	if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
-		chan->txdone_method = TXDONE_BY_ACK;
-
-	spin_unlock_irqrestore(&chan->lock, flags);
-
-	if (chan->mbox->ops->startup) {
-		ret = chan->mbox->ops->startup(chan);
-
-		if (ret) {
-			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
-			mbox_free_channel(chan);
-			chan = ERR_PTR(ret);
-		}
-	}
+	ret = __mbox_bind_client(chan, cl);
+	if (ret)
+		chan = ERR_PTR(ret);
 
 	mutex_unlock(&con_mutex);
 	return chan;
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 65229a45590f..734694912ef7 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -37,6 +37,7 @@ struct mbox_client {
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
 };
 
+int mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl);
 struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
-- 
2.39.2

