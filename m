Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40869F849
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjBVPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBVPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:47:34 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5D38033
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:47:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z10so4358957pgr.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6xhy0KduJrjH6x8qxkMthBBJxGQOVTbwtgaxtb34xHw=;
        b=GbSXcc4NhVcdNgz9DdYITwiNg1vbTRf8pAQqpM4qs5UcTbdQ+bH8qDJkn3qdZEqiuR
         Oc+Je+iuMkH+0KuiqGUSnAnyfABgPXHZAynNAVTUdzAt0V1w0ZWRThbr25ZAFxtzGZm9
         FnUcma1jDwAWtwdJo2MXgKmEK2aUip+IATN3LJBelPjzvqKviiNCaDtmqY1XTXVimHUR
         DnnKrQYhu+PMUF/HvK0OqQxvSeinzGeK71lVawXG/JpVjS27mToqOZAzIWsfKoA475QY
         nnXl1RvumhCy2/uLHvn8qjHeftqgnlBNg7QnJ5RqAstUnA5TQpRnLDvUlU4K0e3AxoA+
         TrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xhy0KduJrjH6x8qxkMthBBJxGQOVTbwtgaxtb34xHw=;
        b=oDwyU8P3pgbkdfis152peX0axrJ58p/PH+ruBoplzYGaDMjgXLXa1H3EARkWMdLuD2
         HV0/sfbpLx2Sv7xNWRMK/D8V9t5hfYiEcTldmH4o1KCIZDagIDU5XOeRX9TeSvE3/0EM
         jsIcsLiCi2njrcqg53nRHp64fK91jn2HtoQ5Amwq63IlSUPgc7BIg7vMeIoWwHBfggL6
         3X6Mi7d9kwjk+PqRYaL49sJLvhUxPKG4mCGBTz7kNLMNV0dwrlqdF/P3wwW5zrMsRQy5
         vdTEFFmJQkjjZCQIpIOC0sEyaHjtobBJum3/HKqSwgNXAQKmbxwTSAnlyxwqdd7/9j/G
         V+hA==
X-Gm-Message-State: AO0yUKUNnvymO8S5z99FTluHaR1MckfJ/eu1O2JTHUF5QSaIbKw+CP9X
        yIZkTSCc6Wt15tNqL8utB+1pshAiRX07PugOEH9+Yw==
X-Google-Smtp-Source: AK7set+iW5vmjMXMKi2kWxkLgEa9gEt7kxmgM+ZBl0soLAIEwTPS5vc7OXxQlzsWMgYcCUrp2o0FUlpqUizYCkQWYBg=
X-Received: by 2002:a63:340d:0:b0:4fb:3591:c608 with SMTP id
 b13-20020a63340d000000b004fb3591c608mr1090181pga.4.1677080852735; Wed, 22 Feb
 2023 07:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-18-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-18-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 22 Feb 2023 07:46:55 -0800
Message-ID: <CADrL8HVZN1CjV3=azvKaJs4h_aTjfmrKpv9O6UVyDiQDdFyEjQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/46] hugetlbfs: do a full walk to check if vma maps a page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 17, 2023 at 4:29 PM James Houghton <jthoughton@google.com> wrote:
>
> Because it is safe to do so, do a full high-granularity page table walk
> to check if the page is mapped.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index cfd09f95551b..c0ee69f0418e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -386,17 +386,24 @@ static void hugetlb_delete_from_page_cache(struct folio *folio)
>  static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
>                                 unsigned long addr, struct page *page)
>  {
> -       pte_t *ptep, pte;
> +       pte_t pte;
> +       struct hugetlb_pte hpte;
>
> -       ptep = hugetlb_walk(vma, addr, huge_page_size(hstate_vma(vma)));
> -       if (!ptep)
> +       if (hugetlb_full_walk(&hpte, vma, addr))
>                 return false;
>
> -       pte = huge_ptep_get(ptep);
> +       pte = huge_ptep_get(hpte.ptep);
>         if (huge_pte_none(pte) || !pte_present(pte))
>                 return false;
>
> -       if (pte_page(pte) == page)
> +       if (unlikely(!hugetlb_pte_present_leaf(&hpte, pte)))
> +               /*
> +                * We raced with someone splitting us, and the only case
> +                * where this is impossible is when the pte was none.
> +                */
> +               return false;
> +
> +       if (compound_head(pte_page(pte)) == page)
>                 return true;
>
>         return false;
> --
> 2.39.2.637.g21b0678d19-goog
>

I think this patch is actually incorrect.

This function is *supposed* to check if the page is mapped at all in
this VMA, but really we're only checking if the base address of the
page is mapped. If we did the 'hugetlb_vma_maybe_maps_page' approach
that I did previously and returned 'true' if
!hugetlb_pte_present_leaf(), then this code would be correct again.

But what I really think this function should do is just call
page_vma_mapped_walk(). We're sort of reimplementing it here anyway.
Unless someone disagrees, I'll do this for v3.
