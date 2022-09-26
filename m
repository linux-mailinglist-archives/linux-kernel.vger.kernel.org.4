Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E85EB043
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiIZSlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIZSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:41:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6233E35;
        Mon, 26 Sep 2022 11:40:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y5so11611996wrh.3;
        Mon, 26 Sep 2022 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=9HwkT/dgvdk+/Bs2VftN0JRDOow0i0YQfPP4YBXd1P8=;
        b=WY2WSwRRvoZNaRIY6SnMIK/stfFzBKTbReHLeXAqSDPv2LJwC0ZcPdLvUZ4wGWyh+J
         uT3UGI63KJphlf8pGSU2zL+Y5/CSgOoV8UwgNbzdbjJ9DVXnKW8P3nBYY9CL8Rchkm7O
         nISPMryDIuUizq3YjZBKdf97+Fn+UWDOR0+1I3z8pMLjO5kiLT3W7Ug8U5khvxQ6qyRI
         xh3N1PdO0P/8KSe+6ADjV45Gx9nFkn5CUddqNL/I6RIuH10b9rgtcn/YRWjxbSHV1NIr
         3tmr3UjSoUjWSt1HBTGr+6HLgM3pg4I99PCgS+D7ws0VywI/CRP+C+H3Pl0WBkS4UxXK
         Yfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9HwkT/dgvdk+/Bs2VftN0JRDOow0i0YQfPP4YBXd1P8=;
        b=S3+DEYe/hBTDd0xYl1Hp8T9uA+auAoIeFTZODqcJZcHXJUBhLYLNV+GQU1dp44f/ed
         4u8vSumiUPqpxJf+Q8zgIU+efgLE+e5IymXjQCWslfDVmN3olC3/aLJ+jOM53ghSe3ac
         AM3lnlvQizPKVbHStGnnf2SnmzWLQS1bz1ps+cYvwug+qFc0+inZ9XknnnnhZQy4U6Bb
         EHNnRBLoBJc3sxWNXfGk2W1+eN+AZPrfndzeBM96bIRlNPHD0dSNCr+W+m6IK+KigzL+
         aOn/Mwik8B/wRKu85IOBn9rPXRr5+JAG1PKtUdsuYtq9AbuaEiLV/oHmsTs04Hza/5RE
         oV6g==
X-Gm-Message-State: ACrzQf3bpVvxzDI+B4TZpAPjxn7ORHGjEziuLXgzVsfLr9ZCVGO2kFIR
        gl15tby0mU3LQpqS0jWmPSlb7jz6/w==
X-Google-Smtp-Source: AMsMyM4MjB5hNdbjU2RS6KBO2Asfh8w3Z4vLm++q18Ah5zWt7sTP25Y6BpOa7HeKLnTB4lWN85SMEg==
X-Received: by 2002:adf:e7c2:0:b0:228:8733:3a6d with SMTP id e2-20020adfe7c2000000b0022887333a6dmr14108007wrn.215.1664217613644;
        Mon, 26 Sep 2022 11:40:13 -0700 (PDT)
Received: from fedora (88-106-97-87.dynamic.dsl.as9105.com. [88.106.97.87])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003b4cba4ef71sm12456802wmq.41.2022.09.26.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:40:13 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:40:11 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] scsi: Convert snprintf() to scnprintf()
Message-ID: <YzHyC191CIXZSfc5@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf
Adding to that, there has been a slow migration from snprintf to scnprintf.
This LWN article explains the rationale for this change
https: //lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length,
while scnprintf() returns the actual length.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/scsi/scsi_sysfs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 5d61f58399dc..b1bfb8af0760 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -228,7 +228,7 @@ show_shost_state(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return scnprintf(buf, 20, "%s\n", name);
 }
 
 /* DEVICE_ATTR(state) clashes with dev_attr_state for sdev */
@@ -274,7 +274,7 @@ show_shost_active_mode(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	if (shost->active_mode == MODE_UNKNOWN)
-		return snprintf(buf, 20, "unknown\n");
+		return scnprintf(buf, 20, "unknown\n");
 	else
 		return show_shost_mode(shost->active_mode, buf);
 }
@@ -324,7 +324,7 @@ show_shost_eh_deadline(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	if (shost->eh_deadline == -1)
-		return snprintf(buf, strlen("off") + 2, "off\n");
+		return scnprintf(buf, strlen("off") + 2, "off\n");
 	return sprintf(buf, "%u\n", shost->eh_deadline / HZ);
 }
 
@@ -382,7 +382,7 @@ static ssize_t
 show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
-	return snprintf(buf, 20, "%d\n", scsi_host_busy(shost));
+	return scnprintf(buf, 20, "%d\n", scsi_host_busy(shost));
 }
 static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
 
@@ -399,7 +399,7 @@ show_nr_hw_queues(struct device *dev, struct device_attribute *attr, char *buf)
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct blk_mq_tag_set *tag_set = &shost->tag_set;
 
-	return snprintf(buf, 20, "%d\n", tag_set->nr_hw_queues);
+	return scnprintf(buf, 20, "%d\n", tag_set->nr_hw_queues);
 }
 static DEVICE_ATTR(nr_hw_queues, S_IRUGO, show_nr_hw_queues, NULL);
 
@@ -692,7 +692,7 @@ sdev_show_device_busy(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", scsi_device_busy(sdev));
+	return scnprintf(buf, 20, "%d\n", scsi_device_busy(sdev));
 }
 static DEVICE_ATTR(device_busy, S_IRUGO, sdev_show_device_busy, NULL);
 
@@ -701,7 +701,7 @@ sdev_show_device_blocked(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", atomic_read(&sdev->device_blocked));
+	return scnprintf(buf, 20, "%d\n", atomic_read(&sdev->device_blocked));
 }
 static DEVICE_ATTR(device_blocked, S_IRUGO, sdev_show_device_blocked, NULL);
 
@@ -713,7 +713,7 @@ sdev_show_timeout (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%d\n", sdev->request_queue->rq_timeout / HZ);
+	return scnprintf(buf, 20, "%d\n", sdev->request_queue->rq_timeout / HZ);
 }
 
 static ssize_t
@@ -734,7 +734,7 @@ sdev_show_eh_timeout(struct device *dev, struct device_attribute *attr, char *bu
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n", sdev->eh_timeout / HZ);
+	return scnprintf(buf, 20, "%u\n", sdev->eh_timeout / HZ);
 }
 
 static ssize_t
@@ -862,7 +862,7 @@ show_state_field(struct device *dev, struct device_attribute *attr, char *buf)
 	if (!name)
 		return -EINVAL;
 
-	return snprintf(buf, 20, "%s\n", name);
+	return scnprintf(buf, 20, "%s\n", name);
 }
 
 static DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
@@ -877,7 +877,7 @@ show_queue_type_field(struct device *dev, struct device_attribute *attr,
 	if (sdev->simple_tags)
 		name = "simple";
 
-	return snprintf(buf, 20, "%s\n", name);
+	return scnprintf(buf, 20, "%s\n", name);
 }
 
 static ssize_t
@@ -957,7 +957,7 @@ static ssize_t
 show_iostat_counterbits(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
+	return scnprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
 }
 
 static DEVICE_ATTR(iocounterbits, S_IRUGO, show_iostat_counterbits, NULL);
@@ -982,7 +982,7 @@ sdev_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf (buf, 20, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
+	return scnprintf (buf, 20, SCSI_DEVICE_MODALIAS_FMT "\n", sdev->type);
 }
 static DEVICE_ATTR(modalias, S_IRUGO, sdev_show_modalias, NULL);
 
@@ -1115,7 +1115,7 @@ sdev_show_dh_state(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 
 	if (!sdev->handler)
-		return snprintf(buf, 20, "detached\n");
+		return scnprintf(buf, 20, "detached\n");
 
 	return snprintf(buf, 20, "%s\n", sdev->handler->name);
 }
@@ -1205,7 +1205,7 @@ sdev_show_queue_ramp_up_period(struct device *dev,
 {
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	return snprintf(buf, 20, "%u\n",
+	return scnprintf(buf, 20, "%u\n",
 			jiffies_to_msecs(sdev->queue_ramp_up_period));
 }
 
-- 
2.37.3

