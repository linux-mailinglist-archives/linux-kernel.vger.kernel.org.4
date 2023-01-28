Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E672C67F73F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjA1Kr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1Kr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:47:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940D73250C
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:47:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3A760B39
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D908C4339C;
        Sat, 28 Jan 2023 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674902845;
        bh=j+QQ4frfhd7/U0TPowl8ebCAvIfb0w0dfp7JE+JYjRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pAa7xA40quWdCu7YlXGQKkTzBURq1QW0vhAUs/6YcBnHM+AJWNCHV4lV160Xss6QJ
         pUmlNCefuRulFCCFHP4u7YuPTDtkcNLtgmMk3puAiEKkf0KFF3gKc5SNbiE+5rSYGL
         9Rp8ME61GjMNvjRY0FlkrzjdkCEI54mX2zykaI/qXH+iILeaWHUx0aoU/rEIHYNZaA
         5l8XFnS6qAWdOEv73K4WT4h6CBCw9zVwMRU/MXa2WxrMiEu1owjhVMGxDQFbYDq+o5
         43PwpJm87q+APDi13U+PW0Bnj/4ViJIDUoowf3fdXi+OWUyNym9S7E7RyOeEzMrHOR
         lpAK1koaWjClg==
Message-ID: <1bd219f7-4990-f0dc-fe07-b434726161e2@kernel.org>
Date:   Sat, 28 Jan 2023 18:47:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: introduce sanity_check_blocks()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230112142213.22784-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230112142213.22784-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/12 22:22, Yangtao Li wrote:
> There are very similar codes in release_compress_blocks() and
> reserve_compress_blocks() which is used for data blocks check.
> 
> This patch introduces a new helper sanity_check_blocks()
> to include those common codes, and used it instead for cleanup.

How about reusing f2fs_sanity_check_cluster()? Something like:

bool f2fs_sanity_check_cluster()

	if (compressed_cluster)
		f2fs_sanity_check_compressed_cluster()
	else
		f2fs_sanity_check_normal_cluster()

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f5c1b7814954..0d539155379c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3369,11 +3369,9 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
>   	return put_user(blocks, (u64 __user *)arg);
>   }
>   
> -static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> +static int sanity_check_blocks(struct dnode_of_data *dn, pgoff_t count)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> -	unsigned int released_blocks = 0;
> -	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>   	block_t blkaddr;
>   	int i;
>   
> @@ -3390,6 +3388,21 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   		}
>   	}
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
> +	if (rc)
> +		return rc;
> +
>   	while (count) {
>   		int compr_blocks = 0;
>   
> @@ -3539,20 +3552,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   	unsigned int reserved_blocks = 0;
>   	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>   	block_t blkaddr;
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
>   	while (count) {
>   		int compr_blocks = 0;
