Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8C61608F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKBKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKBKIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:08:23 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036A27DF2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:08:02 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221102100758epoutp038640cbe95fce170a05c0faf716d01734~jvJ8AKJ250500705007epoutp03O
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:07:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221102100758epoutp038640cbe95fce170a05c0faf716d01734~jvJ8AKJ250500705007epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667383678;
        bh=c1yrA7+mY0/E6pYmHduyjhr1A56b4q1KtHaiQtno14g=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=BTvEfXEm1NLPEhkuX3h4sBCBn7L7TGUedAi+L21ouyEY0u65xqAUL5zE2js8xgO3Z
         7A3VKPVnboTUmReRiaRnM2WEyknPAQKdCmsk1NgamZg0WJMTeIBWrgceppT34I4BQT
         Xi5weXtMDe2dJsEHCMR9CtR8Gzr8APYNQWYdaL4k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221102100757epcas2p25ed87b9cfb33de7d4fc1e92f8f444eb8~jvJ7uUBM-2151121511epcas2p2d;
        Wed,  2 Nov 2022 10:07:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N2Myj2hStz4x9Pr; Wed,  2 Nov
        2022 10:07:57 +0000 (GMT)
X-AuditID: b6c32a46-ad1fd70000012ff6-42-6362417d1287
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.CF.12278.D7142636; Wed,  2 Nov 2022 19:07:57 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v1] f2fs: avoid victim selection from previous victim
 section
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Seokhwan Kim <sukka.kim@samsung.com>,
        Eunhee Rho <eunhee83.rho@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7@epcms2p2>
Date:   Wed, 02 Nov 2022 19:07:56 +0900
X-CMS-MailID: 20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmmW6tY1KywfZGAYvTU88yWfx80sFm
        8WT9LGaLS4vcLS7vmsNmsapjLqPF1PNHmBzYPTat6mTz2L3gM5NH35ZVjB6fN8kFsERl22Sk
        JqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaCkUJaYUwoU
        CkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM6Yt/IG
        a8E5zootl74wNjC+Ze9i5OCQEDCR2LJVsIuRi0NIYAejRP/9IywgcV4BQYm/O4S7GDk5hAX8
        JWacP8gCYgsJKElcO9DLAhHXl9i8eBk7iM0moCvxd8NyMFtE4BWjxJnVoiA2s0CgxM07H5hA
        bAkBXokZ7U9ZIGxpie3LtzJC2BoSP5b1MkPYohI3V79lh7HfH5sPVSMi0XrvLFSNoMSDn7uh
        4pISiw6dh5qfL/F3xXU2CLtGYmtDG1RcX+Jax0awvbwCvhKvbs4Fi7MIqEoceTQLqt5FYsel
        40wQN8tLbH87hxkUDMwCmhLrd+lDQkpZ4sgtFogKPomOw3/ZYb7aMe8J1CY1ic2bNrNC2DIS
        Fx63QV3pIXH/wy1mSAgGShx9dp9xAqPCLEQ4z0KydxbC3gWMzKsYxVILinPTU4uNCozgMZuc
        n7uJEZwQtdx2ME55+0HvECMTB+MhRgkOZiUR3vqz0clCvCmJlVWpRfnxRaU5qcWHGE2BPp7I
        LCWanA9MyXkl8YYmlgYmZmaG5kamBuZK4rxdM7SShQTSE0tSs1NTC1KLYPqYODilGpiWvVSb
        7njLTSP9f2p1VWR/zOvGiZK1l5c1O31cZ3RkZ6ThtQ8Bl9UkzjN2G187XbNjkk7LwtWJPzmn
        2ZQt9g8Xcdf/tMjnZYBaoGF1U19T54ESv4uLDkY/+rFvmlrDR896+UmCTxedSF+2W2VXwxbL
        heeO3XnzxDG5guvsKoFHdqUrnR5aJ/lPKLOvb5MoWxyvvq9wyq2FHTXK1mqnv74yPd7SUrB2
        zd+dOzQ3PMgq1XvKZCmRZn05+vuCSI+EmTxHZvpbtmzqWmF0USbJ/NzpZMYQ23Mb9D68fHNj
        VWGgs+inFfd2aViaf9zw6BrniTuFqvO3ZfNklfkbny3dWScwzVld1lXGYknn6Z0hgteVWIoz
        Eg21mIuKEwHMJD9REQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7
References: <CGME20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7@epcms2p2>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4546e01b2ee0..10677d53ef0e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1744,8 +1744,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
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
