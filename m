Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A316972F3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbjFNE6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFNE6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:58:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED17122;
        Tue, 13 Jun 2023 21:58:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E4oTPD022288;
        Wed, 14 Jun 2023 04:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=lW3wG+8j/vKdx89Rcmr3DMtHKEhTBBXLqiY87hQZwz8=;
 b=XekTbhqUOeQfXVTLRolayRCdsp9VpvtvIncFx99IGMYfxlkx7CNFHxL4Aq++hbbvqgB7
 PJ7T8bG2Aw2LZ6mBKBOVxzseh5CV1HNJM68DLRgUarYWbqiAitpMBeS7qsV3S251ZbvX
 qTC+1yheuf0VR0S5EUjzlftaI2Tq8THT5Ilxc/VQNaOz+FF71PwDTmj/mBjR2kMqVhRa
 w4FWoYHtH0hpJA/yz01Fib98GPC6XWKnCZZjdqxk6QfX3knRJvc1nk807d290kQvZ+ha
 mpAAdOrYwTphLCuTRdXsK/8VWKVE3TReBSH7rM2FpyIP33qBlr9HQ6Ma424/vcrKI00l lQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r71tvrfmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 04:58:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35E4wKZf025617;
        Wed, 14 Jun 2023 04:58:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3r4j8kyuma-1;
        Wed, 14 Jun 2023 04:58:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35E4wKJk025612;
        Wed, 14 Jun 2023 04:58:20 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35E4wKuU025611;
        Wed, 14 Jun 2023 04:58:20 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id A7F3C20BFD; Wed, 14 Jun 2023 10:28:19 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [RESEND v3 1/2] Bluetooth: hci_qca: Add qcom devcoredump sysfs support
Date:   Wed, 14 Jun 2023 10:28:15 +0530
Message-Id: <1686718695-31734-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BXcCmrDX4OHQzapKxtugVxPvLX_CDEJb
X-Proofpoint-ORIG-GUID: BXcCmrDX4OHQzapKxtugVxPvLX_CDEJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140040
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the hci_qca driver side .coredump() callback to
trigger a devcoredump via sysfs.

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

v2 -> V3:
--------
Updated commit text

v1 -> V2:
--------
Updated to work with the updated HCI devcoredump API.
---
 drivers/bluetooth/hci_qca.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e30c979..1ee5323 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2384,6 +2384,18 @@ static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
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
@@ -2394,6 +2406,9 @@ static struct serdev_device_driver qca_serdev_driver = {
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

