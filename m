Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1D62282F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiKIKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKIKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:15:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71D01B9DF;
        Wed,  9 Nov 2022 02:15:50 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p12so11162639plq.4;
        Wed, 09 Nov 2022 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4JRYwmPJ/yKuT/Y3842oeLN+ENdwd9hsXDVOH46R6Y=;
        b=Pw/dudX+YhsZOYMv/a/ukf9SxOLho8UskZ5uwBTffvoZwf7FDwhHpXPApdV1wPgKST
         lzS1ot5YfaZnHxpGPP+noPlFgmke8LsA0sYX6ZhMT/DY6F5JgPe/ojtcJAXsyaDfLngu
         ZOHEf5atgwBf9qwuXJCJ5WTOfTi8i01qygvsRCcFquJEu5HHxncZDdaFz2r9ahC3CVOI
         +AwzoHpZ7XbihbKY6fjYXVfYw31GCkhDR9Wdwnkffs7MNEgaI5O83XNqGbJa0HeCG1Ek
         z1xsD/rv+CZVHy2f8zLKkvJxgRxL1YHPAn9VkEqPr32gwvigueqaQHtVsXwGnpNxyTRA
         abkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4JRYwmPJ/yKuT/Y3842oeLN+ENdwd9hsXDVOH46R6Y=;
        b=PSwJfCwJ2jC836xI/NiXTbBS508U+eaZ+Qdu9O7ri7QnUhRsefyHCootSz0ezHGE8F
         ycu7yyOn89MjJeGdvClNSR/81aaBDlWCey9/U7NWq7uhL4OtllKef6ZiPsZQ2/HOTGsp
         8NMQeywvrYmoDQ56kR+CZp1lqxdk7m28XBDdTyAJlTD2oWOimQv1r6iNJIhevX7ClRRY
         r04OiZ5grNZTZaU/UHjz9VblpJI//+slvsKz2h8rt9UlX61MxczrFgVCbjfow1UbyS6U
         Ps/Anxs8lKSOLaveE9oelcRMdQrpLpiJgHKfo7+mgiDXKWbHtkCN70CvyCTlv2U8a10X
         sS6g==
X-Gm-Message-State: ACrzQf3K41SodpQU+jPBcVWsLf15F1N1LGcxYDaytN/g69pXpC5XPxcY
        IPy8Y7vttIAXiTf6IWR52L4=
X-Google-Smtp-Source: AMsMyM6OleZvmwdmKLJ+vNHk7njo0Syu+gro9Ox1M22l9VatXGA4WEUq9cn4AIbpediKMqDqEm7COA==
X-Received: by 2002:a17:903:50b:b0:187:11e:5f1f with SMTP id jn11-20020a170903050b00b00187011e5f1fmr61540928plb.41.1667988950258;
        Wed, 09 Nov 2022 02:15:50 -0800 (PST)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b00180a7ff78ccsm8683746plg.126.2022.11.09.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:15:49 -0800 (PST)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, zhangxuezhi1@coolpad.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla4xxx: convert sysfs snprintf to sysfs_emit
Date:   Wed,  9 Nov 2022 18:15:41 +0800
Message-Id: <20221109101541.1083350-1-zhangxuezhi3@gmail.com>
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
when formatting the value to be returned to user space

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/qla4xxx/ql4_attr.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_attr.c b/drivers/scsi/qla4xxx/ql4_attr.c
index abfa6ef60480..773b8dbe1121 100644
--- a/drivers/scsi/qla4xxx/ql4_attr.c
+++ b/drivers/scsi/qla4xxx/ql4_attr.c
@@ -156,11 +156,11 @@ qla4xxx_fw_version_show(struct device *dev,
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
 	if (is_qla80XX(ha))
-		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
+		return sysfs_emit(buf, "%d.%02d.%02d (%x)\n",
 				ha->fw_info.fw_major, ha->fw_info.fw_minor,
 				ha->fw_info.fw_patch, ha->fw_info.fw_build);
 	else
-		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
+		return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
 				ha->fw_info.fw_major, ha->fw_info.fw_minor,
 				ha->fw_info.fw_patch, ha->fw_info.fw_build);
 }
@@ -170,7 +170,7 @@ qla4xxx_serial_num_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->serial_number);
+	return sysfs_emit(buf, "%s\n", ha->serial_number);
 }
 
 static ssize_t
@@ -178,7 +178,7 @@ qla4xxx_iscsi_version_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%d.%02d\n", ha->fw_info.iscsi_major,
+	return sysfs_emit(buf, "%d.%02d\n", ha->fw_info.iscsi_major,
 			ha->fw_info.iscsi_minor);
 }
 
@@ -187,7 +187,7 @@ qla4xxx_optrom_version_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
 			ha->fw_info.bootload_major, ha->fw_info.bootload_minor,
 			ha->fw_info.bootload_patch, ha->fw_info.bootload_build);
 }
@@ -197,7 +197,7 @@ qla4xxx_board_id_show(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "0x%08X\n", ha->board_id);
+	return sysfs_emit(buf, "0x%08X\n", ha->board_id);
 }
 
 static ssize_t
@@ -207,7 +207,7 @@ qla4xxx_fw_state_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
 	qla4xxx_get_firmware_state(ha);
-	return snprintf(buf, PAGE_SIZE, "0x%08X%8X\n", ha->firmware_state,
+	return sysfs_emit(buf, "0x%08X%8X\n", ha->firmware_state,
 			ha->addl_fw_state);
 }
 
@@ -220,7 +220,7 @@ qla4xxx_phy_port_cnt_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_cnt);
+	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_cnt);
 }
 
 static ssize_t
@@ -232,7 +232,7 @@ qla4xxx_phy_port_num_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_num);
+	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_num);
 }
 
 static ssize_t
@@ -244,7 +244,7 @@ qla4xxx_iscsi_func_cnt_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->iscsi_pci_func_cnt);
+	return sysfs_emit(buf, "0x%04X\n", ha->iscsi_pci_func_cnt);
 }
 
 static ssize_t
@@ -253,7 +253,7 @@ qla4xxx_hba_model_show(struct device *dev, struct device_attribute *attr,
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->model_name);
+	return sysfs_emit(buf, "%s\n", ha->model_name);
 }
 
 static ssize_t
@@ -261,7 +261,7 @@ qla4xxx_fw_timestamp_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s %s\n", ha->fw_info.fw_build_date,
+	return sysfs_emit(buf, "%s %s\n", ha->fw_info.fw_build_date,
 			ha->fw_info.fw_build_time);
 }
 
@@ -270,7 +270,7 @@ qla4xxx_fw_build_user_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.fw_build_user);
+	return sysfs_emit(buf, "%s\n", ha->fw_info.fw_build_user);
 }
 
 static ssize_t
@@ -278,7 +278,7 @@ qla4xxx_fw_ext_timestamp_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.extended_timestamp);
+	return sysfs_emit(buf, "%s\n", ha->fw_info.extended_timestamp);
 }
 
 static ssize_t
@@ -300,7 +300,7 @@ qla4xxx_fw_load_src_show(struct device *dev, struct device_attribute *attr,
 		break;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", load_src);
+	return sysfs_emit(buf, "%s\n", load_src);
 }
 
 static ssize_t
@@ -309,7 +309,7 @@ qla4xxx_fw_uptime_show(struct device *dev, struct device_attribute *attr,
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 	qla4xxx_about_firmware(ha);
-	return snprintf(buf, PAGE_SIZE, "%u.%u secs\n", ha->fw_uptime_secs,
+	return sysfs_emit(buf, "%u.%u secs\n", ha->fw_uptime_secs,
 			ha->fw_uptime_msecs);
 }
 
-- 
2.25.1

