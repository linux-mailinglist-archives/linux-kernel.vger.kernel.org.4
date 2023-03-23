Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5639F6C7418
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCWXgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCWXgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:36:41 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EB24127;
        Thu, 23 Mar 2023 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679614599;
        bh=LA5jBfp0rmzD1As+Zr0AF8LsPuTbDZTwOeZzx+XkVIU=;
        h=Message-ID:Subject:From:To:Date:From;
        b=CUnWljrOUvRugxlQ+41Zo9xhxD1A+CiOD7JqWkRAKnz8ZGWhGKZycb7HMlgAUmbEY
         Rk0+ezZzUBn2QS78zmIqx6u46u96VOjBP9hhQp7Lil44iVRc3iPIEATVJcfnEkgtev
         81QvDDjhkSfc2gu1Ql6BskLSm6FqOBvSusi1otYk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BC8721286D37;
        Thu, 23 Mar 2023 19:36:39 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PG33SogVEtQA; Thu, 23 Mar 2023 19:36:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1679614599;
        bh=LA5jBfp0rmzD1As+Zr0AF8LsPuTbDZTwOeZzx+XkVIU=;
        h=Message-ID:Subject:From:To:Date:From;
        b=CUnWljrOUvRugxlQ+41Zo9xhxD1A+CiOD7JqWkRAKnz8ZGWhGKZycb7HMlgAUmbEY
         Rk0+ezZzUBn2QS78zmIqx6u46u96VOjBP9hhQp7Lil44iVRc3iPIEATVJcfnEkgtev
         81QvDDjhkSfc2gu1Ql6BskLSm6FqOBvSusi1otYk=
Received: from [153.66.160.227] (unknown [153.66.160.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1856E1286D27;
        Thu, 23 Mar 2023 19:36:39 -0400 (EDT)
Message-ID: <f2515dfb43cd4dd334ea2bda00f8576f69a40178.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.3-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Mar 2023 19:36:37 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four small fixes, three in drivers.  The core fix adds a UFS device to
an existing quirk to avoid a huge delay on boot.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Joel Selvaraj (1):
      scsi: core: Add BLIST_SKIP_VPD_PAGES for SKhynix H28U74301AMR

Nilesh Javali (1):
      scsi: qla2xxx: Perform lockless command completion in abort path

Quinn Tran (1):
      scsi: qla2xxx: Synchronize the IOCB count to be in order

Yu Kuai (1):
      scsi: scsi_dh_alua: Fix memleak for 'qdata' in alua_activate()

And the diffstat:

 drivers/scsi/device_handler/scsi_dh_alua.c |  6 ++++--
 drivers/scsi/qla2xxx/qla_isr.c             |  3 ++-
 drivers/scsi/qla2xxx/qla_os.c              | 11 +++++++++++
 drivers/scsi/scsi_devinfo.c                |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

With full diff below.

James

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 362fa631f39b..a226dc1b65d7 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1145,10 +1145,12 @@ static int alua_activate(struct scsi_device *sdev,
 	rcu_read_unlock();
 	mutex_unlock(&h->init_mutex);
 
-	if (alua_rtpg_queue(pg, sdev, qdata, true))
+	if (alua_rtpg_queue(pg, sdev, qdata, true)) {
 		fn = NULL;
-	else
+	} else {
+		kfree(qdata);
 		err = SCSI_DH_DEV_OFFLINED;
+	}
 	kref_put(&pg->kref, release_port_group);
 out:
 	if (fn)
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 030625ebb4e6..71feda2cdb63 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1900,6 +1900,8 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
 	}
 
 	req->outstanding_cmds[index] = NULL;
+
+	qla_put_fw_resources(sp->qpair, &sp->iores);
 	return sp;
 }
 
@@ -3112,7 +3114,6 @@ qla25xx_process_bidir_status_iocb(scsi_qla_host_t *vha, void *pkt,
 	}
 	bsg_reply->reply_payload_rcv_len = 0;
 
-	qla_put_fw_resources(sp->qpair, &sp->iores);
 done:
 	/* Return the vendor specific reply to API */
 	bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = rval;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 80c4ee9df2a4..bee1b8a82020 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1865,6 +1865,17 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
 		sp = req->outstanding_cmds[cnt];
 		if (sp) {
+			/*
+			 * perform lockless completion during driver unload
+			 */
+			if (qla2x00_chip_is_down(vha)) {
+				req->outstanding_cmds[cnt] = NULL;
+				spin_unlock_irqrestore(qp->qp_lock_ptr, flags);
+				sp->done(sp, res);
+				spin_lock_irqsave(qp->qp_lock_ptr, flags);
+				continue;
+			}
+
 			switch (sp->cmd_type) {
 			case TYPE_SRB:
 				qla2x00_abort_srb(qp, sp, res, &flags);
diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index bc9d280417f6..3fcaf10a9dfe 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -234,6 +234,7 @@ static struct {
 	{"SGI", "RAID5", "*", BLIST_SPARSELUN},
 	{"SGI", "TP9100", "*", BLIST_REPORTLUN2},
 	{"SGI", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
+	{"SKhynix", "H28U74301AMR", NULL, BLIST_SKIP_VPD_PAGES},
 	{"IBM", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"SUN", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"DELL", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},

