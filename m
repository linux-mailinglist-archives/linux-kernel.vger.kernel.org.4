Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69B65242E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiLTQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiLTQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:04:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EE318E15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671552221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHsBBij50mhoSyBuMevxmPD/lcmHG+fHzGKYXun1Pac=;
        b=DsFEwYAYhqhx1iactpYBlrttSb/GlGXDzxM1V4PoHH16ux/yuDmdWIWZrp+8m0GfO3L1cV
        609493MF2HMZaH2MQmbygx23pfG8sSDG7mCFQrjlOyJye/pXP9r2hKhopzpRY6yucB07gm
        /SL5r53gm/g4QYy7Fh4OPlIkS/btXnI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-dr5CBVhsN420mhM_JXvsMg-1; Tue, 20 Dec 2022 11:03:40 -0500
X-MC-Unique: dr5CBVhsN420mhM_JXvsMg-1
Received: by mail-ot1-f70.google.com with SMTP id d18-20020a9d51d2000000b006745346e57bso7276012oth.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHsBBij50mhoSyBuMevxmPD/lcmHG+fHzGKYXun1Pac=;
        b=qdgG1+fJMaRPqo8jgGTqEKkgAfuHarlmKEHy60GRE0ODa2xwm06boGvkr1vTKA2/Z9
         ASgMVnx9DM8VnS+1ftl3sPVGp5pnQKWKyG5WtQeFJ2aoHXqj/fuBCPE1p952CoeGrJCu
         psx+9VoG5LlZqFrLFK0BNdwnOj84B3EU44WFDSZyI4L+RBe9pIRFkyXIR2UZlSa9P31/
         x7ZuP2PpAjpVe9mM0TNSw1kCjH2MwWTqed8AU8lsvKDPg6DPK9mTRB5/XnjORV0koCqb
         uoBcxIhCXcClwVknDUYllaw4XMQ0bngxx46qozdLytVUjLOpoHLBNl6HBeH0dzXcNusD
         /OZg==
X-Gm-Message-State: AFqh2kpZH7cPFb1gTeflLpuqf6cmInlYv3dKmBIqfdrNL5lq3dAUGXLN
        YtFQQvtRBa16SRcR/PXk4WFG+KRireJZ/6COXeqXO5O4Jzle8OsNobah+jMiL7pMLpoA9zo01jI
        TWPSSiTf8B+hvOyy+dTYisQfG
X-Received: by 2002:a05:6808:b15:b0:35e:ae18:9783 with SMTP id s21-20020a0568080b1500b0035eae189783mr6143461oij.8.1671552219494;
        Tue, 20 Dec 2022 08:03:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9x/JehMBrhci4SXiGh76eNNnQW2Xi9nOdubJKRW8QEwlop7Z9tNCR9PjoN0uPNtwSZvjKHQ==
X-Received: by 2002:a05:6808:b15:b0:35e:ae18:9783 with SMTP id s21-20020a0568080b1500b0035eae189783mr6143424oij.8.1671552218975;
        Tue, 20 Dec 2022 08:03:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id h21-20020a05620a401500b006fc6529abaesm9297290qko.101.2022.12.20.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:03:38 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:03:37 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Y6Hc2d+7eTKs7AiH@x1n>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com>
 <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com>
 <Y3vq18eTOE0e7I1+@x1n>
 <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 05:19:12PM +0500, Muhammad Usama Anjum wrote:
> On 11/22/22 2:17 AM, Peter Xu wrote:
> > On Mon, Nov 21, 2022 at 07:57:05PM +0500, Muhammad Usama Anjum wrote:
> >> Hi Peter,
> >>
> >> Thank you so much for replying.
> >>
> >> On 11/19/22 4:14 AM, Peter Xu wrote:
> >>> On Sat, Nov 19, 2022 at 01:16:26AM +0500, Muhammad Usama Anjum wrote:
> >>>> Hi Peter and David,
> >>>
> >>> Hi, Muhammad,
> >>>
> >>>>
> >>>> On 7/25/22 7:20 PM, Peter Xu wrote:
> >>>>> The check wanted to make sure when soft-dirty tracking is enabled we won't
> >>>>> grant write bit by accident, as a page fault is needed for dirty tracking.
> >>>>> The intention is correct but we didn't check it right because VM_SOFTDIRTY
> >>>>> set actually means soft-dirty tracking disabled.  Fix it.
> >>>> [...]
> >>>>> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> >>>>> +{
> >>>>> +	/*
> >>>>> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> >>>>> +	 * enablements, because when without soft-dirty being compiled in,
> >>>>> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> >>>>> +	 * will be constantly true.
> >>>>> +	 */
> >>>>> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>>>> +		return false;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * Soft-dirty is kind of special: its tracking is enabled when the
> >>>>> +	 * vma flags not set.
> >>>>> +	 */
> >>>>> +	return !(vma->vm_flags & VM_SOFTDIRTY);
> >>>>> +}
> >>>> I'm sorry. I'm unable to understand the inversion here.
> >>>>> its tracking is enabled when the vma flags not set.
> >>>> VM_SOFTDIRTY is set on the VMA when new VMA is allocated to mark is
> >>>> soft-dirty. When we write to clear_refs to clear soft-dirty bit,
> >>>> VM_SOFTDIRTY is cleared from the VMA as well. Then why do you say tracking
> >>>> is enabled when the vma flags not set?
> >>>
> >>> Because only when 4>clear_refs happens would VM_SOFTDIRTY be cleared, and
> >>> only until then the real tracking starts (by removing write bits on ptes).
> >> But even if the VM_SOFTDIRTY is set on the VMA, the individual pages are
> >> still marked soft-dirty. Both are independent.
> >>
> >> It means tracking is enabled all the time in individual pages.
> Addition of vma_soft_dirty_enabled() has tinkered with the soft-dirty PTE
> bit status setting. The internal behavior has changed. The test case was
> shared by David
> (https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com/).
> The explanation is as following:
> 
> _Before_ addition of this patch(76aefad628aae),
> m = mmap(2 pages)
> clear_softdirty()
> mremap(m + pag_size)
> mprotect(READ)
> mprotect(READ | WRITE);
> memset(m)
> After memset(),
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	set		set
> /proc//pagemap view	set		set
> 
> 
> _After_ addition of this patch(76aefad628aae)
> m = mmap(2 pages)
> clear_softdirty()
> mremap(m + page_size)
> mprotect(READ)
> mprotect(READ | WRITE);
> memset(m)
> After memset(),
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	*not set*	set
> /proc//pagemap view	set		set
> 
> The user's point of view hasn't changed. But internally after this patch,
> the soft-dirty tracking in PTEs gets turn off if VM_SOFTDIRTY is set. The
> soft-dirty tracking in the PTEs shouldn't be just turned off when mprotect
> is used. Why? Because soft-dirty tracking in the PTEs is always enabled
> regardless of VM_SOFTDIRTY is set or not. Example:
> 
> m = mem(2 pages)
> At this point:
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	not set		not set
> /proc//pagemap view	set		set
> memset(m)
> At this point:
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	set		set
> /proc//pagemap view	set		set
> 
> This example proves that soft-dirty flag on the PTE is set regardless of
> the VM_SOFTDIRTY.

IMHO this is not a proof good enough - it's a kernel internal detail, and
the userspace cannot detect it, right?  Then it looks fine to not keep the
same behavior on the ptes I think.  After all currently the soft-dirty is
designed as "taking either VM_SOFTDIRTY of pte soft-dirty as input of being
dirty".  Nothing violates that.

Your approach introduced PAGEMAP_NO_REUSED_REGIONS but that special
information is not remembered in vma, IIUC that's why you find things
messed up.  Fundamentally, it's because you're trying to reuse soft-dirty
design but it's not completely soft-dirty anymore.

That's also why I mentioned the other async uffd-wp approach because with
that there's no fiddling with vma flags (since it'll be always set as
pre-requisite), and this specific problem shouldn't exist either because
uffd-wp was originally designed to be pte-based as I mentioned, so we can't
grant write if pte is not checked.

Your below change will resolve your problem for now, but it's definitely
not wanted because it has a much broader impact on the whole system, for
example, on vma_wants_writenotify().  We may still have some paths using
default vm_page_prot (especially for file memories, not for the generic PF
path but some others) that will start to lose write bits where we used to
have them set.  That's bad for performance because resolving each of them
needs one more page fault after the change as it mostly invalidated the
write bit in vm_page_prot.

You can also introduce yet another flag in the vma so you can detect which
vma has NEW soft-dirty enabled (your new approach) rather than the OLD
(which still relies on vma flags besides ptes) but that'll really be ugly
and making soft-dirty code unnecessarily complicated.

> 
> The simplest hack to get rid this changed behavior and revert to the
> previous behaviour is as following:
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -860,6 +860,8 @@ static inline bool vma_soft_dirty_enabled(struct
> vm_area_struct *vma)
>         if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>                 return false;
> 
> +       return true;
> +
>         /*
>          * Soft-dirty is kind of special: its tracking is enabled when the
>          * vma flags not set.
> I was trying to verify this hack. But I couldn't previously until @Paul has
> mentioned this again. I've verified with limited tests that this hack
> in-deed works. We are unaware that does this hack create problems in other
> areas or not. We can think of better way to solve this. Once we get the
> comments from the community.
> 
> This internal behavior change is affecting the new feature addition to the
> soft-dirty flag which is already delicate and has issues.
> (https://lore.kernel.org/all/20221109102303.851281-1-usama.anjum@collabora.com/)
> 
> > 
> > IMHO it depends on how we define "tracking enabled" - before clear_refs
> > even if no pages written they'll also be reported as dirty, then the
> > information is useless.
> > 
> >> Only the soft-dirty bit status in individual page isn't significant if
> >> VM_SOFTDIRTY already is set. Right?
> > 
> > Yes.  But I'd say it makes more sense to say "tracking enabled" if we
> > really started tracking (by removing the write bits in ptes, otherwise we
> > did nothing).  When vma created we didn't track anything.
> > 
> > I don't know the rational of why soft-dirty was defined like that.  I think
> > it's somehow related to the fact that we allow false positive dirty pages
> > not false negative.  IOW, it's a bug to leak a page being dirtied, but not
> > vice versa if we report clean page dirty.
> > 
> 
> -- 
> BR,
> Muhammad Usama Anjum
> 

-- 
Peter Xu

