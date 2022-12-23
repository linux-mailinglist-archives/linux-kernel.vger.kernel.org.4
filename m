Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2157165535B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiLWRy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLWRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:54:55 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B613D12;
        Fri, 23 Dec 2022 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671818085; bh=5DYA8gwFgNeg74M/TvZvQ2r78nr2xzpIFOQ0YS2BNf4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=iaYl+vQTNA99MG2NEYJyhN9i0Nzx4vg+wqT5o+UKCa8pQo6XsXv+9CNUhnyIVKvbu
         XsAbp7+s2ZRYl55VnsXm9vG6219iAMdluKJvtC5SyGnJOAhyiAInSAaL51RolHxaWI
         wlDkRSkzDTJKfmIzq/cXbKIvr9oiMPopDKF8FqP4=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 18:54:45 +0100 (CET)
X-EA-Auth: g4A9ULZ5dMWqQWFYKpbIGk1ipkegi013ynAIXpmvJ6i14Vq2f5TlWuYxobcPZIJwZaZ2Uk5oubeQU1kzYzyDn6VtRzL9UISe
Date:   Fri, 23 Dec 2022 23:24:40 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] scsi: mpt3sas: Use sysfs_emit in show function callsbacks
Message-ID: <Y6XrYO35mcrOZ8mO@qemulion>
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
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 0d8b1e942ded..46ad8a434b6d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2822,7 +2822,7 @@ version_fw_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
 	    (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
 	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -2847,7 +2847,7 @@ version_bios_show(struct device *cdev, struct device_attribute *attr,

 	u32 version = le32_to_cpu(ioc->bios_pg3.BiosVersion);

-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (version & 0xFF000000) >> 24,
 	    (version & 0x00FF0000) >> 16,
 	    (version & 0x0000FF00) >> 8,
@@ -2870,7 +2870,7 @@ version_mpi_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%03x.%02x\n",
+	return sysfs_emit(buf, "%03x.%02x\n",
 	    ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
 }
 static DEVICE_ATTR_RO(version_mpi);
@@ -2890,7 +2890,7 @@ version_product_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.ChipName);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.ChipName);
 }
 static DEVICE_ATTR_RO(version_product);

@@ -2909,7 +2909,7 @@ version_nvdata_persistent_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
+	return sysfs_emit(buf, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_persistent);
@@ -2929,7 +2929,7 @@ version_nvdata_default_show(struct device *cdev, struct device_attribute
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
+	return sysfs_emit(buf, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_default);
@@ -2949,7 +2949,7 @@ board_name_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardName);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardName);
 }
 static DEVICE_ATTR_RO(board_name);

@@ -2968,7 +2968,7 @@ board_assembly_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardAssembly);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardAssembly);
 }
 static DEVICE_ATTR_RO(board_assembly);

@@ -2987,7 +2987,7 @@ board_tracer_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardTracerNumber);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardTracerNumber);
 }
 static DEVICE_ATTR_RO(board_tracer);

@@ -3009,7 +3009,7 @@ io_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR_RO(io_delay);

@@ -3031,7 +3031,7 @@ device_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR_RO(device_delay);

@@ -3052,7 +3052,7 @@ fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->facts.RequestCredit);
+	return sysfs_emit(buf, "%02d\n", ioc->facts.RequestCredit);
 }
 static DEVICE_ATTR_RO(fw_queue_depth);

@@ -3074,7 +3074,7 @@ host_sas_address_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 	    (unsigned long long)ioc->sas_hba.sas_address);
 }
 static DEVICE_ATTR_RO(host_sas_address);
@@ -3094,7 +3094,7 @@ logging_level_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->logging_level);
 }
 static ssize_t
 logging_level_store(struct device *cdev, struct device_attribute *attr,
@@ -3130,7 +3130,7 @@ fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
+	return sysfs_emit(buf, "%d\n", ioc->fwfault_debug);
 }
 static ssize_t
 fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
@@ -3167,7 +3167,7 @@ ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
+	return sysfs_emit(buf, "%d\n", ioc->ioc_reset_count);
 }
 static DEVICE_ATTR_RO(ioc_reset_count);

@@ -3195,7 +3195,7 @@ reply_queue_count_show(struct device *cdev,
 	else
 		reply_queue_count = 1;

-	return snprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
+	return sysfs_emit(buf, "%d\n", reply_queue_count);
 }
 static DEVICE_ATTR_RO(reply_queue_count);

@@ -3260,7 +3260,7 @@ BRM_status_show(struct device *cdev, struct device_attribute *attr,

 	/* BRM status is in bit zero of GPIOVal[24] */
 	backup_rail_monitor_status = le16_to_cpu(io_unit_pg3.GPIOVal[24]);
-	rc = snprintf(buf, PAGE_SIZE, "%d\n", (backup_rail_monitor_status & 1));
+	rc = sysfs_emit(buf, "%d\n", (backup_rail_monitor_status & 1));

  out:
 	mutex_unlock(&ioc->pci_access_mutex);
@@ -3317,7 +3317,7 @@ host_trace_buffer_size_show(struct device *cdev,
 		size = le32_to_cpu(request_data->Size);

 	ioc->ring_buffer_sz = size;
-	return snprintf(buf, PAGE_SIZE, "%d\n", size);
+	return sysfs_emit(buf, "%d\n", size);
 }
 static DEVICE_ATTR_RO(host_trace_buffer_size);

@@ -3404,12 +3404,12 @@ host_trace_buffer_enable_show(struct device *cdev,
 	if ((!ioc->diag_buffer[MPI2_DIAG_BUF_TYPE_TRACE]) ||
 	   ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_REGISTERED) == 0))
-		return snprintf(buf, PAGE_SIZE, "off\n");
+		return sysfs_emit(buf, "off\n");
 	else if ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_RELEASED))
-		return snprintf(buf, PAGE_SIZE, "release\n");
+		return sysfs_emit(buf, "release\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "post\n");
+		return sysfs_emit(buf, "post\n");
 }

 static ssize_t
@@ -3825,7 +3825,7 @@ drv_support_bitmap_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", ioc->drv_support_bitmap);
+	return sysfs_emit(buf, "0x%08x\n", ioc->drv_support_bitmap);
 }
 static DEVICE_ATTR_RO(drv_support_bitmap);

@@ -3845,7 +3845,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", ioc->enable_sdev_max_qd);
 }

 /**
@@ -3993,7 +3993,7 @@ sas_address_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 	    (unsigned long long)sas_device_priv_data->sas_target->sas_address);
 }
 static DEVICE_ATTR_RO(sas_address);
@@ -4015,7 +4015,7 @@ sas_device_handle_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
+	return sysfs_emit(buf, "0x%04x\n",
 	    sas_device_priv_data->sas_target->handle);
 }
 static DEVICE_ATTR_RO(sas_device_handle);
@@ -4053,7 +4053,7 @@ sas_ncq_prio_enable_show(struct device *dev,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			sas_device_priv_data->ncq_prio_enable);
 }

--
2.34.1



