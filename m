Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047355F6B13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiJFP4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiJFP4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:56:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CC9E6B3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:56:41 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m14so1189506ilf.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CjxW0PKCyTrNxuUlcWq36jveOujZNX1r5syNeeGoP8s=;
        b=dYWAXBCfGNdt2FEEr/XAmuM7IcXTbwrbh6ObZ10wCExgLJnFqd7ULWVxtf8SpzsIG2
         xsAwTOGs5muyf1Ek1vxwQDgI6lZcSLPZxoQxbC9yEJlyWJnY9J71hAiD2wS0apDSMGpy
         pV5OUUrYFN5ggX769ElWdweoKedia0K/HYzpH1LVfPgRcuvzzr+lcfXPq5afXHFoVzbX
         Q0JUf8e0b+0XygU3i40KcPg+H+h2FmEktr+/Hc5KZg14AEyg/ARvuaT3odGj4Xxvyg7A
         nxMuU2PF/AkOq1ARlHMI2QbMqJ1SbFUOxUqCIZgJM1O6NwXGF1TNEAjl94MdR7SR44Lo
         Y6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjxW0PKCyTrNxuUlcWq36jveOujZNX1r5syNeeGoP8s=;
        b=NjsW23jg74kksj820XjYWztyRqHxRNauPWUREPC/bFzkabO9wTxv5f99LwYZ4NSqWc
         U8/6PmwGXTMHyMz/x10CzF+Pw7zamF50otI1nEt6ptetl5CuK4X81RS/yAQJTR8HZnCU
         wcrHfTVxIoBmK0j84C6pFqme0xMO7nxdd96rC8Gev0WaTELFIzDBcCPFDUbUeE8VUG97
         flFRR7SMnJkyvUevdgJ4mXTJS5O05kS0YumLG0h/NAslpTjDQF1Qj+DK6ovHtuzlSRqs
         ZaTsU8OGTNLyR1lBPG6+d4xjdoPuSl7IuDWl1Ewdx1TOGSSMAmIy+uYPU6Au1rwULMbb
         tbUw==
X-Gm-Message-State: ACrzQf2YHbQSbKk5VMrT7y15ysd3keTIKZLsK99KNBsjTUm/XwPK/Vj8
        VK40TojoDnGYrwf/EOT6OnL41gcFWuiIwKdc07b+/Z0TllUl5Q==
X-Google-Smtp-Source: AMsMyM60Fv/1iOXbHNVfyXudpJGF9twOcRqcHv9MyUpEc9+XYdMr/+CfmeGaJmP/s5m+16actayvNHIFg5LWPz/vnIQ=
X-Received: by 2002:a05:6602:2dc7:b0:6a5:14e5:d709 with SMTP id
 l7-20020a0566022dc700b006a514e5d709mr229751iow.54.1665071790552; Thu, 06 Oct
 2022 08:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com>
 <Yz7316NubHtw2xCa@nvidia.com>
In-Reply-To: <Yz7316NubHtw2xCa@nvidia.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 17:55:54 +0200
Message-ID: <CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com>
Subject: Re: ptep_get_lockless() on 32-bit x86/mips/sh looks wrong
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Oct 6, 2022 at 5:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Thu, Oct 06, 2022 at 05:23:59PM +0200, Jann Horn wrote:
> > ptep_get_lockless() does the following under CONFIG_GUP_GET_PTE_LOW_HIGH:
> >
> > pte_t pte;
> > do {
> >   pte.pte_low = ptep->pte_low;
> >   smp_rmb();
> >   pte.pte_high = ptep->pte_high;
> >   smp_rmb();
> > } while (unlikely(pte.pte_low != ptep->pte_low));
> >
> > It has a comment above it that argues that this is correct because:
> > 1. A present PTE can't become non-present and then become a present
> > PTE pointing to another page without a TLB flush in between.
> > 2. TLB flushes involve IPIs.
> >
> > As far as I can tell, in particular on x86, _both_ of those
> > assumptions are false; perhaps on mips and sh only one of them is?
> >
> > Number 2 is straightforward: X86 can run under hypervisors, and when
> > it runs under hypervisors, the MMU paravirtualization code (including
> > the KVM version) can implement remote TLB flushes without IPIs.
> >
> > Number 1 is gnarlier, because breaking that assumption implies that
> > there can be a situation where different threads see different memory
> > at the same virtual address because their TLBs are incoherent. But as
> > far as I know, it can happen when MADV_DONTNEED races with an
> > anonymous page fault, because zap_pte_range() does not always flush
> > stale TLB entries before dropping the page table lock. I think that's
> > probably fine, since it's a "garbage in, garbage out" kind of
> > situation - but if a concurrent GUP-fast can then theoretically end up
> > returning a completely unrelated page, that's bad.
> >
> >
> > Sadly, mips and sh don't define arch_cmpxchg_double(), so we can't
> > just change ptep_get_lockless() to use arch_cmpxchg_double() and be
> > done with it...
>
> I think the argument here has nothing to do with IPIs, but is more a
> statement on memory ordering.

The comment above the definition of ptep_get_lockless() claims: "it
will not switch to a completely different present page without a TLB
flush in between; something that we are blocking by holding interrupts
off."

> What we want to get is a non-torn load
> of low/high, under some restricted rules.
>
> PTE writes should be ordered so that the present/not present bit is
> properly:
>
> Zapping a PTE:
>
> write_low (not present)
> wmb()
> write_high (a)
> wmb()
>
> Reestablish a PTE:
>
> write_high (b)
> wmb()
> write_low (present)
> wmb()
>
> This ordering is necessary to make the TLB's atomic 64 bit load work
> properly, otherwise the TLB could read a present entry with a bogus
> other half!
>
> For ptep_get_lockless() we define non-torn as meaning the same as for the TLB:
>
>      pre-zap low / high (present)
>   restablish low / high (b) (present)
>          any low / any high (not present)
>
> Other combinations are forbidden.
>
> The read side has a corresponding list of reads:
>
> read_low
> rmb()
> read_high
> rmb()
> read_low
>
> So, it seems plausible this could be OK based only on atomics (I did
> not check that the present bit is properly placed in the right
> low/high). Do you see a way the atomics don't work out?

The race would be something like this, where A is one thread doing
ptep_get_lockless() and B, C and D are other threads:

<PTE initially points to address 0x0001000100010000>
A: read ptep->pte_low, sees low address half 0x00010000
B: begins MADV_DONTNEED, removes the PTE but doesn't flush TLB yet
C: page fault installs a new PTE pointing to address 0x0001000200020000
A: read ptep->pte_high, sees high address half 0x00010002
C: begins MADV_DONTNEED, removes the PTE but doesn't flush TLB yet
D: page fault installs a new PTE pointing to address 0x0001000300010000
A: re-read ptep->pte_low, sees low address half 0x00010000 matching
the first one
A: returns physical address 0x000100020x00010000, which was never
actually in the PTE

So it's not a problem with the memory ordering, it's just that it's
not possible to atomically read a 64-bit PTE with 32-bit reads when
the PTE can completely change under you - and ptep_get_lockless() was
written under the assumption that this can't happen because of TLB
flush IPIs.
