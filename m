Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E756402E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiLBJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiLBJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:05:31 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB525CC;
        Fri,  2 Dec 2022 01:05:30 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NNn8n16BMz5BNS0;
        Fri,  2 Dec 2022 17:05:29 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B295Avb031743;
        Fri, 2 Dec 2022 17:05:10 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 17:05:12 +0800 (CST)
Date:   Fri, 2 Dec 2022 17:05:12 +0800 (CST)
X-Zmail-TransId: 2af96389bfc805f2c885
X-Mailer: Zmail v1.0
Message-ID: <202212021705128095546@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <hdegoede@redhat.com>
Cc:     <justin.ernst@hpe.com>, <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwbGF0Zm9ybS94ODY6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B295Avb031743
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6389BFD9.001 by FangMail milter!
X-FangMail-Envelope: 1669971929/4NNn8n16BMz5BNS0/6389BFD9.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6389BFD9.001/4NNn8n16BMz5BNS0
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
 drivers/platform/x86/uv_sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 625b0b79d185..73fc38ee7430 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -119,12 +119,12 @@ struct uv_hub {

 static ssize_t hub_name_show(struct uv_bios_hub_info *hub_info, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", hub_info->name);
+	return sysfs_emit(buf, "%s\n", hub_info->name);
 }

 static ssize_t hub_location_show(struct uv_bios_hub_info *hub_info, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", hub_info->location);
+	return sysfs_emit(buf, "%s\n", hub_info->location);
 }

 static ssize_t hub_partition_show(struct uv_bios_hub_info *hub_info, char *buf)
@@ -460,12 +460,12 @@ struct uv_pci_top_obj {

 static ssize_t uv_pci_type_show(struct uv_pci_top_obj *top_obj, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->type);
+	return sysfs_emit(buf, "%s\n", top_obj->type);
 }

 static ssize_t uv_pci_location_show(struct uv_pci_top_obj *top_obj, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->location);
+	return sysfs_emit(buf, "%s\n", top_obj->location);
 }

 static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)
@@ -475,7 +475,7 @@ static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)

 static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", top_obj->ppb_addr);
+	return sysfs_emit(buf, "%s\n", top_obj->ppb_addr);
 }

 static ssize_t uv_pci_slot_show(struct uv_pci_top_obj *top_obj, char *buf)
@@ -737,7 +737,7 @@ static ssize_t coherence_id_show(struct kobject *kobj,
 static ssize_t uv_type_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", uv_type_string());
+	return sysfs_emit(buf, "%s\n", uv_type_string());
 }

 static ssize_t uv_archtype_show(struct kobject *kobj,
@@ -749,13 +749,13 @@ static ssize_t uv_archtype_show(struct kobject *kobj,
 static ssize_t uv_hub_type_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_hub_type());
+	return sysfs_emit(buf, "0x%x\n", uv_hub_type());
 }

 static ssize_t uv_hubless_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", uv_get_hubless_system());
+	return sysfs_emit(buf, "0x%x\n", uv_get_hubless_system());
 }

 static struct kobj_attribute partition_id_attr =
-- 
2.25.1
