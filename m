Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FF655381
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiLWSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 13:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiLWSMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 13:12:31 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF5165B4;
        Fri, 23 Dec 2022 10:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671819131; bh=7XkD7f85Pcv9AmvgSuqEDVDEKSRJ5Y36AiME/4pHDm8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=lGy+M8ORIHCGFN2bFw4JOaoA9MNcQbcrRnF3PS9aKDyhHuk4Csce+ppI39uq0trom
         /bLtRu3jiAFUnxnqj7xvU71DCk+XZBJEk/rTqbvw1Y2/sNo3V1LnRO00mwfdbJnD9b
         h86yBAg6dPYfxpPsFN3sYLm8fwX860ADzdS1EdKE=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 19:12:11 +0100 (CET)
X-EA-Auth: K7gmOTf9sTkfNN11vh2VXVy7wKkBtlQ/+3fK4W5Dc46cmvYO17OUDMyxHj/pAV+n5z71H7Yn4CLNtlUX0xTn863Qzkval56Y
Date:   Fri, 23 Dec 2022 23:42:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] scsi: myrs: Use sysfs_emit in show function callsbacks
Message-ID: <Y6XvcuFnqA8po5Ht@qemulion>
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
 drivers/scsi/myrs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 7eb8c39da366..f08b8731d6dd 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -939,7 +939,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;

 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");

 	if (sdev->channel >= cs->ctlr_info->physchan_present) {
 		struct myrs_ldev_info *ldev_info = sdev->hostdata;
@@ -1058,7 +1058,7 @@ static ssize_t raid_level_show(struct device *dev,
 	const char *name = NULL;

 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");

 	if (sdev->channel >= cs->ctlr_info->physchan_present) {
 		struct myrs_ldev_info *ldev_info;
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;

 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sysfs_emit(buf, "physical device - not rebuilding\n");

 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned short ldev_num;

 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return sysfs_emit(buf, "physical device - not checking\n");

 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1303,7 +1303,7 @@ static ssize_t serial_show(struct device *dev,

 	memcpy(serial, cs->ctlr_info->serial_number, 16);
 	serial[16] = '\0';
-	return snprintf(buf, 16, "%s\n", serial);
+	return sysfs_emit(buf, "%s\n", serial);
 }
 static DEVICE_ATTR_RO(serial);

@@ -1313,7 +1313,7 @@ static ssize_t ctlr_num_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);

-	return snprintf(buf, 20, "%d\n", cs->host->host_no);
+	return sysfs_emit(buf, "%d\n", cs->host->host_no);
 }
 static DEVICE_ATTR_RO(ctlr_num);

@@ -1388,7 +1388,7 @@ static ssize_t model_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);

-	return snprintf(buf, 28, "%s\n", cs->model_name);
+	return sysfs_emit(buf, "%s\n", cs->model_name);
 }
 static DEVICE_ATTR_RO(model);

@@ -1398,7 +1398,7 @@ static ssize_t ctlr_type_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);

-	return snprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
+	return sysfs_emit(buf, "%d\n", cs->ctlr_info->ctlr_type);
 }
 static DEVICE_ATTR_RO(ctlr_type);

@@ -1408,7 +1408,7 @@ static ssize_t cache_size_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);

-	return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+	return sysfs_emit(buf, "%d MB\n", cs->ctlr_info->cache_size_mb);
 }
 static DEVICE_ATTR_RO(cache_size);

@@ -1418,7 +1418,7 @@ static ssize_t firmware_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);

-	return snprintf(buf, 16, "%d.%02d-%02d\n",
+	return sysfs_emit(buf, "%d.%02d-%02d\n",
 			cs->ctlr_info->fw_major_version,
 			cs->ctlr_info->fw_minor_version,
 			cs->ctlr_info->fw_turn_number);
@@ -1488,7 +1488,7 @@ static ssize_t disable_enclosure_messages_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);

-	return snprintf(buf, 3, "%d\n", cs->disable_enc_msg);
+	return sysfs_emit(buf, "%d\n", cs->disable_enc_msg);
 }

 static ssize_t disable_enclosure_messages_store(struct device *dev,
--
2.34.1



