Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57EA6FA1ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjEHILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:11:51 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F43C22
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:11:48 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230508081144epoutp018117db72d5f0527ecbbade75ab598a0e~dHM1zsLvU3192231922epoutp011
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:11:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230508081144epoutp018117db72d5f0527ecbbade75ab598a0e~dHM1zsLvU3192231922epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683533504;
        bh=yDLIrghah5Nq9w1zHb2JAr9X6r6l9mF3EzuVTGurF8Q=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Qd8a0i7zCGSmgucPJbG+NwEq4e5aRivJ9U5ThnzGk1yddIIJUEJHJIDkKGnzCd4ar
         5qlJW95lCDrhZUXOVXhgxp5iZGUU2Z3cyx8Xqb2DSHJ8GxrwqKkj9Y/6Yg+wgxmanv
         mE5atB4QtG+QDsaggjsJnEdGvq6VvTFlzdgZontA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230508081143epcas2p2f6e6149ac35656956768d00085b1e8a2~dHM1KzgTr2764627646epcas2p2-;
        Mon,  8 May 2023 08:11:43 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QFDXH1bHRz4x9Q4; Mon,  8 May
        2023 08:11:43 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-1c-6458aebf90eb
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.8E.17293.FBEA8546; Mon,  8 May 2023 17:11:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6] f2fs: add async reset zone command support
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
Message-ID: <20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
Date:   Mon, 08 May 2023 17:10:42 +0900
X-CMS-MailID: 20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmme7+dREpBse3c1pcmPeR2eL01LNM
        Fi8PaVqsehBu8WT9LGaLS4vcLS7vmsNmcWT9WRaLxcvVLPZ1PGCyWNUxl9Fi6vkjTA48Hi37
        brF7bFrVyeaxe8FnJo++LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDU
        NbS0MFdSyEvMTbVVcvEJ0HXLzAG6TUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJT
        YF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbH56wPGglsOFTebfjI3ML4z7WLk5JAQMJFY8uEK
        axcjF4eQwA5Gie6zv9m7GDk4eAUEJf7uEAapERawk9i8bzITiC0koCSx/uIsdoi4nsSth2sY
        QWw2AR2J6Sfug8VFBKYySxzelAoyk1lgMaPE1v8XWSCW8UrMaH8KZUtLbF++lRHC1pD4sayX
        GcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5S4PXcTVH2+xP8ry6HsGoltB+ZB2foS
        1zo2gu3lFfCV+H7tFdiPLAKqEv0LMyBKXCT6nj4CG8ksIC+x/e0cZpASZgFNifW79EFMCQFl
        iSO3WCAq+CQ6Dv9lh3mqYeNvrOwd854wQdhqEut+rmeCGCMjcWse4wRGpVmIYJ6FZO0shLUL
        GJlXMYqlFhTnpqcWGxUYwWM2OT93EyM4jWq57WCc8vaD3iFGJg7GQ4wSHMxKIryrEsJShHhT
        EiurUovy44tKc1KLDzGaAv07kVlKNDkfmMjzSuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeW
        pGanphakFsH0MXFwSjUw2bDuvnc2dIMWJ3PNgZaAknfh77z8Xb5fqj1VfPOE1Kq0JsZbxy3b
        FcWahUQtVJw0YrSNnE8WxV+S7dSbWOVopZzz/aGQJdeyBV8vnV/7zUbnnEmSzy233cdSI5h8
        L89WvbTqwaNfD8+e053F1Hvm3vMXvK97v8tePWsz/6mBf6KAhIR5kedvP2kVIUuHhZkZ+2as
        r70TZphudfv1nmUpd69wX9pWms+1JGeRhcDGW59zBb61vjmlscBkZou7keDhZbJL2XsCJkg8
        mlVoeUhEMtxeYd2HL80FTJfz4y0nrc0VOM7ecX7Lgxubu3evbciw38zVycD7xG/jho6axcvj
        Vt9pvbWpKTqg0/rAvc96SizFGYmGWsxFxYkAkK26GCwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5
References: <CGME20230508081042epcms2p8a637deae7de1829f54614e09d5fde5e5@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6
Added trace_f2fs_iostat support for zone reset command.

v4 -> v5
Added f2fs iostat for zone reset command.

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
 fs/f2fs/f2fs.h              |  1 +
 fs/f2fs/iostat.c            |  1 +
 fs/f2fs/segment.c           | 84 +++++++++++++++++++++++++++++++++++--
 include/trace/events/f2fs.h | 24 +++++++++--
 4 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d211ee89c158..51b68a629814 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1175,6 +1175,7 @@ enum iostat_type {
 	/* other */
 	FS_DISCARD_IO,			/* discard */
 	FS_FLUSH_IO,			/* flush */
+	FS_ZONE_RESET_IO,		/* zone reset */
 	NR_IO_TYPE,
 };
 
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 3d5bfb1ad585..f8703038e1d8 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -80,6 +80,7 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 	seq_puts(seq, "[OTHER]\n");
 	IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
 	IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
+	IOSTAT_INFO_SHOW("fs zone reset", FS_ZONE_RESET_IO);
 
 	return 0;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6db410f1bb8c..4802b05a795b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1196,6 +1196,45 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
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
+	f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO, dc->di.len * F2FS_BLKSIZE);
+}
+#endif
+
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 				struct discard_policy *dpolicy,
@@ -1217,6 +1256,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
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
@@ -1461,6 +1507,19 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
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
@@ -1724,6 +1783,19 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 
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
@@ -1876,9 +1948,15 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
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
index 99cbc5949e3c..793f82cc1515 100644
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
@@ -1979,6 +1993,7 @@ TRACE_EVENT(f2fs_iostat,
 		__field(unsigned long long,	fs_nrio)
 		__field(unsigned long long,	fs_mrio)
 		__field(unsigned long long,	fs_discard)
+		__field(unsigned long long,	fs_reset_zone)
 	),
 
 	TP_fast_assign(
@@ -2010,12 +2025,14 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->fs_nrio	= iostat[FS_NODE_READ_IO];
 		__entry->fs_mrio	= iostat[FS_META_READ_IO];
 		__entry->fs_discard	= iostat[FS_DISCARD_IO];
+		__entry->fs_reset_zone	= iostat[FS_ZONE_RESET_IO];
 	),
 
 	TP_printk("dev = (%d,%d), "
 		"app [write=%llu (direct=%llu, buffered=%llu), mapped=%llu, "
 		"compr(buffered=%llu, mapped=%llu)], "
-		"fs [data=%llu, cdata=%llu, node=%llu, meta=%llu, discard=%llu], "
+		"fs [data=%llu, cdata=%llu, node=%llu, meta=%llu, discard=%llu, "
+		"reset_zone=%llu], "
 		"gc [data=%llu, node=%llu], "
 		"cp [data=%llu, node=%llu, meta=%llu], "
 		"app [read=%llu (direct=%llu, buffered=%llu), mapped=%llu], "
@@ -2026,6 +2043,7 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->app_bio, __entry->app_mio, __entry->app_bcdio,
 		__entry->app_mcdio, __entry->fs_dio, __entry->fs_cdio,
 		__entry->fs_nio, __entry->fs_mio, __entry->fs_discard,
+		__entry->fs_reset_zone,
 		__entry->fs_gc_dio, __entry->fs_gc_nio, __entry->fs_cp_dio,
 		__entry->fs_cp_nio, __entry->fs_cp_mio,
 		__entry->app_rio, __entry->app_drio, __entry->app_brio,
-- 
2.25.1

