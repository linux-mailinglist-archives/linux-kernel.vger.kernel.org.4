Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13261D7F5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 07:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKEGqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 02:46:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A207D186D5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:46:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k7so6765448pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=srq0262QxbkEV6kNYP4erFtvI0rgH+oqu5/TPMxlwy4=;
        b=W4KaJP6FV2vwHiDT+VvgaGaA1jeM6SQ8YJpGYx2Pbkhvyt+b8ut77tl012BXpoCSKZ
         u+nxM1dLCKIVpLHfyXG1p88984BbMhKZGcd9C4F0RT8kncpFr41iKYeXmFz2HFf1Qd2/
         RsyWHfwKmiA0qvv+5iNwqot7JBpHFX9AjApgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srq0262QxbkEV6kNYP4erFtvI0rgH+oqu5/TPMxlwy4=;
        b=E05vZK6Yo4oskasLQZW4MEE7BjOOiH6Ceyn1C0uxsd8nQjMjXMO7p3ukNIq8t/6HVx
         rpFWo0AS03/5Wkz610dEoVNBfwMhLtutVL7yhYGtU4507hQjKufSWchHNfDcu19ch1Fx
         Sdf6L4yK/4LZPzvXBzHdhgF4cg4xF0RzX1MBh/kYlc2nbpqWkQjcw4T3Sox9hun99//9
         DznTo3QYGyaAmifhNHAkhjc0aU43Q5iWWffN7Qycwir8zMprXCk9rHeJEXiJZzOfwP0e
         SaeYZf1B/gc+Vnn5GpRxwkNeaTn/hitOwDfQ04b86ddza9ZnXzRqiV3UVz0jZCxm2hYj
         YRTg==
X-Gm-Message-State: ACrzQf0zPi6J8giSmhnU9exLkZSJDJkSnxqFOU8TZsrSPkB31yVXRwT3
        cc53gDKG3vVS0QYlKmaawQW8OQ==
X-Google-Smtp-Source: AMsMyM4oJjpqJJcKwUVLP7X5WeicCqIX6jcTy1xHjHbJtoU/3/GvJrm+L6ClZGrmleAPy813oxTJNQ==
X-Received: by 2002:a17:903:1c6:b0:185:47ce:f4f0 with SMTP id e6-20020a17090301c600b0018547cef4f0mr40384496plh.132.1667630761129;
        Fri, 04 Nov 2022 23:46:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b0018099c9618esm857879plc.231.2022.11.04.23.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 23:46:00 -0700 (PDT)
Date:   Fri, 4 Nov 2022 23:45:59 -0700
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
Message-ID: <202211042345.B1D74469BC@keescook>
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-3-keescook@chromium.org>
 <Y2PNVUzHWCg765ml@hyeyoo>
 <202211041121.2F1639D2@keescook>
 <Y2W3zEcMd82B0O1I@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2W3zEcMd82B0O1I@hyeyoo>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 10:09:32AM +0900, Hyeonggon Yoo wrote:
> On Fri, Nov 04, 2022 at 11:22:42AM -0700, Kees Cook wrote:
> > On Thu, Nov 03, 2022 at 11:16:53PM +0900, Hyeonggon Yoo wrote:
> > > On Tue, Nov 01, 2022 at 03:33:11PM -0700, Kees Cook wrote:
> > > > Since GCC cannot apply the __alloc_size attributes to inlines[1], all
> > > > allocator inlines need to explicitly call into extern functions that
> > > > contain a size argument. Provide these wrappers that end up just
> > > > ignoring the size argument for the actual allocation.
> > > > 
> > > > This allows CONFIG_FORTIFY_SOURCE=y to see all various dynamic allocation
> > > > sizes under GCC 12+ and all supported Clang versions.
> > > > 
> > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> > > > 
> > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: Christoph Lameter <cl@linux.com>
> > > > Cc: Pekka Enberg <penberg@kernel.org>
> > > > Cc: David Rientjes <rientjes@google.com>
> > > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > Cc: linux-mm@kvack.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  include/linux/slab.h |  8 ++++++--
> > > >  mm/slab_common.c     | 14 ++++++++++++++
> > > >  2 files changed, 20 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > > index 970e9504949e..051d86ca31a8 100644
> > > > --- a/include/linux/slab.h
> > > > +++ b/include/linux/slab.h
> > > > @@ -442,6 +442,8 @@ static_assert(PAGE_SHIFT <= 20);
> > > >  
> > > >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> > > >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> > > > +void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
> > > > +			     __assume_slab_alignment __alloc_size(3);
> > > >  void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > > >  			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> > > >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> > > > @@ -469,6 +471,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignm
> > > >  							 __alloc_size(1);
> > > >  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
> > > >  									 __malloc;
> > > > +void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
> > > > +				  __assume_slab_alignment __alloc_size(4);
> > > >  
> > > >  #ifdef CONFIG_TRACING
> > > >  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> > > > @@ -482,7 +486,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> > > >  static __always_inline __alloc_size(3)
> > > >  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
> > > >  {
> > > > -	void *ret = kmem_cache_alloc(s, flags);
> > > > +	void *ret = kmem_cache_alloc_sized(s, flags, size);
> > > >  
> > > >  	ret = kasan_kmalloc(s, ret, size, flags);
> > > >  	return ret;
> > > > @@ -492,7 +496,7 @@ static __always_inline __alloc_size(4)
> > > >  void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
> > > >  			 int node, size_t size)
> > > >  {
> > > > -	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
> > > > +	void *ret = kmem_cache_alloc_node_sized(s, gfpflags, node, size);
> > > >  
> > > >  	ret = kasan_kmalloc(s, ret, size, gfpflags);
> > > >  	return ret;
> > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > index 33b1886b06eb..5fa547539a6a 100644
> > > > --- a/mm/slab_common.c
> > > > +++ b/mm/slab_common.c
> > > > @@ -1457,6 +1457,20 @@ size_t ksize(const void *objp)
> > > >  }
> > > >  EXPORT_SYMBOL(ksize);
> > > >  
> > > > +/* Wrapper so __alloc_size() can see the actual allocation size. */
> > > > +void *kmem_cache_alloc_sized(struct kmem_cache *s, gfp_t flags, size_t size)
> > > > +{
> > > > +	return kmem_cache_alloc(s, flags);
> > > > +}
> > > > +EXPORT_SYMBOL(kmem_cache_alloc_sized);
> > > > +
> > > > +/* Wrapper so __alloc_size() can see the actual allocation size. */
> > > > +void *kmem_cache_alloc_node_sized(struct kmem_cache *s, gfp_t flags, int node, size_t size)
> > > > +{
> > > > +	return kmem_cache_alloc_node(s, flags, node);
> > > > +}
> > > > +EXPORT_SYMBOL(kmem_cache_alloc_node_sized);
> > > 
> > > The reason that we have two implementations of kmalloc_trace*
> > > depending on CONFIG_TRACING is to save additional function call when
> > > CONFIG_TRACING is not set.
> > > 
> > > With this patch there is no reason to keep both.
> > > So let's drop #ifdefs and use single implementation in mm/slab_common.c.
> > 
> > Okay, I'll respin...
> > 
> > -- 
> > Kees Cook
> 
> Oh, it seems Vlastimil already did that.
> Maybe simply drop this patch in next spin?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.1-rc4/fixes&id=eb4940d4adf590590a9d0c47e38d2799c2ff9670

Oh! Well, yes, that makes that easy. :)

-- 
Kees Cook
