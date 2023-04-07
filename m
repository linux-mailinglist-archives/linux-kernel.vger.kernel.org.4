Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC86DA7B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjDGC27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDGC25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:28:57 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BD4696
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:28:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p15so47957015ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680834535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GxqrDFIK8A2p38p68cfxj81fd2IhJuglmJgqkZLp48=;
        b=Cn/Pth/cWuUWjf+rDV5ExZ8oYTPSaaBCwfXA87u3Z2iGqdxBfr/jzZMAjSGoTJf52S
         1FOQVO1naOUhIfYesZgK/HcG3YldMbqquKn40XH0dP2DQxQBX7+3jTSwfqCdY5hzPoHX
         zyVghfeRNQtnUm/HmYYpuujPh3sNl7wVuM56Y/pBQzZb84r3YugPiy+XQkYYjfyDQ5bu
         8E5nwzOHpZmq61cn4RXaeNkxpGKr+G/ZZYmwkVB3EJCrdjm+PqKKb/vHqtWKDNce5h21
         rVxX7K4/x9/vdEcfAFK3tJdneB9IB/GYuUuv0VGFUMzdovdOrAU1TZwPJcMIMoNjjbe6
         P1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680834535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GxqrDFIK8A2p38p68cfxj81fd2IhJuglmJgqkZLp48=;
        b=6pJU0OBsom130ZMh2Fl+PJ+OTClaCbyXUi8zZXTpoYsTEaiMnFdbprZ6smJUd/A+OP
         yIA8BfwC+w8nBACQ5jPLt05nV223mpo2Af7Iw9BmDZdqdne6PmhgRiZUwXCYIa+Nkq0w
         kH3N1KKFufZoS5bjWrado6EyrcWzZj/hE+/FlW5hW+xIhoud6F1D+8eu/CwveRf+rWae
         CGptFzSzscpPz5FK6TH22mE2A4uLqSVH2vGUiX2q4F+on5lImkL0RhBzYIYh3//pZT0h
         KzCh05KEMxXcehSu3dOBEYyEVsF7o9Uh5iB5mIgJddNuy+vB5Z5h27Lt4GRYHSjIJV97
         kEXA==
X-Gm-Message-State: AAQBX9e4APyJBUYeavO8Plooi4mbdW3L1T19bjPCVp7/tf4a58DTTIXD
        WWTmnKWmPvuRUy6BOnTyzKLGXce2ghEos8lR1/s=
X-Google-Smtp-Source: AKy350a5SeIQsKVYJdgtl96+OyCikyg+SeJGV4dzU/E0F9UwWclqV8kp6h3E2oAAZG15Qov0POcu1OW8z0ITckhiIps=
X-Received: by 2002:a25:d10c:0:b0:b79:22d7:95ff with SMTP id
 i12-20020a25d10c000000b00b7922d795ffmr961662ybg.2.1680834535288; Thu, 06 Apr
 2023 19:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093937.945725-1-zhangpeng362@huawei.com> <20230331093937.945725-4-zhangpeng362@huawei.com>
In-Reply-To: <20230331093937.945725-4-zhangpeng362@huawei.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 6 Apr 2023 19:28:44 -0700
Message-ID: <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user() to copy_folio_from_user()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        mike.kravetz@oracle.com, sidhartha.kumar@oracle.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 2:41=E2=80=AFAM Peng Zhang <zhangpeng362@huawei.com=
> wrote:
>
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Replace copy_huge_page_from_user() with copy_folio_from_user().
> copy_folio_from_user() does the same as copy_huge_page_from_user(), but
> takes in a folio instead of a page. Convert page_kaddr to kaddr in
> copy_folio_from_user() to do indenting cleanup.
>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/mm.h |  7 +++----
>  mm/hugetlb.c       |  5 ++---
>  mm/memory.c        | 26 ++++++++++++--------------
>  mm/userfaultfd.c   |  6 ++----
>  4 files changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e249208f8fbe..cf4d773ca506 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3682,10 +3682,9 @@ extern void copy_user_huge_page(struct page *dst, =
struct page *src,
>                                 unsigned long addr_hint,
>                                 struct vm_area_struct *vma,
>                                 unsigned int pages_per_huge_page);
> -extern long copy_huge_page_from_user(struct page *dst_page,
> -                               const void __user *usr_src,
> -                               unsigned int pages_per_huge_page,
> -                               bool allow_pagefault);
> +long copy_folio_from_user(struct folio *dst_folio,
> +                          const void __user *usr_src,
> +                          bool allow_pagefault);
>
>  /**
>   * vma_is_special_huge - Are transhuge page-table entries considered spe=
cial?
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7e4a80769c9e..aade1b513474 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6217,9 +6217,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>                         goto out;
>                 }
>
> -               ret =3D copy_huge_page_from_user(&folio->page,
> -                                               (const void __user *) src=
_addr,
> -                                               pages_per_huge_page(h), f=
alse);
> +               ret =3D copy_folio_from_user(folio, (const void __user *)=
 src_addr,
> +                                          false);
>
>                 /* fallback to copy_from_user outside mmap_lock */
>                 if (unlikely(ret)) {
> diff --git a/mm/memory.c b/mm/memory.c
> index 808f354bce65..4976422b6979 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5868,35 +5868,33 @@ void copy_user_huge_page(struct page *dst, struct=
 page *src,
>         process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &=
arg);
>  }
>
> -long copy_huge_page_from_user(struct page *dst_page,
> -                               const void __user *usr_src,
> -                               unsigned int pages_per_huge_page,
> -                               bool allow_pagefault)
> +long copy_folio_from_user(struct folio *dst_folio,
> +                          const void __user *usr_src,
> +                          bool allow_pagefault)
>  {
> -       void *page_kaddr;
> +       void *kaddr;
>         unsigned long i, rc =3D 0;
> -       unsigned long ret_val =3D pages_per_huge_page * PAGE_SIZE;
> +       unsigned int nr_pages =3D folio_nr_pages(dst_folio);
> +       unsigned long ret_val =3D nr_pages * PAGE_SIZE;
>         struct page *subpage;
>
> -       for (i =3D 0; i < pages_per_huge_page; i++) {
> -               subpage =3D nth_page(dst_page, i);
> -               page_kaddr =3D kmap_local_page(subpage);
> +       for (i =3D 0; i < nr_pages; i++) {
> +               subpage =3D folio_page(dst_folio, i);
> +               kaddr =3D kmap_local_page(subpage);
>                 if (!allow_pagefault)
>                         pagefault_disable();
> -               rc =3D copy_from_user(page_kaddr,
> -                               usr_src + i * PAGE_SIZE, PAGE_SIZE);
> +               rc =3D copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAG=
E_SIZE);
>                 if (!allow_pagefault)
>                         pagefault_enable();
> -               kunmap_local(page_kaddr);
> +               kunmap_local(kaddr);
>
>                 ret_val -=3D (PAGE_SIZE - rc);
>                 if (rc)
>                         break;
>
> -               flush_dcache_page(subpage);
> -
>                 cond_resched();
>         }
> +       flush_dcache_folio(dst_folio);
>         return ret_val;
>  }

Moving the flush_dcache_page() outside the loop to be
flush_dcache_folio() changes the behavior of the function.

Initially, if it fails to copy the entire page, the function breaks out
of the loop and returns the number of unwritten bytes without
flushing the page from the cache. Now if it fails, it will still flush
out the page it failed on, as well as any later pages it may not
have gotten to yet.
