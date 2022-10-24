Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E718460B5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJXSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJXSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:33:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF8479A74
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:15:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g28so9496105pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNF81HjPeg63b6+jdQdpQLgEMtIaJrnM5MbXRIwld1I=;
        b=Apfhrnx6To3CGS8kKLBfUwYL3ebnjQ9TQ89XgQeA7CHQSL0DskUqakuUwzbfqemOJy
         GQnNzmJn3JtE68zDp91LbMIicQFSBMF6FaJ5cdZ9SGgvIMj0ja2AhXJRnN1AzFZZZSOv
         IkWyU3PrT4wKvl2VGzeIvYyj4KOoSyW17+iXffYjd4Zhl9EY0MxOE7EG0ew0gBIYW+wF
         BAwXf6OTT93ATolDyDgerau8YhoDhORRJlT7E/Ogi/NvnQM9h5uiF5YzRrTIwv3wo82t
         h/g6IsIci/MYd6SyFEUfZHb8pbvopB42GogYmAEyMi9QM0OenmAa6ve0uVut7Dl+lecv
         NXLQ==
X-Gm-Message-State: ACrzQf3bKNnBnqlezSbC/xgfVmp91/GmEa+rsFdmEkA7MkHSUvaaXLOT
        yhozIuNh4cJCo4AUx+vIelMGpckqqs46BQ==
X-Google-Smtp-Source: AMsMyM6r3j9X+b9oTmR2djXqM539RQeRKB549uOmcwIHFQn55wsGQIbLUkBRvxstgz1LVTADSPuf6Q==
X-Received: by 2002:a05:6a00:16c8:b0:53b:3b9f:7283 with SMTP id l8-20020a056a0016c800b0053b3b9f7283mr34350371pfc.46.1666631017116;
        Mon, 24 Oct 2022 10:03:37 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b00176b3d7db49sm25884plg.0.2022.10.24.10.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:03:36 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:03:33 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 8/8] mm/slub, percpu: correct the calculation of early
 percpu allocation size
Message-ID: <Y1bFZZNxP5EkEwtX@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-9-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-9-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:35PM +0800, Baoquan He wrote:
> SLUB allocator relies on percpu allocator to initialize its ->cpu_slab
> during early boot. For that, the dynamic chunk of percpu which serves
> the early allocation need be large enough to satisfy the kmalloc
> creation.
> 
> However, the current BUILD_BUG_ON() in alloc_kmem_cache_cpus() doesn't
> consider the kmalloc array with NR_KMALLOC_TYPES length. Fix that
> with correct calculation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..8ac3bb9a122a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4017,7 +4017,8 @@ init_kmem_cache_node(struct kmem_cache_node *n)
>  static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
>  {
>  	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
> -			KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu));
> +			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
> +			sizeof(struct kmem_cache_cpu));
>  
>  	/*
>  	 * Must align to double word boundary for the double cmpxchg
> -- 
> 2.34.1
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
