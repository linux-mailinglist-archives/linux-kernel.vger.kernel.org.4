Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AD625002
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKKCKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiKKCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:10:36 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73E5E3E6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:10:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b185so3679997pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeXSwUwF6AjEyAp6A6rHwWgKokXvJbdv3lBmf/aErhs=;
        b=aBm2wCxnOQX1faYpEVjrrmxrdJ3lXZIo7Q9U2c13MsxnOxg7PVun0fb+illk1x/alh
         hF15iDoypwXf6SQU7jsxR/NVTwTWjDFRXHV/TImi9G06WKhR33a4m1uozgPjtwULGn//
         T+w1uU+fx8yq81m7qa2mopJ/yah2h40dSuvJCp9U2HHrfH2CW4AkBrbvUN5KtCmtJY8a
         6izYVqaOnJDnaptyfzP/yN15V2lUNE6UEDwAeNvWk6o+rP0y1/3ERmAVsKH/ivumN6yz
         BN6LXkAnuLk6yE72feBzXMfIinaqMgdPTTAmVpkteBKkl5ee6CY7ztVwdzuBaGx2txsh
         Fd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeXSwUwF6AjEyAp6A6rHwWgKokXvJbdv3lBmf/aErhs=;
        b=kvxcGLt9sf4AjT3aPZ81dc8A2PvSP20JNFvSCran+Yhyg/55hmYuCDHQUgrJNhe813
         NaCYYq9FdNDNpNpXCX14aqnURVsu1mrEa+F/24yjtIjBpAKrGhXsnCmxj/IO0ZigxdOh
         ZvO6A0qivw3dYxjckQw5Wl09RZ5lxRPoqW+E8udG1OVGnmxi0YYI4iiz6tQqxYP8+kA/
         zQNrAt25gSIQs4D9wsF6ir0+MPvBEMM701JVPFK0Y3OxA+gTELkNEkw/f+HtrhPQXNgE
         G2TlROvgOhdETVQkaJW1p4QaQKtpLLG7mEbFgrGFWs+h428BfJl/iP0+Zv9mxMobAPRm
         tcZQ==
X-Gm-Message-State: ACrzQf2Njd/JVXvkL7rA0GUlrzjFGbHf32hMOgKwR9OmynN4GHLRzTJn
        y7+Fgk9xDJNJLmxIXXstJMoUTNMV+54=
X-Google-Smtp-Source: AMsMyM5AqSE78E+7okFMArM0KkexVvAW1VX2OHMucapC5vnpi5foZyJ4cN0PLqG6SGqC7YIhVhmdLw==
X-Received: by 2002:a63:d251:0:b0:439:ac9b:34ee with SMTP id t17-20020a63d251000000b00439ac9b34eemr4221743pgi.437.1668132634406;
        Thu, 10 Nov 2022 18:10:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id x11-20020a17090a9dcb00b001faafa42a9esm450525pjv.26.2022.11.10.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:10:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 18:10:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 6/9] zsmalloc: pass limit on pages per-zspage to
 zs_create_pool()
Message-ID: <Y22vGNX0yGaAeoDR@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-7-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-7-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:41:05PM +0900, Sergey Senozhatsky wrote:
> Allow zsmalloc pool owner to specify max number of pages
> per-zspage (during pool creation), so that different pools
> can have different characteristics.
> 
> By default we pass ZS_DEFAULT_PAGES_PER_ZSPAGE which is 4
> (matches the current order 2 zspages limit).

How could user decide what's the best size for their workload?

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c |  3 ++-
>  include/linux/zsmalloc.h      |  2 +-
>  mm/zsmalloc.c                 | 11 +++++++----
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 90b0c66bbd5b..bec02f636bce 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1247,7 +1247,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
>  	if (!zram->table)
>  		return false;
>  
> -	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
> +	zram->mem_pool = zs_create_pool(zram->disk->disk_name,
> +					ZS_DEFAULT_PAGES_PER_ZSPAGE);
>  	if (!zram->mem_pool) {
>  		vfree(zram->table);
>  		return false;
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index b6b8654a2d45..28f2b9cb1c47 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -50,7 +50,7 @@ struct zs_pool_stats {
>  
>  struct zs_pool;
>  
> -struct zs_pool *zs_create_pool(const char *name);
> +struct zs_pool *zs_create_pool(const char *name, unsigned long num_pages);
>  void zs_destroy_pool(struct zs_pool *pool);
>  
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index d329bd673baa..42987a913f45 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -366,7 +366,7 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
>  	 * different contexts and its caller must provide a valid
>  	 * gfp mask.
>  	 */
> -	return zs_create_pool(name);
> +	return zs_create_pool(name, ZS_DEFAULT_PAGES_PER_ZSPAGE);
>  }
>  
>  static void zs_zpool_destroy(void *pool)
> @@ -2195,6 +2195,7 @@ static int zs_register_shrinker(struct zs_pool *pool)
>  /**
>   * zs_create_pool - Creates an allocation pool to work from.
>   * @name: pool name to be created
> + * @num_pages: maximum number of pages per-zspage

How about "max_page_chain:"? 

>   *
>   * This function must be called before anything when using
>   * the zsmalloc allocator.
> @@ -2202,18 +2203,20 @@ static int zs_register_shrinker(struct zs_pool *pool)
>   * On success, a pointer to the newly created pool is returned,
>   * otherwise NULL.
>   */
> -struct zs_pool *zs_create_pool(const char *name)
> +struct zs_pool *zs_create_pool(const char *name, unsigned long num_pages)
>  {
>  	int i;
>  	struct zs_pool *pool;
>  	struct size_class *prev_class = NULL;
> -	unsigned long num_pages;
> +
> +	if (WARN_ON(num_pages < ZS_MIN_PAGES_PER_ZSPAGE ||
> +		    num_pages > ZS_MAX_PAGES_PER_ZSPAGE))
> +		return NULL;
>  
>  	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
>  	if (!pool)
>  		return NULL;
>  
> -	num_pages = ZS_DEFAULT_PAGES_PER_ZSPAGE;
>  	/* min_alloc_size must be multiple of ZS_ALIGN */
>  	pool->min_alloc_size = num_pages << PAGE_SHIFT >> OBJ_INDEX_BITS;
>  	pool->min_alloc_size = max(pool->min_alloc_size, ZS_MIN_ALLOC_SIZE);
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
