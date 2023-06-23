Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC773BE85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFWSgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFWSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:36:40 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 11:36:12 PDT
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D8272C;
        Fri, 23 Jun 2023 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-Id:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=IsmaMbieHmsIvUno8XVnMKWOAwIxRE280MRkqliioTI=; b=UdXxG1KPp32voSQQn1F9/wZ+hC
        m2g3jkXks+Sk4yA1kGVIOrfg477b0sRq1hmda2ykubtPkISBYPaz160Kvl0h0rsfMwQ92ilohOfKk
        /+p5NmY5n0ib3cOOYgpgf7s4EHTmJi4zzw9ImJUC6MxLvuKBZePLmdQYwmgR+j4ekjg9kqCAJcg5/
        9+QP9w0RB/s18vaNrQH0x7zM+uamZb68bzOAufHsRQKUNyB/EqupBAvK1+m9IfdzJGigv/vjALws+
        B7sEsXGqCOjqs4bhmRJG4DWmt8tuz7lse9HXl29joZtCrgxlaLfu4Wg8hPsTQP5/26qJMI4CWHLQd
        A+2W1oDw==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1qClNN-003QH1-34;
        Fri, 23 Jun 2023 18:19:17 +0000
From:   Lorenz Brun <lorenz@brun.one>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: fix bogus SCSI sense after abort
Date:   Fri, 23 Jun 2023 20:19:07 +0200
Message-Id: <20230623181908.2032764-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 058e55e120ca which fixed that commands without valid
error/status codes did not result in any sense error, the returned sense
errors were completely bogus as ata_to_sense_error did not have valid
inputs in the first place.

For example the following ATA error

exception Emask 0x10 SAct 0x20c000 SErr 0x280100 action 0x6 frozen
irq_stat 0x08000000, interface fatal error
SError: { UnrecovData 10B8B BadCRC }
failed command: READ FPDMA QUEUED
cmd 60/e0:70:20:0a:00/00:00:00:00:00/40 tag 14 ncq dma 114688 in
res 40/00:ac:20:5e:50/00:00:5d:01:00/40 Emask 0x10 (ATA bus error)
status: { DRDY }

got turned into the following nonsensical SCSI error

FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
Sense Key : Illegal Request [current]
Add. Sense: Unaligned write command
CDB: Read(16) 88 00 00 00 00 00 00 00 0a 20 00 00 00 e0 00 00

This has nothing to do with an unaligned write command, but is due to an
ATA EH-triggered abort. But ata_to_sense_error only knows about
status and error, both of which aren't even valid here as the command
has been aborted.

Add an additional section to ata_gen_ata_sense which handles
errors not coming from the device first, before calling into
ata_to_sense_error.

According to the SAT-5 spec a reset should cause a Unit Attention event,
which the SCSI subsystem should handle to retry its commands but I
am not sure how much of that infra is present in Linux's SCSI layer, so
this is a simpler solution.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 drivers/ata/libata-scsi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 551077cea4e4..61c6a4e8123a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -13,6 +13,7 @@
  *  - http://www.t13.org/
  */
 
+#include "scsi/scsi_proto.h"
 #include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -1013,6 +1014,21 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+	if (qc->err_mask & (AC_ERR_HSM | AC_ERR_ATA_BUS | AC_ERR_HOST_BUS |
+		AC_ERR_SYSTEM | AC_ERR_OTHER)) {
+		/* Command aborted because of some issue with the ATA subsystem
+		 * Should technically cause unit attention, but this is better
+		 * than nothing, which results in nonsensical errors.
+		 * POWER ON, RESET, OR BUS DEVICE RESET OCCURRED
+		 */
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x29, 0x00);
+		return;
+	}
+	if (qc->err_mask & AC_ERR_TIMEOUT) {
+		/* COMMAND TIMEOUT DURING PROCESSING */
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x2e, 0x02);
+		return;
+	}
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-- 
2.40.1

