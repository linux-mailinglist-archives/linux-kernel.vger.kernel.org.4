Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC068655358
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiLWRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLWRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:53:04 -0500
X-Greylist: delayed 169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Dec 2022 09:53:03 PST
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874413D16;
        Fri, 23 Dec 2022 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671817975; bh=vic0AKsJwRQB5l4OjER1p+febXfqn7JDFSD0OPmAFL0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=aYGw+ohRTozbpJf4Zqv7qZLzF2LfJXIsULJeAwvOlWJsECw+G1Wj7ak8io6NdrFD4
         /dBlk3AMMJmwM/CILoXTGn5JNJf+NNWZiKhN8BUorDY5uem5rkybOnNDVq97+FQZU3
         cXixDDugS8NKKjni6aLf59BAzO0sMBRzIAfa0Nb8=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 18:52:55 +0100 (CET)
X-EA-Auth: +8N21lyApftGT6DNzN3hcEBdXdk1JiW/qk9Iw6HjijP+lHSWgf8kECEJnufHGTjQ6UgP1Aptkv5THegbpFTf8qF4I/nSv5ym
Date:   Fri, 23 Dec 2022 23:22:51 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] scsi: arcmsr: Use sysfs_emit in show function callsbacks
Message-ID: <Y6Xq8480vxO1JKRh@qemulion>
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
 drivers/scsi/arcmsr/arcmsr_attr.c | 44 ++++++++++---------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
index baeb5e795690..feec18222f8c 100644
--- a/drivers/scsi/arcmsr/arcmsr_attr.c
+++ b/drivers/scsi/arcmsr/arcmsr_attr.c
@@ -258,9 +258,7 @@ static ssize_t
 arcmsr_attr_host_driver_version(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			ARCMSR_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", ARCMSR_DRIVER_VERSION);
 }

 static ssize_t
@@ -270,9 +268,8 @@ arcmsr_attr_host_driver_posted_cmd(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			atomic_read(&acb->ccboutstandingcount));
+
+	return sysfs_emit(buf, "%4d\n", atomic_read(&acb->ccboutstandingcount));
 }

 static ssize_t
@@ -282,9 +279,8 @@ arcmsr_attr_host_driver_reset(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_resets);
+
+	return sysfs_emit(buf, "%4d\n", acb->num_resets);
 }

 static ssize_t
@@ -294,9 +290,8 @@ arcmsr_attr_host_driver_abort(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->num_aborts);
+
+	return sysfs_emit(buf, "%4d\n", acb->num_aborts);
 }

 static ssize_t
@@ -306,9 +301,8 @@ arcmsr_attr_host_fw_model(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;
-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_model);
+
+	return sysfs_emit(buf, "%s\n", acb->firm_model);
 }

 static ssize_t
@@ -319,9 +313,7 @@ arcmsr_attr_host_fw_version(struct device *dev,
 	struct AdapterControlBlock *acb =
 			(struct AdapterControlBlock *) host->hostdata;

-	return snprintf(buf, PAGE_SIZE,
-			"%s\n",
-			acb->firm_version);
+	return sysfs_emit(buf, "%s\n", acb->firm_version);
 }

 static ssize_t
@@ -332,9 +324,7 @@ arcmsr_attr_host_fw_request_len(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;

-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_request_len);
+	return sysfs_emit(buf, "%4d\n", acb->firm_request_len);
 }

 static ssize_t
@@ -345,9 +335,7 @@ arcmsr_attr_host_fw_numbers_queue(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;

-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_numbers_queue);
+	return sysfs_emit(buf, "%4d\n", acb->firm_numbers_queue);
 }

 static ssize_t
@@ -358,9 +346,7 @@ arcmsr_attr_host_fw_sdram_size(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;

-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_sdram_size);
+	return sysfs_emit(buf, "%4d\n", acb->firm_sdram_size);
 }

 static ssize_t
@@ -371,9 +357,7 @@ arcmsr_attr_host_fw_hd_channels(struct device *dev,
 	struct AdapterControlBlock *acb =
 		(struct AdapterControlBlock *) host->hostdata;

-	return snprintf(buf, PAGE_SIZE,
-			"%4d\n",
-			acb->firm_hd_channels);
+	return sysfs_emit(buf, "%4d\n", acb->firm_hd_channels);
 }

 static DEVICE_ATTR(host_driver_version, S_IRUGO, arcmsr_attr_host_driver_version, NULL);
--
2.34.1



