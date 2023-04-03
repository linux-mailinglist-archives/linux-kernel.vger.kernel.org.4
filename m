Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED466D4FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjDCSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjDCSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EBD171E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4C061E75
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3E1C433EF;
        Mon,  3 Apr 2023 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680544744;
        bh=khDYkXvty0Ffs3qj1iEECXU0QHcjnVT1YU5sAurqjBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwP+fz7R4y7fEgk7DFITpHPKnhIBPIZHj3VKXNyCQjTlNtEnTvCLRbNrSmYsOBXib
         8CIIH5uQPfwOE62ebPFU/GtZ7vnCCQs31qAJGrjcApvhzvmLQcaMIZBCkmuBOAy8f8
         2hmxxClwdlVoqJsIUlBorabLbh5SjWWIqEBFbkqvhw5iCg7xNQcXeMfaZ9t0Lgi50h
         PG4M3pwMBM6XKoVxqR5KHiEMSsjou78vX2NOJwj70nyS5m1b6ftTV6wpYdZsNSZNel
         I0PT0ETSK+UFfgx6GKwOsVRvfhNJb7MqZgDwWKf1wenFDLq6FPFMyIBxltXSJfTyxB
         xskj06dFIsFew==
Date:   Mon, 3 Apr 2023 10:59:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to check readonly condition correctly
Message-ID: <ZCsT5mRsZJqPXBzz@google.com>
References: <20230402112825.42486-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402112825.42486-1-chao@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, Chao Yu wrote:
> This patch does below changes:
> 
> - If f2fs enables readonly feature or device is readonly, allow to
> mount readonly mode only
> - Introduce f2fs_dev_is_readonly() to indicate whether image or device
> is readonly
> - remove unnecessary f2fs_hw_is_readonly() in f2fs_write_checkpoint()
> and f2fs_convert_inline_inode()
> - enable FLUSH_MERGE only if f2fs is mounted as rw and image/device
> is writable

What is the problem to solve here?

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  2 +-
>  fs/f2fs/f2fs.h       | 10 +++++-----
>  fs/f2fs/inline.c     |  3 +--
>  fs/f2fs/super.c      | 13 +++++++------
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8e1db5752fff..1eef597ed393 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1604,7 +1604,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	unsigned long long ckpt_ver;
>  	int err = 0;
>  
> -	if (f2fs_readonly(sbi->sb) || f2fs_hw_is_readonly(sbi))
> +	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2d4a7ef62537..7de95133478a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4446,6 +4446,11 @@ static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
>  	return false;
>  }
>  
> +static inline bool f2fs_dev_is_readonly(struct f2fs_sb_info *sbi)
> +{
> +	return f2fs_sb_has_readonly(sbi) || f2fs_hw_is_readonly(sbi);
> +}
> +
>  static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
>  {
>  	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
> @@ -4546,11 +4551,6 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
>  	}
>  }
>  
> -static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
> -{
> -	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
> -}
> -
>  #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>  #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>  
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 72269e7efd26..2c36f2dc2317 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -203,8 +203,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
>  	struct page *ipage, *page;
>  	int err = 0;
>  
> -	if (!f2fs_has_inline_data(inode) ||
> -			f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
> +	if (!f2fs_has_inline_data(inode) || f2fs_readonly(sbi->sb))
>  		return 0;
>  
>  	err = f2fs_dquot_initialize(inode);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d016f398fcad..db7649010c12 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1382,15 +1382,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		return -EINVAL;
>  	}
>  
> -	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
> +	if (f2fs_dev_is_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
> +		f2fs_err(sbi, "Allow to mount readonly mode only");
> +		return -EROFS;
> +	}
> +
> +	if (f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE)) {
>  		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
>  		return -EINVAL;
>  	}
>  
> -	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
> -		f2fs_err(sbi, "Allow to mount readonly mode only");
> -		return -EROFS;
> -	}
>  	return 0;
>  }
>  
> @@ -2122,7 +2123,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	set_opt(sbi, MERGE_CHECKPOINT);
>  	F2FS_OPTION(sbi).unusable_cap = 0;
>  	sbi->sb->s_flags |= SB_LAZYTIME;
> -	if (!f2fs_is_readonly(sbi))
> +	if (!f2fs_readonly(sbi->sb) && !f2fs_dev_is_readonly(sbi))
>  		set_opt(sbi, FLUSH_MERGE);
>  	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
>  		set_opt(sbi, DISCARD);
> -- 
> 2.36.1
