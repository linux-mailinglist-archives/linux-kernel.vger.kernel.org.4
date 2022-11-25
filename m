Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4BF6390F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKYVFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:05:31 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19630442C5;
        Fri, 25 Nov 2022 13:05:30 -0800 (PST)
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id B7E39419E9E1;
        Fri, 25 Nov 2022 21:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B7E39419E9E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669410325;
        bh=gv0SXRdsM8PzdgCeoPT9rv4Jtt/qWR7XgDFUEPFsVV8=;
        h=From:To:Cc:Subject:Date:From;
        b=o20EMoupgJpijvO6b6lw/bNuICKYfkb3olBc7A1d8BKLSH5aVCwYeYo3xHxSalorG
         nTanv9X7HWhNaq+oTEhkNtETtVoV1oFJgFLkOBTd5Xtk1eeF/yjQXZawvtN/jNN/8b
         tb0e88srbHB65ohvkuVzpien8Y56wDhiUpw+gvnU=
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Semyon Verchenko <semverchenko@factor-ts.ru>
Subject: [PATCH] scsi: initio: Add checks for errors in initio_msgin()
Date:   Sat, 26 Nov 2022 00:04:04 +0300
Message-Id: <1669410244-5565-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initio_msgin() calls initio_msgin_accept(), initio_msgin_reject()
and initio_msgin_extend(), but does not check if they are succeed.
It is not consistent with the other code of the driver.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 72d39fea9017 ("[SCSI] initio: Convert into a real Linux driver and update to modern style")
Signed-off-by: Semyon Verchenko <semverchenko@factor-ts.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/scsi/initio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 375261d67619..ee451aa34143 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2065,7 +2065,8 @@ static int initio_msgin(struct initio_host * host)
 		case SAVE_POINTERS:
 		case RESTORE_POINTERS:
 		case NOP:
-			initio_msgin_accept(host);
+			if (initio_msgin_accept(host) == -1)
+				return -1;
 			break;
 		case MESSAGE_REJECT:	/* Clear ATN first              */
 			outb((inb(host->addr + TUL_SSignal) & (TSC_SET_ACK | 7)),
@@ -2074,20 +2075,24 @@ static int initio_msgin(struct initio_host * host)
 			if ((active_tc->flags & (TCF_SYNC_DONE | TCF_NO_SYNC_NEGO)) == 0)	/* do sync nego */
 				outb(((inb(host->addr + TUL_SSignal) & (TSC_SET_ACK | 7)) | TSC_SET_ATN),
 					host->addr + TUL_SSignal);
-			initio_msgin_accept(host);
+			if (initio_msgin_accept(host) == -1)
+				return -1;
 			break;
 		case EXTENDED_MESSAGE:	/* extended msg */
-			initio_msgin_extend(host);
+			if (initio_msgin_extend(host) == -1)
+				return -1;
 			break;
 		case IGNORE_WIDE_RESIDUE:
-			initio_msgin_accept(host);
+			if (initio_msgin_accept(host) == -1)
+				return -1;
 			break;
 		case COMMAND_COMPLETE:
 			outb(TSC_FLUSH_FIFO, host->addr + TUL_SCtrl0);
 			outb(TSC_MSG_ACCEPT, host->addr + TUL_SCmd);
 			return initio_wait_done_disc(host);
 		default:
-			initio_msgout_reject(host);
+			if (initio_msgout_reject(host) == -1)
+				return -1;
 			break;
 		}
 		if (host->phase != MSG_IN)
-- 
2.7.4

