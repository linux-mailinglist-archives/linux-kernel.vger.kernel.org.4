Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEB698AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBPC5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:57:52 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6FDF4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:57:48 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230216025745epoutp04c3521f878868160756186d6dcf9a2ef9~ELqksWoSQ1578415784epoutp04f
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:57:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230216025745epoutp04c3521f878868160756186d6dcf9a2ef9~ELqksWoSQ1578415784epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676516265;
        bh=/s/DDvoDqvkI0R3gCjxwHuxsXwGnIrRYiSsKEv400/g=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=W2q1n7vZLO/mbYv4g3UpVezQkggl/3F2/vZo/HI5ICNQ/YeigJCiqrbPcNTzNHTwo
         AvvmCafZJIesovoBrtsCwIwK5qQ1pkh6OAWhn1LIUDN4syVzwAxaHvRdDfF9eGXcBK
         gEOAGYa1NPF5ZfRz9St0Acuv57bR4DP40OzQrEbc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230216025745epcas2p33d13ec8159efa85b6bf194c6f3d6a379~ELqkatBD21025710257epcas2p3e;
        Thu, 16 Feb 2023 02:57:45 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PHKPN5kszz4x9Pw; Thu, 16 Feb
        2023 02:57:44 +0000 (GMT)
X-AuditID: b6c32a46-4e1ff70000007a4b-23-63ed9ba80101
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.2C.31307.8AB9DE36; Thu, 16 Feb 2023 11:57:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: fix uninitialized skipped_gc_rwsem
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
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
Message-ID: <20230216025743epcms2p31d1bde5cfb315d13231010b0a46fbec4@epcms2p3>
Date:   Thu, 16 Feb 2023 11:57:43 +0900
X-CMS-MailID: 20230216025743epcms2p31d1bde5cfb315d13231010b0a46fbec4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmme6K2W+TDf6161ucnnqWyWLVg3CL
        J+tnMVtcWuRucXnXHDaLVR1zGR3YPDat6mTz2L3gM5NH35ZVjB6fN8kFsERl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVZSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcc2zKVteACW8XE
        TZkNjAdYuxg5OSQETCRWzdzD2MXIxSEksINR4sCchSxdjBwcvAKCEn93CIOYwgI2En9v2IGU
        CwkoSVw70MsCYgsL6EtsXryMHcRmE9CV+LthOTvIGBGBB4wSU27sZQNJMAsESdyf8gBqF6/E
        jPanLBC2tMT25VsZIWwNiR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/dUHFJiUWH
        zjNB2PkSf1dcZ4OwayS2NrRBxfUlrnVshHrLV+JokztImEVAVaL15VyoMS4Sf/c3MUOcLC+x
        /e0cZpByZgFNifW79EFMCQFliSO3WCAq+CQ6Dv9lh3lqx7wnUIvUJDZv2gz1rIzEhcdtUNM9
        JCZtvccMCcFAiUf9b9knMCrMQgTzLCR7ZyHsXcDIvIpRLLWgODc9tdiowAgescn5uZsYwSlQ
        y20H45S3H/QOMTJxMB5ilOBgVhLh3XTzTbIQb0piZVVqUX58UWlOavEhRlOgjycyS4km5wOT
        cF5JvKGJpYGJmZmhuZGpgbmSOK+07clkIYH0xJLU7NTUgtQimD4mDk6pBqYijvuHb/GtcF/1
        p+7fZve5DbVr2ff+3My+aB/TtvdLNL90fzTSu1HEF3rbp2Dq/CTp6Zf/rCw02Xp5mvCkCI2M
        3IrPrfq8a5WlGh9Vcxz/vNXrYvXP3K3ndti+1zgh/+bf+zePK/7PV17lftvJJuzEt9NPqk5M
        NltgWX1m3fF/jwVnRFlyV0S7xW66pD3h7pPFbhUrmLnmWNbxJPEwrnq3snuVZezUqNCZr8x3
        rT2wTXQFK89jPuNAc9Z8hlUPfyR5OF3S/rDTR9wuXGWjaVF9/OtmQbFNvW7P2F9WZxRbpZmJ
        aZ5t4X/gcMfeVVzsUfjSH1s8VbdG3vObXHtcVnZb+lNDwS93DpvdPF3hJjNFiaU4I9FQi7mo
        OBEAxwCkCgoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p3>
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

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
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
