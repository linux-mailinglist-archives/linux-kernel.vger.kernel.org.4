Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7484655355
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiLWRuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiLWRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:50:15 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865761B788
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671817806; bh=8XfoPlzImUAHKNdpkCBbzwpmjauMz1KWndmkX7b/pJc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=d96PIxz9JWzFR/ua84Jnoe2EOAZwcmDCLXZFMBg9+78FbtPxczhubBLd7/dctKmVD
         MhHXntjbXqK946ZhBlTsDzpUirvXaNnEdVPubxO+gVNFauyGIHDj+HDgNhtqyghCBf
         1OvKo8WFSG34fgwppF5speuQt2Frk98crO3iOg4U=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 23 Dec 2022 18:50:06 +0100 (CET)
X-EA-Auth: DVajdD7weMqrqtua+2G6c4mEPQI9VnPTajIFbsEaPZCRlRQBoT8UVBWWhMtSxD2kyRHas2vjEUwD0jRM8pDqfWFm3IIxpU5D
Date:   Fri, 23 Dec 2022 23:20:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] scsi: aic94xx: Use sysfs_emit in show function callsbacks
Message-ID: <Y6XqSnPb/y/GMTiX@qemulion>
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
 drivers/scsi/aic94xx/aic94xx_init.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 954d0c5ae2e2..35ac5b91cb1c 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -264,8 +264,7 @@ static ssize_t asd_show_dev_rev(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			asd_dev_rev[asd_ha->revision_id]);
+	return sysfs_emit(buf, "%s\n", asd_dev_rev[asd_ha->revision_id]);
 }
 static DEVICE_ATTR(aic_revision, S_IRUGO, asd_show_dev_rev, NULL);

@@ -273,7 +272,7 @@ static ssize_t asd_show_dev_bios_build(struct device *dev,
 				       struct device_attribute *attr,char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%d\n", asd_ha->hw_prof.bios.bld);
+	return sysfs_emit(buf, "%d\n", asd_ha->hw_prof.bios.bld);
 }
 static DEVICE_ATTR(bios_build, S_IRUGO, asd_show_dev_bios_build, NULL);

@@ -281,7 +280,7 @@ static ssize_t asd_show_dev_pcba_sn(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct asd_ha_struct *asd_ha = dev_to_asd_ha(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", asd_ha->hw_prof.pcba_sn);
+	return sysfs_emit(buf, "%s\n", asd_ha->hw_prof.pcba_sn);
 }
 static DEVICE_ATTR(pcba_sn, S_IRUGO, asd_show_dev_pcba_sn, NULL);

@@ -452,7 +451,7 @@ static ssize_t asd_show_update_bios(struct device *dev,
 	if (asd_ha->bios_status != FLASH_IN_PROGRESS)
 		asd_ha->bios_status = FLASH_OK;

-	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
+	return sysfs_emit(buf, "status=%x %s\n",
 			flash_error_table[i].err_code,
 			flash_error_table[i].reason);
 }
--
2.34.1



