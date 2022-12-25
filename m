Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8AF655CD6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiLYKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 05:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 05:18:39 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3338B5;
        Sun, 25 Dec 2022 02:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671963503; bh=VKddANfidYSZkl7mhdUiLj9w4dOBYWTjz1jmCI1ynMI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=MRQvcu3IL2zD8cij4DfSH9/IzQpmWZJEJj/9lUCCecdfz88tvfA+VrJFgi9q2paXY
         b+USkBlZ0rFyAVRULXj9lEBxlg+0IocPnw94CZXSwFzERO6ZpT0F+2XYIaterjlqyO
         3aumgzQ4nZT4JPbcElyX5QFlz37RO0B/u6WEXJjo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 25 Dec 2022 11:18:23 +0100 (CET)
X-EA-Auth: 8X9Yb/Jt7KQNXICzc/RUtRooJc4xrAVX0UPML0Ft13Dlg18UFZEObQLOEhLF7LD9mfkZTaJ6saww7zT8cF6mKnK6q8PhTMNh
Date:   Sun, 25 Dec 2022 15:48:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: aacraid: Use sysfs_emit in show function callsbacks
Message-ID: <Y6gjaqV3UvnXaVxZ@qemulion>
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
of sprintf() family functions. So, make this change.
Also, change in length of lines enables code allows to reformat code for
improved readability.
Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/aacraid/linit.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 5ba5c18b77b4..7ef31dc4cb8d 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -559,11 +559,9 @@ static ssize_t aac_show_raid_level(struct device *dev, struct device_attribute *
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct aac_dev *aac = (struct aac_dev *)(sdev->host->hostdata);
 	if (sdev_channel(sdev) != CONTAINER_CHANNEL)
-		return snprintf(buf, PAGE_SIZE, sdev->no_uld_attach
-		  ? "Hidden\n" :
+		return sysfs_emit(buf, sdev->no_uld_attach ? "Hidden\n" :
 		  ((aac->jbod && (sdev->type == TYPE_DISK)) ? "JBOD\n" : ""));
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-	  get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
+	return sysfs_emit(buf, "%s\n", get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
 }

 static struct device_attribute aac_raid_level_attr = {
@@ -586,12 +584,13 @@ static ssize_t aac_show_unique_id(struct device *dev,
 	if (sdev_channel(sdev) == CONTAINER_CHANNEL)
 		memcpy(sn, aac->fsa_dev[sdev_id(sdev)].identifier, sizeof(sn));

-	return snprintf(buf, 16 * 2 + 2,
-		"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
-		sn[0], sn[1], sn[2], sn[3],
-		sn[4], sn[5], sn[6], sn[7],
-		sn[8], sn[9], sn[10], sn[11],
-		sn[12], sn[13], sn[14], sn[15]);
+	return sysfs_emit(buf,
+			  "%02X%02X%02X%02X%02X%02X%02X%02X"
+			  "%02X%02X%02X%02X%02X%02X%02X%02X\n",
+			  sn[0], sn[1], sn[2], sn[3],
+			  sn[4], sn[5], sn[6], sn[7],
+			  sn[8], sn[9], sn[10], sn[11],
+			  sn[12], sn[13], sn[14], sn[15]);
 }

 static struct device_attribute aac_unique_id_attr = {
@@ -1297,7 +1296,7 @@ static ssize_t aac_show_driver_version(struct device *device,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", aac_driver_version);
+	return sysfs_emit(buf, "%s\n", aac_driver_version);
 }

 static ssize_t aac_show_serial_number(struct device *device,
@@ -1323,15 +1322,13 @@ static ssize_t aac_show_serial_number(struct device *device,
 static ssize_t aac_show_max_channel(struct device *device,
 				    struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	  class_to_shost(device)->max_channel);
+	return sysfs_emit(buf, "%d\n", class_to_shost(device)->max_channel);
 }

 static ssize_t aac_show_max_id(struct device *device,
 			       struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	  class_to_shost(device)->max_id);
+	return sysfs_emit(buf, "%d\n", class_to_shost(device)->max_id);
 }

 static ssize_t aac_store_reset_adapter(struct device *device,
--
2.34.1



