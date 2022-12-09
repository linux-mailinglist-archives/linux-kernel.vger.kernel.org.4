Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD764896E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLIUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:19:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B410B55
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 12:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 103D9B82910
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 20:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D05C433D2;
        Fri,  9 Dec 2022 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670617186;
        bh=n/aLPvjBDYJVMFXxElsDKBo/M3EKYJZF4SnN3OdN5zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzhWZ+5epGcSYwjTVOqnGyRc/3hnCRskyG1PI2aBYuzNq0mRZf6lU/fqHOorwhGNy
         HYINjFWS6Jjfh0Nu6Hx+X4fpCgOm3qqh6oO9iaeA1bGp+IPd3ZPo/4z/N4CM1vKMl4
         EBzIJvcZrdxyKyM2+F2GhVyclV41LEp8wwRVxayv7ck+7JSLQy0leJzQALhS6gDyor
         EbUyBb9bBtntXTW2Wlkgso7jizPCiXJJfhgMyzjgqmyzvMZIcggAuMoIaPj6cJvwX2
         J1PxCrbeVcdCKunufoAQHwfLPMz2D4yWJOcpu/kOfwgaRHxltkZvbzUmnXRoayphMJ
         +1kwkz2VHxMHA==
Date:   Fri, 9 Dec 2022 12:19:44 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     zhoudan8 <zhuqiandann@gmail.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8 <zhoudan8@xiaomi.com>
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not
 compressed
Message-ID: <Y5OYYJYx9G2LbRmc@google.com>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08, zhoudan8 wrote:
> In compress_mode=user, f2fs_release_compress_blocks()
>  does not verify whether it has been compressed and
>  sets FI_COMPRESS_RELEASED directly. which will lead to
> return -EINVAL after calling compress.
> To fix it,let's do not set FI_COMPRESS_RELEASED if file
> is not compressed.

Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
with zero i_compr_blokcs?

I think the current logic is giving the error on a released file already.

> 
> Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> ---
>  fs/f2fs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82cda1258227..f32910077df6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret)
>  		goto out;
> -
> -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
>  	inode->i_ctime = current_time(inode);
>  	f2fs_mark_inode_dirty_sync(inode, true);
>  
>  	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
>  		goto out;
>  
> +	set_inode_flag(inode, FI_COMPRESS_RELEASED);
>  	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> -- 
> 2.38.1
