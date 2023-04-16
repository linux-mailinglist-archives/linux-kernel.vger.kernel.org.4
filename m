Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6A6E37D5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjDPLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDPLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:55:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330F3A99
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:55:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so927362b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681646150; x=1684238150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8KZ3r9X7m+frzkUk71abgu3pE7RU14Dc/ipsaHwcko=;
        b=XoMq0EVWI3nRgXwtqQFUyUpQLhUcLHer4Yo9nSw6D+lKunzd9B3jNIK72QJ5//v3MC
         AHLPlQr7B2ZErB4zHnCN8YstKDjk17SWcGzlw85VLT2hzPKugGKLPvwcZDj/4zN2lKdx
         RVIj5GTGwR1YeLaXGSi++0qJEwa0FGPg3JqdT7SXfnKqe6b6/iYHz549hUmsB6NGpGA7
         K+0l2TtsYgNhBIuloGc5UyXr6vhrBSw/fpsF5BHjsK0CnpnAP5++BYMfp9SW+B3HcVTz
         X3N46a5zN4P1zIHLZfD6W13NuoCSAS6kC26fi0/KwwAKMMF3srCAr8Ld3MEv2h0XgJzT
         HRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681646150; x=1684238150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8KZ3r9X7m+frzkUk71abgu3pE7RU14Dc/ipsaHwcko=;
        b=Zn7GnEUrxEZGEGpGtrgPI5mI/xWeVMsLikxKW1JANaC+drrhWigMpeM6ISarCIJ1m2
         W4t+lBVL7pwHPGtM2om5wt4rYFbLRxdB2SblUaX8SBJK4+R1qGsGga3AyYvr3RsP/oVy
         F9DsObxvxWuyG+MJR1zuL6WAaTC2/urxBep3MCS4B8YYQtSF6ZVJBEgmgK135mizIgWw
         zyX/u80q/cdraR2YIsLbi3JFnGTgNNjUHdSdUZdD6ASAhDrilyz1SGrmboNEX4xVXxoL
         faC48XbQEkpX+FiBN9BgyfGJpWcI1GnEvr5GM8ha1x15qarLBu70fxFRLSt4PyGOktoT
         WDCA==
X-Gm-Message-State: AAQBX9fxHzaLotiH9vnTIp7gPjNrmV7OtHFqvQt7470w4dAGrzZL0aXP
        bTsCN/MwQ6sYBItmpQqJ5D00+QYIfct2mYr4
X-Google-Smtp-Source: AKy350ZwTAHDISNb23JdS5FOQLwjDaG3jTcMflOFrRkYG0ua5qimsZYO+gjQ3z/Y30C7TbgNhsjLcw==
X-Received: by 2002:a05:6a00:1ac7:b0:63b:5f78:d6e1 with SMTP id f7-20020a056a001ac700b0063b5f78d6e1mr13277000pfv.16.1681646150178;
        Sun, 16 Apr 2023 04:55:50 -0700 (PDT)
Received: from hyeyoo ([211.108.101.96])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b0063b7a0b9cc5sm2555924pfo.186.2023.04.16.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 04:55:49 -0700 (PDT)
Date:   Sun, 16 Apr 2023 20:55:39 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, Jason@zx2c4.com,
        linux-mm@kvack.org, ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: Re: [PATCH v5 2/3]  Replace invocation of weak PRNG
Message-ID: <ZDviOwOyYJ9Ese87@hyeyoo>
References: <20230415173650.5458-1-david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415173650.5458-1-david.keisarschm@mail.huji.ac.il>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 08:36:49PM +0300, david.keisarschm@mail.huji.ac.il wrote:
> From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
> 
> The Slab allocator randomization inside slab_common.c
> uses the prandom_u32 PRNG. That was added to prevent attackers to obtain
> information on the heap state.
> 
> However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
> To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
> to ensure the PRNG is strong.
> 
> Since a modulo operation is applied right after that,
> in the Fisher-Yates shuffle, we used get_random_u32_below, to achieve uniformity.
> 
> Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
> ---

same comment for the subject line.

> 
> This fifth series changes only the arch/x86/mm/kaslr patch.
> 
> Changes since v3:
> * edited commit message.
> 
> Changes since v2:
> 
> * replaced instances of get_random_u32 with get_random_u32_below
>     in mm/slab_common.c.
> 
>  mm/slab_common.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bf4e777cf..361da2191 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmalloc_large_node);
>  
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  /* Randomize a generic freelist */
> -static void freelist_randomize(struct rnd_state *state, unsigned int *list,
> +static void freelist_randomize(unsigned int *list,
>  			       unsigned int count)
>  {
>  	unsigned int rand;
> @@ -1157,8 +1157,7 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
>  
>  	/* Fisher-Yates shuffle */
>  	for (i = count - 1; i > 0; i--) {
> -		rand = prandom_u32_state(state);
> -		rand %= (i + 1);
> +		rand = get_random_u32_below(i+1);

same here.

otherwise looks good to me.


>  		swap(list[i], list[rand]);
>  	}
>  }
> @@ -1167,7 +1166,6 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
>  int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
>  				    gfp_t gfp)
>  {
> -	struct rnd_state state;
>  
>  	if (count < 2 || cachep->random_seq)
>  		return 0;
> @@ -1176,10 +1174,7 @@ int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
>  	if (!cachep->random_seq)
>  		return -ENOMEM;
>  
> -	/* Get best entropy at this stage of boot */
> -	prandom_seed_state(&state, get_random_long());
> -
> -	freelist_randomize(&state, cachep->random_seq, count);
> +	freelist_randomize(cachep->random_seq, count);
>  	return 0;
>  }
>  
> -- 
> 2.37.3
> 
