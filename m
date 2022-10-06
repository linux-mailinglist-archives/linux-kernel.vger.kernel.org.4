Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75895F6DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJFSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiJFSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:43:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E2C511A;
        Thu,  6 Oct 2022 11:43:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l1so2463243pld.13;
        Thu, 06 Oct 2022 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WP+EI4SSCkM2swdzFsOehVVg2VMMJeFZlUzZRWJA3M8=;
        b=qc0KJ3/x74ihpVCej061hRiFy6p5TTrh2/2Sj41HFDDpKdF0fDVXemlSgbC2SY1Es5
         tTVSBicpra1PmxG2W6lKLupqPJFOBg2W7MdlTACU7BxrE3H+VhSpVyCqAWKKeIpZrH5p
         rjZZ1B0bZ+9krKpqz9cCSUYUJgwkZmP876oQVuOcrGtGMysTZXjaDMBJKJb93Rf7FhJ2
         JkKkrLuO4o8rIViHk1ykSExLN8I5ChiNTlvfsHPUhUY6n4Rn6d5x87HGUXZ7MIhG9OHF
         Jq9XTPc3Z/4ljVkcGkbGcluAmD/hGknxTJkA4X6Xat/29YC4oyRSZQGA8wCipn244wNt
         YxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP+EI4SSCkM2swdzFsOehVVg2VMMJeFZlUzZRWJA3M8=;
        b=oF7wtVNiCJdoTAYGYi/1BouALQmgLGhnieOUgDZxJCPsECzRTuivfiZJOlvqQ0C5wN
         FvhSGlUH7tCeysTGzoci1VDDJGEtZ8ZHsR3KIvZtpARwYYUrw6BP/tXXy5jnrcZCsAVO
         LWWELTcHPyS902AJUMbAzCW1V4RLeJHKB2Q6sTB/T7g3T7nCaEJ1AzPb0t/YWABt0Cv1
         ZrbClitJaMEkm0Pu1QMT/IJZjJtxibrTT0cjRVGyKb8Mneo1mfrFLAevbbg4CERxprH2
         91AokBC/Wy52n6ox/De163OlcNpaiCuVnGjUd452LwP2Gx1smV7L1IRxsM6ylJ0qqLeF
         JORg==
X-Gm-Message-State: ACrzQf3610rutmlTWOExpEBMeobTq6uWBQPx6IJFjBJ7A1QHkbJWScOa
        0MOpY06+k64YSF/cYD5cP0dGG13ep8IcpaByB3c=
X-Google-Smtp-Source: AMsMyM5R7Z42TNNA1tMYIegVXcP07NIU1oHEmI3BRNLHVLakFg15TMdvprayB+SwHTUk4MLp83RzkNpprXxB9P+6afI=
X-Received: by 2002:a17:903:41d2:b0:17d:707a:3618 with SMTP id
 u18-20020a17090341d200b0017d707a3618mr755584ple.61.1665081813669; Thu, 06 Oct
 2022 11:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221005180341.1738796-1-shy828301@gmail.com> <20221005180341.1738796-3-shy828301@gmail.com>
 <Yz7qeI0s6TjSEIFe@bfoster>
In-Reply-To: <Yz7qeI0s6TjSEIFe@bfoster>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 6 Oct 2022 11:43:21 -0700
Message-ID: <CAHbLzkprAJFApT8hK5z8MB8Xc4Kq6ZDTXJRByujQNEgcvo5TgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
To:     Brian Foster <bfoster@redhat.com>
Cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 7:47 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> > Since v5.13 the page bulk allocator was introduced to allocate order-0
> > pages in bulk.  There are a few mempool allocator callers which does
> > order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> > etc.  A mempool page bulk allocator seems useful.  So introduce the
> > mempool page bulk allocator.
> >
> > It introduces the below APIs:
> >   - mempool_init_pages_bulk()
> >   - mempool_create_pages_bulk()
> > They initialize the mempool for page bulk allocator.  The pool is filled
> > by alloc_page() in a loop.
> >
> >   - mempool_alloc_pages_bulk_list()
> >   - mempool_alloc_pages_bulk_array()
> > They do bulk allocation from mempool.
> > They do the below conceptually:
> >   1. Call bulk page allocator
> >   2. If the allocation is fulfilled then return otherwise try to
> >      allocate the remaining pages from the mempool
> >   3. If it is fulfilled then return otherwise retry from #1 with sleepable
> >      gfp
> >   4. If it is still failed, sleep for a while to wait for the mempool is
> >      refilled, then retry from #1
> > The populated pages will stay on the list or array until the callers
> > consume them or free them.
> > Since mempool allocator is guaranteed to success in the sleepable context,
> > so the two APIs return true for success or false for fail.  It is the
> > caller's responsibility to handle failure case (partial allocation), just
> > like the page bulk allocator.
> >
> > The mempool typically is an object agnostic allocator, but bulk allocation
> > is only supported by pages, so the mempool bulk allocator is for page
> > allocation only as well.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
>
> Hi Yang,
>
> I'm not terribly familiar with either component so I'm probably missing
> context/details, but just a couple high level thoughts when reading your
> patches...
>
> >  include/linux/mempool.h |  19 ++++
> >  mm/mempool.c            | 188 +++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 197 insertions(+), 10 deletions(-)
> >
> ...
> > diff --git a/mm/mempool.c b/mm/mempool.c
> > index ba32151f3843..7711ca2e6d66 100644
> > --- a/mm/mempool.c
> > +++ b/mm/mempool.c
> > @@ -177,6 +177,7 @@ void mempool_destroy(mempool_t *pool)
> >  EXPORT_SYMBOL(mempool_destroy);
> >
> >  static inline int __mempool_init(mempool_t *pool, int min_nr,
> > +                              mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
> >                                mempool_alloc_t *alloc_fn,
> >                                mempool_free_t *free_fn, void *pool_data,
> >                                gfp_t gfp_mask, int node_id)
> > @@ -186,8 +187,11 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
> >       pool->pool_data = pool_data;
> >       pool->alloc     = alloc_fn;
> >       pool->free      = free_fn;
> > +     pool->alloc_pages_bulk = alloc_pages_bulk_fn;
> >       init_waitqueue_head(&pool->wait);
> >
> > +     WARN_ON_ONCE(alloc_pages_bulk_fn && alloc_fn);
> > +
> >       pool->elements = kmalloc_array_node(min_nr, sizeof(void *),
> >                                           gfp_mask, node_id);
> >       if (!pool->elements)
> > @@ -199,7 +203,10 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
> >       while (pool->curr_nr < pool->min_nr) {
> >               void *element;
> >
> > -             element = pool->alloc(gfp_mask, pool->pool_data);
> > +             if (pool->alloc_pages_bulk)
> > +                     element = alloc_page(gfp_mask);
>
> Any reason to not use the callback from the caller for the bulk variant
> here? It looks like some users might expect consistency between the
> alloc / free callbacks for the pool. I.e., I'm not familiar with
> dm-crypt, but the code modified in the subsequent patches looks like it
> keeps an allocated page count. Will that still work with this, assuming
> these pages are freed through free_fn?

No special reason, this implementation just end up with fewer code
otherwise we should need to define a list, and manipulate the list,
seems like a little bit overkilling for initialization code.

Yes, that allocated page count works, just the pages in the pool are
not counted in the count anymore, 256 pages should be not a big deal
IMHO.

>
> > +             else
> > +                     element = pool->alloc(gfp_mask, pool->pool_data);
> >               if (unlikely(!element)) {
> >                       mempool_exit(pool);
> >                       return -ENOMEM;
> ...
> > @@ -457,6 +499,132 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
> >  }
> >  EXPORT_SYMBOL(mempool_alloc);
> >
> > +/**
> > + * mempool_alloc_pages_bulk - allocate a bulk of pagesfrom a specific
> > + *                           memory pool
> > + * @pool:       pointer to the memory pool which was allocated via
> > + *              mempool_create().
> > + * @gfp_mask:   the usual allocation bitmask.
> > + * @nr:         the number of requested pages.
> > + * @page_list:  the list the pages will be added to.
> > + * @page_array: the array the pages will be added to.
> > + *
> > + * this function only sleeps if the alloc_pages_bulk_fn() function sleeps
> > + * or the allocation can not be satisfied even though the mempool is depleted.
> > + * Note that due to preallocation, this function *never* fails when called
> > + * from process contexts. (it might fail if called from an IRQ context.)
> > + * Note: using __GFP_ZERO is not supported.  And the caller should not pass
> > + * in both valid page_list and page_array.
> > + *
> > + * Return: true when nr pages are allocated or false if not.  It is the
> > + *         caller's responsibility to free the partial allocated pages.
> > + */
> > +static bool mempool_alloc_pages_bulk(mempool_t *pool, gfp_t gfp_mask,
> > +                                  unsigned int nr,
> > +                                  struct list_head *page_list,
> > +                                  struct page **page_array)
> > +{
> > +     unsigned long flags;
> > +     wait_queue_entry_t wait;
> > +     gfp_t gfp_temp;
> > +     int i;
> > +     unsigned int ret, nr_remaining;
> > +     struct page *page;
> > +
>
> This looks like a lot of duplicate boilerplate from mempool_alloc().
> Could this instead do something like: rename the former to
> __mempool_alloc() and add a count parameter, implement bulk alloc
> support in there for count > 1, then let traditional (i.e., non-bulk)
> mempool_alloc() callers pass a count of 1?

Thanks for the suggestion. Yeah, the duplicate code is not perfect. I
thought about this way too, but it may need to have a lot of "if
(count > 0)" of "if (is_bulk_alloc) " if a flag is used in the code to
handle the bulk allocation, for example, calculate remaining nr, loop
to remove element from the pool, manipulate list or array, etc. Seems
not that readable IMHO.

We may be able to extract some common code into shared helpers, for
example, the gfp sanitization and wait logic.

>
> Along the same lines, I also wonder if there's any value in generic bulk
> alloc support for mempool. For example, I suppose technically this could
> be implemented via one change to support a pool->alloc_bulk() callback
> that any user could implement via a loop if they wanted
> mempool_alloc_bulk() support backed by a preallocated pool. The page
> based user could then just use that to call alloc_pages_bulk_*() as an
> optimization without the mempool layer needing to know or care about
> whether the underlying elements are pages or not. Hm?

Thanks for the suggestion. Actually I thought about this too. But the
memory space overhead, particularly stack space seems like a
showstopper to me. We just can put the pointers into an array, but
this may consume a significant amount of stack memory. One pointer is
8 bytes, 256 objects imply 2K stack space. Of course the users could
move the array into a dynamic allocated data structure, but this may
need the users modify their driver. Bulk kmalloc via kmalloc_array()
may be fine, this is the only usercase other than pages I could think
of.

>
> Brian
>
> > +     VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
> > +     might_alloc(gfp_mask);
> > +
> > +     gfp_mask |= __GFP_NOMEMALLOC;   /* don't allocate emergency reserves */
> > +     gfp_mask |= __GFP_NORETRY;      /* don't loop in __alloc_pages */
> > +     gfp_mask |= __GFP_NOWARN;       /* failures are OK */
> > +
> > +     gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
> > +
> > +repeat_alloc:
> > +     i = 0;
> > +     ret = pool->alloc_pages_bulk(gfp_temp, nr, pool->pool_data, page_list,
> > +                                  page_array);
> > +
> > +     if (ret == nr)
> > +             return true;
> > +
> > +     nr_remaining = nr - ret;
> > +
> > +     spin_lock_irqsave(&pool->lock, flags);
> > +     /* Allocate page from the pool and add to the list or array */
> > +     while (pool->curr_nr && (nr_remaining > 0)) {
> > +             page = remove_element(pool);
> > +             spin_unlock_irqrestore(&pool->lock, flags);
> > +             smp_wmb();
> > +
> > +             kmemleak_update_trace((void *)page);
> > +
> > +             if (page_list)
> > +                     list_add(&page->lru, page_list);
> > +             else
> > +                     page_array[ret + i] = page;
> > +
> > +             i++;
> > +             nr_remaining--;
> > +
> > +             spin_lock_irqsave(&pool->lock, flags);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&pool->lock, flags);
> > +
> > +     if (!nr_remaining)
> > +             return true;
> > +
> > +     /*
> > +      * The bulk allocator counts in the populated pages for array,
> > +      * but don't do it for list.
> > +      */
> > +     if (page_list)
> > +             nr = nr_remaining;
> > +
> > +     /*
> > +      * We use gfp mask w/o direct reclaim or IO for the first round.  If
> > +      * alloc failed with that and @pool was empty, retry immediately.
> > +      */
> > +     if (gfp_temp != gfp_mask) {
> > +             gfp_temp = gfp_mask;
> > +             goto repeat_alloc;
> > +     }
> > +
> > +     /* We must not sleep if !__GFP_DIRECT_RECLAIM */
> > +     if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
> > +             return false;
> > +
> > +     /* Let's wait for someone else to return an element to @pool */
> > +     init_wait(&wait);
> > +     prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
> > +
> > +     /*
> > +      * FIXME: this should be io_schedule().  The timeout is there as a
> > +      * workaround for some DM problems in 2.6.18.
> > +      */
> > +     io_schedule_timeout(5*HZ);
> > +
> > +     finish_wait(&pool->wait, &wait);
> > +     goto repeat_alloc;
> > +}
> > +
> > +bool mempool_alloc_pages_bulk_list(mempool_t *pool, gfp_t gfp_mask,
> > +                                unsigned int nr,
> > +                                struct list_head *page_list)
> > +{
> > +     return mempool_alloc_pages_bulk(pool, gfp_mask, nr, page_list, NULL);
> > +}
> > +EXPORT_SYMBOL(mempool_alloc_pages_bulk_list);
> > +
> > +bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
> > +                                 unsigned int nr,
> > +                                 struct page **page_array)
> > +{
> > +     return mempool_alloc_pages_bulk(pool, gfp_mask, nr, NULL, page_array);
> > +}
> > +EXPORT_SYMBOL(mempool_alloc_pages_bulk_array);
> > +
> >  /**
> >   * mempool_free - return an element to the pool.
> >   * @element:   pool element pointer.
> > --
> > 2.26.3
> >
>
