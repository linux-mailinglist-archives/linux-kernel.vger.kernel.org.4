Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24A68FDC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBIDKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjBIDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:09:39 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92781BE0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:07:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEHIIN_1675912062;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbEHIIN_1675912062)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:07:43 +0800
Message-ID: <64d37ad6-c875-7671-5a82-53dd9a03955f@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 11:07:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] erofs: remove unused EROFS_GET_BLOCKS_RAW flag
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
 <20230209024825.17335-2-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230209024825.17335-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/9 10:48, Jingbo Xu wrote:
> For erofs_map_blocks() and erofs_map_blocks_flatmode(), the flags
> argument is always EROFS_GET_BLOCKS_RAW.  Thus remove the unused flags
> parameter for these two functions.
> 
> Besides EROFS_GET_BLOCKS_RAW is originally introduced for reading
> compressed (raw) data for compressed files.  However it's never used
> actually and let's remove it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/data.c              | 14 ++++++--------
>   fs/erofs/fscache.c           |  2 +-
>   fs/erofs/internal.h          | 10 ++++------
>   include/trace/events/erofs.h |  1 -
>   4 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 2713257ee718..032e12dccb84 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -74,8 +74,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>   }
>   
>   static int erofs_map_blocks_flatmode(struct inode *inode,
> -				     struct erofs_map_blocks *map,
> -				     int flags)
> +				     struct erofs_map_blocks *map)
>   {
>   	erofs_blk_t nblocks, lastblk;
>   	u64 offset = map->m_la;
> @@ -114,8 +113,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   	return 0;
>   }
>   
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags)
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>   {
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_inode *vi = EROFS_I(inode);
> @@ -127,7 +125,7 @@ int erofs_map_blocks(struct inode *inode,
>   	void *kaddr;
>   	int err = 0;
>   
> -	trace_erofs_map_blocks_enter(inode, map, flags);
> +	trace_erofs_map_blocks_enter(inode, map, 0);
>   	map->m_deviceid = 0;
>   	if (map->m_la >= inode->i_size) {
>   		/* leave out-of-bound access unmapped */
> @@ -137,7 +135,7 @@ int erofs_map_blocks(struct inode *inode,
>   	}
>   
>   	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
> -		err = erofs_map_blocks_flatmode(inode, map, flags);
> +		err = erofs_map_blocks_flatmode(inode, map);
>   		goto out;
>   	}
>   
> @@ -189,7 +187,7 @@ int erofs_map_blocks(struct inode *inode,
>   out:
>   	if (!err)
>   		map->m_llen = map->m_plen;
> -	trace_erofs_map_blocks_exit(inode, map, flags, 0);
> +	trace_erofs_map_blocks_exit(inode, map, 0, err);
>   	return err;
>   }
>   
> @@ -252,7 +250,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	map.m_la = offset;
>   	map.m_llen = length;
>   
> -	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map);
>   	if (ret < 0)
>   		return ret;
>   
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 03de4dc99302..9658cf8689d9 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -197,7 +197,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>   	int ret;
>   
>   	map.m_la = pos;
> -	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 48a2f33de15a..8a6ae820cd6d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -401,16 +401,15 @@ struct erofs_map_blocks {
>   	unsigned int m_flags;
>   };
>   
> -#define EROFS_GET_BLOCKS_RAW    0x0001
>   /*
>    * Used to get the exact decompressed length, e.g. fiemap (consider lookback
>    * approach instead if possible since it's more metadata lightweight.)
>    */
> -#define EROFS_GET_BLOCKS_FIEMAP	0x0002
> +#define EROFS_GET_BLOCKS_FIEMAP		0x0001
>   /* Used to map the whole extent if non-negligible data is requested for LZMA */
> -#define EROFS_GET_BLOCKS_READMORE	0x0004
> +#define EROFS_GET_BLOCKS_READMORE	0x0002
>   /* Used to map tail extent for tailpacking inline or fragment pcluster */
> -#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
> +#define EROFS_GET_BLOCKS_FINDTAIL	0x0004
>   
>   enum {
>   	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> @@ -458,8 +457,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>   int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
>   int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		 u64 start, u64 len);
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags);
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
>   struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>   int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>   		  struct kstat *stat, u32 request_mask,
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index f0e43e40a4a1..cf4a0d28b178 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,7 +19,6 @@ struct erofs_map_blocks;
>   		{ 1,		"DIR" })
>   
>   #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
>   	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
>   	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
>   	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
