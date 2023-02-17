Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AC69B67E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBQXpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQXpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:45:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82764B3D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:45:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id i10-20020a17090a7e0a00b002341a2656e5so2821103pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxS+9RgiWjgQdh5YVChlSHlv0qg+BOH35aN+0obnUU8=;
        b=BPQlZ4B7gjKpSaCiNyr9zpk5Hau1atVDsU0aO0va0wBByttZ+bdxdrjycdKAqZAnY0
         rwLf3TGMa9Ngz2zNGBlxvqMimTHKcOLIsMphW7slpM0kDF552zILOPvh2NUeDLrq/His
         J9mSPiFee7xhjp5ob0DG5dRyVR5gJli55MWvgkcNraCh5DF4PItFmbuowsOTaJGIO4Ju
         tcdtFcVhPuDDaU+ufOZHm50bwvUWthGUHgHYwgcn3tpBSzo1UyMMomBcoYRUplSUygGR
         p2s+D1kzoYZQciEgY8PZk/ogBsjgFtx2TmPe7Z0u6aDjkT74jmyWLZvOyhnE4nRBwguL
         8oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxS+9RgiWjgQdh5YVChlSHlv0qg+BOH35aN+0obnUU8=;
        b=2oMArR5L9fMd7Q1exQ78XK2RDY8nNTAaXjeKA+Lz3soSgd2zu5rP356msZOjwOuNdm
         hJ7b7TTS7oV0uMs4mf4OpJejJqrKudysICR5OmWNICbeJuAWIJZ4icDq53cygcjwhwU8
         n6RKttw/wHjSau6nEz97h3sUgmr4m76nBhYhKvbc3p5n1uQa6PLojIiDCt2K1ZKDVAxe
         kw3WFsrNvcVp0cbsmbMUP3c65XsY6IHc5uoKv/ZobI1fbbDFO3viznZUnlYgHTH7epyi
         iy3eRMpZ21yPNx/AB5pqGgbkRACJRQhfAwVqtnvVNE8qNRDAMyBfbT5cmnaAXfb8rU2Z
         ubPQ==
X-Gm-Message-State: AO0yUKXwqgyGNQhnOgFxauEYhaYL5FXiACEuUv+Lw/aOgA/N+byW8olT
        ebTLYiKihFGpN3mA8qFUtqOe9wprKYn8tnUXw/k=
X-Google-Smtp-Source: AK7set/GBttqOHZqBwe/yN2PAJZxyDT6bC6cEOqxqLDDwsoJIa7t75iHD6c/UPHy+HZ2+vfH+XH1gHaDbnLpJAocMYM=
X-Received: by 2002:a17:90b:1e47:b0:230:b973:a726 with SMTP id
 pi7-20020a17090b1e4700b00230b973a726mr1861002pjb.23.1676677510260; Fri, 17
 Feb 2023 15:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20230217085439.2826375-1-stevensd@google.com> <20230217085439.2826375-2-stevensd@google.com>
In-Reply-To: <20230217085439.2826375-2-stevensd@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Feb 2023 15:44:58 -0800
Message-ID: <CAHbLzkpTgeiUr4R7C9kw+aujxOpd+phwT1ZEZp9eiqZ1VsoS4g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/khugepaged: refactor collapse_file control flow
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
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

On Fri, Feb 17, 2023 at 12:55 AM David Stevens <stevensd@chromium.org> wrote:
>
> From: David Stevens <stevensd@chromium.org>
>
> Add a rollback label to deal with failure, instead of continuously
> checking for RESULT_SUCCESS, to make it easier to add more failure
> cases. The refactoring also allows the collapse_file tracepoint to
> include hpage on success (instead of NULL).
>
> Signed-off-by: David Stevens <stevensd@chromium.org>

The refactor looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 223 ++++++++++++++++++++++++------------------------
>  1 file changed, 110 insertions(+), 113 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8dbc39896811..6a3d6d2e25e0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1885,6 +1885,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>         if (result != SCAN_SUCCEED)
>                 goto out;
>
> +       __SetPageLocked(hpage);
> +       if (is_shmem)
> +               __SetPageSwapBacked(hpage);
> +       hpage->index = start;
> +       hpage->mapping = mapping;
> +
>         /*
>          * Ensure we have slots for all the pages in the range.  This is
>          * almost certainly a no-op because most of the pages must be present
> @@ -1897,16 +1903,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>                 xas_unlock_irq(&xas);
>                 if (!xas_nomem(&xas, GFP_KERNEL)) {
>                         result = SCAN_FAIL;
> -                       goto out;
> +                       goto rollback;
>                 }
>         } while (1);
>
> -       __SetPageLocked(hpage);
> -       if (is_shmem)
> -               __SetPageSwapBacked(hpage);
> -       hpage->index = start;
> -       hpage->mapping = mapping;
> -
>         /*
>          * At this point the hpage is locked and not up-to-date.
>          * It's safe to insert it into the page cache, because nobody would
> @@ -2123,131 +2123,128 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>          */
>         try_to_unmap_flush();
>
> -       if (result == SCAN_SUCCEED) {
> -               /*
> -                * Replacing old pages with new one has succeeded, now we
> -                * attempt to copy the contents.
> -                */
> -               index = start;
> -               list_for_each_entry(page, &pagelist, lru) {
> -                       while (index < page->index) {
> -                               clear_highpage(hpage + (index % HPAGE_PMD_NR));
> -                               index++;
> -                       }
> -                       if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
> -                                        page) > 0) {
> -                               result = SCAN_COPY_MC;
> -                               break;
> -                       }
> -                       index++;
> -               }
> -               while (result == SCAN_SUCCEED && index < end) {
> +       if (result != SCAN_SUCCEED)
> +               goto rollback;
> +
> +       /*
> +        * Replacing old pages with new one has succeeded, now we
> +        * attempt to copy the contents.
> +        */
> +       index = start;
> +       list_for_each_entry(page, &pagelist, lru) {
> +               while (index < page->index) {
>                         clear_highpage(hpage + (index % HPAGE_PMD_NR));
>                         index++;
>                 }
> +               if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
> +                                page) > 0) {
> +                       result = SCAN_COPY_MC;
> +                       goto rollback;
> +               }
> +               index++;
> +       }
> +       while (index < end) {
> +               clear_highpage(hpage + (index % HPAGE_PMD_NR));
> +               index++;
>         }
>
> -       if (result == SCAN_SUCCEED) {
> -               /*
> -                * Copying old pages to huge one has succeeded, now we
> -                * need to free the old pages.
> -                */
> -               list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> -                       list_del(&page->lru);
> -                       page->mapping = NULL;
> -                       page_ref_unfreeze(page, 1);
> -                       ClearPageActive(page);
> -                       ClearPageUnevictable(page);
> -                       unlock_page(page);
> -                       put_page(page);
> -               }
> +       /*
> +        * Copying old pages to huge one has succeeded, now we
> +        * need to free the old pages.
> +        */
> +       list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> +               list_del(&page->lru);
> +               page->mapping = NULL;
> +               page_ref_unfreeze(page, 1);
> +               ClearPageActive(page);
> +               ClearPageUnevictable(page);
> +               unlock_page(page);
> +               put_page(page);
> +       }
>
> -               xas_lock_irq(&xas);
> -               if (is_shmem)
> -                       __mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> -               else
> -                       __mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
> +       xas_lock_irq(&xas);
> +       if (is_shmem)
> +               __mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> +       else
> +               __mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
> +
> +       if (nr_none) {
> +               __mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
> +               /* nr_none is always 0 for non-shmem. */
> +               __mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
> +       }
> +       /* Join all the small entries into a single multi-index entry. */
> +       xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> +       xas_store(&xas, hpage);
> +       xas_unlock_irq(&xas);
>
> -               if (nr_none) {
> -                       __mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
> -                       /* nr_none is always 0 for non-shmem. */
> -                       __mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
> -               }
> -               /* Join all the small entries into a single multi-index entry. */
> -               xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> -               xas_store(&xas, hpage);
> -               xas_unlock_irq(&xas);
> +       folio = page_folio(hpage);
> +       folio_mark_uptodate(folio);
> +       folio_ref_add(folio, HPAGE_PMD_NR - 1);
>
> -               folio = page_folio(hpage);
> -               folio_mark_uptodate(folio);
> -               folio_ref_add(folio, HPAGE_PMD_NR - 1);
> +       if (is_shmem)
> +               folio_mark_dirty(folio);
> +       folio_add_lru(folio);
>
> -               if (is_shmem)
> -                       folio_mark_dirty(folio);
> -               folio_add_lru(folio);
> +       /*
> +        * Remove pte page tables, so we can re-fault the page as huge.
> +        */
> +       result = retract_page_tables(mapping, start, mm, addr, hpage,
> +                                    cc);
> +       unlock_page(hpage);
> +       goto out;
> +
> +rollback:
> +       /* Something went wrong: roll back page cache changes */
> +       xas_lock_irq(&xas);
> +       if (nr_none) {
> +               mapping->nrpages -= nr_none;
> +               shmem_uncharge(mapping->host, nr_none);
> +       }
>
> -               /*
> -                * Remove pte page tables, so we can re-fault the page as huge.
> -                */
> -               result = retract_page_tables(mapping, start, mm, addr, hpage,
> -                                            cc);
> -               unlock_page(hpage);
> -               hpage = NULL;
> -       } else {
> -               /* Something went wrong: roll back page cache changes */
> -               xas_lock_irq(&xas);
> -               if (nr_none) {
> -                       mapping->nrpages -= nr_none;
> -                       shmem_uncharge(mapping->host, nr_none);
> +       xas_set(&xas, start);
> +       xas_for_each(&xas, page, end - 1) {
> +               page = list_first_entry_or_null(&pagelist,
> +                               struct page, lru);
> +               if (!page || xas.xa_index < page->index) {
> +                       if (!nr_none)
> +                               break;
> +                       nr_none--;
> +                       /* Put holes back where they were */
> +                       xas_store(&xas, NULL);
> +                       continue;
>                 }
>
> -               xas_set(&xas, start);
> -               xas_for_each(&xas, page, end - 1) {
> -                       page = list_first_entry_or_null(&pagelist,
> -                                       struct page, lru);
> -                       if (!page || xas.xa_index < page->index) {
> -                               if (!nr_none)
> -                                       break;
> -                               nr_none--;
> -                               /* Put holes back where they were */
> -                               xas_store(&xas, NULL);
> -                               continue;
> -                       }
> +               VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>
> -                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> +               /* Unfreeze the page. */
> +               list_del(&page->lru);
> +               page_ref_unfreeze(page, 2);
> +               xas_store(&xas, page);
> +               xas_pause(&xas);
> +               xas_unlock_irq(&xas);
> +               unlock_page(page);
> +               putback_lru_page(page);
> +               xas_lock_irq(&xas);
> +       }
> +       VM_BUG_ON(nr_none);
> +       /*
> +        * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
> +        * This undo is not needed unless failure is due to SCAN_COPY_MC.
> +        */
> +       if (!is_shmem && result == SCAN_COPY_MC)
> +               filemap_nr_thps_dec(mapping);
>
> -                       /* Unfreeze the page. */
> -                       list_del(&page->lru);
> -                       page_ref_unfreeze(page, 2);
> -                       xas_store(&xas, page);
> -                       xas_pause(&xas);
> -                       xas_unlock_irq(&xas);
> -                       unlock_page(page);
> -                       putback_lru_page(page);
> -                       xas_lock_irq(&xas);
> -               }
> -               VM_BUG_ON(nr_none);
> -               /*
> -                * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
> -                * This undo is not needed unless failure is due to SCAN_COPY_MC.
> -                */
> -               if (!is_shmem && result == SCAN_COPY_MC)
> -                       filemap_nr_thps_dec(mapping);
> +       xas_unlock_irq(&xas);
>
> -               xas_unlock_irq(&xas);
> +       hpage->mapping = NULL;
>
> -               hpage->mapping = NULL;
> -       }
> +       unlock_page(hpage);
> +       mem_cgroup_uncharge(page_folio(hpage));
> +       put_page(hpage);
>
> -       if (hpage)
> -               unlock_page(hpage);
>  out:
>         VM_BUG_ON(!list_empty(&pagelist));
> -       if (hpage) {
> -               mem_cgroup_uncharge(page_folio(hpage));
> -               put_page(hpage);
> -       }
> -
>         trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
>         return result;
>  }
> --
> 2.39.2.637.g21b0678d19-goog
>
