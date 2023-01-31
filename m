Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B850D6835D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjAaS5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjAaS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:57:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA7B58659
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:57:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3099DB81E57
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23AC433EF;
        Tue, 31 Jan 2023 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675191418;
        bh=qvFUa7E1gUFD3AT6Y+KBidqT85WZjsogoG0PROP8ouI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yifc5Aql8hTSL7Kv4P9QPYW39QSa0ktn9qisjN64h7RBXyWCcZ+bNDjHPX1IQZG7w
         n95JtcZKEp1bCbTFwP2axXj5tpfC3yDAGtKd+iziDR8MmWVTAkvBDs/4WxbKQnyhPe
         xjYNeSiVOTb7Hc9Cmdkw+Rh0WwLDX0nSwrwM/St+RMWvXVpw7Y9gi9erZfLuBfns8L
         FR6BSPgm/pRip8mwgHfH3Pxoq1IIcMLCl2Lf2cKwr4CgO13T6SbRB+kV8kXlEC+IYP
         h2rKtU8lLXMSObBsh0m6ET+euf/LEOy6rOl6z4d5jcNhvLkx+XD6GV7ZjQzsz80VbG
         ESVxk0634N+eg==
Date:   Tue, 31 Jan 2023 10:56:57 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] f2fs: clean up __update_extent_tree_range()
Message-ID: <Y9lkeVCMRA9goN2E@google.com>
References: <20230131144701.34418-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131144701.34418-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31, Chao Yu wrote:
> No logic change, just avoid goto statement.

I wanted to avoid a deep if/else statement.

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index d70ad6a44cbf..cf65a188d112 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -782,47 +782,43 @@ static void __update_extent_tree_range(struct inode *inode,
>  		en = next_en;
>  	}
>  
> -	if (type == EX_BLOCK_AGE)
> -		goto update_age_extent_cache;
> -
> -	/* 3. update extent in read extent cache */
> -	BUG_ON(type != EX_READ);
> -
> -	if (tei->blk) {
> -		__set_extent_info(&ei, fofs, len, tei->blk, false,
> -				  0, 0, EX_READ);
> -		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
> -			__insert_extent_tree(sbi, et, &ei,
> +	/* 3. update extent in extent cache */
> +	if (type == EX_READ) {
> +		if (tei->blk) {
> +			__set_extent_info(&ei, fofs, len, tei->blk, false,
> +					  0, 0, EX_READ);
> +			if (!__try_merge_extent_node(sbi, et, &ei,
> +							prev_en, next_en))
> +				__insert_extent_tree(sbi, et, &ei,
>  					insert_p, insert_parent, leftmost);
>  
> -		/* give up extent_cache, if split and small updates happen */
> -		if (dei.len >= 1 &&
> -				prev.len < F2FS_MIN_EXTENT_LEN &&
> -				et->largest.len < F2FS_MIN_EXTENT_LEN) {
> -			et->largest.len = 0;
> -			et->largest_updated = true;
> -			set_inode_flag(inode, FI_NO_EXTENT);
> +			/* give up read extent cache, if split and small updates happen */
> +			if (dei.len >= 1 &&
> +					prev.len < F2FS_MIN_EXTENT_LEN &&
> +					et->largest.len < F2FS_MIN_EXTENT_LEN) {
> +				et->largest.len = 0;
> +				et->largest_updated = true;
> +				set_inode_flag(inode, FI_NO_EXTENT);
> +			}
>  		}
> -	}
> -
> -	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> -		__free_extent_tree(sbi, et);
>  
> -	if (et->largest_updated) {
> -		et->largest_updated = false;
> -		updated = true;
> -	}
> -	goto out_read_extent_cache;
> -update_age_extent_cache:
> -	if (!tei->last_blocks)
> -		goto out_read_extent_cache;
> +		if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +			__free_extent_tree(sbi, et);
>  
> -	__set_extent_info(&ei, fofs, len, 0, false,
> -			tei->age, tei->last_blocks, EX_BLOCK_AGE);
> -	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
> -		__insert_extent_tree(sbi, et, &ei,
> +		if (et->largest_updated) {
> +			et->largest_updated = false;
> +			updated = true;
> +		}
> +	} else if (type == EX_BLOCK_AGE) {
> +		if (tei->last_blocks) {
> +			__set_extent_info(&ei, fofs, len, 0, false,
> +				tei->age, tei->last_blocks, EX_BLOCK_AGE);
> +			if (!__try_merge_extent_node(sbi, et, &ei,
> +							prev_en, next_en))
> +				__insert_extent_tree(sbi, et, &ei,
>  					insert_p, insert_parent, leftmost);
> -out_read_extent_cache:
> +		}
> +	}
>  	write_unlock(&et->lock);
>  
>  	if (updated)
> -- 
> 2.36.1
