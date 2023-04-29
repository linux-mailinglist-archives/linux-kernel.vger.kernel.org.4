Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BE46F23B1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjD2IPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjD2IPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 04:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97326A6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 01:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B6C60EA5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD51C433D2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682756100;
        bh=q5AlVoiOQJhfivtd0wNfzYog0DxvF++QpqKUdYK74AY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bSreGOfs2/Yc5/AVKlTWeAZZ4VB5+Mq2Oj/Sho9l6ErZo4Lj8zXjeoXSbLvRhZfAu
         b29MyBASS1pwshyCKBGG6i1mhWs3xdimgrlG/Qthpot3HuY3RwIENdLKrR/vIWth9V
         9op0IbOMwZQ67xoh0N8XTD4joWRUtySH+nY5uw+viUX1jmjbNN0tbbU/p6Z8tmdhpH
         47b5u3rZnNtYCVRtnUh7/YRlXaUiHcXRKbhA4EGu95CZmpP7qVr5KwwMT1hepLZ2ME
         7YWv2abBHSrRATpwOg7xEN/NOU6Hczse+nz1DWPFDgsaNV1uPD0cmCk1qeBZy9D8Xv
         jR0fJKw8pPXkA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4efec123b28so910491e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 01:15:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxTe67lqzDQOxAzz2ksfMtZibReM4eanROFJxp+/CVdf2fPaIwl
        KTXCtj37lX1ms6++oPaRq1QNO1dTOWs1ykit/do=
X-Google-Smtp-Source: ACHHUZ5n3WuqKDkEg7i1bMoDv7sJfzcV5KdG4bE0Do5KScT1dAE9PWJ6gwT+wfNZhlH2m97am7T3jm8BBpJoCcN+2YU=
X-Received: by 2002:a2e:870d:0:b0:2ab:143e:e19c with SMTP id
 m13-20020a2e870d000000b002ab143ee19cmr2067172lji.50.1682756098102; Sat, 29
 Apr 2023 01:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230428050442.180913-1-maskray@google.com> <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
 <20230428185814.mmnb3jafp7fnwdrh@google.com> <CAMj1kXFgv6GHm5PvR9Qq9-VwL+5NXwpChkB59c-0-tEJPNYdVQ@mail.gmail.com>
 <20230428210611.pxgmj2tja3y2c3lr@google.com> <CAMj1kXGKPyFOtPE30eanbD+5StvXGgX7Bi9iziTK9iqFg9=9wg@mail.gmail.com>
 <20230428222912.yanrwnl5hwykv6ve@google.com> <CAMj1kXGw9zz-PraPRx12uWkorhV0t8vRwG=qH7-3C75eBH2nAg@mail.gmail.com>
 <20230429075104.6pncukm4a5bxcumx@google.com>
In-Reply-To: <20230429075104.6pncukm4a5bxcumx@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 29 Apr 2023 09:14:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFZabChhNTA77EZbfCkLF7-oGeR-N-d-sQhP7tXjxRSRg@mail.gmail.com>
Message-ID: <CAMj1kXFZabChhNTA77EZbfCkLF7-oGeR-N-d-sQhP7tXjxRSRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
To:     Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 at 08:51, Fangrui Song <maskray@google.com> wrote:
>
> On 2023-04-29, Ard Biesheuvel wrote:
> >On Fri, 28 Apr 2023 at 23:29, Fangrui Song <maskray@google.com> wrote:
> >>
> >> On 2023-04-28, Ard Biesheuvel wrote:
> >> >On Fri, 28 Apr 2023 at 22:06, Fangrui Song <maskray@google.com> wrote:
> >> >>
> >> >> On 2023-04-28, Ard Biesheuvel wrote:
> >> >> >On Fri, 28 Apr 2023 at 19:58, Fangrui Song <maskray@google.com> wrote:
> >> >> >>
> >> >> >> On 2023-04-28, Ard Biesheuvel wrote:
> >> >> >> >Hello Fangrui,
> >> >> >>
> >> >> >> Hello Ard, thank you for the rapid response.
> >> >> >>
> >> >> >> >On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
> >> >> >> >>
> >> >> >> >> Currently, the .got section is placed within the output section .text.
> >> >> >> >> However, when .got is non-empty, the SHF_WRITE flag is set when linked
> >> >> >> >> by lld. GNU ld recognizes .text as a special section and ignores the
> >> >> >> >> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
> >> >> >> >>
> >> >> >> >> Conventionally, the .got section is placed just before .got.plt (which
> >> >> >> >> should be empty and omitted in the kernel). Therefore, we move the .got
> >> >> >> >> section to a conventional location (between .text and .data) and remove
> >> >> >> >> the unneeded `. = ALIGN(16)`.
> >> >> >> >>
> >> >> >> >> Signed-off-by: Fangrui Song <maskray@google.com>
> >> >> >> >> ---
> >> >> >> >>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
> >> >> >> >>  1 file changed, 10 insertions(+), 10 deletions(-)
> >> >> >> >>
> >> >> >> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> >> >> >> >> index b9202c2ee18e..2bcb3b30db41 100644
> >> >> >> >> --- a/arch/arm64/kernel/vmlinux.lds.S
> >> >> >> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
> >> >> >> >> @@ -181,18 +181,8 @@ SECTIONS
> >> >> >> >>                         KPROBES_TEXT
> >> >> >> >>                         HYPERVISOR_TEXT
> >> >> >> >>                         *(.gnu.warning)
> >> >> >> >> -               . = ALIGN(16);
> >> >> >> >> -               *(.got)                 /* Global offset table          */
> >> >> >> >>         }
> >> >> >> >>
> >> >> >> >> -       /*
> >> >> >> >> -        * Make sure that the .got.plt is either completely empty or it
> >> >> >> >> -        * contains only the lazy dispatch entries.
> >> >> >> >> -        */
> >> >> >> >> -       .got.plt : { *(.got.plt) }
> >> >> >> >> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> >> >> >> >> -              "Unexpected GOT/PLT entries detected!")
> >> >> >> >> -
> >> >> >> >>         . = ALIGN(SEGMENT_ALIGN);
> >> >> >> >>         _etext = .;                     /* End of text section */
> >> >> >> >>
> >> >> >> >> @@ -247,6 +237,16 @@ SECTIONS
> >> >> >> >>
> >> >> >> >>         . = ALIGN(SEGMENT_ALIGN);
> >> >> >> >>         __inittext_end = .;
> >> >> >> >> +
> >> >> >> >> +       .got : { *(.got) }
> >> >> >> >
> >> >> >> >This is the .init region, which gets freed and unmapped after boot. If
> >> >> >> >the GOT is non-empty, it needs to remain mapped, so we cannot place it
> >> >> >> >here.
> >> >> >>
> >> >> >> Thanks.  I did not know the constraint.
> >> >> >>
> >> >> >> >We have the same issue with the .rodata section, which incorporates
> >> >> >> >variables marked as __ro_after_init, which are not const qualified. So
> >> >> >> >given that .rodata is already emitted as WA, and we cannot do anything
> >> >> >> >about that, let's move the GOT in there.
> >> >> >>
> >> >> >> Yes, writable .data..ro_after_init and __jump_table sections in
> >> >> >> include/asm-generic/vmlinux.lds.h (#define RO_DATA(align)) makes the
> >> >> >> output section .rodata writable.  Perhaps this is very difficult to fix,
> >> >> >> and we will have writable .rodata for a long time.
> >> >> >>
> >> >> >> What do you think of moving .got/.got.plt immediately before .data?
> >> >> >> I want to place .got/.got.plt before the guaranteed-writable sections,
> >> >> >> not some sections which are "unfortunately" writable (.rodata, __modver,
> >> >> >> .hyp.rodata, .rodata.text, etc).
> >> >> >>
> >> >> >> For userspace programs, either linked with GNU ld or lld, .got/.got.plt
> >> >> >> are usually immediately before .data .
> >> >> >>
> >> >> >
> >> >> >I don't think that would be the right choice.
> >> >> >
> >> >> >We have five pseudo-segments in the kernel
> >> >> >
> >> >> >text (RX)
> >> >> >rodata (R)
> >> >> >inittext (RX)
> >> >> >initdata (RW)
> >> >> >data (RW)
> >> >> >
> >> >> >where the init ones disappear entirely when the boot completes.
> >> >> >
> >> >> >The GOT should not be modifiable, so it should not be in .data. So the
> >> >> >only appropriate 'segment' for the GOT is rodata
> >> >> >
> >> >> >Note that we don't use PIC codegen for the kernel, so all const
> >> >> >qualified data structures containing statically initialized global
> >> >> >pointer variables are emitted into .rodata as well, and relocated at
> >> >> >boot. So having the GOT in rodata too makes sense imho.
> >> >>
> >> >> arm64's vmlinux is linked with -shared -Bsymbolic and .got has many
> >> >> entries that need to be relocated.
> >> >
> >> >Actually, it is mostly empty, given that we don't use -fpic/-fpie codegen.
> >>
> >> Yes, .got is usually small, e.g. 0x68 in my `make ARCH=arm64 LLVM=1 -j60 defconfig vmlinux` build.
> >>
> >> >>  .got is initially writable, and
> >> >> becomes read-only after relocation resolving.
> >> >
> >> >The same applies to .rodata, given that we don't use -fpic/fpie
> >> >codegen. And note that I am not referring to .data..ro_after_init here
> >> >- I mean .rodata itself, which carries all const qualified global data
> >> >structures with statically initialized pointer fields. These are
> >> >conceptually the same as GOT entries - the only difference is that
> >> >they are not created by the linker and are referenced explicitly from
> >> >the C code.
> >>
> >> I agree that they are very similar, but there is a distinction, that's
> >> why we have both .rodata and .data.rel.ro (relro), and the latter is for sections
> >> that need relocations.
> >>
> >
> >Yes, but we don't use .data.rel.ro in the kernel because we don't
> >compile with -fpic/-fpie
> >> >> I think this property is significant enough to make it outside of any rodata
> >> >> segment.
> >> >>
> >> >
> >> >I disagree.
> >> >
> >> >> (In the userspace .got is typically placed in PT_GNU_RELRO by using -z relro.)
> >> >>
> >> >> If we remove inittext and initdata pseudo-segments which disappear after
> >> >> the boot, we have
> >> >>
> >> >> text (RX)
> >> >> rodata (R)
> >> >> /// where is .got (RELRO)
> >> >> data (RW)
> >> >>
> >> >> If we consider .got distinct from rodata, I think placing .got immediately
> >> >> after rodata or immediately before data is both fine?
> >> >>
> >> >
> >> >We can place it anywhere in the rodata pseudo-segment. What user space
> >> >does is not quite relevant here - what is relevant is that we already
> >> >have a pseudo-segment with the right properties. Adding a new segment
> >> >just for the GOT which is almost empty and is mapped with the same
> >> >attributes as rodata seems unnecessary to me.
> >> >
> >> >Do you have any practical concerns? Or is it just tidiness?
> >>
> >> Unfortunately, vmlinux has many PT_LOAD program headers. I am trying to
> >> find the best position for .got that makes the most sense. When making
> >> this decision, I aim to create a layout that looks more normal and is
> >> closer to user-space programs. Additionally, I want to reduce the number
> >> of PT_LOAD program headers.
> >>
> >
> >Why? The PT_LOAD headers are never consumed by anything. On arm64, we
> >never consume the ELF - it is converted to a flat binary during the
> >build.
>
> See below.
>
> >> You are arguing that .got should be part of rodata. However, I disagree
> >> with this perspective from both practical and linker layout viewpoints.
> >>
> >> If we place .got below RO_DATA(PAGE_SIZE), it will immediately follow
> >> .note or .BTF (see NOTES in include/asm-generic/vmlinux.lds.h).
> >> There isn't an option to drop SHF_WRITE from .got, and
> >> we will need a separate PT_LOAD program header for .got.
> >>
> >> Alternatively, if we place .got below .hyp.rodata, we can eliminate one
> >> PT_LOAD because the transition from .hyp.rodata to .got does not require
> >> a separate PT_LOAD. However, having a half-writable .got before
> >> .rodata.text feels strange to me.
> >>
> >>
> >> I feel that the region between .text/.rodata and .data is too messy.
> >> Placing .got immediately before .data makes the layout look more normal
> >> and closer to user space without causing any pessimization.
> >>
> >
> >But we are not in user space. There is no ELF loader at runtime that
> >consumes any of this, The entire layout is self-described by the
> >linker script using symbols that the code links to directly.
> >
> >So frankly, if we could just avoid PT_LOAD headers entirely, or add a
> >PHDRS {} section that defines a single region, I'd be ok with that.
> >But tweaking the layout to reduce the number of PT_LOAD headers seems
> >unnecessary to me.
> >
> >And moving the GOT into a writable area just to make the ELF metadata
> >look tidier is out of the question - that could turn into a security
> >bug.
> >> ---
> >>
> >> My linker layout viewpoint is that ideally a program's program headers
> >> should looke like
> >>
> >> https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#layout-related
> >>
> >> R PT_LOAD
> >> RX PT_LOAD
> >> RW PT_LOAD (overlaps with PT_GNU_RELRO) .got, .data.rel.ro (if present)
> >> RW PT_LOAD
> >>
> >> For historical reason, I can expect swapped R and RX.
> >> Sections such as .got and .data.rel.ro are different from both .rodata
> >> and .data.
> >>
> >
> >The kernel is remapped a number of times during the boot - in the
> >initial mapping everything is read-only-exec except bss, and the
> >physical address is used as the virtual address. When it is remapped
> >again using the actual virtual addresses, we have two pseudo-segments,
> >where text/rodata/inittext are RX and initdata and data are RW. Then,
> >another mapping is created where text and inittext are RX, and rodata,
> >initdata and data are RW, until finally inittext and initdata are
> >unmapped and freed, and rodata is remapped read-only.
> >
> >In the context of the above, why does it matter what the PT_LOAD headers say?
>
> Thank you for the explanation.  I may have missed something as I don't
> know the boot process at all...  If we place .got immediately before the
> _data symbol and the .data section, how is .got considered to be in a
> writable area?
>
> This part of your reply may be relevant:
>
> > where text/rodata/inittext are RX and initdata and data are RW.
>
> Do you mean that the regions [__initdata_begin,__initdata_end) and [_data, _end)
> are RW?
>

Yes.

> If so, placing .got between __initdata_end and _data should not make
> .got writable.  However, .got now appears to belong to an additional
> pseudo-segment, which conceptually is bad.
>

Indeed. We don't parse PT_LOAD program headers, so we would have to
modify the code to add an additional segment.

Please refer to map_kernel() in arch/arm64/mm/mmu.c for details.

> Therefore, moving .got between .rodata.text and `idmap_pg_dir = .;` will
> be a better choice. This makes .got part of a read-only pseudo-segment.
>

Exactly.

> ---
>
> If my understanding is correct, at one point .got is indeed writable.
> However, the kernel has performed R_AARCH64_RELATIVE resolving very
> early, and can then assume that .got is read-only.
> This is similar to user-space PT_GNU_RELRO, but the period is so
> transient that we can essentially consider .got read-only.

Agreed. It would be possible to have finer grained rules for this,
e.g., compile with -fpic and decide that

.text and .rodata are always read-only
.got and .data.rel.ro can be remapped read-only after relocation processing
.data..ro_after_init can be remapped read-only once the boot completes.

At this point, I don't see a lot of benefit from doing that. However,
moving the GOT out of text is a good idea in any case, not only
because it helps syzkaller but simply because we should avoid mapping
things that are not executable code with executable permissions.
