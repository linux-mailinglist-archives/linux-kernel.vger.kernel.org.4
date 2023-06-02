Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEA72043D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjFBOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjFBOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:22:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048901B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:22:13 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33baee0235cso92905ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685715732; x=1688307732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7d8d4MCc4onJq8pBQ681DcsEvxdLqedzghklpUu+XE=;
        b=L79Re62NKLr7jyTpAhcYr+dj4BGT8jlpsciGJ9UqkUTmF1Fp8HF4f7l7PCMx74wnSp
         Z4MExZDdVvmGr9HZZTldLvGj6yO4f7fmzOW5XHnYGFsp6aMxTvyGOWMjPJ6ywm+1hCxQ
         OT6t1BPoULN32Prv5c6c7oEpn7DQQMc7OJntv8coVkeidQLUAxq4YWwjm4UCbhaAUkHY
         CUlzXPTOm1Z7v2fI3l67bBKLhim0lh6AjxhBFfHcW9dOs+LcV01tauSIex0nknLfh486
         eezgiwL7ika5ondE8vdXjdjqeaYRbUDxv3VyIaZo6ZQgfWFoet5hN9FlE8YQgtwWZQa+
         l08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685715732; x=1688307732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7d8d4MCc4onJq8pBQ681DcsEvxdLqedzghklpUu+XE=;
        b=e0JeT9qQSR/k4qmDWFFTcfJF2MB7vE7T/v2NE+2GH19L5ktviX67wrc4FV4pTRVez0
         5mtKZ2LAixfkrcazOjjQcjyZAUgzCPXqYhZrHtsuZCp6OIPNYtSapoKRdzB3gZiGXaw7
         ZIOEUhrSY3uJXGlLE1JPh43HJGUE7PXYKB6Qw1BRUAxr4uizGGKKKz6YzLj3uDL7EzJS
         17fczo+Feue5zseRnRFNBRxNvKrrQ/uyUhNf78KmT6wlwPiTHFTRBvwF5HyyxNIV2/k+
         bIhcfFaThvpUnrhzTqodmMPw41WVRWNJQhFKOABZbA52uXIfEog1bEytInj/6HJalbk/
         rC9A==
X-Gm-Message-State: AC+VfDwvypg2MxHpam3kKrQeoyBLavCswil1u/zKeLDds503jfm82AbU
        mchyMDVIxZ/QhCq8fv9EkNYMeF/CMKZuWLRR82X76w==
X-Google-Smtp-Source: ACHHUZ6mi6QZprfgUPbDzcJiLe/rOvQrRI5aX2Gu9fS+O4S7pV5L9VHsi7BsweO4BYXLes4rrZUtI27C/96anNWk39g=
X-Received: by 2002:a92:c56a:0:b0:338:55b9:f1a3 with SMTP id
 b10-20020a92c56a000000b0033855b9f1a3mr137710ilj.7.1685715732071; Fri, 02 Jun
 2023 07:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <88c445ae-552-5243-31a4-2674bac62d4d@google.com> <CAG48ez0tnYTVjr7zw3Vp4GTcQ=960EodatjqE5bM9a3EVYM16Q@mail.gmail.com>
 <de1e37c-354c-fb98-1598-7ce6d415f257@google.com>
In-Reply-To: <de1e37c-354c-fb98-1598-7ce6d415f257@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Jun 2023 16:21:35 +0200
Message-ID: <CAG48ez3seuiWfiVq0z8weTQV3ZXwo-TXSQWLJ0uxn4eOrq0J0w@mail.gmail.com>
Subject: Re: [PATCH 01/12] mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 4:50=E2=80=AFAM Hugh Dickins <hughd@google.com> wrot=
e:
> On Wed, 31 May 2023, Jann Horn wrote:
> > On Mon, May 29, 2023 at 8:15=E2=80=AFAM Hugh Dickins <hughd@google.com>=
 wrote:
> > > Before putting them to use (several commits later), add rcu_read_lock=
()
> > > to pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this=
 a
> > > separate commit, since it risks exposing imbalances: prior commits ha=
ve
> > > fixed all the known imbalances, but we may find some have been missed=
.
> > [...]
> > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > index c7ab18a5fb77..674671835631 100644
> > > --- a/mm/pgtable-generic.c
> > > +++ b/mm/pgtable-generic.c
> > > @@ -236,7 +236,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long=
 addr, pmd_t *pmdvalp)
> > >  {
> > >         pmd_t pmdval;
> > >
> > > -       /* rcu_read_lock() to be added later */
> > > +       rcu_read_lock();
> > >         pmdval =3D pmdp_get_lockless(pmd);
> > >         if (pmdvalp)
> > >                 *pmdvalp =3D pmdval;
> >
> > It might be a good idea to document that this series assumes that the
> > first argument to __pte_offset_map() is a pointer into a second-level
> > page table (and not a local copy of the entry) unless the containing
> > VMA is known to not be THP-eligible or the page table is detached from
> > the page table hierarchy or something like that. Currently a bunch of
> > places pass references to local copies of the entry, and while I think
> > all of these are fine, it would probably be good to at least document
> > why these are allowed to do it while other places aren't.
>
> Thanks Jann: but I have to guess that here you are showing awareness of
> an important issue that I'm simply ignorant of.
>
> I have been haunted by a dim recollection that there is one architecture
> (arm-32?) which is fussy about the placement of the pmdval being examined
> (deduces info missing from the arch-independent interface, by following
> up the address?), but I couldn't track it down when I tried.
>
> Please tell me more; or better, don't spend your time explaining to me,
> but please just send a link to a good reference on the issue.  I'll be
> unable to document what you ask there, without educating myself first.

Sorry, I think I was somewhat confused about what was going on when I
wrote that message.

After this series, __pte_offset_map() looks as follows, with added
comments describing my understanding of the semantics:

// `pmd` points to one of:
// case 1: a pmd_t stored outside a page table,
//         referencing a page table detached by the caller
// case 2: a pmd_t stored outside a page table, which the caller copied
//         from a page table in an RCU-critical section that extends
//         until at least the end of this function
// case 3: a pmd_t stored inside a page table
pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
{
        unsigned long __maybe_unused flags;
        pmd_t pmdval;

        // begin an RCU section; this is needed for case 3
        rcu_read_lock();
        config_might_irq_save(flags);
        // read the pmd_t.
        // if the pmd_t references a page table, this page table can not
        // go away because:
        //  - in case 1, the caller is the main owner of the page table
        //  - in case 2, because the caller
        //    started an RCU read-side critical section before the caller
        //    read the original pmd_t. (This pmdp_get_lockless() is just
        //    reading a copied pmd_t off the stack.)
        //  - in case 3, because we started an RCU section above before
        //    reading the pmd_t out of the page table here
        pmdval =3D pmdp_get_lockless(pmd);
        config_might_irq_restore(flags);

        if (pmdvalp)
                *pmdvalp =3D pmdval;
        if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
                goto nomap;
        if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
                goto nomap;
        if (unlikely(pmd_bad(pmdval))) {
                pmd_clear_bad(pmd);
                goto nomap;
        }
        return __pte_map(&pmdval, addr);
nomap:
        rcu_read_unlock();
        return NULL;
}

case 1 is what happens in __page_table_check_pte_clear_range(),
__split_huge_zero_page_pmd() and __split_huge_pmd_locked().
case 2 happens in lockless page table traversal (gup_pte_range() and
perf_get_pgtable_size()).
case 3 is normal page table traversal under mmap lock or mapping lock.

I think having a function like this that can run in three different
contexts in which it is protected in three different ways is somewhat
hard to understand without comments. Though maybe I'm thinking about
it the wrong way?

Basically my point is: __pte_offset_map() normally requires that the
pmd argument points into a page table so that the rcu_read_lock() can
provide protection starting from the time the pmd_t is read from a
page table. The exception are cases where the caller has taken its own
precautions to ensure that the referenced page table can not have been
freed.
