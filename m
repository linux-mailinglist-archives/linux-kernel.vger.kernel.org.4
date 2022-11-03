Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC8617A34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiKCJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKCJqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:46:50 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334CE000;
        Thu,  3 Nov 2022 02:46:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VTsFRtL_1667468801;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTsFRtL_1667468801)
          by smtp.aliyun-inc.com;
          Thu, 03 Nov 2022 17:46:46 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] xfs: extend the freelist before available space check
Date:   Thu,  3 Nov 2022 17:46:39 +0800
Message-Id: <20221103094639.39984-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a long standing issue which could cause fs shutdown due to
inode extent to btree conversion failure right after an extent
allocation in the same AG, which is absolutely unexpected due to the
proper minleft reservation in the previous allocation.  Brian once
addressed one of the root cause [1], however, such symptom can still
occur after the commit is merged as reported [2], and our cloud
environment is also suffering from this issue.

From the description of the commit [1], I found that Zirong has an
in-house stress test reproducer for this issue, therefore I asked him
to reproduce again and he confirmed that such issue can still be
reproducable on RHEL 9.

Thanks to him, after dumping the transaction log items, I think
the root cause is as below:
 1. BUF:  ... start blkno:0x3bffe81  len:1  bmap size:1  flags:0x2800
    AGF Buffer: (XAGF)
        ver:1  seq#:3  len:2621424
        root BNO:9  CNT:7
        level BNO:2  CNT:2
        1st:64  last:69  cnt:6  freeblks:18277  longest:6395

 2. agfl (flfirst = 64, fllast = 69, flcount = 6)
    64:547 65:167 66:1651 67:2040807 68:783 69:604

 3. The log records a new AGF
    blkno 62914177, len 1, map_size 1
    00000000: 58 41 47 46 00 00 00 01 00 00 00 03 00 27 ff f0  XAGF.........'..
    00000010: 00 00 00 09 00 00 00 07 00 00 00 00 00 00 00 02  ................
    00000020: 00 00 00 02 00 00 00 00 00 00 00 41 00 00 00 45  ...........A...E
    00000030: 00 00 00 05 00 00 47 65 00 00 18 fb 00 00 00 09  ......Ge........
    00000040: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
    agf 3  flfirst: 65 (0x41) fllast: 69 (0x45) cnt: 5

 4. agfl 64 (daddr 62918552) was then written as a cntbt block
    log item:
      type#011= 0x123c
      flags#011= 0x8
    blkno 62918552, len 8, map_size 1
    00000000: 41 42 33 43 00 00 00 fd 00 1f 23 e4 ff ff ff ff  AB3C......#.....
    00000010: 00 00 00 00 03 c0 0f 98 00 00 00 00 00 00 00 00  ................
    00000020: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf

 5. Finally, kaboom.
    Nov  1 07:56:09 dell-per750-08 kernel: ------------[ cut here ]------------
    Nov  1 07:56:09 dell-per750-08 kernel: WARNING: CPU: 15 PID: 49290 at fs/xfs/libxfs/xfs_bmap.c:717 xfs_bmap_extents_to_btree+0xc51/0x1050 [xfs]
    ...
    Nov  1 07:56:10 dell-per750-08 kernel: XFS (sda2): agno 3 agflcount 5 freeblks 18277 reservation 18276 6

In order to fix the issue above, freelist needs to be filled with the
minimal blocks at least before available space check, and then we also
know the freelist has enough blocks for the following emergency btree
allocations.

[1] commit 1ca89fbc48e1 ("xfs: don't account extra agfl blocks as available")
    https://lore.kernel.org/r/20190327145000.10756-1-bfoster@redhat.com
[2] https://lore.kernel.org/r/20220105071052.GD20464@templeofstupid.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 187 ++++++++++++++++++++++++--------------
 1 file changed, 121 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 6261599bb389..5d5e0e0e5227 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2587,6 +2587,86 @@ xfs_exact_minlen_extent_available(
 }
 #endif
 
+/*
+ * The freelist has to be in a good state before the available space check
+ * since multiple allocations could be performed from a single AG and
+ * transaction under certain conditions.  For example, A bmbt allocation
+ * request made for inode extent to bmap format conversion after an extent
+ * allocation is expected to be satisfied by the same AG.  Such bmap conversion
+ * allocation can fail due to the available space check if allocbt required an
+ * extra btree block from the freelist in the previous allocation but without
+ * make the freelist longer.
+ */
+int
+xfs_fill_agfl(
+	struct xfs_alloc_arg    *args,
+	int			flags,
+	xfs_extlen_t		need,
+	struct xfs_buf          *agbp)
+{
+	struct xfs_trans	*tp = args->tp;
+	struct xfs_perag	*pag = agbp->b_pag;
+	struct xfs_alloc_arg	targs = {
+		.tp		= tp,
+		.mp		= tp->t_mountp,
+		.agbp		= agbp,
+		.agno		= args->agno,
+		.alignment	= 1,
+		.minlen		= 1,
+		.prod		= 1,
+		.type		= XFS_ALLOCTYPE_THIS_AG,
+		.pag		= pag,
+	};
+	struct xfs_buf          *agflbp = NULL;
+	xfs_agblock_t		bno;
+	int error;
+
+	if (flags & XFS_ALLOC_FLAG_NORMAP)
+		targs.oinfo = XFS_RMAP_OINFO_SKIP_UPDATE;
+	else
+		targs.oinfo = XFS_RMAP_OINFO_AG;
+
+	error = xfs_alloc_read_agfl(pag, tp, &agflbp);
+	if (error)
+		return error;
+
+	/* Make the freelist longer if it's too short. */
+	while (pag->pagf_flcount < need) {
+		targs.agbno = 0;
+		targs.maxlen = need - pag->pagf_flcount;
+		targs.resv = XFS_AG_RESV_AGFL;
+
+		/* Allocate as many blocks as possible at once. */
+		error = xfs_alloc_ag_vextent(&targs);
+		if (error)
+			goto out_agflbp_relse;
+
+		/*
+		 * Stop if we run out.  Won't happen if callers are obeying
+		 * the restrictions correctly.  Can happen for free calls
+		 * on a completely full ag.
+		 */
+		if (targs.agbno == NULLAGBLOCK) {
+			if (flags & XFS_ALLOC_FLAG_FREEING)
+				break;
+			error = -ENOSPC;
+			goto out_agflbp_relse;
+		}
+		/*
+		 * Put each allocated block on the list.
+		 */
+		for (bno = targs.agbno; bno < targs.agbno + targs.len; bno++) {
+			error = xfs_alloc_put_freelist(pag, tp, agbp,
+							agflbp, bno, 0);
+			if (error)
+				goto out_agflbp_relse;
+		}
+	}
+out_agflbp_relse:
+	xfs_trans_brelse(tp, agflbp);
+	return error;
+}
+
 /*
  * Decide whether to use this allocation group for this allocation.
  * If so, fix up the btree freelist's size.
@@ -2600,8 +2680,7 @@ xfs_alloc_fix_freelist(
 	struct xfs_perag	*pag = args->pag;
 	struct xfs_trans	*tp = args->tp;
 	struct xfs_buf		*agbp = NULL;
-	struct xfs_buf		*agflbp = NULL;
-	struct xfs_alloc_arg	targs;	/* local allocation arguments */
+	struct xfs_owner_info	oinfo;
 	xfs_agblock_t		bno;	/* freelist block */
 	xfs_extlen_t		need;	/* total blocks needed in freelist */
 	int			error = 0;
@@ -2630,22 +2709,45 @@ xfs_alloc_fix_freelist(
 		goto out_agbp_relse;
 	}
 
-	need = xfs_alloc_min_freelist(mp, pag);
-	if (!xfs_alloc_space_available(args, need, flags |
-			XFS_ALLOC_FLAG_CHECK))
-		goto out_agbp_relse;
-
 	/*
-	 * Get the a.g. freespace buffer.
-	 * Can fail if we're not blocking on locks, and it's held.
+	 * See the comment above xfs_fill_agfl() for the reason why we need to
+	 * make freelist longer here.  Assumed that such case is quite rare, so
+	 * in order to simplify the code, let's take agbp unconditionally.
 	 */
-	if (!agbp) {
-		error = xfs_alloc_read_agf(pag, tp, flags, &agbp);
-		if (error) {
-			/* Couldn't lock the AGF so skip this AG. */
-			if (error == -EAGAIN)
-				error = 0;
-			goto out_no_agbp;
+	need = xfs_alloc_min_freelist(mp, pag);
+	if (pag->pagf_flcount < need) {
+		/*
+		 * Get the a.g. freespace buffer.
+		 * Can fail if we're not blocking on locks, and it's held.
+		 */
+		if (!agbp) {
+			error = xfs_alloc_read_agf(pag, tp, flags, &agbp);
+			if (error) {
+				/* Couldn't lock the AGF so skip this AG. */
+				if (error == -EAGAIN)
+					error = 0;
+				goto out_no_agbp;
+			}
+		}
+
+		need = xfs_alloc_min_freelist(mp, pag);
+		error = xfs_fill_agfl(args, flags, need, agbp);
+		if (error)
+			goto out_agbp_relse;
+	} else {
+		if (!xfs_alloc_space_available(args, need, flags |
+				XFS_ALLOC_FLAG_CHECK))
+			goto out_agbp_relse;
+
+		/* Get the a.g. freespace buffer. */
+		if (!agbp) {
+			error = xfs_alloc_read_agf(pag, tp, flags, &agbp);
+			if (error) {
+				/* Couldn't lock the AGF so skip this AG. */
+				if (error == -EAGAIN)
+					error = 0;
+				goto out_no_agbp;
+			}
 		}
 	}
 
@@ -2691,69 +2793,22 @@ xfs_alloc_fix_freelist(
 	 * regenerated AGFL, bnobt, and cntbt.  See repair/phase5.c and
 	 * repair/rmap.c in xfsprogs for details.
 	 */
-	memset(&targs, 0, sizeof(targs));
-	/* struct copy below */
 	if (flags & XFS_ALLOC_FLAG_NORMAP)
-		targs.oinfo = XFS_RMAP_OINFO_SKIP_UPDATE;
+		oinfo = XFS_RMAP_OINFO_SKIP_UPDATE;
 	else
-		targs.oinfo = XFS_RMAP_OINFO_AG;
+		oinfo = XFS_RMAP_OINFO_AG;
 	while (!(flags & XFS_ALLOC_FLAG_NOSHRINK) && pag->pagf_flcount > need) {
 		error = xfs_alloc_get_freelist(pag, tp, agbp, &bno, 0);
 		if (error)
 			goto out_agbp_relse;
 
 		/* defer agfl frees */
-		xfs_defer_agfl_block(tp, args->agno, bno, &targs.oinfo);
+		xfs_defer_agfl_block(tp, args->agno, bno, &oinfo);
 	}
 
-	targs.tp = tp;
-	targs.mp = mp;
-	targs.agbp = agbp;
-	targs.agno = args->agno;
-	targs.alignment = targs.minlen = targs.prod = 1;
-	targs.type = XFS_ALLOCTYPE_THIS_AG;
-	targs.pag = pag;
-	error = xfs_alloc_read_agfl(pag, tp, &agflbp);
-	if (error)
-		goto out_agbp_relse;
-
-	/* Make the freelist longer if it's too short. */
-	while (pag->pagf_flcount < need) {
-		targs.agbno = 0;
-		targs.maxlen = need - pag->pagf_flcount;
-		targs.resv = XFS_AG_RESV_AGFL;
-
-		/* Allocate as many blocks as possible at once. */
-		error = xfs_alloc_ag_vextent(&targs);
-		if (error)
-			goto out_agflbp_relse;
-
-		/*
-		 * Stop if we run out.  Won't happen if callers are obeying
-		 * the restrictions correctly.  Can happen for free calls
-		 * on a completely full ag.
-		 */
-		if (targs.agbno == NULLAGBLOCK) {
-			if (flags & XFS_ALLOC_FLAG_FREEING)
-				break;
-			goto out_agflbp_relse;
-		}
-		/*
-		 * Put each allocated block on the list.
-		 */
-		for (bno = targs.agbno; bno < targs.agbno + targs.len; bno++) {
-			error = xfs_alloc_put_freelist(pag, tp, agbp,
-							agflbp, bno, 0);
-			if (error)
-				goto out_agflbp_relse;
-		}
-	}
-	xfs_trans_brelse(tp, agflbp);
 	args->agbp = agbp;
 	return 0;
 
-out_agflbp_relse:
-	xfs_trans_brelse(tp, agflbp);
 out_agbp_relse:
 	if (agbp)
 		xfs_trans_brelse(tp, agbp);
-- 
2.24.4

