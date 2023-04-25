Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD20D6EDDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjDYIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjDYIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:11:27 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92119BC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:11:22 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230425081120epoutp04684e4e4264abb76f48ffeee196ce28ea~ZHzx2JAsn2180321803epoutp04-
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:11:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230425081120epoutp04684e4e4264abb76f48ffeee196ce28ea~ZHzx2JAsn2180321803epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682410280;
        bh=N9nZClz1ANv1MSriHoOK5Bg8AtRXHwknq59cqaN77a4=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=JPa8CrndElNzSJWpeOsGXwQC+8o6nAe5vbZIuIT7Trin2OzMPOe03uAWRa2V70hpR
         qtSv176bCa9oVUFdrt2gTns5vKovX0whwoDnmzUDiry2hvE64bCuS58u0FrSxfb0lV
         3zj28oAoUOOUtXZuvnXmyVokfhYolURM+bT0An9o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230425081119epcas2p362a5ce622a454811946cb125facd264a~ZHzxQFGPs1780917809epcas2p3A;
        Tue, 25 Apr 2023 08:11:19 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q5F7q19vfz4x9QN; Tue, 25 Apr
        2023 08:11:19 +0000 (GMT)
X-AuditID: b6c32a48-c8660a8000005998-9c-64478b26d1f2
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.24.22936.62B87446; Tue, 25 Apr 2023 17:11:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: add async reset zone command support
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
CC:     Daejun Park <daejun7.park@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c@epcms2p8>
Date:   Tue, 25 Apr 2023 17:10:18 +0900
X-CMS-MailID: 20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmha56t3uKwbm7TBYX5n1ktjg99SyT
        xctDmharHoRbPFk/i9ni0iJ3i8u75rBZHFl/lsVi8XI1i30dD5gsVnXMZbSYev4IkwOPR8u+
        W+wem1Z1snnsXvCZyaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        mBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0x7s4+5YJlhxeT791gbGN9qdDFyckgImEgs+HGf
        vYuRi0NIYAejRO/tZpYuRg4OXgFBib87hEFqhAXsJDYt3sYIYgsJKEmsvziLHSKuJ3Hr4Rqw
        OJuAjsT0E/fB4iICU5klDm9KBZnJLLCYUWLtohlMEMt4JWa0P2WBsKUlti/fyghha0j8WNbL
        DGGLStxc/ZYdxn5/bD5UjYhE672zUDWCEg9+7oaKS0rcnrsJqj5f4v+V5VB2jcS2A/OgbH2J
        ax0bwfbyCvhKnF14GizOIqAq8XLfA1aIGheJ21vegc1nFpCX2P52DjMoHJgFNCXW79IHMSUE
        lCWO3GKBqOCT6Dj8lx3mq4aNv7Gyd8x7AvW5msS6n+uZIMbISNyaxziBUWkWIpxnIVk7C2Ht
        AkbmVYxiqQXFuempxUYFJvCoTc7P3cQITqRaHjsYZ7/9oHeIkYmD8RCjBAezkggvb6V7ihBv
        SmJlVWpRfnxRaU5q8SFGU6CHJzJLiSbnA1N5Xkm8oYmlgYmZmaG5kamBuZI478cO5RQhgfTE
        ktTs1NSC1CKYPiYOTqkGpujkxt8rwpxr2WZX/Sk/2cfSlVm6nkGna4bOM4d/r+zn3m+ffuhR
        fsG0jb8iNljeZdq5UshX7Nbv+hgxqcs6E+a6uX2u843wu6ye/EjyeZVlybK+e9dvP1x7hXfT
        id1Psg48/n/+p4xL/QrxJfrqfjWbF54NYfX6z8y+WlvOOeV6MNeUWRfeyBv9uh/OfZz1stXG
        NzOrzfaL3VuaKr/N826L3M4rR3dpz1BeaxRnm5b8/8irM8Knclc7Xj9a8vudZ6pzd3qi3jXl
        jq6adze2rilx/BV9QX6vTeCfnSxnVz9MXVYvuH7GhMsfLBR9l6mb/mRb/JI9IJ5rbcasjNCf
        ruHmM1LPMnGmOmSczcpzXaTEUpyRaKjFXFScCABwcRX+LQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c
References: <CGME20230425081018epcms2p8fefa94810f0b341d2cbd70ba587e9e8c@epcms2p8>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

v1 -> v2
Changed to apply the optional async reset write pointer by default.


This patch enables submit reset zone command asynchornously. It helps
decrease average latency of write IOs in high utilization scenario by
faster checkpointing.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/segment.c           | 95 ++++++++++++++++++++++++++++++++++---
 include/trace/events/f2fs.h | 18 ++++++-
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 82430f80c5da..27074a6eaf20 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1195,6 +1195,46 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+static int __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
+				   struct discard_cmd *dc, blk_opf_t flag,
+				   struct list_head *wait_list,
+				   unsigned int *issued)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct block_device *bdev = dc->bdev;
+	struct bio *bio = bio_alloc(bdev, 0, REQ_OP_ZONE_RESET | flag, GFP_NOFS);
+	unsigned long flags;
+
+	trace_f2fs_issue_reset_zone(bdev, SECTOR_FROM_BLOCK(dc->di.start));
+
+	spin_lock_irqsave(&dc->lock, flags);
+	dc->state = D_SUBMIT;
+	dc->bio_ref++;
+	spin_unlock_irqrestore(&dc->lock, flags);
+
+	if (issued)
+		(*issued)++;
+
+	atomic_inc(&dcc->queued_discard);
+	dc->queued++;
+	list_move_tail(&dc->list, wait_list);
+
+	/* sanity check on discard range */
+	__check_sit_bitmap(sbi, dc->di.lstart, dc->di.lstart + dc->di.len);
+
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(dc->di.start);
+	bio->bi_private = dc;
+	bio->bi_end_io = f2fs_submit_discard_endio;
+	submit_bio(bio);
+
+	atomic_inc(&dcc->issued_discard);
+
+	return 0;
+}
+#endif
+
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 				struct discard_policy *dpolicy,
@@ -1216,6 +1256,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		return 0;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev))
+		return __submit_zone_reset_cmd(sbi, dc, flag, wait_list, issued);
+#endif
+
 	trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
 
 	lstart = dc->di.lstart;
@@ -1460,21 +1505,42 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 	}
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static void __queue_zone_reset_cmd(struct f2fs_sb_info *sbi,
+		struct block_device *bdev, block_t blkstart, block_t blklen)
+{
+	block_t lblkstart = blkstart;
+
+	if (f2fs_is_multi_device(sbi)) {
+		int devi = f2fs_target_device_index(sbi, blkstart);
+
+		blkstart -= FDEV(devi).start_blk;
+	}
+
+	trace_f2fs_queue_reset_zone(bdev, blkstart);
+
+	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
+	__insert_discard_cmd(sbi, bdev, lblkstart, blkstart, blklen);
+	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
+}
+#endif
+
 static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 	block_t lblkstart = blkstart;
 
+	trace_f2fs_queue_discard(bdev, blkstart, blklen);
+
 	if (!f2fs_bdev_support_discard(bdev))
 		return;
 
-	trace_f2fs_queue_discard(bdev, blkstart, blklen);
-
 	if (f2fs_is_multi_device(sbi)) {
 		int devi = f2fs_target_device_index(sbi, blkstart);
 
 		blkstart -= FDEV(devi).start_blk;
 	}
+
 	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
 	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
 	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
@@ -1725,7 +1791,18 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	dc = __lookup_discard_cmd(sbi, blkaddr);
 	if (dc) {
 		if (dc->state == D_PREP) {
-			__punch_discard_cmd(sbi, dc, blkaddr);
+			if (f2fs_sb_has_blkzoned(sbi) &&
+			    bdev_is_zoned(dc->bdev)) {
+				struct discard_policy dpolicy;
+				/* force submit zone reset */
+				__init_discard_policy(sbi, &dpolicy,
+						      DPOLICY_FORCE, 1);
+				__submit_discard_cmd(sbi, &dpolicy, dc, NULL);
+				dc->ref++;
+				need_wait = true;
+			} else {
+				__punch_discard_cmd(sbi, dc, blkaddr);
+			}
 		} else {
 			dc->ref++;
 			need_wait = true;
@@ -1875,9 +1952,15 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 				 blkstart, blklen);
 			return -EIO;
 		}
-		trace_f2fs_issue_reset_zone(bdev, blkstart);
-		return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-					sector, nr_sects, GFP_NOFS);
+
+		if (unlikely(!is_sbi_flag_set(sbi, SBI_POR_DOING))) {
+			trace_f2fs_issue_reset_zone(bdev, blkstart);
+			return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+						sector, nr_sects, GFP_NOFS);
+		}
+
+		__queue_zone_reset_cmd(sbi, bdev, lblkstart, blklen);
+		return 0;
 	}
 
 	/* For conventional zones, use regular discard if supported */
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 99cbc5949e3c..ee1477de8324 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1512,7 +1512,7 @@ DEFINE_EVENT(f2fs_discard, f2fs_remove_discard,
 	TP_ARGS(dev, blkstart, blklen)
 );
 
-TRACE_EVENT(f2fs_issue_reset_zone,
+DECLARE_EVENT_CLASS(f2fs_reset_zone,
 
 	TP_PROTO(struct block_device *dev, block_t blkstart),
 
@@ -1528,11 +1528,25 @@ TRACE_EVENT(f2fs_issue_reset_zone,
 		__entry->blkstart = blkstart;
 	),
 
-	TP_printk("dev = (%d,%d), reset zone at block = 0x%llx",
+	TP_printk("dev = (%d,%d), zone at block = 0x%llx",
 		show_dev(__entry->dev),
 		(unsigned long long)__entry->blkstart)
 );
 
+DEFINE_EVENT(f2fs_reset_zone, f2fs_queue_reset_zone,
+
+	TP_PROTO(struct block_device *dev, block_t blkstart),
+
+	TP_ARGS(dev, blkstart)
+);
+
+DEFINE_EVENT(f2fs_reset_zone, f2fs_issue_reset_zone,
+
+	TP_PROTO(struct block_device *dev, block_t blkstart),
+
+	TP_ARGS(dev, blkstart)
+);
+
 TRACE_EVENT(f2fs_issue_flush,
 
 	TP_PROTO(struct block_device *dev, unsigned int nobarrier,
-- 
2.25.1

