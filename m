Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9A6337D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiKVJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiKVJDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:03:25 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DEC75B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:03:23 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221122090321epoutp01660ed243f1d34039e7e4ffb82a0f1793~p3LPG-hjo1844318443epoutp01R
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:03:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221122090321epoutp01660ed243f1d34039e7e4ffb82a0f1793~p3LPG-hjo1844318443epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669107801;
        bh=p9LCVLTZUGHskW6P80iZkkOsBwgTL7D4TlYMb1/7yjc=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=D38PXV3Q02Ls+beYpQxX9/lA+prqrFCEV0TkIAgZNhmOmexkdyfSN1cR1fXrTHuJ8
         It8sHZdartG3l2fG0CCclMSzJO1i0Ys8yyhNMIIkGmF/z4CUp5QbGvxe8f8p+qMl4H
         oV5eSf0R90GWGnzP1dSSsuVw93YOZ9xeN/B5NaPI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221122090321epcas2p2b3dcb585fd8e66e0a2abf332f2147064~p3LO5okHY1823518235epcas2p2y;
        Tue, 22 Nov 2022 09:03:21 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NGdZw6cL0z4x9Q9; Tue, 22 Nov
        2022 09:03:20 +0000 (GMT)
X-AuditID: b6c32a47-079a4a8000002127-72-637c90583602
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.2D.08487.8509C736; Tue, 22 Nov 2022 18:03:20 +0900 (KST)
Mime-Version: 1.0
Subject: [RESEND][PATCH] f2fs: avoid victim selection from previous victim
 section
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be@epcms2p2>
Date:   Tue, 22 Nov 2022 18:03:20 +0900
X-CMS-MailID: 20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmuW7EhJpkg6un9SxOTz3LZPFk/Sxm
        i0uL3C0u75rDZjH1/BEmB1aPTas62Tx2L/jM5NG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGRNuOhdM5ar4+uQTUwPj
        Go4uRk4OCQETiX1HLrN1MXJxCAnsYJT4tuIoaxcjBwevgKDE3x3CIDXCAiESP9uXsYLYQgJK
        EtcO9LJAxPUlNi9exg5iswnoSvzdsBzMFhF4xShxZrUoxHxeiRntT1kgbGmJ7cu3MkLYGhI/
        lvUyQ9iiEjdXv2WHsd8fmw9VIyLReu8sVI2gxIOfu6HikhKLDp1ngrDzJf6uuM4GYddIbG1o
        g4rrS1zr2Ai2l1fAV+Lijylg97MIqEo8e7oTqsZF4vLpj2C9zALyEtvfzmEGeZ1ZQFNi/S59
        EFNCQFniyC0WiAo+iY7Df9lhvtox7wnUFDWJzZs2s0LYMhIXHrdBXekh8X7/IiZIqAVKvL34
        l3UCo/wsRNjOQrJ3FsLeBYzMqxjFUguKc9NTi40KjOGxmZyfu4kRnOS03Hcwznj7Qe8QIxMH
        4yFGCQ5mJRHees+aZCHelMTKqtSi/Pii0pzU4kOMpkAfT2SWEk3OB6bZvJJ4QxNLAxMzM0Nz
        I1MDcyVx3q4ZWslCAumJJanZqakFqUUwfUwcnFINTAeefrydv/YwM/+H8Ke3Z2pyvMo7/iTy
        p5BQ5/bE+1f+2urcW/riWx6Lc1fECa3Wn7Nnlf1/Fur6ur5BMmZ27erUiC5mHyffVsYrH39u
        kaia4VTVNbE2aUImh3/Jok1fPx85Ysp11/F9doW9wzYx439Lw2ssWIW2NBTPaXzzRbl6yuQp
        R9ZKJVULe2R9jr+fES3zyumFSF+G8maLqAMv634ozOj/McWhOFeDZ7bor1vF+mdsff3ehV76
        8UXcd52OuKfymdyTf1J2ljW37mRUPmm8J9y1+/1JgwbDXzxT3rvsvSnEYfS+VM9AVdmveeXu
        3O4lZ1+/vbFk+sGL/DFhfH2zHRg2Hs5Weat2cYZ+nRJLcUaioRZzUXEiAHDN5fT7AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be
References: <CGME20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When f2fs chooses GC victim in large section & LFS mode,
next_victim_seg[gc_type] is referenced first. After segment is freed,
next_victim_seg[gc_type] has the next segment number.
However, next_victim_seg[gc_type] still has the last segment number
even after the last segment of section is freed. In this case, when f2fs
chooses a victim for the next GC round, the last segment of previous victim
section is chosen as a victim.

Initialize next_victim_seg[gc_type] to NULL_SEGNO for the last segment in
large section.

Fixes: e3080b0120a1 ("f2fs: support subsectional garbage collection")
Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0f967b1e98f2..f1b68eda2235 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1749,8 +1749,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
 
-		if (__is_large_section(sbi) && segno + 1 < end_segno)
-			sbi->next_victim_seg[gc_type] = segno + 1;
+		if (__is_large_section(sbi))
+			sbi->next_victim_seg[gc_type] =
+				(segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
 skip:
 		f2fs_put_page(sum_page, 0);
 	}
-- 
2.34.1
