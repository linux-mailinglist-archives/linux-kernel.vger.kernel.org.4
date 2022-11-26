Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0B63934B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKZCQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:16:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0C30F4D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:16:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23219B82AFF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDD6C433D6;
        Sat, 26 Nov 2022 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669429013;
        bh=kDvPHj5wCrq6WnlvH9zd0KKVGoU2QtKs7JnTTAoekQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQjRcdo2n2lwx+A88dpKbiGVImpKl4W2SIvwL8CR4GfPEFlknaNWNymoS59Os1y8s
         wmkajOC2vs/62msCTU7udrSWzdvHlTtvHHiyYsayQk95GYP1+rKZ4IcxeKZPOK/nH7
         Z/mu00lAOp3e2RqqRyIU6M6rMjkpbb6JP5d+Ooi+pP3EGLj/qH2wm9WD+WLEYmeMek
         mVSS6lB7XeMvbxlEIuBr3kMvouLrz0ZluKN5+UCInBMXRnjAJyVZIDToI7BH0WxneK
         JXSXjwkoLruGzlXzlatNbMJVzoQpmyRD2caAQ9bNEV3OUQAcV8Mk2YCZD3ycrVvDud
         JUKWJBCNMpDlQ==
Date:   Sat, 26 Nov 2022 10:16:48 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] erofs: enable large folio support for non-compressed
 format
Message-ID: <Y4F3EGk+0najgTco@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20221126005756.7662-1-jefflexu@linux.alibaba.com>
 <20221126005756.7662-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221126005756.7662-3-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbo,

On Sat, Nov 26, 2022 at 08:57:56AM +0800, Jingbo Xu wrote:
> Enable large folio in both device and fscache mode.  Then the readahead

         ^ large folios in both iomap and fscache modes.

I tend to enable iomap/fscache large folios with two patches.
Also please see dev-test branch.


> routine will pass down large folio containing multiple pages.
> 
> Enable this feature for non-compressed format for now, until the
> compression part supports large folio later.

                            ^ large folios

> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 1 +
>  fs/erofs/inode.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 0643b205c7eb..d2dd58ce312b 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -436,6 +436,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>  		inode->i_size = OFFSET_MAX;
>  		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>  		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +		mapping_set_large_folios(inode->i_mapping);
>  

Meta inodes currently doesn't need large folios for now, and
we don't have readahead policy for these.

>  		ctx->inode = inode;
>  	}
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index ad2a82f2eb4c..85932086d23f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -295,6 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
>  		goto out_unlock;
>  	}
>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +	mapping_set_large_folios(inode->i_mapping);
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  	if (erofs_is_fscache_mode(inode->i_sb))
>  		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> -- 
> 2.19.1.6.gb485710b
> 
