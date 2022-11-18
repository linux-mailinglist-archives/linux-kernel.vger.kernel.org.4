Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35262FF17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKRVBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKRVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:01:28 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CA9153A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:01:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p21so5603091plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsB2gTTpP/OQiGsd+LGWAqdXHasWRJVlovNbcAIifOg=;
        b=lxQbr6oIihZr8uuDeErMxvLhY36vFrXR6iQy5X+ejdFDZbcAAskE5W+4/gVAt/cBb6
         /9Rl+trKs3iCiEGXFkTnTVllHwjep4xMXbmn+y4h+jKewVBbmTUakyhqb7eAsYU7QzG1
         u+wgPXR4QFxTOmzBA9SvybrjGpJEwlhd3V1N0K6W2Q90WK6u6Rr7i+vSeOb3Ifp950FF
         lpj7ftAoOwCg93gg1PYOKBjE76/rmOIPbNVzA/j38v2qmUONX7wPB8SDm9ZdURty3dHM
         3lwQnKioZb1r7FJG8p1zF49biSzv9s4TUUOxRL6JjaZquwAgv5YPsDux42q5mLqERHlq
         KnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsB2gTTpP/OQiGsd+LGWAqdXHasWRJVlovNbcAIifOg=;
        b=aboV8UdQl7QPEPROVQaDpBQhW1afzBKNu68AWFlsxHDLZv9SVSLnkdRyPwuHbTTZUL
         +VjaiaF/Na3IhG3Bwmpx2AANVmayBO51VArkg95J1ry5rzAhaoYZ042uECHR38S4VkJL
         cj4OImKH7UgYYzU4jaN7z3C2X1kOQW16kBDRer5mWqzvJp9DDrf1c9nO86a5c6N6EzYn
         m7DDZ6BsWUvCRetBdyBUM5uZR/8dJe8CwelInCR6dk6iFuFnmPY1UDZGEEUhKvOwbu4s
         CwOJxqu2DlgJeWxAMFIq0O/FQAH7K085m2ZrjXrHD9babsaApQ+QJsPodUtOMf+V124C
         oLQA==
X-Gm-Message-State: ANoB5pm+XGr8NMWyoSgLgp/8gPualTKAUIF0LynBBiRSzEFKUDy6/2Dv
        NSykqQuRYB4a4b5TRuCQj7k=
X-Google-Smtp-Source: AA0mqf4eHvfhkfJqsZWgYouEZmlrSLJlvAbzq+oQJsi3I4zJ+/nom+ZSL3K+6kMA7rV4pudTwTyYQA==
X-Received: by 2002:a17:902:f313:b0:186:8518:6c97 with SMTP id c19-20020a170902f31300b0018685186c97mr1215983ple.94.1668805285191;
        Fri, 18 Nov 2022 13:01:25 -0800 (PST)
Received: from google.com ([2620:15c:211:201:bba9:9f92:b2cc:16a4])
        by smtp.gmail.com with ESMTPSA id m10-20020a634c4a000000b00476e84c3530sm3178987pgl.60.2022.11.18.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:01:24 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Nov 2022 13:01:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3fyon7v00ABtU6M@google.com>
References: <20221118182407.82548-1-nphamcs@gmail.com>
 <20221118182407.82548-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118182407.82548-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:24:07AM -0800, Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 193 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 182 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3ff86f57d08c..d73b9f9e9adf 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -271,12 +271,13 @@ struct zspage {
>  #ifdef CONFIG_ZPOOL
>  	/* links the zspage to the lru list in the pool */
>  	struct list_head lru;
> +	bool under_reclaim;
> +	/* list of unfreed handles whose objects have been reclaimed */
> +	unsigned long *deferred_handles;
>  #endif
> 
>  	struct zs_pool *pool;
> -#ifdef CONFIG_COMPACTION
>  	rwlock_t lock;
> -#endif
>  };
> 
>  struct mapping_area {
> @@ -297,10 +298,11 @@ static bool ZsHugePage(struct zspage *zspage)
>  	return zspage->huge;
>  }
> 
> -#ifdef CONFIG_COMPACTION
>  static void migrate_lock_init(struct zspage *zspage);
>  static void migrate_read_lock(struct zspage *zspage);
>  static void migrate_read_unlock(struct zspage *zspage);
> +
> +#ifdef CONFIG_COMPACTION
>  static void migrate_write_lock(struct zspage *zspage);
>  static void migrate_write_lock_nested(struct zspage *zspage);
>  static void migrate_write_unlock(struct zspage *zspage);
> @@ -308,9 +310,6 @@ static void kick_deferred_free(struct zs_pool *pool);
>  static void init_deferred_free(struct zs_pool *pool);
>  static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
>  #else
> -static void migrate_lock_init(struct zspage *zspage) {}
> -static void migrate_read_lock(struct zspage *zspage) {}
> -static void migrate_read_unlock(struct zspage *zspage) {}
>  static void migrate_write_lock(struct zspage *zspage) {}
>  static void migrate_write_lock_nested(struct zspage *zspage) {}
>  static void migrate_write_unlock(struct zspage *zspage) {}
> @@ -425,6 +424,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
>  	zs_free(pool, handle);
>  }
> 
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
> +
> +static int zs_zpool_shrink(void *pool, unsigned int pages,
> +			unsigned int *reclaimed)
> +{
> +	unsigned int total = 0;
> +	int ret = -EINVAL;
> +
> +	while (total < pages) {
> +		ret = zs_reclaim_page(pool, 8);
> +		if (ret < 0)
> +			break;
> +		total++;
> +	}
> +
> +	if (reclaimed)
> +		*reclaimed = total;
> +
> +	return ret;
> +}
> +
>  static void *zs_zpool_map(void *pool, unsigned long handle,
>  			enum zpool_mapmode mm)
>  {
> @@ -463,6 +483,7 @@ static struct zpool_driver zs_zpool_driver = {
>  	.malloc_support_movable = true,
>  	.malloc =		  zs_zpool_malloc,
>  	.free =			  zs_zpool_free,
> +	.shrink =		  zs_zpool_shrink,
>  	.map =			  zs_zpool_map,
>  	.unmap =		  zs_zpool_unmap,
>  	.total_size =		  zs_zpool_total_size,
> @@ -936,6 +957,23 @@ static int trylock_zspage(struct zspage *zspage)
>  	return 0;
>  }
> 
> +#ifdef CONFIG_ZPOOL
> +/*
> + * Free all the deferred handles whose objects are freed in zs_free.
> + */
> +static void free_handles(struct zs_pool *pool, struct zspage *zspage)
> +{
> +	unsigned long handle = (unsigned long)zspage->deferred_handles;
> +
> +	while (handle) {
> +		unsigned long nxt_handle = handle_to_obj(handle);
> +
> +		cache_free_handle(pool, handle);
> +		handle = nxt_handle;
> +	}
> +}

# else 

 static inline void free_handles(struct zs_pool *pool, struct zspage *zspage) {}

> +#endif
> +
>  static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  				struct zspage *zspage)
>  {
> @@ -950,6 +988,11 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  	VM_BUG_ON(get_zspage_inuse(zspage));
>  	VM_BUG_ON(fg != ZS_EMPTY);
> 
> +#ifdef CONFIG_ZPOOL

Let's remove the ifdef machinery here.

> +	/* Free all deferred handles from zs_free */
> +	free_handles(pool, zspage);
> +#endif
> +

Other than that, looks good to me.
