Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2626B5936
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 08:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCKHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 02:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCKHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 02:10:05 -0500
X-Greylist: delayed 1108 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 23:10:03 PST
Received: from smtpq3.tb.mail.iss.as9143.net (smtpq3.tb.mail.iss.as9143.net [212.54.42.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D5125D8B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 23:10:03 -0800 (PST)
Received: from [212.54.42.107] (helo=smtp3.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <dick@mrns.nl>)
        id 1pat4n-0004fz-Bu
        for linux-kernel@vger.kernel.org; Sat, 11 Mar 2023 07:51:33 +0100
Received: from routi.mrns.nl ([213.93.239.227])
        by smtp3.tb.mail.iss.as9143.net with ESMTPA
        id at4lpceQktg8eat4mp5zov; Sat, 11 Mar 2023 07:51:33 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 213.93.239.227
X-CNFS-Analysis: v=2.4 cv=bZetEsDB c=1 sm=1 tr=0 ts=640c24f5 cx=a_exe
 a=JHrq6bmmrihZf+Bww3MhDg==:117 a=JHrq6bmmrihZf+Bww3MhDg==:17
 a=k__wU0fu6RkA:10 a=oxU5Xt4QAAAA:8 a=H1w7Dpf3J3Y2f7KK384A:9
 a=jKdzr7yA372qb7_9lzlF:22
X-Authenticated-Sender: boeierlaan60@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Sat, 11 Mar 2023 07:51:31 +0100
From:   Dick Marinus <dick@mrns.nl>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Dick Marinus <dick@mrns.nl>
Subject: [PATCH] Use HID descriptor for razer devices
Date:   Sat, 11 Mar 2023 07:51:05 +0100
Message-Id: <20230311065105.2789549-1-dick@mrns.nl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAphZi6dGL5HLTWgpj9F6rN1+rMPfA0C8QU057KnGwYzYGB9VZVvH0Eu6WqCsCjMT85TGuZuh3UN6YT/54gVtV9a1G+ossITH+yk5Ix26lMKHRO4layB
 XPPwJF7PAWiUZmile+17sX1pRPj8gofQIkkSiI9SwCAyMC14zJ21VVsxs+yfxfrvoMqArITs4KvFLb8ejDcUu5QeEzCELR4g8cdZz7qBXleOLvzxZh25q6SL
 okfmN/OTFeme15mamaSU2gLOFnaQBuY/f+behECStdheVcIGdh9Zo3c2QKUXWx86U+iL0PNZCfoexn+cp5C57VMLAirF/sP/waTHTQbZsQE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid-razer currently makes some guesses which device should be used to
send control messages and the size of it.

This patch derives this information from the HID descriptors, the
Windows Drivers from Razer also do this.

The crc in the blackwidow_init packet is now calculated (copied from
openrazer GPL code).

Signed-off-by: Dick Marinus <dick@mrns.nl>
---
 drivers/hid/hid-razer.c | 141 ++++++++++++++++++++++++++++++----------
 drivers/hid/hid-razer.h |   7 ++
 2 files changed, 115 insertions(+), 33 deletions(-)
 create mode 100644 drivers/hid/hid-razer.h

diff --git a/drivers/hid/hid-razer.c b/drivers/hid/hid-razer.c
index 740df148b0..0c83269d66 100644
--- a/drivers/hid/hid-razer.c
+++ b/drivers/hid/hid-razer.c
@@ -15,31 +15,15 @@
 #include <linux/wait.h>
 
 #include "hid-ids.h"
+#include "hid-razer.h"
 
 #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
-#define RAZER_BLACKWIDOW_TRANSFER_BUF_SIZE	91
-
 static bool macro_key_remapping = 1;
 module_param(macro_key_remapping, bool, 0644);
 MODULE_PARM_DESC(macro_key_remapping, " on (Y) off (N)");
 
-
-static unsigned char blackwidow_init[RAZER_BLACKWIDOW_TRANSFER_BUF_SIZE] = {
-	0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04,
-	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x04, 0x00
-};
+static unsigned char set_device_mode[] = {0x00, 0x04, 0x02, 0x00};
 
 static int razer_input_mapping(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
@@ -73,35 +57,125 @@ static int razer_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 
+static bool razer_check_control_interface(struct hid_device *hdev)
+{
+	int i;
+	unsigned int hid;
+	struct hid_report *report;
+	struct hid_razer *hid_razer_drvdata;
+
+	hid_razer_drvdata = hid_get_drvdata(hdev);
+
+	list_for_each_entry(report, &hdev->report_enum[HID_FEATURE_REPORT].report_list, list) {
+		for (i = 0; i < report->maxfield; i++) {
+			hid = report->field[i]->usage->hid;
+
+			if ((hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR && (hid & HID_USAGE) == 0x2) {
+				hid_razer_drvdata->report_count = report->field[i]->report_count;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static int razer_control_message(struct hid_device *hdev, unsigned char data_len,
+	unsigned char *data)
+{
+	struct hid_razer *hid_razer_drvdata;
+	unsigned char *full_control_message;
+	unsigned char crc = 0;
+	unsigned int i;
+	unsigned int report_count;
+	int ret;
+
+	if (data_len < 2) {
+		ret = -EINVAL;
+		goto cleanup_and_exit;
+	}
+
+	hid_razer_drvdata = hid_get_drvdata(hdev);
+
+	report_count = hid_razer_drvdata->report_count;
+
+	if (report_count < 2) {
+		ret = -EINVAL;
+		goto cleanup_and_exit;
+	}
+
+	full_control_message = kzalloc(report_count + 1, GFP_KERNEL);
+
+	if (full_control_message == NULL) {
+		ret = -ENOMEM;
+		goto cleanup_and_exit;
+	}
+
+	full_control_message[6] = data_len - 2;
+	memcpy(full_control_message + 7, data, data_len);
+
+	for (i = 2; i < report_count - 2; i++)
+		crc ^= full_control_message[i];
+
+	full_control_message[report_count - 1] = crc;
+
+	ret = hid_hw_raw_request(
+		hdev,
+		0,
+		full_control_message,
+		report_count + 1,
+		HID_FEATURE_REPORT,
+		HID_REQ_SET_REPORT
+	);
+
+	if (ret != report_count + 1) {
+		ret = -EIO;
+		goto cleanup_and_exit;
+	}
+
+cleanup_and_exit:
+	kfree(full_control_message);
+
+	return 0;
+}
+
+
 static int razer_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	char *buf;
 	int ret = 0;
+	struct hid_razer *hid_razer_drvdata;
+
+	hid_razer_drvdata = kzalloc(sizeof(struct hid_razer), GFP_KERNEL);
+	if (hid_razer_drvdata == NULL)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, hid_razer_drvdata);
 
 	ret = hid_parse(hdev);
+
 	if (ret)
 		return ret;
 
-	/*
-	 * Only send the enable macro keys command for the third device
-	 * identified as mouse input.
-	 */
-	if (hdev->type == HID_TYPE_USBMOUSE) {
-		buf = kmemdup(blackwidow_init, RAZER_BLACKWIDOW_TRANSFER_BUF_SIZE, GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
-
-		ret = hid_hw_raw_request(hdev, 0, buf, RAZER_BLACKWIDOW_TRANSFER_BUF_SIZE,
-				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
-		if (ret != RAZER_BLACKWIDOW_TRANSFER_BUF_SIZE)
+	if (razer_check_control_interface(hdev)) {
+		ret = razer_control_message(hdev, sizeof(set_device_mode), set_device_mode);
+		if (ret) {
 			hid_err(hdev, "failed to enable macro keys: %d\n", ret);
-
-		kfree(buf);
+			return ret;
+		}
 	}
 
 	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 }
 
+static void razer_remove(struct hid_device *hdev)
+{
+	struct hid_razer *hid_razer_drvdata;
+
+	hid_razer_drvdata = hid_get_drvdata(hdev);
+
+	kfree(hid_razer_drvdata);
+}
+
 static const struct hid_device_id razer_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER,
 		USB_DEVICE_ID_RAZER_BLACKWIDOW) },
@@ -118,6 +192,7 @@ static struct hid_driver razer_driver = {
 	.id_table = razer_devices,
 	.input_mapping = razer_input_mapping,
 	.probe = razer_probe,
+	.remove = razer_remove,
 };
 module_hid_driver(razer_driver);
 
diff --git a/drivers/hid/hid-razer.h b/drivers/hid/hid-razer.h
new file mode 100644
index 0000000000..d8214ca54b
--- /dev/null
+++ b/drivers/hid/hid-razer.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HID_RAZER_H
+#define __HID_RAZER_H
+struct hid_razer {
+	unsigned int report_count;
+};
+#endif
-- 
2.39.2

