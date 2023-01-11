Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD8666338
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjAKTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAKTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:02:09 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FFF3D9F2;
        Wed, 11 Jan 2023 11:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673463717; bh=z4mIkRGmW/UOlyaWLzMaGS4Bp7aO/qtky3A43RvUivg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=jAwLC/0I1G8qcyvZt4T119gmSNgDdHHM5K0TbaC6QyZjQwnnOMhiBYNzCELTcmkxh
         RuXzm1imEOwpF5UGiIxwPsKMG7EoTqmfS1RmGh4cVOZV1Lg1KXxrx//nWKXMgSePcr
         9iMvzBmIZLVSHRzKfZJiam15LHzsIICgpfZ+CFRk=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 11 Jan 2023 20:01:57 +0100 (CET)
X-EA-Auth: CBO1VB7wv7T14fzmCZcRvdILkqKtqF5NZHt40nUuTS+YdQ8EqGZfqd7HPpEaP38NZFt+5jZa6GESvjQnldTM2f+rthHICo9/
Date:   Thu, 12 Jan 2023 00:31:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] scsi: qla2xxx: Simplify if condition evaluation
Message-ID: <Y78HoiOWkc3RrEgN@ubun2204.myguest.virtualbox.org>
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

 drivers/scsi/qla2xxx/qla_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 548f22705ddc..bf6aacf4dbd1 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work)
 		}
 
 		if (ha->flags.edif_enabled &&
-		    (!own || (own &&
-			      own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
+				(own && own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
 			sess->edif.authok = 0;
 			if (!ha->flags.host_shutting_down) {
 				ql_dbg(ql_dbg_edif, vha, 0x911e,
-- 
2.34.1



