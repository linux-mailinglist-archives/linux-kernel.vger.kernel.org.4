Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A993604FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJSScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJSSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:31:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F181D0D56
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:31:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p6-20020a17090a748600b002103d1ef63aso770994pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yM0uwPnj6p1l0Vw8Vwd+2ABZhuvsHqcxHJob6ITYEUE=;
        b=C+O4qNrSYj7KA1j+eCNL+Ay7VrHzRJXkWUQ2b6oXQQA/T4lowFXpfzpWsEsS5aJK8H
         F/k79iImu0EYUEqiHhhE0pgJcT5KBFpFvO3T/9uUM8wS+bFvwUA42tfp9tParmphQ0Gc
         U0d5FCUKSBhANP3iTzrLc1aIL/gQJQN2vPYgH8Zj7OPLoLeSytrz/H4Oq7q+/5NkO3lQ
         +pSemIEr10NjFQxZ6vCUzhVpaBV2kOO2L9fqMU1gLOLHqAZ2BPpIYfT1u5LTrOxPi1x+
         7gJuF8ukdDmr/ytYr3TY8pilGLNhv90kTVkoYyDx32mIAYSBBUlJVhl0AfXNH4J0/tzw
         NI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM0uwPnj6p1l0Vw8Vwd+2ABZhuvsHqcxHJob6ITYEUE=;
        b=NADOtfy/Fu0Uq/BGMhdwEHTBfCHtGi9cYjeh5QK4itx2XHKVvrdztJPy9FHqJERp3b
         yfAu3Vx7f/f7dxhISQ9kQR79Y5mMEvX2BuybM6VzplCyWp/fEHpLsLia/qertmcrCTMo
         9klO2ncTTBZA/G9YDqEBEv47HhpWaGjtFgve1qGLDg0oFPTQovbAOnXwNPXLBn4mD/cE
         DxEAWid84tf4NImxGyPIBFPkWhuruwTbcgcdqFUhxH24RjE5l4QaVoxGp8tWBX9UFewX
         83ZsMw50e2cQjgi2g5Dm9MotD64tFwhwB6m4tlXwAgbdag8rxc6QmaWMvL2Kzp/Wi6b4
         UspQ==
X-Gm-Message-State: ACrzQf0G1Gei/eBDKEJp8aVa77qi+I9MiWOuhRgpKlflsDgA1HjVrREV
        jHoDaUEEt96hYTrzmb+vJ2Oafol+xWD/UsPpwMU=
X-Google-Smtp-Source: AMsMyM7wfgoNmD59GgTzTHHz2vdkzDHJoKgejRCMy0H+v9wmEhS0AeNx7ASEW6sDS2ebG48W9deqSp/dFv2yM8BKpAE=
X-Received: by 2002:a17:90b:1c87:b0:20a:e485:4e21 with SMTP id
 oo7-20020a17090b1c8700b0020ae4854e21mr11232233pjb.194.1666204280538; Wed, 19
 Oct 2022 11:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221018200125.848471-1-jthoughton@google.com>
In-Reply-To: <20221018200125.848471-1-jthoughton@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Oct 2022 11:31:08 -0700
Message-ID: <CAHbLzkoAeXhpJ2_eM6uYU9kuqNsT25NubOZZG6E1mFngYREuPg@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
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

On Tue, Oct 18, 2022 at 1:01 PM James Houghton <jthoughton@google.com> wrote:
>
> This change is very similar to the change that was made for shmem [1],
> and it solves the same problem but for HugeTLBFS instead.
>
> Currently, when poison is found in a HugeTLB page, the page is removed
> from the page cache. That means that attempting to map or read that
> hugepage in the future will result in a new hugepage being allocated
> instead of notifying the user that the page was poisoned. As [1] states,
> this is effectively memory corruption.
>
> The fix is to leave the page in the page cache. If the user attempts to
> use a poisoned HugeTLB page with a syscall, the syscall will fail with
> EIO, the same error code that shmem uses. For attempts to map the page,
> the thread will get a BUS_MCEERR_AR SIGBUS.
>
> [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Thanks for the patch. Yes, we should do the same thing for hugetlbfs.
When I was working on shmem I did look into hugetlbfs too. But the
problem is we actually make the whole hugetlb page unavailable even
though just one 4K sub page is hwpoisoned. It may be fine to 2M
hugetlb page, but a lot of memory may be a huge waste for 1G hugetlb
page, particular for the page fault path.

So I discussed this with Mike offline last year, and I was told Google
was working on PTE mapped hugetlb page. That should be able to solve
the problem. And we'd like to have the high-granularity hugetlb
mapping support as the predecessor.

There were some other details, but I can't remember all of them, I
have to refresh my memory by rereading the email discussions...

> ---
>  fs/hugetlbfs/inode.c | 13 ++++++-------
>  mm/hugetlb.c         |  4 ++++
>  mm/memory-failure.c  |  5 ++++-
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index fef5165b73a5..7f836f8f9db1 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -328,6 +328,12 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>                 } else {
>                         unlock_page(page);
>
> +                       if (PageHWPoison(page)) {
> +                               put_page(page);
> +                               retval = -EIO;
> +                               break;
> +                       }
> +
>                         /*
>                          * We have the page, copy it to user space buffer.
>                          */
> @@ -1111,13 +1117,6 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>  static int hugetlbfs_error_remove_page(struct address_space *mapping,
>                                 struct page *page)
>  {
> -       struct inode *inode = mapping->host;
> -       pgoff_t index = page->index;
> -
> -       hugetlb_delete_from_page_cache(page_folio(page));
> -       if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
> -               hugetlb_fix_reserve_counts(inode);
> -
>         return 0;
>  }
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 97896165fd3f..5120a9ccbf5b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6101,6 +6101,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>
>         ptl = huge_pte_lock(h, dst_mm, dst_pte);
>
> +       ret = -EIO;
> +       if (PageHWPoison(page))
> +               goto out_release_unlock;
> +
>         /*
>          * We allow to overwrite a pte marker: consider when both MISSING|WP
>          * registered, we firstly wr-protect a none pte which has no page cache
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 145bb561ddb3..bead6bccc7f2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1080,6 +1080,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>         int res;
>         struct page *hpage = compound_head(p);
>         struct address_space *mapping;
> +       bool extra_pins = false;
>
>         if (!PageHuge(hpage))
>                 return MF_DELAYED;
> @@ -1087,6 +1088,8 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>         mapping = page_mapping(hpage);
>         if (mapping) {
>                 res = truncate_error_page(hpage, page_to_pfn(p), mapping);
> +               /* The page is kept in page cache. */
> +               extra_pins = true;
>                 unlock_page(hpage);
>         } else {
>                 unlock_page(hpage);
> @@ -1104,7 +1107,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>                 }
>         }
>
> -       if (has_extra_refcount(ps, p, false))
> +       if (has_extra_refcount(ps, p, extra_pins))
>                 res = MF_FAILED;
>
>         return res;
> --
> 2.38.0.413.g74048e4d9e-goog
>
