Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF096AD0DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCFVwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCFVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:52:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6766907E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:52:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9BED60F58
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA2C4339B;
        Mon,  6 Mar 2023 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678139521;
        bh=kO0Keh//hnfQf8ULbQJWCH8cX47nO17LVIchs+as6WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YB3IQJ2xZiXWlJSkxMXIgc658PghDmAlpzfen7DzM6yBsYExhqY7DYF741alTyqRi
         KoPeGZ99XE2t7ZQc86cJfnpXmQA1hXLiuPz7WTQlIlP4wOcdQt5E0W6w3kaXBUT7B3
         +lEo80rezUP/7mpU9wFNdmaHAsoayTfEF8ZOxCiWohBBmYwHS4Ot/BbRd1q8O7nnMZ
         KG1uuMAqQeaLZzkPiydzMLscJT+QCRpFb5TUrZvoh9t+dQseK0sjZulbHoO3DWsw7P
         cxdKlQoMJ34cWpBofSl6UBH5qO9e6E+74Bp72zlQP5+C8VQDWAp0c8C8MGiMtPAgs+
         oXVxtLf7w8ZDg==
Date:   Mon, 6 Mar 2023 13:51:59 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yonggil Song <yonggil.song@samsung.com>
Cc:     Chao Yu <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daehojeong@google.com" <daehojeong@google.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
Subject: Re: [PATCH v2] f2fs: fix uninitialized skipped_gc_rwsem
Message-ID: <ZAZgf4sbh14sVZMp@google.com>
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p7>
 <20230216071350epcms2p7b3f5f37b168b634ec7a7ba8555fd0b49@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216071350epcms2p7b3f5f37b168b634ec7a7ba8555fd0b49@epcms2p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16, Yonggil Song wrote:
> When f2fs skipped a gc round during victim migration, there was a bug which
> would skip all upcoming gc rounds unconditionally because skipped_gc_rwsem
> was not initialized. It fixes the bug by correctly initializing the
> skipped_gc_rwsem inside the gc loop.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")

Applied with the below fix.

Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc"

> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index b22f49a6f128..81d326abaac1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1786,8 +1786,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>  				prefree_segments(sbi));
>  
>  	cpc.reason = __get_cp_reason(sbi);
> -	sbi->skipped_gc_rwsem = 0;
>  gc_more:
> +	sbi->skipped_gc_rwsem = 0;
>  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>  		ret = -EINVAL;
>  		goto stop;
> -- 
> 2.34.1
