Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638706B7724
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCMMEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCMMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:04:36 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECDD2311A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:04:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VdmSkDi_1678709068;
Received: from 30.97.49.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdmSkDi_1678709068)
          by smtp.aliyun-inc.com;
          Mon, 13 Mar 2023 20:04:29 +0800
Message-ID: <7ab4275e-b2d6-c9dd-400d-1f6ad24b8f5c@linux.alibaba.com>
Date:   Mon, 13 Mar 2023 20:04:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/2] erofs: set block size to the on-disk block size
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230306100200.117684-1-jefflexu@linux.alibaba.com>
 <20230306100200.117684-3-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230306100200.117684-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 18:02, Jingbo Xu wrote:
> Set the block size to that specified in on-disk superblock.
> 
> Also remove the hard constraint of PAGE_SIZE block size for the
> uncompressed device backend.  This constraint is temporarily remained
> for compressed device and fscache backend, as there is more work needed
> to handle the condition where the block size is not equal to PAGE_SIZE.
> 
> It is worth noting that the on-disk block size is read prior to
> erofs_superblock_csum_verify(), as the read block size is needed in the
> latter.
> 
> Besides, later we are going to make erofs refer to tar data blobs (which
> is 512-byte aligned) for OCI containers, where the block size is 512
> bytes.  In this case, the 512-byte block size may not be adequate for a
> directory to contain enough dirents.  To fix this, we are also going to
> introduce directory block size independent on the block size.
> 
> Due to we have already supported block size smaller than PAGE_SIZE now,
> disable all these images with such separated directory block size until
> we supported this feature later.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/erofs_fs.h |  5 +++--
>   fs/erofs/inode.c    |  3 ++-
>   fs/erofs/internal.h | 11 ++---------
>   fs/erofs/super.c    | 46 +++++++++++++++++++++++++++++----------------
>   4 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index dbcd24371002..44876a97cabd 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -53,7 +53,7 @@ struct erofs_super_block {
>   	__le32 magic;           /* file system magic number */
>   	__le32 checksum;        /* crc32c(super_block) */
>   	__le32 feature_compat;
> -	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> +	__u8 blkszbits;         /* filesystem block size in bit shift */
>   	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
>   
>   	__le16 root_nid;	/* nid of root directory */
> @@ -75,7 +75,8 @@ struct erofs_super_block {
>   	} __packed u1;
>   	__le16 extra_devices;	/* # of devices besides the primary device */
>   	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
> -	__u8 reserved[6];
> +	__u8 dirblkbits;	/* directory block size in bit shift */
> +	__u8 reserved[5];
>   	__le64 packed_nid;	/* nid of the special packed inode */
>   	__u8 reserved2[24];
>   };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index de26dac4e07e..0e6ff8a98c68 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode *inode)
>   	}
>   
>   	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> -		if (!erofs_is_fscache_mode(inode->i_sb))
> +		if (!erofs_is_fscache_mode(inode->i_sb) &&
> +		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
>   			err = z_erofs_fill_inode(inode);
>   		else
>   			err = -EOPNOTSUPP;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d8019d835405..561df4ce9a62 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -148,7 +148,8 @@ struct erofs_sb_info {
>   	u16 device_id_mask;	/* valid bits of device id to be used */
>   
>   	unsigned char islotbits;	/* inode slot unit size in bit shift */
> -	unsigned char blkszbits;
> +	unsigned char blkszbits;	/* filesystem block size in bit shift */
> +	unsigned char dirblkbits;	/* directory block size in bit shift */
>   
>   	u32 sb_size;			/* total superblock size */
>   	u32 build_time_nsec;
> @@ -240,14 +241,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>   					VAL != EROFS_LOCKED_MAGIC);
>   }
>   
> -/* we strictly follow PAGE_SIZE and no buffer head yet */
> -#define LOG_BLOCK_SIZE		PAGE_SHIFT
> -#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
> -
> -#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
> -#error erofs cannot be used in this platform
> -#endif
> -
>   enum erofs_kmap_type {
>   	EROFS_NO_KMAP,		/* don't map the buffer */
>   	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c97615c96ef8..d5fa0f582cbe 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -330,7 +330,6 @@ static int erofs_read_superblock(struct super_block *sb)
>   	struct erofs_sb_info *sbi;
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct erofs_super_block *dsb;
> -	unsigned int blkszbits;
>   	void *data;
>   	int ret;
>   
> @@ -349,6 +348,17 @@ static int erofs_read_superblock(struct super_block *sb)
>   		goto out;
>   	}
>   
> +	sbi->blkszbits  = dsb->blkszbits;
> +	sbi->dirblkbits = dsb->dirblkbits;
> +	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
> +		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
> +		goto out;
> +	}
> +	if (sbi->dirblkbits) {

I think we could just

	if (dsb->dirblkbits) {

so we could avoid "sbi->dirblkbits" in this patch for now and add in the later
patches.

Thanks,
Gao Xiang

