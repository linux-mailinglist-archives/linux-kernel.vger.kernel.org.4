Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9B6CEFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjC2Quo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjC2Quj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:50:39 -0400
Received: from p3plwbeout15-02.prod.phx3.secureserver.net (p3plsmtp15-02-2.prod.phx3.secureserver.net [173.201.193.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5E5FCA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:50:33 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id hZ0KpAI7dnisThZ0LpzlJg; Wed, 29 Mar 2023 09:50:33 -0700
X-CMAE-Analysis: v=2.4 cv=Yet4Wydf c=1 sm=1 tr=0 ts=64246c59
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=FXvPX3liAAAA:8 a=gjMtakkyLEDTN96sYTAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  hZ0KpAI7dnisT
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp01.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1phZ0H-0001bO-K1; Wed, 29 Mar 2023 17:50:30 +0100
Message-ID: <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
Date:   Wed, 29 Mar 2023 17:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     willy@infradead.org, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230327174402.1655365-2-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfP1G+7d1l1ags5pssdPy3lZpIgQmAnMZy4qUiTY3edwL+VL+E7oPcpTiBuuUxJaI8X1vUYXZMhhLZldrMBK/DYw5WOS+84GVDjfeT5S4x1lXvbJ2BUH7
 NnrNRXrpDbcv5ub8XOaF6pylXSb7hz+1SR57tbdU7u41QOdzwUOS+N/K9wjVhJZ8Zj2eETuVnMWQfyAp6x0UbPqsVtTzAeuwqD6acZGYmUB8Dy9CAZPYXO5L
 Z63ua9F+71w6k+JMBlFLOg==
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 18:44, Kent Overstreet wrote:
> This patch reworks bio_for_each_segment_all() to be more inline with how
> the other bio iterators work:
> 
>   - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>     one in the iterator and pass a pointer to it - bad. This way makes it
>     clearer what's a constructed value vs. a reference to something
>     pre-existing, and it also will help with cleaning up and
>     consolidating code with bio_for_each_folio_all().
> 
>   - We now provide bio_for_each_segment_all_continue(), for squashfs:
>     this makes their code clearer.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Phillip Lougher <phillip@squashfs.org.uk>

> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c

> @@ -170,21 +172,25 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>   		if (res)
>   			goto out;
>   
> -		if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
> +		bvec = bio_iter_all_peek(bio, &iter);
> +
> +		if (WARN_ON_ONCE(!bvec.bv_len)) {
>   			res = -EIO;
>   			goto out_free_bio;
>   		}
>   		/* Extract the length of the metadata block */
> -		data = bvec_virt(bvec);
> +		data = bvec_virt(&bvec);
>   		length = data[offset];
> -		if (offset < bvec->bv_len - 1) {
> +		if (offset < bvec.bv_len - 1) {
>   			length |= data[offset + 1] << 8;
>   		} else {
> -			if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
> +			bio_iter_all_advance(bio, &iter, bvec.bv_len);
> +
> +			if (WARN_ON_ONCE(!bvec.bv_len)) {
>   				res = -EIO;
>   				goto out_free_bio;
>   			}
> -			data = bvec_virt(bvec);
> +			data = bvec_virt(&bvec);
>   			length |= data[0] << 8;
>   		}

There is a problem with the above code, on testing I get the following
results:

Index 78018785329, offset 49, bvec.bv_len 1024: In same bio, metadata 
length 32780
Index 77867356495, offset 335, bvec.bv_len 1024: In same bio, metadata 
length 3214
Index 78012985028, offset 708, bvec.bv_len 1024: In same bio, metadata 
length 3161
Index 77738921515, offset 555, bvec.bv_len 1024: In same bio, metadata 
length 2647
Index 78012988191, offset 799, bvec.bv_len 1024: In same bio, metadata 
length 3157
Index 77738926684, offset 604, bvec.bv_len 1024: In same bio, metadata 
length 2291
Index 77738933889, offset 641, bvec.bv_len 1024: In same bio, metadata 
length 2549
Index 77738936440, offset 120, bvec.bv_len 1024: In same bio, metadata 
length 2375
Index 77738938817, offset 449, bvec.bv_len 1024: In same bio, metadata 
length 2686
Index 78018785329, offset 49, bvec.bv_len 1024: In same bio, metadata 
length 32780
Index 77867356495, offset 335, bvec.bv_len 1024: In same bio, metadata 
length 3214
Index 78012985028, offset 708, bvec.bv_len 1024: In same bio, metadata 
length 3161
Index 77738941505, offset 65, bvec.bv_len 1024: In same bio, metadata 
length 2730
Index 78012988191, offset 799, bvec.bv_len 1024: In same bio, metadata 
length 3157
Index 77738946766, offset 206, bvec.bv_len 1024: In same bio, metadata 
length 2651
Index 77738949419, offset 811, bvec.bv_len 1024: In same bio, metadata 
length 2616
Index 77738952037, offset 357, bvec.bv_len 1024: In same bio, metadata 
length 2712
Index 77738954751, offset 1023, bvec.bv_len 1024: Overlapping bios, 
metadata length 41205, low-byte 245 high-byte 160
SQUASHFS error: Failed to read block 0x12199a5001: -5
Kernel panic - not syncing: squashfs read failed

The output should be fairly explanatory.

When the two-byte length field is in the same bio, it is correctly read.

When it overlaps two bios, the first (low-byte) is read correctly, but
the high byte read from the second bio is wrong.  It is being read as
160 when it should be 10.

So the code that reads the second bio isn't working as it should do.

Phillip


>   		bio_free_pages(bio);
> diff --git a/fs/squashfs/lz4_wrapper.c b/fs/squashfs/lz4_wrapper.c
> index 49797729f1..bd0dd787d2 100644
> --- a/fs/squashfs/lz4_wrapper.c
> +++ b/fs/squashfs/lz4_wrapper.c
> @@ -92,20 +92,23 @@ static int lz4_uncompress(struct squashfs_sb_info *msblk, void *strm,
>   	struct bio *bio, int offset, int length,
>   	struct squashfs_page_actor *output)
>   {
> -	struct bvec_iter_all iter_all = {};
> -	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
> +	struct bvec_iter_all iter;
> +	struct bio_vec bvec;
>   	struct squashfs_lz4 *stream = strm;
>   	void *buff = stream->input, *data;
>   	int bytes = length, res;
>   
> -	while (bio_next_segment(bio, &iter_all)) {
> -		int avail = min(bytes, ((int)bvec->bv_len) - offset);
> +	bvec_iter_all_init(&iter);
> +	bio_iter_all_advance(bio, &iter, offset);
>   
> -		data = bvec_virt(bvec);
> -		memcpy(buff, data + offset, avail);
> +	bio_for_each_segment_all_continue(bvec, bio, iter) {
> +		unsigned avail = min_t(unsigned, bytes, bvec.bv_len);
> +
> +		memcpy(buff, bvec_virt(&bvec), avail);
>   		buff += avail;
>   		bytes -= avail;
> -		offset = 0;
> +		if (!bytes)
> +			break;
>   	}
>   
>   	res = LZ4_decompress_safe(stream->input, stream->output,
> diff --git a/fs/squashfs/lzo_wrapper.c b/fs/squashfs/lzo_wrapper.c
> index d216aeefa8..bccfcfa12e 100644
> --- a/fs/squashfs/lzo_wrapper.c
> +++ b/fs/squashfs/lzo_wrapper.c
> @@ -66,21 +66,24 @@ static int lzo_uncompress(struct squashfs_sb_info *msblk, void *strm,
>   	struct bio *bio, int offset, int length,
>   	struct squashfs_page_actor *output)
>   {
> -	struct bvec_iter_all iter_all = {};
> -	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
> +	struct bvec_iter_all iter;
> +	struct bio_vec bvec;
>   	struct squashfs_lzo *stream = strm;
>   	void *buff = stream->input, *data;
>   	int bytes = length, res;
>   	size_t out_len = output->length;
>   
> -	while (bio_next_segment(bio, &iter_all)) {
> -		int avail = min(bytes, ((int)bvec->bv_len) - offset);
> +	bvec_iter_all_init(&iter);
> +	bio_iter_all_advance(bio, &iter, offset);
>   
> -		data = bvec_virt(bvec);
> -		memcpy(buff, data + offset, avail);
> +	bio_for_each_segment_all_continue(bvec, bio, iter) {
> +		unsigned avail = min_t(unsigned, bytes, bvec.bv_len);
> +
> +		memcpy(buff, bvec_virt(&bvec), avail);
>   		buff += avail;
>   		bytes -= avail;
> -		offset = 0;
> +		if (!bytes)
> +			break;
>   	}
>   
>   	res = lzo1x_decompress_safe(stream->input, (size_t)length,
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 961ba24802..c08ff3b406 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -215,7 +215,7 @@ void fsverity_verify_bio(struct bio *bio)
>   	const struct fsverity_info *vi = inode->i_verity_info;
>   	const struct merkle_tree_params *params = &vi->tree_params;
>   	struct ahash_request *req;
> -	struct bio_vec *bv;
> +	struct bio_vec bv;
>   	struct bvec_iter_all iter_all;
>   	unsigned long max_ra_pages = 0;
>   
> @@ -238,7 +238,7 @@ void fsverity_verify_bio(struct bio *bio)
>   	}
>   
>   	bio_for_each_segment_all(bv, bio, iter_all) {
> -		struct page *page = bv->bv_page;
> +		struct page *page = bv.bv_page;
>   		unsigned long level0_index = page->index >> params->log_arity;
>   		unsigned long level0_ra_pages =
>   			min(max_ra_pages, params->level0_blocks - level0_index);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c1da63f6c8..554eebd6a9 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -76,22 +76,37 @@ static inline void *bio_data(struct bio *bio)
>   	return NULL;
>   }
>   
> -static inline bool bio_next_segment(const struct bio *bio,
> -				    struct bvec_iter_all *iter)
> +static inline struct bio_vec bio_iter_all_peek(const struct bio *bio,
> +					       struct bvec_iter_all *iter)
>   {
> -	if (iter->idx >= bio->bi_vcnt)
> -		return false;
> +	BUG_ON(iter->idx >= bio->bi_vcnt);
> +	return bvec_iter_all_peek(bio->bi_io_vec, iter);
> +}
>   
> -	bvec_advance(&bio->bi_io_vec[iter->idx], iter);
> -	return true;
> +static inline void bio_iter_all_advance(const struct bio *bio,
> +					struct bvec_iter_all *iter,
> +					unsigned bytes)
> +{
> +	bvec_iter_all_advance(bio->bi_io_vec, iter, bytes);
> +
> +	BUG_ON(iter->idx > bio->bi_vcnt || (iter->idx == bio->bi_vcnt && iter->done));
>   }
>   
> +#define bio_for_each_segment_all_continue(bvl, bio, iter)		\
> +	for (;								\
> +	     iter.idx < bio->bi_vcnt &&					\
> +		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
> +	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
> +
>   /*
>    * drivers should _never_ use the all version - the bio may have been split
>    * before it got to the driver and the driver won't own all of it
>    */
> -#define bio_for_each_segment_all(bvl, bio, iter) \
> -	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
> +#define bio_for_each_segment_all(bvl, bio, iter)			\
> +	for (bvec_iter_all_init(&iter);					\
> +	     iter.idx < bio->bi_vcnt &&					\
> +		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
> +	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
>   
>   static inline void bio_advance_iter(const struct bio *bio,
>   				    struct bvec_iter *iter, unsigned int bytes)
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 35c25dff65..12f0e073c0 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -46,12 +46,6 @@ struct bvec_iter {
>   						   current bvec */
>   } __packed;
>   
> -struct bvec_iter_all {
> -	struct bio_vec	bv;
> -	int		idx;
> -	unsigned	done;
> -};
> -
>   /*
>    * various member access, note that bio_data should of course not be used
>    * on highmem page vectors
> @@ -145,7 +139,10 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
>   		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
>   	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
>   
> -/* for iterating one bio from start to end */
> +/*
> + * bvec_iter_all: for advancing over a bio as it was originally created, but
> + * with the usual bio_for_each_segment interface - nonstandard, do not use:
> + */
>   #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
>   {									\
>   	.bi_sector	= 0,						\
> @@ -154,33 +151,45 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
>   	.bi_bvec_done	= 0,						\
>   }
>   
> -static inline struct bio_vec *bvec_init_iter_all(struct bvec_iter_all *iter_all)
> +/*
> + * bvec_iter_all: for advancing over individual pages in a bio, as it was when
> + * it was first created:
> + */
> +struct bvec_iter_all {
> +	int		idx;
> +	unsigned	done;
> +};
> +
> +static inline void bvec_iter_all_init(struct bvec_iter_all *iter_all)
>   {
>   	iter_all->done = 0;
>   	iter_all->idx = 0;
> +}
>   
> -	return &iter_all->bv;
> +static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
> +						struct bvec_iter_all *iter)
> +{
> +	struct bio_vec bv = bvec[iter->idx];
> +
> +	bv.bv_offset	+= iter->done;
> +	bv.bv_len	-= iter->done;
> +
> +	bv.bv_page	+= bv.bv_offset >> PAGE_SHIFT;
> +	bv.bv_offset	&= ~PAGE_MASK;
> +	bv.bv_len	= min_t(unsigned, PAGE_SIZE - bv.bv_offset, bv.bv_len);
> +
> +	return bv;
>   }
>   
> -static inline void bvec_advance(const struct bio_vec *bvec,
> -				struct bvec_iter_all *iter_all)
> +static inline void bvec_iter_all_advance(const struct bio_vec *bvec,
> +					 struct bvec_iter_all *iter,
> +					 unsigned bytes)
>   {
> -	struct bio_vec *bv = &iter_all->bv;
> -
> -	if (iter_all->done) {
> -		bv->bv_page++;
> -		bv->bv_offset = 0;
> -	} else {
> -		bv->bv_page = bvec->bv_page + (bvec->bv_offset >> PAGE_SHIFT);
> -		bv->bv_offset = bvec->bv_offset & ~PAGE_MASK;
> -	}
> -	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
> -			   bvec->bv_len - iter_all->done);
> -	iter_all->done += bv->bv_len;
> +	iter->done += bytes;
>   
> -	if (iter_all->done == bvec->bv_len) {
> -		iter_all->idx++;
> -		iter_all->done = 0;
> +	while (iter->done && iter->done >= bvec[iter->idx].bv_len) {
> +		iter->done -= bvec[iter->idx].bv_len;
> +		iter->idx++;
>   	}
>   }
>   

