Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCA619FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiKDSXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiKDSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:23:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD959FE6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:22:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y203so5214821pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kwrddbh0AjpQHJDtv4p1kwlSWL7OpMjxgVy9tJ3ZdE=;
        b=mediYFwUYG/2yUbilqGlldO/gRsGC6/mgEYuIhDe1Si39QjNc/trPYKiP1p9XhU8FS
         YC6GtGaQ7BTmWdx71ehDpLJFh9gH4TAS6wjDRpintwM7thIXMmpHNBa+YpPp7Sk910xG
         LjmbkmsEmGX5jCFZeb0bEhpFMYS1j5fKV131E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kwrddbh0AjpQHJDtv4p1kwlSWL7OpMjxgVy9tJ3ZdE=;
        b=K+YocEblOfP2b2BBQsmzLHE+PHtP79sArp1KU8U2g2InTB3LT/ACiCdywgq4USI4Vx
         FHN+rreRO1A9ndNa76sanlTFwdfjOyzBwAIE93u4PyMze3s+5XZD4AIfIX+46mtlMs8w
         ehDv2nvpjkP9hwJU8K+W+8FsSJTztIDsm1ISDruXGHrF/oEGKFhnOqprq2yfr7OTGYHM
         rU2JWf2K/MhD7cDw0EmcExDDZ8CcFwN5ie4CbhW5wWZL9RYlROFiWAtzbtyRiLi0wYGR
         SYUsJUFH/ilZANHJDUpvdzxpmEFdbOAWhB/f3tHqrEBbIp3jhnkh9gHZWVMXeF6EmuPQ
         i5Sg==
X-Gm-Message-State: ACrzQf1Lk8oMCkgJSU9f3yl8jGSxoOVx1YJpj4OFiBkOL7cnvh3vUpzG
        s23cUtI3br9LLFDPxbA1nMJ/nA==
X-Google-Smtp-Source: AMsMyM4CO8L3McL6UsxwJau7ib17Hp7kzIQy7y4IuR8J7fZLkaa5SiTqyGOJadghOQ5ciylvf87g2g==
X-Received: by 2002:aa7:81cc:0:b0:563:4e53:c08b with SMTP id c12-20020aa781cc000000b005634e53c08bmr36706082pfn.19.1667586163647;
        Fri, 04 Nov 2022 11:22:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79e47000000b0053e38ac0ff4sm3013789pfq.115.2022.11.04.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:22:43 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:22:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
Message-ID: <202211041121.2F1639D2@keescook>
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-3-keescook@chromium.org>
 <Y2PNVUzHWCg765ml@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PNVUzHWCg765ml@hyeyoo>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:16:53PM +0900, Hyeonggon Yoo wrote:
> On Tue, Nov 01, 2022 at 03:33:11PM -0700, Kees Cook wrote:
> > Since GCC cannot apply the __alloc_size attributes to inlines[1], all
> > allocator inlines need to explicitly call into extern functions that
> > contain a size argument. Provide these wrappers that end up just
> > ignoring the size argument for the actual allocation.
> > 
> > This allows CONFIG_FORTIFY_SOURCE=y to see all various dynamic allocation
> > sizes under GCC 12+ and all supported Clang versions.
> > 
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> > 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/slab.h |  8 ++++++--
> >  mm/slab_common.c     | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 970e9504949e..051d86ca31a8 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -442,6 +442,8 @@ static_assert(PAGE_SHIFT <= 20);
> >  
> >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> > +void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
> > +			     __assume_slab_alignment __alloc_size(3);
> >  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> >  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> > @@ -469,6 +471,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignm
> >  							 __alloc_size(1);
> >  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
> >  									 __malloc;
> > +void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
> > +				  __assume_slab_alignment __alloc_size(4);
> >  
> >  #ifdef CONFIG_TRACING
> >  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> > @@ -482,7 +486,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> >  static __always_inline __alloc_size(3)
> >  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> >  {
> > -	void *ret = kmem_cache_alloc(s, flags);
> > +	void *ret = kmem_cache_alloc_sized(s, flags, size);
> >  
> >  	ret = kasan_kmalloc(s, ret, size, flags);
> >  	return ret;
> > @@ -492,7 +496,7 @@ static __always_inline __alloc_size(4)
> >  void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> >  			 int node, size_t size)
> >  {
> > -	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
> > +	void *ret = kmem_cache_alloc_node_sized(s, gfpflags, node, size);
> >  
> >  	ret = kasan_kmalloc(s, ret, size, gfpflags);
> >  	return ret;
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 33b1886b06eb..5fa547539a6a 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1457,6 +1457,20 @@ size_t ksize(const void *objp)
> >  }
> >  EXPORT_SYMBOL(ksize);
> >  
> > +/* Wrapper so __alloc_size() can see the actual allocation size. */
> > +void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
> > +{
> > +	return kmem_cache_alloc(s, flags);
> > +}
> > +EXPORT_SYMBOL(kmem_cache_alloc_sized);
> > +
> > +/* Wrapper so __alloc_size() can see the actual allocation size. */
> > +void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
> > +{
> > +	return kmem_cache_alloc_node(s, flags, node);
> > +}
> > +EXPORT_SYMBOL(kmem_cache_alloc_node_sized);
> 
> The reason that we have two implementations of kmalloc_trace*
> depending on CONFIG_TRACING is to save additional function call when
> CONFIG_TRACING is not set.
> 
> With this patch there is no reason to keep both.
> So let's drop #ifdefs and use single implementation in mm/slab_common.c.

Okay, I'll respin...

-- 
Kees Cook
