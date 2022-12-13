Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563E964B6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiLMODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLMOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:02:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315063FD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:02:57 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso3653981pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YiSjWHoQWvxaPnMWkhQIQOkA+9eRIuJnwPdOS374zI=;
        b=i191arESYf3ytwMfFMtgeaKAS9H5vjtkaPCums6F5nmiiiXLgP6n3izOpIxcPDHuMa
         tGJT27K3n4zgHFtYDXQ/uuQ0wOOJJ8qYhZBSs2mJzJnZjInobNMYKb1uDZve++kIoQdO
         lrn3gZIlO83al62AO3fAseNoqtZc5KiGkccvYuPzzKc3Do0EUC0I/Yn/cB4q+xHGkiKF
         vYH/g7vgwp75Nw4Oi2NrBk/EDD4MKcjWRqiQbP0qGt+3Rlm5vOOWcYW3a5DrfIOlS/fT
         SlsuX6f+4sIX3TyQ6AS/tL6BrA0Wh8C4PE0exCBY4cX0amezW2ahyc/0eRcs7bfoOd6H
         8L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YiSjWHoQWvxaPnMWkhQIQOkA+9eRIuJnwPdOS374zI=;
        b=UTqPebSgKz5+1GWwH2qwb8sZ1NOZJKPF0nXZUWBpTqtWGokHeWN3AmjzNbX7y+PeUP
         LI8WqQbmD3pfqbepeolkDQ32axNVkXpUBvZ/Xr7HylkeUbi6WYJ8nQJ0n3O83x40k9Mt
         F5USzqgYnNj9ZFvz9I67eXLp24QWfy09jcKVfMcL6tuociWgHb7sAN7bX9c+mNltzvfi
         KO7FPJBPXm9IJheoaJU4xFnA3nAO1puRpzK7CSrS258YFSTGStFo6gNAEXCXApmSvJ4r
         BW57qmQgB5Gb6IUZ6JUa1yVQEOM83FlGJ4rp30UhcGwpSm34s42tmXp3P324Jne88Kqn
         SkZg==
X-Gm-Message-State: ANoB5pniiDL74fk7tS5mkJSecg8NmyuyDfFzUIhFmSCL5BLlrRwLbYMd
        9XY3C2UPvvhE4ptrF4QpXHA=
X-Google-Smtp-Source: AA0mqf4ZPrtW54ww6Zvl6Ql4G2TELTlzGR4srjVLOEtRgpEOsxTRyyMe9EvHYVftTjcf85a6AR9rNw==
X-Received: by 2002:a17:902:a588:b0:185:441e:90b5 with SMTP id az8-20020a170902a58800b00185441e90b5mr20420811plb.27.1670940176560;
        Tue, 13 Dec 2022 06:02:56 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001811a197797sm8462259plb.194.2022.12.13.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:02:55 -0800 (PST)
Date:   Tue, 13 Dec 2022 23:02:49 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
Message-ID: <Y5iGCY7LfQ1SKylO@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-11-vbabka@suse.cz>
 <Y4NEkF8DI1uXFRv4@hyeyoo>
 <f318ccc3-eb03-e359-cb6f-157d0b4aed31@suse.cz>
 <Y5cob2jicdNoviU3@fedora>
 <Y5frwZNPN++sqHLY@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5frwZNPN++sqHLY@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:04:33AM +0800, Baoquan He wrote:
> On 12/12/22 at 05:11am, Dennis Zhou wrote:
> > Hello,
> > 
> > On Mon, Dec 12, 2022 at 11:54:28AM +0100, Vlastimil Babka wrote:
> > > On 11/27/22 12:05, Hyeonggon Yoo wrote:
> > > > On Mon, Nov 21, 2022 at 06:12:00PM +0100, Vlastimil Babka wrote:
> > > >> SLUB gets most of its scalability by percpu slabs. However for
> > > >> CONFIG_SLUB_TINY the goal is minimal memory overhead, not scalability.
> > > >> Thus, #ifdef out the whole kmem_cache_cpu percpu structure and
> > > >> associated code. Additionally to the slab page savings, this reduces
> > > >> percpu allocator usage, and code size.
> > > > 
> > > > [+Cc Dennis]
> > > 
> > > +To: Baoquan also.
> 
> Thanks for adding me.
> 
> > > 
> > > > Wondering if we can reduce (or zero) early reservation of percpu area
> > > > when #if !defined(CONFIG_SLUB) || defined(CONFIG_SLUB_TINY)?
> > > 
> > > Good point. I've sent a PR as it was [1], but (if merged) we can still
> > > improve that during RC series, if it means more memory saved thanks to less
> > > percpu usage with CONFIG_SLUB_TINY.
> > > 
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/tag/?h=slab-for-6.2-rc1
> > 
> > The early reservation area not used at boot is then used to serve normal
> > percpu allocations. Percpu allocates additional chunks based on a free
> > page float count and is backed page by page, not all at once. I get
> > slabs is the main motivator of early reservation, but if there are other
> > users of percpu, then shrinking the early reservation area is a bit
> > moot.
> 
> Agree. Before kmem_cache_init() is done, anyone calling alloc_percpu()
> can only get allocation done from early reservatoin of percpu area.
> So, unless we can make sure nobody need to call alloc_percpu() before
> kmem_cache_init() now and future.

Thank you both for explaination.
just googled and found random /proc/meminfo output of K210 board (6MB RAM, dual-core)

Given that even K210 board uses around 100kB of percpu area,
might not be worth thing to do :(

https://gist.github.com/pdp7/0fd86d39e07ad7084f430c85a7a567f4?permalink_comment_id=3179983#gistcomment-3179983

> The only drawback of early reservation is it's not so flexible. We can
> only dynamically create chunk to increase percpu areas when early
> reservation is run out, but can't shrink early reservation if system
> doesn't need that much.
> 
> So we may need weigh the two ideas:
>   - Not allowing to alloc_percpu() before kmem_cache_init();
>   - Keep early reservation, and think of a economic value for
>     CONFIG_SLUB_TINY.
>  
> start_kernel()
>   ->setup_per_cpu_areas();
>   ......
>   ->mm_init();
>       ......
>       -->kmem_cache_init();
> 
> 
> __alloc_percpu()
>   -->pcpu_alloc()
>      --> succeed to allocate from early reservation
>       or
>      -->pcpu_create_chunk()
>         -->pcpu_alloc_chunk()
>            -->pcpu_mem_zalloc()
> 

-- 
Thanks,
Hyeonggon
