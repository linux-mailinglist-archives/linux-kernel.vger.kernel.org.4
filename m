Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354565540A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiLWTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiLWTqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:46:01 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D23630A;
        Fri, 23 Dec 2022 11:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671824742; bh=blHvl4TwFi6Skuv7VrvkLrtt2LPWZsPhT59Ln7QToC0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=BWqqKwNT+21sNLvupwmjKXe/uMjPS7JDfTbdIDkU26N4ANxF4mQoQnGmpQtrERXoz
         RxwaUWl8Oi1wavFWAFmwp9pN2JohJbtF7PN0+9WNKANZmyINUwj1Zo4LQPOZ6PPP2f
         AgsavzcvRZmhIOf5tt5HPZyR7jAOgV0QueJlSfOs=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 20:45:42 +0100 (CET)
X-EA-Auth: Jkjzspo6MwUxQr8f8PpkqhxDaeHVHWwM9XEEMi6XVUeXbBe9SOg1BaM5HVpi4EeR6T6Fgem9bs0G5dYVjj78dqCrvScd/0rz
Date:   Sat, 24 Dec 2022 01:15:35 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: myrb: Use sysfs_emit in show function callsbacks
Message-ID: <Y6YFX3d9JP8CIzal@qemulion>
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
of sprintf family functions. Also, merge split lines wherever possible
due to shortened length of lines.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/myrb.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index e885c1dbf61f..ab7eab0dfa38 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1767,7 +1767,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;

 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");

 	if (sdev->channel == myrb_logical_channel(sdev->host)) {
 		struct myrb_ldev_info *ldev_info = sdev->hostdata;
@@ -1886,11 +1886,10 @@ static ssize_t raid_level_show(struct device *dev,

 		name = myrb_raidlevel_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
-					ldev_info->state);
-		return snprintf(buf, 32, "%s\n", name);
+			return sysfs_emit(buf, "Invalid (%02X)\n", ldev_info->state);
+		return sysfs_emit(buf, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return sysfs_emit(buf, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);

@@ -1903,17 +1902,17 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;

 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sysfs_emit(buf, "physical device - not rebuilding\n");

 	status = myrb_get_rbld_progress(cb, &rbld_buf);

 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return sysfs_emit(buf, "not rebuilding\n");

-	return snprintf(buf, 32, "rebuilding block %u of %u\n",
-			rbld_buf.ldev_size - rbld_buf.blocks_left,
-			rbld_buf.ldev_size);
+	return sysfs_emit(buf, "rebuilding block %u of %u\n",
+			  rbld_buf.ldev_size - rbld_buf.blocks_left,
+			  rbld_buf.ldev_size);
 }

 static ssize_t rebuild_store(struct device *dev,
@@ -2140,7 +2139,7 @@ static ssize_t ctlr_num_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);

-	return snprintf(buf, 20, "%u\n", cb->ctlr_num);
+	return sysfs_emit(buf, "%u\n", cb->ctlr_num);
 }
 static DEVICE_ATTR_RO(ctlr_num);

@@ -2150,7 +2149,7 @@ static ssize_t firmware_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);

-	return snprintf(buf, 16, "%s\n", cb->fw_version);
+	return sysfs_emit(buf, "%s\n", cb->fw_version);
 }
 static DEVICE_ATTR_RO(firmware);

@@ -2160,7 +2159,7 @@ static ssize_t model_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrb_hba *cb = shost_priv(shost);

-	return snprintf(buf, 16, "%s\n", cb->model_name);
+	return sysfs_emit(buf, "%s\n", cb->model_name);
 }
 static DEVICE_ATTR_RO(model);

--
2.34.1



