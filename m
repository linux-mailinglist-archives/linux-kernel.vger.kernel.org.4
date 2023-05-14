Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1E701EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjENSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENSUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 14:20:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF13AA7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 11:20:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9daef8681fso10177973276.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684088430; x=1686680430;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/w8Ik+B9LqquAVc24RATG4RXaBZs1t11jn/s3N/obhU=;
        b=3hM1VI6NWGWu8nKjmz4E776n6/tfMkoFz07qqIrs1oaapPZVpFGqRfLcsrD2Q9+aIl
         lVkR5CaBLhkLbvj6PetC97KquetslVNm4ewYDv3VlmeuHTS81B9LSL8mS5hv5NNIrJ5k
         qfkEuu9pgy+dtpTd6GHTh0Gi0u67Y0T46ElzOPo7riZGmKUfHA7vSk0Zmd7HgvGJHxab
         DqbZyXByDthzzyzxr91aGkpWgNkslpXmOPPlerkZVQyLnPVqgNtVTmJy+exwCn44tZ+/
         VxkE3CJ7HkShwyo4XrVtp449lbAR3UPOjv88P7k+8G1RfjN7YRQ6k8XKtpgdfILs4FOB
         5kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684088430; x=1686680430;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w8Ik+B9LqquAVc24RATG4RXaBZs1t11jn/s3N/obhU=;
        b=WMLHPj9Z18bXKticzllqD/zU7K+eKlPGMOBt+LDV5nVTn5L3MsdnqYxczf+D1I7GUc
         zlaMtW3ZImjf3ibfLbDFHY10ofNrV2N4Yr9gk0LcZPNtBDsOrVdGJ9e6cRGtIr2FJn9/
         Mz/5i7AjJTN1YrMF8i66TZ7OnulUUvcO2uOdHK3iNRDAiid3z6eMOqCGZJ12Rv2Q/zzf
         2dFu3PXi2ceMSVXVNUH5w2i3EFJyR3zVoen0o+8yYZA3YXR5pXqbGkfzkBGKp04rV5MI
         bTgl82TjAyKgalfcb3UapjaNjjLZuDLvsM0fRhWqgWcI2xu0x0cigYDUGnStVv5sdf3f
         87Rg==
X-Gm-Message-State: AC+VfDyt1u91jjmUCXdyelu/P2oAQs9eQPQXqwhyaSppIRmsggw0RREh
        V0cOTMf5gy0ffJ7Jmdaez7fX8w==
X-Google-Smtp-Source: ACHHUZ4uC/iK9slyVYAwsZbskAJfVUMUdzJpIRbgKgSPhKsknTzzPntrNJG85XVm7SRutl/ig2uJ2g==
X-Received: by 2002:a25:abe5:0:b0:ba1:b539:a39a with SMTP id v92-20020a25abe5000000b00ba1b539a39amr27412446ybi.6.1684088430350;
        Sun, 14 May 2023 11:20:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 192-20020a2503c9000000b00ba73c26f0d6sm1520144ybd.15.2023.05.14.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 11:20:28 -0700 (PDT)
Date:   Sun, 14 May 2023 11:20:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Helge Deller <deller@gmx.de>
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
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
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
Subject: Re: [PATCH 08/23] parisc: add pte_unmap() to balance get_ptep()
In-Reply-To: <ca4ac780-42b0-4818-bd84-e1a4acbb28dd@gmx.de>
Message-ID: <6de39db5-d9aa-b35a-1652-8bdf90e7df72@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <44ebbf90-5fbb-2815-17c7-fcfe3c87d78e@google.com> <ca4ac780-42b0-4818-bd84-e1a4acbb28dd@gmx.de>
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

On Sat, 13 May 2023, Helge Deller wrote:

> Hi Hugh,
> 
> On 5/10/23 06:52, Hugh Dickins wrote:
> > To keep balance in future, remember to pte_unmap() after a successful
> > get_ptep().  And (we might as well) pretend that flush_cache_pages()
> > really needed a map there, to read the pfn before "unmapping".
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   arch/parisc/kernel/cache.c | 26 +++++++++++++++++++++-----
> >   1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> > index 1d3b8bc8a623..b0c969b3a300 100644
> > --- a/arch/parisc/kernel/cache.c
> > +++ b/arch/parisc/kernel/cache.c
> > @@ -425,10 +425,15 @@ void flush_dcache_page(struct page *page)
> >     offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
> >     addr = mpnt->vm_start + offset;
> >     if (parisc_requires_coherency()) {
> > +			bool needs_flush = false;
> >      pte_t *ptep;
> >
> >   			ptep = get_ptep(mpnt->vm_mm, addr);
> > -			if (ptep && pte_needs_flush(*ptep))
> > +			if (ptep) {
> > +				needs_flush = pte_needs_flush(*ptep);
> > +				pte_unmap(ptep);
> > +			}
> > +			if (needs_flush)
> >     		flush_user_cache_page(mpnt, addr);
> >     } else {
> >   			/*
> > @@ -560,14 +565,20 @@ EXPORT_SYMBOL(flush_kernel_dcache_page_addr);
> >   static void flush_cache_page_if_present(struct vm_area_struct *vma,
> >   	unsigned long vmaddr, unsigned long pfn)
> >   {
> > -	pte_t *ptep = get_ptep(vma->vm_mm, vmaddr);
> > +	bool needs_flush = false;
> > +	pte_t *ptep;
> >
> >    /*
> >     * The pte check is racy and sometimes the flush will trigger
> >     * a non-access TLB miss. Hopefully, the page has already been
> >     * flushed.
> >     */
> > -	if (ptep && pte_needs_flush(*ptep))
> > +	ptep = get_ptep(vma->vm_mm, vmaddr);
> > +	if (ptep) {
> > +		needs_flush = pte_needs_flush(*ptep))
> 
> ^^^^^
> One ")" too much and lacks a trailing ";"
> Should be:
> 		needs_flush = pte_needs_flush(*ptep);
> 
> With that fixed the kernel compiles and boots sucessfully on parisc.

Urgh! Indeed, thanks a lot Helge: I'll fold that in.

Hugh
