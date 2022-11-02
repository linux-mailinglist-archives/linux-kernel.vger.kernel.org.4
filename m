Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771FD615B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKBEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBEOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:14:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0223146
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:14:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h193so6504214pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c30GhC3CoSosVopfRUjx7dVhkmM5E32hTKQ81gMJsz8=;
        b=CMdN+AncmaG8HzjUzD9ywczQaU/TKgxywNgXU/V1Ac3MzLcrIYrGtAEky0EN0t9Z+R
         kziHTMp/GxnodGxxW8GiqtstZ2gv4PQpowivv1e7YIieaYETHVrvPK18tNiO122bulaI
         EXqiS6Flg0fa12XxofyPl6OT+HjtsLwAn0iLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c30GhC3CoSosVopfRUjx7dVhkmM5E32hTKQ81gMJsz8=;
        b=NNsMZ8Y4y4n8rFKBlcaLE4NnG2DeBbrEzihO5qSwGfR4+ABDb62DozYl+AHlFx1l77
         6vKuhxI9ziTMdiSPHaC0IE24+FtLff3fjxXpwRHKHap/4dwJjOq338VWwUDu6tNpGOsP
         bKnf9V0vk24f4UlMBwWkEVptA/BTd3A2NOw2S0E+NNVrO36TcCVu9DVa4d2soa8pzcWN
         f29+hHLA3LZK7MoVU6XmE3MyC8sx0+M/bxj5gagzsqvtmMzeklCs0PTlUca4zlw7QG8Q
         ZuWyMCcEnfGNFwBZUeNlegc5ne/Xx8rZ2PHXwbkcSRh5pYBy+092sKsHCQiOQAODVY26
         EC+Q==
X-Gm-Message-State: ACrzQf3vyHmTJW0k3d3oDKoa1kTh8sry9DOIm4voeEBomHYkH/2WxerZ
        z9G725F9/hnHQHKUP+E7tc0dmg==
X-Google-Smtp-Source: AMsMyM6oSQXsw+x4LT1N+XG0H91Ng+MhsL+HQJ99odIHJfJ9qXaMBWV8NxtN5U8+WL9yAk+X7o0AMQ==
X-Received: by 2002:a63:d211:0:b0:46f:6229:c380 with SMTP id a17-20020a63d211000000b0046f6229c380mr19785356pgg.621.1667362443346;
        Tue, 01 Nov 2022 21:14:03 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f558:dfb0:7cb7:44d9])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b00187197c499asm5386872pls.164.2022.11.01.21.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 21:14:02 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:13:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y2HuhiyorAHFO+Ss@google.com>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027182736.513530-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/27 11:27), Nhat Pham wrote:
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

The name collides with shrinker callbacks (compaction). That's a bit
confusing, took me some time.

> @@ -482,6 +504,7 @@ static struct zpool_driver zs_zpool_driver = {
>  	.malloc_support_movable = true,
>  	.malloc =		  zs_zpool_malloc,
>  	.free =			  zs_zpool_free,
> +	.shrink =     zs_zpool_shrink,
>  	.map =			  zs_zpool_map,
>  	.unmap =		  zs_zpool_unmap,
>  	.total_size =		  zs_zpool_total_size,
> @@ -955,6 +978,21 @@ static int trylock_zspage(struct zspage *zspage)
>  	return 0;
>  }

[..]

> +#ifdef CONFIG_ZPOOL
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> +{
> +	int i, obj_idx, ret = 0;
> +	unsigned long handle;
> +	struct zspage *zspage;
> +	struct page *page;
> +	enum fullness_group fullness;
> +
> +	/* Lock LRU and fullness list */
> +	spin_lock(&pool->lock);
> +	if (!pool->ops || !pool->ops->evict || list_empty(&pool->lru) ||

You don't need pool->lock for pool->ops/pool->ops->evict checks.

But, more importantly, I don't understand why is it even checked here?
Why do we use ops->evict? Why cannot we call into zsmalloc evict
directly? All of these are statically defined in zsmalloc, just don't
provide .shrink if !define CONFIG_ZPOOL? Under what circumstances
zsmalloc can provide .shrink but no ->evict?
