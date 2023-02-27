Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494556A4AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjB0TcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjB0TcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:32:12 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C191234FA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:32:11 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id f13so12941174vsg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677526330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=syCwjb07+ozeYYldhWV5SCsjeDRV1y+ehflRxQakiIA=;
        b=o9jLTfLoXOAM9KgTs4R8oHGtv9cJ7tkDhFTQBt8Fpct/ccD7ZQ5ZIHpCCd+qk7bsPq
         yRa490+o1bKJffxsgH0c4B48pCh6iBcK9A4NlMJwkXYemabmiS4Ln2grld1/bxc5sFIT
         Ch7UTpAUy6Lc7eaiDbPMdaewbZq2kjoeHXu7M+XPzmfEqR7q10SKKhQv/vv0tJlnuxgr
         kKVdln7RPpO3l6i94NaxAMVqXfNARP/G9Pt/vQwneLjyCHeIoUI5/T+CV7LG/dNpQXVz
         ZioGH4BMUl5NwDQXCHRIDY6/22D+ebyn2mmMMhLt1Wl0pI1mnxONmohf/x1+tdw9cCXH
         00Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677526330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syCwjb07+ozeYYldhWV5SCsjeDRV1y+ehflRxQakiIA=;
        b=16uu0uizwFmyos3pG4VNXONNq9KegzMZ3vvPXPrhMoULzPfnzGxrKBet0iO49sMAeq
         tjVD8XjVlm2OFszegeHzdulmPg9VFHKW+A/oVEEZsXd+WUOS1JcWpVCBRWVtIHTtYfCJ
         MM3rGEKe0uZIRmEocfaHsVMk8jCliPZNzg6l/4FAPbSRYK1MXH+6LH+9kZo55WTa4iKn
         TvK6FFkU06Ey+7i7Dxdj6h0gVlIZQHl5NURgE4/GS5NMNjiH74JlVDULlRfnC4XVAx3m
         TJ8HswypeYowewoobM/SFrA+KWR8Zjn6aUDLg4Xhu72JnVf0m0JmGTsEfHd8VbZ05Q/j
         wi+A==
X-Gm-Message-State: AO0yUKWcSiURgpgjHLBpK9aGmaWInmnMB5j9GW6wCI0te8/ZXnO1aRkP
        42s8mfiYRA3FkrWbsKElKNPmZgztgB7tQI5RtqPd4Q==
X-Google-Smtp-Source: AK7set+upgav+/Kc6aOtPAsemxPPriSwE2AVsQvyawX1VAo7z67icPfFDCi4Pa0MnzmICb7fUS3fKMvNaNuIBs9k1KQ=
X-Received: by 2002:a05:6122:1681:b0:401:d1f4:bccf with SMTP id
 1-20020a056122168100b00401d1f4bccfmr8803967vkl.0.1677526330331; Mon, 27 Feb
 2023 11:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-13-jthoughton@google.com> <Y/0BpWmWNGOxNqXx@monkey>
In-Reply-To: <Y/0BpWmWNGOxNqXx@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 27 Feb 2023 11:31:33 -0800
Message-ID: <CADrL8HW4C=b_5Ryaz+g3+9KTkwTxoHT0YrCy28Y00J9kwwYvtQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/46] hugetlb: add hugetlb_alloc_pmd and hugetlb_alloc_pte
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
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

"

On Mon, Feb 27, 2023 at 11:17 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 02/18/23 00:27, James Houghton wrote:
> > These functions are used to allocate new PTEs below the hstate PTE. This
> > will be used by hugetlb_walk_step, which implements stepping forwards in
> > a HugeTLB high-granularity page table walk.
> >
> > The reasons that we don't use the standard pmd_alloc/pte_alloc*
> > functions are:
> >  1) This prevents us from accidentally overwriting swap entries or
> >     attempting to use swap entries as present non-leaf PTEs (see
> >     pmd_alloc(); we assume that !pte_none means pte_present and
> >     non-leaf).
> >  2) Locking hugetlb PTEs can different than regular PTEs. (Although, as
> >     implemented right now, locking is the same.)
> >  3) We can maintain compatibility with CONFIG_HIGHPTE. That is, HugeTLB
> >     HGM won't use HIGHPTE, but the kernel can still be built with it,
> >     and other mm code will use it.
> >
> > When GENERAL_HUGETLB supports P4D-based hugepages, we will need to
> > implement hugetlb_pud_alloc to implement hugetlb_walk_step.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index eeacadf3272b..9d839519c875 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -72,6 +72,11 @@ unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> >
> >  bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> >
> > +pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +             unsigned long addr);
> > +pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +             unsigned long addr);
> > +
> >  struct hugepage_subpool {
> >       spinlock_t lock;
> >       long count;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6c74adff43b6..bb424cdf79e4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -483,6 +483,120 @@ static bool has_same_uncharge_info(struct file_region *rg,
> >  #endif
> >  }
> >
> > +/*
> > + * hugetlb_alloc_pmd -- Allocate or find a PMD beneath a PUD-level hpte.
> > + *
> > + * This is meant to be used to implement hugetlb_walk_step when one must go to
> > + * step down to a PMD. Different architectures may implement hugetlb_walk_step
> > + * differently, but hugetlb_alloc_pmd and hugetlb_alloc_pte are architecture-
> > + * independent.
> > + *
> > + * Returns:
> > + *   On success: the pointer to the PMD. This should be placed into a
> > + *               hugetlb_pte. @hpte is not changed.
> > + *   ERR_PTR(-EINVAL): hpte is not PUD-level
> > + *   ERR_PTR(-EEXIST): there is a non-leaf and non-empty PUD in @hpte
>
> I often get this confused, should this really be 'non-leaf'?  Because, ...

This comment is wrong, it should be "non-empty PUD that is not
pointing to page tables". Maybe it would be better to say "-EEXIST
unless @hpte is pud_none() or already points to page tables".

In this commit, PTEs containing PTE markers are treated as non-empty
here (and not pointing to page tables), but after the commit "hugetlb:
split PTE markers when doing HGM walks", they are treated as empty.
I'll update the comment in that commit as well.

>
> > + *   ERR_PTR(-ENOMEM): could not allocate the new PMD
> > + */
> > +pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +             unsigned long addr)
> > +{
> > +     spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
> > +     pmd_t *new;
> > +     pud_t *pudp;
> > +     pud_t pud;
> > +
> > +     if (hpte->level != HUGETLB_LEVEL_PUD)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     pudp = (pud_t *)hpte->ptep;
> > +retry:
> > +     pud = READ_ONCE(*pudp);
> > +     if (likely(pud_present(pud)))
> > +             return unlikely(pud_leaf(pud))
> > +                     ? ERR_PTR(-EEXIST)
> > +                     : pmd_offset(pudp, addr);
>
> ... it seems we return -EEXIST in the pud_leaf case.

This code is correct. :) We don't want to overwrite a leaf. Sorry for
the confusion!
