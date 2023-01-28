Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F567F697
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjA1JHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1JHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:07:07 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993BF3A5BF;
        Sat, 28 Jan 2023 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674896816; bh=R22iGH266oHN3h6bLIRI3IU02Lca0t2HNgSH9AFK7xY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=FgY8dCfmlku124IWKVZMOXPGlAfK5Gg2fanHRW1d0Zyw9S45K948vxgwdgsoGrubT
         9FDJ5u0uLXNgRZta+ZNQpt/ZgWjcjeNvPSTWT7el8zEvjyn4l8Gj4ZZpK43LgVBqHg
         yalrUzxZh7FDM3rjZCNuCOUhuA6KMBAcYzxbOwlw=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 28 Jan 2023 10:06:56 +0100 (CET)
X-EA-Auth: SRWUIv6AJgtVE3RQZ67P7FCAUdgrw6wjpl4y1/hi8InCGVwzvJxW8XIpkgCCOobOVDEFmyiIvbqlnftv0WTXBY7q16AYgkjN
Date:   Sat, 28 Jan 2023 14:36:52 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] scsi: qla2xxx: Use min/max helpers for comparison and
 assignment
Message-ID: <Y9TlrA2k85LecxaO@ubun2204.myguest.virtualbox.org>
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

Simplify code by using min and max helper macro for logical evaluation
and value assignment.
Proposed change is identified using minmax.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c  | 4 ++--
 drivers/scsi/qla2xxx/qla_init.c | 8 ++------
 drivers/scsi/qla2xxx/qla_sup.c  | 2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index d7e8454304ce..02440c595753 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -686,9 +686,9 @@ qla25xx_copy_mq(struct qla_hw_data *ha, void *ptr, __be32 **last_chain)
 	mq->type = htonl(DUMP_CHAIN_MQ);
 	mq->chain_size = htonl(sizeof(struct qla2xxx_mq_chain));
 
-	que_cnt = ha->max_req_queues > ha->max_rsp_queues ?
-		ha->max_req_queues : ha->max_rsp_queues;
+	que_cnt = max(ha->max_req_queues, ha->max_rsp_queues);
 	mq->count = htonl(que_cnt);
+
 	for (cnt = 0; cnt < que_cnt; cnt++) {
 		reg = ISP_QUE_REG(ha, cnt);
 		que_idx = cnt * 4;
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8d9ecabb1aac..1250f575fb1e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3734,12 +3734,8 @@ qla2x00_alloc_outstanding_cmds(struct qla_hw_data *ha, struct req_que *req)
 
 	if (!IS_FWI2_CAPABLE(ha))
 		req->num_outstanding_cmds = DEFAULT_OUTSTANDING_COMMANDS;
-	else {
-		if (ha->cur_fw_xcb_count <= ha->cur_fw_iocb_count)
-			req->num_outstanding_cmds = ha->cur_fw_xcb_count;
-		else
-			req->num_outstanding_cmds = ha->cur_fw_iocb_count;
-	}
+	else
+		req->num_outstanding_cmds = min(ha->cur_fw_xcb_count, ha->cur_fw_iocb_count);
 
 	req->outstanding_cmds = kcalloc(req->num_outstanding_cmds,
 					sizeof(srb_t *),
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index c092a6b1ced4..e26f9835c124 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -3625,7 +3625,7 @@ qla24xx_read_fcp_prio_cfg(scsi_qla_host_t *vha)
 	max_len = FCP_PRIO_CFG_SIZE - FCP_PRIO_CFG_HDR_SIZE;
 
 	ha->isp_ops->read_optrom(vha, &ha->fcp_prio_cfg->entry[0],
-			fcp_prio_addr << 2, (len < max_len ? len : max_len));
+				 fcp_prio_addr << 2, min(len, max_len));
 
 	/* revalidate the entire FCP priority config data, including entries */
 	if (!qla24xx_fcp_prio_cfg_valid(vha, ha->fcp_prio_cfg, 1))
-- 
2.34.1



