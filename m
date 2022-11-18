Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03162FE02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiKRTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiKRTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:32:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AA786F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:32:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o7so5361408pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YT7jh12C9b+MGVUbQC67HmN3j2iOcFYyfJpQMQ1dp4c=;
        b=nWMaCZ3QP/mFnpvGl93qvAIEWDpEyst5izQAWsgrbNJS4E4vPHQ5vE+8QCmrxGt/mt
         DvDFNExdjyfLVA6gHlRG2uI/7rdjPKgjJDcEx8ZNv24iSqb7jE4p/WhzrFEPwxSDhqDY
         1KfiV7EdIOU3PTZ6CxPRLMSNgZwvSusIsIloYZu5k8rk3yhLr6pL7xoMlmVEO+aaTPiv
         jieYjfZawyQwnaSOYnTXIgsDoFZJ94RgM8/coHMH/tKiRRROOjNklNNjUyNgS6KpAL0Q
         GSLomCr3HmLPe2vE66d9pj2Kh3Idc8ja5ibNriP61V3PZ2AsPyj776iGOLTs81CdCDZN
         S8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT7jh12C9b+MGVUbQC67HmN3j2iOcFYyfJpQMQ1dp4c=;
        b=AAyn3SvXMbANO/fxknPOpvrqwq9KIEFXTYKKoS+YDUCAhkw88I4K6G+RHcsV4yZAvF
         mPtkO+l0ITMo+qlKe8FHdCSsm3xo+7cnS0STAQkYnJCPBFRHVlpDhOCuT2MEZZnM6vDD
         qktcVBdE7q46NWQA9WJJA++Ee34PjS6NJf6HhlyfbDu2Hyi0cbdtQWd8WpkXuE8A46qY
         M15FZHWofclAqZlKy98MptQgoGlGgYo06E7uc1zpIifzsEUavdUMYTkFpgo2GQCMxiqr
         SiXw6vpFSMkDCfgDls+U954dxZ6QgYjZN3/W+l5UoWrW432JX5Lt9uOT6/vgMB2d5/ak
         yOMQ==
X-Gm-Message-State: ANoB5pmC2UOiTi2eyn2fILJtDr0vRKoo6TylL32clQXFlE9Cd5B9JBts
        YiebvYq0P5pGF4VQoEovpF8=
X-Google-Smtp-Source: AA0mqf7HQUep/xODul/qAH2LRmvIbHpj0vO/tG3rt0ek/yMX9K71eY6mGcsX8r0Z759elpZeUn7FIw==
X-Received: by 2002:a17:902:7881:b0:185:5537:f399 with SMTP id q1-20020a170902788100b001855537f399mr990413pll.39.1668799923782;
        Fri, 18 Nov 2022 11:32:03 -0800 (PST)
Received: from google.com ([2620:15c:211:201:bba9:9f92:b2cc:16a4])
        by smtp.gmail.com with ESMTPSA id cp17-20020a170902e79100b00186b8752a78sm4080558plb.80.2022.11.18.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:32:03 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Nov 2022 11:32:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3fdsTDFgCzhcDwo@google.com>
References: <20221118182407.82548-1-nphamcs@gmail.com>
 <20221118182407.82548-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118182407.82548-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:24:05AM -0800, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 326faa751f0a..9e7b54324181 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -239,6 +239,11 @@ struct zs_pool {
>  	/* Compact classes */
>  	struct shrinker shrinker;
> 
> +#ifdef CONFIG_ZPOOL
> +	/* List tracking the zspages in LRU order by most recently added object */
> +	struct list_head lru;
> +#endif
> +
>  #ifdef CONFIG_ZSMALLOC_STAT
>  	struct dentry *stat_dentry;
>  #endif
> @@ -260,6 +265,12 @@ struct zspage {
>  	unsigned int freeobj;
>  	struct page *first_page;
>  	struct list_head list; /* fullness list */
> +
> +#ifdef CONFIG_ZPOOL
> +	/* links the zspage to the lru list in the pool */
> +	struct list_head lru;
> +#endif
> +
>  	struct zs_pool *pool;
>  #ifdef CONFIG_COMPACTION
>  	rwlock_t lock;
> @@ -352,6 +363,18 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
>  	kmem_cache_free(pool->zspage_cachep, zspage);
>  }
> 
> +#ifdef CONFIG_ZPOOL
> +/* Moves the zspage to the front of the zspool's LRU */
> +static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
> +{
> +	assert_spin_locked(&pool->lock);
> +
> +	if (!list_empty(&zspage->lru))
> +		list_del(&zspage->lru);
> +	list_add(&zspage->lru, &pool->lru);
> +}
> +#endif
> +
>  /* pool->lock(which owns the handle) synchronizes races */
>  static void record_obj(unsigned long handle, unsigned long obj)
>  {
> @@ -953,6 +976,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
>  	}
> 
>  	remove_zspage(class, zspage, ZS_EMPTY);
> +#ifdef CONFIG_ZPOOL
> +	list_del(&zspage->lru);
> +#endif
>  	__free_zspage(pool, class, zspage);
>  }
> 
> @@ -998,6 +1024,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>  		off %= PAGE_SIZE;
>  	}
> 
> +#ifdef CONFIG_ZPOOL
> +	INIT_LIST_HEAD(&zspage->lru);
> +#endif
> +
>  	set_freeobj(zspage, 0);
>  }
> 
> @@ -1418,9 +1448,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  		fix_fullness_group(class, zspage);
>  		record_obj(handle, obj);
>  		class_stat_inc(class, OBJ_USED, 1);
> -		spin_unlock(&pool->lock);
> 
> -		return handle;
> +		goto out;
>  	}
> 
>  	spin_unlock(&pool->lock);
> @@ -1444,6 +1473,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> 
>  	/* We completely set up zspage so mark them as movable */
>  	SetZsPageMovable(pool, zspage);
> +out:
> +#ifdef CONFIG_ZPOOL
> +	/* Move the zspage to front of pool's LRU */
> +	move_to_front(pool, zspage);
> +#endif
>  	spin_unlock(&pool->lock);

Please move the move_to_front into zs_map_object with ZS_MM_WO with
comment with "why we are doing only for WO case".
