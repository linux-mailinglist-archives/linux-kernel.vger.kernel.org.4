Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0B697484
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBOCs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:48:56 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8C31E39
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:48:53 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230215024851epoutp0445c4e757c94c42c870eef651fd3010e4~D35hfiFNj2351623516epoutp04f
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:48:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230215024851epoutp0445c4e757c94c42c870eef651fd3010e4~D35hfiFNj2351623516epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676429331;
        bh=WBBMh11k+5k+trQqfhsCGIiCubTA7xgMqB9364lgdrs=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=liNxrF0aVnd/iaPaj38Nn3N/k2G6HTrz8wt2BDoqSJcfrLwMEwG045diS7RGhvrxC
         R4jVHWpIb1EFhh4n6yASjyBg51KBZIYlaJaCaCuAw9DiiP//iOwqHf6dC7Cr008wy6
         dKw1a0LjKfM3XOjyCc63ptXbxjOSOFfElIbZlOrc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230215024851epcas2p1f721c7342ecb6dc5a28c0b732bbe6d64~D35g-T9mH1382613826epcas2p1-;
        Wed, 15 Feb 2023 02:48:51 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PGjFZ756Rz4x9Px; Wed, 15 Feb
        2023 02:48:50 +0000 (GMT)
X-AuditID: b6c32a46-cee5fa8000007a4b-57-63ec48127d0c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.56.31307.2184CE36; Wed, 15 Feb 2023 11:48:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v1] f2fs: fix uninitialized skipped_gc_rwsem
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p2>
Date:   Wed, 15 Feb 2023 11:48:50 +0900
X-CMS-MailID: 20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmha6Qx5tkg8VdVhanp55lslj1INzi
        yfpZzBaXFrlbXN41h81iVcdcRoup548wObB7bFrVyeaxe8FnJo++LasYPT5vkgtgicq2yUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzmhZ/IK5
        4AVbxeR5v9kbGG+wdjFyckgImEj0XfnL0sXIxSEksINR4vn+dWxdjBwcvAKCEn93CIPUCAvY
        SHQtvMkGYgsJKElcO9DLAhHXl9i8eBk7iM0moCvxd8NyMFtE4BWjxJnVoiA2s0CQxP0pD6B2
        8UrMaH/KAmFLS2xfvpURwtaQ+LGslxnCFpW4ufotO4z9/th8qBoRidZ7Z6FqBCUe/NwNFZeU
        WHToPBOEnS/xd8V1Ngi7RmJrQxtUXF/iWsdGFoi3fCVmXBcBCbMIqEr8nTEX6hwXiWUzrrBD
        nCwvsf3tHGaQcmYBTYn1u/RBTAkBZYkjt1ggKvgkOg7/ZYd5ase8J1CL1CQ2b9oM9ayMxIXH
        bVBHekhM2nqPGRKAgRKHtt1jncCoMAsRzLOQ7J2FsHcBI/MqRrHUguLc9NRiowIjeMwm5+du
        YgSnQy23HYxT3n7QO8TIxMF4iFGCg1lJhFf46YtkId6UxMqq1KL8+KLSnNTiQ4ymQB9PZJYS
        Tc4HJuS8knhDE0sDEzMzQ3MjUwNzJXFeaduTyUIC6YklqdmpqQWpRTB9TBycUg1MocqPVGuy
        1T/5FXpy2kfaFviWyvzV//uR4ePBGX26d2fem2YVtpP10x9+tt/qVoe6rIOKGtZMizbI/To3
        9N0W3kCNf390DRNfhsbtOnP4s7dQzu4Qhvq1jGu3T5uutTOoU6f9w5wdvXvaHx4XtXJ7zWIW
        a/6l5HOR+Unxf+1T3dq3NWqwV175vq9J69ZTLQvZqKLLqdub1jvKHAgU6TW9d4VttoJD/7/d
        LNpmMgoX3j3eWSK7R7O1p5pt5/2AScIX9s54eJz30iNBBVOPNWnPzj9eGmb1sOzio5D5ixJ+
        Kn3gWJ0vyP38UKGmZKDnT0vxS/cTF9xW2rv2QOHE+/vFA6MWbzRZuGxukF9My+cFSizFGYmG
        WsxFxYkAqa50JxAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When f2fs skipped a gc round during victim migration, there was a bug which
would skip all upcoming gc rounds unconditionally because skipped_gc_rwsem
was not initialized. It fixes the bug by correctly initializing the
skipped_gc_rwsem inside the gc loop.

Fixes: d147ea4adb96 ("f2fs: introduce f2fs_gc_control to consolidate f2fs_gc parameters")
Signed-off-by: Yonggil Song <yonggil.song@samsung.com>

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b22f49a6f128..81d326abaac1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1786,8 +1786,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 				prefree_segments(sbi));
 
 	cpc.reason = __get_cp_reason(sbi);
-	sbi->skipped_gc_rwsem = 0;
 gc_more:
+	sbi->skipped_gc_rwsem = 0;
 	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
 		ret = -EINVAL;
 		goto stop;
-- 
2.34.1
