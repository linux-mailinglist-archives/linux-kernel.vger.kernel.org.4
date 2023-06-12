Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B690872CE25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbjFLS3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbjFLS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1751FDB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD2762D01
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25848C433EF;
        Mon, 12 Jun 2023 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686594524;
        bh=c+yC6Rpmu7pRoA+uZdVLb6zb7tJTIGh/t+XCxSFYxDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iajpz+lP7/dk43ai9rqBh+O7PPCHDIZd05sufNM+6EO7KM9eKW3Z1qTrWvYZZh/FU
         iFXUPYu5iGQs25ISSPV4Km+kUF2Z3mqiIqiDXfvy0OfyQvrJqXhy6Sq9CUNoVvDRYH
         aCOv/YJmbv8WZdg/1OoiUC6+t/xDaGgukIWc3HDDNI7tZ70/5UbWx6C6+T8ubIbx53
         U86tXtY3KZ8sBet2znXFUojKWc2YqTmoU61PLhSGZ0VdK1hIzEP1GE/ybSOZyMTH17
         NRjnqCxSjIQTvzNkJD4zyOiDdxetYJZ9Rt0puZm71mmZUbZeDWbnGT4nz3lT3umAY4
         H4bFUz3GMhwVg==
Date:   Mon, 12 Jun 2023 11:28:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Chao Yu <chao@kernel.org>, Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: add sanity compress level check for compressed
 file
Message-ID: <ZIdj2jAFDvkZ3eJW@google.com>
References: <20230407183148.23231-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407183148.23231-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08, Yangtao Li wrote:
> Commit 3fde13f817e2 ("f2fs: compress: support compress level")
> forgot to do basic compress level check, let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/inode.c | 106 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index bb5b365a195d..c2460f51bf80 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -10,6 +10,8 @@
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
>  #include <linux/sched/mm.h>
> +#include <linux/lz4.h>
> +#include <linux/zstd.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -202,6 +204,79 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
>  	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
>  }
>  
> +static bool sanity_check_compress_inode(struct inode *inode,
> +			struct f2fs_inode *ri)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	unsigned char compress_level;
> +
> +	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
> +		f2fs_warn(sbi,
> +			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
> +			__func__, inode->i_ino, ri->i_compress_algorithm);
> +		goto err;
> +	}
> +	if (le64_to_cpu(ri->i_compr_blocks) >
> +			SECTOR_TO_BLOCK(inode->i_blocks)) {
> +		f2fs_warn(sbi,
> +			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> +			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
> +			SECTOR_TO_BLOCK(inode->i_blocks));
> +		goto err;
> +	}
> +	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
> +		f2fs_warn(sbi,
> +			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
> +			__func__, inode->i_ino, ri->i_log_cluster_size);
> +		goto err;
> +	}
> +
> +	compress_level = le16_to_cpu(ri->i_compress_flag) >>
> +				COMPRESS_LEVEL_OFFSET;
> +	switch (ri->i_compress_algorithm) {
> +	case COMPRESS_LZO:
> +#ifdef CONFIG_F2FS_FS_LZO
> +		if (compress_level)
> +			goto err_level;
> +#endif
> +		break;
> +	case COMPRESS_LZORLE:
> +#ifdef CONFIG_F2FS_FS_LZORLE
> +		if (compress_level)
> +			goto err_level;
> +#endif
> +		break;
> +	case COMPRESS_LZ4:
> +#ifdef CONFIG_F2FS_FS_LZ4
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +		if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
> +				compress_level > LZ4HC_MAX_CLEVEL)
> +#else
> +		if (compress_level)
> +#endif
> +			goto err_level;
> +#endif
> +		break;
> +	case COMPRESS_ZSTD:
> +#ifdef CONFIG_F2FS_FS_ZSTD
> +		if (!compress_level || compress_level > zstd_max_clevel())

I think compress_level=0 is wrong, since that'll be changed to the default level later.
I'll modify to assign the correct level, so please revisit this patch later.

> +			goto err_level;
> +#endif
> +		break;
> +	default:
> +		goto err_level;
> +	}
> +
> +	return true;
> +err_level:
> +	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
> +		  __func__, inode->i_ino, compress_level);
> +err:
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +	return false;
> +}
> +
>  static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -286,35 +361,8 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
>  			fi->i_flags & F2FS_COMPR_FL &&
>  			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
> -						i_log_cluster_size)) {
> -		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> -				"compress algorithm: %u, run fsck to fix",
> -				  __func__, inode->i_ino,
> -				  ri->i_compress_algorithm);
> -			return false;
> -		}
> -		if (le64_to_cpu(ri->i_compr_blocks) >
> -				SECTOR_TO_BLOCK(inode->i_blocks)) {
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) has inconsistent "
> -				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> -				  __func__, inode->i_ino,
> -				  le64_to_cpu(ri->i_compr_blocks),
> -				  SECTOR_TO_BLOCK(inode->i_blocks));
> -			return false;
> -		}
> -		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> -			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
> -				"log cluster size: %u, run fsck to fix",
> -				  __func__, inode->i_ino,
> -				  ri->i_log_cluster_size);
> -			return false;
> -		}
> -	}
> +						i_log_cluster_size))
> +		return sanity_check_compress_inode(inode, ri);
>  
>  	return true;
>  }
> -- 
> 2.35.1
