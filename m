Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C589661926
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjAHUNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjAHUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:13:30 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BD2671;
        Sun,  8 Jan 2023 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673208800; bh=KK4gdVcPkbx53T8nteORF7wE5stV6jTMnhmIKRwioCA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=dRTEpHbsiYQnW5JX9HHf9oPr/RwLZMwAjIML/ixJCvuIvGypC9YkeQHaLFlB7S3L8
         ZB1FdlF/qZBaXWT/RP9Eu7U533mC3H10H0gU7/8UbmFmM09tAAmZagLElGobhM4Gyy
         kzmuQtpvvG9wlXxddJ2dGC8llZqZwAFGby635P6U=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  8 Jan 2023 21:13:20 +0100 (CET)
X-EA-Auth: QzJkpgvuklnVpan+KktYI8NBrX6wZ9giHA77fbQ68+m9op63iHv+LC14cxn1CgsqZjmbUJuY99opuOT3wCTFk/NNnuhjtTP9
Date:   Mon, 9 Jan 2023 01:43:15 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH v2] scsi: Replace printk+WARN_ON by WARN macro
Message-ID: <Y7sj22gCmnYqTzP4@ubun2204.myguest.virtualbox.org>
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

A combination of printk() followed by WARN_ON() macro can be simplified
using a single WARN(1, ...) macro. Patch change suggested by warn.cocci
Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   - Remove printk() from the WARN macro to avoid build warning
   - I missed to build the change before sending the earlier version which
     results in a build error due to incorrect brace balancing. Fixed it.

 drivers/scsi/initio.c   | 3 +--
 drivers/scsi/scsi_lib.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 375261d67619..fea591d9d292 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2738,8 +2738,7 @@ static void i91uSCBPost(u8 * host_mem, u8 * cblk_mem)
 	host = (struct initio_host *) host_mem;
 	cblk = (struct scsi_ctrl_blk *) cblk_mem;
 	if ((cmnd = cblk->srb) == NULL) {
-		printk(KERN_ERR "i91uSCBPost: SRB pointer is empty\n");
-		WARN_ON(1);
+		WARN(1, KERN_ERR "i91uSCBPost: SRB pointer is empty\n");
 		initio_release_scb(host, cblk);	/* Release SCB for current channel */
 		return;
 	}
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9ed1ebcb7443..0f1e9ee4591b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3009,10 +3009,8 @@ void *scsi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
 	}
 
 	if (unlikely(i == sg_count)) {
-		printk(KERN_ERR "%s: Bytes in sg: %zu, requested offset %zu, "
-			"elements %d\n",
-		       __func__, sg_len, *offset, sg_count);
-		WARN_ON(1);
+		WARN(1, KERN_ERR "%s: Bytes in sg: %zu, requested offset %zu, elements %d\n",
+				__func__, sg_len, *offset, sg_count);
 		return NULL;
 	}
 
-- 
2.34.1



