Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5855166196A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjAHUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAHUii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:38:38 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C53B7CB;
        Sun,  8 Jan 2023 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673210308; bh=W+GnkAId60B8+kx0qvRInY7BmXQ5CWhNPxJNlVxnWps=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=WO8xqzGC5rsnJJdsnSP6uUJG+ofmj5qDZXnzRzc/SLs2pt1Ov/ZN4l4DCVvtoWO21
         8T5KPzjrQ6P21iP69LyeqB5CAdt/YR/1SmJGKM1bWYO4R8OetQKjq2kEGB9QE/qsBX
         PdbVrWh3kG28Hb4gTLGjLByPc2osXE6lUEk6gLaM=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  8 Jan 2023 21:38:28 +0100 (CET)
X-EA-Auth: RDzrUikqaR2vh1gQOWWDaBwjRimXsJMMIR4iHIYZyDQbTtUHXyag5PB6pfZf1T3uhwuhbmm6qlgjgxxm5+SLT+gno3cQLH6p
Date:   Mon, 9 Jan 2023 02:08:24 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] scsi: qla2xxx: Use a variable for repeated mem_size
 computation
Message-ID: <Y7spwF8HTt0c0l7y@ubun2204.myguest.virtualbox.org>
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

Use a variable to upfront compute memory size to be allocated, instead of
repeatedly computing the memory size at different instructions. The reduced
instruction length also allows to tidy up the code. Issue identified using
the array_size_dup Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 8fa0056b56dd..8024322c9c5a 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -1552,6 +1552,7 @@ static const struct qla_tgt_func_tmpl tcm_qla2xxx_template = {
 static int tcm_qla2xxx_init_lport(struct tcm_qla2xxx_lport *lport)
 {
 	int rc;
+	size_t map_sz;
 
 	rc = btree_init32(&lport->lport_fcport_map);
 	if (rc) {
@@ -1559,17 +1560,15 @@ static int tcm_qla2xxx_init_lport(struct tcm_qla2xxx_lport *lport)
 		return rc;
 	}
 
-	lport->lport_loopid_map =
-		vzalloc(array_size(65536,
-				   sizeof(struct tcm_qla2xxx_fc_loopid)));
+	map_sz = array_size(65536, sizeof(struct tcm_qla2xxx_fc_loopid));
+
+	lport->lport_loopid_map = vzalloc(map_sz);
 	if (!lport->lport_loopid_map) {
-		pr_err("Unable to allocate lport->lport_loopid_map of %zu bytes\n",
-		    sizeof(struct tcm_qla2xxx_fc_loopid) * 65536);
+		pr_err("Unable to allocate lport->lport_loopid_map of %zu bytes\n", map_sz);
 		btree_destroy32(&lport->lport_fcport_map);
 		return -ENOMEM;
 	}
-	pr_debug("qla2xxx: Allocated lport_loopid_map of %zu bytes\n",
-	       sizeof(struct tcm_qla2xxx_fc_loopid) * 65536);
+	pr_debug("qla2xxx: Allocated lport_loopid_map of %zu bytes\n", map_sz);
 	return 0;
 }
 
-- 
2.34.1



