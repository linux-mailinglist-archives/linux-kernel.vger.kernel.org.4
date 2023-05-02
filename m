Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE76F3CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjEBEWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBEWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:22:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47022702;
        Mon,  1 May 2023 21:22:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3424Gocw023660;
        Tue, 2 May 2023 04:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=BAI2pSNXMZu9fQ6IMOP1IqPcHZ2SOkxNhVQAdj8f1/c=;
 b=brwJKGXxI+CkHExJPl8m186mffgc1Nzd2g26wtC2V3VgDBh0ZBPEiNoUz3X2H9uu4+7K
 Q7smXuokEP4hF2Wi391Tqczubb6WLJ1UAA1E81lhv0KkBH8XqAe2OCF8A69IwkhAA/KP
 mCt2cd57wM5cx3K+ZMS9dkFEjAtQEFAB+Cq4tH9xzrMmWdlUxezS40a/md7Jt90x3oGt
 T23vWpIY2wOEwaBae1MItrxEq94U+06U1D83FFq2LwO6/r9w7cU8pdERDnlCvJuI7hXq
 0PkXqwVW++Qsbqxoa1ixsHa4tucwVGMwrl5UtCiPcvefd/tCX9UKL/mpBSI5Egiw+DmI 7A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8vhgw8hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 04:22:38 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3424MXZG008220;
        Tue, 2 May 2023 04:22:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q8vaks3ca-1;
        Tue, 02 May 2023 04:22:33 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3424MXZo008213;
        Tue, 2 May 2023 04:22:33 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3424MXE7008211;
        Tue, 02 May 2023 04:22:33 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id 8EB8B20B88; Tue,  2 May 2023 09:52:32 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v2 1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs support
Date:   Tue,  2 May 2023 09:52:12 +0530
Message-Id: <1683001332-29777-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zzweEfxt8GraypYnhyDiL3OZnj20lsDt
X-Proofpoint-ORIG-GUID: zzweEfxt8GraypYnhyDiL3OZnj20lsDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020036
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

V2:
--
Updated to work with the updated HCI devcoredump API. 

V1:
--
Initial Patch

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

