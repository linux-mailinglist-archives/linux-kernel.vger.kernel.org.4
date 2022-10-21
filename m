Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E25607866
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJUN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJUN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:28:43 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31B1366A2;
        Fri, 21 Oct 2022 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1666358920;
        bh=G2PsC9YonHQYdncfwu8+22Lzftzzm23vftY3NCjeUys=;
        h=Message-ID:Subject:From:To:Date:From;
        b=VdB3021SWte2YiS4DfTKx5DT2QnvonMJ1ubAygnX7V8QCM3rIfA5L7StE1OSJaym+
         01P9Jb/vqviV1d4jFDu4WerdgzDx8Y4pVQ4ouol0PLFGm5VlfhvqcqaiV1bno7Z35t
         oZEfCne8ri8jHduTXgjWktIgJ7fJfwA1eSHpwRe8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0010E1285DD1;
        Fri, 21 Oct 2022 09:28:39 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cBcpPUwfALA3; Fri, 21 Oct 2022 09:28:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1666358919;
        bh=G2PsC9YonHQYdncfwu8+22Lzftzzm23vftY3NCjeUys=;
        h=Message-ID:Subject:From:To:Date:From;
        b=ZUBaJHBx3X8SpCDOd6ctPCXOFh8/ayVT793kiNqu7HCe08zZu5g0ay1xDIY9Iyg13
         ADD47ZNmowhFgsDVvawDXGxg8A/9VhXfOqBWAthd/uWKtL7EXrZrPwloPQ+2gutCy9
         2tjFWREcGOmg/pH1vFuh7gXXOllVqhWrZ5cDWRrk=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 506B21285D90;
        Fri, 21 Oct 2022 09:28:39 -0400 (EDT)
Message-ID: <5054a79b9c9672750ad68704c2d4f77ec2986d6f.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Oct 2022 09:28:37 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small changes, one in the lpfc driver and the other in the core. 
The core change is an additional footgun guard which prevents users
from writing the wrong state to sysfs and causing a hang.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Rafael Mendonca (1):
      scsi: lpfc: Fix memory leak in lpfc_create_port()

Uday Shankar (1):
      scsi: core: Restrict legal sdev_state transitions via sysfs

And the diffstat:

 drivers/scsi/lpfc/lpfc_init.c | 7 ++++---
 drivers/scsi/scsi_sysfs.c     | 8 ++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index b49c39569386..b535f1fd3010 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4812,7 +4812,7 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	rc = lpfc_vmid_res_alloc(phba, vport);
 
 	if (rc)
-		goto out;
+		goto out_put_shost;
 
 	/* Initialize all internally managed lists. */
 	INIT_LIST_HEAD(&vport->fc_nodes);
@@ -4830,16 +4830,17 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 
 	error = scsi_add_host_with_dma(shost, dev, &phba->pcidev->dev);
 	if (error)
-		goto out_put_shost;
+		goto out_free_vmid;
 
 	spin_lock_irq(&phba->port_list_lock);
 	list_add_tail(&vport->listentry, &phba->port_list);
 	spin_unlock_irq(&phba->port_list_lock);
 	return vport;
 
-out_put_shost:
+out_free_vmid:
 	kfree(vport->vmid);
 	bitmap_free(vport->vmid_priority_range);
+out_put_shost:
 	scsi_host_put(shost);
 out:
 	return NULL;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index c95177ca6ed2..cac7c902cf70 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -828,6 +828,14 @@ store_state_field(struct device *dev, struct device_attribute *attr,
 	}
 
 	mutex_lock(&sdev->state_mutex);
+	switch (sdev->sdev_state) {
+	case SDEV_RUNNING:
+	case SDEV_OFFLINE:
+		break;
+	default:
+		mutex_unlock(&sdev->state_mutex);
+		return -EINVAL;
+	}
 	if (sdev->sdev_state == SDEV_RUNNING && state == SDEV_RUNNING) {
 		ret = 0;
 	} else {


