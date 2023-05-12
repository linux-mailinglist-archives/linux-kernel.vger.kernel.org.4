Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D496FFF90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjELEQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:16:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0E4EFE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:16:14 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230512041611epoutp03134bbcdb831527ec107ebb1e087854cd~eSkUrXnMC1950419504epoutp03N
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:16:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230512041611epoutp03134bbcdb831527ec107ebb1e087854cd~eSkUrXnMC1950419504epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683864971;
        bh=v0F36rdhCqmYHzWYCcSPoz47p9NTpAJZ63jsBopms9k=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=uxvtEuD/qycRzM3UlP2AR/4D8BIUc7CpiQ/9/UtV4bJm9eFjAfzqrKvFw75diVJyz
         hO9oQardNXTuYcKqdSLF+TYrMvYAVsbd+TdusCtPV+XyNEoAOGQNqjUeXMmjVSywwK
         ZCY34nSp2Zm9N5spgEzKePDL1mk7pnwK8k0ixjsA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230512041611epcas2p205e0bc905f352e9afb7f95c468911e09~eSkUWIr0p0853708537epcas2p2R;
        Fri, 12 May 2023 04:16:11 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QHb6f6fd4z4x9QB; Fri, 12 May
        2023 04:16:10 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-af-645dbd8ab9e8
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.2D.22936.A8DBD546; Fri, 12 May 2023 13:16:10 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v1] f2fs: Fix over-estimating free section during FG GC
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
Date:   Fri, 12 May 2023 13:16:10 +0900
X-CMS-MailID: 20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTVLdrb2yKwYENZhYX5n1ktjg99SyT
        xaoH4RZP1s9itri0yN3i8q45bBarOuYyWkw9f4TJgcNj06pONo/dCz4zefRtWcXo8XmTXABL
        VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
        jLMPZ7EVdIhWvLwq38D4TqCLkZNDQsBEYm/nQdYuRi4OIYEdjBITXp9l6WLk4OAVEJT4u0MY
        pEZYwF3i4oa9rCC2kICSxLUDvSwQcX2JzYuXsYPYbAK6En83LAezRQReMUqcWS0KYjMLVEhs
        /vCSBWIXr8SM9qdQtrTE9uVbGSFsDYkfy3qZIWxRiZur37LD2O+PzYeqEZFovXcWqkZQ4sHP
        3VBxSYlFh84zQdj5En9XXGeDsGsktja0QcX1Ja51bATbyyvgK3HteDNYnEVAVWLLrC9Q9S4S
        879tY4e4WV5i+9s5zKBgYBbQlFi/Sx/ElBBQljhyiwWigk+i4/Bfdpivdsx7ArVJTWLzps2s
        ELaMxIXHbVBXekgcf3WZCRKCgRI3O5tZJjAqzEKE8ywke2ch7F3AyLyKUSy1oDg3PbXYqMAE
        HrPJ+bmbGMGJUctjB+Pstx/0DjEycTAeYpTgYFYS4X27JDpFiDclsbIqtSg/vqg0J7X4EKMp
        0McTmaVEk/OBqTmvJN7QxNLAxMzM0NzI1MBcSZz3Y4dyipBAemJJanZqakFqEUwfEwenVAOT
        p2fyuYo1LrvzqpJSXnQ7PiqbwLJ5fejyZAXlj5LSxy9FmvWku+i/nfTRnsv8mOfsmTNnPDr0
        /6rR1tTc/b0L5KMnrJNbm/z/S5dHwsqQlR1sM24Z8dTdOK54Q/LPltWdykkXc3K2sVXfKG+9
        e3i3ic0H9R9yJspMX5jd9zl/Dw5fxPb4YYqhzYNbm9dcu6jFt3R/2AQb6Yt/mo4IOGv/XLcr
        LWnl1p0MwYzsAXczXzCtCH3/TX7/P9EDM1/JbJe3C57zprEp9mVg/ySJOO63h/XZJn1Ysdgp
        1Pv36hVnyhPqUt7w+MnGHHWYtCNvjsgb9gM7PhZsnZp7zde76nfqLeWj5v2NecHbA7WfJKzO
        VGIpzkg01GIuKk4EABRcudwVBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63
References: <CGME20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a bug that finishing FG GC unconditionally because free sections
are over-estimated after checkpoint in FG GC.
This patch initializes sec_freed by every checkpoint in FG GC.

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 fs/f2fs/gc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d455140322a8..51d7e8d29bf1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1797,7 +1797,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 {
 	int gc_type = gc_control->init_gc_type;
 	unsigned int segno = gc_control->victim_segno;
-	int sec_freed = 0, seg_freed = 0, total_freed = 0;
+	int sec_freed = 0, seg_freed = 0, total_freed = 0, total_sec_freed = 0;
 	int ret = 0;
 	struct cp_control cpc;
 	struct gc_inode_list gc_list = {
@@ -1842,6 +1842,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
+			/* Reset due to checkpoint */
+			sec_freed = 0;
 		}
 	}
 
@@ -1866,15 +1868,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 				gc_control->should_migrate_blocks);
 	total_freed += seg_freed;
 
-	if (seg_freed == f2fs_usable_segs_in_sec(sbi, segno))
+	if (seg_freed == f2fs_usable_segs_in_sec(sbi, segno)) {
 		sec_freed++;
+		total_sec_freed++;
+	}
 
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 		if (has_enough_free_secs(sbi, sec_freed, 0)) {
 			if (!gc_control->no_bg_gc &&
-			    sec_freed < gc_control->nr_free_secs)
+			    total_sec_freed < gc_control->nr_free_secs)
 				goto go_gc_more;
 			goto stop;
 		}
@@ -1901,6 +1905,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		ret = f2fs_write_checkpoint(sbi, &cpc);
 		if (ret)
 			goto stop;
+		/* Reset due to checkpoint */
+		sec_freed = 0;
 	}
 go_gc_more:
 	segno = NULL_SEGNO;
@@ -1913,7 +1919,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	if (gc_type == FG_GC)
 		f2fs_unpin_all_sections(sbi, true);
 
-	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
+	trace_f2fs_gc_end(sbi->sb, ret, total_freed, total_sec_freed,
 				get_pages(sbi, F2FS_DIRTY_NODES),
 				get_pages(sbi, F2FS_DIRTY_DENTS),
 				get_pages(sbi, F2FS_DIRTY_IMETA),
@@ -1927,7 +1933,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	put_gc_inode(&gc_list);
 
 	if (gc_control->err_gc_skipped && !ret)
-		ret = sec_freed ? 0 : -EAGAIN;
+		ret = total_sec_freed ? 0 : -EAGAIN;
 	return ret;
 }
 
-- 
2.34.1
