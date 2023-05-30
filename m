Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FCD715CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjE3LQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjE3LQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:16:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0281E5;
        Tue, 30 May 2023 04:16:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UAxIDq006267;
        Tue, 30 May 2023 11:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=itfenvgDHTyxp1L5qxO18pecrhAyNG1011llMvDnQMU=;
 b=YhqObDpAwMPRrc76syfjTfcX/goGEoo00rty5aUl6IiaYQCy/AZ58KF7kRHgXuD+4BWs
 KD6BGE2uXv8C4uKYbKGDSI+jvmgvjvZ2t5XgHm+OwtPlV1bJSmj2yvzsCNqHzUSkeAog
 Plqs9Q7+jb7fFVLE6jsBvDZ3PrIoqC7+npYAhCQap1aGt6O0/s1E4JijddYacgVy3OQn
 1uYu0HOsW5REg3iJNcBMP02Tgf7cKoAm7ZQG28ZI/xwUbZKUOxYIOslulGVIJMmZ9XVq
 XtB1rpqu16MhuQZmpv4BqrPzE2pMf5IhSZdHLArF9tr7ObfOadrLx1y812VKBGZGYqKt mw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwa34grdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 11:16:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34UBG9BG007539;
        Tue, 30 May 2023 11:16:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3quaxka9pc-1;
        Tue, 30 May 2023 11:16:09 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UBG93m007534;
        Tue, 30 May 2023 11:16:09 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-mraninga-hyd.qualcomm.com [10.213.107.117])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34UBG9bC007533;
        Tue, 30 May 2023 11:16:09 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4325269)
        id 690C65000AF; Tue, 30 May 2023 16:46:08 +0530 (+0530)
From:   Mehul Raninga <quic_mraninga@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_vdadhani@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com,
        Mehul Raninga <quic_mraninga@quicinc.com>
Subject: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep sleep
Date:   Tue, 30 May 2023 16:45:57 +0530
Message-Id: <20230530111557.10944-1-quic_mraninga@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5LvPNkpv05sofZel4uMjGzIOq26WjmVY
X-Proofpoint-GUID: 5LvPNkpv05sofZel4uMjGzIOq26WjmVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300093
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While exiting deep sleep, serial port loses its configuration
hence it prints garbage characters on console.

Set serial port configuration while resume from deep sleep.

Signed-off-by: Mehul Raninga <quic_mraninga@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 8582479f0211..c04b8fec30ba 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -20,6 +20,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
@@ -1737,6 +1738,8 @@ static int qcom_geni_serial_sys_resume(struct device *dev)
 	if (uart_console(uport)) {
 		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
 		geni_icc_set_bw(&port->se);
+		if (pm_suspend_via_firmware())
+			qcom_geni_serial_port_setup(uport);
 	}
 	return ret;
 }
-- 
2.17.1

