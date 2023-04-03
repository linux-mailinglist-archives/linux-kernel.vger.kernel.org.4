Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC966D3C34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjDCDqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDCDqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:46:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A0593D1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 20:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3868BB81088
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13D0C433EF;
        Mon,  3 Apr 2023 03:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680493577;
        bh=V8S6zUdIEBM11OVGVZxlNmpKknApeEtYdclT/G+jciU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aOb6yqLMpzFxaTevR0H2AArJjSI0eNW1/a195Fc/fqB6O39OZhqclypMI6dpVUrOY
         SzrhSj7aG3z/N0YDZZmCPxm9PP4HMd20PCze0M21qV//B7LLTCD/CuUiHsAkDigohe
         bl7W/l9LiV71eyrtmja+7GU7oGFnMLLFhIMFBYmFUdjbz19mVfYfnkPGGpkeZAXaAd
         EPxCDQDEaN03YgFJsn59xXPKu++gZFei0h9sCQO5drUKXRh6KFYQZJwQ8XbH8VD9M4
         23XstaKOXsBjShh+p50wbYxizbezYc0VHMgCnXR4MurplaVc+5xjYPfEdA6OP7n+4E
         d/P1WCduknOwA==
Message-ID: <d87f168e-6155-3784-48f5-03c551c589f7@kernel.org>
Date:   Mon, 3 Apr 2023 11:46:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND] f2fs: add sanity compress level check for compressed
 file
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230330162811.18923-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330162811.18923-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 0:28, Yangtao Li wrote:
> Commit 3fde13f817e2 ("f2fs: compress: support compress level")
> forgot to do basic compress level check, let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/inode.c             | 94 +++++++++++++++++++++++++------------
>   include/linux/zstd_lib.h    |  3 ++
>   lib/zstd/compress/clevels.h |  4 --
>   3 files changed, 67 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index bb5b365a195d..e63f75168700 100644
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
> @@ -202,6 +204,66 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
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
> +	compress_level = le16_to_cpu(ri->i_compress_flag) >> COMPRESS_LEVEL_OFFSET;

Exceed 80 lines.

> +	switch (ri->i_compress_algorithm) {
> +	case COMPRESS_LZO:
> +	case COMPRESS_LZORLE:
> +		if (compress_level)
> +			goto err;
> +		break;
> +	case COMPRESS_LZ4:
> +		if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
> +				compress_level > LZ4HC_MAX_CLEVEL)
> +			goto err;
> +		break;
> +	case COMPRESS_ZSTD:
> +		if (!compress_level || compress_level > ZSTD_MAX_CLEVEL)
> +			goto err;
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
> +	return false;
> +}
> +
>   static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -285,36 +347,8 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   
>   	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
>   			fi->i_flags & F2FS_COMPR_FL &&
> -			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
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
> +			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_log_cluster_size))

Exceed 80 lines.

> +		sanity_check_compress_inode(inode, ri);

Missed to check return value?

>   
>   	return true;
>   }
> diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
> index 79d55465d5c1..ff55f41c73d3 100644
> --- a/include/linux/zstd_lib.h
> +++ b/include/linux/zstd_lib.h
> @@ -88,6 +88,9 @@ ZSTDLIB_API const char* ZSTD_versionString(void);
>   #  define ZSTD_CLEVEL_DEFAULT 3
>   #endif
>   
> +/*-=====  Pre-defined compression levels  =====-*/
> +#define ZSTD_MAX_CLEVEL     22
> +
>   /* *************************************
>    *  Constants
>    ***************************************/
> diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
> index d9a76112ec3a..b040d9d29089 100644
> --- a/lib/zstd/compress/clevels.h
> +++ b/lib/zstd/compress/clevels.h
> @@ -14,10 +14,6 @@
>   #define ZSTD_STATIC_LINKING_ONLY  /* ZSTD_compressionParameters  */
>   #include <linux/zstd.h>
>   
> -/*-=====  Pre-defined compression levels  =====-*/
> -
> -#define ZSTD_MAX_CLEVEL     22

Why not zstd_max_clevel()?

Thanks,

> -
>   __attribute__((__unused__))
>   
>   static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
