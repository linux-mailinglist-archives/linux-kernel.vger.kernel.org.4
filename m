Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165B6553BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiLWSya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLWSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:54:27 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A14E01;
        Fri, 23 Dec 2022 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671821659; bh=af6CEPT9L/YhPRZSzPiOdEvylSMlUYMcU2N0o2CVvNM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=HMypGhOTwKeJhuSf50nQYGKVJr8aBji4h3b0fKTgmkvJQAMANhLvL2gdmQVrhY5Gb
         0Nfgb5l1Y1TTVdFGJcuJqWP+jTW9ky2sTEalJrmjxEBfSCiNvif96ZZNYPivJ9+/Ab
         RXIo+GbzuMcmb682AWVqmzg07nepP+xme9ZMR67Y=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 19:54:19 +0100 (CET)
X-EA-Auth: pT6u2iuRLMZr1nkeqFfqnWkh5q8zaU5OFzUMDggFVwRVv0K9S30ugeCQwRKXpsnyTAun9mLmmt6jOXceY/wSXBdEDGKy2sZH
Date:   Sat, 24 Dec 2022 00:24:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] scsi: core: Use sysfs_emit in show function callsbacks
Message-ID: <Y6X5VeR12W016Cef@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/filesystems/sysfs.rst, the show() callback
function of kobject attributes should strictly use sysfs_emit instead
of sprintf family functions.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/scsi_sysfs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 981d1bab2120..ad64cd8f244d 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -228,7 +228,7 @@ show_shost_state(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;

-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 /* DEVICE_ATTR(state) clashes with dev_attr_state for sdev */
@@ -274,7 +274,7 @@ show_shost_active_mode(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	if (shost->active_mode == MODE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return sysfs_emit(buf, "unknown\n");
 	else
 		return show_shost_mode(shost->active_mode, buf);
 }
@@ -324,8 +324,8 @@ show_shost_eh_deadline(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	if (shost->eh_deadline == -1)
-		return snprintf(buf, strlen("off") + 2, "off\n");
-	return sprintf(buf, "%u\n", shost->eh_deadline / HZ);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%u\n", shost->eh_deadline / HZ);
 }

 static ssize_t
@@ -382,7 +382,7 @@ static ssize_t
 show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
-	return snprintf(buf, 20, "%d\n", scsi_host_busy(shost));
+	return sysfs_emit(buf, "%d\n", scsi_host_busy(shost));
 }
 static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);

@@ -399,7 +399,7 @@ show_nr_hw_queues(struct device *dev, struct device_attribute *attr, char *buf)
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct blk_mq_tag_set *tag_set = &shost->tag_set;

-	return snprintf(buf, 20, "%d\n", tag_set->nr_hw_queues);
+	return sysfs_emit(buf, "%d\n", tag_set->nr_hw_queues);
 }
 static DEVICE_ATTR(nr_hw_queues, S_IRUGO, show_nr_hw_queues, NULL);

@@ -654,7 +654,7 @@ static int scsi_sdev_check_buf_bit(const char *buf)
 			return 1;
 		else if (buf[0] == '0')
 			return 0;
-		else
+		else
 			return -EINVAL;
 	} else
 		return -EINVAL;
@@ -674,7 +674,7 @@ sdev_show_device_busy(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", scsi_device_busy(sdev));
+	return sysfs_emit(buf, "%d\n", scsi_device_busy(sdev));
 }
 static DEVICE_ATTR(device_busy, S_IRUGO, sdev_show_device_busy, NULL);

@@ -683,7 +683,7 @@ sdev_show_device_blocked(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", atomic_read(&sdev->device_blocked));
+	return sysfs_emit(buf, "%d\n", atomic_read(&sdev->device_blocked));
 }
 static DEVICE_ATTR(device_blocked, S_IRUGO, sdev_show_device_blocked, NULL);

@@ -695,7 +695,7 @@ sdev_show_timeout (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", sdev->request_queue->rq_timeout / HZ);
+	return sysfs_emit(buf, "%d\n", sdev->request_queue->rq_timeout / HZ);
 }

 static ssize_t
@@ -716,7 +716,7 @@ sdev_show_eh_timeout(struct device *dev, struct device_attribute *attr, char *bu
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n", sdev->eh_timeout / HZ);
+	return sysfs_emit(buf, "%u\n", sdev->eh_timeout / HZ);
 }

 static ssize_t
@@ -852,7 +852,7 @@ show_state_field(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;

-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 static DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
@@ -867,7 +867,7 @@ show_queue_type_field(struct device *dev, struct device_attribute *attr,
 	if (sdev->simple_tags)
 		name = "simple";

-	return snprintf(buf, 20, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }

 static ssize_t
@@ -878,7 +878,7 @@ store_queue_type_field(struct device *dev, struct device_attribute *attr,

 	if (!sdev->tagged_supported)
 		return -EINVAL;
-
+
 	sdev_printk(KERN_INFO, sdev,
 		    "ignoring write to deprecated queue_type attribute");
 	return count;
@@ -947,7 +947,7 @@ static ssize_t
 show_iostat_counterbits(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
+	return sysfs_emit(buf, "%d\n", (int)sizeof(atomic_t) * 8);
 }

 static DEVICE_ATTR(iocounterbits, S_IRUGO, show_iostat_counterbits, NULL);
@@ -973,7 +973,7 @@ sdev_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf (buf, 20, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
+	return sysfs_emit(buf, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
 }
 static DEVICE_ATTR(modalias, S_IRUGO, sdev_show_modalias, NULL);

@@ -1106,9 +1106,9 @@ sdev_show_dh_state(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);

 	if (!sdev->handler)
-		return snprintf(buf, 20, "detached\n");
+		return sysfs_emit(buf, "detached\n");

-	return snprintf(buf, 20, "%s\n", sdev->handler->name);
+	return sysfs_emit(buf, "%s\n", sdev->handler->name);
 }

 static ssize_t
@@ -1196,7 +1196,7 @@ sdev_show_queue_ramp_up_period(struct device *dev,
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			jiffies_to_msecs(sdev->queue_ramp_up_period));
 }

--
2.34.1



