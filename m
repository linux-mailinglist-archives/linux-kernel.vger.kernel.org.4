Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BC69EA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBUW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjBUW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:28:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD3D27D6A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:28:36 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a26so3454754pfo.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=acGnR7zCh6ECcT7oOcZq1a4dkWUWWWZOL9ziUjEaicY=;
        b=mspeJSNVRBqIDXkMkTX1TDYD6a1Eo1IJp9bzYbQULUXd/gqBtnfSE8Rj+/URLcStAN
         Hrz8XWNDV+puJljscApSmEJk6hOiKs82+OVRjRkSR3zEbbF4IyQWYlmN/HLnGc16DjQV
         +wZL/USrDjeMup/N6aDm9dYRHI1OL+KBQRbheet/EmjwQqwmYNxOEQs7+WkhxnL0COmI
         Yg6L/VVe+ISq6heE6JqAsrcugGTLKoJfj9OSsP8EiuITNPegh6/ZLHBhmML3H3MEKIHu
         vFlBcMbofCxxpvBDNdcJosSezw4xeBVblKK7Xvn1PWIP32KcilIB5rQJtEXPYt95/PGT
         8AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acGnR7zCh6ECcT7oOcZq1a4dkWUWWWZOL9ziUjEaicY=;
        b=aXmtR9Z+uDYVwVw16pkT1zaxlPtu4/6bmB+kXzYAUuYXdVH+ZNhja8bHq+AUvoTYLv
         lmDAFGf6r8ldxXpo/84CtR+FNETITooIJEIIUzTsnmSqgM/kkjatgG/7kP+Xz2dDtgJE
         CZFYCnTy8UKQC61lDkauMYeZj9p9HlrFF4Swsu6leHo7ZtZZaxk+S0vCiDK6sUNlBN7m
         dYQU1sePESVXwHZI0NuOhYOzyKVGvoXr0WFxvuIBi1d6Nw6dndzbyH20QxAlndRqXi4b
         Fx/bK18vU2bDQd914NEoo4yhiKu87I1B/en5SBvPw0LOFGxwrLNlPHvMH5CTKYaiZaXi
         O3WQ==
X-Gm-Message-State: AO0yUKUGBqu/wyGq/uEc/vdOmeXhFImSZV87km2zbsWXUHPfinQxAxv6
        Q14WEnzHObeilJSH50Fa01/soZADFaqVdVEf3eMks7Qr
X-Google-Smtp-Source: AK7set9Ohhg+8g9jUftr5yftEqHtU3m5cIwYcY9Lwgpz0yF0FzEY0VSzyo5BJ/HxuU7Unca1/oI0PLRMvsZt5jKNcwE=
X-Received: by 2002:a63:7e55:0:b0:4fb:97bd:ac25 with SMTP id
 o21-20020a637e55000000b004fb97bdac25mr789368pgn.6.1677018515624; Tue, 21 Feb
 2023 14:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20230217085439.2826375-1-stevensd@google.com> <20230217085439.2826375-2-stevensd@google.com>
 <Y/U9fBxVJdhxiZ1v@x1n>
In-Reply-To: <Y/U9fBxVJdhxiZ1v@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Feb 2023 14:28:24 -0800
Message-ID: <CAHbLzkrTHWit1-J4wQcohi2bLCwfQF3wEtnCWh9-NO7Xj1b5jA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/khugepaged: refactor collapse_file control flow
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
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

On Tue, Feb 21, 2023 at 1:54 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Feb 17, 2023 at 05:54:37PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Add a rollback label to deal with failure, instead of continuously
> > checking for RESULT_SUCCESS, to make it easier to add more failure
> > cases. The refactoring also allows the collapse_file tracepoint to
> > include hpage on success (instead of NULL).
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  mm/khugepaged.c | 223 ++++++++++++++++++++++++------------------------
> >  1 file changed, 110 insertions(+), 113 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 8dbc39896811..6a3d6d2e25e0 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1885,6 +1885,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >       if (result != SCAN_SUCCEED)
> >               goto out;
> >
> > +     __SetPageLocked(hpage);
> > +     if (is_shmem)
> > +             __SetPageSwapBacked(hpage);
> > +     hpage->index = start;
> > +     hpage->mapping = mapping;
> > +
> >       /*
> >        * Ensure we have slots for all the pages in the range.  This is
> >        * almost certainly a no-op because most of the pages must be present
> > @@ -1897,16 +1903,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >               xas_unlock_irq(&xas);
> >               if (!xas_nomem(&xas, GFP_KERNEL)) {
> >                       result = SCAN_FAIL;
> > -                     goto out;
> > +                     goto rollback;
> >               }
> >       } while (1);
> >
> > -     __SetPageLocked(hpage);
> > -     if (is_shmem)
> > -             __SetPageSwapBacked(hpage);
> > -     hpage->index = start;
> > -     hpage->mapping = mapping;
> > -
> >       /*
> >        * At this point the hpage is locked and not up-to-date.
> >        * It's safe to insert it into the page cache, because nobody would
> > @@ -2123,131 +2123,128 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
> >        */
> >       try_to_unmap_flush();
> >
> > -     if (result == SCAN_SUCCEED) {
> > -             /*
> > -              * Replacing old pages with new one has succeeded, now we
> > -              * attempt to copy the contents.
> > -              */
> > -             index = start;
> > -             list_for_each_entry(page, &pagelist, lru) {
> > -                     while (index < page->index) {
> > -                             clear_highpage(hpage + (index % HPAGE_PMD_NR));
> > -                             index++;
> > -                     }
> > -                     if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
> > -                                      page) > 0) {
> > -                             result = SCAN_COPY_MC;
> > -                             break;
> > -                     }
> > -                     index++;
> > -             }
> > -             while (result == SCAN_SUCCEED && index < end) {
> > +     if (result != SCAN_SUCCEED)
> > +             goto rollback;
> > +
> > +     /*
> > +      * Replacing old pages with new one has succeeded, now we
> > +      * attempt to copy the contents.
> > +      */
> > +     index = start;
> > +     list_for_each_entry(page, &pagelist, lru) {
> > +             while (index < page->index) {
> >                       clear_highpage(hpage + (index % HPAGE_PMD_NR));
> >                       index++;
> >               }
> > +             if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
> > +                              page) > 0) {
> > +                     result = SCAN_COPY_MC;
> > +                     goto rollback;
> > +             }
> > +             index++;
> > +     }
> > +     while (index < end) {
> > +             clear_highpage(hpage + (index % HPAGE_PMD_NR));
> > +             index++;
> >       }
> >
> > -     if (result == SCAN_SUCCEED) {
> > -             /*
> > -              * Copying old pages to huge one has succeeded, now we
> > -              * need to free the old pages.
> > -              */
> > -             list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> > -                     list_del(&page->lru);
> > -                     page->mapping = NULL;
> > -                     page_ref_unfreeze(page, 1);
> > -                     ClearPageActive(page);
> > -                     ClearPageUnevictable(page);
> > -                     unlock_page(page);
> > -                     put_page(page);
> > -             }
> > +     /*
> > +      * Copying old pages to huge one has succeeded, now we
> > +      * need to free the old pages.
> > +      */
> > +     list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> > +             list_del(&page->lru);
> > +             page->mapping = NULL;
> > +             page_ref_unfreeze(page, 1);
> > +             ClearPageActive(page);
> > +             ClearPageUnevictable(page);
> > +             unlock_page(page);
> > +             put_page(page);
> > +     }
> >
> > -             xas_lock_irq(&xas);
> > -             if (is_shmem)
> > -                     __mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> > -             else
> > -                     __mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
> > +     xas_lock_irq(&xas);
> > +     if (is_shmem)
> > +             __mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> > +     else
> > +             __mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
> > +
> > +     if (nr_none) {
> > +             __mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
> > +             /* nr_none is always 0 for non-shmem. */
> > +             __mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
> > +     }
> > +     /* Join all the small entries into a single multi-index entry. */
> > +     xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> > +     xas_store(&xas, hpage);
> > +     xas_unlock_irq(&xas);
> >
> > -             if (nr_none) {
> > -                     __mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
> > -                     /* nr_none is always 0 for non-shmem. */
> > -                     __mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
> > -             }
> > -             /* Join all the small entries into a single multi-index entry. */
> > -             xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> > -             xas_store(&xas, hpage);
> > -             xas_unlock_irq(&xas);
> > +     folio = page_folio(hpage);
> > +     folio_mark_uptodate(folio);
> > +     folio_ref_add(folio, HPAGE_PMD_NR - 1);
> >
> > -             folio = page_folio(hpage);
> > -             folio_mark_uptodate(folio);
> > -             folio_ref_add(folio, HPAGE_PMD_NR - 1);
> > +     if (is_shmem)
> > +             folio_mark_dirty(folio);
> > +     folio_add_lru(folio);
> >
> > -             if (is_shmem)
> > -                     folio_mark_dirty(folio);
> > -             folio_add_lru(folio);
> > +     /*
> > +      * Remove pte page tables, so we can re-fault the page as huge.
> > +      */
> > +     result = retract_page_tables(mapping, start, mm, addr, hpage,
> > +                                  cc);
> > +     unlock_page(hpage);
> > +     goto out;
> > +
> > +rollback:
> > +     /* Something went wrong: roll back page cache changes */
> > +     xas_lock_irq(&xas);
> > +     if (nr_none) {
> > +             mapping->nrpages -= nr_none;
> > +             shmem_uncharge(mapping->host, nr_none);
> > +     }
> >
> > -             /*
> > -              * Remove pte page tables, so we can re-fault the page as huge.
> > -              */
> > -             result = retract_page_tables(mapping, start, mm, addr, hpage,
> > -                                          cc);
> > -             unlock_page(hpage);
> > -             hpage = NULL;
> > -     } else {
> > -             /* Something went wrong: roll back page cache changes */
> > -             xas_lock_irq(&xas);
> > -             if (nr_none) {
> > -                     mapping->nrpages -= nr_none;
> > -                     shmem_uncharge(mapping->host, nr_none);
> > +     xas_set(&xas, start);
> > +     xas_for_each(&xas, page, end - 1) {
> > +             page = list_first_entry_or_null(&pagelist,
> > +                             struct page, lru);
> > +             if (!page || xas.xa_index < page->index) {
> > +                     if (!nr_none)
> > +                             break;
> > +                     nr_none--;
> > +                     /* Put holes back where they were */
> > +                     xas_store(&xas, NULL);
> > +                     continue;
> >               }
> >
> > -             xas_set(&xas, start);
> > -             xas_for_each(&xas, page, end - 1) {
> > -                     page = list_first_entry_or_null(&pagelist,
> > -                                     struct page, lru);
> > -                     if (!page || xas.xa_index < page->index) {
> > -                             if (!nr_none)
> > -                                     break;
> > -                             nr_none--;
> > -                             /* Put holes back where they were */
> > -                             xas_store(&xas, NULL);
> > -                             continue;
> > -                     }
> > +             VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> >
> > -                     VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> > +             /* Unfreeze the page. */
> > +             list_del(&page->lru);
> > +             page_ref_unfreeze(page, 2);
> > +             xas_store(&xas, page);
> > +             xas_pause(&xas);
> > +             xas_unlock_irq(&xas);
> > +             unlock_page(page);
> > +             putback_lru_page(page);
> > +             xas_lock_irq(&xas);
> > +     }
> > +     VM_BUG_ON(nr_none);
> > +     /*
> > +      * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
> > +      * This undo is not needed unless failure is due to SCAN_COPY_MC.
> > +      */
> > +     if (!is_shmem && result == SCAN_COPY_MC)
> > +             filemap_nr_thps_dec(mapping);
> >
> > -                     /* Unfreeze the page. */
> > -                     list_del(&page->lru);
> > -                     page_ref_unfreeze(page, 2);
> > -                     xas_store(&xas, page);
> > -                     xas_pause(&xas);
> > -                     xas_unlock_irq(&xas);
> > -                     unlock_page(page);
> > -                     putback_lru_page(page);
> > -                     xas_lock_irq(&xas);
> > -             }
> > -             VM_BUG_ON(nr_none);
> > -             /*
> > -              * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
> > -              * This undo is not needed unless failure is due to SCAN_COPY_MC.
> > -              */
> > -             if (!is_shmem && result == SCAN_COPY_MC)
> > -                     filemap_nr_thps_dec(mapping);
> > +     xas_unlock_irq(&xas);
> >
> > -             xas_unlock_irq(&xas);
> > +     hpage->mapping = NULL;
> >
> > -             hpage->mapping = NULL;
> > -     }
> > +     unlock_page(hpage);
> > +     mem_cgroup_uncharge(page_folio(hpage));
> > +     put_page(hpage);
> >
> > -     if (hpage)
> > -             unlock_page(hpage);
> >  out:
> >       VM_BUG_ON(!list_empty(&pagelist));
> > -     if (hpage) {
> > -             mem_cgroup_uncharge(page_folio(hpage));
> > -             put_page(hpage);
> > -     }
>
> Moving this chunk seems wrong, as it can leak the huge page if
> alloc_charge_hpage() failed on mem charging, iiuc.

Yeah, good catch.

>
> And I found that keeping it seems wrong either, because if mem charge
> failed we'll uncharge even without charging it before.  But that's nothing
> about this patch alone.

We should be able to just simply check the return value. For example:

if (result == SCAN_CGROUP_CHARGE_FAIL)
    put_page(hpage);

>
> Posted a patch for this:
>
> https://lore.kernel.org/all/20230221214344.609226-1-peterx@redhat.com/
>
> I _think_ this patch will make sense after rebasing to that fix if that's
> correct, but please review it and double check.

It is ok too.


>
> Thanks,
>
> > -
> >       trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
> >       return result;
> >  }
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
>
> --
> Peter Xu
>
