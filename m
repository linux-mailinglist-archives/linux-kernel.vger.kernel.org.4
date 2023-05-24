Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B3A70EC87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjEXE0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXE0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:26:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C5135
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:26:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56190515833so10719597b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684902397; x=1687494397;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMzLKiBxLfoI6P+dZdn5tAx16KBddxlFh7DFYFY62sE=;
        b=GPJQk76q1KTZRrSReZmgVOj0kZRP0ZgJlBP72oOacta1ZnwE9jne6YsMN76ucCU7Fz
         OrCHEWL2y7cGV3TLBV67k61Z7aAnS4+LVzGEGmxwjR9CYkQSFcTvbKNmqLnXBoOS1zZ2
         dHN7GnTVl0uJL/38zUsRA5cKUstyeua8jEt/FdE3ym3++7ol17wn2veX0lZpzugqjZOu
         jBDDdgbSQep0B8lErE9eWHFLHLyW305rJ0pmZGqbe+6sW7+zuZZupFqAu/i3f2AbEBRP
         mgj228K/wRHBYq2/5z82YdVsCCGTgq4arA43sx+pgZIXmHYzfvl9aOzwwRa78NMmRJ0B
         kDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684902397; x=1687494397;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMzLKiBxLfoI6P+dZdn5tAx16KBddxlFh7DFYFY62sE=;
        b=ddDRqwyAV1UMKqynkdrlvT4Vog0es2TvilwZ/+1/e5dhSKE6ccI09EqqtOCpKSXjCP
         PwOh9hvzCBvyrpGeytN8BKyKyYJ5ngoM0V0txaB23fbQYOejq2XnPJNQ8UMy3IveecJl
         sopEZDipRhd1KWq71cgJVyvMjQpfuN9r0mZ55mmP66wvnYD/blFKnI++ibqwFRM7s4ys
         SyR/9FCn+aRv7+BMudVnocHYgS8vIXG9fOrub/kkW0pdw7N25aU5BG1P0Lw8J1AKQ7y9
         kG3nhDfO7k77Hi/LL56GfuFXCJu1U3AwKlH4XrN029m60aEoHi1kSKGrg8yspHna3OzD
         M72A==
X-Gm-Message-State: AC+VfDxRkaD9PQCKBDc2hzqMOLHz3n6JW1BRlq1GrvjtaU3P++YYloeZ
        HbA/c93wOVh8R4n9uRfIR4EPlQ==
X-Google-Smtp-Source: ACHHUZ7aF8288OQwPxDA2xoNmvBFWRU1yMGqirXSuIKhge0/55UqjaGEBK/BIi2MrXiTDprdgSWV+w==
X-Received: by 2002:a0d:d8d1:0:b0:564:c747:64f4 with SMTP id a200-20020a0dd8d1000000b00564c74764f4mr13325863ywe.11.1684902397030;
        Tue, 23 May 2023 21:26:37 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h15-20020a81b40f000000b00561b76b72d7sm3412288ywi.40.2023.05.23.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:26:36 -0700 (PDT)
Date:   Tue, 23 May 2023 21:26:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 25/31] mm/gup: remove FOLL_SPLIT_PMD use of
 pmd_trans_unstable()
In-Reply-To: <CAHbLzkpOs4fz5NuAzQDdMRQYDLn6HzR1CHQoU5OYZyPW1GQmHg@mail.gmail.com>
Message-ID: <3d548f45-9ff9-d73a-83e0-bdd312f524@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <b9da41bb-b7b6-2fc6-caac-b01b6719334@google.com> <CAHbLzkpdWqLM1+Jb+rzVjxGyRBUtJFU_2O7=7PtE0dNgsvXSrQ@mail.gmail.com> <CAHbLzkpOs4fz5NuAzQDdMRQYDLn6HzR1CHQoU5OYZyPW1GQmHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1821753091-1684902396=:7491"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1821753091-1684902396=:7491
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 May 2023, Yang Shi wrote:
> On Mon, May 22, 2023 at 7:26=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> > On Sun, May 21, 2023 at 10:22=E2=80=AFPM Hugh Dickins <hughd@google.com=
> wrote:
> > >
> > > There is now no reason for follow_pmd_mask()'s FOLL_SPLIT_PMD block t=
o
> > > distinguish huge_zero_page from a normal THP: follow_page_pte() handl=
es
> > > any instability, and here it's a good idea to replace any pmd_none(*p=
md)
> > > by a page table a.s.a.p, in the huge_zero_page case as for a normal T=
HP.
> > > (Hmm, couldn't the normal THP case have hit an unstably refaulted THP
> > > before?  But there are only two, exceptional, users of FOLL_SPLIT_PMD=
=2E)
> > >
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > ---
> > >  mm/gup.c | 19 ++++---------------
> > >  1 file changed, 4 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index bb67193c5460..4ad50a59897f 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -681,21 +681,10 @@ static struct page *follow_pmd_mask(struct vm_a=
rea_struct *vma,
> > >                 return follow_page_pte(vma, address, pmd, flags, &ctx=
->pgmap);
> > >         }
> > >         if (flags & FOLL_SPLIT_PMD) {
> > > -               int ret;
> > > -               page =3D pmd_page(*pmd);
> > > -               if (is_huge_zero_page(page)) {
> > > -                       spin_unlock(ptl);
> > > -                       ret =3D 0;
> > > -                       split_huge_pmd(vma, pmd, address);
> > > -                       if (pmd_trans_unstable(pmd))
> > > -                               ret =3D -EBUSY;
> >
> > IIUC the pmd_trans_unstable() check was transferred to the implicit
> > pmd_none() in pte_alloc(). But it will return -ENOMEM instead of
> > -EBUSY. Won't it break some userspace? Or the pmd_trans_unstable() is
> > never true? If so it seems worth mentioning in the commit log about
> > this return value change.

Thanks a lot for looking at these, but I disagree here.

>=20
> Oops, the above comment is not accurate. It will call
> follow_page_pte() instead of returning -EBUSY if pmd is none.

Yes.  Ignoring secondary races, if pmd is none, pte_alloc() will allocate
an empty page table there, follow_page_pte() find !pte_present and return
NULL; or if pmd is not none, follow_page_pte() will return no_page_table()
i.e. NULL.  And page NULL ends up with __get_user_pages() having another
go round, instead of failing with -EBUSY.

Which I'd say is better handling for such a transient case - remember,
it's split_huge_pmd() (which should always succeed, but might be raced)
in use there, not split_huge_page() (which might take years for pins to
be removed before it can succeed).

> For other unstable cases, it will return -ENOMEM instead of -EBUSY.

I don't think so: the possibly-failing __pte_alloc() only gets called
in the pmd_none() case.

Hugh

>=20
> >
> > > -               } else {
> > > -                       spin_unlock(ptl);
> > > -                       split_huge_pmd(vma, pmd, address);
> > > -                       ret =3D pte_alloc(mm, pmd) ? -ENOMEM : 0;
> > > -               }
> > > -
> > > -               return ret ? ERR_PTR(ret) :
> > > +               spin_unlock(ptl);
> > > +               split_huge_pmd(vma, pmd, address);
> > > +               /* If pmd was left empty, stuff a page table in there=
 quickly */
> > > +               return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
> > >                         follow_page_pte(vma, address, pmd, flags, &ct=
x->pgmap);
> > >         }
> > >         page =3D follow_trans_huge_pmd(vma, address, pmd, flags);
> > > --
> > > 2.35.3
---1463760895-1821753091-1684902396=:7491--
