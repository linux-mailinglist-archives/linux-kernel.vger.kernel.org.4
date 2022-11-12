Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13362662F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiKLB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLB2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:28:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C330F6A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:28:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE790B82885
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A246C433D6;
        Sat, 12 Nov 2022 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668216479;
        bh=MoShBfZdwzrv76NQDM8F3RCjVb1XBmORpbl/oOgsLWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzfiLyomEvyu1Jlh/ptuz+3kSmXVV1j9Q3YNIOUFheOLcuIBHgZwiYiQ8/+xnLHVt
         el/b3QJC1d9inQHC6Rizyv6DXG+FG0FnQtBmWOTY01ODGE+OP/By32ppLqEB0bFzDf
         rQeElz9jrrU1py9sWaBB9drfXAJoHXjWOUAEifHKoVsOKHg2Ac6uulDzfyYrUMetgt
         byg1Cx4k1vVn8rCa9ZYW/nB31oV0QYoj7nquBzNcu4EN009e7Em8nCIqqSTi5VR/hG
         h8ox72aeu8WHizFrhwzL/106ynUtOxy2JTj8JwcZuO9GRrwb2xfbOoJ9icd1WmHZTE
         GMJgAxp2XyEeA==
Date:   Fri, 11 Nov 2022 17:27:57 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sheng Yong <shengyong@oppo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] f2fs: fix to enable compress for newly created
 file if extension matches
Message-ID: <Y272nVjzr6CynmyQ@google.com>
References: <20221111100830.953733-1-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111100830.953733-1-shengyong@oppo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does thes make sense?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=608460dfae20b9d23aa222f7448710a086778222
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=962379487b5cb9f3b85ea367b130c2c6ca584edf

Second one is needed to address build error.

On 11/11, Sheng Yong wrote:
> If compress_extension is set, and a newly created file matches the
> extension, the file could be marked as compression file. However,
> if inline_data is also enabled, there is no chance to check its
> extension since f2fs_should_compress() always returns false.
> 
> This patch moves set_compress_inode(), which do extension check, in
> f2fs_should_compress() to check extensions before setting inline
> data flag.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>  fs/f2fs/namei.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> ---
> v1->v2: add filename parameter for f2fs_new_inode, and move
>         set_compress_inode into f2fs_new_inode
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index e104409c3a0e5..36e251f438568 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -22,8 +22,12 @@
>  #include "acl.h"
>  #include <trace/events/f2fs.h>
>  
> +static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
> +						const unsigned char *name);
> +
>  static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
> -						struct inode *dir, umode_t mode)
> +						struct inode *dir, umode_t mode,
> +						const char *name)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>  	nid_t ino;
> @@ -119,6 +123,8 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
>  		if ((F2FS_I(dir)->i_flags & F2FS_COMPR_FL) &&
>  					f2fs_may_compress(inode))
>  			set_compress_context(inode);
> +		if (name)
> +			set_compress_inode(sbi, inode, name);
>  	}
>  
>  	/* Should enable inline_data after compression set */
> @@ -293,8 +299,7 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
>  	unsigned char noext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
>  	int i, cold_count, hot_count;
>  
> -	if (!f2fs_sb_has_compression(sbi) ||
> -			F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
> +	if (F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
>  			!f2fs_may_compress(inode) ||
>  			(!ext_cnt && !noext_cnt))
>  		return;
> @@ -326,10 +331,6 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
>  	for (i = 0; i < ext_cnt; i++) {
>  		if (!is_extension_exist(name, ext[i], false))
>  			continue;
> -
> -		/* Do not use inline_data with compression */
> -		stat_dec_inline_inode(inode);
> -		clear_inode_flag(inode, FI_INLINE_DATA);
>  		set_compress_context(inode);
>  		return;
>  	}
> @@ -352,15 +353,13 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, mode, dentry->d_name.name);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
>  	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
>  		set_file_temperature(sbi, inode, dentry->d_name.name);
>  
> -	set_compress_inode(sbi, inode, dentry->d_name.name);
> -
>  	inode->i_op = &f2fs_file_inode_operations;
>  	inode->i_fop = &f2fs_file_operations;
>  	inode->i_mapping->a_ops = &f2fs_dblock_aops;
> @@ -689,7 +688,7 @@ static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO);
> +	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO, NULL);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -760,7 +759,7 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode, NULL);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -817,7 +816,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -856,7 +855,7 @@ static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	inode = f2fs_new_inode(mnt_userns, dir, mode);
> +	inode = f2fs_new_inode(mnt_userns, dir, mode, NULL);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> -- 
> 2.25.1
