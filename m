Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4063EF71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLAL2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLAL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:28:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F2250D70;
        Thu,  1 Dec 2022 03:28:09 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NNDMr3pKmz4xVnf;
        Thu,  1 Dec 2022 19:28:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B1BRunB071769;
        Thu, 1 Dec 2022 19:27:56 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 19:27:59 +0800 (CST)
Date:   Thu, 1 Dec 2022 19:27:59 +0800 (CST)
X-Zmail-TransId: 2af963888fbf0b577f89
X-Mailer: Zmail v1.0
Message-ID: <202212011927592559291@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <isely@pobox.com>
Cc:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZWRpYTogcHZydXNiMjogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B1BRunB071769
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63888FC8.000 by FangMail milter!
X-FangMail-Envelope: 1669894088/4NNDMr3pKmz4xVnf/63888FC8.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63888FC8.000/4NNDMr3pKmz4xVnf
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
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
index 3e42e209be37..81c8b65bd9ef 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
@@ -81,7 +81,7 @@ static ssize_t show_name(struct device *class_dev,
 	pvr2_sysfs_trace("pvr2_sysfs(%p) show_name(cid=%d) is %s",
 			 cip->chptr, cip->ctl_id, name);
 	if (!name) return -EINVAL;
-	return scnprintf(buf, PAGE_SIZE, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 static ssize_t show_type(struct device *class_dev,
@@ -102,7 +102,7 @@ static ssize_t show_type(struct device *class_dev,
 	}
 	pvr2_sysfs_trace("pvr2_sysfs(%p) show_type(cid=%d) is %s",
 			 cip->chptr, cip->ctl_id, name);
-	return scnprintf(buf, PAGE_SIZE, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 static ssize_t show_min(struct device *class_dev,
@@ -115,7 +115,7 @@ static ssize_t show_min(struct device *class_dev,
 	val = pvr2_ctrl_get_min(cip->cptr);
 	pvr2_sysfs_trace("pvr2_sysfs(%p) show_min(cid=%d) is %ld",
 			 cip->chptr, cip->ctl_id, val);
-	return scnprintf(buf, PAGE_SIZE, "%ld\n", val);
+	return sysfs_emit(buf, "%ld\n", val);
 }

 static ssize_t show_max(struct device *class_dev,
@@ -128,7 +128,7 @@ static ssize_t show_max(struct device *class_dev,
 	val = pvr2_ctrl_get_max(cip->cptr);
 	pvr2_sysfs_trace("pvr2_sysfs(%p) show_max(cid=%d) is %ld",
 			 cip->chptr, cip->ctl_id, val);
-	return scnprintf(buf, PAGE_SIZE, "%ld\n", val);
+	return sysfs_emit(buf, "%ld\n", val);
 }

 static ssize_t show_def(struct device *class_dev,
@@ -551,7 +551,7 @@ static ssize_t v4l_minor_number_show(struct device *class_dev,
 	struct pvr2_sysfs *sfp;
 	sfp = dev_get_drvdata(class_dev);
 	if (!sfp) return -EINVAL;
-	return scnprintf(buf,PAGE_SIZE,"%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 pvr2_hdw_v4l_get_minor_number(sfp->channel.hdw,
 						       pvr2_v4l_type_video));
 }
@@ -563,7 +563,7 @@ static ssize_t bus_info_show(struct device *class_dev,
 	struct pvr2_sysfs *sfp;
 	sfp = dev_get_drvdata(class_dev);
 	if (!sfp) return -EINVAL;
-	return scnprintf(buf,PAGE_SIZE,"%s\n",
+	return sysfs_emit(buf, "%s\n",
 			 pvr2_hdw_get_bus_info(sfp->channel.hdw));
 }

@@ -574,7 +574,7 @@ static ssize_t hdw_name_show(struct device *class_dev,
 	struct pvr2_sysfs *sfp;
 	sfp = dev_get_drvdata(class_dev);
 	if (!sfp) return -EINVAL;
-	return scnprintf(buf,PAGE_SIZE,"%s\n",
+	return sysfs_emit(buf, "%s\n",
 			 pvr2_hdw_get_type(sfp->channel.hdw));
 }

@@ -585,7 +585,7 @@ static ssize_t hdw_desc_show(struct device *class_dev,
 	struct pvr2_sysfs *sfp;
 	sfp = dev_get_drvdata(class_dev);
 	if (!sfp) return -EINVAL;
-	return scnprintf(buf,PAGE_SIZE,"%s\n",
+	return sysfs_emit(buf, "%s\n",
 			 pvr2_hdw_get_desc(sfp->channel.hdw));
 }

@@ -597,7 +597,7 @@ static ssize_t v4l_radio_minor_number_show(struct device *class_dev,
 	struct pvr2_sysfs *sfp;
 	sfp = dev_get_drvdata(class_dev);
 	if (!sfp) return -EINVAL;
-	return scnprintf(buf,PAGE_SIZE,"%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 pvr2_hdw_v4l_get_minor_number(sfp->channel.hdw,
 						       pvr2_v4l_type_radio));
 }
@@ -609,7 +609,7 @@ static ssize_t unit_number_show(struct device *class_dev,
 	struct pvr2_sysfs *sfp;
 	sfp = dev_get_drvdata(class_dev);
 	if (!sfp) return -EINVAL;
-	return scnprintf(buf,PAGE_SIZE,"%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 pvr2_hdw_get_unit_number(sfp->channel.hdw));
 }

-- 
2.25.1
