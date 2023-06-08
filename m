Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0872846C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjFHP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjFHP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:58:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466162729
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:58:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9d31203f0so2779571cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686239929; x=1688831929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oE0L6uhiLhYAQ30whkI5Wz9EZKNxwSeFyqmqYPKICPs=;
        b=rFlDtp6CimDUBwq8WNXMrwm+2f1NefnYPrJxslday08prNuXa4pgiuEVkSApNioiDQ
         EleXqAxvRhFc0GBTfFA4nunO8LLFigNx4vyrGrksoKktru3VQATXF3r47kGAArZZf0fC
         UvuZOugrOmBSZMZCV/OkZtoQat/g97LmOl3qh+KhP8oSniL1tSCMIbzISnleZgAQlV3p
         b8Gx4W4h+eW0dX+M0gG9EpnheLely9k2MiYHgVLGGRsoT1uhTtgJRnRGSqjAoRXGG0CA
         vPGOcImBXFlDWxinJ6j0rmX2RFW4zbVnYpTgVZ+I612ZIfBhmwGmjiPkhULqUM0oaClL
         TSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239929; x=1688831929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE0L6uhiLhYAQ30whkI5Wz9EZKNxwSeFyqmqYPKICPs=;
        b=XQBn9p5WXgnjVzhJ5l+kVhJUkSt8aCivjzEX8r7kHQhCsO8cSvlwSuruPuvcL/jWIU
         ExzpCFJ3YRT8h/EY+ePLOd5M3sf8wMU1zBFZHx962G3dLiWmf4bVtE48EPkL6rhsCh+4
         4Wd9VJCgoZQGbhNl6INzGts+LhaBvfYu96holbgkzQAHQDPdtH6BgjzcWf+tHlabHlmm
         0c8TDUqB6dBbvP+V8unxFFxADIOoQKVQY2W3Vsv3vV0suxrCXJQa1ZNOw9ED9Oo3Qjnz
         Skfc2vGbMWN5pHtCP7U2Q+/FE1d0Ad5Pk/SVF4ANomcrgg9EIX5WBUiY+vLoQ37umqaB
         hGDw==
X-Gm-Message-State: AC+VfDwsREgG2aKaLoRJubfp0ExegZJLkCM+Nt6L8JmvA4M0KJG5vhem
        gFGZqwC2nKr9QkTDfIe+zfJzfg==
X-Google-Smtp-Source: ACHHUZ5N6QaV3GnMPx+oJ398Kgsw/r8y4wVZ0ah8baiJMoQer2Hnp70AlbnjsxAw52Ayg3CxBRnd5w==
X-Received: by 2002:a05:622a:178e:b0:3f5:d890:8aa6 with SMTP id s14-20020a05622a178e00b003f5d8908aa6mr7932963qtk.60.1686239929322;
        Thu, 08 Jun 2023 08:58:49 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id h25-20020ac87459000000b003f6a0fa022bsm442216qtr.51.2023.06.08.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:58:48 -0700 (PDT)
Date:   Thu, 8 Jun 2023 11:58:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230608155847.GA352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-2-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

Thanks for incorporating the feedback. Just two more nits:

On Tue, Jun 06, 2023 at 04:56:05PM +0200, Domenico Cerasuolo wrote:
> Each zpool driver (zbud, z3fold and zsmalloc) implements its own shrink
> function, which is called from zpool_shrink. However, with this commit,
> a unified shrink function is added to zswap. The ultimate goal is to
> eliminate the need for zpool_shrink once all zpool implementations have
> dropped their shrink code.
> 
> To ensure the functionality of each commit, this change focuses solely
> on adding the mechanism itself. No modifications are made to
> the backends, meaning that functionally, there are no immediate changes.
> The zswap mechanism will only come into effect once the backends have
> removed their shrink code. The subsequent commits will address the
> modifications needed in the backends.
> 
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> @@ -364,6 +375,12 @@ static void zswap_free_entry(struct zswap_entry *entry)
>  	if (!entry->length)
>  		atomic_dec(&zswap_same_filled_pages);
>  	else {
> +	/* zpool_evictable will be removed once all 3 backends have migrated */
> +		if (!zpool_evictable(entry->pool->zpool)) {

Comment indentation is off.

> +			spin_lock(&entry->pool->lru_lock);
> +			list_del(&entry->lru);
> +			spin_unlock(&entry->pool->lru_lock);
> +		}
>  		zpool_free(entry->pool->zpool, entry->handle);
>  		zswap_pool_put(entry->pool);
>  	}
> @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
>  	return NULL;
>  }
>  
> +static int zswap_shrink(struct zswap_pool *pool)
> +{
> +	struct zswap_entry *lru_entry, *tree_entry = NULL;
> +	struct zswap_header *zhdr;
> +	struct zswap_tree *tree;
> +	int swpoffset;

pgoff_t

With that and what Yosry pointed out fixed, please feel free to add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

to the next version.
