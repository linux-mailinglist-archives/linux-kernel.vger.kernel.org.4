Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8428655CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLYIoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 03:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 03:44:14 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F7FDF;
        Sun, 25 Dec 2022 00:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671957848; bh=AMAL+pQujTNRvofLMFa9MGgUi+tA4aWwIHE47oA9prE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=PxSVgo0h3Xzy4ccwggXXlLG/nwyR2YVIm8kAQH/IdgXHat1GTBNGr9l3vUszgGHzX
         etU0my3OO/7FnLhHz2miierbRNHjd17yWwJ7BX+1keKJW8CuzkaTXKcJl5s9eSeaGQ
         T3b7mfu9mPvPnd0aUrquoiVwJIyA2KYMkcDKOMuw=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 25 Dec 2022 09:44:08 +0100 (CET)
X-EA-Auth: vHquZMvShtGA9OOi8DYdIs5bFVmiLvpnxf7YEH5FgtlCrcHcoWP3KtKhvYtISKOSdmU+xTPk74IbmnCXAa6WRuvZ+BrfpVoQ
Date:   Sun, 25 Dec 2022 14:14:03 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: message: fusion: Use sysfs_emit in show function
 callsbacks
Message-ID: <Y6gNU9DM26htGbUQ@qemulion>
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
Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/message/fusion/mptscsih.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 276084ed04a6..9ccefeb11661 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -3046,7 +3046,7 @@ mptscsih_version_fw_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
 	    (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
 	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -3062,7 +3062,7 @@ mptscsih_version_bios_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+	return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 	    (ioc->biosVersion & 0xFF000000) >> 24,
 	    (ioc->biosVersion & 0x00FF0000) >> 16,
 	    (ioc->biosVersion & 0x0000FF00) >> 8,
@@ -3078,7 +3078,7 @@ mptscsih_version_mpi_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%03x\n", ioc->facts.MsgVersion);
+	return sysfs_emit(buf, "%03x\n", ioc->facts.MsgVersion);
 }
 static DEVICE_ATTR(version_mpi, S_IRUGO, mptscsih_version_mpi_show, NULL);

@@ -3091,7 +3091,7 @@ char *buf)
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->prod_name);
+	return sysfs_emit(buf, "%s\n", ioc->prod_name);
 }
 static DEVICE_ATTR(version_product, S_IRUGO,
     mptscsih_version_product_show, NULL);
@@ -3105,7 +3105,7 @@ mptscsih_version_nvdata_persistent_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%02xh\n",
+	return sysfs_emit(buf, "%02xh\n",
 	    ioc->nvdata_version_persistent);
 }
 static DEVICE_ATTR(version_nvdata_persistent, S_IRUGO,
@@ -3119,7 +3119,7 @@ mptscsih_version_nvdata_default_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%02xh\n",ioc->nvdata_version_default);
+	return sysfs_emit(buf, "%02xh\n", ioc->nvdata_version_default);
 }
 static DEVICE_ATTR(version_nvdata_default, S_IRUGO,
     mptscsih_version_nvdata_default_show, NULL);
@@ -3132,7 +3132,7 @@ mptscsih_board_name_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_name);
+	return sysfs_emit(buf, "%s\n", ioc->board_name);
 }
 static DEVICE_ATTR(board_name, S_IRUGO, mptscsih_board_name_show, NULL);

@@ -3144,7 +3144,7 @@ mptscsih_board_assembly_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_assembly);
+	return sysfs_emit(buf, "%s\n", ioc->board_assembly);
 }
 static DEVICE_ATTR(board_assembly, S_IRUGO,
     mptscsih_board_assembly_show, NULL);
@@ -3157,7 +3157,7 @@ mptscsih_board_tracer_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_tracer);
+	return sysfs_emit(buf, "%s\n", ioc->board_tracer);
 }
 static DEVICE_ATTR(board_tracer, S_IRUGO,
     mptscsih_board_tracer_show, NULL);
@@ -3170,7 +3170,7 @@ mptscsih_io_delay_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR(io_delay, S_IRUGO,
     mptscsih_io_delay_show, NULL);
@@ -3183,7 +3183,7 @@ mptscsih_device_delay_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR(device_delay, S_IRUGO,
     mptscsih_device_delay_show, NULL);
@@ -3196,7 +3196,7 @@ mptscsih_debug_level_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;

-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->debug_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->debug_level);
 }
 static ssize_t
 mptscsih_debug_level_store(struct device *dev, struct device_attribute *attr,
--
2.34.1



