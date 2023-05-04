Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B06F004B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbjD0FHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0FG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:06:59 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228414208;
        Wed, 26 Apr 2023 22:06:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0EB4A42558;
        Thu, 27 Apr 2023 05:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682572016;
        bh=I5LSa7XOMxPLIwa3sfuPkV7a2K2/LBac6oRm6IkSpRk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UcNxV3G2WQt0eMYuFL+kcViuLMVyYKaVEQOew9doGZE9oi/vVgHCZH1tJeIddYICz
         vTpj9AjWz3RkfLY3w1hpX8w6cQAQiVuYVuWyWLVDe98G2dpui5XeV1dt/FfdaNffHR
         hDRN2uVdppsqdpvOC69556RSTsoyYehoWkNqaQLqk6P83zH/9QQiTl88F+qZQhCfP9
         TsKkb1aXAe5yu3LC1M4ZBrtpYd0mBHs6Tz0xy5kKJxQLmk6zDAykPS/lUOsw8b0y+a
         3qGZ7eCbxmuD9g1OKyrbLTuhwqxQv/lB6IbkRkSOtn8Lhs3Wa6iej6DUFONxi075IA
         sK/qPYVoJgenA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bblock@linux.ibm.com, acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ata: libata: Defer rescan on suspended device
Date:   Thu, 27 Apr 2023 13:06:03 +0800
Message-Id: <20230427050603.612145-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427050603.612145-1-kai.heng.feng@canonical.com>
References: <20230427050603.612145-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v3:
 - New patch to resolve undefined pm_suspend_target_state.

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

