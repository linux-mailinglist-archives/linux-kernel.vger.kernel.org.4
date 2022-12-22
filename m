Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C472653B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiLVEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiLVEto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:49:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458211A80E;
        Wed, 21 Dec 2022 20:49:44 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM4bgBC032093;
        Thu, 22 Dec 2022 04:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=8NKz2ilz1nUXqtBqiyLd1bHJ5FljdNQMK8Gvb39Gb+M=;
 b=n+Udh3cQtavIsBd7Gvp/Y8/e7hTm+JcmZW9dvs+paUTYlrdHICvLScco69KpADrCZxjT
 9YMrKAwIYVadYRAY3zDQZVd6U7FRmxwJX9D056yDlyPBZpvxW+F3UMDqGdV+J57uSj8y
 VjtYaVqNa8nlvC6HssPwCVZ9MAZv3wR7xZGwaSt8pTZak4XkSz6rJ55W28UA4Z3mZGxd
 jAIdaZNLgb92z7yvYGOMr7KHQNOC4DESFVukr2f8zvsbbyqgRefifvSw5vQPp2wxh2IX
 EEvDaWNfKUWtqKLHgyCXDJsSPI/aLSZTGqDaNo3Z1WCWa+JL6xpr36dcCAqEHw2rm23a Rw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm5r2h9x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 04:49:41 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2BM4na0u017965;
        Thu, 22 Dec 2022 04:49:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3mh6ukhx2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Dec 2022 04:49:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BM4naUo017958;
        Thu, 22 Dec 2022 04:49:36 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2BM4nauk017957;
        Thu, 22 Dec 2022 04:49:36 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
        id 87BE65001C2; Thu, 22 Dec 2022 10:19:35 +0530 (+0530)
From:   Viken Dadhaniya <quic_vdadhani@quicinc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vnivarth@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH V1 1/1] Serial: core: Add compat ioctl support
Date:   Thu, 22 Dec 2022 10:19:25 +0530
Message-Id: <20221222044925.27846-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZhoE1F2HzIAuvtmtE_rav98Md3AnjTWj
X-Proofpoint-ORIG-GUID: ZhoE1F2HzIAuvtmtE_rav98Md3AnjTWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_01,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220042
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
 drivers/tty/serial/serial_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9fbbee598b8..5ffa0798db3b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1601,6 +1601,22 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+/**
+ * uart_compat_ioctl: uart compat IOCTL function.
+ * @tty: pointer to tty structure.
+ * @cmd: command code passed by user-space.
+ * @arg: argument  passed by user-space.
+ *
+ * This function will call normal uart IOCTL.
+ *
+ * Return: 0 for success, Negative number for error condition.
+ */
+static long
+uart_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
+{
+	return (long)uart_ioctl(tty, cmd, arg);
+};
+
 static void uart_set_ldisc(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
@@ -2670,6 +2686,7 @@ static const struct tty_operations uart_ops = {
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

