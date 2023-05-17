Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFE70748B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEQVup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEQVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:50:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0219059EE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:50:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56190515833so12458877b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684360239; x=1686952239;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYrqZZXifWUb49UwqN4ktjCYYTpIiyxjiceM91X1owo=;
        b=PPBehuovPkLBa6/NGbQAXn/eE0OjqEyROrqLX97nN6jBSNnfJoc5x6zVzWooSZlBuR
         ygh7zMisKFOdApdpWLXdE38Ez48wbdl6bRgelI1M2q7oF1fjbdo+FT/cryTh0RkA2PgM
         PVNv73NfYOacgZraULasH6MPisPmrZxBB5SdyINIUR+rCWC/xGGFoY/3V4eCh48ezelN
         vlspmk4A/B3orH5IwCfSCJfMbueYznmKfST0fzCY2VeJqOWgXVBfHyrQGp7gwU4xxk/e
         4DAXLkf7AssRwZV1LOldxmp7mNGGXTey4IiHanP7lOcu21DjwGEEnizw4Nh4dLrJMR0W
         24RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360239; x=1686952239;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYrqZZXifWUb49UwqN4ktjCYYTpIiyxjiceM91X1owo=;
        b=hf0+hzMersUJnASUpFGuSA9sF2aht5nbalVCld2TfjirYiO0aVyiNSWAnQ8t1PvAIV
         yFkIRRbuxk/h0CLuepW+ha8PtxJC7rsQzIHBzs44xHKGRBwyILZoMld2H3dhib+4i/eQ
         /cinSFTQDLzHpF9N5FJOLXdMjXxTdmjr3C3BFWpvukJ09HkIlMDMBAQCrxhflBups+O6
         cTjDeeuTjNpK55IrikF5kMBIdTNKVR6i8A66LInI2U46b86V88jDQWjk/gbWgsWMVskt
         6IGJ9kVFb3LLTF9oBR7DDIpRE0M09A5PjTBlvO3WOCR3s1UrAUX3eD/GgjTBX6QKEvYq
         YmAg==
X-Gm-Message-State: AC+VfDw50iuWi/VkB3SeJ0YeZd6Ts3piDUwQVqdS+MdC5CKeOgfiGc4G
        hSzTdgkbgEih47RroKNSebXYvA==
X-Google-Smtp-Source: ACHHUZ5K1W6BqH54lP1fyWtEUpWwZ0lmy+14bsbtce6I/HyB5LShp2aTZ/lznkrMNM/kuQdbHXvf0A==
X-Received: by 2002:a81:6744:0:b0:55a:af:2486 with SMTP id b65-20020a816744000000b0055a00af2486mr2691032ywc.18.1684360239031;
        Wed, 17 May 2023 14:50:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 129-20020a251187000000b00ba6ffc7ef35sm785837ybr.65.2023.05.17.14.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:50:38 -0700 (PDT)
Date:   Wed, 17 May 2023 14:50:28 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/23] s390: allow pte_offset_map_lock() to fail
In-Reply-To: <20230517123546.672fb9b0@p-imbrenda>
Message-ID: <4a15dbaa-1614-ce-ce1f-f73959cef895@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com> <20230517123546.672fb9b0@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 17 May 2023, Claudio Imbrenda wrote:
> On Tue, 9 May 2023 22:01:16 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> 
> > In rare transient cases, not yet made possible, pte_offset_map() and
> > pte_offset_map_lock() may not find a page table: handle appropriately.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  arch/s390/kernel/uv.c  |  2 ++
> >  arch/s390/mm/gmap.c    |  2 ++
> >  arch/s390/mm/pgtable.c | 12 +++++++++---
> >  3 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index cb2ee06df286..3c62d1b218b1 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -294,6 +294,8 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
> >  
> >  	rc = -ENXIO;
> >  	ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
> > +	if (!ptep)
> > +		goto out;

You may or may not be asking about this instance too.  When I looked at
how the code lower down handles -ENXIO (promoting it to -EFAULT if an
access fails, or to -EAGAIN to ask for a retry), this looked just right
(whereas using -EAGAIN here would be wrong: that expects a "page" which
has not been initialized at this point).

> >  	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
> >  		page = pte_page(*ptep);
> >  		rc = -EAGAIN;
> > diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> > index dc90d1eb0d55..d198fc9475a2 100644
> > --- a/arch/s390/mm/gmap.c
> > +++ b/arch/s390/mm/gmap.c
> > @@ -2549,6 +2549,8 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
> >  		spinlock_t *ptl;
> >  
> >  		ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> > +		if (!ptep)
> > +			break;
> 
> so if pte_offset_map_lock fails, we abort and skip both the failed
> entry and the rest of the entries?

Yes.

> 
> can pte_offset_map_lock be retried immediately if it fails? (consider
> that we currently don't allow THP with KVM guests)
> 
> Would something like this:
> 
> do {
> 	ptep = pte_offset_map_lock(...);
> 	mb();	/* maybe? */
> } while (!ptep);
> 
> make sense?

No.  But you're absolutely right to be asking: thank you for looking
into it so carefully - and I realize that it's hard at this stage to
judge what's appropriate, when I've not yet even posted the endpoint
of these changes, the patches which make it possible not to find a
page table here.  And I'm intentionally keeping that vague, because
although I shall only introduce a THP case, I do expect it to be built
upon later in reclaiming empty page tables: it would be nice not to
have to change the arch code again when extending further.

My "rare transient cases" phrase may be somewhat misleading: one thing
that's wrong with your tight pte_offset_map_lock() loop above is that
the pmd entry pointing to page table may have been suddenly replaced by
a pmd_none() entry; and there's nothing in your loop above to break out
if that is so.

But if a page table is suddenly removed, that would be because it was
either empty, or replaced by a THP entry, or easily reconstructable on
demand (by that, I probably mean it was only mapping shared file pages,
which can just be refaulted if needed again).

The case you're wary of, is if the page table were removed briefly,
then put back shortly after: and still contains zero pages further down.
That's not something mm does now, nor at the end of my several series,
nor that I imagine us wanting to do in future: but I am struggling to
find a killer argument to persuade you that it could never be done -
most pages in a page table do need rmap tracking, which will BUG if
it's broken, but that argument happens not to apply to the zero page.

(Hmm, there could be somewhere, where we would find it convenient to
remove a page table with intent to do ...something, then validation
of that isolated page table fails, so we just put it back again.)

Is it good enough for me to promise you that we won't do that?

There are several ways in which we could change __zap_zero_pages(),
but I don't see them as actually dealing with the concern at hand.

One change, I've tended to make at the mm end but did not dare
to interfere here: it would seem more sensible to do a single
pte_offset_map_lock() outside the loop, return if that fails,
increment ptep inside the loop, pte_unmap_unlock() after the loop.

But perhaps you have preemption reasons for not wanting that; and
although it would eliminate the oddity of half-processing a page
table, it would not really resolve the problem at hand: because,
what if this page table got removed just before __zap_zero_pages()
tries to take the lock, then got put back just after?

Another change: I see __zap_zero_pages() is driven by walk_page_range(),
and over at the mm end I'm usually setting walk->action to ACTION_AGAIN
in these failure cases; but thought that an unnecessary piece of magic
here, and cannot see how it could actually help.  Your "retry the whole
walk_page_range()" suggestion below would be a heavier equivalent of
that: but neither way gives confidence, if a page table could actually
be removed then reinserted without mmap_write_lock().

I think I want to keep this s390 __zap_zero_pages() issue in mind, it is
important and thank you for raising it; but don't see any change to the
patch as actually needed.

Hugh

> 
> 
> otherwise maybe it's better to return an error and retry the whole
> walk_page_range() in s390_enable_sie() ? it's a slow path anyway.
> 
> >  		if (is_zero_pfn(pte_pfn(*ptep)))
> >  			ptep_xchg_direct(walk->mm, addr, ptep, __pte(_PAGE_INVALID));
> >  		pte_unmap_unlock(ptep, ptl);
> 
> [...]
