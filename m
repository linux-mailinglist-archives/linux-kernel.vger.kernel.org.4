Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26539725424
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjFGG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFGG2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:28:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159DF1BC6;
        Tue,  6 Jun 2023 23:28:16 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3573Ddua012254;
        Wed, 7 Jun 2023 06:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=lW3wG+8j/vKdx89Rcmr3DMtHKEhTBBXLqiY87hQZwz8=;
 b=QVcQK/aQICJxwmXum24hYHE5V1+7UBV7Ks+btboyjIjoNQDXCTJWglwpIqheO/2uCu9Z
 iE593GkIoXejkibTvxFwl5fVJtDGId2L75ixba2CAlofOMWut4NV86ghbTi3xsFr1vqw
 WxFK9RSRi5x5TU/DjeamVLZef4BoqR1WIkPfKpXQ/qTQ4xsnf53hbElPniHzHq5+PV+q
 9LmGEdr+2llxRwABGWjeWclj08Q/rls7Msgn8/6cXwIgHfAZzlI+psAm9hp2xOjCvfWA
 +CK/VGeQjgHy2QVxgUVb3L1I07HMWlmq9/gUDIlfXKjZp+UnQLtQ/64yCjzWCClJb0TM WQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a7k13ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 06:28:11 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3576S7Nd012633;
        Wed, 7 Jun 2023 06:28:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkm0u1j-1;
        Wed, 07 Jun 2023 06:28:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3576S7DH012628;
        Wed, 7 Jun 2023 06:28:07 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3576S7Ei012625;
        Wed, 07 Jun 2023 06:28:07 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id B060620B89; Wed,  7 Jun 2023 11:58:06 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v3 1/2] Bluetooth: hci_qca: Add qcom devcoredump sysfs support
Date:   Wed,  7 Jun 2023 11:57:56 +0530
Message-Id: <1686119276-10756-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6AahDkLab7ioVa5UwqdsjdMQwLguDe7H
X-Proofpoint-GUID: 6AahDkLab7ioVa5UwqdsjdMQwLguDe7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_03,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070052
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

