Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC576F23A9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjD2HvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjD2HvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:51:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658452105
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 00:51:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a7ff4a454eso604645ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682754668; x=1685346668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57k/jRaUMj2v/CyMJRUtve/B9PRxVvtUhlbQlk0U0Mg=;
        b=xolJYgpHFEqnujoYOOlRo8ls2nPpGMzMMcT28i2rRqAXUQlNsf86a/8gXVVa+diQFk
         7KvofRPVibEUBN0KDlOepMWfKJHAIt/cUAee4VmkMss5XKm7UNwcocGnaeT4+OHQJw4m
         /9zof7+Jn/dhEAnFy5Q1NE0e9Q5raidRGKmQ+JUsDZgENG7DapUT/3VdsdknbyuqC85k
         1DFGJjbRdyjTVSctOOUg19PbE83zkdmLYftfcflU6uNuT59LrGtRoxzaI25QLX2UBq8l
         dPCKw5Wc9By+Rk+8AQ/Hr3nBHqpKweQp6XSR/4ZX3QK3SHwZk+b5ci37vCd12y7QI9Zg
         Qx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682754668; x=1685346668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57k/jRaUMj2v/CyMJRUtve/B9PRxVvtUhlbQlk0U0Mg=;
        b=S5cETTez2pkKYewddnxfRzqJ/X824HoU6ef0iwUktw30amNQmnM2+K6y0lBJGL2/Bi
         rChODVdVDiI6XVcIWqkBCHb2j7nH7e1d9h8aHJLynp7UV1u+fkQw6pxRZcBzik8mMeQZ
         ArGHLotvIyvETDd67Lo3obYmLcAFLYWDuSu2bezoCtO7bOmEFlWZtmqBYPQFoZ25vj+B
         coqngBcM0oIx4y5mJaSCnJQyTEzRAPFuRYa1VE7Tw64wDlainQwUEnhmwQvEOBrokEc4
         3pF9ZUkLXcCeQMusoblj6L8dGvyEZCjUj9UA3Vke7Fx6V1tXPHQ0I02QjUjUhgn/tHj2
         SEIg==
X-Gm-Message-State: AC+VfDyWWMehqtJEBLUJijRuK0jJQBKQKtjf3D6xNrt216+1ezlQu5ky
        zRzTzQJ/83sJRhkN9AJ8OI5ULA==
X-Google-Smtp-Source: ACHHUZ4Gr0QQ+ZcK/i/VQ2rpYZaYbZXv33BKoEc4PqG+RdONzZCV9uQIHTzIUyZzCZRNhN2o96n3AQ==
X-Received: by 2002:a17:902:e883:b0:1a6:d776:9628 with SMTP id w3-20020a170902e88300b001a6d7769628mr86656plg.19.1682754667567;
        Sat, 29 Apr 2023 00:51:07 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001a6b2813c13sm14277717pll.172.2023.04.29.00.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 00:51:07 -0700 (PDT)
Date:   Sat, 29 Apr 2023 07:51:04 +0000
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
Message-ID: <20230429075104.6pncukm4a5bxcumx@google.com>
References: <20230428050442.180913-1-maskray@google.com>
 <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
 <20230428185814.mmnb3jafp7fnwdrh@google.com>
 <CAMj1kXFgv6GHm5PvR9Qq9-VwL+5NXwpChkB59c-0-tEJPNYdVQ@mail.gmail.com>
 <20230428210611.pxgmj2tja3y2c3lr@google.com>
 <CAMj1kXGKPyFOtPE30eanbD+5StvXGgX7Bi9iziTK9iqFg9=9wg@mail.gmail.com>
 <20230428222912.yanrwnl5hwykv6ve@google.com>
 <CAMj1kXGw9zz-PraPRx12uWkorhV0t8vRwG=qH7-3C75eBH2nAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXGw9zz-PraPRx12uWkorhV0t8vRwG=qH7-3C75eBH2nAg@mail.gmail.com>
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

On 2023-04-29, Ard Biesheuvel wrote:
>On Fri, 28 Apr 2023 at 23:29, Fangrui Song <maskray@google.com> wrote:
>>
>> On 2023-04-28, Ard Biesheuvel wrote:
>> >On Fri, 28 Apr 2023 at 22:06, Fangrui Song <maskray@google.com> wrote:
>> >>
>> >> On 2023-04-28, Ard Biesheuvel wrote:
>> >> >On Fri, 28 Apr 2023 at 19:58, Fangrui Song <maskray@google.com> wrote:
>> >> >>
>> >> >> On 2023-04-28, Ard Biesheuvel wrote:
>> >> >> >Hello Fangrui,
>> >> >>
>> >> >> Hello Ard, thank you for the rapid response.
>> >> >>
>> >> >> >On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
>> >> >> >>
>> >> >> >> Currently, the .got section is placed within the output section .text.
>> >> >> >> However, when .got is non-empty, the SHF_WRITE flag is set when linked
>> >> >> >> by lld. GNU ld recognizes .text as a special section and ignores the
>> >> >> >> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
>> >> >> >>
>> >> >> >> Conventionally, the .got section is placed just before .got.plt (which
>> >> >> >> should be empty and omitted in the kernel). Therefore, we move the .got
>> >> >> >> section to a conventional location (between .text and .data) and remove
>> >> >> >> the unneeded `. = ALIGN(16)`.
>> >> >> >>
>> >> >> >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> >> >> ---
>> >> >> >>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
>> >> >> >>  1 file changed, 10 insertions(+), 10 deletions(-)
>> >> >> >>
>> >> >> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >> >> >> index b9202c2ee18e..2bcb3b30db41 100644
>> >> >> >> --- a/arch/arm64/kernel/vmlinux.lds.S
>> >> >> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> >> >> >> @@ -181,18 +181,8 @@ SECTIONS
>> >> >> >>                         KPROBES_TEXT
>> >> >> >>                         HYPERVISOR_TEXT
>> >> >> >>                         *(.gnu.warning)
>> >> >> >> -               . = ALIGN(16);
>> >> >> >> -               *(.got)                 /* Global offset table          */
>> >> >> >>         }
>> >> >> >>
>> >> >> >> -       /*
>> >> >> >> -        * Make sure that the .got.plt is either completely empty or it
>> >> >> >> -        * contains only the lazy dispatch entries.
>> >> >> >> -        */
>> >> >> >> -       .got.plt : { *(.got.plt) }
>> >> >> >> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> >> >> >> -              "Unexpected GOT/PLT entries detected!")
>> >> >> >> -
>> >> >> >>         . = ALIGN(SEGMENT_ALIGN);
>> >> >> >>         _etext = .;                     /* End of text section */
>> >> >> >>
>> >> >> >> @@ -247,6 +237,16 @@ SECTIONS
>> >> >> >>
>> >> >> >>         . = ALIGN(SEGMENT_ALIGN);
>> >> >> >>         __inittext_end = .;
>> >> >> >> +
>> >> >> >> +       .got : { *(.got) }
>> >> >> >
>> >> >> >This is the .init region, which gets freed and unmapped after boot. If
>> >> >> >the GOT is non-empty, it needs to remain mapped, so we cannot place it
>> >> >> >here.
>> >> >>
>> >> >> Thanks.  I did not know the constraint.
>> >> >>
>> >> >> >We have the same issue with the .rodata section, which incorporates
>> >> >> >variables marked as __ro_after_init, which are not const qualified. So
>> >> >> >given that .rodata is already emitted as WA, and we cannot do anything
>> >> >> >about that, let's move the GOT in there.
>> >> >>
>> >> >> Yes, writable .data..ro_after_init and __jump_table sections in
>> >> >> include/asm-generic/vmlinux.lds.h (#define RO_DATA(align)) makes the
>> >> >> output section .rodata writable.  Perhaps this is very difficult to fix,
>> >> >> and we will have writable .rodata for a long time.
>> >> >>
>> >> >> What do you think of moving .got/.got.plt immediately before .data?
>> >> >> I want to place .got/.got.plt before the guaranteed-writable sections,
>> >> >> not some sections which are "unfortunately" writable (.rodata, __modver,
>> >> >> .hyp.rodata, .rodata.text, etc).
>> >> >>
>> >> >> For userspace programs, either linked with GNU ld or lld, .got/.got.plt
>> >> >> are usually immediately before .data .
>> >> >>
>> >> >
>> >> >I don't think that would be the right choice.
>> >> >
>> >> >We have five pseudo-segments in the kernel
>> >> >
>> >> >text (RX)
>> >> >rodata (R)
>> >> >inittext (RX)
>> >> >initdata (RW)
>> >> >data (RW)
>> >> >
>> >> >where the init ones disappear entirely when the boot completes.
>> >> >
>> >> >The GOT should not be modifiable, so it should not be in .data. So the
>> >> >only appropriate 'segment' for the GOT is rodata
>> >> >
>> >> >Note that we don't use PIC codegen for the kernel, so all const
>> >> >qualified data structures containing statically initialized global
>> >> >pointer variables are emitted into .rodata as well, and relocated at
>> >> >boot. So having the GOT in rodata too makes sense imho.
>> >>
>> >> arm64's vmlinux is linked with -shared -Bsymbolic and .got has many
>> >> entries that need to be relocated.
>> >
>> >Actually, it is mostly empty, given that we don't use -fpic/-fpie codegen.
>>
>> Yes, .got is usually small, e.g. 0x68 in my `make ARCH=arm64 LLVM=1 -j60 defconfig vmlinux` build.
>>
>> >>  .got is initially writable, and
>> >> becomes read-only after relocation resolving.
>> >
>> >The same applies to .rodata, given that we don't use -fpic/fpie
>> >codegen. And note that I am not referring to .data..ro_after_init here
>> >- I mean .rodata itself, which carries all const qualified global data
>> >structures with statically initialized pointer fields. These are
>> >conceptually the same as GOT entries - the only difference is that
>> >they are not created by the linker and are referenced explicitly from
>> >the C code.
>>
>> I agree that they are very similar, but there is a distinction, that's
>> why we have both .rodata and .data.rel.ro (relro), and the latter is for sections
>> that need relocations.
>>
>
>Yes, but we don't use .data.rel.ro in the kernel because we don't
>compile with -fpic/-fpie
>> >> I think this property is significant enough to make it outside of any rodata
>> >> segment.
>> >>
>> >
>> >I disagree.
>> >
>> >> (In the userspace .got is typically placed in PT_GNU_RELRO by using -z relro.)
>> >>
>> >> If we remove inittext and initdata pseudo-segments which disappear after
>> >> the boot, we have
>> >>
>> >> text (RX)
>> >> rodata (R)
>> >> /// where is .got (RELRO)
>> >> data (RW)
>> >>
>> >> If we consider .got distinct from rodata, I think placing .got immediately
>> >> after rodata or immediately before data is both fine?
>> >>
>> >
>> >We can place it anywhere in the rodata pseudo-segment. What user space
>> >does is not quite relevant here - what is relevant is that we already
>> >have a pseudo-segment with the right properties. Adding a new segment
>> >just for the GOT which is almost empty and is mapped with the same
>> >attributes as rodata seems unnecessary to me.
>> >
>> >Do you have any practical concerns? Or is it just tidiness?
>>
>> Unfortunately, vmlinux has many PT_LOAD program headers. I am trying to
>> find the best position for .got that makes the most sense. When making
>> this decision, I aim to create a layout that looks more normal and is
>> closer to user-space programs. Additionally, I want to reduce the number
>> of PT_LOAD program headers.
>>
>
>Why? The PT_LOAD headers are never consumed by anything. On arm64, we
>never consume the ELF - it is converted to a flat binary during the
>build.

See below.

>> You are arguing that .got should be part of rodata. However, I disagree
>> with this perspective from both practical and linker layout viewpoints.
>>
>> If we place .got below RO_DATA(PAGE_SIZE), it will immediately follow
>> .note or .BTF (see NOTES in include/asm-generic/vmlinux.lds.h).
>> There isn't an option to drop SHF_WRITE from .got, and
>> we will need a separate PT_LOAD program header for .got.
>>
>> Alternatively, if we place .got below .hyp.rodata, we can eliminate one
>> PT_LOAD because the transition from .hyp.rodata to .got does not require
>> a separate PT_LOAD. However, having a half-writable .got before
>> .rodata.text feels strange to me.
>>
>>
>> I feel that the region between .text/.rodata and .data is too messy.
>> Placing .got immediately before .data makes the layout look more normal
>> and closer to user space without causing any pessimization.
>>
>
>But we are not in user space. There is no ELF loader at runtime that
>consumes any of this, The entire layout is self-described by the
>linker script using symbols that the code links to directly.
>
>So frankly, if we could just avoid PT_LOAD headers entirely, or add a
>PHDRS {} section that defines a single region, I'd be ok with that.
>But tweaking the layout to reduce the number of PT_LOAD headers seems
>unnecessary to me.
>
>And moving the GOT into a writable area just to make the ELF metadata
>look tidier is out of the question - that could turn into a security
>bug.
>> ---
>>
>> My linker layout viewpoint is that ideally a program's program headers
>> should looke like
>>
>> https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#layout-related
>>
>> R PT_LOAD
>> RX PT_LOAD
>> RW PT_LOAD (overlaps with PT_GNU_RELRO) .got, .data.rel.ro (if present)
>> RW PT_LOAD
>>
>> For historical reason, I can expect swapped R and RX.
>> Sections such as .got and .data.rel.ro are different from both .rodata
>> and .data.
>>
>
>The kernel is remapped a number of times during the boot - in the
>initial mapping everything is read-only-exec except bss, and the
>physical address is used as the virtual address. When it is remapped
>again using the actual virtual addresses, we have two pseudo-segments,
>where text/rodata/inittext are RX and initdata and data are RW. Then,
>another mapping is created where text and inittext are RX, and rodata,
>initdata and data are RW, until finally inittext and initdata are
>unmapped and freed, and rodata is remapped read-only.
>
>In the context of the above, why does it matter what the PT_LOAD headers say?

Thank you for the explanation.  I may have missed something as I don't
know the boot process at all...  If we place .got immediately before the
_data symbol and the .data section, how is .got considered to be in a
writable area?

This part of your reply may be relevant:

> where text/rodata/inittext are RX and initdata and data are RW.

Do you mean that the regions [__initdata_begin,__initdata_end) and [_data, _end)
are RW?

If so, placing .got between __initdata_end and _data should not make
.got writable.  However, .got now appears to belong to an additional
pseudo-segment, which conceptually is bad.

Therefore, moving .got between .rodata.text and `idmap_pg_dir = .;` will
be a better choice. This makes .got part of a read-only pseudo-segment.

---

If my understanding is correct, at one point .got is indeed writable.
However, the kernel has performed R_AARCH64_RELATIVE resolving very
early, and can then assume that .got is read-only.
This is similar to user-space PT_GNU_RELRO, but the period is so
transient that we can essentially consider .got read-only.
