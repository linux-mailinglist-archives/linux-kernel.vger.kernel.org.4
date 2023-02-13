Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB446954C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBMX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBMX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:26:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A5212D;
        Mon, 13 Feb 2023 15:26:25 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMv5LH022198;
        Mon, 13 Feb 2023 23:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7yEmPDxwX+j68RdLPeUfDl+nbsuqsW6P3jODpDSi6T0=;
 b=aLv42hbhCrtbuGTKHpe8Id+PtqkKqBs/twfRAzwIrjjD51KMi3aMV2QnAq2OyPpRCFiP
 l+h6A1ijsw3yklTzvxvVPPqwd9gfzGgxRKhtvRraDtYzS2LzV+dvO4DY5sL+4fhOaj2e
 10jud8P54DA73tB8p+1/E40TTzMj4/IhVHDa0TpLNHE93u0Hq+YVo4/qh+uG8Q5IGKnG
 QwfBEFLmYTEcZDNS3Zy7m3sdXIfQiJG1w4q+0zuiQueFPaoXdNvYzq4uTT/q7qopIg+c
 zoApddZD01KjFpx5ndpfAkHcUGklTR5o9SMGYdx34msxD8Yj956mkPt1VxSW6lLOq+CP Og== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np389w8rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 23:26:21 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DNQK0B030322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 23:26:20 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 15:26:20 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 3/3] mailbox: pcc: Use mbox_bind_client
Date:   Mon, 13 Feb 2023 15:25:37 -0800
Message-ID: <20230213232537.2040976-4-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213232537.2040976-1-quic_eberman@quicinc.com>
References: <20230213232537.2040976-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FryChU_jp-N1t5XihmY6y49n05w6IhkI
X-Proofpoint-GUID: FryChU_jp-N1t5XihmY6y49n05w6IhkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=854 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130205
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/mailbox/pcc.c | 82 ++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 105d46c9801b..3a025415c5d5 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -283,7 +283,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan;
 	struct device *dev;
-	unsigned long flags;
+	int rc;
 
 	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);
@@ -296,30 +296,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	}
 	dev = chan->mbox->dev;
 
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
@@ -333,23 +312,12 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
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
 
@@ -377,8 +345,48 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	return pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
+/**
+ * pcc_startup - Called from Mailbox Controller code. Used here
+ *		to request the interrupt.
+ * @chan: Pointer to Mailbox channel to startup.
+ *
+ * Return: Err if something failed else 0 for success.
+ */
+int pcc_startup(struct mbox_chan *chan)
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
+void pcc_shutdown(struct mbox_chan *chan)
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
2.39.1

