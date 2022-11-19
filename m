Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF8630E58
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKSLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 06:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiKSLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 06:20:55 -0500
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB72B189
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:20:54 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wLtyoAfds1SdMwLtyoEjpE; Sat, 19 Nov 2022 12:20:52 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Nov 2022 12:20:52 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: No need to clear memory after a dma_alloc_coherent() call
Date:   Sat, 19 Nov 2022 12:20:49 +0100
Message-Id: <57d6a4c0c44b9a33087d3f17a9cc245d1943d881.1668856835.git.christophe.jaillet@wanadoo.fr>
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

dma_alloc_coherent() already clear the allocated memory, there is no need
to explicitly call memset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/scsi/qla2xxx/qla_gs.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 64ab070b8716..0afd6cee7113 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -622,8 +622,7 @@ static int qla_async_rftid(scsi_qla_host_t *vha, port_id_t *d_id)
 		    __func__);
 		goto done_free_sp;
 	}
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.rsp;
-	memset(ct_sns, 0, sizeof(*ct_sns));
+
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
 
 	/* Prepare CT request */
@@ -718,8 +717,7 @@ static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
 		    __func__);
 		goto done_free_sp;
 	}
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.rsp;
-	memset(ct_sns, 0, sizeof(*ct_sns));
+
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
 
 	/* Prepare CT request */
@@ -810,8 +808,7 @@ static int qla_async_rnnid(scsi_qla_host_t *vha, port_id_t *d_id,
 		    __func__);
 		goto done_free_sp;
 	}
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.rsp;
-	memset(ct_sns, 0, sizeof(*ct_sns));
+
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
 
 	/* Prepare CT request */
@@ -917,8 +914,7 @@ static int qla_async_rsnn_nn(scsi_qla_host_t *vha)
 		    __func__);
 		goto done_free_sp;
 	}
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.rsp;
-	memset(ct_sns, 0, sizeof(*ct_sns));
+
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
 
 	/* Prepare CT request */
@@ -3228,10 +3224,8 @@ int qla24xx_async_gpnid(scsi_qla_host_t *vha, port_id_t *id)
 		goto done_free_sp;
 	}
 
-	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.rsp;
-	memset(ct_sns, 0, sizeof(*ct_sns));
-
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
+
 	/* CT_IU preamble  */
 	ct_req = qla2x00_prep_ct_req(ct_sns, GPN_ID_CMD, GPN_ID_RSP_SIZE);
 
-- 
2.34.1

