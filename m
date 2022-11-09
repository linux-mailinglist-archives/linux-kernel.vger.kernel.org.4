Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B50C623634
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKIVzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKIVzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:55:49 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1F2E1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:55:48 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q71so17344308pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYg5m0atdOw1dxzpeo8zRV+fGD2ca4bGE4Ou9GGosT8=;
        b=JZ1aEngmeUjTyS0jGftdK9sfnEOYpywxOW8vTmF8M0XKg9fIbQuh88iEUN4HWiDTpf
         A0/olhVTqMj7brak4I2mXLsGDwPy6JAx5FLbQBPvQEdUeyQ7xBrtLcRDZeW/+Lusmxyq
         aBZ1phYnJM92P5aZydE4CN8ZeEweeBV1NhHomh4QmorYskOPi/biYyznZ4JOe6jL6DYM
         LZkjuA58DlrdPniBGroEmCvgVhV471Xfyh/vKM+YMQ1RDY9MaYEiDKDcyPsw3XHDjb0k
         L0eMUyDs8Fk6lojVIlwefH6yUd1QHdATMh1Vmj3iNbefWC1MhR5MMUNE25A9TWkNAiac
         3Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYg5m0atdOw1dxzpeo8zRV+fGD2ca4bGE4Ou9GGosT8=;
        b=tBwi+GeF6HKBqkY0MF6uQhKijrsPnGiBIABx22I14DfrvTPTX1/vHPOiWlpAc1HZ7P
         GebQYX5lGIVYQYXsrRLSgQs3XtfZP3SYVHXDkEJd65lgXI+vDb/1RuGSvJQ0+rFDapjw
         wHvPTJVkop8XOmiOGptXD+p47Au2M6jinv5tJwCj29ZTgE1UUFjH9ZU6f450LkHLbwkR
         bsViqO7OcngMlyb53XLlznTIa0JeKpxc4GbKqDQCv9OTY7TRzUcjriREKCUlMU9nxzd1
         c+H+AcqzL1evTXW6EcKbGlE6c/w29MvePizjXP9KFlFIYAB4bWrl/bgEHJiddwUyur7/
         Ik5g==
X-Gm-Message-State: ACrzQf1nttD/3tFdP5R+cVIj4lArpazKA83ifXR8s+jpGr/OgkCk/VmV
        W3SGg4mZpmwnhyJFOPegxE0=
X-Google-Smtp-Source: AMsMyM5hw6qls3PUCHGF6uCN29DcI1jmEzoJ4z1WkLKabSqkaQDHErMVb3uAq5TMH+SGFZF7o2YneA==
X-Received: by 2002:a63:8741:0:b0:470:ef2:6f11 with SMTP id i62-20020a638741000000b004700ef26f11mr34654684pge.455.1668030947625;
        Wed, 09 Nov 2022 13:55:47 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8514:5da3:d38f:7bd])
        by smtp.gmail.com with ESMTPSA id om8-20020a17090b3a8800b00216df8f03fdsm1682431pjb.50.2022.11.09.13.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:55:47 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 9 Nov 2022 13:55:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y2wh4b3oMaknNqGP@google.com>
References: <20221108193207.3297327-1-nphamcs@gmail.com>
 <20221108193207.3297327-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108193207.3297327-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:32:05AM -0800, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 326faa751f0a..600c40121544 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -239,6 +239,9 @@ struct zs_pool {
>  	/* Compact classes */
>  	struct shrinker shrinker;
> 
> +	/* List tracking the zspages in LRU order by most recently added object */
> +	struct list_head lru;
> +
>  #ifdef CONFIG_ZSMALLOC_STAT
>  	struct dentry *stat_dentry;
>  #endif
> @@ -260,6 +263,10 @@ struct zspage {
>  	unsigned int freeobj;
>  	struct page *first_page;
>  	struct list_head list; /* fullness list */
> +
> +	/* links the zspage to the lru list in the pool */
> +	struct list_head lru;

Please put the LRU logic under config ZSMALLOC_LRU since we don't need
the additional logic to others.
