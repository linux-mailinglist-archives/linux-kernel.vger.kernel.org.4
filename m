Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E7630E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKSLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKSLZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:25:16 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BEE7FC32
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:25:12 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wLy8o8HMFb9QWwLy8oM3lt; Sat, 19 Nov 2022 12:25:10 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Nov 2022 12:25:10 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Remove a useless variable in qla24xx_async_gnnft_done()
Date:   Sat, 19 Nov 2022 12:25:07 +0100
Message-Id: <0a98ea98784299393042e9e7b2cd03ab17b13f94.1668857101.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dup' is useless. It is only 1 if 'dup_cnt' is 1 or more.
It is as easy to test 'dup_cnt' directly and remove 'dup'.

This slightly simplify the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/qla2xxx/qla_gs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 0afd6cee7113..8caa6c6ed479 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3467,7 +3467,7 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 	struct fab_scan_rp *rp, *trp;
 	unsigned long flags;
 	u8 recheck = 0;
-	u16 dup = 0, dup_cnt = 0;
+	u16 dup_cnt = 0;
 
 	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xffff,
 	    "%s enter\n", __func__);
@@ -3526,7 +3526,6 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 		for (k = i + 1; k < vha->hw->max_fibre_devices; k++) {
 			trp = &vha->scan.l[k];
 			if (rp->id.b24 == trp->id.b24) {
-				dup = 1;
 				dup_cnt++;
 				ql_dbg(ql_dbg_disc + ql_dbg_verbose,
 				    vha, 0xffff,
@@ -3588,7 +3587,7 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 		}
 	}
 
-	if (dup) {
+	if (dup_cnt) {
 		ql_log(ql_log_warn, vha, 0xffff,
 		    "Detected %d duplicate NPORT ID(s) from switch data base\n",
 		    dup_cnt);
-- 
2.34.1

