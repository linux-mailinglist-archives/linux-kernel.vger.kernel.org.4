Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBACE686D31
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBARhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBARgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:36:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450F13DDD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:36:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso2971094pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lNNBl9TG5gq1FAjUOQrlfZPYidvGY/eJUnN7u2ZEXHk=;
        b=HLjT6gQT3T0IDOJdrOk38fSJKz+tjYdMFkjDZT0UlOusLFPQbx9clVZsB8cJxKCfQG
         AUNykTCEV9U6DRTsfQh6/XuwXAJVUqno5T67n9Nk7wx6QOgEJS44fJsvnRG5puZlUVIu
         Wh1Lo7ihEQhLTiUF4nL4firnT9R11xIgTodShfaOJh1afnYJoost0yJ87fknYO8XI/aq
         Yc6WDeRWfr7zvmxj2X0aDRCX8htv+58XlARI8XXGnJEu8wFmEIXYohyvEYwObfINBIqY
         VU68MzIPIRyc91xRBAEsnyU41vMaolDkL1ovWC15TiUL7UdZMFJCQAnKjiveV8RDT44O
         Ywew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNNBl9TG5gq1FAjUOQrlfZPYidvGY/eJUnN7u2ZEXHk=;
        b=tij4CHCJh+VoJ5HxaNYemq3aueI0RRq55PWm0OMlfgr8yv34EUfS89v33wE6L7/2em
         P9aMlZIy94j2rcm2KCgrISSs/7PKlZD7toQgY8tgWXFuw9JA1pDtxFEBxp2f6PqpGNQ8
         U3nv2ikg8jXr8oTH2pA3cOEcqNzuXHh428+12/wzBRF/UAmr3mbmI/QstxQw9+u4mceZ
         YhsTG8ziF3ETXzP7xQbWuDNv+KgaoHminXgKGv7ADCuT18nY1UVhdKhbj674fg0CGfsl
         fhNu+N2C2qjWTRrxXJ/6XhHsx4c9lsK/1xdC1HujOh+DAsxSsa6ZXlokrkYTCGMfD3jf
         wVCA==
X-Gm-Message-State: AO0yUKUVpNzZkOE2pnFMG2zFPkChWTwuRcZEZn3UiyOaULJ68mTnA09v
        haCW1afDsdp2Jub6E9jNAPsdKqDtOyQXoultN1aE8udYvD8=
X-Google-Smtp-Source: AK7set/A7YrXJhNR3dJLJzfHSRgvF4TpgQVc/ddea8Qf0uZJbygZ8rMlbWdqvyI8Gfm8AmHhH0DuXcZzNQwQByTYSgQ=
X-Received: by 2002:a17:90a:7f82:b0:22c:377c:3612 with SMTP id
 m2-20020a17090a7f8200b0022c377c3612mr545267pjl.60.1675273009324; Wed, 01 Feb
 2023 09:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20230201034137.2463113-1-stevensd@google.com>
In-Reply-To: <20230201034137.2463113-1-stevensd@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 1 Feb 2023 09:36:37 -0800
Message-ID: <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
To:     David Stevens <stevensd@chromium.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 31, 2023 at 7:42 PM David Stevens <stevensd@chromium.org> wrote:
>
> From: David Stevens <stevensd@chromium.org>
>
> Collapsing memory in a vma that has an armed userfaultfd results in
> zero-filling any missing pages, which breaks user-space paging for those
> filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
> pages in shmem reached via scanning a vma with an armed userfaultfd if
> doing so would zero-fill any pages.
>
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  mm/khugepaged.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 79be13133322..48e944fb8972 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1736,8 +1736,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>   *    + restore gaps in the page cache;
>   *    + unlock and free huge page;
>   */
> -static int collapse_file(struct mm_struct *mm, unsigned long addr,
> -                        struct file *file, pgoff_t start,
> +static int collapse_file(struct mm_struct *mm, struct vm_area_struct *vma,
> +                        unsigned long addr, struct file *file, pgoff_t start,
>                          struct collapse_control *cc)
>  {
>         struct address_space *mapping = file->f_mapping;
> @@ -1784,6 +1784,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>          * be able to map it or use it in another way until we unlock it.
>          */
>
> +       if (is_shmem)
> +               mmap_read_lock(mm);

If you release mmap_lock before then reacquire it here, the vma is not
trusted anymore. It is not safe to use the vma anymore.

Since you already read uffd_was_armed before releasing mmap_lock, so
you could pass it directly to collapse_file w/o dereferencing vma
again. The problem may be false positive (not userfaultfd armed
anymore), but it should be fine. Khugepaged could collapse this area
in the next round.

Also +userfaultfd folks.

> +
>         xas_set(&xas, start);
>         for (index = start; index < end; index++) {
>                 struct page *page = xas_next(&xas);
> @@ -1792,6 +1795,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>                 VM_BUG_ON(index != xas.xa_index);
>                 if (is_shmem) {
>                         if (!page) {
> +                               if (userfaultfd_armed(vma)) {
> +                                       result = SCAN_EXCEED_NONE_PTE;
> +                                       goto xa_locked;
> +                               }
>                                 /*
>                                  * Stop if extent has been truncated or
>                                  * hole-punched, and is now completely
> @@ -2095,6 +2102,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>                 hpage->mapping = NULL;
>         }
>
> +       if (is_shmem)
> +               mmap_read_unlock(mm);
>         if (hpage)
>                 unlock_page(hpage);
>  out:
> @@ -2108,8 +2117,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>         return result;
>  }
>
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> -                                   struct file *file, pgoff_t start,
> +static int hpage_collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
> +                                   unsigned long addr, struct file *file, pgoff_t start,
>                                     struct collapse_control *cc)
>  {
>         struct page *page = NULL;
> @@ -2118,6 +2127,9 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>         int present, swap;
>         int node = NUMA_NO_NODE;
>         int result = SCAN_SUCCEED;
> +       bool uffd_was_armed = userfaultfd_armed(vma);
> +
> +       mmap_read_unlock(mm);
>
>         present = 0;
>         swap = 0;
> @@ -2193,13 +2205,16 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>         }
>         rcu_read_unlock();
>
> +       if (uffd_was_armed && present < HPAGE_PMD_NR)
> +               result = SCAN_EXCEED_SWAP_PTE;
> +
>         if (result == SCAN_SUCCEED) {
>                 if (cc->is_khugepaged &&
>                     present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
>                         result = SCAN_EXCEED_NONE_PTE;
>                         count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>                 } else {
> -                       result = collapse_file(mm, addr, file, start, cc);
> +                       result = collapse_file(mm, vma, addr, file, start, cc);
>                 }
>         }
>
> @@ -2207,8 +2222,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>         return result;
>  }
>  #else
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> -                                   struct file *file, pgoff_t start,
> +static int hpage_collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
> +                                   unsigned long addr, struct file *file, pgoff_t start,
>                                     struct collapse_control *cc)
>  {
>         BUILD_BUG();
> @@ -2304,8 +2319,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>                                 pgoff_t pgoff = linear_page_index(vma,
>                                                 khugepaged_scan.address);
>
> -                               mmap_read_unlock(mm);
> -                               *result = hpage_collapse_scan_file(mm,
> +                               *result = hpage_collapse_scan_file(mm, vma,
>                                                                    khugepaged_scan.address,
>                                                                    file, pgoff, cc);
>                                 mmap_locked = false;
> @@ -2656,9 +2670,8 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>                         struct file *file = get_file(vma->vm_file);
>                         pgoff_t pgoff = linear_page_index(vma, addr);
>
> -                       mmap_read_unlock(mm);
>                         mmap_locked = false;
> -                       result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> +                       result = hpage_collapse_scan_file(mm, vma, addr, file, pgoff,
>                                                           cc);
>                         fput(file);
>                 } else {
> --
> 2.39.1.456.gfc5497dd1b-goog
>
>
