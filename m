Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6B7237B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjFFG3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjFFG2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:28:41 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED101E76
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:28:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565e6beb7aaso72071917b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686032913; x=1688624913;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lh4nTYVvP2xhbTqzCFThdJwLmWrtDo6cCYu0K1MEaUc=;
        b=ULW8wPRikckM9LELAx9UpWle2Lb4WwZxPIXEDt1lR9wQIO5cxXakH/8jTLMBuZw8wx
         Uh47SeunW4Tp+pyb/wTLCC6nZMEC4nTofGf4XUgb3BlgvfEFnDLECsk+JtbDPIEYi26x
         9vZZ874SZy4X8WigJ/C8mjXXdDbReJrV0R4WIGr0mh0A5ZnrYuJU6h/Cw9u/zsQYaDk7
         mLxWS2XDJjEOTgncPyb98NRz5neLtObTpcxFngkG2w0fp+AzoZOrYLnFHTWNsS7we8ze
         5+dQOLu1Iwg73UmL89hyYzq5nExeBAcTkTsnwBDNieMk9P3B3h923KXyo65p9UTdz89t
         Xo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032913; x=1688624913;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lh4nTYVvP2xhbTqzCFThdJwLmWrtDo6cCYu0K1MEaUc=;
        b=Ef2VxiW53zpZHR01cVvLfJ2zOGQaWHRY+obYsRZmCspof+WM5iTR6RX68cU3CoaoSM
         l9nuO2e9d3kIa+jJ4c8vv8Iys2vjX+lKYLFomBPFw23m/WtiJ8uKO8Z3l9YsCzfMySnD
         j3FMV3AjDjCDnCuxHJpMQZLKXXs7hGgucJsHobsiDv0LE3FHzMp1kfLes5xL30P0u3tN
         erI7BWzj/PzvDyv4wikZ8LOD8jGJ3R8fCu5HGXve8a5+vTDnvgczh7dt77ruH04lDbkI
         cIjplpUUYyjJ4Lm3o9UNaUBueezNRrGtKrcU7jspNPFSsIuubPlHf7q7IcbKOzWjsYam
         TJNQ==
X-Gm-Message-State: AC+VfDykz9SqVPhugjVq5Miyelu/7D+Y2SxhR9pV6o0qpVipwCuxLNDz
        GiRkcu+sdp/eM0sX7+lUb96CTg==
X-Google-Smtp-Source: ACHHUZ7idIXR3XCuKUN9DZBZ124U2LyUkc47jWZoQiMKnSHKdPcQWeTsiAJumin9N7U+fFXlqtOy5g==
X-Received: by 2002:a0d:dd0f:0:b0:565:a3e6:1b7b with SMTP id g15-20020a0ddd0f000000b00565a3e61b7bmr1184720ywe.18.1686032912712;
        Mon, 05 Jun 2023 23:28:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u127-20020a818485000000b00569e0490babsm626769ywf.16.2023.06.05.23.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:28:32 -0700 (PDT)
Date:   Mon, 5 Jun 2023 23:28:27 -0700 (PDT)
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
Subject: Re: [PATCH 00/12] mm: free retracted page table by RCU
In-Reply-To: <CAG48ez1Yua=6ztK6Urc-BZj9ku14MWbOKP8iBUK6_F5VzRXP-A@mail.gmail.com>
Message-ID: <99fadcf-3979-a493-2664-291c5fbce19e@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <CAG48ez0pCqfRdVSnJz7EKtNvMR65=zJgVB-72nTdrNuhtJNX2Q@mail.gmail.com> <3a33b59f-47c1-9dea-209a-9f77eec3cb1@google.com> <CAG48ez1Yua=6ztK6Urc-BZj9ku14MWbOKP8iBUK6_F5VzRXP-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-360064877-1686032912=:3708"
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

---1463760895-360064877-1686032912=:3708
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 2 Jun 2023, Jann Horn wrote:
> On Fri, Jun 2, 2023 at 6:37=E2=80=AFAM Hugh Dickins <hughd@google.com> wr=
ote:
>=20
> > The most obvious vital thing (in the split ptlock case) is that it
> > remains a struct page with a usable ptl spinlock embedded in it.
> >
> > The question becomes more urgent when/if extending to replacing the
> > pagetable pmd by huge pmd in one go, without any mmap_lock: powerpc
> > wants to deposit the page table for later use even in the shmem/file
> > case (and all arches in the anon case): I did work out the details once
> > before, but I'm not sure whether I would still agree with myself; and w=
as
> > glad to leave replacement out of this series, to revisit some time late=
r.
> >
> > >
> > > So in particular, in handle_pte_fault() we can reach the "if
> > > (unlikely(!pte_same(*vmf->pte, entry)))" with vmf->pte pointing to a
> > > detached zeroed page table, but we're okay with that because in that
> > > case we know that !pte_none(vmf->orig_pte)&&pte_none(*vmf->pte) ,
> > > which implies !pte_same(*vmf->pte, entry) , which means we'll bail
> > > out?
> >
> > There is no current (even at end of series) circumstance in which we
> > could be pointing to a detached page table there; but yes, I want to
> > allow for that, and yes I agree with your analysis.
>=20
> Hmm, what am I missing here?

I spent quite a while trying to reconstruct what I had been thinking,
what meaning of "detached" or "there" I had in mind when I asserted so
confidently "There is no current (even at end of series) circumstance
in which we could be pointing to a detached page table there".

But had to give up and get on with more useful work.
Of course you are right, and that is what this series is about.

Hugh

>=20
> static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> {
>   pte_t entry;
>=20
>   if (unlikely(pmd_none(*vmf->pmd))) {
>     [not executed]
>   } else {
>     /*
>      * A regular pmd is established and it can't morph into a huge
>      * pmd by anon khugepaged, since that takes mmap_lock in write
>      * mode; but shmem or file collapse to THP could still morph
>      * it into a huge pmd: just retry later if so.
>      */
>     vmf->pte =3D pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>              vmf->address, &vmf->ptl);
>     if (unlikely(!vmf->pte))
>       [not executed]
>     // this reads a present readonly PTE
>     vmf->orig_pte =3D ptep_get_lockless(vmf->pte);
>     vmf->flags |=3D FAULT_FLAG_ORIG_PTE_VALID;
>=20
>     if (pte_none(vmf->orig_pte)) {
>       [not executed]
>     }
>   }
>=20
>   [at this point, a concurrent THP collapse operation detaches the page t=
able]
>   // vmf->pte now points into a detached page table
>=20
>   if (!vmf->pte)
>     [not executed]
>=20
>   if (!pte_present(vmf->orig_pte))
>     [not executed]
>=20
>   if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
>     [not executed]
>=20
>   spin_lock(vmf->ptl);
>   entry =3D vmf->orig_pte;
>   // vmf->pte still points into a detached page table
>   if (unlikely(!pte_same(*vmf->pte, entry))) {
>     update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>     goto unlock;
>   }
>   [...]
> }
---1463760895-360064877-1686032912=:3708--
