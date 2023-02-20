Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324C69D103
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjBTP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBTP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:56:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3C601C32E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:56:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C95FEC;
        Mon, 20 Feb 2023 07:57:37 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7105D3F703;
        Mon, 20 Feb 2023 07:56:53 -0800 (PST)
Date:   Mon, 20 Feb 2023 15:56:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     syzbot <syzbot+f8ac312e31226e23302b@syzkaller.appspotmail.com>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Subject: Re: [syzbot] upstream-arm64 build error
Message-ID: <Y/OYQqqyyPGUHk0n@FVFF77S0Q05N>
References: <00000000000028ea4105f4e2ef54@google.com>
 <Y/Nwfrb42e6MRrAi@FVFF77S0Q05N>
 <CAMj1kXGhWKPbZAeEx4HOqhswx__mY_mZCzdhgaj6eWw2z3PSQg@mail.gmail.com>
 <Y/OOJfZ7oLuAXSg0@FVFF77S0Q05N>
 <CAMj1kXF6PSNmj7z71mnGmQoXZOkLxyjv9H+6+2psNwS2L510QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF6PSNmj7z71mnGmQoXZOkLxyjv9H+6+2psNwS2L510QA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 04:38:31PM +0100, Ard Biesheuvel wrote:
> On Mon, 20 Feb 2023 at 16:13, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Feb 20, 2023 at 02:18:23PM +0100, Ard Biesheuvel wrote:
> > > On Mon, 20 Feb 2023 at 14:07, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > With my config, the Image size is ~242MiB, and I think what's happening is that
> > > > some branches from .idmap.text to .text are (possibly) out-of-range, but the
> > > > linker doesn't know the final position of the sections yet and hasn't placed
> > > > PLTs, and doesn't know the final size of the sections.
> > > >
> > > > I don't know much about the linker, so that's conjecture, but the below diff
> > > > got rid of the build error for me.
> > >
> > > This issue was reported before here:
> > >
> > > https://lore.kernel.org/all/CAMj1kXGAf7ikEU5jLoik0xrOde0xBg0yJkOo5=PtEtNXoUxMXA@mail.gmail.com/
> > >
> > > and the bisect ended up somewhere else.
> >
> > Ah, sorry; I hadn't spotted that.
> >
> > > The issue seems to be where exactly the veneers for the entire image
> > > are dumped, and when this is right after .idmap.text (being the last
> > > input section with the EXEC ELF attribute), it pushes the
> > > __idmap_text_end symbol over the next 4k boundary.
> >
> > I'm a bit confused as to why veneers for other sections would be dropped in
> > here. Note that these branches (for-next/core and for-kernelci) have your patch
> > moving IDMAP_TEXT into .rodata, so that's no longer the last input section with
> > the EXEC attribute, unless I've misunderstood?
> >
> > Perhaps that's meant to be read as the last input section *within a given
> > output section* ?
> 
> The issue seems subtly different in this case:
> 
>  .idmap.text    0xffffffc01e48e5c0      0x32c arch/arm64/mm/proc.o
>                 0xffffffc01e48e5c0                idmap_cpu_replace_ttbr1
>                 0xffffffc01e48e600                idmap_kpti_install_ng_mappings
>                 0xffffffc01e48e800                __cpu_setup
>  *fill*         0xffffffc01e48e8ec        0x4
>  .idmap.text.stub
>                 0xffffffc01e48e8f0       0x18 linker stubs
>                 0xffffffc01e48f8f0                __idmap_text_end = .
>                 0xffffffc01e48f000                . = ALIGN (0x1000)
>  *fill*         0xffffffc01e48f8f0      0x710
>                 0xffffffc01e490000                idmap_pg_dir = .
> 
> So here, there is 0x18 bytes of stubs, but for some reason, it ends up
> bumping the output pointer by an additional 4k.

Yeah, the 4K bump is bizarre, especially since it's literally +4K and not an
align upwards to the next 4K boundary.

> > If marking the .idmap.text section as non-executable prevents other veneers
> > from being collected there, then I reckon that doing that along with the
> > indirect branches using adr_l + blr should be sufficient? That way there should
> > be no veneers dropped into .idmap.text, and the cost of ADRP+ADD+BLR in a
> > one-time boot path isn't going to be noticeable.
> >
> 
> I guess but I hate making that kind of changes just to make a
> theoretical boot target that nobody uses build.

I appreciate it's niche, but this is a configuration I've been using for
testing for several years (see my fuzzing/* and testing/* branches on
kernel.org), so it's not quite "nobody" unless that was an a judgement on my
popularity. ;)

I'm going to assume that means if I clean this up and post as a proper patch
you're not going to NAK it. :)

> > FWIW, If I modify head.S to replace:
> >
> >   .section ".idmap.text","a"
> >
> > With:
> >
> >   .section ".idmap.text","a"
> >
> 
> You mean ax -> a right? That seems like a reasonable change as long as
> we apply it everywhere, but it would be nice if we wouldn't need it.

Yes, sorry, It's currently "awx", and AFAICT we need neither the "w" nor the
"x".

> > Then the only branches which don't get PLTs are the ones I mentioned earlier,
> > and the linker complains about those becoming truncated:
> >
> > | [mark@lakrids:~/src/linux]% usekorg 12.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j50 Image
> > |   CALL    scripts/checksyscalls.sh
> > |   LDS     arch/arm64/kernel/vmlinux.lds
> > |   AS      arch/arm64/kernel/head.o
> > |   AR      arch/arm64/kernel/built-in.a
> > |   AR      arch/arm64/built-in.a
> > |   AR      built-in.a
> > |   AR      vmlinux.a
> > |   LD      vmlinux.o
> > |   OBJCOPY modules.builtin.modinfo
> > |   GEN     modules.builtin
> > |   MODPOST vmlinux.symvers
> > |   UPD     include/generated/utsversion.h
> > |   CC      init/version-timestamp.o
> > |   LD      .tmp_vmlinux.kallsyms1
> > | arch/arm64/kernel/head.o: in function `primary_entry':
> > | (.idmap.text+0x1c): relocation truncated to fit: R_AARCH64_CALL26 against symbol `dcache_clean_poc' defined in .text section in arch/arm64/mm/cache.o
> > | arch/arm64/kernel/head.o: in function `init_el2':
> > | (.idmap.text+0x88): relocation truncated to fit: R_AARCH64_CALL26 against symbol `dcache_clean_poc' defined in .text section in arch/arm64/mm/cache.o
> > | make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > | make: *** [Makefile:1252: vmlinux] Error 2
> >
> > Is there any reason we need the "wx" attributs for .idmap.text?
> 
> It doesn't really matter - we place these input sections explicitly anyway.

That was my assumption; just checking I haven't missed a subtlety where this
would affect assembler or linker behaviour undesireably.

Thanks,
Mark.

> > With that in mind, does the below look ok? It builds cleanly and boots fine for
> > me with GCC 12.1.0 atop for-next/core.
> >
> > We could wrap the adr_l + blr into a blr_l macro for legibility.
> >
> > Thanks,
> > Mark.
> >
> > ---->8----
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 212d93aca5e61..b98970907226b 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -70,7 +70,7 @@
> >
> >         __EFI_PE_HEADER
> >
> > -       .section ".idmap.text","awx"
> > +       .section ".idmap.text","a"
> >
> >         /*
> >          * The following callee saved general purpose registers are used on the
> > @@ -99,7 +99,8 @@ SYM_CODE_START(primary_entry)
> >         cbz     x19, 0f
> >         adrp    x0, __idmap_text_start
> >         adr_l   x1, __idmap_text_end
> > -       bl      dcache_clean_poc
> > +       adr_l   x2, dcache_clean_poc
> > +       blr     x2
> >  0:     mov     x0, x19
> >         bl      init_kernel_el                  // w0=cpu_boot_mode
> >         mov     x20, x0
> > @@ -527,7 +528,7 @@ SYM_FUNC_END(__primary_switched)
> >   * end early head section, begin head code that is also used for
> >   * hotplug and needs to have the same protections as the text region
> >   */
> > -       .section ".idmap.text","awx"
> > +       .section ".idmap.text","a"
> >
> >  /*
> >   * Starting from EL2 or EL1, configure the CPU to execute at the highest
> > @@ -566,7 +567,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
> >         cbz     x0, 0f
> >         adrp    x0, __hyp_idmap_text_start
> >         adr_l   x1, __hyp_text_end
> > -       bl      dcache_clean_poc
> > +       adr_l   x2, dcache_clean_poc
> > +       blr     x2
> >  0:
> >         mov_q   x0, HCR_HOST_NVHE_FLAGS
> >         msr     hcr_el2, x0
> > @@ -728,7 +730,7 @@ SYM_FUNC_END(set_cpu_boot_mode_flag)
> >   * Checks if the selected granule size is supported by the CPU.
> >   * If it isn't, park the CPU
> >   */
> > -       .section ".idmap.text","awx"
> > +       .section ".idmap.text","a"
> >  SYM_FUNC_START(__enable_mmu)
> >         mrs     x3, ID_AA64MMFR0_EL1
> >         ubfx    x3, x3, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
