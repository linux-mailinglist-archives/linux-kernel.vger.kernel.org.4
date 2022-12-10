Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD350648B96
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 01:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLJAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJAYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 19:24:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFEC78BA7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 16:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F67622EC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C92C433D2;
        Sat, 10 Dec 2022 00:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670631843;
        bh=mkQRf8rZZglel4X8c1Cmb05WYQ3DlvFSrxTlbe8Fg2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMnz6XKHeIK4xxbwY8/aw7uvotAQAU6pwJkOnr4m50CTmHQ5L4VYgCy3jcQS3N4wJ
         +PoUSkzTLsuzy6M1t/Kjq/TKu5WXRpasc9GlSesdmGO5uP9Ic4z5MYWJVJ82oDat8v
         Xm96TbwCFMNH/xrY1t3OaEcKk+M9t8KllQkfD4uxQnrl/ehrUQ8H23NQ/AZ4dEh+sU
         JpnjuHTEcIYN0HCzII0hDOEc25H+O3G42oe8nQpLOOCTtHu4gc3eXwaWw7vM7a0wqF
         W63W423ele92yNoHXQvcZ+tENnmPTO2kCybaa77XwtvJ5mvvDqzF1hCu6eL2Tk6DTS
         7CBcuMDcTHJ2Q==
Date:   Sat, 10 Dec 2022 08:23:57 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] erofs/zmap.c: Fix incorrect offset calculation
Message-ID: <Y5PRnfFDJkIOXRCB@debian>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
        Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
References: <20221209102151.311049-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221209102151.311049-1-code@siddh.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:51:51PM +0530, Siddh Raman Pant via Linux-erofs wrote:
> Effective offset to add to length was being incorrectly calculated,
> which resulted in iomap->length being set to 0, triggering a WARN_ON
> in iomap_iter_done().
> 
> Fix that, and describe it in comments.
> 
> This was reported as a crash by syzbot under an issue about a warning
> encountered in iomap_iter_done(), but unrelated to erofs.
> 
> C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
> Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> 
> Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

It looks good to me!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> Changes since v2:
> - Fix the calculation instead of bailing out.
> 
>  fs/erofs/zmap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..a171e4caba3c 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -790,12 +790,16 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
>  		iomap->type = IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
>  		/*
> -		 * No strict rule how to describe extents for post EOF, yet
> -		 * we need do like below. Otherwise, iomap itself will get
> +		 * No strict rule on how to describe extents for post EOF, yet
> +		 * we need to do like below. Otherwise, iomap itself will get
>  		 * into an endless loop on post EOF.
> +		 *
> +		 * Calculate the effective offset by subtracting extent start
> +		 * (map.m_la) from the requested offset, and add it to length.
> +		 * (NB: offset >= map.m_la always)
>  		 */
>  		if (iomap->offset >= inode->i_size)
> -			iomap->length = length + map.m_la - offset;
> +			iomap->length = length + offset - map.m_la;
>  	}
>  	iomap->flags = 0;
>  	return 0;
> -- 
> 2.35.1
> 
> 
