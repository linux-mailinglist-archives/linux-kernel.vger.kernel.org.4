Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D93683665
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjAaTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjAaTVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:21:31 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDECA06;
        Tue, 31 Jan 2023 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1675192887;
        bh=ylYwSQlzxv3UK8qHxCuat9EOrQw8l1G5MawGzF0fTMs=;
        h=Message-ID:Subject:From:To:Date:From;
        b=FAaljnmTB8PteQDcqpkoTu5UdHX9bkvWsjaIeJVaInLQ4QjguKJ9yzdWYlbKU9bJe
         nb4K1gLo3tIsWwqy69SmhpW24+cFY5+VSd6adfeAwYuEZq3do5JU+MweYm9bOPzCFf
         Cleb5lJfqAlTM+uBABQtiqry+IL2ucI3BCWMFvRU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0FDB91280528;
        Tue, 31 Jan 2023 14:21:27 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eOqdkYJqxs9Q; Tue, 31 Jan 2023 14:21:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1675192886;
        bh=ylYwSQlzxv3UK8qHxCuat9EOrQw8l1G5MawGzF0fTMs=;
        h=Message-ID:Subject:From:To:Date:From;
        b=RAClvfL4gLV50EmBa7rYzB5MhVY/62xlBW71ATK4x+TAqPZiFSLzdNaIcSSNvRXom
         bGZfC384JuoaVRRI3EM756mi2jH28NSIBpV35h+jTKREuSiq22cTuMv1CkKoKtH3BJ
         R4z49HaGMyZvfm1EsFycmXifMbj8jbMlnsyfv5I8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 638DE1280486;
        Tue, 31 Jan 2023 14:21:26 -0500 (EST)
Message-ID: <b7da90228a0f844928c9331eab0be64072d237f5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.1-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Jan 2023 14:21:25 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two core fixes.  One simply moves an annotation from put to release to
avoid the warning triggering needlessly in alua, but to keep it in case
release is ever called from that path (which we don't think will
happen).  The other reverts a change to the PQ=1 target scanning
behaviour that's under intense discussion at the moment.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (1):
      scsi: core: Fix the scsi_device_put() might_sleep annotation

Martin K. Petersen (1):
      scsi: Revert "scsi: core: map PQ=1, PDT=other values to SCSI_SCAN_TARGET_PRESENT"

And the diffstat:

 drivers/scsi/scsi.c       | 2 --
 drivers/scsi/scsi_scan.c  | 7 +++----
 drivers/scsi/scsi_sysfs.c | 2 ++
 3 files changed, 5 insertions(+), 6 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1426b9b03612..9feb0323bc44 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -588,8 +588,6 @@ void scsi_device_put(struct scsi_device *sdev)
 {
 	struct module *mod = sdev->host->hostt->module;
 
-	might_sleep();
-
 	put_device(&sdev->sdev_gendev);
 	module_put(mod);
 }
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 7a6904a3928e..f9b18fdc7b3c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1232,8 +1232,7 @@ static int scsi_probe_and_add_lun(struct scsi_target *starget,
 	 * that no LUN is present, so don't add sdev in these cases.
 	 * Two specific examples are:
 	 * 1) NetApp targets: return PQ=1, PDT=0x1f
-	 * 2) IBM/2145 targets: return PQ=1, PDT=0
-	 * 3) USB UFI: returns PDT=0x1f, with the PQ bits being "reserved"
+	 * 2) USB UFI: returns PDT=0x1f, with the PQ bits being "reserved"
 	 *    in the UFI 1.0 spec (we cannot rely on reserved bits).
 	 *
 	 * References:
@@ -1247,8 +1246,8 @@ static int scsi_probe_and_add_lun(struct scsi_target *starget,
 	 * PDT=00h Direct-access device (floppy)
 	 * PDT=1Fh none (no FDD connected to the requested logical unit)
 	 */
-	if (((result[0] >> 5) == 1 ||
-	    (starget->pdt_1f_for_no_lun && (result[0] & 0x1f) == 0x1f)) &&
+	if (((result[0] >> 5) == 1 || starget->pdt_1f_for_no_lun) &&
+	    (result[0] & 0x1f) == 0x1f &&
 	    !scsi_is_wlun(lun)) {
 		SCSI_LOG_SCAN_BUS(3, sdev_printk(KERN_INFO, sdev,
 					"scsi scan: peripheral device type"
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 981d1bab2120..8ef9a5494340 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -451,6 +451,8 @@ static void scsi_device_dev_release(struct device *dev)
 	struct scsi_vpd *vpd_pgb0 = NULL, *vpd_pgb1 = NULL, *vpd_pgb2 = NULL;
 	unsigned long flags;
 
+	might_sleep();
+
 	scsi_dh_release_device(sdev);
 
 	parent = sdev->sdev_gendev.parent;

