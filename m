Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E8E699A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBPQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBPQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:38:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FC4CC98;
        Thu, 16 Feb 2023 08:38:23 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G9v6W8006206;
        Thu, 16 Feb 2023 16:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=xkLbnqJt/sijM+Co64dSaanSfQWhIPybj6CY+XxPrR8=;
 b=bTZKxEEYXlAriNHGjQI+btGTq8axeObcfAi0eLBZkcOmP0y5eqQSz7PVdO7XU1dM/Uu3
 Bn3kIHnGdnhfrYvEEp5j37Ybwcaprd/DHe5EcfrTmgdgNw2ONELRsj+WHQ+RXPicB3ny
 wtHIBdr/3OXSWEkVbsZGDHt2wnxLIGWtzDYJcnLk4BJ3vDS2G83zSanes4FiqHYbOyf2
 1RNpQwtsw+cdZ9qtt3qjZ59ok5L4ebg6ip+0+YOFgkzYTo5N6LqhHjPOsLlTHXJnuEAE
 sS2snKNS+JYN3b4Yk8DBR0B9KEonFURoVXIe4htDOLOYYoEBzyeHCdECz7jGjwK10ut9 6Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nsja910cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:38:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GGcJiQ011639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 16:38:19 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Feb 2023 08:38:18 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     <quic_eberman@quicinc.com>, Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>
Subject: [PATCH 1/3] mailbox: Allow direct registration to a channel
Date:   Thu, 16 Feb 2023 08:38:03 -0800
Message-ID: <20230216163804.456714-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213232537.2040976-1-quic_eberman@quicinc.com>
References: <20230213232537.2040976-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8bNlDWfzueRAZh6CaVV4wflYTGdv_NWy
X-Proofpoint-ORIG-GUID: 8bNlDWfzueRAZh6CaVV4wflYTGdv_NWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_12,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support virtual mailbox controllers and clients which are not platform
devices or come from the devicetree by allowing them to match client to
channel via some other mechanism.

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
2.39.1

