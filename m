Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849AF6D5CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjDDKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjDDKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C498E8F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B2462EB5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D5EC433D2;
        Tue,  4 Apr 2023 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680603355;
        bh=rm1UGIavk3asvTdDupoxoTwlekUJeaAORF0Tuc7qynU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DRYJlvjw9gWNnAe6f82/pn7KfDTJMBEVV/TAJdpqUwWTLxxt7vLACKYQ/quTv5uoe
         WjUmAmRorb9qFtt5fVHy4833A6ddhbzw90iRznR9VX8D1O+LFYIXMkRQNhs+CUaurR
         Rr5b8u/PHDR/WMLmDscYUwvAPxwlhA/EqnFHvNeUfacGakWxnkavTTJRGd5DA+TMER
         Ox0aBv8UzgqYssYc59KbCqg+EDdAMx2UeiuzGoCaKwuTyqeyY6bsQfjRbKeWGHiogm
         jq/VylYEzM/nLWa38JJfcn8mCj7DaonBuAdKEFfps4bvNOA0Rv6DIAs68RjA3wyNV9
         aOs7dBkDPcALA==
Message-ID: <b66f93fc-b37e-8e9b-6b8b-4589a9929c15@kernel.org>
Date:   Tue, 4 Apr 2023 18:15:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] f2fs: add sanity compress level check for compressed
 file
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230404034847.26667-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230404034847.26667-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 11:48, Yangtao Li wrote:
> Commit 3fde13f817e2 ("f2fs: compress: support compress level")
> forgot to do basic compress level check, let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -convert to zstd_max_clevel()
>   fs/f2fs/inode.c | 96 ++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index bb5b365a195d..e6f45a7a079d 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -10,6 +10,8 @@
>   #include <linux/buffer_head.h>
>   #include <linux/writeback.h>
>   #include <linux/sched/mm.h>
> +#include <linux/lz4.h>
> +#include <linux/zstd.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -202,6 +204,69 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
>   	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
>   }
>   
> +static bool sanity_check_compress_inode(struct inode *inode,
> +			struct f2fs_inode *ri)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	unsigned char compress_level;
> +
> +	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		f2fs_warn(sbi,
> +			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
> +			__func__, inode->i_ino, ri->i_compress_algorithm);
> +		return false;
> +	}
> +	if (le64_to_cpu(ri->i_compr_blocks) >
> +			SECTOR_TO_BLOCK(inode->i_blocks)) {
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		f2fs_warn(sbi,
> +			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
> +			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
> +			SECTOR_TO_BLOCK(inode->i_blocks));
> +		return false;
> +	}
> +	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
> +		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		f2fs_warn(sbi,
> +			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
> +			__func__, inode->i_ino, ri->i_log_cluster_size);
> +		return false;
> +	}
> +
> +	compress_level = le16_to_cpu(ri->i_compress_flag) >>
> +				COMPRESS_LEVEL_OFFSET;
> +	switch (ri->i_compress_algorithm) {
> +	case COMPRESS_LZO:
> +	case COMPRESS_LZORLE:
> +		if (compress_level)
> +			goto err;
> +		break;
> +	case COMPRESS_LZ4:

It needs to cover below codes w/ CONFIG_F2FS_FS_LZ4HC and CONFIG_F2FS_FS_LZ4?

> +		if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
> +				compress_level > LZ4HC_MAX_CLEVEL)
> +			goto err;
> +		break;
> +	case COMPRESS_ZSTD:
> +#ifdef CONFIG_F2FS_FS_ZSTD
> +		if (!compress_level || compress_level > zstd_max_clevel())
> +			goto err;
> +#endif
> +		break;
> +	default:
> +		goto err;
> +	}
> +
> +	return true;
> +
> +err:
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
> +		  __func__, inode->i_ino, compress_level);

Move above codes to default case?

Thanks,

> +	return false;
> +}
> +
>   static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -286,35 +351,8 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
>   			fi->i_flags & F2FS_COMPR_FL &&
>   			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
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
>   	return true;
>   }
