Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA17629761
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKOL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKOL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:28:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6731010;
        Tue, 15 Nov 2022 03:28:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h14so13050973pjv.4;
        Tue, 15 Nov 2022 03:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3o0IP0jRO/k6EuewxkJJcEod0HUZCfXHgiOkxOYiCag=;
        b=EwXpXdYmCH55f66LcK5rJS3Qrmzr6sZjvFNr4efYWyP4Ykh/W1BOLZ3/7UM2LwRsZx
         2lPQZRJWTmWsRULXVOfpEnxyUWLlHsmXwDrrx8uLxnQW8wdWZtTT6EsOqWOvxtC8Kn99
         Bk+/Yccd+SaAKHP/QQVowATqCPuUK43n4EZOpMzdgLqfrcfj3t3eoHymfd14TXHKOmB6
         X8RYMQUxJUpUdjNBDgjYzlWMMhUKIBfnG3jsAts74/Vx1wgp8/BZ/fYEnMPSUOoJfSNB
         FJtJyPTLA5dawWuJBtqo6WOrjeHBYFo3bWC+LFGtgM1UMtOENCDPSeIT3le5sZ+fp+hv
         5geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3o0IP0jRO/k6EuewxkJJcEod0HUZCfXHgiOkxOYiCag=;
        b=n2onegP1FbiIEE+Uy9t3uc6YJa1QsDrMsS8bp4d35fQnXV2GTlbUSatp9A5HYeHjts
         InxFcpJEN5sU828FvGTG2izgMWf46XQb6yuZBtSZG8roUZsAC6f5z/EJI2JRcdbKTPfJ
         QK4bN8h0GenAc0sdnI8zdWkTbESYV1BpyXRAB46NXQYM4jWWGe4EPxQaqGChU5BHVkl4
         IJ/3rV0x0fWg9hTdiDlt1QuAKHF1tI5TUxqVksJa0WpOc+d7U8BpLxEVbOoelKNg+Ykg
         doAp0QItmnBdeE/DERdGqC6Al+UvlqcfGVtTnD2IDXO2ezd1B0cjVqUVfutPqk+Fzrqu
         dW+Q==
X-Gm-Message-State: ANoB5pnRcG+HcmcMmq+EN1tYMrmkf4OpINMy0cZEdbCxAZyfgQo419/D
        d9s5AvwuYFOp14NgcwcRiF91NdMw1QI=
X-Google-Smtp-Source: AA0mqf5tODoJrAyf0JpV043CfqnPI1lrhyItE/45JfggxCVZZrt0S6dCz4CMu43Z8wP1NBU998BeYA==
X-Received: by 2002:a17:903:2d0:b0:188:7dca:6f41 with SMTP id s16-20020a17090302d000b001887dca6f41mr3580296plk.72.1668511736984;
        Tue, 15 Nov 2022 03:28:56 -0800 (PST)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ab38d00b0021806f631ccsm8127582pjr.30.2022.11.15.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:28:56 -0800 (PST)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     zhangxuezhi1@coolpad.com, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pm8001: convert sysfs snprintf to sysfs_emit
Date:   Tue, 15 Nov 2022 19:28:51 +0800
Message-Id: <20221115112851.1271409-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 38 +++++++++++++++-----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 73f036bed128..3a08ece321a8 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -61,10 +61,10 @@ static ssize_t pm8001_ctl_mpi_interface_rev_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.interface_rev);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.interface_rev);
 	}
 }
@@ -86,8 +86,7 @@ static ssize_t controller_fatal_error_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			pm8001_ha->controller_fatal_error);
+	return sysfs_emit(buf, "%d\n", pm8001_ha->controller_fatal_error);
 }
 static DEVICE_ATTR_RO(controller_fatal_error);
 
@@ -107,13 +106,13 @@ static ssize_t pm8001_ctl_fw_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 8),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev));
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 8),
@@ -138,7 +137,7 @@ static ssize_t pm8001_ctl_ila_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id != chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 8),
@@ -164,7 +163,7 @@ static ssize_t pm8001_ctl_inactive_fw_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id != chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 8),
@@ -191,10 +190,10 @@ static ssize_t pm8001_ctl_max_out_io_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_out_io);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io);
 	}
 }
@@ -215,11 +214,11 @@ static ssize_t pm8001_ctl_max_devices_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			(u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16)
 			);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			(u16)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl >> 16)
 			);
 	}
@@ -242,11 +241,11 @@ static ssize_t pm8001_ctl_max_sg_list_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF
 			);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl & 0x0000FFFF
 			);
 	}
@@ -315,7 +314,7 @@ static ssize_t pm8001_ctl_host_sas_address_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 			be64_to_cpu(*(__be64 *)pm8001_ha->sas_addr));
 }
 static DEVICE_ATTR(host_sas_address, S_IRUGO,
@@ -336,7 +335,7 @@ static ssize_t pm8001_ctl_logging_level_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", pm8001_ha->logging_level);
+	return sysfs_emit(buf, "%08xh\n", pm8001_ha->logging_level);
 }
 
 static ssize_t pm8001_ctl_logging_level_store(struct device *cdev,
@@ -517,7 +516,7 @@ static ssize_t event_log_size_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size);
 }
 static DEVICE_ATTR_RO(event_log_size);
@@ -604,8 +603,7 @@ static ssize_t non_fatal_count_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%08x",
-			pm8001_ha->non_fatal_count);
+	return sysfs_emit(buf, "%08x\n", pm8001_ha->non_fatal_count);
 }
 
 static ssize_t non_fatal_count_store(struct device *cdev,
@@ -884,7 +882,7 @@ static ssize_t pm8001_show_update_fw(struct device *cdev,
 	if (pm8001_ha->fw_status != FLASH_IN_PROGRESS)
 		pm8001_ha->fw_status = FLASH_OK;
 
-	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
+	return sysfs_emit(buf, "status=%x %s\n",
 			flash_error_table[i].err_code,
 			flash_error_table[i].reason);
 }
-- 
2.25.1

