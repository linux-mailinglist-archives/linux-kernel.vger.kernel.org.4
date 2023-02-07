Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACA768CBA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBGBDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBGBC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:02:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4FC3A88
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:02:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mf7so39284544ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eI0E0KfbMh1tl/kmihqYOety3/NlUN0gS/GZJiIqWAc=;
        b=dwGb1aIm+zlsS2i/YRAeWgSi4quFVIikHWPJSIyAQmhXDsg5Sox302oOpZpV8IOpzY
         fAbAUeGMiLn5N7Ez3thWAwxKvj/tFe/vjrqFuD/0YxC9yq5g4R4Thh4TVxfU2RpmYO1K
         q8C2k70kll0TiscAlJShqc7rswaKgIEMjC9//YXniWYGccQbtpLv4fti//yXYb0ZN1mZ
         U4XkqISP7viv7SKUY556jBo4CB9e60xEOOZuYD6UZ8cjJLAZ0Ft7ofhFV+2S8YnnniJy
         N5bgYg1VRPAJXsxq/qV9Dcxwvw0bwKgRAdbEyJ06OzFMmTzObKSk32N2D20ljx2hiZGR
         qIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI0E0KfbMh1tl/kmihqYOety3/NlUN0gS/GZJiIqWAc=;
        b=2is9+B3oKi3BIqo3TKoMJcnlPQaWRgOihk5BPI60YbKpV/Ef4pYJN2GcY96az9r/O5
         lghy99VPsBubKVt3ttsz4tg+Y8eCwhOcZLricwdtQshVCpY72U82cBr1ICW99e1MIIHi
         +61MzKwAlqRBn+fDwDlZte5X9seKj4q9iRYPK05JjHSnTq4cjIObAYn231g1oi5fQXhr
         RT8/NZRuLd/jGH2pk6iP2g0ZSJ03B9wImmvvE5X6PbKPZxad6qCUuCjPkOyyQhZzpbtJ
         QwdUHVcTmWLHCfrD1rHIbnJFfWUPA21mlxUhIk71Iwt1KzpkN8OfAvoD8E3bE9hpWCnr
         kOaQ==
X-Gm-Message-State: AO0yUKX9LK7y5m9mVnKAk7roRhJgGF67hkoIALFL/vcC3dRM/wUfbWHq
        U91CanuE+xrVaJMI18c3aB7SexxJ678WIEFenidX3Q==
X-Google-Smtp-Source: AK7set83JGcXC2wJde+/wGhhCaXVYmerbToe105TAr9I1vVU4/2sNVIi1QS95M4RV0uzRJy+NB33HS0Ohf9vGEwI1ow=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr368230ejc.220.1675731775095; Mon, 06 Feb
 2023 17:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20230206092559.2722946-1-senozhatsky@chromium.org> <20230206092559.2722946-3-senozhatsky@chromium.org>
In-Reply-To: <20230206092559.2722946-3-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 17:02:18 -0800
Message-ID: <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness grouping
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 1:26 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Each zspage maintains ->inuse counter which keeps track of the
> number of objects stored in the page. The ->inuse counter also
> determines the page's "fullness group" which is calculated as
> the ratio of the "inuse" objects to the total number of objects
> the page can hold (objs_per_zspage). The closer the ->inuse
> counter is to objs_per_zspage, the better.
>
> Each size class maintains several fullness lists, that keep
> track of zspages of particular "fullness". There are four lists
> at the moment:
>
>  ZS_EMPTY for pages with zero "inuse" counter
>  ZS_FULL for pages with "inuse" equal to objs_per_zspage
>  ZS_ALMOST_EMPTY for pages with "inuse" less than or equal to
>    3 * objs_per_zspage / 4
>  ZS_ALMOST_FULL for pages with "inuse" greater than
>    3 * objs_per_zspage / 4.
>
> First or all, this makes ZS_ALMOST_EMPTY fullness list pretty
> busy for certain size classes. For example, the ZS_ALMOST_EMPTY
> list for class-112 (which can store 256 objects per zspage) will
> contain pages with ->inuse counters in the range from 1 to 192.
>
> Second, pages within each fullness list are stored in random
> order with regard to the ->inuse counter. This is because
> sorting the pages by ->inuse counter each time obj_malloc() or
> obj_free() is called would be too expensive.
>
> However, the ->inuse counter is still a crucial factor in many
> situations.
>
> In a busy system with many obj_malloc() and obj_free() calls,
> fullness lists become inefficient. For instance, the ->inuse
> counters for the first 7 zspages of some random classes are:
>
>  class-1840 objs_per_zspage 20:
>    ZS_ALMOST_EMPTY: 3 13 8  2 11 14 3
>    ZS_ALMOST_FULL : empty
>
>  class-688  objs_per_zspage 59:
>    ZS_ALMOST_EMPTY: 1 3  5  1 18 13 15
>    ZS_ALMOST_FULL : empty
>
> For the two major zsmalloc operations, zs_malloc() and zs_compact(),
> we typically select the head page from the corresponding fullness
> list as the best candidate page. However, this assumption is not
> always accurate.
>
> For the zs_malloc() operation, the optimal candidate page should
> have the highest ->inuse counter. This is because the goal is to
> maximize the number of ZS_FULL pages and make full use of all
> allocated memory.
>
> For the zs_compact() operation, the optimal candidate page should
> have the lowest ->inuse counter. This is because compaction needs
> to move objects in use to another page before it can release the
> zspage and return its physical pages to the buddy allocator. The
> fewer objects in use, the quicker compaction can release the page.
> Additionally, compaction is measured by the number of pages it
> releases. For example, assume the following case:
>
>  - size class stores 8 objects per zspage
>  - ALMOST_FULL list contains one page that has ->inuse equal to 6
>  - ALMOST_EMPTY list contains 3 pages: one pages has ->inuse
>    equal to 2, and two pages have ->inuse equal to 1.
>
> The current compaction algorithm selects the head page of the
> ALMOST_EMPTY list (the source page), which has inuse equals 2,
> moves its objects to the ALMOST_FULL list page (the destination
> page), and then releases the source page. The ALMOST_FULL page
> (destination page) becomes FULL, so further compaction is not
> possible.
>
> At the same time, if compaction were to choose ALMOST_EMPTY pages
> with ->inuse equal to 1, it would be able to release two zspages
> while still performing the same number of memcpy() operations.
>
> This patch reworks the fullness grouping mechanism. Instead of
> relying on a threshold that results in too many pages being
> included in the ALMOST_EMPTY group for specific classes, size
> classes maintain a larger number of fullness lists that give
> strict guarantees on the minimum and maximum ->inuse values
> within each group. Each group represents a 10% change in the
> ->inuse ratio compared to neighboring groups. In essence, there
> are groups for pages with 0%, 10%, 20% usage ratios, and so on,
> up to 100%.
>
> This enhances the selection of candidate pages for both zs_malloc()
> and zs_compact(). A printout of the ->inuse counters of the first 7
> pages per (random) class fullness group:
>
>  class-768 objs_per_zspage 16:
>    fullness 100%:  empty
>    fullness  99%:  empty
>    fullness  90%:  empty
>    fullness  80%:  empty
>    fullness  70%:  empty
>    fullness  60%:  8  8  9  9  8  8  8
>    fullness  50%:  empty
>    fullness  40%:  5  5  6  5  5  5  5
>    fullness  30%:  4  4  4  4  4  4  4
>    fullness  20%:  2  3  2  3  3  2  2
>    fullness  10%:  1  1  1  1  1  1  1
>    fullness   0%:  empty
>
> The zs_malloc() function searches through the groups of pages
> starting with the one having the highest usage ratio. This means
> that it always selects a page from the group with the least
> internal fragmentation (highest usage ratio) and makes it even
> less fragmented by increasing its usage ratio.
>
> The zs_compact() function, on the other hand, begins by scanning
> the group with the highest fragmentation (lowest usage ratio) to
> locate the source page. The first available page is selected, and
> then the function moves downward to find a destination page in
> the group with the lowest internal fragmentation (highest usage
> ratio).
>
> The example demonstrates that zs_malloc() would choose a page
> with ->inuse of 8 as the candidate page, while zs_compact()
> would pick a page with ->inuse of 1 as the source page and
> another page with ->inuse of 8 as the destination page.
>
> A 1/10 difference in ratio between fullness groups is intentional
> and critical for classes that have a high number of objs_per_zspage.
> For instance, class-624 stores 59 objects per zspage. With a 1/10
> ratio grouping, the difference in inuse values between the page
> with the lowest and highest inuse in a single fullness group is
> only 4 objects (2469 bytes), whereas a 1/5 ratio grouping would
> result in a difference of 10 objects (6240 bytes).


The memory extra overhead would be sizeof(list_head) * nr of classes *
extra fullness groups = 16 * 255 * 6 = 24480 bytes ~= 24KB on a
machine with 4096 page size. Sounds reasonable (although I wonder how
it scales with PAGE_SIZE).

>
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> ---
>  mm/zsmalloc.c | 224 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 148 insertions(+), 76 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index b57a89ed6f30..1901edd01e38 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -127,7 +127,7 @@
>  #define OBJ_INDEX_MASK ((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
>
>  #define HUGE_BITS      1
> -#define FULLNESS_BITS  2
> +#define FULLNESS_BITS  4
>  #define CLASS_BITS     8
>  #define ISOLATED_BITS  5
>  #define MAGIC_VAL_BITS 8
> @@ -159,24 +159,88 @@
>  #define ZS_SIZE_CLASSES        (DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
>                                       ZS_SIZE_CLASS_DELTA) + 1)
>
> +/*
> + * Pages are distinguished by the ratio of used memory (that is the ratio
> + * of ->inuse objects to all objects that page can store). For example,
> + * USAGE_30 means that the ratio of used objects is > 20% and <= 30%.
> + *
> + * The number of fullness groups is not random. It allows us to keep
> + * diffeence between the least busy page in the group (minimum permitted
> + * number of ->inuse objects) and the most busy page (maximum permitted
> + * number of ->inuse objects) at a reasonable value.
> + */
>  enum fullness_group {
> -       ZS_EMPTY,
> -       ZS_ALMOST_EMPTY,
> -       ZS_ALMOST_FULL,
> -       ZS_FULL,
> +       ZS_USAGE_0,
> +       ZS_USAGE_10,
> +       ZS_USAGE_20,
> +       ZS_USAGE_30,
> +       ZS_USAGE_40,
> +       ZS_USAGE_50,
> +       ZS_USAGE_60,
> +       ZS_USAGE_70,
> +       ZS_USAGE_80,
> +       ZS_USAGE_90,
> +       ZS_USAGE_99,
> +       ZS_USAGE_100,
>         NR_ZS_FULLNESS,
>  };
>

Is there a reason why this can't be done with something like #define
FULLNESS_GROUPS 10? We can make sure during build that (100 %
FULLNESS_GROUPS == 0) to make our lives easier. I feel like the code
will be much more concise and easier to navigate, instead of multiple
enums and static arrays.

>
>  enum class_stat_type {
> -       CLASS_EMPTY,
> -       CLASS_ALMOST_EMPTY,
> -       CLASS_ALMOST_FULL,
> -       CLASS_FULL,
> +       CLASS_USAGE_0,
> +       CLASS_USAGE_10,
> +       CLASS_USAGE_20,
> +       CLASS_USAGE_30,
> +       CLASS_USAGE_40,
> +       CLASS_USAGE_50,
> +       CLASS_USAGE_60,
> +       CLASS_USAGE_70,
> +       CLASS_USAGE_80,
> +       CLASS_USAGE_90,
> +       CLASS_USAGE_99,
> +       CLASS_USAGE_100,
>         OBJ_ALLOCATED,
>         OBJ_USED,
>         NR_ZS_STAT_TYPE,
>  };
>
> +#define NUM_FULLNESS_GROUPS    10
> +
> +/*
> + * Lookup pages in increasing (from lowest to highest) order of usage ratio.
> + * This is useful, for instance, during compaction, when we want to migrate
> + * as few objects as possible in order to free zspage.
> + */
> +static const enum fullness_group fullness_asc[NUM_FULLNESS_GROUPS] = {
> +       ZS_USAGE_10,
> +       ZS_USAGE_20,
> +       ZS_USAGE_30,
> +       ZS_USAGE_40,
> +       ZS_USAGE_50,
> +       ZS_USAGE_60,
> +       ZS_USAGE_70,
> +       ZS_USAGE_80,
> +       ZS_USAGE_90,
> +       ZS_USAGE_99
> +};
> +
> +/*
> + * Lookup pages in decreasing (from highest to lowest) order of usage ratio.
> + * This is useful in zs_malloc() and compaction, when we want to have as
> + * many full pages as possible for more efficient memory usage.
> + */
> +static const enum fullness_group fullness_desc[NUM_FULLNESS_GROUPS] = {
> +       ZS_USAGE_99,
> +       ZS_USAGE_90,
> +       ZS_USAGE_80,
> +       ZS_USAGE_70,
> +       ZS_USAGE_60,
> +       ZS_USAGE_50,
> +       ZS_USAGE_40,
> +       ZS_USAGE_30,
> +       ZS_USAGE_20,
> +       ZS_USAGE_10,
> +};
> +
>  struct zs_size_stat {
>         unsigned long objs[NR_ZS_STAT_TYPE];
>  };
> @@ -185,21 +249,6 @@ struct zs_size_stat {
>  static struct dentry *zs_stat_root;
>  #endif
>
> -/*
> - * We assign a page to ZS_ALMOST_EMPTY fullness group when:
> - *     n <= N / f, where
> - * n = number of allocated objects
> - * N = total number of objects zspage can store
> - * f = fullness_threshold_frac
> - *
> - * Similarly, we assign zspage to:
> - *     ZS_ALMOST_FULL  when n > N / f
> - *     ZS_EMPTY        when n == 0
> - *     ZS_FULL         when n == N
> - *
> - * (see: fix_fullness_group())
> - */
> -static const int fullness_threshold_frac = 4;
>  static size_t huge_class_size;
>
>  struct size_class {
> @@ -652,8 +701,23 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
>                         continue;
>
>                 spin_lock(&pool->lock);
> -               class_almost_full = zs_stat_get(class, CLASS_ALMOST_FULL);
> -               class_almost_empty = zs_stat_get(class, CLASS_ALMOST_EMPTY);
> +
> +               /*
> +                * Replecate old behaviour for almost_full and almost_empty
> +                * stats.
> +                */
> +               class_almost_full = zs_stat_get(class, CLASS_USAGE_99);
> +               class_almost_full += zs_stat_get(class, CLASS_USAGE_90);
> +               class_almost_full += zs_stat_get(class, CLASS_USAGE_80);
> +               class_almost_full += zs_stat_get(class, CLASS_USAGE_70);
> +
> +               class_almost_empty = zs_stat_get(class, CLASS_USAGE_60);
> +               class_almost_empty += zs_stat_get(class, CLASS_USAGE_50);
> +               class_almost_empty += zs_stat_get(class, CLASS_USAGE_40);
> +               class_almost_empty += zs_stat_get(class, CLASS_USAGE_30);
> +               class_almost_empty += zs_stat_get(class, CLASS_USAGE_20);
> +               class_almost_empty += zs_stat_get(class, CLASS_USAGE_10);
> +
>                 obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
>                 obj_used = zs_stat_get(class, OBJ_USED);
>                 freeable = zs_can_compact(class);
> @@ -723,33 +787,39 @@ static inline void zs_pool_stat_destroy(struct zs_pool *pool)
>  }
>  #endif
>
> -
>  /*
>   * For each size class, zspages are divided into different groups
> - * depending on how "full" they are. This was done so that we could
> - * easily find empty or nearly empty zspages when we try to shrink
> - * the pool (not yet implemented). This function returns fullness
> + * depending on their usage ratio. This function returns fullness
>   * status of the given page.
>   */
>  static enum fullness_group get_fullness_group(struct size_class *class,
> -                                               struct zspage *zspage)
> -{
> +                                             struct zspage *zspage)
> +{
> +       static const enum fullness_group groups[] = {
> +               ZS_USAGE_10,
> +               ZS_USAGE_20,
> +               ZS_USAGE_30,
> +               ZS_USAGE_40,
> +               ZS_USAGE_50,
> +               ZS_USAGE_60,
> +               ZS_USAGE_70,
> +               ZS_USAGE_80,
> +               ZS_USAGE_90,
> +               ZS_USAGE_99,
> +       };
>         int inuse, objs_per_zspage;
> -       enum fullness_group fg;
> +       int ratio;
>
>         inuse = get_zspage_inuse(zspage);
>         objs_per_zspage = class->objs_per_zspage;
>
>         if (inuse == 0)
> -               fg = ZS_EMPTY;
> -       else if (inuse == objs_per_zspage)
> -               fg = ZS_FULL;
> -       else if (inuse <= 3 * objs_per_zspage / fullness_threshold_frac)
> -               fg = ZS_ALMOST_EMPTY;
> -       else
> -               fg = ZS_ALMOST_FULL;
> +               return ZS_USAGE_0;
> +       if (inuse == objs_per_zspage)
> +               return ZS_USAGE_100;
>
> -       return fg;
> +       ratio = 100 * inuse / objs_per_zspage;
> +       return groups[ratio / 10];
>  }
>
>  /*
> @@ -781,14 +851,13 @@ static void remove_zspage(struct size_class *class,
>  /*
>   * Each size class maintains zspages in different fullness groups depending
>   * on the number of live objects they contain. When allocating or freeing
> - * objects, the fullness status of the page can change, say, from ALMOST_FULL
> - * to ALMOST_EMPTY when freeing an object. This function checks if such
> - * a status change has occurred for the given page and accordingly moves the
> - * page from the freelist of the old fullness group to that of the new
> - * fullness group.
> + * objects, the fullness status of the page can change, say, from USAGE_80
> + * to USAGE_70 when freeing an object. This function checks if such a status
> + * change has occurred for the given page and accordingly moves the page from
> + * the list of the old fullness group to that of the new fullness group.
>   */
>  static enum fullness_group fix_fullness_group(struct size_class *class,
> -                                               struct zspage *zspage)
> +                                             struct zspage *zspage)
>  {
>         int class_idx;
>         enum fullness_group currfg, newfg;
> @@ -972,7 +1041,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>         assert_spin_locked(&pool->lock);
>
>         VM_BUG_ON(get_zspage_inuse(zspage));
> -       VM_BUG_ON(fg != ZS_EMPTY);
> +       VM_BUG_ON(fg != ZS_USAGE_0);
>
>         /* Free all deferred handles from zs_free */
>         free_handles(pool, class, zspage);
> @@ -1011,7 +1080,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
>                 return;
>         }
>
> -       remove_zspage(class, zspage, ZS_EMPTY);
> +       remove_zspage(class, zspage, ZS_USAGE_0);
>  #ifdef CONFIG_ZPOOL
>         list_del(&zspage->lru);
>  #endif
> @@ -1142,14 +1211,15 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>         return zspage;
>  }
>
> -static struct zspage *find_get_zspage(struct size_class *class)
> +static struct zspage *find_get_zspage(struct size_class *class,
> +                                     const enum fullness_group *groups)
>  {
> -       int i;
>         struct zspage *zspage;
> +       int i;
>
> -       for (i = ZS_ALMOST_FULL; i >= ZS_EMPTY; i--) {
> +       for (i = 0; i < NUM_FULLNESS_GROUPS; i++) {


I think you missed using the passed groups arg here.

>
>                 zspage = list_first_entry_or_null(&class->fullness_list[i],
> -                               struct zspage, list);
> +                                                 struct zspage, list);
>                 if (zspage)
>                         break;
>         }
> @@ -1524,7 +1594,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>
>         /* pool->lock effectively protects the zpage migration */
>         spin_lock(&pool->lock);
> -       zspage = find_get_zspage(class);
> +       zspage = find_get_zspage(class, fullness_desc);
>         if (likely(zspage)) {
>                 obj = obj_malloc(pool, zspage, handle);
>                 /* Now move the zspage to another fullness group, if required */
> @@ -1642,7 +1712,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
>         obj_free(class->size, obj, NULL);
>
>         fullness = fix_fullness_group(class, zspage);
> -       if (fullness == ZS_EMPTY)
> +       if (fullness == ZS_USAGE_0)
>                 free_zspage(pool, class, zspage);
>
>         spin_unlock(&pool->lock);
> @@ -1824,22 +1894,19 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
>         return ret;
>  }
>
> -static struct zspage *isolate_zspage(struct size_class *class, bool source)
> +static struct zspage *isolate_zspage(struct size_class *class,
> +                                    const enum fullness_group *groups)
>  {
> -       int i;
>         struct zspage *zspage;
> -       enum fullness_group fg[2] = {ZS_ALMOST_EMPTY, ZS_ALMOST_FULL};
> +       int i;
>
> -       if (!source) {
> -               fg[0] = ZS_ALMOST_FULL;
> -               fg[1] = ZS_ALMOST_EMPTY;
> -       }
> +       for (i = 0; i < NUM_FULLNESS_GROUPS; i++) {
> +               enum fullness_group fg = groups[i];
>
> -       for (i = 0; i < 2; i++) {
> -               zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
> -                                                       struct zspage, list);
> +               zspage = list_first_entry_or_null(&class->fullness_list[fg],
> +                                                 struct zspage, list);
>                 if (zspage) {
> -                       remove_zspage(class, zspage, fg[i]);
> +                       remove_zspage(class, zspage, fg);
>                         return zspage;
>                 }
>         }
> @@ -2133,7 +2200,8 @@ static void async_free_zspage(struct work_struct *work)
>                         continue;
>
>                 spin_lock(&pool->lock);
> -               list_splice_init(&class->fullness_list[ZS_EMPTY], &free_pages);
> +               list_splice_init(&class->fullness_list[ZS_USAGE_0],
> +                                &free_pages);
>                 spin_unlock(&pool->lock);
>         }
>
> @@ -2142,7 +2210,7 @@ static void async_free_zspage(struct work_struct *work)
>                 lock_zspage(zspage);
>
>                 get_zspage_mapping(zspage, &class_idx, &fullness);
> -               VM_BUG_ON(fullness != ZS_EMPTY);
> +               VM_BUG_ON(fullness != ZS_USAGE_0);
>                 class = pool->size_class[class_idx];
>                 spin_lock(&pool->lock);
>  #ifdef CONFIG_ZPOOL
> @@ -2215,7 +2283,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>          * as well as zpage allocation/free
>          */
>         spin_lock(&pool->lock);
> -       while ((src_zspage = isolate_zspage(class, true))) {
> +       while ((src_zspage = isolate_zspage(class, fullness_asc))) {
>                 /* protect someone accessing the zspage(i.e., zs_map_object) */
>                 migrate_write_lock(src_zspage);
>
> @@ -2225,10 +2293,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>                 cc.obj_idx = 0;
>                 cc.s_page = get_first_page(src_zspage);
>
> -               while ((dst_zspage = isolate_zspage(class, false))) {
> +               while ((dst_zspage = isolate_zspage(class, fullness_desc))) {
>                         migrate_write_lock_nested(dst_zspage);
>
>                         cc.d_page = get_first_page(dst_zspage);
> +
>                         /*
>                          * If there is no more space in dst_page, resched
>                          * and see if anyone had allocated another zspage.
> @@ -2250,7 +2319,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>                 putback_zspage(class, dst_zspage);
>                 migrate_write_unlock(dst_zspage);
>
> -               if (putback_zspage(class, src_zspage) == ZS_EMPTY) {
> +               if (putback_zspage(class, src_zspage) == ZS_USAGE_0) {
>                         migrate_write_unlock(src_zspage);
>                         free_zspage(pool, class, src_zspage);
>                         pages_freed += class->pages_per_zspage;
> @@ -2408,7 +2477,7 @@ struct zs_pool *zs_create_pool(const char *name)
>                 int pages_per_zspage;
>                 int objs_per_zspage;
>                 struct size_class *class;
> -               int fullness = 0;
> +               int fullness;
>
>                 size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
>                 if (size > ZS_MAX_ALLOC_SIZE)
> @@ -2462,9 +2531,12 @@ struct zs_pool *zs_create_pool(const char *name)
>                 class->pages_per_zspage = pages_per_zspage;
>                 class->objs_per_zspage = objs_per_zspage;
>                 pool->size_class[i] = class;
> -               for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
> -                                                       fullness++)
> +
> +               fullness = ZS_USAGE_0;
> +               while (fullness < NR_ZS_FULLNESS) {
>                         INIT_LIST_HEAD(&class->fullness_list[fullness]);
> +                       fullness++;
> +               }
>
>                 prev_class = class;
>         }
> @@ -2510,7 +2582,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>                 if (class->index != i)
>                         continue;
>
> -               for (fg = ZS_EMPTY; fg < NR_ZS_FULLNESS; fg++) {
> +               for (fg = ZS_USAGE_0; fg < NR_ZS_FULLNESS; fg++) {
>                         if (!list_empty(&class->fullness_list[fg])) {
>                                 pr_info("Freeing non-empty class with size %db, fullness group %d\n",
>                                         class->size, fg);
> @@ -2686,7 +2758,7 @@ static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
>                          * while the page is removed from the pool. Fix it
>                          * up for the check in __free_zspage().
>                          */
> -                       zspage->fullness = ZS_EMPTY;
> +                       zspage->fullness = ZS_USAGE_0;
>
>                         __free_zspage(pool, class, zspage);
>                         spin_unlock(&pool->lock);
> --
> 2.39.1.519.gcb327c4b5f-goog
>
>
