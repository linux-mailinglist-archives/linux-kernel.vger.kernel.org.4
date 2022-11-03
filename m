Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D886188D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKCTgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942761CFF4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F28261E6E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC06C433C1;
        Thu,  3 Nov 2022 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667504159;
        bh=zcoG/+WvByXxxHPPM3wHg/JURpe0ekEhkjLQoWAGhZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUgD8oT9cbo3l/wCfTbjVuXwW6h5DNa8vDkMjOVwoVzb7ap7fvlX6Npne6FNzY1LL
         +JoF4UyvL8q7C7D9pl1XfEWIsY22dareueuT+c957nvXJRGSKWiX/ikAWEvDav4NAR
         3PBavyPvHY8mG42ZLNvy1JYg/JTSSSZ0ag2l8N/KdQ4wtJqaYHfKYK598+MSf1lNgu
         PKEbfiEWZCsBrskIvAR/sFWeY5VhsPGiV3HsG9visFtaw+ovlyJHVOBFXxR4CvpAvL
         B19YyqQbnN15ZJcR88G8uDbHPa8jGXZA5+Qfzs8HSUZtYH74KWAA5aMMdxlDABnVve
         BY8e0vGH/fbKw==
Date:   Thu, 3 Nov 2022 12:35:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:23:41PM +0100, Uros Bizjak wrote:
> On Thu, Nov 3, 2022 at 8:09 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Peter,
> >
> > On Sat, Oct 22, 2022 at 01:14:14PM +0200, Peter Zijlstra wrote:
> > > The use of set_64bit() in X86_64 only code is pretty pointless, seeing
> > > how it's a direct assignment. Remove all this nonsense.
> > >
> > > Additionally, since x86_64 unconditionally has HAVE_CMPXCHG_DOUBLE,
> > > there is no point in even having that fallback.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/um/include/asm/pgtable-3level.h |    8 --------
> > >  arch/x86/include/asm/cmpxchg_64.h    |    5 -----
> > >  drivers/iommu/intel/irq_remapping.c  |   10 ++--------
> > >  3 files changed, 2 insertions(+), 21 deletions(-)
> > >
> > > --- a/arch/um/include/asm/pgtable-3level.h
> > > +++ b/arch/um/include/asm/pgtable-3level.h
> > > @@ -58,11 +58,7 @@
> > >  #define pud_populate(mm, pud, pmd) \
> > >       set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
> > >
> > > -#ifdef CONFIG_64BIT
> > > -#define set_pud(pudptr, pudval) set_64bit((u64 *) (pudptr), pud_val(pudval))
> > > -#else
> > >  #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
> > > -#endif
> > >
> > >  static inline int pgd_newpage(pgd_t pgd)
> > >  {
> > > @@ -71,11 +67,7 @@ static inline int pgd_newpage(pgd_t pgd)
> > >
> > >  static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
> > >
> > > -#ifdef CONFIG_64BIT
> > > -#define set_pmd(pmdptr, pmdval) set_64bit((u64 *) (pmdptr), pmd_val(pmdval))
> > > -#else
> > >  #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
> > > -#endif
> > >
> > >  static inline void pud_clear (pud_t *pud)
> > >  {
> > > --- a/arch/x86/include/asm/cmpxchg_64.h
> > > +++ b/arch/x86/include/asm/cmpxchg_64.h
> > > @@ -2,11 +2,6 @@
> > >  #ifndef _ASM_X86_CMPXCHG_64_H
> > >  #define _ASM_X86_CMPXCHG_64_H
> > >
> > > -static inline void set_64bit(volatile u64 *ptr, u64 val)
> > > -{
> > > -     *ptr = val;
> > > -}
> > > -
> > >  #define arch_cmpxchg64(ptr, o, n)                                    \
> > >  ({                                                                   \
> > >       BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > > --- a/drivers/iommu/intel/irq_remapping.c
> > > +++ b/drivers/iommu/intel/irq_remapping.c
> > > @@ -173,7 +173,6 @@ static int modify_irte(struct irq_2_iomm
> > >       index = irq_iommu->irte_index + irq_iommu->sub_handle;
> > >       irte = &iommu->ir_table->base[index];
> > >
> > > -#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE)
> > >       if ((irte->pst == 1) || (irte_modified->pst == 1)) {
> > >               bool ret;
> > >
> > > @@ -187,11 +186,6 @@ static int modify_irte(struct irq_2_iomm
> > >                * same as the old value.
> > >                */
> > >               WARN_ON(!ret);
> > > -     } else
> > > -#endif
> > > -     {
> > > -             set_64bit(&irte->low, irte_modified->low);
> > > -             set_64bit(&irte->high, irte_modified->high);
> > >       }
> > >       __iommu_flush_cache(iommu, irte, sizeof(*irte));
> 
> It looks to me that the above part should not be removed, but
> set_64bit should be substituted with WRITE_ONCE. Only #if/#endif lines
> should be removed.

Thanks, I also realized that only a couple minutes after I sent my
initial message. I just got done testing the following diff, which
resolves my issue. Peter, would you like a formal patch or did you want
to squash it in to the original change?

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 4216cafd67e7..5d176168bb76 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -186,6 +186,9 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 		 * same as the old value.
 		 */
 		WARN_ON(!ret);
+	} else {
+		WRITE_ONCE(irte->low, irte_modified->low);
+		WRITE_ONCE(irte->high, irte_modified->high);
 	}
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 

> > >
> > > @@ -249,8 +243,8 @@ static int clear_entries(struct irq_2_io
> > >       end = start + (1 << irq_iommu->irte_mask);
> > >
> > >       for (entry = start; entry < end; entry++) {
> > > -             set_64bit(&entry->low, 0);
> > > -             set_64bit(&entry->high, 0);
> > > +             WRITE_ONCE(entry->low, 0);
> > > +             WRITE_ONCE(entry->high, 0);
> > >       }
> > >       bitmap_release_region(iommu->ir_table->bitmap, index,
> > >                             irq_iommu->irte_mask);
> > >
> > >
> >
> > This commit is now in -next as commit 0475a2d10fc7 ("x86_64: Remove
> > pointless set_64bit() usage") and I just bisect a boot failure on my
> > Intel test desktop to it.
> >
> > # bad: [81214a573d19ae2fa5b528286ba23cd1cb17feec] Add linux-next specific files for 20221103
> > # good: [8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a] Merge tag 'parisc-for-6.1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> > git bisect start '81214a573d19ae2fa5b528286ba23cd1cb17feec' '8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a'
> > # good: [8c13089d26d070fef87a64b48191cb7ae6dfbdb2] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> > git bisect good 8c13089d26d070fef87a64b48191cb7ae6dfbdb2
> > # bad: [1bba8e9d15551d2f1c304d8f9d5c647a5b54bfc0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > git bisect bad 1bba8e9d15551d2f1c304d8f9d5c647a5b54bfc0
> > # good: [748c419c7ade509684ce5bcf74f50e13e0447afd] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> > git bisect good 748c419c7ade509684ce5bcf74f50e13e0447afd
> > # good: [0acc81a3bf9f875c5ef03037ff5431d37f536f05] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> > git bisect good 0acc81a3bf9f875c5ef03037ff5431d37f536f05
> > # bad: [c0fb84e0698d2ce57f9391c7f4112f6e17676f99] Merge branch into tip/master: 'x86/cleanups'
> > git bisect bad c0fb84e0698d2ce57f9391c7f4112f6e17676f99
> > # good: [7212c34aac1ec6abadf8b439824c8307ef0dd338] Merge branch 'x86/core' into x86/paravirt, to resolve conflicts
> > git bisect good 7212c34aac1ec6abadf8b439824c8307ef0dd338
> > # good: [e1f2ac1d285d963a783a027a1b109420b07f30c1] Merge branch into tip/master: 'x86/cpu'
> > git bisect good e1f2ac1d285d963a783a027a1b109420b07f30c1
> > # good: [306b75edbf25b86fe8189a4f96c217e49483f8ae] Merge branch into tip/master: 'x86/cleanups'
> > git bisect good 306b75edbf25b86fe8189a4f96c217e49483f8ae
> > # good: [8f28b415703e1935457a4bf0be7f03dc5471d09f] mm: Rename GUP_GET_PTE_LOW_HIGH
> > git bisect good 8f28b415703e1935457a4bf0be7f03dc5471d09f
> > # bad: [0475a2d10fc7ced3268cd0f0551390b5858f90cd] x86_64: Remove pointless set_64bit() usage
> > git bisect bad 0475a2d10fc7ced3268cd0f0551390b5858f90cd
> > # good: [a677802d5b0258f93f54620e1cd181b56547c36c] x86/mm/pae: Don't (ab)use atomic64
> > git bisect good a677802d5b0258f93f54620e1cd181b56547c36c
> > # good: [533627610ae7709572a4fac1393fb61153e2a5b3] x86/mm/pae: Be consistent with pXXp_get_and_clear()
> > git bisect good 533627610ae7709572a4fac1393fb61153e2a5b3
> > # first bad commit: [0475a2d10fc7ced3268cd0f0551390b5858f90cd] x86_64: Remove pointless set_64bit() usage
> > # good: [533627610ae7709572a4fac1393fb61153e2a5b3] x86/mm/pae: Be consistent with pXXp_get_and_clear()
> > git bisect good 533627610ae7709572a4fac1393fb61153e2a5b3
> > # first bad commit: [0475a2d10fc7ced3268cd0f0551390b5858f90cd] x86_64: Remove pointless set_64bit() usage
> >
> > Unfortunately, I see no output on the screen it is attached to so I
> > assume it is happening pretty early during the boot sequence, which will
> > probably make getting logs somewhat hard. I can provide information
> > about the system if that would help reveal anything. If there is
> > anything I can test, I am more than happy to do so.
> >
> > Cheers,
> > Nathan
