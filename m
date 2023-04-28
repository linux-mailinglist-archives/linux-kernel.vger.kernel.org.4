Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7D6F1234
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjD1HRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjD1HRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:17:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563012125;
        Fri, 28 Apr 2023 00:17:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S6ktEm032540;
        Fri, 28 Apr 2023 07:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=nqig2+ej3w4Jhp8vgYn+OLQTxwiF7rppO0W2C5VOZGo=;
 b=QSWKPo4Pa+KwGHI9pvPAl6UVis43eA5Bu0VaUCVn1fhPTQ1bwo5akN1i27IapSe9XtFF
 8YWFEQmzWlFcDHCJbgMKvlUA+sWEg6mqbhJJcR3H7ATcjVCkH007KU0cIc6UOj+M+lkx
 qgppDiu240azJDsEPxY+u4sC/8elXFT2qc7K+uI9IVf7nxwkGnAIq1dTkvnWlxlq7OAt
 kxZyxNQJxxHRdifuARQ3l8Qd6JiEEQ5vsVVXvZZkwDBc38dkh+FSduEw5jpOHLO+zfgq
 J40qS42oTnsu1ylplov7KLKUMDXc63qyupprD9LVHCiOjl0FG73u4qEkMQyUn4LiBpDO lA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7wm59bs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 07:17:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33S7Gx4R023216;
        Fri, 28 Apr 2023 07:16:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q48nmbs2d-1;
        Fri, 28 Apr 2023 07:16:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33S7Gx0E023208;
        Fri, 28 Apr 2023 07:16:59 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33S7Gx92023205;
        Fri, 28 Apr 2023 07:16:59 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id B71CF20ECF; Fri, 28 Apr 2023 12:46:58 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        quic_rameshn@quicinc.com, jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v1 1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs support
Date:   Fri, 28 Apr 2023 12:46:53 +0530
Message-Id: <1682666213-7973-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YgMRD4flNPKIrKjXB1B7LrcnDlC5n7TV
X-Proofpoint-ORIG-GUID: YgMRD4flNPKIrKjXB1B7LrcnDlC5n7TV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280058
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
trigger a devcoredump via sysfs and .enable_coredump() callback to
check if the devcoredump functionality is enabled for a device.

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
Reviewed-by: Manish Mandlik <mmandlik@google.com>

---
 drivers/bluetooth/hci_qca.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1b06450..e21180d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1702,6 +1702,15 @@ static int qca_power_on(struct hci_dev *hdev)
 	return ret;
 }
 
+#ifdef CONFIG_DEV_COREDUMP
+static bool hciqca_coredump_enabled(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	return !hu->serdev->dev.coredump_disabled;
+}
+#endif
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1780,6 +1789,9 @@ static int qca_setup(struct hci_uart *hu)
 		qca_debugfs_init(hdev);
 		hu->hdev->hw_error = qca_hw_error;
 		hu->hdev->cmd_timeout = qca_cmd_timeout;
+#ifdef CONFIG_DEV_COREDUMP
+		hu->hdev->dump.enabled = hciqca_coredump_enabled;
+#endif
 		if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
 			hu->hdev->wakeup = qca_wakeup;
 	} else if (ret == -ENOENT) {
@@ -2380,6 +2392,18 @@ static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
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
+	if (!dev->coredump_disabled && hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
 
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
@@ -2390,6 +2414,9 @@ static struct serdev_device_driver qca_serdev_driver = {
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

