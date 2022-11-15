Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B418629ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiKONmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKONmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:42:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D896186E2;
        Tue, 15 Nov 2022 05:42:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6EC36177F;
        Tue, 15 Nov 2022 13:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EEEC433D6;
        Tue, 15 Nov 2022 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668519753;
        bh=xHg3G395U98Mtabx7NVsrASIF/dX0dl0qNOXLK3KOTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liQxIWNpicfA25wBWONZ7cL9EJvz3sxD4CNmKzpBV3aybNTotJhJrQhrUukDkuzEL
         97siY3fsyD9xazMtE8tH+DDLR6k86yuO75G4xm35SXUFG3mWgLjl4Uhm0velhlPHB1
         wwaFlte4uekp2sTAE4kz234fiY+hCARhibqDWwlngg1e7kywNxuUvDEBaeEJhWypNh
         2kffWPG7vL+2bKYfOxSVVmiIEhLVWhMVxP53vQvHs2JeQwS7JpjQf2GfUbnWmc9AOV
         /NoHbZ8zupGdw9t382H4VSs4aKXGGMMU0ubTlkFTLRPpblyEgt5ltYL/+DXDAJ1zb0
         XsFyX+wUy7oSA==
Date:   Tue, 15 Nov 2022 13:42:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Message-ID: <20221115134226.GD524@willie-the-truck>
References: <20221113012645.190301-1-anshuman.khandual@arm.com>
 <20221113012645.190301-3-anshuman.khandual@arm.com>
 <20221115133854.GC524@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115133854.GC524@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 01:38:54PM +0000, Will Deacon wrote:
> On Sun, Nov 13, 2022 at 06:56:45AM +0530, Anshuman Khandual wrote:
> > If a Cortex-A715 cpu sees a page mapping permissions change from executable
> > to non-executable, it may corrupt the ESR_ELx and FAR_ELx registers, on the
> > next instruction abort caused by permission fault.
> > 
> > Only user-space does executable to non-executable permission transition via
> > mprotect() system call which calls ptep_modify_prot_start() and ptep_modify
> > _prot_commit() helpers, while changing the page mapping. The platform code
> > can override these helpers via __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION.
> > 
> > Work around the problem via doing a break-before-make TLB invalidation, for
> > all executable user space mappings, that go through mprotect() system call.
> > This overrides ptep_modify_prot_start() and ptep_modify_prot_commit(), via
> > defining HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION on the platform thus giving
> > an opportunity to intercept user space exec mappings, and do the necessary
> > TLB invalidation. Similar interceptions are also implemented for HugeTLB.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  Documentation/arm64/silicon-errata.rst |  2 ++
> >  arch/arm64/Kconfig                     | 16 ++++++++++++++++
> >  arch/arm64/include/asm/hugetlb.h       |  9 +++++++++
> >  arch/arm64/include/asm/pgtable.h       |  9 +++++++++
> >  arch/arm64/kernel/cpu_errata.c         |  7 +++++++
> >  arch/arm64/mm/hugetlbpage.c            | 21 +++++++++++++++++++++
> >  arch/arm64/mm/mmu.c                    | 21 +++++++++++++++++++++
> >  arch/arm64/tools/cpucaps               |  1 +
> >  8 files changed, 86 insertions(+)
> 
> [...]
> 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 9a7c38965154..c1fb0ce1473c 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1702,3 +1702,24 @@ static int __init prevent_bootmem_remove_init(void)
> >  }
> >  early_initcall(prevent_bootmem_remove_init);
> >  #endif
> > +
> > +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
> > +{
> > +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> > +		pte_t pte = READ_ONCE(*ptep);
> > +		/*
> > +		 * Break-before-make (BBM) is required for all user space mappings
> > +		 * when the permission changes from executable to non-executable
> > +		 * in cases where cpu is affected with errata #2645198.
> > +		 */
> > +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> > +			return ptep_clear_flush(vma, addr, ptep);
> > +	}
> > +	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
> > +}
> > +
> > +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
> > +			     pte_t old_pte, pte_t pte)
> > +{
> > +	__set_pte_at(vma->vm_mm, addr, ptep, pte);
> > +}
> 
> So these are really similar to the generic copies and, in looking at
> change_pte_range(), it appears that we already invalidate the TLB, it just
> happens _after_ writing the new version.
> 
> So with your change, I think we end up invalidating twice. Can we instead
> change the generic code to invalidate the TLB before writing the new entry?

Bah, scratch that, the invalidations are all batched, aren't they?

It just seems silly that we have to add all this code just to do a TLB
invalidation.

Will
