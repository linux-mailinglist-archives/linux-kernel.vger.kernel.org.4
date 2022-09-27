Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD715EB63D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiI0AYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiI0AYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:24:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7430C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:24:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so909752pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FVHGtYud7j+TinhRk0Oj0kpaihso/Zh2+gft6elVZaA=;
        b=nR9lKmiMiqGKmEqlY1OFRY5wvSYDGQ+IGHwkuNkZ5uOh7ueyfl1qnsWHsEncw0THtU
         ttt698wZDhzNdXiDyV0FES6OZdwSdcEVCK0CpvN8qBJA9jCOPaHSh7cP+GxLbnK5TQNz
         tJpiwJsN2nIHWT7I3ibmhTj/Eild+zjAgu9Q92bB4959PEaCsmQYU0rpy/04LjL8jbki
         AYfHL5ixBItqm0MnI3fNetBC1sLNEzNS1E5r2bUTttnEKOYIrXDPUZrmlS6f8oQ3MtoD
         l3zpZvhWqmUk20eMUxI5Lbz5prYL5LOZfbKmCkZtDpP3feAGouzjKuuB0HpMVk5j7K0b
         RLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FVHGtYud7j+TinhRk0Oj0kpaihso/Zh2+gft6elVZaA=;
        b=o2dj3j5JuDvvz1A2NGlcC361DIymkno7vE0MMYCVhkacn+pCMd8u5PlqKn4GeN0O1y
         BKTalEavBQC6f+bdCZowTtYHSdYJv/uUzWa7Ygo+edXjyaYB6EyWbrCrMraDO7mwQxnM
         o2b/p2K9FPxWKWzfO4+W1xtCEDyNcuwJDyU0Jj1iuDj03robjJNWroNp03ssTesMfzCy
         P4XxbSGgmXVBOSFYUVcQLRzL8fd9mz35xfmtxp/U+lg0J2O+q0M3KCRXCB3qEdTGj/86
         8VoKMucjImbKbb/NZ1heObvzs0DzAOvzbcgw2FDEJnGx5IrYBQQeF0msZXLJ8pR7+GLK
         NRfg==
X-Gm-Message-State: ACrzQf2SuXwVhhxs2oh1BHodzSXANDybYvipAr8W1/6n05v7e9nWuQXF
        FMX2WaSDEWS1dbzeExZQBFOniQ==
X-Google-Smtp-Source: AMsMyM4EFvGoGl0C+uHpbpm80WZcxdN1g3sT9qDpjgtEf10wN95IrszxCieJx2Kffs0/DNo+BC1pYg==
X-Received: by 2002:a17:902:f548:b0:178:44b:4ea9 with SMTP id h8-20020a170902f54800b00178044b4ea9mr24614393plf.77.1664238285344;
        Mon, 26 Sep 2022 17:24:45 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t15-20020a63534f000000b00439c1e13112sm73737pgl.22.2022.09.26.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:24:44 -0700 (PDT)
Date:   Tue, 27 Sep 2022 00:24:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
Subject: Re: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush
 and mremap())
Message-ID: <YzJCyTD4kBSt3VlU@google.com>
References: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
 <Yy3skVk/DvwVnPXD@nvidia.com>
 <YzIHzIxknGNba6CC@google.com>
 <YzI2jzvc8D9lYU6G@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzI2jzvc8D9lYU6G@nvidia.com>
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

On Mon, Sep 26, 2022, Jason Gunthorpe wrote:
> On Mon, Sep 26, 2022 at 08:13:00PM +0000, Sean Christopherson wrote:
> 
> > > AFAIK if we are flushing the CPU tlb then we really must also flush
> > > the CPU tlb that KVM controls, and that is primarily what
> > > invalidate_range() is used for.
> > 
> > As above, for its actual secondary MMU, KVM invalidates and flushes at
> > invalidate_range_start(), and then prevents vCPUs from creating new entries for
> > the range until invalidate_range_start_end().
> 
> Was it always like this? Why did we add this invalidate_range thing if
> nothing really needed it?

No, the invalidate_range() hook was added by commit 1897bdc4d331 ("mmu_notifier:
add mmu_notifier_invalidate_range()") for IOMMUs.  From that changelog, the key
issue is stalling hardware while the start+end pair is ongoing runs afoul of GPUs
that don't play nice with re-faulting "indefinitely.

    The page-fault handler in the AMD IOMMUv2 driver doesn't handle the fault
    if an invalidate_range_start/end pair is active, it just reports back
    SUCCESS to the device and let it refault the page.  But existing hardware
    (newer Radeon GPUs) that makes use of this feature don't re-fault
    indefinitly, after a certain number of faults for the same address the
    device enters a failure state and needs to be resetted.
    
    To avoid the GPUs entering a failure state we need to get rid of the
    empty-page-table workaround and use the mmu_notifier_invalidate_range()
    function introduced with this patch.

> That means iommu is really the only place using it as a proper
> synchronous shadow TLB flush.

More or less. There's also an "OpenCAPI coherent accelerator support" driver,
drivers/misc/ocxl, that appears use invalidate_range() the same way the IOMMU does.
No idea how relevant that is these days.

I much prefer KVM's (and the old IOMMU's) approach of re-faulting in hardware until
the entire sequence completes.   It _might_ be less performant, but I find it so
much easier to reason about.  I actually had typed out a "can we just kill off
mmu_notifier_invalidate_range() and force users to refault hardware" question
before seeing the above changelog.

> > > Which makes me wonder if the invalidate_range() hidden inside
> > > invalidate_end() is a bad idea in general - when is this need and
> > > would be correct? Isn't it better to put the invalidates near the TLB
> > > invalidates and leave start/end as purely a bracketing API, which by
> > > definition, cannot have an end that is 'too late'?
> > 
> > Documentation/mm/mmu_notifier.rst explains this, although even that is quite subtle.
> > The argument is that if the change is purely to downgrade protections, then
> > deferring invalidate_range() is ok because the only requirement is that secondary
> > MMUs invalidate before the "end" of the sequence.
> > 
> >   When changing a pte to write protect or to point to a new write protected page  
> >   with same content (KSM) it is fine to delay the mmu_notifier_invalidate_range   
> >   call to mmu_notifier_invalidate_range_end() outside the page table lock. This   
> 
> And then if KVM never needed it why on earth did we micro-optimize it
> in such an obscure and opaque way?

I don't know.  I found the series that introduced the behavior[*], but there are
no numbers provided and I haven't been able to dredge up why this was even looked
into in the first place.  From the cover letter:

  It should improve performances but i am lacking hardware and benchmarks
  which might show an improvement. Maybe folks in cc can help here.

[*] https://lore.kernel.org/all/20171017031003.7481-1-jglisse@redhat.com

> >   is true even if the thread doing the page table update is preempted right after 
> >   releasing page table lock but before call mmu_notifier_invalidate_range_end().
> 
> That feels like it is getting dangerously close to the CVE Jan pointed
> at.. We have a write protected page, installed in the PTEs, PTLs
> unlocked and other things can sense the PTE and see that it is write
> protected - is it really true nothing acts on that - especially now
> that DavidH has gone and changed all that logic?
> 
> IMHO if we had logic that required the CPU TLB to be flushed under a
> certain lock I find it to be a very, very, difficult conceptual leap
> that a shadow TLB is OK to flush later.  If the shadow TLB is OK then
> lets move the CPU TLB out of the lock as well :)
> 
> > That said, I also dislike hiding invalidate_range() inside end(), I constantly
> > forget about that behavior.  To address that, what about renaming
> > mmu_notifier_invalidate_range_end() to make it more explicit, e.g.
> > mmu_notifier_invalidate_range_and_end().
> 
> The name for the special case should really capture that hidden point
> above 'invalidate_range_delayed_write_protect_end' or something else
> long and horrible. Because it really is special, it is really is only
> allowed in that one special case (assuming the logic still holds) and
> every other possible case should catch the invalidate through the tlb
> flusher.

If I had a vote to cast, I would vote to always do invalidate_range() at the same
time the primary TLBs are flushed.  That seems completely logical and much harder
to screw up.  I might be a little biased though since KVM doesn't benefit from the
current shenanigans :-)
