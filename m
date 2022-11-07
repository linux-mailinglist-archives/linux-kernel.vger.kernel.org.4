Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0061FDE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiKGSuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiKGSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:50:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6820BE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:50:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y203so11478906pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OkbKD0hurujVVht024zGU2voP/dZ56F3Wcwu4hfe930=;
        b=KmgMr4fg8fm5HvUimY4RdQQ8xjZ+apNEJhUFiN0Rthjs6EsZq1zZ5xXNMVLcBcHvrA
         B17ZgZXm6YQL6OPa3mKazq2r4czfm6uqIznM7NdhOy+3tUzcQWneZCJxv9ftKUblUlhB
         1+pPko7GmCd8GugIZRVPa/m9bTaQdDq0QjYbugCAfY07b3B/8GGDXc7yYsv6dBHDjQ06
         METzd+DMDLfcVD8bpKoFaMVzeeQY3ceepjqsYQxnh8Zbs48CZROkpteBzdc5QXwo2zq6
         L4TilUYqlKZME4bhtAHxCJJqFMwhJwvjsTRYYONZpOjCe0OxM8JUhhltoZNjY34rE0Zc
         ipVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkbKD0hurujVVht024zGU2voP/dZ56F3Wcwu4hfe930=;
        b=z06OHG8Lx8N2aVArcY+GJBIGLtHHqvktDUWZ0ZaZ8E+gQjkTaTWIUYVSr9WQGAyKd7
         Evqsa4UG24KTOBFM3Of+mb+clRJapq4IwRY56YTEreO0SaJynHn742iW9kZYB06oq+Jg
         ZPWn8jqwGV67JF7pZqfB1IsIMuOP/lpa5J+S1UN7j8bRjcmU4XjIWwjDzG1ijX3K4Hx5
         T7WpP2rr46FxaRxBciIB1vJaO/1b4mOERn0ytfikScAJyK/5XBS6v4UiNTfV++CsAYIT
         a7sS8rM3znZuu7hgS6ieZvCVmjE8drpUAuREJlreA3zzAvSkE3o7SL9IxQ9K79LMgQ1L
         AtZQ==
X-Gm-Message-State: ACrzQf1rAF2ujTlCw2I+cVcRW6PWffP64uaDZ26tlWM1+D1WYZ2otAJK
        yhTMiRmcjxlYtfXIFfXI6o7AtF+BbLocN4EDeQ4=
X-Google-Smtp-Source: AMsMyM5Y8LwFqWZxqbLJRDyGi6N/+7BCwghS/FKamv+4uC4Ip9PGJdyi6pZxOoAEVANWG+oi9x9/T1taSfkaa8yLtU8=
X-Received: by 2002:a63:6d8a:0:b0:46f:57e9:f933 with SMTP id
 i132-20020a636d8a000000b0046f57e9f933mr44624820pgc.195.1667847002500; Mon, 07
 Nov 2022 10:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20221104083020.155835-1-ying.huang@intel.com> <20221104083020.155835-2-ying.huang@intel.com>
In-Reply-To: <20221104083020.155835-2-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Nov 2022 10:49:50 -0800
Message-ID: <CAHbLzkrBQvLMHA+krcWwnEe4cj65b=PYR22R_rBTWxq1h3Rh6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] migrate: convert unmap_and_move() to use folios
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
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

On Fri, Nov 4, 2022 at 1:31 AM Huang Ying <ying.huang@intel.com> wrote:
>
> Quite straightforward, the page functions are converted to
> corresponding folio functions.  Same for comments.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dff333593a8a..f6dd749dd2f8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1150,79 +1150,79 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
>  }
>
>  /*
> - * Obtain the lock on page, remove all ptes and migrate the page
> - * to the newly allocated page in newpage.
> + * Obtain the lock on folio, remove all ptes and migrate the folio
> + * to the newly allocated folio in dst.
>   */
>  static int unmap_and_move(new_page_t get_new_page,
>                                    free_page_t put_new_page,
> -                                  unsigned long private, struct page *page,
> +                                  unsigned long private, struct folio *src,
>                                    int force, enum migrate_mode mode,
>                                    enum migrate_reason reason,
>                                    struct list_head *ret)
>  {
> -       struct folio *dst, *src = page_folio(page);
> +       struct folio *dst;
>         int rc = MIGRATEPAGE_SUCCESS;
>         struct page *newpage = NULL;
>
> -       if (!thp_migration_supported() && PageTransHuge(page))
> +       if (!thp_migration_supported() && folio_test_transhuge(src))
>                 return -ENOSYS;
>
> -       if (page_count(page) == 1) {
> -               /* Page was freed from under us. So we are done. */
> -               ClearPageActive(page);
> -               ClearPageUnevictable(page);
> +       if (folio_ref_count(src) == 1) {
> +               /* Folio was freed from under us. So we are done. */
> +               folio_clear_active(src);
> +               folio_clear_unevictable(src);
>                 /* free_pages_prepare() will clear PG_isolated. */
>                 goto out;
>         }
>
> -       newpage = get_new_page(page, private);
> +       newpage = get_new_page(&src->page, private);
>         if (!newpage)
>                 return -ENOMEM;
>         dst = page_folio(newpage);
>
> -       newpage->private = 0;
> +       dst->private = 0;
>         rc = __unmap_and_move(src, dst, force, mode);
>         if (rc == MIGRATEPAGE_SUCCESS)
> -               set_page_owner_migrate_reason(newpage, reason);
> +               set_page_owner_migrate_reason(&dst->page, reason);
>
>  out:
>         if (rc != -EAGAIN) {
>                 /*
> -                * A page that has been migrated has all references
> -                * removed and will be freed. A page that has not been
> +                * A folio that has been migrated has all references
> +                * removed and will be freed. A folio that has not been
>                  * migrated will have kept its references and be restored.
>                  */
> -               list_del(&page->lru);
> +               list_del(&src->lru);
>         }
>
>         /*
>          * If migration is successful, releases reference grabbed during
> -        * isolation. Otherwise, restore the page to right list unless
> +        * isolation. Otherwise, restore the folio to right list unless
>          * we want to retry.
>          */
>         if (rc == MIGRATEPAGE_SUCCESS) {
>                 /*
> -                * Compaction can migrate also non-LRU pages which are
> +                * Compaction can migrate also non-LRU folios which are
>                  * not accounted to NR_ISOLATED_*. They can be recognized
> -                * as __PageMovable
> +                * as __folio_test_movable
>                  */
> -               if (likely(!__PageMovable(page)))
> -                       mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -                                       page_is_file_lru(page), -thp_nr_pages(page));
> +               if (likely(!__folio_test_movable(src)))
> +                       mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> +                                       folio_is_file_lru(src), -folio_nr_pages(src));
>
>                 if (reason != MR_MEMORY_FAILURE)
>                         /*
> -                        * We release the page in page_handle_poison.
> +                        * We release the folio in page_handle_poison.
>                          */
> -                       put_page(page);
> +                       folio_put(src);
>         } else {
>                 if (rc != -EAGAIN)
> -                       list_add_tail(&page->lru, ret);
> +                       list_add_tail(&src->lru, ret);
>
>                 if (put_new_page)
> -                       put_new_page(newpage, private);
> +                       put_new_page(&dst->page, private);
>                 else
> -                       put_page(newpage);
> +                       folio_put(dst);
>         }
>
>         return rc;
> @@ -1459,7 +1459,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                                                 &ret_pages);
>                         else
>                                 rc = unmap_and_move(get_new_page, put_new_page,
> -                                               private, page, pass > 2, mode,
> +                                               private, page_folio(page), pass > 2, mode,
>                                                 reason, &ret_pages);
>                         /*
>                          * The rules are:
> --
> 2.35.1
>
