Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2E723777
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjFFGT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjFFGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:19:08 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D0E4C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:19:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565ba6aee5fso62801527b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686032342; x=1688624342;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sTRYTVdx/ux01uBjEjpeUqJbg1WCUQQStTJJJ+iSYQ=;
        b=YVpcnR57XK58Ak9HJaKiD+AbmN0H/CYge3w1rDZy+kp+ixEQ5UXDhUW9pOYeesSqFj
         UIRUIc+94+rFepe5SS0IdOo5iztw/rOy6CZpzWrU+IO4mNui1Zkgo9h3jingrr3fdVeR
         HIuDw7tANLptHE48ffNhMDJFR/2yVZoygTObBxZHLrYwZ5ig0FO5oMVOAbG5JmgJ0UWU
         6+2GTtgCPvXlaoClixmzd6lsXHoN+YRamBAk/DTYCWg1LdM33PXGWziAwYwNFEbX76sd
         8nwM0BIPLw8ZG/nUnsDIXqbiioZwSbfpAnbTQqesPpDB88/NKXiVlbDpREXhm6LvGiU9
         9BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032342; x=1688624342;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sTRYTVdx/ux01uBjEjpeUqJbg1WCUQQStTJJJ+iSYQ=;
        b=Vof9JHPygLBUD6V762rsSXbp9JeBQlgjaKR0fYftr0sFKr7PiEyOaM0uXB8uL0MJKo
         NHH2Ti81wQ9JCIRdr4WxSzjeG+BAE0nrAhyM6jtNMeoMPGq16f+QIM+H+88MajuJ13ij
         wzfX/RN7EFhOQTicaKm+ZkCqWfEBkagCIxD6qMVmtax1/E9masa3yj27BNYMWH3EzrAf
         OxjKegf120U0uDh0LiCOVhP8QN5hBfeba7iVBazQJptVRYXggp0VgDvIjvafjmvNQOZ6
         kZaDM19FIl4RW+Qr1smHFeZcg9+5tcYkIuD+CIvvY6ODz3FJkDyQS/pY7VY6HZj+SKgO
         q0uQ==
X-Gm-Message-State: AC+VfDxo018edWUPDuopq4x5MCIjxQo6DATqRrUTjv7OLnobS1g+bzxF
        e0/QBQ/HpCbxaYpwaX+ahCva5g==
X-Google-Smtp-Source: ACHHUZ5WPUWoPm4xuDxQsHa6AYmw1XOJYysfo3qH0lT+OY94v7UN7xIfgoB+mAV06b+Ahd1uLZ7ohg==
X-Received: by 2002:a81:6d46:0:b0:565:d3f9:209e with SMTP id i67-20020a816d46000000b00565d3f9209emr1132264ywc.34.1686032341554;
        Mon, 05 Jun 2023 23:19:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i187-20020a816dc4000000b0055d820f11cesm3876070ywc.13.2023.06.05.23.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:19:00 -0700 (PDT)
Date:   Mon, 5 Jun 2023 23:18:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jann Horn <jannh@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap
 or vma lock
In-Reply-To: <CAG48ez0aF1Rf1apSjn9YcnfyFQ4YqSd4GqB6f2wfhF7jMdi5Hg@mail.gmail.com>
Message-ID: <c096f6fb-93c4-3f23-7698-8e4c5286c2b2@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com> <CAG48ez0aF1Rf1apSjn9YcnfyFQ4YqSd4GqB6f2wfhF7jMdi5Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-64387534-1686032340=:3708"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-64387534-1686032340=:3708
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 May 2023, Jann Horn wrote:
> On Mon, May 29, 2023 at 8:25=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > +static void retract_page_tables(struct address_space *mapping, pgoff_t=
 pgoff)
=2E..
> > +                * Note that vma->anon_vma check is racy: it can be set=
 after
> > +                * the check, but page locks (with XA_RETRY_ENTRYs in h=
oles)
> > +                * prevented establishing new ptes of the page. So we a=
re safe
> > +                * to remove page table below, without even checking it=
's empty.
>=20
> This "we are safe to remove page table below, without even checking
> it's empty" assumes that the only way to create new anonymous PTEs is
> to use existing file PTEs, right? What about private shmem VMAs that
> are registered with userfaultfd as VM_UFFD_MISSING? I think for those,
> the UFFDIO_COPY ioctl lets you directly insert anonymous PTEs without
> looking at the mapping and its pages (except for checking that the
> insertion point is before end-of-file), protected only by mmap_lock
> (shared) and pte_offset_map_lock().

Right, from your comments and Peter's, thank you both, I can see that
userfaultfd breaks the usual assumptions here: so I'm putting an
=09=09if (unlikely(vma->anon_vma || userfaultfd_wp(vma)))
check in once we've got the ptlock; with a comment above it to point
the blame at uffd, though I gave up on describing all the detail.
And deleted this earlier "we are safe" paragraph.

You did suggest, in another mail, that perhaps there should be a scan
checking all pte_none() when we get the ptlock.  I wasn't keen on yet
another debug scan for bugs and didn't add that, thinking I was going
to add a patch on the end to do so in page_table_check_pte_clear_range().

But when I came to write that patch, found that I'd been misled by its
name: it's about checking or adjusting some accounting, not really a
suitable place to check for pte_none() at all; so just scrapped it.

=2E..
> > -                       collapse_and_free_pmd(mm, vma, addr, pmd);
>=20
> The old code called collapse_and_free_pmd(), which involves MMU
> notifier invocation...

=2E..
> > +               pml =3D pmd_lock(mm, pmd);
> > +               ptl =3D pte_lockptr(mm, pmd);
> > +               if (ptl !=3D pml)
> > +                       spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> > +               pgt_pmd =3D pmdp_collapse_flush(vma, addr, pmd);
>=20
> ... while the new code only does pmdp_collapse_flush(), which clears
> the pmd entry and does a TLB flush, but AFAICS doesn't use MMU
> notifiers. My understanding is that that's problematic - maybe (?) it
> is sort of okay with regards to classic MMU notifier users like KVM,
> but it's probably wrong for IOMMUv2 users, where an IOMMU directly
> consumes the normal page tables?

Right, I intentionally left out the MMU notifier invocation, knowing
that we have already done an MMU notifier invocation when unmapping
any PTEs which were mapped: it was necessary for collapse_and_free_pmd()
in the collapse_pte_mapped_thp() case, but there was no notifier in this
case for many years, and I was glad to be rid of it.

However, I now see that you were adding it intentionally even for this
case in your f268f6cf875f; and from later comments in this thread, it
looks like there is still uncertainty about whether it is needed here,
but safer to assume that it is needed: I'll add it back.

>=20
> (FWIW, last I looked, there also seemed to be some other issues with
> MMU notifier usage wrt IOMMUv2, see the thread
> <https://lore.kernel.org/linux-mm/Yzbaf9HW1%2FreKqR8@nvidia.com/>.)
---1463760895-64387534-1686032340=:3708--
