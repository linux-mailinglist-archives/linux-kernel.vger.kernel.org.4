Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8C68B493
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBFDl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBFDlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:41:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967216AF7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:41:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BFB60C77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B97C433EF;
        Mon,  6 Feb 2023 03:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675654870;
        bh=0e5Vf/+wq9RFfzBH3ksPS6To75J3Rc8u/Il3bhGTie0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdpLCcMr6Ug8oCrOURoCovSbDtScoGcswvN+oKO7fkXeQ9l6t4FE8EDKxzLPqinbH
         Q6MLfnhGj7ds7XoGY2XuyJMxJG17bKVlsewPsyGA4l5A+sIk/CMqgb4a7pezgKIha+
         VKzCOFdERR46lNQi9XCDF4KA2lnEC9oGteuEZL3y9xIQmNy04bG0rF099I51T7eU31
         2QLWFl2DyhhmgVvhldUqrJTPJArnG+RyuyYpnQ3fo9g4aZ9E/wZKBp8UgrnAibAZ88
         vEPsXFjuViVM66sj26TxUxq7NoCEjm39iGGfgEKbwP+5xPULox/OC4Y6l3swHC0THo
         ahHGA6do+S5vw==
Date:   Sun, 5 Feb 2023 19:41:08 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] f2fs: clean up __update_extent_tree_range()
Message-ID: <Y+B21EAHfuw2vyJ6@google.com>
References: <20230131144701.34418-1-chao@kernel.org>
 <Y9lkeVCMRA9goN2E@google.com>
 <a27b1135-757f-9609-1511-7c6738887472@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27b1135-757f-9609-1511-7c6738887472@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Chao Yu wrote:
> On 2023/2/1 2:56, Jaegeuk Kim wrote:
> > I wanted to avoid a deep if/else statement.
> 
> So how about this:

Nothing impressive.

> 
> From 418b408420367ac5491c97a7c4d26e3d0e68ea57 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Tue, 31 Jan 2023 22:46:59 +0800
> Subject: [PATCH v2] f2fs: clean up __update_extent_tree_range()
> 
> Introduce __update_read_extent_cache() and __update_age_extent_cache()
> to clean up __update_extent_tree_range(), no logic change.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2
> - introduce __update_read_extent_cache() and __update_age_extent_cache()
> to avoid a deep if/else statement in __update_extent_tree_range().
>  fs/f2fs/extent_cache.c | 116 +++++++++++++++++++++++++++--------------
>  1 file changed, 77 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index d70ad6a44cbf..887b0b2898b9 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -666,6 +666,75 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>  	return en;
>  }
> 
> +static inline bool __update_read_extent_cache(struct inode *inode,
> +					struct extent_info *tei,
> +					struct extent_info *ei,
> +					struct extent_info *dei,
> +					struct extent_info *prev,
> +					unsigned int fofs, unsigned int len,
> +					struct extent_node *prev_en,
> +					struct extent_node *next_en,
> +					struct rb_node **insert_p,
> +					struct rb_node *insert_parent,
> +					bool leftmost)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
> +
> +	if (!tei->blk)
> +		return false;
> +
> +	__set_extent_info(ei, fofs, len, tei->blk, false,
> +			  0, 0, EX_READ);
> +	if (!__try_merge_extent_node(sbi, et, ei,
> +					prev_en, next_en))
> +		__insert_extent_tree(sbi, et, ei,
> +			insert_p, insert_parent, leftmost);
> +
> +	/* give up read extent cache, if split and small updates happen */
> +	if (dei->len >= 1 &&
> +			prev->len < F2FS_MIN_EXTENT_LEN &&
> +			et->largest.len < F2FS_MIN_EXTENT_LEN) {
> +		et->largest.len = 0;
> +		et->largest_updated = true;
> +		set_inode_flag(inode, FI_NO_EXTENT);
> +	}
> +
> +	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +		__free_extent_tree(sbi, et);
> +
> +	if (et->largest_updated) {
> +		et->largest_updated = false;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static inline void __update_age_extent_cache(struct inode *inode,
> +					struct extent_info *tei,
> +					struct extent_info *ei,
> +					unsigned int fofs, unsigned int len,
> +					struct extent_node *prev_en,
> +					struct extent_node *next_en,
> +					struct rb_node **insert_p,
> +					struct rb_node *insert_parent,
> +					bool leftmost)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_BLOCK_AGE];
> +
> +	if (!tei->last_blocks)
> +		return;
> +
> +	__set_extent_info(ei, fofs, len, 0, false,
> +		tei->age, tei->last_blocks, EX_BLOCK_AGE);
> +	if (!__try_merge_extent_node(sbi, et, ei,
> +					prev_en, next_en))
> +		__insert_extent_tree(sbi, et, ei,
> +			insert_p, insert_parent, leftmost);
> +}
> +
>  static void __update_extent_tree_range(struct inode *inode,
>  			struct extent_info *tei, enum extent_type type)
>  {
> @@ -782,47 +851,16 @@ static void __update_extent_tree_range(struct inode *inode,
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
> +	if (type == EX_READ)
> +		updated = __update_read_extent_cache(inode, tei, &ei, &dei,
> +					&prev, fofs, len, prev_en, next_en,
>  					insert_p, insert_parent, leftmost);
> -
> -		/* give up extent_cache, if split and small updates happen */
> -		if (dei.len >= 1 &&
> -				prev.len < F2FS_MIN_EXTENT_LEN &&
> -				et->largest.len < F2FS_MIN_EXTENT_LEN) {
> -			et->largest.len = 0;
> -			et->largest_updated = true;
> -			set_inode_flag(inode, FI_NO_EXTENT);
> -		}
> -	}
> -
> -	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> -		__free_extent_tree(sbi, et);
> -
> -	if (et->largest_updated) {
> -		et->largest_updated = false;
> -		updated = true;
> -	}
> -	goto out_read_extent_cache;
> -update_age_extent_cache:
> -	if (!tei->last_blocks)
> -		goto out_read_extent_cache;
> -
> -	__set_extent_info(&ei, fofs, len, 0, false,
> -			tei->age, tei->last_blocks, EX_BLOCK_AGE);
> -	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
> -		__insert_extent_tree(sbi, et, &ei,
> +	else if (type == EX_BLOCK_AGE)
> +		__update_age_extent_cache(inode, tei, &ei,
> +					fofs, len, prev_en, next_en,
>  					insert_p, insert_parent, leftmost);
> -out_read_extent_cache:
> +
>  	write_unlock(&et->lock);
> 
>  	if (updated)
> -- 
> 2.25.1
> 
> Thanks,
