Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927864FD69
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 03:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLRCGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 21:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLRCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 21:06:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B3F101D0;
        Sat, 17 Dec 2022 18:06:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9742096pjs.4;
        Sat, 17 Dec 2022 18:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQlL5ghD7N0N01DujD2JXmYgCfDGcy7QogVwZx4Fjmk=;
        b=J1gBib2Q784kiXcU/vut8sUBNvdQgVqgCdUXusll8rXTeI5hQxVytK/hJ+aQpiYDHO
         FE3bRIHokQ6x1YStbDNVSg+7w/rohIeQh6Ckjceu/LaK5nx1JztXpSSIOhFzBEZZZipG
         xa6hyjye7AwuwphAdNvvH1fTt0oY3in6il9nVaLkFBnUebbbk7Sg5+HF8XAMwogFMkZg
         +W1nhiVHBxzBstAn8R28tc1LPStKKumCNgnwKF+LmGrKpPTnhFB7SIhGIpI/sj50jK09
         2/WSuQDUjGulUbRvKlf8t95BaZ3MVDF2fVZfMhUa/QVk2FiNRjlswKWiRf311v2hNqip
         Nkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQlL5ghD7N0N01DujD2JXmYgCfDGcy7QogVwZx4Fjmk=;
        b=eOTFkOiuCHuLT2yOhEHFxHaEpgey1za49cASlzEFrmQqkSnYfu/sm041XNMESBHd+5
         kejXlXxYdQESWfawckUcDIsnQeIsl2GZNFDTkh31i95cnzTuzRJJX185EbM0ITTn2Gvz
         ziEkpR5WviOMaqNwy9a+bNpO6u0VaoJecnPkshzzRt45QIvAPvYoaGuBHXub0YcLSdTE
         XN/g59IOVWfD7m3ODEKbRmKqYtoNCtJgJcHdl51rUWpcqCoRnTErPOHzSqyuVdTcF3z9
         y5Gpc7YgaE33wDqSduZZ+wGeOM/XyD2p+Fiw2fTMntMmK9Fz6Uiloe9waSwBqphaguVK
         Wg1Q==
X-Gm-Message-State: ANoB5pkQVsInuOksyCsPQ0WZdxP/ypLagqBLA6kR9+eN3AgEoiqxtGc3
        JeJmbOSRTJ3h53AnXcb1K0U=
X-Google-Smtp-Source: AA0mqf7Qiqj4Lf1RGe8dDZvnYHrIQLS5TCLeM0jd61cz/BJ5Z6igzixS54FlFJ4hkoVFNjhr/lH58w==
X-Received: by 2002:a17:90a:dc14:b0:219:20b6:55e5 with SMTP id i20-20020a17090adc1400b0021920b655e5mr39424070pjv.5.1671329211448;
        Sat, 17 Dec 2022 18:06:51 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id mi14-20020a17090b4b4e00b0020d67a726easm6895842pjb.10.2022.12.17.18.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 18:06:50 -0800 (PST)
Date:   Sun, 18 Dec 2022 11:06:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     gouhao@uniontech.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, keescook@chromium.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, mingo@elte.hu, gouhaojake@163.com
Subject: Re: [PATCH] mm/slab: remove unused slab_early_init
Message-ID: <Y551tFBVcYxPlFlH@hyeyoo>
References: <20221217113045.15997-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217113045.15997-1-gouhao@uniontech.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 07:30:45PM +0800, gouhao@uniontech.com wrote:
> From: Gou Hao <gouhao@uniontech.com>
> 
> 'slab_early_init' was introduced by 'commit e0a42726794f
> ("[PATCH] mm/slab.c: fix early init assumption")', this
> flag was used to prevented off-slab caches being created

s/prevented/prevent

> so early during bootup.
> 
> The only user of 'slab_early_init' was removed in commit
> '3217fd9bdf00 ("mm/slab: make criteria for off slab
> determination robust and simple")'.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  mm/slab.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 7a269db050ee..ede1f29fd81c 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -220,7 +220,6 @@ static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
>  static inline void fixup_slab_list(struct kmem_cache *cachep,
>  				struct kmem_cache_node *n, struct slab *slab,
>  				void **list);
> -static int slab_early_init = 1;
>  
>  #define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
>  
> @@ -1249,8 +1248,6 @@ void __init kmem_cache_init(void)
>  	slab_state = PARTIAL_NODE;
>  	setup_kmalloc_cache_index_table();
>  
> -	slab_early_init = 0;
> -
>  	/* 5) Replace the bootstrap kmem_cache_node */
>  	{
>  		int nid;
> -- 
> 2.20.1

Nice cleanup, thanks!

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
