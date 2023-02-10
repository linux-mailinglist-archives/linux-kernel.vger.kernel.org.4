Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A9692095
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjBJOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:15:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF51E299;
        Fri, 10 Feb 2023 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676038499; x=1707574499;
  h=from:to:cc:subject:date:message-id;
  bh=/qvMeQ9j2X2HaFmNEFykOjD3cjxN0Sct0rI+Lc/meY0=;
  b=gmM5wZKpQjWqGbgD2IsO3C/10qbkll30/aIiKvusVBPNafsuovR1Oe+8
   DouYH/oSYchmiJzwVV0O8AJCUNVFOi9iwT1ZIYdhMiLhGv0resDcUZ/3m
   qTPPWz55WUO5WcC7aqc/XpxlcfZKLUj+cI9MHQdy6cxLtIn0/QsQBxTmB
   xswO60uS5tlKMBzcjRLyrgKH+VAWUocjofuuiD9Pi4SWkG/Ua8jCQUoPg
   fL2lZg/5DmnQCrg4ow+bTrjqmfMz8JZg4QozzDoWOM2E1Z/x/OgPaVJg8
   ScbO0KxGxLYNSeRs/aGQlHNXZRZJTpvPedGjcIuGGt767LvqalV2A7TIY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="395034337"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="395034337"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="776939961"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="776939961"
Received: from storage2.sh.intel.com (HELO localhost) ([10.67.111.9])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 06:14:56 -0800
From:   Liu Xiaodong <xiaodong.liu@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>
Subject: [PATCH] block: ublk: check IO buffer based on flag need_get_data
Date:   Fri, 10 Feb 2023 09:13:56 -0500
Message-Id: <20230210141356.112321-1-xiaodong.liu@intel.com>
X-Mailer: git-send-email 2.14.5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, uring_cmd with UBLK_IO_FETCH_REQ or
UBLK_IO_COMMIT_AND_FETCH_REQ is always checked whether
userspace server has provided IO buffer even flag
UBLK_F_NEED_GET_DATA is configured.

This is a excessive check. If UBLK_F_NEED_GET_DATA is
configured, FETCH_RQ doesn't need to provide IO buffer;
COMMIT_AND_FETCH_REQ also doesn't need to do that if
the IO type is not READ.

Check ub_cmd->addr together with ublk_need_get_data()
and IO type in ublk_ch_uring_cmd().

With this fix, userspace server doesn't need to preserve
buffers for every ublk_io when flag UBLK_F_NEED_GET_DATA
is configured, in order to save memory.

Signed-off-by: Liu Xiaodong <xiaodong.liu@intel.com>
---
 drivers/block/ublk_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e54693204630..609137791667 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1203,6 +1203,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret = -EINVAL;
+	struct request *req;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -1253,8 +1254,8 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		 */
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
-		/* FETCH_RQ has to provide IO buffer */
-		if (!ub_cmd->addr)
+		/* FETCH_RQ has to provide IO buffer if NEED GET DATA is not enabled */
+		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
 			goto out;
 		io->cmd = cmd;
 		io->flags |= UBLK_IO_FLAG_ACTIVE;
@@ -1263,8 +1264,12 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		/* FETCH_RQ has to provide IO buffer */
-		if (!ub_cmd->addr)
+		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
+		/*
+		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if NEED GET DATA is
+		 * not enabled or it is Read IO.
+		 */
+		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) || req_op(req) == REQ_OP_READ))
 			goto out;
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
-- 
2.14.5

