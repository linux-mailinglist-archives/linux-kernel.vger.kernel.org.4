Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C672D6D6C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjDDSls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjDDSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:41:43 -0400
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA850135
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:41:41 -0700 (PDT)
Date:   Tue, 4 Apr 2023 18:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680633699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CD1jFme43qexXcrz2XKuPM7oAmE3rbgRSVHroXDqbrw=;
        b=XxMWM4k6DzmlzlUYCTPsBpVShgELiUyXykVncoQOI9O0ryTtAg39juJqr096OjqQhF24JI
        uEvzoH7ILn2I9mZGvoxalTYWjyS69x8X3o/W6iSilKD5dhH0vV8RaOw4on8UiGaV1aQyrs
        OqJuRLoiUX/kY7qk/unXspbmaHW8FqA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Raghavendra Rao Ananta <rananta@google.com>
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
Subject: Re: [PATCH v2 2/7] KVM: arm64: Add FEAT_TLBIRANGE support
Message-ID: <ZCxvXq0dftq/Szra@linux.dev>
References: <20230206172340.2639971-1-rananta@google.com>
 <20230206172340.2639971-3-rananta@google.com>
 <ZCTjirkCgBkT65eP@linux.dev>
 <CAJHc60y1BLQC4c0qXCuqF7JfewBC_fG2xuH0Wj0AHJh9x3CK5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHc60y1BLQC4c0qXCuqF7JfewBC_fG2xuH0Wj0AHJh9x3CK5g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:26:01AM -0700, Raghavendra Rao Ananta wrote:
> Hi Oliver,
> 
> On Wed, Mar 29, 2023 at 6:19 PM Oliver Upton <oliver.upton@linux.dev> wrote:
> >
> > On Mon, Feb 06, 2023 at 05:23:35PM +0000, Raghavendra Rao Ananta wrote:
> > > Define a generic function __kvm_tlb_flush_range() to
> > > invalidate the TLBs over a range of addresses. The
> > > implementation accepts 'op' as a generic TLBI operation.
> > > Upcoming patches will use this to implement IPA based
> > > TLB invalidations (ipas2e1is).
> > >
> > > If the system doesn't support FEAT_TLBIRANGE, the
> > > implementation falls back to flushing the pages one by one
> > > for the range supplied.
> > >
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_asm.h | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > > index 43c3bc0f9544d..995ff048e8851 100644
> > > --- a/arch/arm64/include/asm/kvm_asm.h
> > > +++ b/arch/arm64/include/asm/kvm_asm.h
> > > @@ -221,6 +221,24 @@ DECLARE_KVM_NVHE_SYM(__per_cpu_end);
> > >  DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
> > >  #define __bp_harden_hyp_vecs CHOOSE_HYP_SYM(__bp_harden_hyp_vecs)
> > >
> > > +#define __kvm_tlb_flush_range(op, mmu, start, end, level, tlb_level) do {    \
> > > +     unsigned long pages, stride;                                            \
> > > +                                                                             \
> > > +     stride = kvm_granule_size(level);                                       \
> >
> > Hmm... There's a rather subtle and annoying complication here that I
> > don't believe is handled.
> >
> > Similar to what I said in the last spin of the series, there is no
> > guarantee that a range of IPAs is mapped at the exact same level
> > throughout. Dirty logging and memslots that aren't hugepage aligned
> > could lead to a mix of mapping levels being used within a range of the
> > IPA space.
> >
> Unlike the comment on v1, the level/stride here is used to jump the
> addresses in case the system doesn't support TLBIRANGE. The TTL hint
> is 0.

Right. So we agree that the level is not uniform throughout the provided
range. The invalidation by IPA is also used if 'pages' is odd, even on
systems with TLBIRANGE. We must assume the worst case here, in that the
TLBI by IPA invalidated a single PTE-level entry. You could wind up
over-invalidating in that case, but you'd still be correct.

> That being said, do you think we can always assume the least possible
> stride (say, 4k) and hardcode it?
> With respect to alignment, since the function is only called while
> breaking the table PTE,  do you think it'll still be a problem even if
> we go with the least granularity stride?

I believe so. If we want to apply the range-based invalidations generally
in KVM then we will not always be dealing with a block-aligned chunk of
address.

> > > +     start = round_down(start, stride);                                      \
> > > +     end = round_up(end, stride);                                            \
> > > +     pages = (end - start) >> PAGE_SHIFT;                                    \
> > > +                                                                             \
> > > +     if ((!system_supports_tlb_range() &&                                    \
> > > +          (end - start) >= (MAX_TLBI_OPS * stride)) ||                       \
> >
> > Doesn't checking for TLBIRANGE above eliminate the need to test against
> > MAX_TLBI_OPS?
> >
> Derived from __flush_tlb_range(), I think the condition is used to
> just flush everything if the range is too large to iterate and flush
> when the system doesn't support TLBIRANGE. Probably to prevent
> soft-lockups?

Right, but you test above for system_supports_tlb_range(), meaning that
you'd unconditionally call __kvm_tlb_flush_vmid() below.

> > > +         pages >= MAX_TLBI_RANGE_PAGES) {                                    \
> > > +             __kvm_tlb_flush_vmid(mmu);                                      \
> > > +             break;                                                          \
> > > +     }                                                                       \
> > > +                                                                             \
> > > +     __flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false);    \
> > > +} while (0)

-- 
Thanks,
Oliver
