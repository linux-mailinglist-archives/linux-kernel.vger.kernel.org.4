Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C016377CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKXLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKXLlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:41:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF96B9F0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:41:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g62so1414079pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCd6zgZ9Hqz9sR1Spt/uKXD2LWWaO3T2x6GLxEqyUkg=;
        b=aVtcbxcWGK5RCiec4i5uxxwG6QRkwATKRsEZtp+hNgtD6GKJBJMHXAXgiA4M9kOETk
         PZSbcC1I+uFxZI7U6tYmA+Ujthmm18YFZlhRFH7Vp77+Ipyuhbv2F/CDofWiu9yeZvdg
         usz4tJtMQNNpo4yyRcEC8rXBel62a2MIH86Wu5qqFgTa/B+ppw1RmC1wdQwvJWsSim2O
         RoeLGpgzmFM22+MJ1kj/D24r765zNqlZWuT08zaPCv/lLKAKipm+3OBCQiX3IRN3hqUu
         loOBXEMKQZWXo/N0E/TuxPcsgUDg/uhhA1jCEdcM3j3w3JQ3NgoSrjAKtpNwV5oy+7L2
         p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCd6zgZ9Hqz9sR1Spt/uKXD2LWWaO3T2x6GLxEqyUkg=;
        b=liBEf6wZEbzZyPiaRddm5cCPw0h6nkajRGwRM3DS0xn9NLslnSODXMnQhARUxdedey
         L7OoHxM28vaMSCEdstEjkhOgd2KCCPeibbmBOnXnIPrLzYiue65HNsViMLF4kdiLzpUF
         1KPKRZnGIHmeN2QlCQdE02UqOg7jI+fhKh+BAuJiU6MwPKchT9HbeyLRAyctExg/0BlK
         DE005zraT7wfbcpz7pcG2HkofJcCAcAS8IYyydH0ycqFABbm8j4k9c/G1rWtkU9BYyj2
         8xvzOD1Yv8p/g25ZaFwPvgvOzjZAVgYeWrDHGjyx7/BKuwY1KBTRGwxt8nrnWWaDqEG6
         R5dA==
X-Gm-Message-State: ANoB5pnlvvr2EVvuY+2ZydxoCrZZ7ab4XqUMCZ2gEYL2ocgxcmpa5mek
        HYCUUY21xH0XItuY/QhmxN4=
X-Google-Smtp-Source: AA0mqf5wa9KogvZ0ibs8xKawXeQ7pWMiPHK8R57Xr6/6pRLZQZVtwvu7Pwy75DKI3kFZofZ+tgzfTA==
X-Received: by 2002:a63:fc49:0:b0:476:941a:8582 with SMTP id r9-20020a63fc49000000b00476941a8582mr11276389pgk.321.1669290062175;
        Thu, 24 Nov 2022 03:41:02 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b00186b55e3cd6sm1098576ple.133.2022.11.24.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:41:01 -0800 (PST)
Date:   Thu, 24 Nov 2022 20:40:55 +0900
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
Subject: Re: [PATCH 05/12] mm, slub: lower the default slub_max_order with
 CONFIG_SLUB_TINY
Message-ID: <Y39YR5nn6aUs2KRW@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-6-vbabka@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:55PM +0100, Vlastimil Babka wrote:
> With CONFIG_SLUB_TINY we want to minimize memory overhead. By lowering
> the default slub_max_order we can make slab allocations use smaller
> pages. However depending on object sizes, order-0 might not be the best
> due to increased fragmentation. When testing on a 8MB RAM k210 system by
> Damien Le Moal [1], slub_max_order=1 had the best results, so use that
> as the default for CONFIG_SLUB_TINY.
> 
> [1] https://lore.kernel.org/all/6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 917b79278bad..bf726dd00f7d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3888,7 +3888,8 @@ EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>   * take the list_lock.
>   */
>  static unsigned int slub_min_order;
> -static unsigned int slub_max_order = PAGE_ALLOC_COSTLY_ORDER;
> +static unsigned int slub_max_order =
> +	IS_ENABLED(CONFIG_SLUB_TINY) ? 1 : PAGE_ALLOC_COSTLY_ORDER;
>  static unsigned int slub_min_objects;
>  
>  /*
> -- 
> 2.38.1
>

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
