Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767516F20CC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbjD1W3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjD1W3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:29:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A93584
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:29:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a7ff4a454eso583905ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682720955; x=1685312955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7teNL06QVCbJWHJqrjonK+EdtdnBopkd8T/rWWHRcWY=;
        b=nvAMLCGDHTh/ikVsuUpZ3W3oCqcSBDh5CgZ2dauQK3ChNz7UMLYaAyMUyvdqU3oA20
         68oJf3ci+rtN0hbw+NG/FxLjL/Yc2IpD+G7WAkCx5yBpboKrccClxFGQqHsp0ndPMs3C
         S62DdgEjFTUT06PUQpcr9SEfd+5Zh9cuUvoumD/KOuLX6YRwvo5BL5vyrjqtN978FBm2
         LuEluqmfSc5AEjiySILkMguLgOorLynJXILYAzC/pD49WA8B329V/MxohXfB2bW1wiPg
         fZNyTayyHgdXxEwBTJyvuqbnQFPaSITMw71giL6pnVPptjPfh925N/0n3lr2UrLyJyoA
         ffgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720955; x=1685312955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7teNL06QVCbJWHJqrjonK+EdtdnBopkd8T/rWWHRcWY=;
        b=OHsnmm1edQOxIs2WF+E1QSW6Q8D8232JEzwvFu1OJ7mhWZE2pDn7veCR/7/65BhMoF
         fGn9k1aCErmuVXMCMMr+y8ozaM0Ytw5cXBL+ko2za7OqQ/vi5MIa1saWpS2NifcCCy2e
         lmQiFDtMPYF8vQ3MoQpPx+oABfqUPLFNNq8mNRvw9UIH8xC/GTxquxLJPyS0UPgr/ki7
         J7QRdpHI0SeHYX8UKr4HrkwGptMiFFfzDmxLy7GwkEixCmzGxVqWfdzufVmUPI9Q4Dhz
         NPIliQxRZccgHfpMTj7sXDRZiU8+UfXWl6AIHm+1j8D27Sa8nNlViz6GQVNweuv0NIK1
         H+gQ==
X-Gm-Message-State: AC+VfDxp0L4QbSjSGNMoHGq433TSyV4hGOZ15eqf66qqPtfPfTR4kR2E
        jAjZOVlOVLfM83hcL+10i12L/Q==
X-Google-Smtp-Source: ACHHUZ5/X4/LaPZScfAa+mjv6GrPxTid+9Yz6RInQIGya5sI8+aIVvuScrFYTOenB9/ezOchFBYfvg==
X-Received: by 2002:a17:902:da90:b0:1a2:79ff:6a86 with SMTP id j16-20020a170902da9000b001a279ff6a86mr15056plx.17.1682720955105;
        Fri, 28 Apr 2023 15:29:15 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id m8-20020a654388000000b0051303d3e3c5sm13437734pgp.42.2023.04.28.15.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:29:14 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:29:12 +0000
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
Message-ID: <20230428222912.yanrwnl5hwykv6ve@google.com>
References: <20230428050442.180913-1-maskray@google.com>
 <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
 <20230428185814.mmnb3jafp7fnwdrh@google.com>
 <CAMj1kXFgv6GHm5PvR9Qq9-VwL+5NXwpChkB59c-0-tEJPNYdVQ@mail.gmail.com>
 <20230428210611.pxgmj2tja3y2c3lr@google.com>
 <CAMj1kXGKPyFOtPE30eanbD+5StvXGgX7Bi9iziTK9iqFg9=9wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXGKPyFOtPE30eanbD+5StvXGgX7Bi9iziTK9iqFg9=9wg@mail.gmail.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28, Ard Biesheuvel wrote:
>On Fri, 28 Apr 2023 at 22:06, Fangrui Song <maskray@google.com> wrote:
>>
>> On 2023-04-28, Ard Biesheuvel wrote:
>> >On Fri, 28 Apr 2023 at 19:58, Fangrui Song <maskray@google.com> wrote:
>> >>
>> >> On 2023-04-28, Ard Biesheuvel wrote:
>> >> >Hello Fangrui,
>> >>
>> >> Hello Ard, thank you for the rapid response.
>> >>
>> >> >On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
>> >> >>
>> >> >> Currently, the .got section is placed within the output section .text.
>> >> >> However, when .got is non-empty, the SHF_WRITE flag is set when linked
>> >> >> by lld. GNU ld recognizes .text as a special section and ignores the
>> >> >> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
>> >> >>
>> >> >> Conventionally, the .got section is placed just before .got.plt (which
>> >> >> should be empty and omitted in the kernel). Therefore, we move the .got
>> >> >> section to a conventional location (between .text and .data) and remove
>> >> >> the unneeded `. = ALIGN(16)`.
>> >> >>
>> >> >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> >> ---
>> >> >>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
>> >> >>  1 file changed, 10 insertions(+), 10 deletions(-)
>> >> >>
>> >> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >> >> index b9202c2ee18e..2bcb3b30db41 100644
>> >> >> --- a/arch/arm64/kernel/vmlinux.lds.S
>> >> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> >> >> @@ -181,18 +181,8 @@ SECTIONS
>> >> >>                         KPROBES_TEXT
>> >> >>                         HYPERVISOR_TEXT
>> >> >>                         *(.gnu.warning)
>> >> >> -               . = ALIGN(16);
>> >> >> -               *(.got)                 /* Global offset table          */
>> >> >>         }
>> >> >>
>> >> >> -       /*
>> >> >> -        * Make sure that the .got.plt is either completely empty or it
>> >> >> -        * contains only the lazy dispatch entries.
>> >> >> -        */
>> >> >> -       .got.plt : { *(.got.plt) }
>> >> >> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> >> >> -              "Unexpected GOT/PLT entries detected!")
>> >> >> -
>> >> >>         . = ALIGN(SEGMENT_ALIGN);
>> >> >>         _etext = .;                     /* End of text section */
>> >> >>
>> >> >> @@ -247,6 +237,16 @@ SECTIONS
>> >> >>
>> >> >>         . = ALIGN(SEGMENT_ALIGN);
>> >> >>         __inittext_end = .;
>> >> >> +
>> >> >> +       .got : { *(.got) }
>> >> >
>> >> >This is the .init region, which gets freed and unmapped after boot. If
>> >> >the GOT is non-empty, it needs to remain mapped, so we cannot place it
>> >> >here.
>> >>
>> >> Thanks.  I did not know the constraint.
>> >>
>> >> >We have the same issue with the .rodata section, which incorporates
>> >> >variables marked as __ro_after_init, which are not const qualified. So
>> >> >given that .rodata is already emitted as WA, and we cannot do anything
>> >> >about that, let's move the GOT in there.
>> >>
>> >> Yes, writable .data..ro_after_init and __jump_table sections in
>> >> include/asm-generic/vmlinux.lds.h (#define RO_DATA(align)) makes the
>> >> output section .rodata writable.  Perhaps this is very difficult to fix,
>> >> and we will have writable .rodata for a long time.
>> >>
>> >> What do you think of moving .got/.got.plt immediately before .data?
>> >> I want to place .got/.got.plt before the guaranteed-writable sections,
>> >> not some sections which are "unfortunately" writable (.rodata, __modver,
>> >> .hyp.rodata, .rodata.text, etc).
>> >>
>> >> For userspace programs, either linked with GNU ld or lld, .got/.got.plt
>> >> are usually immediately before .data .
>> >>
>> >
>> >I don't think that would be the right choice.
>> >
>> >We have five pseudo-segments in the kernel
>> >
>> >text (RX)
>> >rodata (R)
>> >inittext (RX)
>> >initdata (RW)
>> >data (RW)
>> >
>> >where the init ones disappear entirely when the boot completes.
>> >
>> >The GOT should not be modifiable, so it should not be in .data. So the
>> >only appropriate 'segment' for the GOT is rodata
>> >
>> >Note that we don't use PIC codegen for the kernel, so all const
>> >qualified data structures containing statically initialized global
>> >pointer variables are emitted into .rodata as well, and relocated at
>> >boot. So having the GOT in rodata too makes sense imho.
>>
>> arm64's vmlinux is linked with -shared -Bsymbolic and .got has many
>> entries that need to be relocated.
>
>Actually, it is mostly empty, given that we don't use -fpic/-fpie codegen.

Yes, .got is usually small, e.g. 0x68 in my `make ARCH=arm64 LLVM=1 -j60 defconfig vmlinux` build.

>>  .got is initially writable, and
>> becomes read-only after relocation resolving.
>
>The same applies to .rodata, given that we don't use -fpic/fpie
>codegen. And note that I am not referring to .data..ro_after_init here
>- I mean .rodata itself, which carries all const qualified global data
>structures with statically initialized pointer fields. These are
>conceptually the same as GOT entries - the only difference is that
>they are not created by the linker and are referenced explicitly from
>the C code.

I agree that they are very similar, but there is a distinction, that's
why we have both .rodata and .data.rel.ro (relro), and the latter is for sections
that need relocations.

>> I think this property is significant enough to make it outside of any rodata
>> segment.
>>
>
>I disagree.
>
>> (In the userspace .got is typically placed in PT_GNU_RELRO by using -z relro.)
>>
>> If we remove inittext and initdata pseudo-segments which disappear after
>> the boot, we have
>>
>> text (RX)
>> rodata (R)
>> /// where is .got (RELRO)
>> data (RW)
>>
>> If we consider .got distinct from rodata, I think placing .got immediately
>> after rodata or immediately before data is both fine?
>>
>
>We can place it anywhere in the rodata pseudo-segment. What user space
>does is not quite relevant here - what is relevant is that we already
>have a pseudo-segment with the right properties. Adding a new segment
>just for the GOT which is almost empty and is mapped with the same
>attributes as rodata seems unnecessary to me.
>
>Do you have any practical concerns? Or is it just tidiness?

Unfortunately, vmlinux has many PT_LOAD program headers. I am trying to
find the best position for .got that makes the most sense. When making
this decision, I aim to create a layout that looks more normal and is
closer to user-space programs. Additionally, I want to reduce the number
of PT_LOAD program headers.

You are arguing that .got should be part of rodata. However, I disagree
with this perspective from both practical and linker layout viewpoints.

If we place .got below RO_DATA(PAGE_SIZE), it will immediately follow
.note or .BTF (see NOTES in include/asm-generic/vmlinux.lds.h).
There isn't an option to drop SHF_WRITE from .got, and
we will need a separate PT_LOAD program header for .got.

Alternatively, if we place .got below .hyp.rodata, we can eliminate one
PT_LOAD because the transition from .hyp.rodata to .got does not require
a separate PT_LOAD. However, having a half-writable .got before
.rodata.text feels strange to me.


I feel that the region between .text/.rodata and .data is too messy.
Placing .got immediately before .data makes the layout look more normal
and closer to user space without causing any pessimization.

---

My linker layout viewpoint is that ideally a program's program headers
should looke like

https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#layout-related

R PT_LOAD
RX PT_LOAD
RW PT_LOAD (overlaps with PT_GNU_RELRO) .got, .data.rel.ro (if present)
RW PT_LOAD

For historical reason, I can expect swapped R and RX.
Sections such as .got and .data.rel.ro are different from both .rodata
and .data.

>
>>
>> >
>> >
>> >
>> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >> index b9202c2ee18e..48bd7c25b6ab 100644
>> >> --- a/arch/arm64/kernel/vmlinux.lds.S
>> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> >> @@ -181,18 +181,8 @@ SECTIONS
>> >>                         KPROBES_TEXT
>> >>                         HYPERVISOR_TEXT
>> >>                         *(.gnu.warning)
>> >> -               . = ALIGN(16);
>> >> -               *(.got)                 /* Global offset table          */
>> >>         }
>> >>
>> >> -       /*
>> >> -        * Make sure that the .got.plt is either completely empty or it
>> >> -        * contains only the lazy dispatch entries.
>> >> -        */
>> >> -       .got.plt : { *(.got.plt) }
>> >> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> >> -              "Unexpected GOT/PLT entries detected!")
>> >> -
>> >>         . = ALIGN(SEGMENT_ALIGN);
>> >>         _etext = .;                     /* End of text section */
>> >>
>> >> @@ -286,6 +276,15 @@ SECTIONS
>> >>         __initdata_end = .;
>> >>         __init_end = .;
>> >>
>> >> +       .got : { *(.got) }
>> >> +       /*
>> >> +        * Make sure that the .got.plt is either completely empty or it
>> >> +        * contains only the lazy dispatch entries.
>> >> +        */
>> >> +       .got.plt : { *(.got.plt) }
>> >> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> >> +              "Unexpected GOT/PLT entries detected!")
>> >> +
>> >>         _data = .;
>> >>         _sdata = .;
>> >>         RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
>> >> --
>> >> 2.40.1.495.gc816e09b53d-goog
>> >>
>> >>
>> >> >> +       /*
>> >> >> +        * Make sure that the .got.plt is either completely empty or it
>> >> >> +        * contains only the lazy dispatch entries.
>> >> >> +        */
>> >> >> +       .got.plt : { *(.got.plt) }
>> >> >> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> >> >> +              "Unexpected GOT/PLT entries detected!")
>> >> >> +
>> >> >>         __initdata_begin = .;
>> >> >>
>> >> >>         init_idmap_pg_dir = .;
>> >> >> --
>> >> >> 2.40.1.495.gc816e09b53d-goog
>> >> >>
