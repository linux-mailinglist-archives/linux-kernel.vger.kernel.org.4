Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890A061A68D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKEBJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKEBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:09:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25964091D;
        Fri,  4 Nov 2022 18:09:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u6so6347729plq.12;
        Fri, 04 Nov 2022 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZRKTfzUgUmUoDMmXtLNWbH1d7SRg9NOYtTV2ieREGk=;
        b=WEeQ3oedxebSq3TylgaXd4uhHZ9fSf85t4y+VbXKEnRu/7HDBOu+78DX1+z7CCi5y7
         iXRQ9RG1+Zg01X1PRF7ztSjuRtPSWejAzJyKjVmW5vQBGjgN+PSGGvaFgNrjYR/yHXLH
         sn53T4Ne/NmwBRYJ5cRZM4YACVxoe+c7TnndsA9ak7FT4Nk/uRjxeR9Kgv2Ji9Kwf4GZ
         ZSwkypKIL9HoKD6Va65PrJYvi1yFVSeWLvEEoMsWeLDq5B7KPzuGinuq4ql9AMXKXWPu
         tMeggNh/G7KLz4CDnMCUtPkiNqH/satSpu6aMojsrEmZbKZLfg2X2ZK94qwSx3yGOOOC
         l90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZRKTfzUgUmUoDMmXtLNWbH1d7SRg9NOYtTV2ieREGk=;
        b=DZc0sm3msTx3QTgEcO7AVt4hZY6AWUedJUY3cfv18wqCi3Rx44vswdLqwg9LZMRcAc
         Oxh1MGuoWlY+PWI8Qb6kUrWnRPFNhhQYbUQ8xtSmsNnk+ZMTVeyZsX/Z1WWX5e+mGGgI
         HOP7V7d1rPlPX7Y2c7IFjlvZOFCVvY6IrtDDNmxw/yndO15tq3sTfXmMR5mMwMIzT8GP
         GhkattzhZP3eCuxC02/gev8dgZPlJfscROJMi8UH3BPoDytg4ZOmQKfbB6/Ghi5qniXy
         iOau8A+ctUeNjJntn+L6AS1FsAt0odozqxTjx+aeQrDX3yx4VbS5JPASPLebqNA29Dxw
         vGhw==
X-Gm-Message-State: ACrzQf0Wa0SLsv5iO9p2fOdEDB3xMyg7DB4oLQU0HW/EPlECtG3vw23L
        gPZcP8yFH8JJHIVYfsW26E8=
X-Google-Smtp-Source: AMsMyM7rn2BtRhnzi3h+OsA0B40E06ImoWbABI8HcmyJhN73GZyM7ao3+XvXzCg/8TYVD9EkwCIrNg==
X-Received: by 2002:a17:90a:ba85:b0:212:d644:fc28 with SMTP id t5-20020a17090aba8500b00212d644fc28mr39973129pjr.72.1667610581148;
        Fri, 04 Nov 2022 18:09:41 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id u7-20020a63ef07000000b004393c5a8006sm310615pgh.75.2022.11.04.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 18:09:40 -0700 (PDT)
Date:   Sat, 5 Nov 2022 10:09:32 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        David Gow <davidgow@google.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 3/6] slab: Provide functional __alloc_size() hints to
 kmalloc_trace*()
Message-ID: <Y2W3zEcMd82B0O1I@hyeyoo>
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-3-keescook@chromium.org>
 <Y2PNVUzHWCg765ml@hyeyoo>
 <202211041121.2F1639D2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211041121.2F1639D2@keescook>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:22:42AM -0700, Kees Cook wrote:
> On Thu, Nov 03, 2022 at 11:16:53PM +0900, Hyeonggon Yoo wrote:
> > On Tue, Nov 01, 2022 at 03:33:11PM -0700, Kees Cook wrote:
> > > Since GCC cannot apply the __alloc_size attributes to inlines[1], all
> > > allocator inlines need to explicitly call into extern functions that
> > > contain a size argument. Provide these wrappers that end up just
> > > ignoring the size argument for the actual allocation.
> > > 
> > > This allows CONFIG_FORTIFY_SOURCE=y to see all various dynamic allocation
> > > sizes under GCC 12+ and all supported Clang versions.
> > > 
> > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> > > 
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Christoph Lameter <cl@linux.com>
> > > Cc: Pekka Enberg <penberg@kernel.org>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > Cc: linux-mm@kvack.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/linux/slab.h |  8 ++++++--
> > >  mm/slab_common.c     | 14 ++++++++++++++
> > >  2 files changed, 20 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index 970e9504949e..051d86ca31a8 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -442,6 +442,8 @@ static_assert(PAGE_SHIFT <= 20);
> > >  
> > >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> > >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> > > +void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
> > > +			     __assume_slab_alignment __alloc_size(3);
> > >  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > >  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> > >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> > > @@ -469,6 +471,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignm
> > >  							 __alloc_size(1);
> > >  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
> > >  									 __malloc;
> > > +void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
> > > +				  __assume_slab_alignment __alloc_size(4);
> > >  
> > >  #ifdef CONFIG_TRACING
> > >  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> > > @@ -482,7 +486,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> > >  static __always_inline __alloc_size(3)
> > >  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> > >  {
> > > -	void *ret = kmem_cache_alloc(s, flags);
> > > +	void *ret = kmem_cache_alloc_sized(s, flags, size);
> > >  
> > >  	ret = kasan_kmalloc(s, ret, size, flags);
> > >  	return ret;
> > > @@ -492,7 +496,7 @@ static __always_inline __alloc_size(4)
> > >  void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> > >  			 int node, size_t size)
> > >  {
> > > -	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
> > > +	void *ret = kmem_cache_alloc_node_sized(s, gfpflags, node, size);
> > >  
> > >  	ret = kasan_kmalloc(s, ret, size, gfpflags);
> > >  	return ret;
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index 33b1886b06eb..5fa547539a6a 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -1457,6 +1457,20 @@ size_t ksize(const void *objp)
> > >  }
> > >  EXPORT_SYMBOL(ksize);
> > >  
> > > +/* Wrapper so __alloc_size() can see the actual allocation size. */
> > > +void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
> > > +{
> > > +	return kmem_cache_alloc(s, flags);
> > > +}
> > > +EXPORT_SYMBOL(kmem_cache_alloc_sized);
> > > +
> > > +/* Wrapper so __alloc_size() can see the actual allocation size. */
> > > +void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
> > > +{
> > > +	return kmem_cache_alloc_node(s, flags, node);
> > > +}
> > > +EXPORT_SYMBOL(kmem_cache_alloc_node_sized);
> > 
> > The reason that we have two implementations of kmalloc_trace*
> > depending on CONFIG_TRACING is to save additional function call when
> > CONFIG_TRACING is not set.
> > 
> > With this patch there is no reason to keep both.
> > So let's drop #ifdefs and use single implementation in mm/slab_common.c.
> 
> Okay, I'll respin...
> 
> -- 
> Kees Cook

Oh, it seems Vlastimil already did that.
Maybe simply drop this patch in next spin?

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.1-rc4/fixes&id=eb4940d4adf590590a9d0c47e38d2799c2ff9670

Thanks!

-- 
Hyeonggon
