Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94B68164C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjA3Q0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjA3Q0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:26:46 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FDD3A856;
        Mon, 30 Jan 2023 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675095991; bh=WOQ4vuk34rA8b08A56gxt9geZ1TucBGZIWvT4ETxZIg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=IbGW6e4yoU4N8jnk+gb10lFBklYd+2W/It+3J/QhfgIMobtaPdJc6y9BO2othIbxg
         JRDe8wYdbV3d7ohGr8KCQDZgriuZ4nx9P7TH0u/NVWaV/pYeK/bYfTmmaoaNHwojuw
         aRRvFB7kAclMZWKjGGhdhU1H8heZfzG4MjsBJCAc=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 30 Jan 2023 17:26:31 +0100 (CET)
X-EA-Auth: Iop45wzrRbdCV8RWDLbj/0flWLCA+fQ84U0oUYoywr0m1w/jsYoUdCyRQTjntI8xuq8QxZvlDC+KbaNmp/Tv59KAlvf6dJXs
Date:   Mon, 30 Jan 2023 21:56:25 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: snic: Use sysfs_emit in show function callback
Message-ID: <Y9fvsSJrflcIHm7e@ubun2204.myguest.virtualbox.org>
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
of sprintf() family functions.
Issue identified using the device_attr_show.cocci Coccinelle script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/snic/snic_attrs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/snic/snic_attrs.c b/drivers/scsi/snic/snic_attrs.c
index 3ddbdbc3ded1..56c46ea06e60 100644
--- a/drivers/scsi/snic/snic_attrs.c
+++ b/drivers/scsi/snic/snic_attrs.c
@@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
 {
 	struct snic *snic = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
+	return sysfs_emit(buf, "%s\n", snic->name);
 }
 
 static ssize_t
@@ -23,8 +23,7 @@ snic_show_state(struct device *dev,
 {
 	struct snic *snic = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			snic_state_str[snic_get_state(snic)]);
+	return sysfs_emit(buf, "%s\n", snic_state_str[snic_get_state(snic)]);
 }
 
 static ssize_t
@@ -32,7 +31,7 @@ snic_show_drv_version(struct device *dev,
 		      struct device_attribute *attr,
 		      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
+	return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
 }
 
 static ssize_t
@@ -45,8 +44,7 @@ snic_show_link_state(struct device *dev,
 	if (snic->config.xpt_type == SNIC_DAS)
 		snic->link_status = svnic_dev_link_status(snic->vdev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			(snic->link_status) ? "Link Up" : "Link Down");
+	return sysfs_emit(buf, "%s\n", (snic->link_status) ? "Link Up" : "Link Down");
 }
 
 static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name, NULL);
-- 
2.34.1



