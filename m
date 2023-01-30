Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77EB681B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjA3UWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA3UWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:22:13 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CB2470AF;
        Mon, 30 Jan 2023 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675110125; bh=pOqor3QSVU7vfogPUbrnGNPF65OQgfQ9DubvQZ9Hg8M=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=oIor9ak8pXR65QOhYfff4SGTjzd8NjsqAidXb6hPH3/c/hPb8GC6mUuTz07lgAmHR
         ATfwb6Iw3xE0NZdPdsbFCsAPGF1jvUlioZhAViDU8ELRGndonDJjfNVNykgBibD+sU
         v6I5FcaNbe/+KxNLL7arAN2liBKq2KjM5TT4AZLc=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 30 Jan 2023 21:22:04 +0100 (CET)
X-EA-Auth: KFh5ORkxrJaJFJViVaNy7TAPZFh6u5OSl1mCjUOG+bGhs8BMAdxOJnykaGc6EMAivV1gucpipKqF6rQ4YTZLNwZDKnAQ1nKt
Date:   Tue, 31 Jan 2023 01:52:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: pmcraid: Use sysfs_emit in show function callback
Message-ID: <Y9gm6F6TINrlEPPo@ubun2204.myguest.virtualbox.org>
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

According to Documentation/filesystems/sysfs.rst, show() callback
function should only use sysfs_emit() or sysfs_emit_at() instead
of sprint() family functions when formatting the device attribute
values to be returned to user space.
Issue identified using the device_attr_show.cocci Coccinelle script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/pmcraid.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 836ddc476764..2705dcaa7798 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3493,7 +3493,7 @@ static ssize_t pmcraid_show_log_level(
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pmcraid_instance *pinstance =
 		(struct pmcraid_instance *)shost->hostdata;
-	return snprintf(buf, PAGE_SIZE, "%d\n", pinstance->current_log_level);
+	return sysfs_emit(buf, "%d\n", pinstance->current_log_level);
 }
 
 /**
@@ -3554,8 +3554,7 @@ static ssize_t pmcraid_show_drv_version(
 	char *buf
 )
 {
-	return snprintf(buf, PAGE_SIZE, "version: %s\n",
-			PMCRAID_DRIVER_VERSION);
+	return sysfs_emit(buf, "version: %s\n", PMCRAID_DRIVER_VERSION);
 }
 
 static struct device_attribute pmcraid_driver_version_attr = {
@@ -3588,9 +3587,8 @@ static ssize_t pmcraid_show_adapter_id(
 		pinstance->pdev->devfn;
 	u32 aen_group = pmcraid_event_family.id;
 
-	return snprintf(buf, PAGE_SIZE,
-			"adapter id: %d\nminor: %d\naen group: %d\n",
-			adapter_id, MINOR(pinstance->cdev.dev), aen_group);
+	return sysfs_emit(buf, "adapter id: %d\nminor: %d\naen group: %d\n",
+			  adapter_id, MINOR(pinstance->cdev.dev), aen_group);
 }
 
 static struct device_attribute pmcraid_adapter_id_attr = {
-- 
2.34.1



