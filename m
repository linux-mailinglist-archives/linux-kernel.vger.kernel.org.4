Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068F6377B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKXLdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKXLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:33:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE697352
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:33:19 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 130so1401987pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YMTx0dYsCXcdicmdhniq9bvZBuxl4kai8z8N0OctaU=;
        b=FL9D8iGgmgmofA5VoLVagb3Z/kMvnn1F9H88SIPRFUTcPk6RrqxMqEYrQKpo7zMF+H
         CBX887MkKNednTWCyU6O+ZKdoK5jgvF9Pmg5Qp2U4OdK9TGmd5s8opFFIw4tGNjnqaY0
         EU2j9GKQKe2WzveuiSd5XvPv2O7qrTGsKjJdEYX6pUUP3HCfzHXPAfUiD1VWafcuEPaW
         qYWKk+ol1OhOfWIxXSSXqW8W/QQF/7Ke+8DmUvy73ww5Yim97xi3GOUT2k4xJ42buJLu
         iuEpUDtWQpt7USLqKmZJ0W6YeZFgY2KClw9nKVfhuJ2mqBafYYvuIOlqro/vmE0jLNfj
         Oq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YMTx0dYsCXcdicmdhniq9bvZBuxl4kai8z8N0OctaU=;
        b=IEr6s6SmaZ+xPKwqJUv1LUbhhMcUsOgA2oRJe5XitoB3pYOgtYKL48gEe0KpSoHMFZ
         Y76UNdniOQa+JNa7qosyE/vXwdzazMv+X24OJzcbl23bE7QNBTwUYHg8beiglJVSNate
         S0kVlbQWuCKNKTbnsa5zG1djbdfYbS1LSbdkr1qz6yVUMc7moR7tKJXnyjGM+CxAh5tu
         AqGHszthKwxTe/Jubd8pFQB/KJMf0uB9ViFbsdcuoDMRz4ZYcdGtXhyQQk6DOO2M+lUN
         iA/vrFRv38Qq5/lAlR/6FxaPOA0UT3kBJ+NR4skI255AFKAvXsbq13cAUIGdkLSxfZ1u
         aNUA==
X-Gm-Message-State: ANoB5pkLjC5Rd86adQD1jmrdv1lV049wuK9ObheymuZM5iQaCG3zglHl
        Q3H9DkX4h0UXd6noObkiO9A=
X-Google-Smtp-Source: AA0mqf4XlADXE9OvMpXzVxVnILOKztzIa1G613NCrC4ef+qIggfZ8kQ5+6tkPgi9VcJqts5f8LMmQA==
X-Received: by 2002:a63:5007:0:b0:45f:beda:4116 with SMTP id e7-20020a635007000000b0045fbeda4116mr12995905pgb.618.1669289599361;
        Thu, 24 Nov 2022 03:33:19 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902a41400b0018693643504sm1100620plq.40.2022.11.24.03.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:33:18 -0800 (PST)
Date:   Thu, 24 Nov 2022 20:33:12 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] mm, slub: add CONFIG_SLUB_TINY
Message-ID: <Y39WeEpboF4u7pP6@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-3-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:52PM +0100, Vlastimil Babka wrote:
> For tiny systems that have used SLOB until now, SLUB might be
> impractical due to its higher memory usage. To help with that, introduce
> an option CONFIG_SLUB_TINY that modifies SLUB to use less memory.
> This is done by sacrificing scalability, security and debugging
> features, therefore not recommended for any system with more than 16MB
> RAM.
> 
> This commit introduces the option and uses it to set other related
> options in a way that reduces memory usage.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/Kconfig       | 21 +++++++++++++++++----
>  mm/Kconfig.debug |  2 +-
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 57e1d8c5b505..5941cb34e30d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -230,6 +230,19 @@ config SLOB
>  
>  endchoice
>  
> +config SLUB_TINY
> +	bool "Configure SLUB for minimal memory footprint"
> +	depends on SLUB && EXPERT
> +	select SLAB_MERGE_DEFAULT
> +	help
> +	   Configures the SLUB allocator in a way to achieve minimal memory
> +	   footprint, sacrificing scalability, debugging and other features.
> +	   This is intended only for the smallest system that had used the
> +	   SLOB allocator and is not recommended for systems with more than
> +	   16MB RAM.
> +
> +	   If unsure, say N.
> +
>  config SLAB_MERGE_DEFAULT
>  	bool "Allow slab caches to be merged"
>  	default y
> @@ -247,7 +260,7 @@ config SLAB_MERGE_DEFAULT
>  
>  config SLAB_FREELIST_RANDOM
>  	bool "Randomize slab freelist"
> -	depends on SLAB || SLUB
> +	depends on SLAB || SLUB && !SLUB_TINY
>  	help
>  	  Randomizes the freelist order used on creating new pages. This
>  	  security feature reduces the predictability of the kernel slab
> @@ -255,7 +268,7 @@ config SLAB_FREELIST_RANDOM
>  
>  config SLAB_FREELIST_HARDENED
>  	bool "Harden slab freelist metadata"
> -	depends on SLAB || SLUB
> +	depends on SLAB || SLUB && !SLUB_TINY
>  	help
>  	  Many kernel heap attacks try to target slab cache metadata and
>  	  other infrastructure. This options makes minor performance
> @@ -267,7 +280,7 @@ config SLAB_FREELIST_HARDENED
>  config SLUB_STATS
>  	default n
>  	bool "Enable SLUB performance statistics"
> -	depends on SLUB && SYSFS
> +	depends on SLUB && SYSFS && !SLUB_TINY
>  	help
>  	  SLUB statistics are useful to debug SLUBs allocation behavior in
>  	  order find ways to optimize the allocator. This should never be
> @@ -279,7 +292,7 @@ config SLUB_STATS
>  
>  config SLUB_CPU_PARTIAL
>  	default y
> -	depends on SLUB && SMP
> +	depends on SLUB && SMP && !SLUB_TINY
>  	bool "SLUB per cpu partial cache"
>  	help
>  	  Per cpu partial caches accelerate objects allocation and freeing
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index ce8dded36de9..fca699ad1fb0 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -56,7 +56,7 @@ config DEBUG_SLAB
>  config SLUB_DEBUG
>  	default y
>  	bool "Enable SLUB debugging support" if EXPERT
> -	depends on SLUB && SYSFS
> +	depends on SLUB && SYSFS && !SLUB_TINY
>  	select STACKDEPOT if STACKTRACE_SUPPORT
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
> -- 
> 2.38.1

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

small comment:
SLAB || (SLUB && !SLUB_TINY) would be easier to interpret than
SLAB || SLUB && !SLUB_TINY

-- 
Thanks,
Hyeonggon
