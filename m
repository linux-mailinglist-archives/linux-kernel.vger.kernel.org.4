Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1AD72D04D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjFLUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFLUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27D1BF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8590862946
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA48C433EF;
        Mon, 12 Jun 2023 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686600972;
        bh=fNy6PCNyZ/ZgFsqHgyUlHwtcbWrxGE7+bJ0hTW50yJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JM4j+rgCg86UjFlts7tVah/4iCxfXFWWwazW+5Ni4z5w3VJEKfOzF8/LUCesaD5F5
         yHWfMQDOng1oy9FksHVr52cLdmk6iMskzueze6sy46oLHsGupEZ8RPk7oikOuenane
         oqXFEZH18TaWNAMvBDlhgcCMOE/vSAmi3Uq2ymLf0ayDxZ3OXOEZlqY/CFhHOfVK0e
         52SEK1gJLoACH1RQfwbpruTJjvDg3zVp0Xf1Dg/MrHzFNhEYMS4TgJA0u7hx6RhGZY
         O87jH9kTrlahMkX46988iMi1O4O4vVrDR0GDBnNupXJZU0zXNtqECyeulWDN1UgQKU
         JANm7YITiowhw==
Date:   Mon, 12 Jun 2023 13:16:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: do more sanity check on inode
Message-ID: <ZId9Cw8eqgj417gz@google.com>
References: <20230531014055.3904072-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531014055.3904072-1-chao@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Chao Yu wrote:
> There are several issues in sanity_check_inode():
> - The code looks not clean, it checks extra_attr related condition
> dispersively.
> - It missed to check i_extra_isize w/ lower boundary
> - It missed to check feature dependency: prjquota, inode_chksum,
> inode_crtime, compression features rely on extra_attr feature.
> - It's not necessary to check i_extra_isize due to it will only
> be assigned to non-zero value if f2fs_has_extra_attr() is true
> in do_read_inode().
> 
> Fix them all in this patch.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - describe current problem in commit message
>  fs/f2fs/f2fs.h  |   2 +
>  fs/f2fs/inode.c | 108 +++++++++++++++++++++++++++++++-----------------
>  2 files changed, 72 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7e406da8b4b3..619ad49993ce 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3413,6 +3413,8 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
>  
> +#define F2FS_MIN_EXTRA_ATTR_SIZE		(sizeof(__le32))
> +
>  #define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
>  	(offsetof(struct f2fs_inode, i_extra_end) -	\
>  	offsetof(struct f2fs_inode, i_extra_isize))	\
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 0a1748444329..1e49009831c1 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -300,41 +300,79 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		return false;
>  	}
>  
> -	if (f2fs_sb_has_flexible_inline_xattr(sbi)
> -			&& !f2fs_has_extra_attr(inode)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
> -			  __func__, inode->i_ino);
> -		return false;
> -	}
> -
> -	if (f2fs_has_extra_attr(inode) &&
> -			!f2fs_sb_has_extra_attr(sbi)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
> -			  __func__, inode->i_ino);
> -		return false;
> -	}
> -
> -	if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
> +	if (f2fs_has_extra_attr(inode)) {
> +		if (!f2fs_sb_has_extra_attr(sbi)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
> +				  __func__, inode->i_ino);
> +			return false;
> +		}
> +		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
> +			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
>  			fi->i_extra_isize % sizeof(__le32)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
> -			  __func__, inode->i_ino, fi->i_extra_isize,
> -			  F2FS_TOTAL_EXTRA_ATTR_SIZE);
> -		return false;
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
> +				  __func__, inode->i_ino, fi->i_extra_isize,
> +				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
> +			return false;
> +		}
> +		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
> +			f2fs_has_inline_xattr(inode) &&
> +			(!fi->i_inline_xattr_size ||
> +			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
> +				  __func__, inode->i_ino, fi->i_inline_xattr_size,
> +				  MAX_INLINE_XATTR_SIZE);
> +			return false;
> +		}
> +		if (f2fs_sb_has_compression(sbi) &&
> +			fi->i_flags & F2FS_COMPR_FL &&
> +			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
> +						i_compress_flag)) {
> +			if (!sanity_check_compress_inode(inode, ri))
> +				return false;
> +		}
> +	} else {
> +		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {

Modified to combine else if.

> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
> +				  __func__, inode->i_ino);
> +			return false;
> +		}
>  	}
>  
> -	if (f2fs_has_extra_attr(inode) &&
> -		f2fs_sb_has_flexible_inline_xattr(sbi) &&
> -		f2fs_has_inline_xattr(inode) &&
> -		(!fi->i_inline_xattr_size ||
> -		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
> -			  __func__, inode->i_ino, fi->i_inline_xattr_size,
> -			  MAX_INLINE_XATTR_SIZE);
> -		return false;
> +	if (!f2fs_sb_has_extra_attr(sbi)) {
> +		if (f2fs_sb_has_project_quota(sbi)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +				  __func__, inode->i_ino, F2FS_FEATURE_PRJQUOTA);
> +			return false;
> +		}
> +		if (f2fs_sb_has_inode_chksum(sbi)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CHKSUM);
> +			return false;
> +		}
> +		if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +				  __func__, inode->i_ino, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
> +			return false;
> +		}
> +		if (f2fs_sb_has_inode_crtime(sbi)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +				  __func__, inode->i_ino, F2FS_FEATURE_INODE_CRTIME);
> +			return false;
> +		}
> +		if (f2fs_sb_has_compression(sbi)) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
> +				  __func__, inode->i_ino, F2FS_FEATURE_COMPRESSION);
> +			return false;
> +		}
>  	}
>  
>  	if (f2fs_sanity_check_inline_data(inode)) {
> @@ -358,12 +396,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		return false;
>  	}
>  
> -	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
> -			fi->i_flags & F2FS_COMPR_FL &&
> -			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
> -						i_compress_flag))
> -		return sanity_check_compress_inode(inode, ri);
> -
>  	return true;
>  }
>  
> -- 
> 2.40.1
