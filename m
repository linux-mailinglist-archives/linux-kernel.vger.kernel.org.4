Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA467B172
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjAYLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjAYLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:34:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E115CB2;
        Wed, 25 Jan 2023 03:34:31 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PBVCWD001867;
        Wed, 25 Jan 2023 11:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=/+VsR0WVfZgRKDbswEbML4hy6rt27/ONKz75RbjHZZ8=;
 b=J4xz1ELfTDUoHtKoY8WJNjsq6qVrhyXswcZjGyTLvNmzDPHXDZZfHjm1X/N1sE38Tr5s
 rXROvlnbncx1b8rIBSW+gOaJJhGP+8t7tH4M8ECpnJ+PRoxpOKrV6zwA6nvqeIZT86Vq
 7T5zEsDA2Q2vUDAQDucW74b/ZK5Gj4RNH3fixwFO2h0Ol7b2CRBsImnhtpL5IjTbE26i
 +0HDjXUXF1LRUFHG3JaN7s9SaWrvmT97I8EloYuhPvhxwOYfDb2e47yQi853IjQje08U
 +RcHUitr/2MPcQ0Zw7H8EY6z3LBG7I287DGfsnKX2PWiupjP7oxo3pNpbYtLwdD6iLWs KQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk6ykh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:34:28 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30PBYOdA022986;
        Wed, 25 Jan 2023 11:34:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3n894ksyqm-1;
        Wed, 25 Jan 2023 11:34:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PBYOUR022981;
        Wed, 25 Jan 2023 11:34:24 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 30PBYN8f022980;
        Wed, 25 Jan 2023 11:34:24 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
        id 3BEF65000AA; Wed, 25 Jan 2023 17:04:23 +0530 (+0530)
From:   Viken Dadhaniya <quic_vdadhani@quicinc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vnivarth@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH V2] Serial: core: Add compat ioctl support
Date:   Wed, 25 Jan 2023 17:04:18 +0530
Message-Id: <20230125113418.7221-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qju924ljFTlRTFPnG1rNQPYZUdI0OysZ
X-Proofpoint-ORIG-GUID: Qju924ljFTlRTFPnG1rNQPYZUdI0OysZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250105
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current serial core driver doesn't support compat_ioctl
due to which 32-bit application is not able to send
ioctls to driver on a 64-bit platform.

Added compat_ioctl support in serial core to handle
ioctls from 32-bit applications on a 64-bit platform.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 drivers/tty/serial/serial_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9fbbee598b8..ad4c3a5a3d29 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1601,6 +1601,12 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+static long
+uart_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
+{
+	return (long)uart_ioctl(tty, cmd, arg);
+};
+
 static void uart_set_ldisc(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
@@ -2670,6 +2676,7 @@ static const struct tty_operations uart_ops = {
 	.chars_in_buffer= uart_chars_in_buffer,
 	.flush_buffer	= uart_flush_buffer,
 	.ioctl		= uart_ioctl,
+	.compat_ioctl   = uart_compat_ioctl,
 	.throttle	= uart_throttle,
 	.unthrottle	= uart_unthrottle,
 	.send_xchar	= uart_send_xchar,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

