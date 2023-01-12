Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47E666B33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 07:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjALG1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 01:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjALG1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 01:27:03 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB93AB0A;
        Wed, 11 Jan 2023 22:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673504810; bh=fHGz+mVERPlEDyQi1LBbBnlU4At61b0q89t6mvAZBUk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=NDny7k1Ubmb9flzoCwIufQVhZk3lV9o2u2FHtiKJXF3vXQbolVWuP9CNzbzVJT/vP
         EUYR9ztfPDWnxGjF3MUJY5ra1v7sQqGrVUrk1CxObWBMnKPsfWDw1lRBVe2cNtMXHc
         io+RaYLitQBtGV2/vKC7GGCEthah73fxZy6cvbDs=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 12 Jan 2023 07:26:50 +0100 (CET)
X-EA-Auth: IlPXWbvs9jiSH8qL4yNDve1rZSPMI0a8fDcySvxCyLG/tzazJPATIVc+FBXbKDkNGzVg4i2VwN8W33u6kEcAd9zidFRmWkqr
Date:   Thu, 12 Jan 2023 11:56:46 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH v2] scsi: qla2xxx: Simplify if condition evaluation
Message-ID: <Y7+oJuah0MgEW0PQ@ubun2204.myguest.virtualbox.org>
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

A logical evaluation of type (!A || A && B) can be simplified as
(!A || B).
Improvement by suggested by excluded_middle.cocci Coccinelel semantic
patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: Change is compile tested only.

Changes in v2:
   - Correct the if evaluation from (A && B) to (!A || B). Feedback
     from Lee Duncan <lduncan@suse.com>

 drivers/scsi/qla2xxx/qla_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 548f22705ddc..4f104fbfe55d 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work)
 		}
 
 		if (ha->flags.edif_enabled &&
-		    (!own || (own &&
-			      own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
+				(!own || own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
 			sess->edif.authok = 0;
 			if (!ha->flags.host_shutting_down) {
 				ql_dbg(ql_dbg_edif, vha, 0x911e,
-- 
2.34.1



