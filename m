Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F336F2015
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbjD1VZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjD1VZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C63C1E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B415645A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 21:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A43C433D2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682717116;
        bh=lhg1FXfdsuYGWmRRCuRygvHNTbiRCw5gIT5z7HSluKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a59R+ZJELTj+5JbEwYUfgi/sv/EQqlCTpO6S3xyl39AJSlXevDeVpO6ATwmOceygO
         Wk4m/CNdtzaM7WBS+HiPpctdw/HAIU82PPLimQKd5lZGOgtGqIc1dMsEBzPy6mRmMF
         REnhfLi/o8eg6qJYZLMGwhHlXil9qt5hZ4zMnKjovoBlQXGSBcaYQduU8lqsDWGdwD
         e7FBbOUVZKkhV6xJGk2BC1Q++NiO60I+t+rbg4Z2UHolB9Nk2/a7c1IMGJ2qmRNjFo
         qmMDD6fzxU1tZ6ZDLZv51oLO7Y2OVF/LITD/Zek5oA2cqZbtQbmXZygQNMe4EZ8upk
         IVfB+LwF3FbDg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4ec81773cf7so411300e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:25:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDy7epFiVNrS9SgAMPvT7nrJYSezmstdjl3AF7+MV6jKLxvhK5av
        cJwVTZuG9g7xCkbdU1Ky4/uPsEl4566PM6onG6E=
X-Google-Smtp-Source: ACHHUZ75v73aOsgcr/ez+lwVob4xwcUFMR2l3gj6i0XJVhuboz+mixcqJbGiUJ4NhJbh1LS1SCnzYprD0aGb2UGT5PI=
X-Received: by 2002:ac2:5e8f:0:b0:4ec:a9c5:f3ae with SMTP id
 b15-20020ac25e8f000000b004eca9c5f3aemr1870931lfq.11.1682717114699; Fri, 28
 Apr 2023 14:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230428050442.180913-1-maskray@google.com> <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
 <20230428185814.mmnb3jafp7fnwdrh@google.com> <CAMj1kXFgv6GHm5PvR9Qq9-VwL+5NXwpChkB59c-0-tEJPNYdVQ@mail.gmail.com>
 <20230428210611.pxgmj2tja3y2c3lr@google.com>
In-Reply-To: <20230428210611.pxgmj2tja3y2c3lr@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 22:25:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGKPyFOtPE30eanbD+5StvXGgX7Bi9iziTK9iqFg9=9wg@mail.gmail.com>
Message-ID: <CAMj1kXGKPyFOtPE30eanbD+5StvXGgX7Bi9iziTK9iqFg9=9wg@mail.gmail.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
To:     Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 at 22:06, Fangrui Song <maskray@google.com> wrote:
>
> On 2023-04-28, Ard Biesheuvel wrote:
> >On Fri, 28 Apr 2023 at 19:58, Fangrui Song <maskray@google.com> wrote:
> >>
> >> On 2023-04-28, Ard Biesheuvel wrote:
> >> >Hello Fangrui,
> >>
> >> Hello Ard, thank you for the rapid response.
> >>
> >> >On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
> >> >>
> >> >> Currently, the .got section is placed within the output section .text.
> >> >> However, when .got is non-empty, the SHF_WRITE flag is set when linked
> >> >> by lld. GNU ld recognizes .text as a special section and ignores the
> >> >> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
> >> >>
> >> >> Conventionally, the .got section is placed just before .got.plt (which
> >> >> should be empty and omitted in the kernel). Therefore, we move the .got
> >> >> section to a conventional location (between .text and .data) and remove
> >> >> the unneeded `. = ALIGN(16)`.
> >> >>
> >> >> Signed-off-by: Fangrui Song <maskray@google.com>
> >> >> ---
> >> >>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
> >> >>  1 file changed, 10 insertions(+), 10 deletions(-)
> >> >>
> >> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> >> >> index b9202c2ee18e..2bcb3b30db41 100644
> >> >> --- a/arch/arm64/kernel/vmlinux.lds.S
> >> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
> >> >> @@ -181,18 +181,8 @@ SECTIONS
> >> >>                         KPROBES_TEXT
> >> >>                         HYPERVISOR_TEXT
> >> >>                         *(.gnu.warning)
> >> >> -               . = ALIGN(16);
> >> >> -               *(.got)                 /* Global offset table          */
> >> >>         }
> >> >>
> >> >> -       /*
> >> >> -        * Make sure that the .got.plt is either completely empty or it
> >> >> -        * contains only the lazy dispatch entries.
> >> >> -        */
> >> >> -       .got.plt : { *(.got.plt) }
> >> >> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> >> >> -              "Unexpected GOT/PLT entries detected!")
> >> >> -
> >> >>         . = ALIGN(SEGMENT_ALIGN);
> >> >>         _etext = .;                     /* End of text section */
> >> >>
> >> >> @@ -247,6 +237,16 @@ SECTIONS
> >> >>
> >> >>         . = ALIGN(SEGMENT_ALIGN);
> >> >>         __inittext_end = .;
> >> >> +
> >> >> +       .got : { *(.got) }
> >> >
> >> >This is the .init region, which gets freed and unmapped after boot. If
> >> >the GOT is non-empty, it needs to remain mapped, so we cannot place it
> >> >here.
> >>
> >> Thanks.  I did not know the constraint.
> >>
> >> >We have the same issue with the .rodata section, which incorporates
> >> >variables marked as __ro_after_init, which are not const qualified. So
> >> >given that .rodata is already emitted as WA, and we cannot do anything
> >> >about that, let's move the GOT in there.
> >>
> >> Yes, writable .data..ro_after_init and __jump_table sections in
> >> include/asm-generic/vmlinux.lds.h (#define RO_DATA(align)) makes the
> >> output section .rodata writable.  Perhaps this is very difficult to fix,
> >> and we will have writable .rodata for a long time.
> >>
> >> What do you think of moving .got/.got.plt immediately before .data?
> >> I want to place .got/.got.plt before the guaranteed-writable sections,
> >> not some sections which are "unfortunately" writable (.rodata, __modver,
> >> .hyp.rodata, .rodata.text, etc).
> >>
> >> For userspace programs, either linked with GNU ld or lld, .got/.got.plt
> >> are usually immediately before .data .
> >>
> >
> >I don't think that would be the right choice.
> >
> >We have five pseudo-segments in the kernel
> >
> >text (RX)
> >rodata (R)
> >inittext (RX)
> >initdata (RW)
> >data (RW)
> >
> >where the init ones disappear entirely when the boot completes.
> >
> >The GOT should not be modifiable, so it should not be in .data. So the
> >only appropriate 'segment' for the GOT is rodata
> >
> >Note that we don't use PIC codegen for the kernel, so all const
> >qualified data structures containing statically initialized global
> >pointer variables are emitted into .rodata as well, and relocated at
> >boot. So having the GOT in rodata too makes sense imho.
>
> arm64's vmlinux is linked with -shared -Bsymbolic and .got has many
> entries that need to be relocated.

Actually, it is mostly empty, given that we don't use -fpic/-fpie codegen.

>  .got is initially writable, and
> becomes read-only after relocation resolving.

The same applies to .rodata, given that we don't use -fpic/fpie
codegen. And note that I am not referring to .data..ro_after_init here
- I mean .rodata itself, which carries all const qualified global data
structures with statically initialized pointer fields. These are
conceptually the same as GOT entries - the only difference is that
they are not created by the linker and are referenced explicitly from
the C code.

> I think this property is significant enough to make it outside of any rodata
> segment.
>

I disagree.

> (In the userspace .got is typically placed in PT_GNU_RELRO by using -z relro.)
>
> If we remove inittext and initdata pseudo-segments which disappear after
> the boot, we have
>
> text (RX)
> rodata (R)
> /// where is .got (RELRO)
> data (RW)
>
> If we consider .got distinct from rodata, I think placing .got immediately
> after rodata or immediately before data is both fine?
>

We can place it anywhere in the rodata pseudo-segment. What user space
does is not quite relevant here - what is relevant is that we already
have a pseudo-segment with the right properties. Adding a new segment
just for the GOT which is almost empty and is mapped with the same
attributes as rodata seems unnecessary to me.

Do you have any practical concerns? Or is it just tidiness?


>
> >
> >
> >
> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> >> index b9202c2ee18e..48bd7c25b6ab 100644
> >> --- a/arch/arm64/kernel/vmlinux.lds.S
> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
> >> @@ -181,18 +181,8 @@ SECTIONS
> >>                         KPROBES_TEXT
> >>                         HYPERVISOR_TEXT
> >>                         *(.gnu.warning)
> >> -               . = ALIGN(16);
> >> -               *(.got)                 /* Global offset table          */
> >>         }
> >>
> >> -       /*
> >> -        * Make sure that the .got.plt is either completely empty or it
> >> -        * contains only the lazy dispatch entries.
> >> -        */
> >> -       .got.plt : { *(.got.plt) }
> >> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> >> -              "Unexpected GOT/PLT entries detected!")
> >> -
> >>         . = ALIGN(SEGMENT_ALIGN);
> >>         _etext = .;                     /* End of text section */
> >>
> >> @@ -286,6 +276,15 @@ SECTIONS
> >>         __initdata_end = .;
> >>         __init_end = .;
> >>
> >> +       .got : { *(.got) }
> >> +       /*
> >> +        * Make sure that the .got.plt is either completely empty or it
> >> +        * contains only the lazy dispatch entries.
> >> +        */
> >> +       .got.plt : { *(.got.plt) }
> >> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> >> +              "Unexpected GOT/PLT entries detected!")
> >> +
> >>         _data = .;
> >>         _sdata = .;
> >>         RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
> >> --
> >> 2.40.1.495.gc816e09b53d-goog
> >>
> >>
> >> >> +       /*
> >> >> +        * Make sure that the .got.plt is either completely empty or it
> >> >> +        * contains only the lazy dispatch entries.
> >> >> +        */
> >> >> +       .got.plt : { *(.got.plt) }
> >> >> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> >> >> +              "Unexpected GOT/PLT entries detected!")
> >> >> +
> >> >>         __initdata_begin = .;
> >> >>
> >> >>         init_idmap_pg_dir = .;
> >> >> --
> >> >> 2.40.1.495.gc816e09b53d-goog
> >> >>
