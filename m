Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A4629E82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKOQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiKOQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE551D65A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668528527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DqBPgUe4Sm3rQRHQ4BZn8ze3h0OIxC8sEcLBb0IfLqw=;
        b=IhyhYOgDIcb/kqnRIswP7goeCK1dO8PWc8yMclYspSitILnXU2NGd2OdVvR3eqR273T0jA
        3xpCxPTwbrlzdekv8CIWo6qQMUtXevliidgfi01K0ACw7SZtH6SDR51qP1e9tvjozy1yUg
        Jq6JiBq5XN2p2BNgDnaXj3fZT3zl3cw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-DTAts_VkMFiRmGJyBFpqGA-1; Tue, 15 Nov 2022 11:08:15 -0500
X-MC-Unique: DTAts_VkMFiRmGJyBFpqGA-1
Received: by mail-qv1-f69.google.com with SMTP id nh17-20020a056214391100b004bb6c16bd4dso10980929qvb.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqBPgUe4Sm3rQRHQ4BZn8ze3h0OIxC8sEcLBb0IfLqw=;
        b=dvjFPD9HGc0aLfYHzgnsVimPxgXJYI61Igdr/hX1vqCdViuDwYYK/HK1ZqXbDhoRN0
         RG3E3C3hrmu66EW5UfJyuiMi1aouDFXznFtdeEqj4kbS57mwFFMKUCRQNRV8Xt68Beu1
         VC698Zi7chlMdDum6U+pxuuqnFa6tTSf7YbJBkFVVzrDHeZAtgwGg5zSbn1jNI2mT/Ln
         DnIdUW4f3nYLR2GKu5BjOpbwiocaO25uOrst24k6IbMEx5eRvunG4PYUndwW1kATUoqR
         XVJOiio6386H/eUyulALOwpLbSFzOeDlaZ8QW72ksQZexOCgkXZmQYMFyt4UvaBhVtSv
         0CIA==
X-Gm-Message-State: ANoB5pkn+svhBiZ1J3TyQkzPAmdvfOVLZ141wjPMVWye2Y/coC9bpkL3
        wW9bj+S/e3P5x5ZUGg3UV65bDEYOMD1HQTCzy7mHl3FXsfiNdVHwhM/qTmad1riMm6QdasHtQNa
        rrJlfMDxFEOJ0CWE3LZOknw7d
X-Received: by 2002:ad4:444b:0:b0:4bc:22fe:b07c with SMTP id l11-20020ad4444b000000b004bc22feb07cmr17166166qvt.7.1668528494703;
        Tue, 15 Nov 2022 08:08:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf70mQJUfQ19xOCkCRFYx0GkmNRSEJPLG9Rt+n1xw5LBbvpYTpsOBchqj+H6ysPG6urM3V1fvw==
X-Received: by 2002:ad4:444b:0:b0:4bc:22fe:b07c with SMTP id l11-20020ad4444b000000b004bc22feb07cmr17166134qvt.7.1668528494412;
        Tue, 15 Nov 2022 08:08:14 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006ec62032d3dsm8580912qkp.30.2022.11.15.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:08:13 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:08:12 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
Message-ID: <Y3O5bCXSbvKJrjRL@x1n>
References: <20221110203132.1498183-1-peterx@redhat.com>
 <20221110203132.1498183-2-peterx@redhat.com>
 <9af36be3-313b-e39c-85bb-bf30011bccb8@redhat.com>
 <Y3KgYeMTdTM0FN5W@x1n>
 <ec8b3c86-d3b2-f898-7297-c20a58ae2ac1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec8b3c86-d3b2-f898-7297-c20a58ae2ac1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:13:24AM +0100, David Hildenbrand wrote:
> > > 
> > > Any particular reason why not to simply glue this to pte_swp_uffd_wp(),
> > > because only that needs special care:
> > > 
> > > if (pte_swp_uffd_wp(*pvmw.pte)) {
> > > 	pte = pte_wrprotect(pte);
> > > 	pte = pte_mkuffd_wp(pte);
> > > }
> > > 
> > > 
> > > And that would match what actually should have been done in commit
> > > f45ec5ff16a7 -- only special-case uffd-wp.
> > > 
> > > Note that I think there are cases where we have a PTE that was !writable,
> > > but after migration we can map it writable.
> > 
> > The thing is recovering the pte into its original form is the safest
> > approach to me, so I think we need justification on why it's always safe to
> > set the write bit.
> > 
> > Or do you perhaps have solid clue and think it's always safe
> The problem I am having with this broader change, is that this changes
> something independent of your original patch/problem.
> 
> If we identify this to be an actual problem, it should most probably be
> separate fix + backport.
> 
> 
> My understanding is that vma->vm_page_prot always tells you what the default
> PTE protection in a mapping is.
> 
> If the mapping is private, it is never writable (due to COW). Similarly, if
> the shared file mapping needs writenotify, it is never writable.

Right.

> 
> 
> I consider UFFD-wp a special case: while the default VMA protection might
> state that it is writable, you actually want individual PTEs to be
> write-protected and have to manually remove the protection.
> 
> softdirty tracking is another special case: however, softdirty tracking is
> enabled for the whole VMA. For remove_migration_pte() that should be fine (I
> guess) because writenotify is active when the VMA needs to track softdirty
> bits, and consequently vma->vm_page_prot has the proper default permissions.
> 
> 
> I wonder if the following (valid), for example is possible:
> 
> 
> 1) clear_refs() clears VM_SOFTDIRTY and pte_wrprotect() the pte.
> -> writenotify is active and vma->vm_page_prot updated accordingly
> 
> VM_SOFTDIRTY is reset due to VMA merging and vma->vm_page_prot is updated
> accordingly. See mmap_region() where we set VM_SOFTDIRTY.
> 
> If you now migrate the (still write-protected in the PTE) page, it was not
> writable, but it can be writable on the destination.

I didn't even notice merging could work with soft-dirty enabled, that's
interesting to know.

Yes I think it's possible and I agree it's safe, as VM_SOFTDIRTY is set for
the merged vma so afaiu the write bit is safe to set.  We get a bunch of
false positives but that's how soft-dirty works.

I think the whole problem is easier if we see this at a higher level.
You're discussing this from vma pov and it's fair to do so, at least I
agree with what you mentioned so far and I can't see anything outside
uffd-wp that can be affected.  However, it is also true when you noticed we
already have quite a few paragraphs trying to discuss the safety for this
and that, that's the part where I think we need justification and it's not
that "natural".

For "natural", I meant fundamentally we're talking about page migrations
here.  The natural way (at least to me) for page migration to happen as a
fundamental rule is that, we leverag the migration pte to make sure the pte
being stable so we can do the migration work, then we "recover" the pte to
present either by a full recovery or just (hopefully) only replace the pfn,
keeping all the rest untouched.

One thing to prove that is we have two migration entries not one (I'm
temporarily put the exclusive read one aside since that's solving different
problems): MIGRATION_READ and MIGRATION_WRITE.  If we only rely on vma
flags logically we don't need MIGRATION_READ and MIGRATION_WRITE, we only
need MIGRATION generic swap pte then we recover the write bit from vma
flags and other things (like uffd-wp, currently we have the bit set in swap
pte besides the swap entry type).

So maybe one day we can use two migration types rather than three
(MIGRATION and MIGRATION_EXCLUSIVE)?  I can't tell, but hopefully that
shows what I meant, that we need further justification to grant write bit
only base on vma, rather than recovering write bit based on migration entry
type.

> 
> > 
> > > 
> > > BTW, does unuse_pte() need similar care?
> > > 
> > > new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
> > > if (pte_swp_uffd_wp(*pte))
> > > 	new_pte = pte_mkuffd_wp(new_pte);
> > > set_pte_at(vma->vm_mm, addr, pte, new_pte);
> > 
> > I think unuse path is fine because unuse only applies to private mappings,
> > so we should always have the W bit removed there within mk_pte().
> 
> You're right, however, shmem swapping confuses me. Maybe that does not apply
> here.

Yeah these are confusing.  Actually I think the unuse path should apply to
private mappings on shmem when the page was CoWed already and then got
swapped out, but again as long as it's private mapping I think we don't
have write bit anyway in retval of mk_pte() even if it's shmem.

-- 
Peter Xu

