Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0032A708694
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjERRQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjERRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED29F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A6F65107
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48EEC433A7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430173;
        bh=BicXuHAH0L0Nj1CK7fc4znKiUcAy3bHgVFwXS6rqpv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g+N7l4bQMeSJN0riQz8JUa1UFMvnLPw7I8F5CtkcYIl1N/qZ3b+wJzcxyTm9sRmjb
         VJ/1NYk6XWhS0SXHSwO52p1p89b7VeIXH/Gkkr/4ltSEj7jOVzoqtxPwhcV1ZdvaGv
         w2ohtiEc1P0hq17iDppKdn/PkU7xNThfDLdSHKUG5aYJaH/obFB6DiuIz8B05tk/hF
         Lyo0aPt4/lV3JMkvu2rBeHWOGm9YGJl/jno0CedZpWkWUQpnM/wG3pb9J+WII4rDOu
         dsqhbMDu+myTLJeupN5foFRefVFoz65wN1k5f8QuP2EpfO2d+U7C+jT1wdxNNj0uOR
         O/LCwAC4FVWsg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ac733b813fso25084561fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:16:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDzJgDkwdNxKyiEuEiAaurosilHnp6D8LJyA2sGSD040FwSnxp51
        kf6uTtbIrx7dmpBdYoW0JvgrJuNdtmBgVsVlsvY=
X-Google-Smtp-Source: ACHHUZ5G/pNUXKf8HN8qep0pHvgI1/meZ1dwee9HVbTYCVYba+8igYppAwpm5kHbrxX3hnmw5giGIqyU1BcxOR8GW48=
X-Received: by 2002:ac2:4a65:0:b0:4f1:3d7d:409e with SMTP id
 q5-20020ac24a65000000b004f13d7d409emr1540743lfp.0.1684430171727; Thu, 18 May
 2023 10:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com> <ZGZZIM0qftr0T59b@moria.home.lan>
In-Reply-To: <ZGZZIM0qftr0T59b@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Thu, 18 May 2023 10:15:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Ccu1oYw1WjqqX0a685VWxiieHZiPui_=BMAn8dV7ivQ@mail.gmail.com>
Message-ID: <CAPhsuW4Ccu1oYw1WjqqX0a685VWxiieHZiPui_=BMAn8dV7ivQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 9:58=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 18, 2023 at 09:33:20AM -0700, Song Liu wrote:
> > I am working on patches based on the discussion in [1]. I am planning t=
o
> > send v1 for review in a week or so.
>
> For reference, here's my own (early, but functioning :) slab allocator:
>
> Look forward to comparing!

This looks similar to the bpf_prog_pack allocator we use for BPF at the
moment. (search for bpf_prog_pack in kernel/bpf/core.c). I guess we
can also use bpf_prog_pack for bcachefs for now.

Thanks,
Song

> -->--
> From 6eeb6b8ef4271ea1a8d9cac7fbaeeb7704951976 Mon Sep 17 00:00:00 2001
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Wed, 17 May 2023 01:22:06 -0400
> Subject: [PATCH] mm: jit/text allocator
>
> This provides a new, very simple slab allocator for jit/text, i.e. bpf,
> ftrace trampolines, or bcachefs unpack functions.
>
> With this API we can avoid ever mapping pages both writeable and
> executable (not implemented in this patch: need to tweak
> module_alloc()), and it also supports sub-page sized allocations.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> diff --git a/include/linux/jitalloc.h b/include/linux/jitalloc.h
> new file mode 100644
> index 0000000000..f1549d60e8
> --- /dev/null
> +++ b/include/linux/jitalloc.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_JITALLOC_H
> +#define _LINUX_JITALLOC_H
> +
> +void jit_update(void *buf, void *new_buf, size_t len);
> +void jit_free(void *buf);
> +void *jit_alloc(void *buf, size_t len);
> +
> +#endif /* _LINUX_JITALLOC_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4751031f3f..ff26a4f0c9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1202,6 +1202,9 @@ config LRU_GEN_STATS
>           This option has a per-memcg and per-node memory overhead.
>  # }
>
> +config JITALLOC
> +       bool
> +
>  source "mm/damon/Kconfig"
>
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index c03e1e5859..25e82db9e8 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) +=3D io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) +=3D bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) +=3D ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) +=3D shrinker_debug.o
> +obj-$(CONFIG_JITALLOC) +=3D jitalloc.o
> diff --git a/mm/jitalloc.c b/mm/jitalloc.c
> new file mode 100644
> index 0000000000..7c4d621802
> --- /dev/null
> +++ b/mm/jitalloc.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/gfp.h>
> +#include <linux/highmem.h>
> +#include <linux/jitalloc.h>
> +#include <linux/mm.h>
> +#include <linux/moduleloader.h>
> +#include <linux/mutex.h>
> +#include <linux/set_memory.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/text-patching.h>
> +
> +static DEFINE_MUTEX(jit_alloc_lock);
> +
> +struct jit_cache {
> +       unsigned                obj_size_bits;
> +       unsigned                objs_per_slab;
> +       struct list_head        partial;
> +};
> +
> +#define JITALLOC_MIN_SIZE      16
> +#define NR_JIT_CACHES          ilog2(PAGE_SIZE / JITALLOC_MIN_SIZE)
> +
> +static struct jit_cache jit_caches[NR_JIT_CACHES];
> +
> +struct jit_slab {
> +       unsigned long           __page_flags;
> +
> +       struct jit_cache        *cache;
> +       void                    *executably_mapped;;
> +       unsigned long           *objs_allocated; /* bitmap of free object=
s */
> +       struct list_head        list;
> +};
> +
> +#define folio_jit_slab(folio)          (_Generic((folio),               =
       \
> +       const struct folio *:           (const struct jit_slab *)(folio),=
       \
> +       struct folio *:                 (struct jit_slab *)(folio)))
> +
> +#define jit_slab_folio(s)              (_Generic((s),                   =
       \
> +       const struct jit_slab *:        (const struct folio *)s,         =
       \
> +       struct jit_slab *:              (struct folio *)s))
> +
> +static struct jit_slab *jit_slab_alloc(struct jit_cache *cache)
> +{
> +       void *executably_mapped =3D module_alloc(PAGE_SIZE);
> +       struct page *page;
> +       struct folio *folio;
> +       struct jit_slab *slab;
> +       unsigned long *objs_allocated;
> +
> +       if (!executably_mapped)
> +               return NULL;
> +
> +       objs_allocated =3D kcalloc(BITS_TO_LONGS(cache->objs_per_slab), s=
izeof(unsigned long), GFP_KERNEL);
> +       if (!objs_allocated ) {
> +               vfree(executably_mapped);
> +               return NULL;
> +       }
> +
> +       set_vm_flush_reset_perms(executably_mapped);
> +       set_memory_rox((unsigned long) executably_mapped, 1);
> +
> +       page =3D vmalloc_to_page(executably_mapped);
> +       folio =3D page_folio(page);
> +
> +       __folio_set_slab(folio);
> +       slab                    =3D folio_jit_slab(folio);
> +       slab->cache             =3D cache;
> +       slab->executably_mapped =3D executably_mapped;
> +       slab->objs_allocated =3D objs_allocated;
> +       INIT_LIST_HEAD(&slab->list);
> +
> +       return slab;
> +}
> +
> +static void *jit_cache_alloc(void *buf, size_t len, struct jit_cache *ca=
che)
> +{
> +       struct jit_slab *s =3D
> +               list_first_entry_or_null(&cache->partial, struct jit_slab=
, list) ?:
> +               jit_slab_alloc(cache);
> +       unsigned obj_idx, nr_allocated;
> +
> +       if (!s)
> +               return NULL;
> +
> +       obj_idx =3D find_first_zero_bit(s->objs_allocated, cache->objs_pe=
r_slab);
> +
> +       BUG_ON(obj_idx >=3D cache->objs_per_slab);
> +       __set_bit(obj_idx, s->objs_allocated);
> +
> +       nr_allocated =3D bitmap_weight(s->objs_allocated, s->cache->objs_=
per_slab);
> +
> +       if (nr_allocated =3D=3D s->cache->objs_per_slab) {
> +               list_del_init(&s->list);
> +       } else if (nr_allocated =3D=3D 1) {
> +               list_del(&s->list);
> +               list_add(&s->list, &s->cache->partial);
> +       }
> +
> +       return s->executably_mapped + (obj_idx << cache->obj_size_bits);
> +}
> +
> +void jit_update(void *buf, void *new_buf, size_t len)
> +{
> +       text_poke_copy(buf, new_buf, len);
> +}
> +EXPORT_SYMBOL_GPL(jit_update);
> +
> +void jit_free(void *buf)
> +{
> +       struct page *page;
> +       struct folio *folio;
> +       struct jit_slab *s;
> +       unsigned obj_idx, nr_allocated;
> +       size_t offset;
> +
> +       if (!buf)
> +               return;
> +
> +       page    =3D vmalloc_to_page(buf);
> +       folio   =3D page_folio(page);
> +       offset  =3D offset_in_folio(folio, buf);
> +
> +       if (!folio_test_slab(folio)) {
> +               vfree(buf);
> +               return;
> +       }
> +
> +       s =3D folio_jit_slab(folio);
> +
> +       mutex_lock(&jit_alloc_lock);
> +       obj_idx =3D offset >> s->cache->obj_size_bits;
> +
> +       __clear_bit(obj_idx, s->objs_allocated);
> +
> +       nr_allocated =3D bitmap_weight(s->objs_allocated, s->cache->objs_=
per_slab);
> +
> +       if (nr_allocated =3D=3D 0) {
> +               list_del(&s->list);
> +               kfree(s->objs_allocated);
> +               folio_put(folio);
> +       } else if (nr_allocated + 1 =3D=3D s->cache->objs_per_slab) {
> +               list_del(&s->list);
> +               list_add(&s->list, &s->cache->partial);
> +       }
> +
> +       mutex_unlock(&jit_alloc_lock);
> +}
> +EXPORT_SYMBOL_GPL(jit_free);
> +
> +void *jit_alloc(void *buf, size_t len)
> +{
> +       unsigned jit_cache_idx =3D ilog2(roundup_pow_of_two(len) / 16);
> +       void *p;
> +
> +       if (jit_cache_idx < NR_JIT_CACHES) {
> +               mutex_lock(&jit_alloc_lock);
> +               p =3D jit_cache_alloc(buf, len, &jit_caches[jit_cache_idx=
]);
> +               mutex_unlock(&jit_alloc_lock);
> +       } else {
> +               p =3D module_alloc(len);
> +               if (p) {
> +                       set_vm_flush_reset_perms(p);
> +                       set_memory_rox((unsigned long) p, DIV_ROUND_UP(le=
n, PAGE_SIZE));
> +               }
> +       }
> +
> +       if (p && buf)
> +               jit_update(p, buf, len);
> +
> +       return p;
> +}
> +EXPORT_SYMBOL_GPL(jit_alloc);
> +
> +static int __init jit_alloc_init(void)
> +{
> +       for (unsigned i =3D 0; i < ARRAY_SIZE(jit_caches); i++) {
> +               jit_caches[i].obj_size_bits     =3D ilog2(JITALLOC_MIN_SI=
ZE) + i;
> +               jit_caches[i].objs_per_slab     =3D PAGE_SIZE >> jit_cach=
es[i].obj_size_bits;
> +
> +               INIT_LIST_HEAD(&jit_caches[i].partial);
> +       }
> +
> +       return 0;
> +}
> +core_initcall(jit_alloc_init);
>
