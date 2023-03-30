Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D76D1250
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC3WlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjC3WlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:41:11 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7049E3A6;
        Thu, 30 Mar 2023 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680216066;
        bh=Xp3e0oiu7aRZHsb7yyU8uyZbKvDBmEhbjq5K5x+Wyy4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=E22Vs9i1pxOHmqI4fzZkwPKW0zexLy8C0C9lMUUj3x7dIhkoqxOm4sEPb3Ex+6IPJ
         6Hql3U+jFak325dEfAqF2NWrl9BTnHPRRbL5r6kAE5eB198jfkh3m/uRuSj5iDlY3d
         2FFZihnTLTCjHLO0a9V1QswZ6GOM2dr63kZluesA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0CE371281050;
        Thu, 30 Mar 2023 18:41:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HUC-Uq3TTfF8; Thu, 30 Mar 2023 18:41:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680216065;
        bh=Xp3e0oiu7aRZHsb7yyU8uyZbKvDBmEhbjq5K5x+Wyy4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=aqP60LcivZx67MrYjOfZbuohWuhmsQAinA6W1u2qHmUyS7HRfbFKyjUj93pt/TAGA
         FepM5d+HOyBDC/HadgHxm7hEo09hyxuvscAHzd/eHDkFG7eFwcdPNeOpplpXU9AWr3
         4EqKSa+X9VEvin+ag4uu4FELP8Jt14YTUPwX6Blo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 79FF712809CD;
        Thu, 30 Mar 2023 18:41:05 -0400 (EDT)
Message-ID: <99b73ddcbca9be5d0295242edffd11def69c1db7.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.3-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Mar 2023 18:41:04 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four small fixes, three in drivers.  The core fix is yet another
attempt to insulate us from UFS devices' weird behaviour for VPD pages.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Damien Le Moal (1):
      scsi: core: Improve scsi_vpd_inquiry() checks

Jerry Snitselaar (1):
      scsi: mpt3sas: Don't print sense pool info twice

Tomas Henzl (2):
      scsi: megaraid_sas: Fix crash after a double completion
      scsi: megaraid_sas: Fix fw_crash_buffer_show()

And the diffstat:

 drivers/scsi/megaraid/megaraid_sas_base.c   |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 ++--
 drivers/scsi/mpt3sas/mpt3sas_base.c         |  5 -----
 drivers/scsi/scsi.c                         | 11 +++++++++--
 4 files changed, 12 insertions(+), 10 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3ceece988338..c895189375e2 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3298,7 +3298,7 @@ fw_crash_buffer_show(struct device *cdev,
 
 	spin_lock_irqsave(&instance->crashdump_lock, flags);
 	buff_offset = instance->fw_crash_buffer_offset;
-	if (!instance->crash_dump_buf &&
+	if (!instance->crash_dump_buf ||
 		!((instance->fw_crash_state == AVAILABLE) ||
 		(instance->fw_crash_state == COPYING))) {
 		dev_err(&instance->pdev->dev,
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 84c9a55a5794..8a83f3fc2b86 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -4771,7 +4771,7 @@ int megasas_task_abort_fusion(struct scsi_cmnd *scmd)
 	devhandle = megasas_get_tm_devhandle(scmd->device);
 
 	if (devhandle == (u16)ULONG_MAX) {
-		ret = SUCCESS;
+		ret = FAILED;
 		sdev_printk(KERN_INFO, scmd->device,
 			"task abort issued for invalid devhandle\n");
 		mutex_unlock(&instance->reset_mutex);
@@ -4841,7 +4841,7 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
 	devhandle = megasas_get_tm_devhandle(scmd->device);
 
 	if (devhandle == (u16)ULONG_MAX) {
-		ret = SUCCESS;
+		ret = FAILED;
 		sdev_printk(KERN_INFO, scmd->device,
 			"target reset issued for invalid devhandle\n");
 		mutex_unlock(&instance->reset_mutex);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2ee9ea57554d..14ae0a9c5d3d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6616,11 +6616,6 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 	else if (rc == -EAGAIN)
 		goto try_32bit_dma;
 	total_sz += sense_sz;
-	ioc_info(ioc,
-	    "sense pool(0x%p)- dma(0x%llx): depth(%d),"
-	    "element_size(%d), pool_size(%d kB)\n",
-	    ioc->sense, (unsigned long long)ioc->sense_dma, ioc->scsiio_depth,
-	    SCSI_SENSE_BUFFERSIZE, sz / 1024);
 	/* reply pool, 4 byte align */
 	sz = ioc->reply_free_queue_depth * ioc->reply_sz;
 	rc = _base_allocate_reply_pool(ioc, sz);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 5cce1ba70fc6..09ef0b31dfc0 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -314,11 +314,18 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
 	if (result)
 		return -EIO;
 
-	/* Sanity check that we got the page back that we asked for */
+	/*
+	 * Sanity check that we got the page back that we asked for and that
+	 * the page size is not 0.
+	 */
 	if (buffer[1] != page)
 		return -EIO;
 
-	return get_unaligned_be16(&buffer[2]) + 4;
+	result = get_unaligned_be16(&buffer[2]);
+	if (!result)
+		return -EIO;
+
+	return result + 4;
 }
 
 static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)

