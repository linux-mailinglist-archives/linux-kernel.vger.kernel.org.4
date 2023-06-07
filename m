Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AA7726729
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFGRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFGRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:23:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F021FC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:23:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-390723f815fso4057527b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686158631; x=1688750631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJV/t3eMTnpMjvvKxmxoYTbLUWGsad7w4TPfD5j+Agk=;
        b=AYnt6jFgFTJ7iv4rpwD3Utko/tgnxySc9U4xMczr6gGX5LekY2LKFwM0dCjoy/Um86
         XjA6KVCcFtHwIB7IAyVJAMLT1mvIBOd4mcL+1vSu0FpmkjuLX+33EZqTrh2uknaDMiY0
         BVWge3G+kBV0rTVtr4IApd8cqYWnUnkaveUT1ZA/Bh9Bk+5egkBz5RrwB9HnyBQZHqcF
         nYeRvY5KyT27lcYHTLKAvmD+RtkDVySAIbMY5o3V+3r507Ww9jVj4F+656G5Gi3Y17/Z
         GOFnCKXepCfotr2x2WODDfZXIddJnKMjwBp8iy2k0vrJwO5gyejerRmJn3ezVMCgAlS2
         jjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158631; x=1688750631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJV/t3eMTnpMjvvKxmxoYTbLUWGsad7w4TPfD5j+Agk=;
        b=ZG/Fmbh5veEzxgygTTQMsjkxACw5cVRLBaQm0XUMMg8VLHjLyXmLdmczXafmsx1vDN
         kFDponXlt+DzASb616zWjf2CkLBxuCVc/UGzmfQ4Vn5SCyVnY+fmUQ8KUNuE5WFNmYlh
         4MNIWj0N+HE8Jr8+MlaG1yAnbzHScuajfH77Qx4VjEKbUrAN0p6AVoowR6Y8TIuymoJ+
         hMfUZjiyw1VgHTf7MfoFe9RVXsvo9f4Kpghp985CvHKmIcI73NF1PE6f7fQ3rJ8axkt8
         AYx6b6rW/Gmh3BgeRXeR3StYfuJajK3oZeTFycahYXwLHZn69y6yPoIOIndJ9u20TF0R
         ECag==
X-Gm-Message-State: AC+VfDyrDaWGftdCB95shofm+qvXzah+QotPr58GCBEGqhGjMd0YWjkE
        sG8wLPHCld3dSkfU5/nmg3SEMrYRHSShSZEgQD0=
X-Google-Smtp-Source: ACHHUZ4kwq/svnMlUrx9P4jIkFQDD7mOtN7tXH2f42o/YdyG0tNCMUm08lvEsS/PuN7NMc7HIMnwogmanC6SsTsvXmw=
X-Received: by 2002:a05:6808:984:b0:39a:bd3b:9cb3 with SMTP id
 a4-20020a056808098400b0039abd3b9cb3mr3945155oic.23.1686158630655; Wed, 07 Jun
 2023 10:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <20230606145611.704392-5-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-5-cerasuolodomenico@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 7 Jun 2023 10:23:39 -0700
Message-ID: <CAKEwX=OMTqfqpZzQkUPRX4Nt33kJKsCdZ6RSERG_YPo+JXXjWw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/7] mm: zswap: remove page reclaim logic from zsmalloc
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> With the recent enhancement to zswap enabling direct page writeback, the
> need for the shrink code in zsmalloc has become obsolete. As a result,
> this commit removes the page reclaim logic from zsmalloc entirely.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zsmalloc.c | 393 ++------------------------------------------------
>  1 file changed, 13 insertions(+), 380 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 02f7f414aade..75386283dba0 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -107,21 +107,8 @@
>   */
>  #define OBJ_ALLOCATED_TAG 1
>
> -#ifdef CONFIG_ZPOOL
> -/*
> - * The second least-significant bit in the object's header identifies if=
 the
> - * value stored at the header is a deferred handle from the last reclaim
> - * attempt.
> - *
> - * As noted above, this is valid because we have room for two bits.
> - */
> -#define OBJ_DEFERRED_HANDLE_TAG        2
> -#define OBJ_TAG_BITS   2
> -#define OBJ_TAG_MASK   (OBJ_ALLOCATED_TAG | OBJ_DEFERRED_HANDLE_TAG)
> -#else
>  #define OBJ_TAG_BITS   1
>  #define OBJ_TAG_MASK   OBJ_ALLOCATED_TAG
> -#endif /* CONFIG_ZPOOL */
>
>  #define OBJ_INDEX_BITS (BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK ((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
> @@ -227,12 +214,6 @@ struct link_free {
>                  * Handle of allocated object.
>                  */
>                 unsigned long handle;
> -#ifdef CONFIG_ZPOOL
> -               /*
> -                * Deferred handle of a reclaimed object.
> -                */
> -               unsigned long deferred_handle;
> -#endif
>         };
>  };
>
> @@ -250,13 +231,6 @@ struct zs_pool {
>         /* Compact classes */
>         struct shrinker shrinker;
>
> -#ifdef CONFIG_ZPOOL
> -       /* List tracking the zspages in LRU order by most recently added =
object */
> -       struct list_head lru;
> -       struct zpool *zpool;
> -       const struct zpool_ops *zpool_ops;
> -#endif
> -
>  #ifdef CONFIG_ZSMALLOC_STAT
>         struct dentry *stat_dentry;
>  #endif
> @@ -279,13 +253,6 @@ struct zspage {
>         unsigned int freeobj;
>         struct page *first_page;
>         struct list_head list; /* fullness list */
> -
> -#ifdef CONFIG_ZPOOL
> -       /* links the zspage to the lru list in the pool */
> -       struct list_head lru;
> -       bool under_reclaim;
> -#endif
> -
>         struct zs_pool *pool;
>         rwlock_t lock;
>  };
> @@ -393,14 +360,7 @@ static void *zs_zpool_create(const char *name, gfp_t=
 gfp,
>          * different contexts and its caller must provide a valid
>          * gfp mask.
>          */
> -       struct zs_pool *pool =3D zs_create_pool(name);
> -
> -       if (pool) {
> -               pool->zpool =3D zpool;
> -               pool->zpool_ops =3D zpool_ops;
> -       }
> -
> -       return pool;
> +       return zs_create_pool(name);
>  }
>
>  static void zs_zpool_destroy(void *pool)
> @@ -422,27 +382,6 @@ static void zs_zpool_free(void *pool, unsigned long =
handle)
>         zs_free(pool, handle);
>  }
>
> -static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
> -
> -static int zs_zpool_shrink(void *pool, unsigned int pages,
> -                       unsigned int *reclaimed)
> -{
> -       unsigned int total =3D 0;
> -       int ret =3D -EINVAL;
> -
> -       while (total < pages) {
> -               ret =3D zs_reclaim_page(pool, 8);
> -               if (ret < 0)
> -                       break;
> -               total++;
> -       }
> -
> -       if (reclaimed)
> -               *reclaimed =3D total;
> -
> -       return ret;
> -}
> -
>  static void *zs_zpool_map(void *pool, unsigned long handle,
>                         enum zpool_mapmode mm)
>  {
> @@ -481,7 +420,7 @@ static struct zpool_driver zs_zpool_driver =3D {
>         .malloc_support_movable =3D true,
>         .malloc =3D                 zs_zpool_malloc,
>         .free =3D                   zs_zpool_free,
> -       .shrink =3D                 zs_zpool_shrink,
> +       .shrink =3D                 NULL,
>         .map =3D                    zs_zpool_map,
>         .unmap =3D                  zs_zpool_unmap,
>         .total_size =3D             zs_zpool_total_size,
> @@ -884,14 +823,6 @@ static inline bool obj_allocated(struct page *page, =
void *obj, unsigned long *ph
>         return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
>  }
>
> -#ifdef CONFIG_ZPOOL
> -static bool obj_stores_deferred_handle(struct page *page, void *obj,
> -               unsigned long *phandle)
> -{
> -       return obj_tagged(page, obj, phandle, OBJ_DEFERRED_HANDLE_TAG);
> -}
> -#endif
> -
>  static void reset_page(struct page *page)
>  {
>         __ClearPageMovable(page);
> @@ -922,39 +853,6 @@ static int trylock_zspage(struct zspage *zspage)
>         return 0;
>  }
>
> -#ifdef CONFIG_ZPOOL
> -static unsigned long find_deferred_handle_obj(struct size_class *class,
> -               struct page *page, int *obj_idx);
> -
> -/*
> - * Free all the deferred handles whose objects are freed in zs_free.
> - */
> -static void free_handles(struct zs_pool *pool, struct size_class *class,
> -               struct zspage *zspage)
> -{
> -       int obj_idx =3D 0;
> -       struct page *page =3D get_first_page(zspage);
> -       unsigned long handle;
> -
> -       while (1) {
> -               handle =3D find_deferred_handle_obj(class, page, &obj_idx=
);
> -               if (!handle) {
> -                       page =3D get_next_page(page);
> -                       if (!page)
> -                               break;
> -                       obj_idx =3D 0;
> -                       continue;
> -               }
> -
> -               cache_free_handle(pool, handle);
> -               obj_idx++;
> -       }
> -}
> -#else
> -static inline void free_handles(struct zs_pool *pool, struct size_class =
*class,
> -               struct zspage *zspage) {}
> -#endif
> -
>  static void __free_zspage(struct zs_pool *pool, struct size_class *class=
,
>                                 struct zspage *zspage)
>  {
> @@ -969,9 +867,6 @@ static void __free_zspage(struct zs_pool *pool, struc=
t size_class *class,
>         VM_BUG_ON(get_zspage_inuse(zspage));
>         VM_BUG_ON(fg !=3D ZS_INUSE_RATIO_0);
>
> -       /* Free all deferred handles from zs_free */
> -       free_handles(pool, class, zspage);
> -
>         next =3D page =3D get_first_page(zspage);
>         do {
>                 VM_BUG_ON_PAGE(!PageLocked(page), page);
> @@ -1006,9 +901,6 @@ static void free_zspage(struct zs_pool *pool, struct=
 size_class *class,
>         }
>
>         remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
> -#ifdef CONFIG_ZPOOL
> -       list_del(&zspage->lru);
> -#endif
>         __free_zspage(pool, class, zspage);
>  }
>
> @@ -1054,11 +946,6 @@ static void init_zspage(struct size_class *class, s=
truct zspage *zspage)
>                 off %=3D PAGE_SIZE;
>         }
>
> -#ifdef CONFIG_ZPOOL
> -       INIT_LIST_HEAD(&zspage->lru);
> -       zspage->under_reclaim =3D false;
> -#endif
> -
>         set_freeobj(zspage, 0);
>  }
>
> @@ -1525,20 +1412,13 @@ unsigned long zs_malloc(struct zs_pool *pool, siz=
e_t size, gfp_t gfp)
>         /* We completely set up zspage so mark them as movable */
>         SetZsPageMovable(pool, zspage);
>  out:
> -#ifdef CONFIG_ZPOOL
> -       /* Add/move zspage to beginning of LRU */
> -       if (!list_empty(&zspage->lru))
> -               list_del(&zspage->lru);
> -       list_add(&zspage->lru, &pool->lru);
> -#endif
> -
>         spin_unlock(&pool->lock);
>
>         return handle;
>  }
>  EXPORT_SYMBOL_GPL(zs_malloc);
>
> -static void obj_free(int class_size, unsigned long obj, unsigned long *h=
andle)
> +static void obj_free(int class_size, unsigned long obj)
>  {
>         struct link_free *link;
>         struct zspage *zspage;
> @@ -1554,25 +1434,12 @@ static void obj_free(int class_size, unsigned lon=
g obj, unsigned long *handle)
>         vaddr =3D kmap_atomic(f_page);
>         link =3D (struct link_free *)(vaddr + f_offset);
>
> -       if (handle) {
> -#ifdef CONFIG_ZPOOL
> -               /* Stores the (deferred) handle in the object's header */
> -               *handle |=3D OBJ_DEFERRED_HANDLE_TAG;
> -               *handle &=3D ~OBJ_ALLOCATED_TAG;
> -
> -               if (likely(!ZsHugePage(zspage)))
> -                       link->deferred_handle =3D *handle;
> -               else
> -                       f_page->index =3D *handle;
> -#endif
> -       } else {
> -               /* Insert this object in containing zspage's freelist */
> -               if (likely(!ZsHugePage(zspage)))
> -                       link->next =3D get_freeobj(zspage) << OBJ_TAG_BIT=
S;
> -               else
> -                       f_page->index =3D 0;
> -               set_freeobj(zspage, f_objidx);
> -       }
> +       /* Insert this object in containing zspage's freelist */
> +       if (likely(!ZsHugePage(zspage)))
> +               link->next =3D get_freeobj(zspage) << OBJ_TAG_BITS;
> +       else
> +               f_page->index =3D 0;
> +       set_freeobj(zspage, f_objidx);
>
>         kunmap_atomic(vaddr);
>         mod_zspage_inuse(zspage, -1);
> @@ -1600,21 +1467,7 @@ void zs_free(struct zs_pool *pool, unsigned long h=
andle)
>         class =3D zspage_class(pool, zspage);
>
>         class_stat_dec(class, ZS_OBJS_INUSE, 1);
> -
> -#ifdef CONFIG_ZPOOL
> -       if (zspage->under_reclaim) {
> -               /*
> -                * Reclaim needs the handles during writeback. It'll free
> -                * them along with the zspage when it's done with them.
> -                *
> -                * Record current deferred handle in the object's header.
> -                */
> -               obj_free(class->size, obj, &handle);
> -               spin_unlock(&pool->lock);
> -               return;
> -       }
> -#endif
> -       obj_free(class->size, obj, NULL);
> +       obj_free(class->size, obj);
>
>         fullness =3D fix_fullness_group(class, zspage);
>         if (fullness =3D=3D ZS_INUSE_RATIO_0)
> @@ -1735,18 +1588,6 @@ static unsigned long find_alloced_obj(struct size_=
class *class,
>         return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
>  }
>
> -#ifdef CONFIG_ZPOOL
> -/*
> - * Find object storing a deferred handle in header in zspage from index =
object
> - * and return handle.
> - */
> -static unsigned long find_deferred_handle_obj(struct size_class *class,
> -               struct page *page, int *obj_idx)
> -{
> -       return find_tagged_obj(class, page, obj_idx, OBJ_DEFERRED_HANDLE_=
TAG);
> -}
> -#endif
> -
>  struct zs_compact_control {
>         /* Source spage for migration which could be a subpage of zspage =
*/
>         struct page *s_page;
> @@ -1786,7 +1627,7 @@ static void migrate_zspage(struct zs_pool *pool, st=
ruct size_class *class,
>                 zs_object_copy(class, free_obj, used_obj);
>                 obj_idx++;
>                 record_obj(handle, free_obj);
> -               obj_free(class->size, used_obj, NULL);
> +               obj_free(class->size, used_obj);
>         }
>
>         /* Remember last position in this iteration */
> @@ -1846,7 +1687,7 @@ static int putback_zspage(struct size_class *class,=
 struct zspage *zspage)
>         return fullness;
>  }
>
> -#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
> +#ifdef CONFIG_COMPACTION
>  /*
>   * To prevent zspage destroy during migration, zspage freeing should
>   * hold locks of all pages in the zspage.
> @@ -1888,24 +1729,7 @@ static void lock_zspage(struct zspage *zspage)
>         }
>         migrate_read_unlock(zspage);
>  }
> -#endif /* defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION) */
> -
> -#ifdef CONFIG_ZPOOL
> -/*
> - * Unlocks all the pages of the zspage.
> - *
> - * pool->lock must be held before this function is called
> - * to prevent the underlying pages from migrating.
> - */
> -static void unlock_zspage(struct zspage *zspage)
> -{
> -       struct page *page =3D get_first_page(zspage);
> -
> -       do {
> -               unlock_page(page);
> -       } while ((page =3D get_next_page(page)) !=3D NULL);
> -}
> -#endif /* CONFIG_ZPOOL */
> +#endif /* CONFIG_COMPACTION */
>
>  static void migrate_lock_init(struct zspage *zspage)
>  {
> @@ -2126,9 +1950,6 @@ static void async_free_zspage(struct work_struct *w=
ork)
>                 VM_BUG_ON(fullness !=3D ZS_INUSE_RATIO_0);
>                 class =3D pool->size_class[class_idx];
>                 spin_lock(&pool->lock);
> -#ifdef CONFIG_ZPOOL
> -               list_del(&zspage->lru);
> -#endif
>                 __free_zspage(pool, class, zspage);
>                 spin_unlock(&pool->lock);
>         }
> @@ -2474,10 +2295,6 @@ struct zs_pool *zs_create_pool(const char *name)
>          */
>         zs_register_shrinker(pool);
>
> -#ifdef CONFIG_ZPOOL
> -       INIT_LIST_HEAD(&pool->lru);
> -#endif
> -
>         return pool;
>
>  err:
> @@ -2520,190 +2337,6 @@ void zs_destroy_pool(struct zs_pool *pool)
>  }
>  EXPORT_SYMBOL_GPL(zs_destroy_pool);
>
> -#ifdef CONFIG_ZPOOL
> -static void restore_freelist(struct zs_pool *pool, struct size_class *cl=
ass,
> -               struct zspage *zspage)
> -{
> -       unsigned int obj_idx =3D 0;
> -       unsigned long handle, off =3D 0; /* off is within-page offset */
> -       struct page *page =3D get_first_page(zspage);
> -       struct link_free *prev_free =3D NULL;
> -       void *prev_page_vaddr =3D NULL;
> -
> -       /* in case no free object found */
> -       set_freeobj(zspage, (unsigned int)(-1UL));
> -
> -       while (page) {
> -               void *vaddr =3D kmap_atomic(page);
> -               struct page *next_page;
> -
> -               while (off < PAGE_SIZE) {
> -                       void *obj_addr =3D vaddr + off;
> -
> -                       /* skip allocated object */
> -                       if (obj_allocated(page, obj_addr, &handle)) {
> -                               obj_idx++;
> -                               off +=3D class->size;
> -                               continue;
> -                       }
> -
> -                       /* free deferred handle from reclaim attempt */
> -                       if (obj_stores_deferred_handle(page, obj_addr, &h=
andle))
> -                               cache_free_handle(pool, handle);
> -
> -                       if (prev_free)
> -                               prev_free->next =3D obj_idx << OBJ_TAG_BI=
TS;
> -                       else /* first free object found */
> -                               set_freeobj(zspage, obj_idx);
> -
> -                       prev_free =3D (struct link_free *)vaddr + off / s=
izeof(*prev_free);
> -                       /* if last free object in a previous page, need t=
o unmap */
> -                       if (prev_page_vaddr) {
> -                               kunmap_atomic(prev_page_vaddr);
> -                               prev_page_vaddr =3D NULL;
> -                       }
> -
> -                       obj_idx++;
> -                       off +=3D class->size;
> -               }
> -
> -               /*
> -                * Handle the last (full or partial) object on this page.
> -                */
> -               next_page =3D get_next_page(page);
> -               if (next_page) {
> -                       if (!prev_free || prev_page_vaddr) {
> -                               /*
> -                                * There is no free object in this page, =
so we can safely
> -                                * unmap it.
> -                                */
> -                               kunmap_atomic(vaddr);
> -                       } else {
> -                               /* update prev_page_vaddr since prev_free=
 is on this page */
> -                               prev_page_vaddr =3D vaddr;
> -                       }
> -               } else { /* this is the last page */
> -                       if (prev_free) {
> -                               /*
> -                                * Reset OBJ_TAG_BITS bit to last link to=
 tell
> -                                * whether it's allocated object or not.
> -                                */
> -                               prev_free->next =3D -1UL << OBJ_TAG_BITS;
> -                       }
> -
> -                       /* unmap previous page (if not done yet) */
> -                       if (prev_page_vaddr) {
> -                               kunmap_atomic(prev_page_vaddr);
> -                               prev_page_vaddr =3D NULL;
> -                       }
> -
> -                       kunmap_atomic(vaddr);
> -               }
> -
> -               page =3D next_page;
> -               off %=3D PAGE_SIZE;
> -       }
> -}
> -
> -static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> -{
> -       int i, obj_idx, ret =3D 0;
> -       unsigned long handle;
> -       struct zspage *zspage;
> -       struct page *page;
> -       int fullness;
> -
> -       /* Lock LRU and fullness list */
> -       spin_lock(&pool->lock);
> -       if (list_empty(&pool->lru)) {
> -               spin_unlock(&pool->lock);
> -               return -EINVAL;
> -       }
> -
> -       for (i =3D 0; i < retries; i++) {
> -               struct size_class *class;
> -
> -               zspage =3D list_last_entry(&pool->lru, struct zspage, lru=
);
> -               list_del(&zspage->lru);
> -
> -               /* zs_free may free objects, but not the zspage and handl=
es */
> -               zspage->under_reclaim =3D true;
> -
> -               class =3D zspage_class(pool, zspage);
> -               fullness =3D get_fullness_group(class, zspage);
> -
> -               /* Lock out object allocations and object compaction */
> -               remove_zspage(class, zspage, fullness);
> -
> -               spin_unlock(&pool->lock);
> -               cond_resched();
> -
> -               /* Lock backing pages into place */
> -               lock_zspage(zspage);
> -
> -               obj_idx =3D 0;
> -               page =3D get_first_page(zspage);
> -               while (1) {
> -                       handle =3D find_alloced_obj(class, page, &obj_idx=
);
> -                       if (!handle) {
> -                               page =3D get_next_page(page);
> -                               if (!page)
> -                                       break;
> -                               obj_idx =3D 0;
> -                               continue;
> -                       }
> -
> -                       /*
> -                        * This will write the object and call zs_free.
> -                        *
> -                        * zs_free will free the object, but the
> -                        * under_reclaim flag prevents it from freeing
> -                        * the zspage altogether. This is necessary so
> -                        * that we can continue working with the
> -                        * zspage potentially after the last object
> -                        * has been freed.
> -                        */
> -                       ret =3D pool->zpool_ops->evict(pool->zpool, handl=
e);
> -                       if (ret)
> -                               goto next;
> -
> -                       obj_idx++;
> -               }
> -
> -next:
> -               /* For freeing the zspage, or putting it back in the pool=
 and LRU list. */
> -               spin_lock(&pool->lock);
> -               zspage->under_reclaim =3D false;
> -
> -               if (!get_zspage_inuse(zspage)) {
> -                       /*
> -                        * Fullness went stale as zs_free() won't touch i=
t
> -                        * while the page is removed from the pool. Fix i=
t
> -                        * up for the check in __free_zspage().
> -                        */
> -                       zspage->fullness =3D ZS_INUSE_RATIO_0;
> -
> -                       __free_zspage(pool, class, zspage);
> -                       spin_unlock(&pool->lock);
> -                       return 0;
> -               }
> -
> -               /*
> -                * Eviction fails on one of the handles, so we need to re=
store zspage.
> -                * We need to rebuild its freelist (and free stored defer=
red handles),
> -                * put it back to the correct size class, and add it to t=
he LRU list.
> -                */
> -               restore_freelist(pool, class, zspage);
> -               putback_zspage(class, zspage);
> -               list_add(&zspage->lru, &pool->lru);
> -               unlock_zspage(zspage);
> -       }
> -
> -       spin_unlock(&pool->lock);
> -       return -EAGAIN;
> -}
> -#endif /* CONFIG_ZPOOL */
> -
>  static int __init zs_init(void)
>  {
>         int ret;
> --
> 2.34.1
>

LGTM! Thanks for the clean-up, Domenico.
Acked-by: Nhat Pham <nphamcs@gmail.com>
