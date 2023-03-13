Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5A6B731C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCMJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCMJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:48:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C00168AB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:48:30 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230313094827epoutp020d50025fc958c3f88e58f31940ba39b0~L8ZTEaNEg0137001370epoutp02v
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:48:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230313094827epoutp020d50025fc958c3f88e58f31940ba39b0~L8ZTEaNEg0137001370epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678700907;
        bh=IJ4uA0edrYRShANGVQu8z7uWX3r+wVwyvh58KR1qTbQ=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=sYYr1nJRi+tcZ81xDTCXAFeacWPR37kp1tpOrxvgNsrotHj56LRlaEBK2ufB9TAPE
         6r/m3v4XEnzH147NXCa0V+HZUU5+E9kLHtIsdR1SqKcXDskaeBwUEXQAx7FYZGPqWW
         U6sBMIJQItvsaSfrMLR49vbST0UL24u8aON2rKJU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230313094826epcas2p2e769dc1e9a07591bfb1d75bfc878dae8~L8ZR5SBGz2865928659epcas2p2H;
        Mon, 13 Mar 2023 09:48:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PZsKj3VvLz4x9Pw; Mon, 13 Mar
        2023 09:48:25 +0000 (GMT)
X-AuditID: b6c32a45-e942ca800001f1e7-65-640ef1694088
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.98.61927.961FE046; Mon, 13 Mar 2023 18:48:25 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v1] f2fs: Fix discard bug on zoned block devices with 2MiB
 zone size
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
Message-ID: <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
Date:   Mon, 13 Mar 2023 18:48:25 +0900
X-CMS-MailID: 20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmmW7mR74Ug6ZpYhanp55lsniyfhaz
        xaVF7haXd81hs5h6/giTA6vHplWdbB67F3xm8ujbsorR4/MmuQCWqGybjNTElNQihdS85PyU
        zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
        0pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjB133jAVnOasWH1pC1sD
        4xP2LkZODgkBE4kn99YzdzFycQgJ7GCUODp/NpDDwcErICjxd4cwSI2wQJjExkefmEFsIQEl
        iWsHelkg4voSmxcvA5vDJqAr8XfDcjBbROAVo8SZ1aIQ83klZrQ/ZYGwpSW2L9/KCGFrSPxY
        1ssMYYtK3Fz9lh3Gfn9sPlSNiETrvbNQNYISD37uhopLSiw6dJ4Jws6X+LviOhuEXSOxtaEN
        Kq4vca1jI9heXgFfiS/t58F6WQRUJa5P/gpV7yLRfmEu2HxmAXmJ7W/ngL3OLKApsX6XPogp
        IaAsceQWC0QFn0TH4b/sMF/tmPcEapOaxOZNm1khbBmJC4/boK70kHi7vIUJEmqBEmvvvWGZ
        wCg/CxG2s5DsnYWwdwEj8ypGsdSC4tz01GKjAkN4dCbn525iBKc5LdcdjJPfftA7xMjEwXiI
        UYKDWUmEdws/T4oQb0piZVVqUX58UWlOavEhRlOgjycyS4km5wMTbV5JvKGJpYGJmZmhuZGp
        gbmSOK+07clkIYH0xJLU7NTUgtQimD4mDk6pBib+f5c4nUtXThH32bukQGLW4zyOtetexgXe
        1fhYb87s8fy1ctetBV3r2w7lnZy6r/Wz2MlTT1buX1LtOm2eVZ/bosojbXWPHyU8mblBYO7B
        wOsLHt+Zycig87b/TWj1gagjV+zWc66Y6XX2j+qLi7IPp229ffMP3+qTl4x/Xnh/I2dRcB/X
        8dDMN7MkVIyP98lPXsxxfI3gX6OzDmcOKHTr7dk49ZNzUt2/0C2GOU9ie1fIX5hb9POnsJJF
        k9zyJ1dXM8xkjI64+dtVoW5TncvuSfNuz/2xMpuX29VGbuL/n58sTfsKeHNe/p64vzOZ17qi
        jGtJ0PP1CmX2GVp25YLtSy6ucdmrk5byxe+F7cbSo0osxRmJhlrMRcWJAI4dXln8AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using f2fs on a zoned block device with 2MiB zone size, IO errors
occurs because f2fs tries to write data to a zone that has not been reset.

The cause is that f2fs tries to discard multiple zones at once. This is
caused by a condition in f2fs_clear_prefree_segments that does not check
for zoned block devices when setting the discard range. This leads to
invalid reset commands and write pointer mismatches.

This patch fixes the zoned block device with 2MiB zone size to reset one
zone at a time.

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..2b6cb6df623b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					(end - 1) <= cpc->trim_end)
 				continue;
 
-		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
+		if (!f2fs_sb_has_blkzoned(sbi) &&
+		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
 				(end - start) << sbi->log_blocks_per_seg);
 			continue;
-- 
2.34.1

