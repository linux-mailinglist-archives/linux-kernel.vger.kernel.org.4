Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A9966642A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAKT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAKT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:56:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB14DD98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:56:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e3so6930141wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+NPdJF8hsiubtlj+AiVrEELlpk0n5+S7Jan8m1JiJs=;
        b=jmHAw91zUvLCtshLu05+anzIs1lDqMNt+L4mURze0qIz146bnoEmHF79u3dQ4Os6fc
         0p+ppE3uJo3ttTuKZ+RaVlZnnEpzjAJeNRK0omtOKO2s+xt4HDcg9AvrvzMh/8fvHAgh
         ekizJ85mQ7OIKPkV1+9dP1OGWaHd9ilxInWnNKzjRKww9GFOo3o1s6GoKi0dIOusI1Np
         36AWfJqQVXJXzJNYzc6qJlTSCnn4SmGP7wVoerpgO0pzQHZ90aDLhCL0shbKwH6SX6OG
         2per0sdcz6Mp4j4A4oeKaDPVKG8URG5Nh5AGtvt5bTb9DcFSsb39N2FAMkaFBuxKQVoG
         j5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+NPdJF8hsiubtlj+AiVrEELlpk0n5+S7Jan8m1JiJs=;
        b=DGEGqnwk3jkjnkzkUsFjCU0J9dajlEGnSWHnL0xLR5tItzBi9OPtrEwAR/yDgKPnNr
         pbzZRvyFyHVN4nTXtYlzXs7h3F1T2i72GGIR5FigzFn9cyaL7WnFFA2ozpSIj7WLzQo5
         U584bZi8axxWaBW7fBhihu+EBugrnFmSWARrVgxJ5ecWojMXjAjn55EmxGIg9SDR/tIB
         zcQ6lIICkCTy6SYxCk0oNL/VtrixDy8os1OI4LmAeLRRzFa0zcuOMpr/WjTPk4oWRZGk
         0XMejE2z85MoP+6yNLo3k2pVDR+1kbQdc56eIq+FWFq85et+uqy2hiIfRB2dpHWMxWpj
         4Y/g==
X-Gm-Message-State: AFqh2krsmQ8PJcRwV48ZXhGkdh6JEboTKukO2QX04qzYBcRQryUQboO3
        qihydTrKddCg3SWYDqInNkoIghYO0YxKxbSAQvdKRDY/Vl05Vg==
X-Google-Smtp-Source: AMrXdXvZBBV/vcnpEzLVQlHiZgLrDfO4YgBhvJTB/dnnY/zD6fiSPuakF82/M4ys/vMcsNr7ebnqtcOa+04uAbuodoo=
X-Received: by 2002:a5d:5221:0:b0:2b0:6953:fac6 with SMTP id
 i1-20020a5d5221000000b002b06953fac6mr1306658wra.131.1673466974005; Wed, 11
 Jan 2023 11:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20230110231701.326724-1-nphamcs@gmail.com>
In-Reply-To: <20230110231701.326724-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 11 Jan 2023 11:56:02 -0800
Message-ID: <CAKEwX=NWkwqtZ9FtaVZj=7kMnjXR+avmb+9xqhG9NpA-s05SPg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: fix a race with deferred_handles storing
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 3:17 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Currently, there is a race between zs_free() and zs_reclaim_page():
> zs_reclaim_page() finds a handle to an allocated object, but before the
> eviction happens, an independent zs_free() call to the same handle could
> come in and overwrite the object value stored at the handle with
> the last deferred handle. When zs_reclaim_page() finally gets to call
> the eviction handler, it will see an invalid object value (i.e the
> previous deferred handle instead of the original object value).
>
> This race happens quite infrequently. We only managed to produce it with
> out-of-tree developmental code that triggers zsmalloc writeback with a
> much higher frequency than usual.
>
> This patch fixes this race by storing the deferred handle in the object
> header instead. We differentiate the deferred handle from the other two
> cases (handle for allocated object, and linkage for free object) with a
> new tag. If zspage reclamation succeeds, we will free these deferred
> handles by walking through the zspage objects. On the other hand, if
> zspage reclamation fails, we reconstruct the zspage freelist (with the
> deferred handle tag and allocated tag) before trying again with the
> reclamation.
>
Fixes: 9997bc017549 ("zsmalloc: implement writeback mechanism for zsmalloc")
I forgot to add the fix tag to this patch.
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 237 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 205 insertions(+), 32 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 9445bee6b014..b4b40ef98703 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -113,7 +113,23 @@
>   * have room for two bit at least.
>   */
>  #define OBJ_ALLOCATED_TAG 1
> -#define OBJ_TAG_BITS 1
> +
> +#ifdef CONFIG_ZPOOL
> +/*
> + * The second least-significant bit in the object's header identifies if the
> + * value stored at the header is a deferred handle from the last reclaim
> + * attempt.
> + *
> + * As noted above, this is valid because we have room for two bits.
> + */
> +#define OBJ_DEFERRED_HANDLE_TAG        2
> +#define OBJ_TAG_BITS   2
> +#define OBJ_TAG_MASK   (OBJ_ALLOCATED_TAG | OBJ_DEFERRED_HANDLE_TAG)
> +#else
> +#define OBJ_TAG_BITS   1
> +#define OBJ_TAG_MASK   OBJ_ALLOCATED_TAG
> +#endif /* CONFIG_ZPOOL */
> +
>  #define OBJ_INDEX_BITS (BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK ((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
>
> @@ -222,6 +238,12 @@ struct link_free {
>                  * Handle of allocated object.
>                  */
>                 unsigned long handle;
> +#ifdef CONFIG_ZPOOL
> +               /*
> +                * Deferred handle of a reclaimed object.
> +                */
> +               unsigned long deferred_handle;
> +#endif
>         };
>  };
>
> @@ -272,8 +294,6 @@ struct zspage {
>         /* links the zspage to the lru list in the pool */
>         struct list_head lru;
>         bool under_reclaim;
> -       /* list of unfreed handles whose objects have been reclaimed */
> -       unsigned long *deferred_handles;
>  #endif
>
>         struct zs_pool *pool;
> @@ -897,7 +917,8 @@ static unsigned long handle_to_obj(unsigned long handle)
>         return *(unsigned long *)handle;
>  }
>
> -static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
> +static bool obj_tagged(struct page *page, void *obj, unsigned long *phandle,
> +               int tag)
>  {
>         unsigned long handle;
>         struct zspage *zspage = get_zspage(page);
> @@ -908,13 +929,27 @@ static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
>         } else
>                 handle = *(unsigned long *)obj;
>
> -       if (!(handle & OBJ_ALLOCATED_TAG))
> +       if (!(handle & tag))
>                 return false;
>
> -       *phandle = handle & ~OBJ_ALLOCATED_TAG;
> +       /* Clear all tags before returning the handle */
> +       *phandle = handle & ~OBJ_TAG_MASK;
>         return true;
>  }
>
> +static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
> +{
> +       return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
> +}
> +
> +#ifdef CONFIG_ZPOOL
> +static bool obj_stores_deferred_handle(struct page *page, void *obj,
> +               unsigned long *phandle)
> +{
> +       return obj_tagged(page, obj, phandle, OBJ_DEFERRED_HANDLE_TAG);
> +}
> +#endif
> +
>  static void reset_page(struct page *page)
>  {
>         __ClearPageMovable(page);
> @@ -946,22 +981,36 @@ static int trylock_zspage(struct zspage *zspage)
>  }
>
>  #ifdef CONFIG_ZPOOL
> +static unsigned long find_deferred_handle_obj(struct size_class *class,
> +               struct page *page, int *obj_idx);
> +
>  /*
>   * Free all the deferred handles whose objects are freed in zs_free.
>   */
> -static void free_handles(struct zs_pool *pool, struct zspage *zspage)
> +static void free_handles(struct zs_pool *pool, struct size_class *class,
> +               struct zspage *zspage)
>  {
> -       unsigned long handle = (unsigned long)zspage->deferred_handles;
> +       int obj_idx = 0;
> +       struct page *page = get_first_page(zspage);
> +       unsigned long handle;
>
> -       while (handle) {
> -               unsigned long nxt_handle = handle_to_obj(handle);
> +       while (1) {
> +               handle = find_deferred_handle_obj(class, page, &obj_idx);
> +               if (!handle) {
> +                       page = get_next_page(page);
> +                       if (!page)
> +                               break;
> +                       obj_idx = 0;
> +                       continue;
> +               }
>
>                 cache_free_handle(pool, handle);
> -               handle = nxt_handle;
> +               obj_idx++;
>         }
>  }
>  #else
> -static inline void free_handles(struct zs_pool *pool, struct zspage *zspage) {}
> +static inline void free_handles(struct zs_pool *pool, struct size_class *class,
> +               struct zspage *zspage) {}
>  #endif
>
>  static void __free_zspage(struct zs_pool *pool, struct size_class *class,
> @@ -979,7 +1028,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>         VM_BUG_ON(fg != ZS_EMPTY);
>
>         /* Free all deferred handles from zs_free */
> -       free_handles(pool, zspage);
> +       free_handles(pool, class, zspage);
>
>         next = page = get_first_page(zspage);
>         do {
> @@ -1067,7 +1116,6 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>  #ifdef CONFIG_ZPOOL
>         INIT_LIST_HEAD(&zspage->lru);
>         zspage->under_reclaim = false;
> -       zspage->deferred_handles = NULL;
>  #endif
>
>         set_freeobj(zspage, 0);
> @@ -1568,7 +1616,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(zs_malloc);
>
> -static void obj_free(int class_size, unsigned long obj)
> +static void obj_free(int class_size, unsigned long obj, unsigned long *handle)
>  {
>         struct link_free *link;
>         struct zspage *zspage;
> @@ -1582,15 +1630,29 @@ static void obj_free(int class_size, unsigned long obj)
>         zspage = get_zspage(f_page);
>
>         vaddr = kmap_atomic(f_page);
> -
> -       /* Insert this object in containing zspage's freelist */
>         link = (struct link_free *)(vaddr + f_offset);
> -       if (likely(!ZsHugePage(zspage)))
> -               link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
> -       else
> -               f_page->index = 0;
> +
> +       if (handle) {
> +#ifdef CONFIG_ZPOOL
> +               /* Stores the (deferred) handle in the object's header */
> +               *handle |= OBJ_DEFERRED_HANDLE_TAG;
> +               *handle &= ~OBJ_ALLOCATED_TAG;
> +
> +               if (likely(!ZsHugePage(zspage)))
> +                       link->deferred_handle = *handle;
> +               else
> +                       f_page->index = *handle;
> +#endif
> +       } else {
> +               /* Insert this object in containing zspage's freelist */
> +               if (likely(!ZsHugePage(zspage)))
> +                       link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
> +               else
> +                       f_page->index = 0;
> +               set_freeobj(zspage, f_objidx);
> +       }
> +
>         kunmap_atomic(vaddr);
> -       set_freeobj(zspage, f_objidx);
>         mod_zspage_inuse(zspage, -1);
>  }
>
> @@ -1615,7 +1677,6 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
>         zspage = get_zspage(f_page);
>         class = zspage_class(pool, zspage);
>
> -       obj_free(class->size, obj);
>         class_stat_dec(class, OBJ_USED, 1);
>
>  #ifdef CONFIG_ZPOOL
> @@ -1624,15 +1685,15 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
>                  * Reclaim needs the handles during writeback. It'll free
>                  * them along with the zspage when it's done with them.
>                  *
> -                * Record current deferred handle at the memory location
> -                * whose address is given by handle.
> +                * Record current deferred handle in the object's header.
>                  */
> -               record_obj(handle, (unsigned long)zspage->deferred_handles);
> -               zspage->deferred_handles = (unsigned long *)handle;
> +               obj_free(class->size, obj, &handle);
>                 spin_unlock(&pool->lock);
>                 return;
>         }
>  #endif
> +       obj_free(class->size, obj, NULL);
> +
>         fullness = fix_fullness_group(class, zspage);
>         if (fullness == ZS_EMPTY)
>                 free_zspage(pool, class, zspage);
> @@ -1713,11 +1774,11 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
>  }
>
>  /*
> - * Find alloced object in zspage from index object and
> + * Find object with a certain tag in zspage from index object and
>   * return handle.
>   */
> -static unsigned long find_alloced_obj(struct size_class *class,
> -                                       struct page *page, int *obj_idx)
> +static unsigned long find_tagged_obj(struct size_class *class,
> +                                       struct page *page, int *obj_idx, int tag)
>  {
>         unsigned int offset;
>         int index = *obj_idx;
> @@ -1728,7 +1789,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
>         offset += class->size * index;
>
>         while (offset < PAGE_SIZE) {
> -               if (obj_allocated(page, addr + offset, &handle))
> +               if (obj_tagged(page, addr + offset, &handle, tag))
>                         break;
>
>                 offset += class->size;
> @@ -1742,6 +1803,28 @@ static unsigned long find_alloced_obj(struct size_class *class,
>         return handle;
>  }
>
> +/*
> + * Find alloced object in zspage from index object and
> + * return handle.
> + */
> +static unsigned long find_alloced_obj(struct size_class *class,
> +                                       struct page *page, int *obj_idx)
> +{
> +       return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
> +}
> +
> +#ifdef CONFIG_ZPOOL
> +/*
> + * Find object storing a deferred handle in header in zspage from index object
> + * and return handle.
> + */
> +static unsigned long find_deferred_handle_obj(struct size_class *class,
> +               struct page *page, int *obj_idx)
> +{
> +       return find_tagged_obj(class, page, obj_idx, OBJ_DEFERRED_HANDLE_TAG);
> +}
> +#endif
> +
>  struct zs_compact_control {
>         /* Source spage for migration which could be a subpage of zspage */
>         struct page *s_page;
> @@ -1784,7 +1867,7 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
>                 zs_object_copy(class, free_obj, used_obj);
>                 obj_idx++;
>                 record_obj(handle, free_obj);
> -               obj_free(class->size, used_obj);
> +               obj_free(class->size, used_obj, NULL);
>         }
>
>         /* Remember last position in this iteration */
> @@ -2478,6 +2561,90 @@ void zs_destroy_pool(struct zs_pool *pool)
>  EXPORT_SYMBOL_GPL(zs_destroy_pool);
>
>  #ifdef CONFIG_ZPOOL
> +static void restore_freelist(struct zs_pool *pool, struct size_class *class,
> +               struct zspage *zspage)
> +{
> +       unsigned int obj_idx = 0;
> +       unsigned long handle, off = 0; /* off is within-page offset */
> +       struct page *page = get_first_page(zspage);
> +       struct link_free *prev_free = NULL;
> +       void *prev_page_vaddr = NULL;
> +
> +       /* in case no free object found */
> +       set_freeobj(zspage, (unsigned int)(-1UL));
> +
> +       while (page) {
> +               void *vaddr = kmap_atomic(page);
> +               struct page *next_page;
> +
> +               while (off < PAGE_SIZE) {
> +                       void *obj_addr = vaddr + off;
> +
> +                       /* skip allocated object */
> +                       if (obj_allocated(page, obj_addr, &handle)) {
> +                               obj_idx++;
> +                               off += class->size;
> +                               continue;
> +                       }
> +
> +                       /* free deferred handle from reclaim attempt */
> +                       if (obj_stores_deferred_handle(page, obj_addr, &handle))
> +                               cache_free_handle(pool, handle);
> +
> +                       if (prev_free)
> +                               prev_free->next = obj_idx << OBJ_TAG_BITS;
> +                       else /* first free object found */
> +                               set_freeobj(zspage, obj_idx);
> +
> +                       prev_free = (struct link_free *)vaddr + off / sizeof(*prev_free);
> +                       /* if last free object in a previous page, need to unmap */
> +                       if (prev_page_vaddr) {
> +                               kunmap_atomic(prev_page_vaddr);
> +                               prev_page_vaddr = NULL;
> +                       }
> +
> +                       obj_idx++;
> +                       off += class->size;
> +               }
> +
> +               /*
> +                * Handle the last (full or partial) object on this page.
> +                */
> +               next_page = get_next_page(page);
> +               if (next_page) {
> +                       if (!prev_free || prev_page_vaddr) {
> +                               /*
> +                                * There is no free object in this page, so we can safely
> +                                * unmap it.
> +                                */
> +                               kunmap_atomic(vaddr);
> +                       } else {
> +                               /* update prev_page_vaddr since prev_free is on this page */
> +                               prev_page_vaddr = vaddr;
> +                       }
> +               } else { /* this is the last page */
> +                       if (prev_free) {
> +                               /*
> +                                * Reset OBJ_TAG_BITS bit to last link to tell
> +                                * whether it's allocated object or not.
> +                                */
> +                               prev_free->next = -1UL << OBJ_TAG_BITS;
> +                       }
> +
> +                       /* unmap previous page (if not done yet) */
> +                       if (prev_page_vaddr) {
> +                               kunmap_atomic(prev_page_vaddr);
> +                               prev_page_vaddr = NULL;
> +                       }
> +
> +                       kunmap_atomic(vaddr);
> +               }
> +
> +               page = next_page;
> +               off %= PAGE_SIZE;
> +       }
> +}
> +
>  static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
>  {
>         int i, obj_idx, ret = 0;
> @@ -2561,6 +2728,12 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
>                         return 0;
>                 }
>
> +               /*
> +                * Eviction fails on one of the handles, so we need to restore zspage.
> +                * We need to rebuild its freelist (and free stored deferred handles),
> +                * put it back to the correct size class, and add it to the LRU list.
> +                */
> +               restore_freelist(pool, class, zspage);
>                 putback_zspage(class, zspage);
>                 list_add(&zspage->lru, &pool->lru);
>                 unlock_zspage(zspage);
> --
> 2.30.2
>
