Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086C6944A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBMLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBMLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:37:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB12118;
        Mon, 13 Feb 2023 03:37:26 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8sLmp032210;
        Mon, 13 Feb 2023 11:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=xt1VHmgKgpm0l+/ZG/+O/+c/YoQVFy6mXmp98uIPAKY=;
 b=YjU7gvtb1orIN5DZlhnaTXujHOZTV0/cIA39D/p5dm9i9Eko4cvtz82YuXxfYP0VeK7F
 CqwvcYvSSzb8EdDorBZ6O+IBIJXfQQL2QN4uCt24gYvl0La/wunR+wteHY6j7sMzVP/l
 KC0QIN/WZcINLx4JVtW6OODtaK42z86aoubIkgH70CKvqKVXT69VpoixUUxUFpphmonO
 VJPpszyYrTRx4s60jGOWLhtvw0DNn/KcZHMfdK2v0oa53FKo4EJaw0S15BKA1ACKJKzq
 jPwGLcFM51cyv5opPKMK42kZCGQdQD2DqSuoadACxOwwOE7M8XqIGLSBz19gHIDpcRoT IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np342v2kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 11:37:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DBbIxI002891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 11:37:18 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 03:37:14 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
CC:     Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v4] usb: gadget: u_serial: Add null pointer check in gserial_resume
Date:   Mon, 13 Feb 2023 17:06:10 +0530
Message-ID: <1676288170-5493-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: maXhBMFVuAl4d-wfqfxDYj8dnWRgiOgY
X-Proofpoint-ORIG-GUID: maXhBMFVuAl4d-wfqfxDYj8dnWRgiOgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=798 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302130104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a case where gserial_disconnect has already cleared
gser->ioport. And if a wakeup interrupt triggers afterwards,
gserial_resume gets called, which will lead to accessing of
gser->ioport and thus causing null pointer dereference.Add
a null pointer check to prevent this.

Added a static spinlock to prevent gser->ioport from becoming
null after the newly added check.

Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
v4: Added short comment about serial_port_lock.

 drivers/usb/gadget/function/u_serial.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 840626e..3a6adf2 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -82,6 +82,13 @@
 #define WRITE_BUF_SIZE		8192		/* TX only */
 #define GS_CONSOLE_BUF_SIZE	8192
 
+/*
+ * Since all the spinlocks used in this driver is part of struct gs_port (port_lock).
+ * Added a new static spinlock to prevent race conditions where gs_port is dereferenced
+ * after marking as null.
+ */
+static DEFINE_SPINLOCK(serial_port_lock);
+
 /* console info */
 struct gs_console {
 	struct console		console;
@@ -1375,8 +1382,10 @@ void gserial_disconnect(struct gserial *gser)
 	if (!port)
 		return;
 
+	spin_lock_irqsave(&serial_port_lock, flags);
+
 	/* tell the TTY glue not to do I/O here any more */
-	spin_lock_irqsave(&port->port_lock, flags);
+	spin_lock(&port->port_lock);
 
 	gs_console_disconnect(port);
 
@@ -1391,7 +1400,8 @@ void gserial_disconnect(struct gserial *gser)
 			tty_hangup(port->port.tty);
 	}
 	port->suspended = false;
-	spin_unlock_irqrestore(&port->port_lock, flags);
+	spin_unlock(&port->port_lock);
+	spin_unlock_irqrestore(&serial_port_lock, flags);
 
 	/* disable endpoints, aborting down any active I/O */
 	usb_ep_disable(gser->out);
@@ -1425,10 +1435,19 @@ EXPORT_SYMBOL_GPL(gserial_suspend);
 
 void gserial_resume(struct gserial *gser)
 {
-	struct gs_port *port = gser->ioport;
+	struct gs_port *port;
 	unsigned long	flags;
 
-	spin_lock_irqsave(&port->port_lock, flags);
+	spin_lock_irqsave(&serial_port_lock, flags);
+	port = gser->ioport;
+
+	if (!port) {
+		spin_unlock_irqrestore(&serial_port_lock, flags);
+		return;
+	}
+
+	spin_lock(&port->port_lock);
+	spin_unlock(&serial_port_lock);
 	port->suspended = false;
 	if (!port->start_delayed) {
 		spin_unlock_irqrestore(&port->port_lock, flags);
-- 
2.7.4

