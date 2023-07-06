Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064674A3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGFSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGFSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:25:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD31BF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:25:27 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5700b15c12fso12784427b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688667927; x=1691259927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWFgfPgGoLKqTDSSqG8QcMK5uhrLKHKXGtxaWQuRFrs=;
        b=TmLg7EeANHof3EJKbciWU5J8LMsEIwR/OHNvoUdluWhILf99UZmTNILMzHFezQ2Oae
         bfWpuZnKo8ESL6gU4PVuanKSs9u2IkCt1ZFUrEmIYDIm2Y1IQwbqN5Y96bf5VDKs4fK6
         +UIc/fXP1uZzC4+ufeNTUQuOwyLQymZrH8myYOrMOHhKutRzzLJV9AInKgWi4q1NRCIk
         tF0Gr6D1EzNKQ1R5PC4Xurb8OR4HHnjz4nnKLiI0l3PxqnFnhJjV2WQVY+bibMhXrGE0
         wxXBl82wvk9to6Yrl9iMmKcaMhMQOjXn6U9LRDcqbQsKttPzLHMb+/MFFWGA/Ofy+RHV
         E2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667927; x=1691259927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWFgfPgGoLKqTDSSqG8QcMK5uhrLKHKXGtxaWQuRFrs=;
        b=TgmB3ttJIz9LcGZxd2DgxfeSV8XCGfUjSZ6qZzufkyWpZ+M3HNoahtt+siN9KQFew+
         8KiVPTO51cwepcL/Jb8PWlscGDFNVXo6R+Jddl9r+tm94QKJIK3rLTd6lA2LiqaWNAQt
         gCs9qIf9QdYXDeX0bovQdrU6ja2mb4XSKeFT0pmiKGxv6OOJXUEL7WQD3SJxlop+45Hj
         Is3H/h9pHABFuiRfoIIM//KxrQUV3hfdLUyAkOk79VXw4vl/KP0Ct467kVOABms8YB6b
         vvvDMwvxjdMZYL/GHcp8C3MLHlOJPAyyAxDT88iXUzxf+dRoOD3hogIcNokuqhBQAVxx
         JL1Q==
X-Gm-Message-State: ABy/qLYsPeqBaaNYXYsuazSDCrLEzxLbV8BST+S5SQjbfNVTHwMV1W5J
        SEh/KvsEFXxcUrMGkQCLg25pmXceEPBHpMWjrohuJQ==
X-Google-Smtp-Source: APBJJlGt5s+qN3+MlugdTjd5BHq9Gd9N6Bj4jGVrcAHiiIF7IqFsDoJ6W9XPGep06nFmJ+uAU5LfN+oe3MkQys0D9oE=
X-Received: by 2002:a0d:e241:0:b0:573:d710:6f88 with SMTP id
 l62-20020a0de241000000b00573d7106f88mr2552493ywe.36.1688667926648; Thu, 06
 Jul 2023 11:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230623164015.3431990-1-jiaqiyan@google.com> <20230623164015.3431990-3-jiaqiyan@google.com>
 <20230705235705.GE41006@monkey>
In-Reply-To: <20230705235705.GE41006@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Thu, 6 Jul 2023 11:25:15 -0700
Message-ID: <CACw3F511Hk-XM46fYnciKy6=t0bdmGpu9y1qsqrpJOA0zFKWhw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
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

On Wed, Jul 5, 2023 at 4:57=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> On 06/23/23 16:40, Jiaqi Yan wrote:
> > Adds the functionality to tell if a subpage of a hugetlb folio is a
> > raw HWPOISON page. This functionality relies on RawHwpUnreliable to
> > be not set; otherwise hugepage's HWPOISON list becomes meaningless.
> >
> > Exports this functionality to be immediately used in the read operation
> > for hugetlbfs.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  include/linux/hugetlb.h | 19 +++++++++++++++++++
> >  include/linux/mm.h      |  7 +++++++
> >  mm/hugetlb.c            | 10 ++++++++++
> >  mm/memory-failure.c     | 34 ++++++++++++++++++++++++----------
> >  4 files changed, 60 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 21f942025fec..8b73a12b7b38 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -1013,6 +1013,25 @@ void hugetlb_register_node(struct node *node);
> >  void hugetlb_unregister_node(struct node *node);
> >  #endif
> >
> > +/*
> > + * Struct raw_hwp_page represents information about "raw error page",
> > + * constructing singly linked list from ->_hugetlb_hwpoison field of f=
olio.
> > + */
> > +struct raw_hwp_page {
> > +     struct llist_node node;
> > +     struct page *page;
> > +};
> > +
> > +static inline struct llist_head *raw_hwp_list_head(struct folio *folio=
)
> > +{
> > +     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > +}
> > +
> > +/*
> > + * Check if a given raw @subpage in a hugepage @folio is HWPOISON.
> > + */
> > +bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage);
> > +
> >  #else        /* CONFIG_HUGETLB_PAGE */
> >  struct hstate {};
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 66032f0d515c..41a283bd41a7 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3671,6 +3671,7 @@ extern const struct attribute_group memory_failur=
e_attr_group;
> >  extern void memory_failure_queue(unsigned long pfn, int flags);
> >  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >                                       bool *migratable_cleared);
> > +extern bool __is_raw_hwp_subpage(struct folio *folio, struct page *sub=
page);
> >  void num_poisoned_pages_inc(unsigned long pfn);
> >  void num_poisoned_pages_sub(unsigned long pfn, long i);
> >  struct task_struct *task_early_kill(struct task_struct *tsk, int force=
_early);
> > @@ -3685,6 +3686,12 @@ static inline int __get_huge_page_for_hwpoison(u=
nsigned long pfn, int flags,
> >       return 0;
> >  }
> >
> > +static inline bool __is_raw_hwp_subpage(struct folio *folio,
> > +                                     struct page *subpage)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline void num_poisoned_pages_inc(unsigned long pfn)
> >  {
> >  }
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ea24718db4af..6b860de87590 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -7377,6 +7377,16 @@ int get_huge_page_for_hwpoison(unsigned long pfn=
, int flags,
> >       return ret;
> >  }
> >
> > +bool is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> > +{
> > +     bool ret;
> > +
> > +     spin_lock_irq(&hugetlb_lock);
> > +     ret =3D __is_raw_hwp_subpage(folio, subpage);
> > +     spin_unlock_irq(&hugetlb_lock);
>
> Can you describe what races the hugetlb_lock prevents here?

I think we should sync here with __get_huge_page_for_hwpoison, who
iterates and inserts an entry to raw_hwp_list. llist itself doesn't
ensure insertion is synchronized with iterating from
__is_raw_hwp_subpage.

> --
> Mike Kravetz
>
> > +     return ret;
> > +}
> > +
> >  void folio_putback_active_hugetlb(struct folio *folio)
> >  {
> >       spin_lock_irq(&hugetlb_lock);
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index c415c3c462a3..891248e2930e 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1809,18 +1809,32 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> >  #endif /* CONFIG_FS_DAX */
> >
> >  #ifdef CONFIG_HUGETLB_PAGE
> > -/*
> > - * Struct raw_hwp_page represents information about "raw error page",
> > - * constructing singly linked list from ->_hugetlb_hwpoison field of f=
olio.
> > - */
> > -struct raw_hwp_page {
> > -     struct llist_node node;
> > -     struct page *page;
> > -};
> >
> > -static inline struct llist_head *raw_hwp_list_head(struct folio *folio=
)
> > +bool __is_raw_hwp_subpage(struct folio *folio, struct page *subpage)
> >  {
> > -     return (struct llist_head *)&folio->_hugetlb_hwpoison;
> > +     struct llist_head *raw_hwp_head;
> > +     struct raw_hwp_page *p, *tmp;
> > +     bool ret =3D false;
> > +
> > +     if (!folio_test_hwpoison(folio))
> > +             return false;
> > +
> > +     /*
> > +      * When RawHwpUnreliable is set, kernel lost track of which subpa=
ges
> > +      * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> > +      */
> > +     if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> > +             return true;
> > +
> > +     raw_hwp_head =3D raw_hwp_list_head(folio);
> > +     llist_for_each_entry_safe(p, tmp, raw_hwp_head->first, node) {
> > +             if (subpage =3D=3D p->page) {
> > +                     ret =3D true;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return ret;
> >  }
> >
> >  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool mo=
ve_flag)
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
