Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3D6EDB91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjDYGSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:18:37 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A59001;
        Mon, 24 Apr 2023 23:18:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 082993FC2B;
        Tue, 25 Apr 2023 06:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682403512;
        bh=xpybMNqsIkCk472a+6jLgU3wLUPfUx2T87BEmh4vcf0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Cvi96RZncRDEiCpOutJL541wj6f0hVJrhiEcsz47MUL8NZMYRuwZuxsfbe6xbhil0
         KvCNVZ9akCc0poyuyzb5IMLy+8vY/A5JLDaN5GLLdoYk9PApGmrszoxnHS3DjDgaYr
         nU2+mIBYRehdD0VLyunYzhEHPmjBhERcw3BL374aBYzrFOB5SLKcYb1cEBRa841oe1
         frVx94SHbbno8i2QYvlOEEpRKYNuR/MVCjxOgCOd/0erl65SoLpXqwfTeEgFQ6n6VD
         fi9RJNDGzXPMcfXEXTj0XU6L1Z/Q7SWo1RhpZ+XJYluRRDAHk9hFU1ZaYhMx7itQO0
         0OSzqF2CiZolQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bblock@linux.ibm.com, acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ata: libata: Defer rescan on suspended device
Date:   Tue, 25 Apr 2023 14:17:45 +0800
Message-Id: <20230425061746.503145-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system resume, if an EH is schduled after ATA host is resumed
(i.e. ATA_PFLAG_PM_PENDING cleared), but before the disk device is
fully resumed, the device_lock hold by scsi_rescan_device() is never
released so the dpm_resume() of the disk is blocked forerver.

That's because scsi_attach_vpd() is expecting the disk device is in
operational state, as it doesn't work on suspended device.

To avoid such deadlock, defer rescan if the disk is still suspended so
the resume process of the disk device can proceed. At the end of the
resume process, use the complete() callback to schedule the rescan task.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Schedule rescan task at the end of system resume phase.
 - Wording.

 drivers/ata/libata-core.c | 11 +++++++++++
 drivers/ata/libata-eh.c   | 11 +++++++++--
 include/linux/libata.h    |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14c17c3bda4e..564d72bf1ec6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5093,6 +5093,16 @@ static int ata_port_pm_poweroff(struct device *dev)
 	return 0;
 }
 
+static void ata_port_pm_complete(struct device *dev)
+{
+	struct ata_port *ap = to_ata_port(dev);
+
+	if (ap->pflags & ATA_PFLAG_DEFER_RESCAN)
+		schedule_work(&(ap->scsi_rescan_task));
+
+	ap->pflags &= ~ATA_PFLAG_DEFER_RESCAN;
+}
+
 static const unsigned int ata_port_resume_ehi = ATA_EHI_NO_AUTOPSY
 						| ATA_EHI_QUIET;
 
@@ -5158,6 +5168,7 @@ static const struct dev_pm_ops ata_port_pm_ops = {
 	.thaw = ata_port_pm_resume,
 	.poweroff = ata_port_pm_poweroff,
 	.restore = ata_port_pm_resume,
+	.complete = ata_port_pm_complete,
 
 	.runtime_suspend = ata_port_runtime_suspend,
 	.runtime_resume = ata_port_runtime_resume,
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a6c901811802..0881b590fb7e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -15,6 +15,7 @@
 #include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_eh.h>
@@ -2983,8 +2984,14 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			 */
 			ehc->i.flags |= ATA_EHI_SETMODE;
 
-			/* schedule the scsi_rescan_device() here */
-			schedule_work(&(ap->scsi_rescan_task));
+			/* Schedule the scsi_rescan_device() here.
+			 * Defer the rescan if it's in process of
+			 * suspending or resuming.
+			 */
+			if (pm_suspend_target_state != PM_SUSPEND_ON)
+				ap->pflags |= ATA_PFLAG_DEFER_RESCAN;
+			else
+				schedule_work(&(ap->scsi_rescan_task));
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
 			   ehc->tries[dev->devno] &&
 			   ata_class_enabled(ehc->classes[dev->devno])) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a759dfbdcc91..aaa549444abc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -189,6 +189,7 @@ enum {
 	ATA_PFLAG_UNLOADING	= (1 << 9), /* driver is being unloaded */
 	ATA_PFLAG_UNLOADED	= (1 << 10), /* driver is unloaded */
 
+	ATA_PFLAG_DEFER_RESCAN	= (1 << 16), /* peform deferred rescan on system resume */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_INIT_GTM_VALID = (1 << 19), /* initial gtm data valid */
-- 
2.34.1

