Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640856D6D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjDDTTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDDTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:19:40 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 12:19:37 PDT
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [IPv6:2001:41d0:203:375::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC953A92
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:19:37 -0700 (PDT)
Date:   Tue, 4 Apr 2023 19:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680635974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bE39oER6mn2FeknwM80LYwyihVXXMbmc7AYdxCBaNKA=;
        b=o2lpR3z3PI8EYPXhhSNQwIzQ2F9+bFAurHLQZJzbXBEVzJFyZXWqhNt/bd1MfOXfBjuzQI
        P0AX3UCRyzYkstzP+ET4V+we8YsuEbIBsKbzIcit5BA73KKiBALMyWal2F4R44fMblXhJh
        4e93hK5GgLcKc6db51KQ8hGeCbJp7fk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Raghavendra Rao Ananta <rananta@google.com>, h@linux.dev
Cc:     Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] KVM: arm64: Create a fast stage-2 unmap path
Message-ID: <ZCx4QCs+cjr4nYev@linux.dev>
References: <20230206172340.2639971-1-rananta@google.com>
 <20230206172340.2639971-8-rananta@google.com>
 <ZCTa5wfVtGScLQEa@linux.dev>
 <CAJHc60xvSFpUs+o84fR14Rghd6rruBJkCMBtroeCeLDtjJg=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60xvSFpUs+o84fR14Rghd6rruBJkCMBtroeCeLDtjJg=gw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:52:01AM -0700, Raghavendra Rao Ananta wrote:
> On Wed, Mar 29, 2023 at 5:42 PM Oliver Upton <oliver.upton@linux.dev> wrote:
> >
> > On Mon, Feb 06, 2023 at 05:23:40PM +0000, Raghavendra Rao Ananta wrote:
> > > The current implementation of the stage-2 unmap walker
> > > traverses the entire page-table to clear and flush the TLBs
> > > for each entry. This could be very expensive, especially if
> > > the VM is not backed by hugepages. The unmap operation could be
> > > made efficient by disconnecting the table at the very
> > > top (level at which the largest block mapping can be hosted)
> > > and do the rest of the unmapping using free_removed_table().
> > > If the system supports FEAT_TLBIRANGE, flush the entire range
> > > that has been disconnected from the rest of the page-table.
> > >
> > > Suggested-by: Ricardo Koller <ricarkol@google.com>
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/pgtable.c | 44 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > index 0858d1fa85d6b..af3729d0971f2 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -1017,6 +1017,49 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > >       return 0;
> > >  }
> > >
> > > +/*
> > > + * The fast walker executes only if the unmap size is exactly equal to the
> > > + * largest block mapping supported (i.e. at KVM_PGTABLE_MIN_BLOCK_LEVEL),
> > > + * such that the underneath hierarchy at KVM_PGTABLE_MIN_BLOCK_LEVEL can
> > > + * be disconnected from the rest of the page-table without the need to
> > > + * traverse all the PTEs, at all the levels, and unmap each and every one
> > > + * of them. The disconnected table is freed using free_removed_table().
> > > + */
> > > +static int fast_stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > > +                            enum kvm_pgtable_walk_flags visit)
> > > +{
> > > +     struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
> > > +     kvm_pte_t *childp = kvm_pte_follow(ctx->old, mm_ops);
> > > +     struct kvm_s2_mmu *mmu = ctx->arg;
> > > +
> > > +     if (!kvm_pte_valid(ctx->old) || ctx->level != KVM_PGTABLE_MIN_BLOCK_LEVEL)
> > > +             return 0;
> > > +
> > > +     if (!stage2_try_break_pte(ctx, mmu))
> > > +             return -EAGAIN;
> > > +
> > > +     /*
> > > +      * Gain back a reference for stage2_unmap_walker() to free
> > > +      * this table entry from KVM_PGTABLE_MIN_BLOCK_LEVEL - 1.
> > > +      */
> > > +     mm_ops->get_page(ctx->ptep);
> >
> > Doesn't this run the risk of a potential UAF if the refcount was 1 before
> > calling stage2_try_break_pte()? IOW, stage2_try_break_pte() will drop
> > the refcount to 0 on the page before this ever gets called.
> >
> > Also, AFAICT this misses the CMOs that are required on systems w/o
> > FEAT_FWB. Without them it is possible that the host will read something
> > other than what was most recently written by the guest if it is using
> > noncacheable memory attributes at stage-1.
> >
> > I imagine the actual bottleneck is the DSB required after every
> > CMO/TLBI. Theoretically, the unmap path could be updated to:
> >
> >  - Perform the appropriate CMOs for every valid leaf entry *without*
> >    issuing a DSB.
> >
> >  - Elide TLBIs entirely that take place in the middle of the walk
> >
> >  - After the walk completes, dsb(ish) to guarantee that the CMOs have
> >    completed and the invalid PTEs are made visible to the hardware
> >    walkers. This should be done implicitly by the TLBI implementation
> >
> >  - Invalidate the [addr, addr + size) range of IPAs
> >
> > This would also avoid over-invalidating stage-1 since we blast the
> > entire stage-1 context for every stage-2 invalidation. Thoughts?
> >
> Correct me if I'm wrong, but if we invalidate the TLB after the walk
> is complete, don't you think there's a risk of race if the guest can
> hit in the TLB even though the page was unmapped?

Yeah, we'd need to do the CMOs _after_ making the translation invalid in
the page tables and completing the TLB invalidation. Apologies.

Otherwise, the only requirement we need to uphold w/ either the MMU
notifiers or userspace is that the translation has been invalidated at
the time of return.

-- 
Thanks,
Oliver
