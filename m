Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308237013E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbjEMCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjEMCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:15:15 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 19:15:12 PDT
Received: from p3plwbeout22-02.prod.phx3.secureserver.net (p3plsmtp22-02-2.prod.phx3.secureserver.net [68.178.252.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020C59C5
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 19:15:12 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id xekDpR1m7owqlxekEpHSEc; Fri, 12 May 2023 19:12:26 -0700
X-CMAE-Analysis: v=2.4 cv=JPb+D+Gb c=1 sm=1 tr=0 ts=645ef20a
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=3-RhneuVAAAA:8
 a=FXvPX3liAAAA:8 a=VwQbUJbxAAAA:8 a=HEUgJizi0IQopOyZ0BIA:9 a=QEXdDO2ut3YA:10
 a=VLVLkjT_5ZicWzSuYqSo:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  xekDpR1m7owql
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.87])
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pxekD-000150-2w; Sat, 13 May 2023 03:12:26 +0100
Message-ID: <da96ff78-db3f-903c-cf8c-e1cfd430a4e8@squashfs.org.uk>
Date:   Sat, 13 May 2023 03:12:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] squashfs: cache partial compressed blocks
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Philippe Liard <pliard@google.com>, hch@lst.de,
        linux-kernel@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        kernel@axis.com
References: <20230510-squashfs-cache-v2-1-42a501a17569@axis.com>
Content-Language: en-GB
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230510-squashfs-cache-v2-1-42a501a17569@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfBiWo7Kr4KDfFtu854gcOVIa1n/GtO9PVkjCIeFJz2IX4r9VGRgp5Cs3ELeAHRVodC8PrSKdIbtEYSw9rRc7hMWC+UMZuu7YI2ad8+0oDclvyqz+d2ZV
 25qcAox2fnkMi/BhpUqfab1o+zU935LbF8rP1v/Nz8x0FTK/J2oBywr68XAhARxZ7gQhoqjaUrnoQA02DX/XTBGlHPGznU7rSFg=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:18, Vincent Whitchurch wrote:
> Before commit 93e72b3c612adcaca1 ("squashfs: migrate from ll_rw_block
> usage to BIO"), compressed blocks read by squashfs were cached in the
> page cache, but that is not the case after that commit.  That has lead
> to squashfs having to re-read a lot of sectors from disk/flash.

Good catch.  I wasn't aware of that regression.

> For example, the first sectors of every metadata block need to be read
> twice from the disk.  Once partially to read the length, and a
> second time to read the block itself.  Also, in linear reads of large
> files, the last sectors of one data block are re-read from disk when
> reading the next data block, since the compressed blocks are of variable
> sizes and not aligned to device blocks.  This extra I/O results in a
> degrade in read performance of, for example, ~16% in one scenario on my
> ARM platform using squashfs with dm-verity and NAND.
>
> Since the decompressed data is cached in the page cache or squashfs'
> internal metadata and fragment caches, caching _all_ compressed pages
> would lead to a lot of double caching and is undesirable.  But make the
> code cache any disk blocks which were only partially requested, since
> these are the ones likely to include data which is needed by other file
> system blocks.  This restores read performance in my test scenario.
>
> The compressed block caching is only applied when the disk block size is
> equal to the page size, to avoid having to deal with caching sub-page
> reads.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Patch looks good.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>


> ---
> Changes in v2:
> - Do not remove static from squashfs_bio_read()
> - Link to v1: https://lore.kernel.org/r/20230510-squashfs-cache-v1-1-3b6bb0e7d952@axis.com
> ---
>   fs/squashfs/block.c          | 116 +++++++++++++++++++++++++++++++++++++++++--
>   fs/squashfs/squashfs_fs_sb.h |   1 +
>   fs/squashfs/super.c          |  12 +++++
>   3 files changed, 126 insertions(+), 3 deletions(-)
>
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index bed3bb8b27fa..d750f72711fa 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -76,10 +76,101 @@ static int copy_bio_to_actor(struct bio *bio,
>   	return copied_bytes;
>   }
>   
> +static int squashfs_bio_read_cached(struct bio *fullbio, struct address_space *cache_mapping,
> +				    u64 index, int length, u64 read_start, u64 read_end,
> +				    int page_count)
> +{
> +	struct page *head_to_cache = NULL, *tail_to_cache = NULL;
> +	struct block_device *bdev = fullbio->bi_bdev;
> +	struct bvec_iter_all iter_all;
> +	struct bio *bio = NULL;
> +	int prev_io_idx = -1;
> +	struct bio_vec *bv;
> +	int idx = 0;
> +	int err = 0;
> +
> +	bio_for_each_segment_all(bv, fullbio, iter_all) {
> +		struct page *page = bv->bv_page;
> +		int retlen;
> +
> +		if (page->mapping == cache_mapping && PageUptodate(page)) {
> +			idx++;
> +			continue;
> +		}
> +
> +		/*
> +		 * We only use this when the device block size is the same as
> +		 * the page size, so read_start and read_end cover full pages.
> +		 *
> +		 * Compare these to the original required index and length to
> +		 * only cache pages which were requested partially, since these
> +		 * are the ones which are likely to be needed when reading
> +		 * adjacent blocks.
> +		 */
> +		if (idx == 0 && index != read_start)
> +			head_to_cache = page;
> +		else if (idx == page_count - 1 && index + length != read_end)
> +			tail_to_cache = page;
> +
> +		if (!bio || idx != prev_io_idx + 1) {
> +			unsigned int remaining_pages;
> +			unsigned int this_nr_pages;
> +
> +submit_and_retry:
> +			remaining_pages = page_count - idx;
> +			this_nr_pages = min(remaining_pages, BIO_MAX_VECS);
> +			bio = blk_next_bio(bio, bdev, this_nr_pages, REQ_OP_READ,
> +					   GFP_NOIO);
> +			bio->bi_iter.bi_sector = fullbio->bi_iter.bi_sector +
> +						 idx * (PAGE_SIZE / SECTOR_SIZE);
> +		}
> +
> +		retlen = bio_add_page(bio, bv->bv_page, bv->bv_len, bv->bv_offset);
> +		if (retlen != bv->bv_len)
> +			goto submit_and_retry;
> +
> +		prev_io_idx = idx;
> +		idx++;
> +	}
> +
> +	if (bio) {
> +		err = submit_bio_wait(bio);
> +		bio_put(bio);
> +	}
> +
> +	if (err)
> +		return err;
> +
> +	if (head_to_cache) {
> +		int ret = add_to_page_cache_lru(head_to_cache, cache_mapping,
> +						read_start, GFP_NOIO);
> +
> +		if (!ret) {
> +			SetPageUptodate(head_to_cache);
> +			unlock_page(head_to_cache);
> +		}
> +
> +	}
> +
> +	if (tail_to_cache) {
> +		int ret = add_to_page_cache_lru(tail_to_cache, cache_mapping,
> +						read_end - PAGE_SIZE, GFP_NOIO);
> +
> +		if (!ret) {
> +			SetPageUptodate(tail_to_cache);
> +			unlock_page(tail_to_cache);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
>   			     struct bio **biop, int *block_offset)
>   {
>   	struct squashfs_sb_info *msblk = sb->s_fs_info;
> +	struct inode *cache_inode = msblk->cache_inode;
> +	struct address_space *cache_mapping = cache_inode ? cache_inode->i_mapping : NULL;
>   	const u64 read_start = round_down(index, msblk->devblksize);
>   	const sector_t block = read_start >> msblk->devblksize_log2;
>   	const u64 read_end = round_up(index + length, msblk->devblksize);
> @@ -99,13 +190,27 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
>   	for (i = 0; i < page_count; ++i) {
>   		unsigned int len =
>   			min_t(unsigned int, PAGE_SIZE - offset, total_len);
> -		struct page *page = alloc_page(GFP_NOIO);
> +		struct page *page = NULL;
> +
> +		if (cache_mapping)
> +			page = find_get_page(cache_mapping,
> +					     read_start + i * PAGE_SIZE);
> +		if (!page)
> +			page = alloc_page(GFP_NOIO);
>   
>   		if (!page) {
>   			error = -ENOMEM;
>   			goto out_free_bio;
>   		}
> -		if (!bio_add_page(bio, page, len, offset)) {
> +
> +		if (cache_mapping) {
> +			/*
> +			 * Use the __ version to avoid merging since we need
> +			 * each page to be separate when we check for and avoid
> +			 * cached pages.
> +			 */
> +			__bio_add_page(bio, page, len, offset);
> +		} else if (!bio_add_page(bio, page, len, offset)) {
>   			error = -EIO;
>   			goto out_free_bio;
>   		}
> @@ -113,7 +218,12 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
>   		total_len -= len;
>   	}
>   
> -	error = submit_bio_wait(bio);
> +	if (cache_mapping)
> +		error = squashfs_bio_read_cached(bio, cache_mapping, index,
> +						 length, read_start, read_end,
> +						 page_count);
> +	else
> +		error = submit_bio_wait(bio);
>   	if (error)
>   		goto out_free_bio;
>   
> diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
> index 72f6f4b37863..dfee65845d48 100644
> --- a/fs/squashfs/squashfs_fs_sb.h
> +++ b/fs/squashfs/squashfs_fs_sb.h
> @@ -47,6 +47,7 @@ struct squashfs_sb_info {
>   	struct squashfs_cache			*block_cache;
>   	struct squashfs_cache			*fragment_cache;
>   	struct squashfs_cache			*read_page;
> +	struct inode				*cache_inode;
>   	int					next_meta_index;
>   	__le64					*id_table;
>   	__le64					*fragment_index;
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index e090fae48e68..64d6bc95950b 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -329,6 +329,16 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto failed_mount;
>   	}
>   
> +	if (msblk->devblksize == PAGE_SIZE) {
> +		msblk->cache_inode = new_inode(sb);
> +		if (msblk->cache_inode == NULL)
> +			goto failed_mount;
> +
> +		set_nlink(msblk->cache_inode, 1);
> +		msblk->cache_inode->i_size = OFFSET_MAX;
> +		mapping_set_gfp_mask(msblk->cache_inode->i_mapping, GFP_NOFS);
> +	}
> +
>   	msblk->stream = squashfs_decompressor_setup(sb, flags);
>   	if (IS_ERR(msblk->stream)) {
>   		err = PTR_ERR(msblk->stream);
> @@ -454,6 +464,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	squashfs_cache_delete(msblk->block_cache);
>   	squashfs_cache_delete(msblk->fragment_cache);
>   	squashfs_cache_delete(msblk->read_page);
> +	iput(msblk->cache_inode);
>   	msblk->thread_ops->destroy(msblk);
>   	kfree(msblk->inode_lookup_table);
>   	kfree(msblk->fragment_index);
> @@ -572,6 +583,7 @@ static void squashfs_put_super(struct super_block *sb)
>   		squashfs_cache_delete(sbi->block_cache);
>   		squashfs_cache_delete(sbi->fragment_cache);
>   		squashfs_cache_delete(sbi->read_page);
> +		iput(sbi->cache_inode);
>   		sbi->thread_ops->destroy(sbi);
>   		kfree(sbi->id_table);
>   		kfree(sbi->fragment_index);
>
> ---
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
> change-id: 20230510-squashfs-cache-7a3b9e7355c1
>
> Best regards,
