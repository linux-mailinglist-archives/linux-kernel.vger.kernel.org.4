Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E29708834
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjERTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjERTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:10:50 -0400
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF1198
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:10:48 -0700 (PDT)
Date:   Thu, 18 May 2023 15:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684437046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTE9m9G2YQF3y82OvwFBbeZse+nVjMDUG8xTbRI5o5Q=;
        b=i13k7+869NLwZHoG32SSkSjBCsz/GmdDXRWkQt7PfcP7BocdKjdrKACQgzHQfznKCl8VRa
        XvYbZX3X7zVKBis8q4OTniEc5QE9YOTi3HypKZx6OcNqyz+9aVpiZxKfyoiOBIYaGgtfIh
        Kz3mgAERwxzMjLWwlXkozEhwruCWcAg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZGZ4Mln9tKI8W3Qq@moria.home.lan>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan>
 <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZZIM0qftr0T59b@moria.home.lan>
 <CAPhsuW7yz4iOuDaA_eH2aWsY7B_NQayW1WGZ_1qYepur_4KOsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7yz4iOuDaA_eH2aWsY7B_NQayW1WGZ_1qYepur_4KOsQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:01:26PM -0700, Song Liu wrote:
> On Thu, May 18, 2023 at 9:58 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > > I am working on patches based on the discussion in [1]. I am planning to
> > > send v1 for review in a week or so.
> >
> > For reference, here's my own (early, but functioning :) slab allocator:
> >
> > Look forward to comparing!
> > -->--
> > From 6eeb6b8ef4271ea1a8d9cac7fbaeeb7704951976 Mon Sep 17 00:00:00 2001
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > Date: Wed, 17 May 2023 01:22:06 -0400
> > Subject: [PATCH] mm: jit/text allocator
> >
> > This provides a new, very simple slab allocator for jit/text, i.e. bpf,
> > ftrace trampolines, or bcachefs unpack functions.
> >
> > With this API we can avoid ever mapping pages both writeable and
> > executable (not implemented in this patch: need to tweak
> > module_alloc()), and it also supports sub-page sized allocations.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> [...]
> 
> > +static void *jit_cache_alloc(void *buf, size_t len, struct jit_cache *cache)
> > +{
> > +       struct jit_slab *s =
> > +               list_first_entry_or_null(&cache->partial, struct jit_slab, list) ?:
> > +               jit_slab_alloc(cache);
> > +       unsigned obj_idx, nr_allocated;
> > +
> > +       if (!s)
> > +               return NULL;
> > +
> > +       obj_idx = find_first_zero_bit(s->objs_allocated, cache->objs_per_slab);
> > +
> > +       BUG_ON(obj_idx >= cache->objs_per_slab);
> > +       __set_bit(obj_idx, s->objs_allocated);
> > +
> > +       nr_allocated = bitmap_weight(s->objs_allocated, s->cache->objs_per_slab);
> > +
> > +       if (nr_allocated == s->cache->objs_per_slab) {
> > +               list_del_init(&s->list);
> > +       } else if (nr_allocated == 1) {
> > +               list_del(&s->list);
> > +               list_add(&s->list, &s->cache->partial);
> > +       }
> > +
> > +       return s->executably_mapped + (obj_idx << cache->obj_size_bits);
> > +}
> 
> IIUC, "len" is ignored in jit_cache_alloc(), so it can only handle
> <=16 byte allocations?

len is a redundant parameter (good catch); at that point we've picked a
cache for the specific allocation size.

Since there's multiple caches for each power of two size, it can handle
allocations up to PAGE_SIZE.
