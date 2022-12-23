Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B4655432
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiLWUai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWUah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:30:37 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6251CB35;
        Fri, 23 Dec 2022 12:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671827426; bh=vS/Li6+Zpr7ZVWYqMAYDUhEPOIJVm0V6qi7y4a+hgec=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=DOFTE9bh+/75w7++Fzm8CplrQvVTNgunb2xbH8+SYagFUIdYrX8+1RQs8SL+BkSyZ
         nKUH7nSwqGWjenqDvpNeDthszclzY5+Xp8KVcQ0DehP5GZYpkOn2I/mAnkej7fjbOb
         MHc0zhEYwiFIv1ZYHt/3CBDPJi3D1NFjZt1VIf4I=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 21:30:26 +0100 (CET)
X-EA-Auth: c7h24WgU1hn1i+tB6xwSDyBlqMaEz3g4uv7Rzli+8tGkg/uIxCiLw7CsxEWTL5vDC2rjihhk4WDnChAIIEcfxbpkuSeqHNv6
Date:   Sat, 24 Dec 2022 02:00:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: megaraid_sas: Use sysfs_emit in show function
 callsbacks
Message-ID: <Y6YP2sTtn30dg6pV@qemulion>
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
function of kobject attributes should strictly use sysfs_emit() instead
of sprintf() family functions. So, make this change. Also, merge split
lines wherever possible due to shortened length of lines.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3ceece988338..7fa472ab0b94 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3335,7 +3335,7 @@ fw_crash_buffer_size_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)
+	return sysfs_emit(buf, "%ld\n", (unsigned long)
 		((instance->fw_crash_buffer_size) * 1024 * 1024)/PAGE_SIZE);
 }

@@ -3382,14 +3382,14 @@ fw_crash_state_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->fw_crash_state);
+	return sysfs_emit(buf, "%d\n", instance->fw_crash_state);
 }

 static ssize_t
 page_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 1);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)PAGE_SIZE - 1);
 }

 static ssize_t
@@ -3399,7 +3399,7 @@ ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->ldio_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->ldio_outstanding));
 }

 static ssize_t
@@ -3409,7 +3409,7 @@ fw_cmds_outstanding_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->fw_outstanding));
 }

 static ssize_t
@@ -3419,7 +3419,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", instance->enable_sdev_max_qd);
 }

 static ssize_t
@@ -3473,8 +3473,7 @@ raid_map_id_show(struct device *cdev, struct device_attribute *attr,
 	struct megasas_instance *instance =
 			(struct megasas_instance *)shost->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%ld\n",
-			(unsigned long)instance->map_id);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)instance->map_id);
 }

 static DEVICE_ATTR_RW(fw_crash_buffer);
--
2.34.1



