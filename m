Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DBA6402BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiLBI6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiLBI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:57:17 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E46C4604
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:56:16 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NNmy71JNcz501Qn;
        Fri,  2 Dec 2022 16:56:15 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B28u1JC018322;
        Fri, 2 Dec 2022 16:56:02 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 16:56:04 +0800 (CST)
Date:   Fri, 2 Dec 2022 16:56:04 +0800 (CST)
X-Zmail-TransId: 2af96389bda4ffffffffd68155a6
X-Mailer: Zmail v1.0
Message-ID: <202212021656040995199@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <bleung@chromium.org>
Cc:     <groeck@chromium.org>, <chrome-platform@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwbGF0Zm9ybS9jaHJvbWU6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B28u1JC018322
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6389BDAF.000 by FangMail milter!
X-FangMail-Envelope: 1669971375/4NNmy71JNcz501Qn/6389BDAF.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6389BDAF.000/4NNmy71JNcz501Qn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/platform/chrome/cros_ec_lightbar.c | 14 ++++++--------
 drivers/platform/chrome/cros_ec_sysfs.c    |  4 ++--
 drivers/platform/chrome/wilco_ec/sysfs.c   |  3 +--
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 1674105decfb..376425bbd8ff 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -34,7 +34,7 @@ static ssize_t interval_msec_show(struct device *dev,
 {
 	unsigned long msec = lb_interval_jiffies * 1000 / HZ;

-	return scnprintf(buf, PAGE_SIZE, "%lu\n", msec);
+	return sysfs_emit(buf, "%lu\n", msec);
 }

 static ssize_t interval_msec_store(struct device *dev,
@@ -169,7 +169,7 @@ static ssize_t version_show(struct device *dev,
 	if (!get_lightbar_version(ec, &version, &flags))
 		return -EIO;

-	return scnprintf(buf, PAGE_SIZE, "%d %d\n", version, flags);
+	return sysfs_emit(buf, "%d %d\n", version, flags);
 }

 static ssize_t brightness_store(struct device *dev,
@@ -302,17 +302,15 @@ static ssize_t sequence_show(struct device *dev,

 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
-		ret = scnprintf(buf, PAGE_SIZE, "XFER / EC ERROR %d / %d\n",
-				ret, msg->result);
+		ret = sysfs_emit(buf, "XFER / EC ERROR %d / %d\n", ret, msg->result);
 		goto exit;
 	}

 	resp = (struct ec_response_lightbar *)msg->data;
 	if (resp->get_seq.num >= ARRAY_SIZE(seqname))
-		ret = scnprintf(buf, PAGE_SIZE, "%d\n", resp->get_seq.num);
+		ret = sysfs_emit(buf, "%d\n", resp->get_seq.num);
 	else
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n",
-				seqname[resp->get_seq.num]);
+		ret = sysfs_emit(buf, "%s\n", seqname[resp->get_seq.num]);

 exit:
 	kfree(msg);
@@ -483,7 +481,7 @@ static ssize_t userspace_control_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", userspace_control);
+	return sysfs_emit(buf, "%d\n", userspace_control);
 }

 static ssize_t userspace_control_store(struct device *dev,
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f07eabcf9494..e45e57cee3a8 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -227,7 +227,7 @@ static ssize_t flashinfo_show(struct device *dev,

 	resp = (struct ec_response_flash_info *)msg->data;

-	ret = scnprintf(buf, PAGE_SIZE,
+	ret = sysfs_emit(buf,
 			"FlashSize %d\nWriteSize %d\n"
 			"EraseSize %d\nProtectSize %d\n",
 			resp->flash_size, resp->write_block_size,
@@ -264,7 +264,7 @@ static ssize_t kb_wake_angle_show(struct device *dev,
 		goto exit;

 	resp = (struct ec_response_motion_sense *)msg->data;
-	ret = scnprintf(buf, PAGE_SIZE, "%d\n", resp->kb_wake_angle.ret);
+	ret = sysfs_emit(buf, "%d\n", resp->kb_wake_angle.ret);
 exit:
 	kfree(msg);
 	return ret;
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 79a5e8fa680f..893c59dde32a 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -119,8 +119,7 @@ static ssize_t get_info(struct device *dev, char *buf, enum get_ec_info_op op)
 	if (ret < 0)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%.*s\n", (int)sizeof(resp.value),
-			 (char *)&resp.value);
+	return sysfs_emit(buf, "%.*s\n", (int)sizeof(resp.value), (char *)&resp.value);
 }

 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
-- 
2.25.1
