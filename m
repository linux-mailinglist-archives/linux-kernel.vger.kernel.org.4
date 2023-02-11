Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC9693383
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBKUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBKUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:07:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F919694;
        Sat, 11 Feb 2023 12:07:27 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31BJvVOi021451;
        Sat, 11 Feb 2023 20:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZjpcJA4Rc/e6tv1rB7kOM0ARVaYht00pDtjoIJCOOic=;
 b=jpDKF9fSsdRzwwlPY+8sj5hqJIQdQNZIqPQIhg2Lo5on3m0/aviuCAmhaNNyuknB4F8T
 QZiK/m+aBO3jbMU5sJoBrSJ2D/KCH+w+XWR73y9B4AR2LT5cBFqs6MMGPVrnU6WVT/Q7
 36W//tkav+BvnyH62Ss6IeoNaumnjRtNbNd+znt+kIDwYKXRd8jyk1/cB2y9MxJhOffY
 g4zFJPJ4PaCPYyHgj/pEw6ae1/cHYbVTWH0eO1bWuaQJdoQiie/0DnG5nUNoBaTN9zfi
 TQxbdwH4TldnhW+9dRU0UUsFjag25KxUKoh0ufYqxHpOixgUBVZ9svyoKNd6j+yM/vee bQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np4ag909u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 20:07:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31BK7KUM007961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 20:07:20 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sat, 11 Feb 2023 12:07:17 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
CC:     Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v3] usb: gadget: u_serial: Add null pointer check in gserial_resume
Date:   Sun, 12 Feb 2023 01:37:13 +0530
Message-ID: <1676146033-3948-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DV0m_I9uDM6_NqS_zAeJpSGPAbVWeJhD
X-Proofpoint-GUID: DV0m_I9uDM6_NqS_zAeJpSGPAbVWeJhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=793
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302110187
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v3: Fixed the spin_lock_irqsave flags.

 drivers/usb/gadget/function/u_serial.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 840626e..471087f 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -82,6 +82,8 @@
 #define WRITE_BUF_SIZE		8192		/* TX only */
 #define GS_CONSOLE_BUF_SIZE	8192
 
+static DEFINE_SPINLOCK(serial_port_lock);
+
 /* console info */
 struct gs_console {
 	struct console		console;
@@ -1370,13 +1372,15 @@ EXPORT_SYMBOL_GPL(gserial_connect);
 void gserial_disconnect(struct gserial *gser)
 {
 	struct gs_port	*port = gser->ioport;
-	unsigned long	flags;
+	unsigned long flags;
 
 	if (!port)
 		return;
 
+	spin_lock_irqsave(&serial_port_lock, flags);
+
 	/* tell the TTY glue not to do I/O here any more */
-	spin_lock_irqsave(&port->port_lock, flags);
+	spin_lock(&port->port_lock);
 
 	gs_console_disconnect(port);
 
@@ -1391,7 +1395,8 @@ void gserial_disconnect(struct gserial *gser)
 			tty_hangup(port->port.tty);
 	}
 	port->suspended = false;
-	spin_unlock_irqrestore(&port->port_lock, flags);
+	spin_unlock(&port->port_lock);
+	spin_unlock_irqrestore(&serial_port_lock, flags);
 
 	/* disable endpoints, aborting down any active I/O */
 	usb_ep_disable(gser->out);
@@ -1426,9 +1431,16 @@ EXPORT_SYMBOL_GPL(gserial_suspend);
 void gserial_resume(struct gserial *gser)
 {
 	struct gs_port *port = gser->ioport;
-	unsigned long	flags;
+	unsigned long flags;
 
-	spin_lock_irqsave(&port->port_lock, flags);
+	spin_lock_irqsave(&serial_port_lock, flags);
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

