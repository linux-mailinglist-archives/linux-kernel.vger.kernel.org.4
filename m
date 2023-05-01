Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AAB6F3092
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjEAMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjEAMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:01:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5671F129;
        Mon,  1 May 2023 05:01:11 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341BwZMp013766;
        Mon, 1 May 2023 12:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=GTzR/JKjiDDUTEOYY5n13fNjrjSQxoI+C4Wak3ZL/MI=;
 b=QSVvSZXVSbLHdiOepNpT9ASNHYPzaOJtJReRSGfXzF6r8/mtVpp9N4/l6+csnHtnRyol
 3qx8IqbKvaxzncn1Sk0x33k5XhfwAAqsXjUdALUtyrieo2240DvO6v0EhKzFGRYKaRLr
 Z53pbtT8r/8hoL8tthYObvufXZpmSKUde/qvd0Y7DhuhYkiEhYE70NJcwC0x4/VE2v3N
 PGbl4QK8pxo1MT1oLiKsXkjfUBYO7474Y+v9HwiHWR5Wa4qG2HWEaBRoBdvQ1xIu8gMM
 sJuryQf913FTzEoSZychk/4DdYBTI7Tb+vXzANzyBHYkGrJv1UQBjCoRhk3oNin1DrVn SQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8rkwupq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 12:01:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 341C10xJ005931;
        Mon, 1 May 2023 12:01:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q8vakmwfw-1;
        Mon, 01 May 2023 12:01:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 341C0xVn005848;
        Mon, 1 May 2023 12:00:59 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 341C0x1b005846;
        Mon, 01 May 2023 12:00:59 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id EAD0020EB7; Mon,  1 May 2023 17:30:58 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v1 1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs support
Date:   Mon,  1 May 2023 17:30:42 +0530
Message-Id: <1682942442-21507-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KR4KxSX8uvS134IokWDhl9buk6kku2mw
X-Proofpoint-GUID: KR4KxSX8uvS134IokWDhl9buk6kku2mw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010095
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the hci_qca driver side .coredump() callback to
trigger a devcoredump via sysfs

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
Reviewed-by: Manish Mandlik <mmandlik@google.com>
v1:Initial Patch
---
 drivers/bluetooth/hci_qca.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1b06450..ca98f6d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2380,6 +2380,18 @@ static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void hciqca_coredump(struct device *dev)
+{
+	struct serdev_device *serdev = to_serdev_device(dev);
+	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &qcadev->serdev_hu;
+	struct hci_dev  *hdev = hu->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
 
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
@@ -2390,6 +2402,9 @@ static struct serdev_device_driver qca_serdev_driver = {
 		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
 		.shutdown = qca_serdev_shutdown,
 		.pm = &qca_pm_ops,
+#ifdef CONFIG_DEV_COREDUMP
+		.coredump = hciqca_coredump,
+#endif
 	},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

