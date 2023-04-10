Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25C76DC922
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDJQRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjDJQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:17:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC495E74;
        Mon, 10 Apr 2023 09:17:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFxbs5027500;
        Mon, 10 Apr 2023 16:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rx+6r/17vOkvNWWUv4Nah3sAcrya9hfjXuhqzZbdT/I=;
 b=PuZip9sKIABDVsrs0C1TiARXXm1bOVDZl8IJoZez8mVRxwrb/ojV2Ub4dN/YrKMRxaBa
 d+/HmS8WSIOK+SFcvS4dosYpTIZlCGW3+7vkeMhi8nmuucoM+x/y8iuX9Ji2vKecsGmq
 mB5sluZFh5jK3IJ9/0a+ntLZhkAX0F9reNBTEZnD196UrVpZv6hpMib9P4OqWOtMPHuz
 f7Ky+LK64ScrsCEmMTnP6xWIS1NAEMcW82HqRBQHbcJt5SzPAzi7x/+u07H+Ib2C/QGr
 AKjsTQU+PuG8H8JeBoJqVJYUe/r1j9Ysb+S+UpWjiXJoOL9AwlNjk3k9VywFNO/zGIhz pg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvnjer135-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:17:19 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AGHIxl029813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:17:18 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 09:17:18 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 3/3] mailbox: pcc: Use mbox_bind_client
Date:   Mon, 10 Apr 2023 09:16:54 -0700
Message-ID: <20230410161654.1660757-4-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410161654.1660757-1-quic_eberman@quicinc.com>
References: <20230410161654.1660757-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C4ROi07CWOn_bjgIrmFjBxPnZUz7OHlW
X-Proofpoint-GUID: C4ROi07CWOn_bjgIrmFjBxPnZUz7OHlW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=706 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100139
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic mbox_bind_client() to bind omap mailbox channel to a client.

mbox_bind_client is identical to the replaced lines, except that it:
 - Does the operation under con_mutex which prevents possible races in
   removal path
 - Sets TXDONE_BY_ACK if pcc uses TXDONE_BY_POLL and the client knows
   when tx is done. TXDONE_BY_ACK is already set if there's no interrupt,
   so this is not applicable.
 - Calls chan->mbox->ops->startup. This is usecase for requesting irq:
   move the devm_request_irq into the startup callback and unregister it
   in the shutdown path.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/mailbox/pcc.c | 84 +++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 105d46c9801b..a44d4b3e5beb 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -282,8 +282,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan;
-	struct device *dev;
-	unsigned long flags;
+	int rc;
 
 	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);
@@ -294,32 +293,10 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 		pr_err("Channel not found for idx: %d\n", subspace_id);
 		return ERR_PTR(-EBUSY);
 	}
-	dev = chan->mbox->dev;
 
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	init_completion(&chan->tx_complete);
-
-	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
-		chan->txdone_method = TXDONE_BY_ACK;
-
-	spin_unlock_irqrestore(&chan->lock, flags);
-
-	if (pchan->plat_irq > 0) {
-		int rc;
-
-		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
-				      MBOX_IRQ_NAME, chan);
-		if (unlikely(rc)) {
-			dev_err(dev, "failed to register PCC interrupt %d\n",
-				pchan->plat_irq);
-			pcc_mbox_free_channel(&pchan->chan);
-			return ERR_PTR(rc);
-		}
-	}
+	rc = mbox_bind_client(chan, cl);
+	if (rc)
+		return ERR_PTR(rc);
 
 	return &pchan->chan;
 }
@@ -333,23 +310,12 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
  */
 void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 {
-	struct pcc_chan_info *pchan_info = to_pcc_chan_info(pchan);
 	struct mbox_chan *chan = pchan->mchan;
-	unsigned long flags;
 
 	if (!chan || !chan->cl)
 		return;
 
-	if (pchan_info->plat_irq > 0)
-		devm_free_irq(chan->mbox->dev, pchan_info->plat_irq, chan);
-
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->cl = NULL;
-	chan->active_req = NULL;
-	if (chan->txdone_method == TXDONE_BY_ACK)
-		chan->txdone_method = TXDONE_BY_POLL;
-
-	spin_unlock_irqrestore(&chan->lock, flags);
+	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
@@ -377,8 +343,48 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	return pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
+/**
+ * pcc_startup - Called from Mailbox Controller code. Used here
+ *		to request the interrupt.
+ * @chan: Pointer to Mailbox channel to startup.
+ *
+ * Return: Err if something failed else 0 for success.
+ */
+static int pcc_startup(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+	int rc;
+
+	if (pchan->plat_irq > 0) {
+		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq, 0,
+				      MBOX_IRQ_NAME, chan);
+		if (unlikely(rc)) {
+			dev_err(chan->mbox->dev, "failed to register PCC interrupt %d\n",
+				pchan->plat_irq);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pcc_shutdown - Called from Mailbox Controller code. Used here
+ *		to free the interrupt.
+ * @chan: Pointer to Mailbox channel to shutdown.
+ */
+static void pcc_shutdown(struct mbox_chan *chan)
+{
+	struct pcc_chan_info *pchan = chan->con_priv;
+
+	if (pchan->plat_irq > 0)
+		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
+}
+
 static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
+	.startup = pcc_startup,
+	.shutdown = pcc_shutdown,
 };
 
 /**
-- 
2.39.2

