Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097926C7443
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCWXr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWXr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6C22A05
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 571C062903
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF1BC433D2;
        Thu, 23 Mar 2023 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679615273;
        bh=738p3ibTqVlY5mo1Jphm9v6tZjFmkt3auqk1E27jx2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YX7qSzBHOGjz+BQPpzLCv8yiAK0SsfYCgirUAoFcvlONRTp3PKeOdKIUisWMWvk1W
         M+/vWyIaPrJAA98QXQjryNlmcdT3D8ioXCPJz6E1kmJuOCwWl4zb6yoIWlQ098wVok
         0aCl1PW9aVeWI7FX8q9l6TGt2hySWekuX37e3gMQCtjsXdivfg9xCmGM5GtAIn18VX
         +dfH9pP80T66PSNS+sMHZ+3BHIDE+XzFOCksaDRExndCyRYXv8DBZBUPuxTD9uvF0Z
         fOA5dInQiforFZI81AoG2yQmXQ75L/lcSm3HVw/o4bBkXtYdukiRHq8SZmxdgbRkav
         ecLJ9DdTj7w6Q==
Date:   Thu, 23 Mar 2023 16:47:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yohan Joung <jyh429@gmail.com>
Cc:     lkp@intel.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Yohan Joung <yohan.joung@sk.com>
Subject: Re: [PATCH] f2fs: fix align check for npo2
Message-ID: <ZBzlJ36kO5KvxODB@google.com>
References: <202303231039.GKLRE8O5-lkp@intel.com>
 <20230323072338.175-1-jyh429@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323072338.175-1-jyh429@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Yohan Joung wrote:
> Fix alignment check to be correct in npo2 as well
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 055e70e77aa2..46458085a8d0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1858,7 +1858,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  		sector = SECTOR_FROM_BLOCK(blkstart);
>  		nr_sects = SECTOR_FROM_BLOCK(blklen);
>  
> -		if (sector & (bdev_zone_sectors(bdev) - 1) ||
> +		if (sector % bdev_zone_sectors(bdev) ||

Need to use div_u64_rem()?

>  				nr_sects != bdev_zone_sectors(bdev)) {
>  			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted (block %x + %x)",
>  				 devi, sbi->s_ndevs ? FDEV(devi).path : "",
> 
> base-commit: d15180a8d1d72c7bddcb700d2c9ffdab7d2b9481
> -- 
> 2.25.1
