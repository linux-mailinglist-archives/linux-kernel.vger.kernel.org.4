Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2D972F44E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbjFNFzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbjFNFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:55:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8351BCD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:55:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgvld0gW4zBQJYc
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:55:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686722108; x=1689314109; bh=6QKQo8XFdbBHHEENs1F7DiszScD
        sWMu3i8SevNAIN9M=; b=flVdO7u0mHIYI7TU3rOXUIg4veK4B6Gd5CmujI94iqo
        F9FlP5f1eipU+pXOePTrHpZBY+YqjX3QMwtmE0kqYWebpIzIS4V6VwCVEQOIZl6Y
        RziPTcsnrpj6HLFpGBm3DvM+Nn3SJHR4trho5nZ/R+FxZauhveCHulehQQaOkyvj
        RTgdcgFM8q9aMPwdq92TGsyL9D9al/g4ecMjJYAaceTeGkECVdf0kvB5Vd5zuTuA
        TUqHPnNAFxPRH8/XPa9jLLDWwxmiMiKMPpLp6dFcgvpCi4Rrnbtfh6tlR0pClO6b
        6Plof9ry5vRV/AaoCj78Y514t5Oyitsi3c/+lJdTazw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SHYJtHdswwsN for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 13:55:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgvlc4zMZzBJLB3;
        Wed, 14 Jun 2023 13:55:08 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 13:55:08 +0800
From:   wuyonggang001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: Replacing snprintf with scnprintf
In-Reply-To: <590d5329a2f9f65e227f454412a4244b@208suo.com>
References: <20230613063833.56146-1-zhanglibing@cdjrlc.com>
 <590d5329a2f9f65e227f454412a4244b@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <29e8bcd77e2aaf44377d3c98569d575d@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/mpt3sas/mpt3sas_ctl.c:2971:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 48 +++++++++++++++---------------
  1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c 
b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index efdb8178db32..34cd15f33820 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2822,7 +2822,7 @@ version_fw_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+    return scnprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
          (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
          (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
          (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -2847,7 +2847,7 @@ version_bios_show(struct device *cdev, struct 
device_attribute *attr,

      u32 version = le32_to_cpu(ioc->bios_pg3.BiosVersion);

-    return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+    return scnprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
          (version & 0xFF000000) >> 24,
          (version & 0x00FF0000) >> 16,
          (version & 0x0000FF00) >> 8,
@@ -2870,7 +2870,7 @@ version_mpi_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%03x.%02x\n",
+    return scnprintf(buf, PAGE_SIZE, "%03x.%02x\n",
          ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
  }
  static DEVICE_ATTR_RO(version_mpi);
@@ -2890,7 +2890,7 @@ version_product_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, 16, "%s\n", ioc->manu_pg0.ChipName);
+    return scnprintf(buf, 16, "%s\n", ioc->manu_pg0.ChipName);
  }
  static DEVICE_ATTR_RO(version_product);

@@ -2909,7 +2909,7 @@ version_nvdata_persistent_show(struct device 
*cdev,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%08xh\n",
+    return scnprintf(buf, PAGE_SIZE, "%08xh\n",
          le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
  }
  static DEVICE_ATTR_RO(version_nvdata_persistent);
@@ -2929,7 +2929,7 @@ version_nvdata_default_show(struct device *cdev, 
struct device_attribute
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%08xh\n",
+    return scnprintf(buf, PAGE_SIZE, "%08xh\n",
          le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
  }
  static DEVICE_ATTR_RO(version_nvdata_default);
@@ -2949,7 +2949,7 @@ board_name_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardName);
+    return scnprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardName);
  }
  static DEVICE_ATTR_RO(board_name);

@@ -2968,7 +2968,7 @@ board_assembly_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardAssembly);
+    return scnprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardAssembly);
  }
  static DEVICE_ATTR_RO(board_assembly);

@@ -2987,7 +2987,7 @@ board_tracer_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardTracerNumber);
+    return scnprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardTracerNumber);
  }
  static DEVICE_ATTR_RO(board_tracer);

@@ -3009,7 +3009,7 @@ io_delay_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+    return scnprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
  }
  static DEVICE_ATTR_RO(io_delay);

@@ -3031,7 +3031,7 @@ device_delay_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%02d\n", 
ioc->device_missing_delay);
+    return scnprintf(buf, PAGE_SIZE, "%02d\n", 
ioc->device_missing_delay);
  }
  static DEVICE_ATTR_RO(device_delay);

@@ -3052,7 +3052,7 @@ fw_queue_depth_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%02d\n", 
ioc->facts.RequestCredit);
+    return scnprintf(buf, PAGE_SIZE, "%02d\n", 
ioc->facts.RequestCredit);
  }
  static DEVICE_ATTR_RO(fw_queue_depth);

@@ -3074,7 +3074,7 @@ host_sas_address_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+    return scnprintf(buf, PAGE_SIZE, "0x%016llx\n",
          (unsigned long long)ioc->sas_hba.sas_address);
  }
  static DEVICE_ATTR_RO(host_sas_address);
@@ -3094,7 +3094,7 @@ logging_level_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
+    return scnprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
  }
  static ssize_t
  logging_level_store(struct device *cdev, struct device_attribute *attr,
@@ -3130,7 +3130,7 @@ fwfault_debug_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
  }
  static ssize_t
  fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
@@ -3167,7 +3167,7 @@ ioc_reset_count_show(struct device *cdev, struct 
device_attribute *attr,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
  }
  static DEVICE_ATTR_RO(ioc_reset_count);

@@ -3195,7 +3195,7 @@ reply_queue_count_show(struct device *cdev,
      else
          reply_queue_count = 1;

-    return snprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
  }
  static DEVICE_ATTR_RO(reply_queue_count);

@@ -3317,7 +3317,7 @@ host_trace_buffer_size_show(struct device *cdev,
          size = le32_to_cpu(request_data->Size);

      ioc->ring_buffer_sz = size;
-    return snprintf(buf, PAGE_SIZE, "%d\n", size);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", size);
  }
  static DEVICE_ATTR_RO(host_trace_buffer_size);

@@ -3404,7 +3404,7 @@ host_trace_buffer_enable_show(struct device *cdev,
      if ((!ioc->diag_buffer[MPI2_DIAG_BUF_TYPE_TRACE]) ||
         ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
          MPT3_DIAG_BUFFER_IS_REGISTERED) == 0))
-        return snprintf(buf, PAGE_SIZE, "off\n");
+        return scnprintf(buf, PAGE_SIZE, "off\n");
      else if ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
          MPT3_DIAG_BUFFER_IS_RELEASED))
          return snprintf(buf, PAGE_SIZE, "release\n");
@@ -3825,7 +3825,7 @@ drv_support_bitmap_show(struct device *cdev,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "0x%08x\n", 
ioc->drv_support_bitmap);
+    return scnprintf(buf, PAGE_SIZE, "0x%08x\n", 
ioc->drv_support_bitmap);
  }
  static DEVICE_ATTR_RO(drv_support_bitmap);

@@ -3845,7 +3845,7 @@ enable_sdev_max_qd_show(struct device *cdev,
      struct Scsi_Host *shost = class_to_shost(cdev);
      struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);

-    return snprintf(buf, PAGE_SIZE, "%d\n", ioc->enable_sdev_max_qd);
+    return scnprintf(buf, PAGE_SIZE, "%d\n", ioc->enable_sdev_max_qd);
  }

  /**
@@ -3993,7 +3993,7 @@ sas_address_show(struct device *dev, struct 
device_attribute *attr,
      struct scsi_device *sdev = to_scsi_device(dev);
      struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-    return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+    return scnprintf(buf, PAGE_SIZE, "0x%016llx\n",
          (unsigned long 
long)sas_device_priv_data->sas_target->sas_address);
  }
  static DEVICE_ATTR_RO(sas_address);
@@ -4015,7 +4015,7 @@ sas_device_handle_show(struct device *dev, struct 
device_attribute *attr,
      struct scsi_device *sdev = to_scsi_device(dev);
      struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-    return snprintf(buf, PAGE_SIZE, "0x%04x\n",
+    return scnprintf(buf, PAGE_SIZE, "0x%04x\n",
          sas_device_priv_data->sas_target->handle);
  }
  static DEVICE_ATTR_RO(sas_device_handle);
@@ -4053,7 +4053,7 @@ sas_ncq_prio_enable_show(struct device *dev,
      struct scsi_device *sdev = to_scsi_device(dev);
      struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;

-    return snprintf(buf, PAGE_SIZE, "%d\n",
+    return scnprintf(buf, PAGE_SIZE, "%d\n",
              sas_device_priv_data->ncq_prio_enable);
  }
