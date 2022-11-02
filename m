Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61824616E61
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKBUNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKBUNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:13:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047CBE5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:13:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so4023253pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emp5tyYcPGKa08xxALMwIEN7mCVaGstbPSwT5xJzy3A=;
        b=AucYyypC9aywq8xqowItZNi6cO6lXib4bpB3tFFO+c8yy0PKGwJ00mZGzU4qoZrOg4
         +W9Qe99mMk3Gpq2AQuB6p3F+hgmu3OaBMml9NiRqHkAqagVGbQrbkohnaIz+m/xyPrQO
         uw6U/xujEOSnRfG8cTl+soy06Uk5uVY2OOuDvNJNkm0VjE2hCN6ugcQ8R5XvM8q6O8md
         kiPWkhnxaUAHsmyn/LxlpuPjXu/JqD8X8lrTEFFRNdRfSegN5gR7OQCr8qNoqYADMKee
         6uN4yd0WV4TdaUBL3UM81/ACutFMG7AZpJOaNFzlk2jil4jAWTYgXpahtRHbqplbJSKb
         +bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emp5tyYcPGKa08xxALMwIEN7mCVaGstbPSwT5xJzy3A=;
        b=JVYR8S4o47EjD9FW0yKdFMKjnyMj+kthajB1AWJRb5cRbY5B33Qpt5LuLzYHJpFT+S
         T787uZ8jMlve/jgRnIBrmo3aqZ5Xg7nGNwLQzy7gnQZayfzDFStJYraVTDv8c6Q8Zonx
         D3Rnr+VQDpi2wym6nG7th9u5dqM0CWdjMf+jgl8g7ZfxF3btFXdYbPY6Oz5iOdn0aflu
         /GvW1KzEV3VI+OPeMXdvv4meOQ068wQZuo29Q6/c3H7P3Inm7pp5TqyHmaIcFywudjbv
         2Q3aj72UZpPvfE3NqQkhVmYu3BnUrZ9Px39ai148fzS2Xj5yGxzB9QldJmibmbSAeFiY
         Q6nA==
X-Gm-Message-State: ACrzQf10MbwDT7826Q0jTVS9+5D9cyZRdMHdhxsHS3FlqSWpMXhWFlvX
        Lc2dXVdug6jFs1GZdJVJNs4=
X-Google-Smtp-Source: AMsMyM4ozF0iVC9zZvir9b9xeFOH1FENuTKo98GEXzEV4xXkI0eCsRFLJilIIHitFCRtFACreR3F5g==
X-Received: by 2002:a17:90b:3b82:b0:213:6ae1:cc3d with SMTP id pc2-20020a17090b3b8200b002136ae1cc3dmr27784013pjb.27.1667419989227;
        Wed, 02 Nov 2022 13:13:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3fd5:8614:6eb0:846b])
        by smtp.gmail.com with ESMTPSA id 13-20020a62190d000000b00562cfc80864sm8842314pfz.36.2022.11.02.13.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:13:08 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 2 Nov 2022 13:13:06 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 1/9] zram: Preparation for multi-zcomp support
Message-ID: <Y2LPUlircv6a74mJ@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-2-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018045533.2396670-2-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:55:25PM +0900, Sergey Senozhatsky wrote:
> The patch turns compression streams and compressor algorithm
> name struct zram members into arrays, so that we can have
> multiple compression streams support (in the next patches).
> 
> The patch uses a rather explicit API for compressor selection:
> 
> - Get primary (default) compression stream
> 	zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP])
> - Get secondary compression stream
> 	zcomp_stream_get(zram->comps[ZRAM_SECONDARY_ZCOMP])
> 
> We use similar API for compression streams put().
> 
> At this point we always have just one compression stream,
> since CONFIG_ZRAM_MULTI_COMP is not yet defined.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zcomp.c    |  6 +--
>  drivers/block/zram/zcomp.h    |  2 +-
>  drivers/block/zram/zram_drv.c | 87 ++++++++++++++++++++++++-----------
>  drivers/block/zram/zram_drv.h | 14 +++++-
>  4 files changed, 77 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 0916de952e09..55af4efd7983 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -206,7 +206,7 @@ void zcomp_destroy(struct zcomp *comp)
>   * case of allocation error, or any other error potentially
>   * returned by zcomp_init().
>   */
> -struct zcomp *zcomp_create(const char *compress)
> +struct zcomp *zcomp_create(const char *alg)
>  {
>  	struct zcomp *comp;
>  	int error;
> @@ -216,14 +216,14 @@ struct zcomp *zcomp_create(const char *compress)
>  	 * is not loaded yet. We must do it here, otherwise we are about to
>  	 * call /sbin/modprobe under CPU hot-plug lock.
>  	 */
> -	if (!zcomp_available_algorithm(compress))
> +	if (!zcomp_available_algorithm(alg))
>  		return ERR_PTR(-EINVAL);
>  
>  	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
>  	if (!comp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	comp->name = compress;
> +	comp->name = alg;
>  	error = zcomp_init(comp);
>  	if (error) {
>  		kfree(comp);
> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> index 40f6420f4b2e..cdefdef93da8 100644
> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -27,7 +27,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
>  ssize_t zcomp_available_show(const char *comp, char *buf);
>  bool zcomp_available_algorithm(const char *comp);
>  
> -struct zcomp *zcomp_create(const char *comp);
> +struct zcomp *zcomp_create(const char *alg);
>  void zcomp_destroy(struct zcomp *comp);
>  
>  struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 966aab902d19..770ea3489eb6 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1007,36 +1007,53 @@ static ssize_t comp_algorithm_show(struct device *dev,
>  	struct zram *zram = dev_to_zram(dev);
>  
>  	down_read(&zram->init_lock);
> -	sz = zcomp_available_show(zram->compressor, buf);
> +	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_ZCOMP], buf);
>  	up_read(&zram->init_lock);
>  
>  	return sz;
>  }
>  
> +static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
> +{
> +	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
> +	if (zram->comp_algs[idx] != default_compressor)
> +		kfree(zram->comp_algs[idx]);
> +	zram->comp_algs[idx] = alg;
> +}
> +
>  static ssize_t comp_algorithm_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	struct zram *zram = dev_to_zram(dev);
> -	char compressor[ARRAY_SIZE(zram->compressor)];
> +	char *compressor;
>  	size_t sz;
>  
> -	strscpy(compressor, buf, sizeof(compressor));
> +	sz = strlen(buf);
> +	if (sz >= CRYPTO_MAX_ALG_NAME)
> +		return -E2BIG;
> +
> +	compressor = kstrdup(buf, GFP_KERNEL);
> +	if (!compressor)
> +		return -ENOMEM;
> +
>  	/* ignore trailing newline */
> -	sz = strlen(compressor);
>  	if (sz > 0 && compressor[sz - 1] == '\n')
>  		compressor[sz - 1] = 0x00;
>  
> -	if (!zcomp_available_algorithm(compressor))
> +	if (!zcomp_available_algorithm(compressor)) {
> +		kfree(compressor);
>  		return -EINVAL;
> +	}
>  
>  	down_write(&zram->init_lock);
>  	if (init_done(zram)) {
>  		up_write(&zram->init_lock);
> +		kfree(compressor);
>  		pr_info("Can't change algorithm for initialized device\n");
>  		return -EBUSY;
>  	}
>  
> -	strcpy(zram->compressor, compressor);
> +	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, compressor);
>  	up_write(&zram->init_lock);
>  	return len;
>  }
> @@ -1284,7 +1301,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>  	size = zram_get_obj_size(zram, index);
>  
>  	if (size != PAGE_SIZE)
> -		zstrm = zcomp_stream_get(zram->comp);
> +		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  
>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>  	if (size == PAGE_SIZE) {
> @@ -1296,7 +1313,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>  		dst = kmap_atomic(page);
>  		ret = zcomp_decompress(zstrm, src, size, dst);
>  		kunmap_atomic(dst);
> -		zcomp_stream_put(zram->comp);
> +		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  	}
>  	zs_unmap_object(zram->mem_pool, handle);
>  	zram_slot_unlock(zram, index);
> @@ -1363,13 +1380,13 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  	kunmap_atomic(mem);
>  
>  compress_again:
> -	zstrm = zcomp_stream_get(zram->comp);
> +	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  	src = kmap_atomic(page);
>  	ret = zcomp_compress(zstrm, src, &comp_len);
>  	kunmap_atomic(src);
>  
>  	if (unlikely(ret)) {
> -		zcomp_stream_put(zram->comp);
> +		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  		pr_err("Compression failed! err=%d\n", ret);
>  		zs_free(zram->mem_pool, handle);
>  		return ret;
> @@ -1397,7 +1414,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  				__GFP_HIGHMEM |
>  				__GFP_MOVABLE);
>  	if (IS_ERR((void *)handle)) {
> -		zcomp_stream_put(zram->comp);
> +		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  		atomic64_inc(&zram->stats.writestall);
>  		handle = zs_malloc(zram->mem_pool, comp_len,
>  				GFP_NOIO | __GFP_HIGHMEM |
> @@ -1414,14 +1431,14 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  		 * zstrm buffer back. It is necessary that the dereferencing
>  		 * of the zstrm variable below occurs correctly.
>  		 */
> -		zstrm = zcomp_stream_get(zram->comp);
> +		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  	}
>  
>  	alloced_pages = zs_get_total_pages(zram->mem_pool);
>  	update_used_max(zram, alloced_pages);
>  
>  	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
> -		zcomp_stream_put(zram->comp);
> +		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  		zs_free(zram->mem_pool, handle);
>  		return -ENOMEM;
>  	}
> @@ -1435,7 +1452,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
>  	if (comp_len == PAGE_SIZE)
>  		kunmap_atomic(src);
>  
> -	zcomp_stream_put(zram->comp);
> +	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
>  	zs_unmap_object(zram->mem_pool, handle);
>  	atomic64_add(comp_len, &zram->stats.compr_data_size);
>  out:
> @@ -1710,6 +1727,20 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
>  	return ret;
>  }
>  
> +static void zram_destroy_comps(struct zram *zram)
> +{
> +	u32 idx;
> +
> +	for (idx = 0; idx < ZRAM_MAX_ZCOMPS; idx++) {
> +		struct zcomp *comp = zram->comps[idx];
> +
> +		zram->comps[idx] = NULL;
> +		if (IS_ERR_OR_NULL(comp))

nit:

Why don't you use just NULL check? I don't see any error setting
for zram->comps(Maybe later patch? Will keep check)?
