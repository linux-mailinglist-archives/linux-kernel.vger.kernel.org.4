Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF478712DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjEZTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjEZTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950BC10CA
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685129786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZn7U3ROVV8UqPfz/FOkmUDhsVUZCtzUhADb0fjn+KQ=;
        b=QyxvLmPsLz1GZ3TVXzgdS1KlKkW+DrJvzbNYxO41QeNTIQpC7kDIaj2sKnrzLBkbDcpVtH
        UhZweJVkKpTswLWlgogZP1hICFGLKK55wgVdLCnJFwCam1Mk1GXWd7x1E/rwMQK1sZLGE8
        roAkrz/Qc4GsD0io38h3CDIwjy5Xp5s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-1gjhdOGFNlqJKKuCBNk_lw-1; Fri, 26 May 2023 15:36:24 -0400
X-MC-Unique: 1gjhdOGFNlqJKKuCBNk_lw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so4570915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129783; x=1687721783;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZn7U3ROVV8UqPfz/FOkmUDhsVUZCtzUhADb0fjn+KQ=;
        b=Pkgtcyf+3FIYJ0KTYP7FcP7JFTL3PEwJH4a4r8CIxxqJzWEoleT2IeWhMSL+4e4RJS
         VPCdYLrHtI3h7WZ1G7PW4cw2/Qep2AN+p9p9MIulRz3apfsJ1ZfxTwwzON6LB3v6QjBz
         DErADVIn84r5JFJP04sWDjOdGdLoppBI1ycA0S/arCSE8uivX506v3/9Ma7+FX0K+Tic
         UP9GUYl+vrv/YgBacNUIgbc59WpZBLncRhAVx+yICpIb0Gdj12tPthM/ehG2ItSmWN4x
         wRMQqJSr9nqYJwXPRyCJR1ReD2c9zMj7VI3YUJdyR7hlEYk81JYKGDY36gI8Khp27pDw
         FFqg==
X-Gm-Message-State: AC+VfDx2mUlVZUzMo1E0Zx1rW2/PjbWiUioN4ywfsh+JGNyheqF9++AS
        uU1nG3F6y+ei6nHPDl68uGsjGThI+ix+36ujrAoUM75EXRREM+DpDVzLkeUVWDV2ySoCWxjzyLU
        LvkXt/9IVGogchDucyFGoHaXW
X-Received: by 2002:a05:600c:2258:b0:3f6:d23a:fefb with SMTP id a24-20020a05600c225800b003f6d23afefbmr2592169wmm.12.1685129783557;
        Fri, 26 May 2023 12:36:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KFPA6k9sE7WjwusxP6R8sKO1bJOpthRYdhRP4/KcKv6+GKDcc/rlA3+DX0c+XfKuf9uTefw==
X-Received: by 2002:a05:600c:2258:b0:3f6:d23a:fefb with SMTP id a24-20020a05600c225800b003f6d23afefbmr2592150wmm.12.1685129783217;
        Fri, 26 May 2023 12:36:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003f17848673fsm6041572wmc.27.2023.05.26.12.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 12:36:22 -0700 (PDT)
Message-ID: <c1bd0983-219d-e279-2630-c38329e59140@redhat.com>
Date:   Fri, 26 May 2023 21:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv4] mm: skip CMA pages when they are not available
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
References: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 08:36, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> This patch fixes unproductive reclaiming of CMA pages by skipping them when they
> are not available for current context. It is arise from bellowing OOM issue, which
> caused by large proportion of MIGRATE_CMA pages among free pages.
> 
> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
> ...
> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: update commit message and fix build error when CONFIG_CMA is not set
> v3,v4: update code and comments
> ---
> ---
>   mm/vmscan.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd6637f..20facec 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2193,6 +2193,26 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
>   
>   }
>   
> +#ifdef CONFIG_CMA
> +/*
> + * It is waste of effort to scan and reclaim CMA pages if it is not available
> + * for current allocation context
> + */

/*
  * Only movable allocations may end up on MIGRATE_CMA pageblocks. If
  * we're not dealing with a movable allocation, it doesn't make sense to
  * reclaim from these pageblocks: the reclaimed memory is unusable for
  * this allocation.
  */

Did I get it right?

> +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> +{
> +	if (!current_is_kswapd() &&
> +			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
> +			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA)
> +		return true;
> +	return false;

	return !current_is_kswapd() &&
	       gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
	       get_pageblock_migratetype(&folio->page) == MIGRATE_CMA;


-- 
Thanks,

David / dhildenb

