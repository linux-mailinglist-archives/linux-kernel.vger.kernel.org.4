Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DAD640337
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiLBJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiLBJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:23:21 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E57C7D29;
        Fri,  2 Dec 2022 01:22:09 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NNnWz5v70z8RTZL;
        Fri,  2 Dec 2022 17:22:07 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B29LqdK063118;
        Fri, 2 Dec 2022 17:21:52 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 17:21:54 +0800 (CST)
Date:   Fri, 2 Dec 2022 17:21:54 +0800 (CST)
X-Zmail-TransId: 2af96389c3b25295ad21
X-Mailer: Zmail v1.0
Message-ID: <202212021721543696124@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <hdegoede@redhat.com>
Cc:     <markgross@kernel.org>, <pobrn@protonmail.com>,
        <dell.client.kernel@dell.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwbGF0Zm9ybS94ODY6IGRlbGw6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZsKgc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B29LqdK063118
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6389C3BF.002 by FangMail milter!
X-FangMail-Envelope: 1669972927/4NNnWz5v70z8RTZL/6389C3BF.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6389C3BF.002/4NNnWz5v70z8RTZL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/platform/x86/dell/alienware-wmi.c | 41 +++++++++--------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index a34e07ef2c79..a9477e5432e4 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -398,10 +398,10 @@ static ssize_t show_control_state(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	if (lighting_control_state == LEGACY_BOOTING)
-		return scnprintf(buf, PAGE_SIZE, "[booting] running suspend\n");
+		return sysfs_emit(buf, "[booting] running suspend\n");
 	else if (lighting_control_state == LEGACY_SUSPEND)
-		return scnprintf(buf, PAGE_SIZE, "booting running [suspend]\n");
-	return scnprintf(buf, PAGE_SIZE, "booting [running] suspend\n");
+		return sysfs_emit(buf, "booting running [suspend]\n");
+	return sysfs_emit(buf, "booting [running] suspend\n");
 }

 static ssize_t store_control_state(struct device *dev,
@@ -547,14 +547,12 @@ static ssize_t show_hdmi_cable(struct device *dev,
 				   (u32 *) &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
-			return scnprintf(buf, PAGE_SIZE,
-					 "[unconnected] connected unknown\n");
+			return sysfs_emit(buf, "[unconnected] connected unknown\n");
 		else if (out_data == 1)
-			return scnprintf(buf, PAGE_SIZE,
-					 "unconnected [connected] unknown\n");
+			return sysfs_emit(buf, "unconnected [connected] unknown\n");
 	}
 	pr_err("alienware-wmi: unknown HDMI cable status: %d\n", status);
-	return scnprintf(buf, PAGE_SIZE, "unconnected connected [unknown]\n");
+	return sysfs_emit(buf, "unconnected connected [unknown]\n");
 }

 static ssize_t show_hdmi_source(struct device *dev,
@@ -571,14 +569,12 @@ static ssize_t show_hdmi_source(struct device *dev,

 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
-			return scnprintf(buf, PAGE_SIZE,
-					 "[input] gpu unknown\n");
+			return sysfs_emit(buf, "[input] gpu unknown\n");
 		else if (out_data == 2)
-			return scnprintf(buf, PAGE_SIZE,
-					 "input [gpu] unknown\n");
+			return sysfs_emit(buf, "input [gpu] unknown\n");
 	}
 	pr_err("alienware-wmi: unknown HDMI source status: %u\n", status);
-	return scnprintf(buf, PAGE_SIZE, "input gpu [unknown]\n");
+	return sysfs_emit(buf, "input gpu [unknown]\n");
 }

 static ssize_t toggle_hdmi_source(struct device *dev,
@@ -652,14 +648,12 @@ static ssize_t show_amplifier_status(struct device *dev,
 				   (u32 *) &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
-			return scnprintf(buf, PAGE_SIZE,
-					 "[unconnected] connected unknown\n");
+			return sysfs_emit(buf, "[unconnected] connected unknown\n");
 		else if (out_data == 1)
-			return scnprintf(buf, PAGE_SIZE,
-					 "unconnected [connected] unknown\n");
+			return sysfs_emit(buf, "unconnected [connected] unknown\n");
 	}
 	pr_err("alienware-wmi: unknown amplifier cable status: %d\n", status);
-	return scnprintf(buf, PAGE_SIZE, "unconnected connected [unknown]\n");
+	return sysfs_emit(buf, "unconnected connected [unknown]\n");
 }

 static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
@@ -706,17 +700,14 @@ static ssize_t show_deepsleep_status(struct device *dev,
 					(u32 *) &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
-			return scnprintf(buf, PAGE_SIZE,
-					 "[disabled] s5 s5_s4\n");
+			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
 		else if (out_data == 1)
-			return scnprintf(buf, PAGE_SIZE,
-					 "disabled [s5] s5_s4\n");
+			return sysfs_emit(buf, "disabled [s5] s5_s4\n");
 		else if (out_data == 2)
-			return scnprintf(buf, PAGE_SIZE,
-					 "disabled s5 [s5_s4]\n");
+			return sysfs_emit(buf, "disabled s5 [s5_s4]\n");
 	}
 	pr_err("alienware-wmi: unknown deep sleep status: %d\n", status);
-	return scnprintf(buf, PAGE_SIZE, "disabled s5 s5_s4 [unknown]\n");
+	return sysfs_emit(buf, "disabled s5 s5_s4 [unknown]\n");
 }

 static ssize_t toggle_deepsleep(struct device *dev,
-- 
2.25.1
