Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F374632C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGCTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGCTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:06:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A25CA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:06:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so69501cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688411194; x=1691003194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtH9VX9zQlOrzH25LrN35KBx/OwKQshilIn0Tyi1LzU=;
        b=XV8ARzOexIi9d51XEZ4LBwpQAJfh5eLRI6V71U/cSAX/3Rg0NKvL7BuFP2kQCO4pUa
         LYbGqtiacCx4rIVo3E3/+XJFT7/WLipNZh+4ki9QemJgxTL+HFWmc/TeuKo9oE6hdDqH
         W7TVYUE+hhWYQkCsmc91r55R+Nk4qgs5eW3Ay1X0snZDPJgYbnJNZmMsOTl4monY7Z/q
         ubHOeI6ivKqY+G2p7RSmO64ddhfjiXzB2STA3f7uyMDy6u7ccEA1zrBxaZb99ZioxvpE
         KjBYYsnFDL5l+7jEbQc9f+eSqvQ9XfC36SgyCHNxx6x1DRr94vDMexn+CYtY4lxa/OX0
         Hk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411194; x=1691003194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtH9VX9zQlOrzH25LrN35KBx/OwKQshilIn0Tyi1LzU=;
        b=bN01VQh7vAjF0q7jx2iPiN/7ng99Vh0LoS2HXRp8eqkfc3N5wieF/1hDPVlR+UIngj
         gbuWgbnb0v77dHXrZv++mHsTIX0lxhLdhV3pWm0x1NAPm1EHC4cAnMPvZ7GiykXC96tk
         qOro3UMQFIJpe4u9PzMPfkzH9GSX28ZUMyxXyzSx/5rgVwEDgsiG19R9ficUAkl8fCJn
         DUtRHHFuZ7rA6VK8ke1T0aI1SB6Fwe9iN2bK6c5eL91W3bINO4Vm6pPnrsfOqviinXW3
         MVkvx18idZfMwFI8fUzRJbeN3XM7G5Av9TI7tlwBa2a35jkcBAaI+6odaEUNgsIy8Fs8
         Mzfg==
X-Gm-Message-State: ABy/qLa5YE96uOx4jKC18P9rRJUBZdPjq/UBKYNDmd7fWelACnjvhAnE
        OWxrzr3HsacAFYqnxZDfbe2u4LHOOWfpeDyNmBAjvA==
X-Google-Smtp-Source: APBJJlHON4TWi0qQ1gFxI43A3FgOyVsahUaTj0rQqg84esGxECbdTYLcC4IPdg0vrlxsJRPFs13pHyCRSEf7eJpW79w=
X-Received: by 2002:ac8:4e4c:0:b0:3f6:97b4:1a4a with SMTP id
 e12-20020ac84e4c000000b003f697b41a4amr12864qtw.20.1688411193668; Mon, 03 Jul
 2023 12:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com> <20230703135330.1865927-2-ryan.roberts@arm.com>
In-Reply-To: <20230703135330.1865927-2-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 13:05:57 -0600
Message-ID: <CAOUHufYtW+6Svaq7pcyBiModTSKn1VU-LKxB_Xwnja=f83X2YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> In preparation for FLEXIBLE_THP support, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> "small" pages scheme.

Nit: In this case, all *subpages*  are accounted using the *order-0
folio* (or base page) scheme.

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yu Zhao <yuzhao@google.com>

>  mm/rmap.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1d8369549424..82ef5ba363d1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1278,31 +1278,43 @@ void page_add_anon_rmap(struct page *page, struct=
 vm_area_struct *vma,
>   * This means the inc-and-test can be bypassed.
>   * The folio does not have to be locked.
>   *
> - * If the folio is large, it is accounted as a THP.  As the folio
> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>   * is new, it's assumed to be mapped exclusively by a single process.
>   */
>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct =
*vma,
>                 unsigned long address)
>  {
> -       int nr;
> +       int nr =3D folio_nr_pages(folio);
> +       int i;
> +       struct page *page;
>
> -       VM_BUG_ON_VMA(address < vma->vm_start || address >=3D vma->vm_end=
, vma);
> +       VM_BUG_ON_VMA(address < vma->vm_start ||
> +                       address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>         __folio_set_swapbacked(folio);
>
> -       if (likely(!folio_test_pmd_mappable(folio))) {
> +       if (!folio_test_large(folio)) {
>                 /* increment count (starts at -1) */
>                 atomic_set(&folio->_mapcount, 0);
> -               nr =3D 1;
> +               __page_set_anon_rmap(folio, &folio->page, vma, address, 1=
);
> +       } else if (!folio_test_pmd_mappable(folio)) {
> +               /* increment count (starts at 0) */
> +               atomic_set(&folio->_nr_pages_mapped, nr);
> +
> +               page =3D &folio->page;
> +               for (i =3D 0; i < nr; i++, page++, address +=3D PAGE_SIZE=
) {
> +                       /* increment count (starts at -1) */
> +                       atomic_set(&page->_mapcount, 0);
> +                       __page_set_anon_rmap(folio, page, vma, address, 1=
);
> +               }

Nit: use folio_page(), e.g.,

  } else if (!folio_test_pmd_mappable(folio)) {
    int i;

    for (i =3D 0; i < nr; i++) {
      struct page *page =3D folio_page(folio, i);

      /* increment count (starts at -1) */
      atomic_set(&page->_mapcount, 0);
      __page_set_anon_rmap(folio, page, vma, address + PAGE_SIZE * i, 1);
    }
    /* increment count (starts at 0) */
    atomic_set(&folio->_nr_pages_mapped, nr);
  } else {

>         } else {
>                 /* increment count (starts at -1) */
>                 atomic_set(&folio->_entire_mapcount, 0);
>                 atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> -               nr =3D folio_nr_pages(folio);
>                 __lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
> +               __page_set_anon_rmap(folio, &folio->page, vma, address, 1=
);
>         }
>
>         __lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
> -       __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
