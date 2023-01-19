Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B7672EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjASCTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASCTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:19:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC44A1D5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:19:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A591AB81FC0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BDBC433D2;
        Thu, 19 Jan 2023 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674094775;
        bh=PhzcDmkGhRVjGbw8rA/j27ZqHma/HzGuMcD0dVpCosk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTxbQ24DVjeX5Fmul0D7mGDM2W55q1zjUo2bT+7jfI37A/f2ZbEOUjwzsv7+E+26b
         LVPXxnhD7XXl3FEeZH8YRfV++4A0QxiSEeHhAx57nBHo7uTLYT5T5ccSeMhTFxE1mn
         V4JdmTns0MoZKQpD08PGObKkVeT7ewjDTguV6fBDnx9gnRvLhni9aeQAeirjMQKBfI
         6P0TK53JOx14uMkMKGoLdOgYkx8DminHo0+sfcLTI0t0tQgB5MUtEsuHU2pUIKmEwB
         I/jRwL6EepOXFqKco2LY5Gd0raZzjJmmngw7gZZ82FHUm0DHBf74eJm13WXVoSxLQn
         ZxftEMEQPMc5w==
Date:   Wed, 18 Jan 2023 18:19:33 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: introduce sanity_check_blocks()
Message-ID: <Y8iotYUXzfPZLhj9@google.com>
References: <20230112142213.22784-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112142213.22784-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Yangtao Li wrote:
> There are very similar codes in release_compress_blocks() and
> reserve_compress_blocks() which is used for data blocks check.
> 
> This patch introduces a new helper sanity_check_blocks()
> to include those common codes, and used it instead for cleanup.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f5c1b7814954..0d539155379c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3369,11 +3369,9 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
>  	return put_user(blocks, (u64 __user *)arg);
>  }
>  
> -static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> +static int sanity_check_blocks(struct dnode_of_data *dn, pgoff_t count)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> -	unsigned int released_blocks = 0;
> -	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>  	block_t blkaddr;
>  	int i;
>  
> @@ -3390,6 +3388,21 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>  		}
>  	}
>  
> +	return 0;
> +}
> +
> +static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> +	unsigned int released_blocks = 0;
> +	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
> +	block_t blkaddr;
> +	int i, rc;
> +
> +	rc = sanity_check_blocks(dn, count);

        ^
        err

> +	if (rc)
> +		return rc;
> +
>  	while (count) {
>  		int compr_blocks = 0;
>  
> @@ -3539,20 +3552,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>  	unsigned int reserved_blocks = 0;
>  	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>  	block_t blkaddr;
> -	int i;
> +	int i, rc;
>  
> -	for (i = 0; i < count; i++) {
> -		blkaddr = data_blkaddr(dn->inode, dn->node_page,
> -						dn->ofs_in_node + i);
> -
> -		if (!__is_valid_data_blkaddr(blkaddr))
> -			continue;
> -		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))) {
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> -			return -EFSCORRUPTED;
> -		}
> -	}
> +	rc = sanity_check_blocks(dn, count);
> +	if (rc)
> +		return rc;
>  
>  	while (count) {
>  		int compr_blocks = 0;
> -- 
> 2.25.1
