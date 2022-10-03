Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13205F28F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJCHCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 03:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJCHCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:02:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AD13D56
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:02:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w2so9468077pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xuzIMwp5HI6O+rs54OcfoUBBSXbBPTwhf+nMoMjwGgE=;
        b=MQfF98n60cR3Csy4oSEkat/fUVrP9fWxbnJNOpgYFOiKKszMzTmf/4LwHUGh+PN3ad
         9zmw73CevAQ+J4j0iKgHy+98HF52rk/PvvlOFJMQszMJ4aGyKBdtEkEpFD2u6y21xano
         4CyTJAs3IWVqeYQWsZdZCcmBt7ZmjPRxMtI9jyK6bTjGbEDmcq1/4XdE+K5+rC2+fRrl
         U1DJY7mrr1pTYgTT60np68+f16Uyn1ERF5mQi8ZQ60+2XGVV1PMIC0SK9sRRneE9RhAG
         EQX3GS6eJm7jybN1d6AjbedQ96a4ASwRNxf3mWakcrkO0OjP2FFu1Z4TGw1fkM91r7T/
         MR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xuzIMwp5HI6O+rs54OcfoUBBSXbBPTwhf+nMoMjwGgE=;
        b=ptGxWpSQepKAu3jGNvt75tuN1TP86APpEW6+3qDRl/6vxqSsYC9dqtBaAhafldz8ne
         /BcGM0rVYRrV7yXCE+nPVb0mD1ehWOOF9/LWrWwIcJiwzyoGVhKSQ209ncFvWv39uiwT
         5ZZ0BTB/+Lr+Bb2AWyrp7IhUg4aNbuNVlWftiyA2IcBtiBWmioKHvDsicsMlRuTPanhF
         pD9pVh2YpoRIRS2wPj2Ro8M98gNj8+SL+u3XfZH2/mn2mZRY+ItO2s3YbHNjbY43RRPE
         dMNIkSMVL77MZKQrsnErsu6alZFvJ2l33dS8nIhiLIiZ9EEkcdzX+ErF8LFht7CY++La
         hqyA==
X-Gm-Message-State: ACrzQf21j+BEXXf025qkLrz3n1FAW6pMIMLYecpMcKI3PgYYHhUj0L6p
        JWZB1u9yR2LcfvjiPm3ouDI=
X-Google-Smtp-Source: AMsMyM5gyoXRUAdUGQlSAXkwuUUKwbzpryEuCLNoMDPqSho1rK7hunhlepJbSgQ1ZFsIi3Yj4/GXMg==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr17759214pgw.599.1664780572232;
        Mon, 03 Oct 2022 00:02:52 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b0016d1b70872asm1864440plk.134.2022.10.03.00.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 00:02:51 -0700 (PDT)
Date:   Mon, 3 Oct 2022 16:02:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: slub: remove dead and buggy code from
 sysfs_slab_add()
Message-ID: <YzqJFnCA1bfYqJ5x@hyeyoo>
References: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:47:42AM +0200, Rasmus Villemoes wrote:
> The function sysfs_slab_add() has two callers:
> 
> One is slab_sysfs_init(), which first initializes slab_kset, and only
> when that succeeds sets slab_state to FULL, and then proceeds to call
> sysfs_slab_add() for all previously created slabs.
> 
> The other is __kmem_cache_create(), but only after a
> 
> 	if (slab_state <= UP)
> 		return 0;
> 
> check.
> 
> So in other words, sysfs_slab_add() is never called without
> slab_kset (aka the return value of cache_kset()) being non-NULL.
> 
> And this is just as well, because if we ever did take this path and
> called kobject_init(&s->kobj), and then later when called again from
> slab_sysfs_init() would end up calling kobject_init_and_add(), we
> would hit
> 
> 	if (kobj->state_initialized) {
> 		/* do not error out as sometimes we can recover */
> 		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
> 		dump_stack();
> 	}
> 
> in kobject.c.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  mm/slub.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4b98dff9be8e..04a7f75a7b1f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5937,11 +5937,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  	struct kset *kset = cache_kset(s);
>  	int unmergeable = slab_unmergeable(s);
>  
> -	if (!kset) {
> -		kobject_init(&s->kobj, &slab_ktype);
> -		return 0;
> -	}
> -
>  	if (!unmergeable && disable_higher_order_debug &&
>  			(slub_debug & DEBUG_METADATA_FLAGS))
>  		unmergeable = 1;
> -- 
> 2.37.2

I assumed that it's hit when SLUB failed to initialize slab_kset in
slab_sysfs_init(). (Yeah, it is too unlikely, though....)

And obviously it's a bug if sysfs_slab_add() is called early than
slab_sysfs_init().

-- 
Thanks,
Hyeonggon
