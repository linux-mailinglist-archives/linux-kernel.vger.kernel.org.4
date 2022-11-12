Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E2626A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiKLPCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKLPCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:02:43 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1920D85;
        Sat, 12 Nov 2022 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668265362;
        bh=MAQGUiCk/Jw5XkMj9qWX64lAaw+VlNgC2YDZwGFdF/4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=xmynR6dDohIKCQw9SqClTLhGXOMwAUTOSptC1N+FS/I/cnJiRQBBxI6sCpG1DCzN/
         14ia0S6+UpgUapJom65KxB2noubX0QfBzBc7dcurJHDfnD5INm9jVR9hIyJtp1NjvK
         pR1u2MiSlX3/BWQeqnaDHomzTMb060KraoWsADJs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 44B1F1281727;
        Sat, 12 Nov 2022 10:02:42 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aiOV2KVLxLvY; Sat, 12 Nov 2022 10:02:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668265362;
        bh=MAQGUiCk/Jw5XkMj9qWX64lAaw+VlNgC2YDZwGFdF/4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=xmynR6dDohIKCQw9SqClTLhGXOMwAUTOSptC1N+FS/I/cnJiRQBBxI6sCpG1DCzN/
         14ia0S6+UpgUapJom65KxB2noubX0QfBzBc7dcurJHDfnD5INm9jVR9hIyJtp1NjvK
         pR1u2MiSlX3/BWQeqnaDHomzTMb060KraoWsADJs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A94771281708;
        Sat, 12 Nov 2022 10:02:41 -0500 (EST)
Message-ID: <d70b92ce5eb5b50b1a0975e8b3b21b9f48809ad8.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Nov 2022 10:02:40 -0500
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

Three small fixes, all in drivers.  The sas one is in an unlikely error
leg, the debug one is to make it more standards conformant and the
ibmvfc one is to fix a user visible bug where a failover could lose all
paths to the device.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (1):
      scsi: scsi_debug: Make the READ CAPACITY response compliant with ZBC

Brian King (1):
      scsi: ibmvfc: Avoid path failures during live migration

Yang Yingliang (1):
      scsi: scsi_transport_sas: Fix error handling in sas_phy_add()

And the diffstat:

 drivers/scsi/ibmvscsi/ibmvfc.c    | 14 +++++++++++---
 drivers/scsi/scsi_debug.c         |  7 +++++++
 drivers/scsi/scsi_transport_sas.c | 13 +++++++++----
 3 files changed, 27 insertions(+), 7 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c
b/drivers/scsi/ibmvscsi/ibmvfc.c
index 00684e11976b..1a0c0b7289d2 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -708,8 +708,13 @@ static void ibmvfc_init_host(struct ibmvfc_host
*vhost)
 		memset(vhost->async_crq.msgs.async, 0, PAGE_SIZE);
 		vhost->async_crq.cur = 0;
 
-		list_for_each_entry(tgt, &vhost->targets, queue)
-			ibmvfc_del_tgt(tgt);
+		list_for_each_entry(tgt, &vhost->targets, queue) {
+			if (vhost->client_migrated)
+				tgt->need_login = 1;
+			else
+				ibmvfc_del_tgt(tgt);
+		}
+
 		scsi_block_requests(vhost->host);
 		ibmvfc_set_host_action(vhost,
IBMVFC_HOST_ACTION_INIT);
 		vhost->job_step = ibmvfc_npiv_login;
@@ -3235,9 +3240,12 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq
*crq, struct ibmvfc_host *vhost,
 			/* We need to re-setup the interpartition
connection */
 			dev_info(vhost->dev, "Partition migrated, Re-
enabling adapter\n");
 			vhost->client_migrated = 1;
+
+			scsi_block_requests(vhost->host);
 			ibmvfc_purge_requests(vhost, DID_REQUEUE);
-			ibmvfc_link_down(vhost, IBMVFC_LINK_DOWN);
+			ibmvfc_set_host_state(vhost,
IBMVFC_LINK_DOWN);
 			ibmvfc_set_host_action(vhost,
IBMVFC_HOST_ACTION_REENABLE);
+			wake_up(&vhost->work_wait_q);
 		} else if (crq->format == IBMVFC_PARTNER_FAILED ||
crq->format == IBMVFC_PARTNER_DEREGISTER) {
 			dev_err(vhost->dev, "Host partner adapter
deregistered or failed (rc=%d)\n", crq->format);
 			ibmvfc_purge_requests(vhost, DID_ERROR);
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 697fc57bc711..629853662b82 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1899,6 +1899,13 @@ static int resp_readcap16(struct scsi_cmnd *scp,
 			arr[14] |= 0x40;
 	}
 
+	/*
+	 * Since the scsi_debug READ CAPACITY implementation always
reports the
+	 * total disk capacity, set RC BASIS = 1 for host-managed ZBC
devices.
+	 */
+	if (devip->zmodel == BLK_ZONED_HM)
+		arr[12] |= 1 << 4;
+
 	arr[15] = sdebug_lowest_aligned & 0xff;
 
 	if (have_dif_prot) {
diff --git a/drivers/scsi/scsi_transport_sas.c
b/drivers/scsi/scsi_transport_sas.c
index 2f88c61216ee..74b99f2b0b74 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -722,12 +722,17 @@ int sas_phy_add(struct sas_phy *phy)
 	int error;
 
 	error = device_add(&phy->dev);
-	if (!error) {
-		transport_add_device(&phy->dev);
-		transport_configure_device(&phy->dev);
+	if (error)
+		return error;
+
+	error = transport_add_device(&phy->dev);
+	if (error) {
+		device_del(&phy->dev);
+		return error;
 	}
+	transport_configure_device(&phy->dev);
 
-	return error;
+	return 0;
 }
 EXPORT_SYMBOL(sas_phy_add);
 

