Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2A5BED9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiITTZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiITTZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:25:35 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D08B4B0DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:25:33 -0700 (PDT)
Date:   Tue, 20 Sep 2022 19:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663701932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opjBQT+KUUTUTOINtMinmfnFqSJMY1GahFg1/kUGeAQ=;
        b=R21ULCIb311qSFCfDr6wErlsTHVHAB0eXPvclfG1/epL5qC4oF8QKCtX3CI1DTr86tDaJW
        HWHbLoG8BoGmlcy5rYCDunGvsNpoaIyd/5GvGCEimXQBSmE3EJyDPDJDOok+Fy2vGhrlMh
        659+CXY4N53i1wz/JZVxZSQZcP9yJuc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Ricardo Koller <ricarkol@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to 1GB
Message-ID: <YyoTqNcI6mE/+wAi@google.com>
References: <20220920183630.3376939-1-oliver.upton@linux.dev>
 <YyoOMOJxPJkxALtL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyoOMOJxPJkxALtL@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ricardo,

On Tue, Sep 20, 2022 at 12:02:08PM -0700, Ricardo Koller wrote:
> On Tue, Sep 20, 2022 at 06:36:29PM +0000, Oliver Upton wrote:
> > Presently stage2_apply_range() works on a batch of memory addressed by a
> > stage 2 root table entry for the VM. Depending on the IPA limit of the
> > VM and PAGE_SIZE of the host, this could address a massive range of
> > memory. Some examples:
> > 
> >   4 level, 4K paging -> 512 GB batch size
> > 
> >   3 level, 64K paging -> 4TB batch size
> > 
> > Unsurprisingly, working on such a large range of memory can lead to soft
> > lockups. When running dirty_log_perf_test:
> > 
> >   ./dirty_log_perf_test -m -2 -s anonymous_thp -b 4G -v 48
> > 
> >   watchdog: BUG: soft lockup - CPU#0 stuck for 45s! [dirty_log_perf_:16703]
> >   Modules linked in: vfat fat cdc_ether usbnet mii xhci_pci xhci_hcd sha3_generic gq(O)
> >   CPU: 0 PID: 16703 Comm: dirty_log_perf_ Tainted: G           O       6.0.0-smp-DEV #1
> >   pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   pc : dcache_clean_inval_poc+0x24/0x38
> >   lr : clean_dcache_guest_page+0x28/0x4c
> >   sp : ffff800021763990
> >   pmr_save: 000000e0
> >   x29: ffff800021763990 x28: 0000000000000005 x27: 0000000000000de0
> >   x26: 0000000000000001 x25: 00400830b13bc77f x24: ffffad4f91ead9c0
> >   x23: 0000000000000000 x22: ffff8000082ad9c8 x21: 0000fffafa7bc000
> >   x20: ffffad4f9066ce50 x19: 0000000000000003 x18: ffffad4f92402000
> >   x17: 000000000000011b x16: 000000000000011b x15: 0000000000000124
> >   x14: ffff07ff8301d280 x13: 0000000000000000 x12: 00000000ffffffff
> >   x11: 0000000000010001 x10: fffffc0000000000 x9 : ffffad4f9069e580
> >   x8 : 000000000000000c x7 : 0000000000000000 x6 : 000000000000003f
> >   x5 : ffff07ffa2076980 x4 : 0000000000000001 x3 : 000000000000003f
> >   x2 : 0000000000000040 x1 : ffff0830313bd000 x0 : ffff0830313bcc40
> >   Call trace:
> >    dcache_clean_inval_poc+0x24/0x38
> >    stage2_unmap_walker+0x138/0x1ec
> >    __kvm_pgtable_walk+0x130/0x1d4
> >    __kvm_pgtable_walk+0x170/0x1d4
> >    __kvm_pgtable_walk+0x170/0x1d4
> >    __kvm_pgtable_walk+0x170/0x1d4
> >    kvm_pgtable_stage2_unmap+0xc4/0xf8
> >    kvm_arch_flush_shadow_memslot+0xa4/0x10c
> >    kvm_set_memslot+0xb8/0x454
> >    __kvm_set_memory_region+0x194/0x244
> >    kvm_vm_ioctl_set_memory_region+0x58/0x7c
> >    kvm_vm_ioctl+0x49c/0x560
> >    __arm64_sys_ioctl+0x9c/0xd4
> >    invoke_syscall+0x4c/0x124
> >    el0_svc_common+0xc8/0x194
> >    do_el0_svc+0x38/0xc0
> >    el0_svc+0x2c/0xa4
> >    el0t_64_sync_handler+0x84/0xf0
> >    el0t_64_sync+0x1a0/0x1a4
> > 
> > Given the various paging configurations used by KVM at stage 2 there
> > isn't a sensible page table level to use as the batch size. Use 1GB as
> > the batch size instead, as it is evenly divisible by all supported
> > hugepage sizes across 4K, 16K, and 64K paging.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> > 
> > Applies to 6.0-rc3. Tested with 4K and 64K pages with the above
> > dirty_log_perf_test command and noticed no more soft lockups. I don't
> > have a 16K system to test with.
> > 
> > Marc, we spoke about this a while ago and agreed to go for some page
> > table level based batching scheme. However, I decided against that
> > because it doesn't really solve the problem for non-4K kernels.
> > 
> >  arch/arm64/include/asm/stage2_pgtable.h | 20 --------------------
> >  arch/arm64/kvm/mmu.c                    |  8 +++++++-
> >  2 files changed, 7 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> > index fe341a6578c3..c8dca8ae359c 100644
> > --- a/arch/arm64/include/asm/stage2_pgtable.h
> > +++ b/arch/arm64/include/asm/stage2_pgtable.h
> > @@ -10,13 +10,6 @@
> >  
> >  #include <linux/pgtable.h>
> >  
> > -/*
> > - * PGDIR_SHIFT determines the size a top-level page table entry can map
> > - * and depends on the number of levels in the page table. Compute the
> > - * PGDIR_SHIFT for a given number of levels.
> > - */
> > -#define pt_levels_pgdir_shift(lvls)	ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (lvls))
> > -
> >  /*
> >   * The hardware supports concatenation of up to 16 tables at stage2 entry
> >   * level and we use the feature whenever possible, which means we resolve 4
> > @@ -30,11 +23,6 @@
> >  #define stage2_pgtable_levels(ipa)	ARM64_HW_PGTABLE_LEVELS((ipa) - 4)
> >  #define kvm_stage2_levels(kvm)		VTCR_EL2_LVLS(kvm->arch.vtcr)
> >  
> > -/* stage2_pgdir_shift() is the size mapped by top-level stage2 entry for the VM */
> > -#define stage2_pgdir_shift(kvm)		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
> > -#define stage2_pgdir_size(kvm)		(1ULL << stage2_pgdir_shift(kvm))
> > -#define stage2_pgdir_mask(kvm)		~(stage2_pgdir_size(kvm) - 1)
> > -
> >  /*
> >   * kvm_mmmu_cache_min_pages() is the number of pages required to install
> >   * a stage-2 translation. We pre-allocate the entry level page table at
> > @@ -42,12 +30,4 @@
> >   */
> >  #define kvm_mmu_cache_min_pages(kvm)	(kvm_stage2_levels(kvm) - 1)
> >  
> > -static inline phys_addr_t
> > -stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
> > -{
> > -	phys_addr_t boundary = (addr + stage2_pgdir_size(kvm)) & stage2_pgdir_mask(kvm);
> > -
> > -	return (boundary - 1 < end - 1) ? boundary : end;
> > -}
> > -
> >  #endif	/* __ARM64_S2_PGTABLE_H_ */
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index c9a13e487187..d64032b9fbb6 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -31,6 +31,12 @@ static phys_addr_t hyp_idmap_vector;
> >  
> >  static unsigned long io_map_base;
> >  
> > +static inline phys_addr_t stage2_apply_range_next(phys_addr_t addr, phys_addr_t end)
> > +{
> > +	phys_addr_t boundary = addr + SZ_1G;
> 
> I think you want this to be aligned-down to 1G as well. At least
> stage2_pgd_addr_end() was doing so, plus it reduces the number of
> operations (e.g., when splitting a 1GB huge page when the address is
> unaligned).

Doh! Yeah, we'll want to preserve the alignment that was being done. I'll
post v2 here in a few days but I'll include your suggestion.

--
Thanks,
Oliver
