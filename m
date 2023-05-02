Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98006F3CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjEBERr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:17:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC73AA1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 21:17:34 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230502041730epoutp01d6e27715e952da7e264064cbac685f0d~bOInRZ3Qq0965409654epoutp01T
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:17:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230502041730epoutp01d6e27715e952da7e264064cbac685f0d~bOInRZ3Qq0965409654epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683001050;
        bh=h4HpTDjrPqp6n1tHtvG6n2IcLGmnTi88PxPVIUpI41Q=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=kdMt3j9kvspriM3mSFNkVxDVXTtSMcbvLhXZgYgalkcLNxkkzBcZAMp639aFN/PQ4
         vGDQGh1ghWDGX5eozD1Ffgdyk0s6OvjF/8Su38yYgQ9JqAOyjkv0W1SMAh8iNYElOP
         dpcpsQWN4J8i5q7Rdo1RTHbgCBSw8O9cTQRlzkJU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230502041729epcas2p30506747b2e5967ca9c6e3037045aa594~bOImw2bLF0659306593epcas2p3Q;
        Tue,  2 May 2023 04:17:29 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q9Rcn1HGqz4x9QN; Tue,  2 May
        2023 04:17:29 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-a4-64508ed955ae
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.4A.08199.9DE80546; Tue,  2 May 2023 13:17:29 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4] f2fs: add async reset zone command support
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
CC:     Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230502041628epcms2p7233a97389cebafb73fc525a47215e707@epcms2p7>
Date:   Tue, 02 May 2023 13:16:28 +0900
X-CMS-MailID: 20230502041628epcms2p7233a97389cebafb73fc525a47215e707
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmme7NvoAUg6dT2SwuzPvIbHF66lkm
        i5eHNC1WPQi3eLJ+FrPFpUXuFpd3zWGzOLL+LIvF4uVqFvs6HjBZrOqYy2gx9fwRJgcej5Z9
        t9g9Nq3qZPPYveAzk0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztg5fwJzwW/dii9vfrE0MK5S62Lk5JAQMJHY92EH
        axcjF4eQwA5Gif8nD7N1MXJw8AoISvzdIQxSIyxgJ9HxdSc7iC0koCSx/uIsdoi4nsSth2sY
        QWw2AR2J6Sfug8VFBKYySxzelAoyk1lgMaPE1v8XWSCW8UrMaH8KZUtLbF++lRHC1pD4sayX
        GcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5S4PXcTVH2+xP8ry6HsGoltB+ZB2foS
        1zo2gu3lFfCVeHl6AhOIzSKgKtHybiPUHBeJppuvwWqYBeQltr+dwwwKB2YBTYn1u/RBTAkB
        ZYkjt6Aq+CQ6Dv9lh/mqYeNvrOwd854wQdhqEut+rmeCGCMjcWse4wRGpVmIcJ6FZO0shLUL
        GJlXMYqlFhTnpqcWGxUYw6M2OT93EyM4kWq572Cc8faD3iFGJg7GQ4wSHMxKIrwfCv1ShHhT
        EiurUovy44tKc1KLDzGaAj08kVlKNDkfmMrzSuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeW
        pGanphakFsH0MXFwSjUwdXgp8qZ+WvJOev4p66OujDe1pxW580iLuLAvium0CLL/PVEisqaw
        /FeFvLx1wF/mht0tq5miVtQ0vc+XVH7JtfvP968Kk26IbfiiJVoiGbvv0TMLQb3a0ndTF56a
        IXfu7Gf9BTe3zFgWP4fN/JKD+N7v1Xddkn9/8lO48d01X8BqqmbvBo3U/Ka4qQ8+bu0urJY8
        qhRkP3PPnof7/9dcitjufeCggJkz9+e6qQcWSu+PKzBqMq/nMpzTtfz//okLb3gYNUQ81fjX
        HzAzmE9y1pHedau3NeUZ/2teXbNa7feyn2tbta8ekWy18JW9JbDcbU7S+UcXOD9ffnPbjz80
        xVFMMCZSwiAyN9H6svVkJZbijERDLeai4kQAfh01zS0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502041628epcms2p7233a97389cebafb73fc525a47215e707
References: <CGME20230502041628epcms2p7233a97389cebafb73fc525a47215e707@epcms2p7>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

v3 -> v4
Fixed build error caused by unused function.

v2 -> v3
Modified arguments to be correct for ftrace parameter.
Changed __submit_zone_reset_cmd to void return.
Refactored the f2fs_wait_discard_bio function.
Fixed code that was previously incorrectly merged.

v1 -> v2
Changed to apply the optional async reset write pointer by default.

This patch enables submit reset zone command asynchornously. It helps
decrease average latency of write IOs in high utilization scenario by
faster checkpointing.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/segment.c           | 83 +++++++++++++++++++++++++++++++++++--
 include/trace/events/f2fs.h | 18 +++++++-
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6db410f1bb8c..ec7a8de71198 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1196,6 +1196,44 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+static void __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
+				   struct discard_cmd *dc, blk_opf_t flag,
+				   struct list_head *wait_list,
+				   unsigned int *issued)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct block_device *bdev = dc->bdev;
+	struct bio *bio = bio_alloc(bdev, 0, REQ_OP_ZONE_RESET | flag, GFP_NOFS);
+	unsigned long flags;
+
+	trace_f2fs_issue_reset_zone(bdev, dc->di.start);
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
+}
+#endif
+
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 				struct discard_policy *dpolicy,
@@ -1217,6 +1255,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		return 0;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev)) {
+		__submit_zone_reset_cmd(sbi, dc, flag, wait_list, issued);
+		return 0;
+	}
+#endif
+
 	trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
 
 	lstart = dc->di.lstart;
@@ -1461,6 +1506,19 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 	}
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static void __queue_zone_reset_cmd(struct f2fs_sb_info *sbi,
+		struct block_device *bdev, block_t blkstart, block_t lblkstart,
+		block_t blklen)
+{
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
@@ -1724,6 +1782,19 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 	mutex_lock(&dcc->cmd_lock);
 	dc = __lookup_discard_cmd(sbi, blkaddr);
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (dc && f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev)) {
+		/* force submit zone reset */
+		if (dc->state == D_PREP)
+			__submit_zone_reset_cmd(sbi, dc, REQ_SYNC,
+						&dcc->wait_list, NULL);
+		dc->ref++;
+		mutex_unlock(&dcc->cmd_lock);
+		/* wait zone reset */
+		__wait_one_discard_bio(sbi, dc);
+		return;
+	}
+#endif
 	if (dc) {
 		if (dc->state == D_PREP) {
 			__punch_discard_cmd(sbi, dc, blkaddr);
@@ -1876,9 +1947,15 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 				 blkstart, blklen);
 			return -EIO;
 		}
-		trace_f2fs_issue_reset_zone(bdev, blkstart);
-		return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-					sector, nr_sects, GFP_NOFS);
+
+		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING))) {
+			trace_f2fs_issue_reset_zone(bdev, blkstart);
+			return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+						sector, nr_sects, GFP_NOFS);
+		}
+
+		__queue_zone_reset_cmd(sbi, bdev, blkstart, lblkstart, blklen);
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

