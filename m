Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803EE67F44A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjA1DZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjA1DZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:25:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056080036
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:25:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A1361DD0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC9CC433D2;
        Sat, 28 Jan 2023 03:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674876315;
        bh=zF4sk78pBYi4YYSfHkxiC48+SMUtQAl2WB+q3cKbATM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bLCUcXkEoS6OXy/yzH9fT7wQPSFAhl6R+Vi3ATKh+UUYQa3jLMMxdduws18fVsXHk
         OpXKu6UwNdzeqoGd/GpR8S1OnaKppylaDCJO7Homial+7FkERYJwhAPbnc2I+K4X20
         BvxTAApfO9/ov4xoPVbpVSY/phEbCMlzPWXfu2rdBY8/1woZEHR+N/FNbaZlRXrLBq
         94HiYSn9hMqSoTYkO4zUyETmO4iYfPiZydmb9QT9NB/D4A48lqDoO7oDAhw+iLEfOg
         mhpu2Ssw/YYlk4escpwyYKvZOpakQBNc0Jfei/bvh/jZjX/5lqGtqyzWB34fp8aYR6
         ijp8Hqhjja7IQ==
Message-ID: <8ab26acd-4df6-8330-8e82-1d258d9f0d6d@kernel.org>
Date:   Sat, 28 Jan 2023 11:25:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: use iostat_lat_type directly as a parameter in the
 iostat_update_and_unbind_ctx()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230105042240.24738-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230105042240.24738-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/5 12:22, Yangtao Li wrote:
> Convert to use iostat_lat_type as parameter instead of raw number.
> BTW, move NUM_PREALLOC_IOSTAT_CTXS to the header file, and rename
> iotype to page_type to match the definition.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/data.c   |  5 +++--
>   fs/f2fs/iostat.c | 34 +++++++++++-----------------------
>   fs/f2fs/iostat.h | 19 ++++++++++---------
>   3 files changed, 24 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c940da1c540f..4e8fd5697c42 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -292,7 +292,7 @@ static void f2fs_read_end_io(struct bio *bio)
>   	struct bio_post_read_ctx *ctx;
>   	bool intask = in_task();
>   
> -	iostat_update_and_unbind_ctx(bio, 0);
> +	iostat_update_and_unbind_ctx(bio, READ_IO);
>   	ctx = bio->bi_private;
>   
>   	if (time_to_inject(sbi, FAULT_READ_IO))
> @@ -330,7 +330,8 @@ static void f2fs_write_end_io(struct bio *bio)
>   	struct bio_vec *bvec;
>   	struct bvec_iter_all iter_all;
>   
> -	iostat_update_and_unbind_ctx(bio, 1);
> +	iostat_update_and_unbind_ctx(bio, bio->bi_opf & REQ_SYNC ? WRITE_SYNC_IO :
> +										WRITE_ASYNC_IO);

We can use op_is_write(bio_op(bio)) to check IO's rw type, why not just
passing bio arguement, and parse rw/sync types from bio inside
iostat_update_and_unbind_ctx(), it can avoid passing unneeded arguements.

Thanks,

>   	sbi = bio->bi_private;
>   
>   	if (time_to_inject(sbi, FAULT_WRITE_IO))
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index 59c72f92191a..20944c4a683a 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -14,7 +14,6 @@
>   #include "iostat.h"
>   #include <trace/events/f2fs.h>
>   
> -#define NUM_PREALLOC_IOSTAT_CTXS	128
>   static struct kmem_cache *bio_iostat_ctx_cache;
>   static mempool_t *bio_iostat_ctx_pool;
>   
> @@ -210,49 +209,38 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>   }
>   
>   static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
> -				int rw, bool is_sync)
> +				enum iostat_lat_type type)
>   {
>   	unsigned long ts_diff;
> -	unsigned int iotype = iostat_ctx->type;
> +	unsigned int page_type = iostat_ctx->type;
>   	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
> -	int idx;
>   	unsigned long flags;
>   
>   	if (!sbi->iostat_enable)
>   		return;
>   
>   	ts_diff = jiffies - iostat_ctx->submit_ts;
> -	if (iotype >= META_FLUSH)
> -		iotype = META;
> -
> -	if (rw == 0) {
> -		idx = READ_IO;
> -	} else {
> -		if (is_sync)
> -			idx = WRITE_SYNC_IO;
> -		else
> -			idx = WRITE_ASYNC_IO;
> -	}
> +	if (page_type >= META_FLUSH)
> +		page_type = META;
>   
>   	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
> -	io_lat->sum_lat[idx][iotype] += ts_diff;
> -	io_lat->bio_cnt[idx][iotype]++;
> -	if (ts_diff > io_lat->peak_lat[idx][iotype])
> -		io_lat->peak_lat[idx][iotype] = ts_diff;
> +	io_lat->sum_lat[type][page_type] += ts_diff;
> +	io_lat->bio_cnt[type][page_type]++;
> +	if (ts_diff > io_lat->peak_lat[type][page_type])
> +		io_lat->peak_lat[type][page_type] = ts_diff;
>   	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>   }
>   
> -void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
> +void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type)
>   {
>   	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> -	bool is_sync = bio->bi_opf & REQ_SYNC;
>   
> -	if (rw == 0)
> +	if (type == READ_IO)
>   		bio->bi_private = iostat_ctx->post_read_ctx;
>   	else
>   		bio->bi_private = iostat_ctx->sbi;
> -	__update_iostat_latency(iostat_ctx, rw, is_sync);
> +	__update_iostat_latency(iostat_ctx, type);
>   	mempool_free(iostat_ctx, bio_iostat_ctx_pool);
>   }
>   
> diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
> index 2c048307b6e0..1f827a2fe6b2 100644
> --- a/fs/f2fs/iostat.h
> +++ b/fs/f2fs/iostat.h
> @@ -8,20 +8,21 @@
>   
>   struct bio_post_read_ctx;
>   
> +enum iostat_lat_type {
> +	READ_IO = 0,
> +	WRITE_SYNC_IO,
> +	WRITE_ASYNC_IO,
> +	MAX_IO_TYPE,
> +};
> +
>   #ifdef CONFIG_F2FS_IOSTAT
>   
> +#define NUM_PREALLOC_IOSTAT_CTXS	128
>   #define DEFAULT_IOSTAT_PERIOD_MS	3000
>   #define MIN_IOSTAT_PERIOD_MS		100
>   /* maximum period of iostat tracing is 1 day */
>   #define MAX_IOSTAT_PERIOD_MS		8640000
>   
> -enum {
> -	READ_IO,
> -	WRITE_SYNC_IO,
> -	WRITE_ASYNC_IO,
> -	MAX_IO_TYPE,
> -};
> -
>   struct iostat_lat_info {
>   	unsigned long sum_lat[MAX_IO_TYPE][NR_PAGE_TYPE];	/* sum of io latencies */
>   	unsigned long peak_lat[MAX_IO_TYPE][NR_PAGE_TYPE];	/* peak io latency */
> @@ -57,7 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
>   	return iostat_ctx->post_read_ctx;
>   }
>   
> -extern void iostat_update_and_unbind_ctx(struct bio *bio, int rw);
> +extern void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type);
>   extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>   		struct bio *bio, struct bio_post_read_ctx *ctx);
>   extern int f2fs_init_iostat_processing(void);
> @@ -67,7 +68,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
>   #else
>   static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>   		enum iostat_type type, unsigned long long io_bytes) {}
> -static inline void iostat_update_and_unbind_ctx(struct bio *bio, int rw) {}
> +static inline void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type) {}
>   static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>   		struct bio *bio, struct bio_post_read_ctx *ctx) {}
>   static inline void iostat_update_submit_ctx(struct bio *bio,
