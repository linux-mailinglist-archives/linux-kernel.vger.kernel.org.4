Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D56688912
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBBVfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBBVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:35:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F5484FA5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69418B8289F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A6C433A7;
        Thu,  2 Feb 2023 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675373702;
        bh=uJDn851yK+BrevF94iZ7LAZiRgm42e9IzrvdJtjGikQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxxNvIwjB7l7rnX6Xl06YsNMT4w75RmKbnwVG19qoI55+/vxiR4mrzw6gEBwa43+i
         yQe3x+b7s0Lq0IyMRk9D/1RmSqWNWvWfQL8kIK26vOKI74kYQq9vUm8pzU4LxvQGLG
         zbsK2vKIchyCJJXVC8IMHrEzw23DvJC1Xrx569SYPGTzwb/+flam1Jv9dvsPRfukVw
         5YIKU3EjN0jqzn0y9s/pNtENz8dGNNV/Km9o6FTFJamrnKegMmAZ1utnu3/uIwEiDj
         /VLrfeBzXhU4wGJ3Mft7CubCoe3M5Dku2BK9v8m1613A0soD0PqeaAf6alDdstYA0Z
         lf1DPsTNFrBVA==
Date:   Thu, 2 Feb 2023 13:35:00 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] f2fs: clean up parameters of
 iostat_update_and_unbind_ctx()
Message-ID: <Y9wshEwTfCAwEb/4@google.com>
References: <20230201104703.31008-1-frank.li@vivo.com>
 <20230201104703.31008-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201104703.31008-2-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I combined two patches into one w/ Chao's reviewed-by.
Let me know if you have other concern.

On 02/01, Yangtao Li wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Parsing sync/rw type from bio inside iostat_update_and_unbind_ctx()
> to avoid unnecessary parameters.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> [Yangtao: remove lat_type check]
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> change:
> -remove lat_type check
>  fs/f2fs/data.c   |  4 ++--
>  fs/f2fs/iostat.c | 19 ++++++++++---------
>  fs/f2fs/iostat.h |  4 ++--
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 86fc28adc970..82e326c0e11d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -292,7 +292,7 @@ static void f2fs_read_end_io(struct bio *bio)
>  	struct bio_post_read_ctx *ctx;
>  	bool intask = in_task();
>  
> -	iostat_update_and_unbind_ctx(bio, READ_IO);
> +	iostat_update_and_unbind_ctx(bio);
>  	ctx = bio->bi_private;
>  
>  	if (time_to_inject(sbi, FAULT_READ_IO))
> @@ -330,7 +330,7 @@ static void f2fs_write_end_io(struct bio *bio)
>  	struct bio_vec *bvec;
>  	struct bvec_iter_all iter_all;
>  
> -	iostat_update_and_unbind_ctx(bio, bio->bi_opf & REQ_SYNC ? WRITE_SYNC_IO : WRITE_ASYNC_IO);
> +	iostat_update_and_unbind_ctx(bio);
>  	sbi = bio->bi_private;
>  
>  	if (time_to_inject(sbi, FAULT_WRITE_IO))
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index c767a2e7d5a9..3d5bfb1ad585 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -228,11 +228,6 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>  		return;
>  	}
>  
> -	if (lat_type >= MAX_IO_TYPE) {
> -		f2fs_warn(sbi, "%s: %d over MAX_IO_TYPE", __func__, lat_type);
> -		return;
> -	}
> -
>  	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>  	io_lat->sum_lat[lat_type][page_type] += ts_diff;
>  	io_lat->bio_cnt[lat_type][page_type]++;
> @@ -241,14 +236,20 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>  	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>  }
>  
> -void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type lat_type)
> +void iostat_update_and_unbind_ctx(struct bio *bio)
>  {
>  	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> +	enum iostat_lat_type lat_type;
>  
> -	if (lat_type == READ_IO)
> -		bio->bi_private = iostat_ctx->post_read_ctx;
> -	else
> +	if (op_is_write(bio_op(bio))) {
> +		lat_type = bio->bi_opf & REQ_SYNC ?
> +				WRITE_SYNC_IO : WRITE_ASYNC_IO;
>  		bio->bi_private = iostat_ctx->sbi;
> +	} else {
> +		lat_type = READ_IO;
> +		bio->bi_private = iostat_ctx->post_read_ctx;
> +	}
> +
>  	__update_iostat_latency(iostat_ctx, lat_type);
>  	mempool_free(iostat_ctx, bio_iostat_ctx_pool);
>  }
> diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
> index 1f827a2fe6b2..eb99d05cf272 100644
> --- a/fs/f2fs/iostat.h
> +++ b/fs/f2fs/iostat.h
> @@ -58,7 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
>  	return iostat_ctx->post_read_ctx;
>  }
>  
> -extern void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type);
> +extern void iostat_update_and_unbind_ctx(struct bio *bio);
>  extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>  		struct bio *bio, struct bio_post_read_ctx *ctx);
>  extern int f2fs_init_iostat_processing(void);
> @@ -68,7 +68,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
>  #else
>  static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>  		enum iostat_type type, unsigned long long io_bytes) {}
> -static inline void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type) {}
> +static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
>  static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>  		struct bio *bio, struct bio_post_read_ctx *ctx) {}
>  static inline void iostat_update_submit_ctx(struct bio *bio,
> -- 
> 2.25.1
