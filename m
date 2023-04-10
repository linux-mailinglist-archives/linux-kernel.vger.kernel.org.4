Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4706C6DC927
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDJQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjDJQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:17:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1CC1FDD;
        Mon, 10 Apr 2023 09:17:27 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ADeHnE018567;
        Mon, 10 Apr 2023 16:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=8YqbOZ+zPszKRteZJwJzU3+KjVpZYfDq8pQt6ZMxOqQ=;
 b=BOmuYtllF991FlQIpBkLAvmyBldp1GR/mGOI0DKyf5qtL/uSwdgh9PMBULQ8hstQbx0G
 6QvZ6IJQsI4/+7EQGAL6hxAExSmKwaRd0svbdV1BCUQugGJ1ZpFsuwPW6KN+8AdnHcW/
 ly7L6eC/l0IuYyZ8Aen7XOoLm9qxWIpI65ec93iyBvnwgGyIEPwSbGVBuMMXXzSQG3Kj
 G5O3F07PWNl9IsDxatYVZqMiM2KsYr45Ie0tVjHrmHQsGwwIDk5JTMmGX3gBPxTQZq1f
 59DHTT0T5vZPp73Bdy6dU+9X1bttntmp1hhZWUaZcm5LwBp4JFhyHx/jLeMazIfD/jVD lA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pu0c33cr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:17:18 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AGHHMM029807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:17:17 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 10 Apr 2023 09:17:17 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 2/3] mailbox: omap: Use mbox_bind_client
Date:   Mon, 10 Apr 2023 09:16:53 -0700
Message-ID: <20230410161654.1660757-3-quic_eberman@quicinc.com>
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
X-Proofpoint-GUID: NdR-6xRiWn2A2b_QdDq5ctTeofEn8jtc
X-Proofpoint-ORIG-GUID: NdR-6xRiWn2A2b_QdDq5ctTeofEn8jtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=673 classifier=spam adjust=0 reason=mlx scancount=1
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
 - Sets TXDONE_BY_ACK if omap uses TXDONE_BY_POLL. omap uses
   TXDONE_BY_IRQ, so this check is not applicable.
 - Calls chan->mbox->ops->startup, if available. omap doesn't have, so
   this is not applicable.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/mailbox/omap-mailbox.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 098c82d87137..dfe82a5ff403 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -417,8 +417,6 @@ struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
 	struct device *dev = cl->dev;
 	struct omap_mbox *mbox = NULL;
 	struct omap_mbox_device *mdev;
-	struct mbox_chan *chan;
-	unsigned long flags;
 	int ret;
 
 	if (!dev)
@@ -441,23 +439,11 @@ struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
 	if (!mbox || !mbox->chan)
 		return ERR_PTR(-ENOENT);
 
-	chan = mbox->chan;
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	init_completion(&chan->tx_complete);
-	spin_unlock_irqrestore(&chan->lock, flags);
-
-	ret = chan->mbox->ops->startup(chan);
-	if (ret) {
-		pr_err("Unable to startup the chan (%d)\n", ret);
-		mbox_free_channel(chan);
-		chan = ERR_PTR(ret);
-	}
+	ret = mbox_bind_client(mbox->chan, cl);
+	if (ret)
+		return ERR_PTR(ret);
 
-	return chan;
+	return mbox->chan;
 }
 EXPORT_SYMBOL(omap_mbox_request_channel);
 
-- 
2.39.2

