Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D786D6553DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiLWTe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiLWTeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:34:25 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7F1F9E6;
        Fri, 23 Dec 2022 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671823994; bh=WO06F4+3LP+PUS7vNlhJpQqJsk7T8QkJB749mQn/WnA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=IFyt1uTY+qT7XW9kPNJzWSXVrmOQNgSWmwHi1AzIi8X56iP+bgALulyAaKt+OQBDL
         L3N1JCRV9rHAixgvlRm0FhqkTqzJBh4eJedH00Y27XdrHs09CKacAvThcoWSUrgPsK
         Fq9Yd2UM8qF5+r98V4QmbXUTASd6DSVJJosvFUrA=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 20:33:14 +0100 (CET)
X-EA-Auth: tYf7JlHV5yJoXQVqHEb8JXftfLRxMz/Bd0h2loUWHyS4uY67PTszEL7O2O+kd3l5uZ1DlSw/x0zHZyD+UcxbPUmDaKJy+Q7/
Date:   Sat, 24 Dec 2022 01:03:07 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: hpsa: Use sysfs_emit in show function callsbacks
Message-ID: <Y6YCcyihZCWZH9dj@qemulion>
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
 drivers/scsi/hpsa.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 4dbf51e2623a..1fc359cd05f3 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -525,8 +525,7 @@ static ssize_t host_show_firmware_revision(struct device *dev,
 	if (!h->hba_inquiry_data)
 		return 0;
 	fwrev = &h->hba_inquiry_data[32];
-	return snprintf(buf, 20, "%c%c%c%c\n",
-		fwrev[0], fwrev[1], fwrev[2], fwrev[3]);
+	return sysfs_emit(buf, "%c%c%c%c\n", fwrev[0], fwrev[1], fwrev[2], fwrev[3]);
 }

 static ssize_t host_show_commands_outstanding(struct device *dev,
@@ -535,8 +534,7 @@ static ssize_t host_show_commands_outstanding(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ctlr_info *h = shost_to_hba(shost);

-	return snprintf(buf, 20, "%d\n",
-			atomic_read(&h->commands_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&h->commands_outstanding));
 }

 static ssize_t host_show_transport_mode(struct device *dev,
@@ -546,7 +544,7 @@ static ssize_t host_show_transport_mode(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 		h->transMethod & CFGTBL_Trans_Performant ?
 			"performant" : "simple");
 }
@@ -558,7 +556,7 @@ static ssize_t host_show_hp_ssd_smart_path_status(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	h = shost_to_hba(shost);
-	return snprintf(buf, 30, "HP SSD Smart Path %s\n",
+	return sysfs_emit(buf, "HP SSD Smart Path %s\n",
 		(h->acciopath_status == 1) ?  "enabled" : "disabled");
 }

@@ -642,7 +640,7 @@ static ssize_t host_show_resettable(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", ctlr_is_resettable(h->board_id));
+	return sysfs_emit(buf, "%d\n", ctlr_is_resettable(h->board_id));
 }

 static inline int is_logical_dev_addr_mode(unsigned char scsi3addr[])
@@ -721,7 +719,7 @@ static ssize_t lunid_show(struct device *dev,
 	}
 	memcpy(lunid, hdev->scsi3addr, sizeof(lunid));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 20, "0x%8phN\n", lunid);
+	return sysfs_emit(buf, "0x%8phN\n", lunid);
 }

 static ssize_t unique_id_show(struct device *dev,
@@ -743,13 +741,13 @@ static ssize_t unique_id_show(struct device *dev,
 	}
 	memcpy(sn, hdev->device_id, sizeof(sn));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 16 * 2 + 2,
-			"%02X%02X%02X%02X%02X%02X%02X%02X"
-			"%02X%02X%02X%02X%02X%02X%02X%02X\n",
-			sn[0], sn[1], sn[2], sn[3],
-			sn[4], sn[5], sn[6], sn[7],
-			sn[8], sn[9], sn[10], sn[11],
-			sn[12], sn[13], sn[14], sn[15]);
+	return sysfs_emit(buf,
+			  "%02X%02X%02X%02X%02X%02X%02X%02X"
+			  "%02X%02X%02X%02X%02X%02X%02X%02X\n",
+			  sn[0], sn[1], sn[2], sn[3],
+			  sn[4], sn[5], sn[6], sn[7],
+			  sn[8], sn[9], sn[10], sn[11],
+			  sn[12], sn[13], sn[14], sn[15]);
 }

 static ssize_t sas_address_show(struct device *dev,
@@ -772,7 +770,7 @@ static ssize_t sas_address_show(struct device *dev,
 	sas_address = hdev->sas_address;
 	spin_unlock_irqrestore(&h->lock, flags);

-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n", sas_address);
+	return sysfs_emit(buf, "0x%016llx\n", sas_address);
 }

 static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
@@ -796,10 +794,9 @@ static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
 	spin_unlock_irqrestore(&h->lock, flags);

 	if (hdev->devtype == TYPE_DISK || hdev->devtype == TYPE_ZBC)
-		return snprintf(buf, 20, "%d\n", offload_enabled);
+		return sysfs_emit(buf, "%d\n", offload_enabled);
 	else
-		return snprintf(buf, 40, "%s\n",
-				"Not applicable for a controller");
+		return sysfs_emit(buf, "%s\n", "Not applicable for a controller");
 }

 #define MAX_PATHS 8
@@ -895,7 +892,7 @@ static ssize_t host_show_ctlr_num(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", h->ctlr);
+	return sysfs_emit(buf, "%d\n", h->ctlr);
 }

 static ssize_t host_show_legacy_board(struct device *dev,
@@ -905,7 +902,7 @@ static ssize_t host_show_legacy_board(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);

 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", h->legacy_board ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", h->legacy_board ? 1 : 0);
 }

 static DEVICE_ATTR_RO(raid_level);
--
2.34.1



