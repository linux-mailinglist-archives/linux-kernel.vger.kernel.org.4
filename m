Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E701B6F1FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbjD1VGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbjD1VGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:06:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF310CF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:06:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a7ff4a454eso570905ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682715974; x=1685307974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhTOqSe6qAnF13reuabqOrN1K5xG4O3tS/SFmUpEa/0=;
        b=x0p3eemnc8UOuLDH7PeGt0q0ec27HwjsXWpsPhsVFEtLjrcbYMdbaKdXABFRK2yNmV
         yrnp2+xOyClZ0yc0GO3OW323CfODC2Qg+U5TtNPKZ0jhoX9fb9CXYRpd5u0aCaS9U5Hk
         KCEv7cvu1YHgIZIkzcokcR4BBAdTUahoX1Qz26IXIbc/jO4IQNYqK50S1eGIH2wiNRRj
         ggaeumAxjWCdpfnxhevA68PGIAVR58ECygbZ4xo9/ehI+BX0gE8fqhxOp2gKWwugXuMV
         RgYcdZEi9/e6EHMK4p3LdWVCIfkTevjdEkn3ZLoPOTUqKmVuXbqc2z078odGlPtU3me6
         7qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682715974; x=1685307974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhTOqSe6qAnF13reuabqOrN1K5xG4O3tS/SFmUpEa/0=;
        b=TCXFagT35ex8IRPRXJYyA4PrOoOSKX9cz/61jjpoWlpxneR3ENpJ+hUSnrSZWjOsNR
         fn+GzI6a7Bw4hTjaJVk50Dve+pA4EKAY4jKlM+zlzbjDOtdNMOVYl+VY5UxRFHLfswkP
         fU+/T0Pqd+x0w09+xJ+W/PM1OBP5zvAtJjvCbOvOVd4KyVc7/hVKJWobn8zL/WxgixdE
         pNGn+OhR3TESQ0lSJLxNupedu+/Xa5GVpb1NkebfwaTHUxNtRru8CV+qQqowlWO/1SkZ
         usxoEJXFrdG6cv7WPfSWELqRNk0vdbsjr6k8/pgunZJlOaPukZs+jrAkWLm6ZPQkN2hQ
         LBiQ==
X-Gm-Message-State: AC+VfDyIrqTsZRj3BgrTf63aUCsLagvnhK/hp0Dbzu7aI6EZfa1U9fmn
        4z5Br7fW/4G1n9QJv51otgCM8Q==
X-Google-Smtp-Source: ACHHUZ7Awam+ifDmPR1FqzYdNuRRwApNC4SQkIrzJJnclCww5q/6MjPHYxpDa+nCPDmidsigLYOsaw==
X-Received: by 2002:a17:903:1d0:b0:1a6:970f:8572 with SMTP id e16-20020a17090301d000b001a6970f8572mr4282plh.3.1682715973761;
        Fri, 28 Apr 2023 14:06:13 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id w77-20020a627b50000000b0063f0ef3b421sm4212399pfc.14.2023.04.28.14.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:06:13 -0700 (PDT)
Date:   Fri, 28 Apr 2023 21:06:11 +0000
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
Message-ID: <20230428210611.pxgmj2tja3y2c3lr@google.com>
References: <20230428050442.180913-1-maskray@google.com>
 <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
 <20230428185814.mmnb3jafp7fnwdrh@google.com>
 <CAMj1kXFgv6GHm5PvR9Qq9-VwL+5NXwpChkB59c-0-tEJPNYdVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXFgv6GHm5PvR9Qq9-VwL+5NXwpChkB59c-0-tEJPNYdVQ@mail.gmail.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28, Ard Biesheuvel wrote:
>On Fri, 28 Apr 2023 at 19:58, Fangrui Song <maskray@google.com> wrote:
>>
>> On 2023-04-28, Ard Biesheuvel wrote:
>> >Hello Fangrui,
>>
>> Hello Ard, thank you for the rapid response.
>>
>> >On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
>> >>
>> >> Currently, the .got section is placed within the output section .text.
>> >> However, when .got is non-empty, the SHF_WRITE flag is set when linked
>> >> by lld. GNU ld recognizes .text as a special section and ignores the
>> >> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
>> >>
>> >> Conventionally, the .got section is placed just before .got.plt (which
>> >> should be empty and omitted in the kernel). Therefore, we move the .got
>> >> section to a conventional location (between .text and .data) and remove
>> >> the unneeded `. = ALIGN(16)`.
>> >>
>> >> Signed-off-by: Fangrui Song <maskray@google.com>
>> >> ---
>> >>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
>> >>  1 file changed, 10 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >> index b9202c2ee18e..2bcb3b30db41 100644
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
>> >> @@ -247,6 +237,16 @@ SECTIONS
>> >>
>> >>         . = ALIGN(SEGMENT_ALIGN);
>> >>         __inittext_end = .;
>> >> +
>> >> +       .got : { *(.got) }
>> >
>> >This is the .init region, which gets freed and unmapped after boot. If
>> >the GOT is non-empty, it needs to remain mapped, so we cannot place it
>> >here.
>>
>> Thanks.  I did not know the constraint.
>>
>> >We have the same issue with the .rodata section, which incorporates
>> >variables marked as __ro_after_init, which are not const qualified. So
>> >given that .rodata is already emitted as WA, and we cannot do anything
>> >about that, let's move the GOT in there.
>>
>> Yes, writable .data..ro_after_init and __jump_table sections in
>> include/asm-generic/vmlinux.lds.h (#define RO_DATA(align)) makes the
>> output section .rodata writable.  Perhaps this is very difficult to fix,
>> and we will have writable .rodata for a long time.
>>
>> What do you think of moving .got/.got.plt immediately before .data?
>> I want to place .got/.got.plt before the guaranteed-writable sections,
>> not some sections which are "unfortunately" writable (.rodata, __modver,
>> .hyp.rodata, .rodata.text, etc).
>>
>> For userspace programs, either linked with GNU ld or lld, .got/.got.plt
>> are usually immediately before .data .
>>
>
>I don't think that would be the right choice.
>
>We have five pseudo-segments in the kernel
>
>text (RX)
>rodata (R)
>inittext (RX)
>initdata (RW)
>data (RW)
>
>where the init ones disappear entirely when the boot completes.
>
>The GOT should not be modifiable, so it should not be in .data. So the
>only appropriate 'segment' for the GOT is rodata
>
>Note that we don't use PIC codegen for the kernel, so all const
>qualified data structures containing statically initialized global
>pointer variables are emitted into .rodata as well, and relocated at
>boot. So having the GOT in rodata too makes sense imho.

arm64's vmlinux is linked with -shared -Bsymbolic and .got has many
entries that need to be relocated.  .got is initially writable, and
becomes read-only after relocation resolving.
I think this property is significant enough to make it outside of any rodata
segment.

(In the userspace .got is typically placed in PT_GNU_RELRO by using -z relro.)

If we remove inittext and initdata pseudo-segments which disappear after
the boot, we have

text (RX)
rodata (R)
/// where is .got (RELRO)
data (RW)

If we consider .got distinct from rodata, I think placing .got immediately
after rodata or immediately before data is both fine?


>
>
>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index b9202c2ee18e..48bd7c25b6ab 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -181,18 +181,8 @@ SECTIONS
>>                         KPROBES_TEXT
>>                         HYPERVISOR_TEXT
>>                         *(.gnu.warning)
>> -               . = ALIGN(16);
>> -               *(.got)                 /* Global offset table          */
>>         }
>>
>> -       /*
>> -        * Make sure that the .got.plt is either completely empty or it
>> -        * contains only the lazy dispatch entries.
>> -        */
>> -       .got.plt : { *(.got.plt) }
>> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> -              "Unexpected GOT/PLT entries detected!")
>> -
>>         . = ALIGN(SEGMENT_ALIGN);
>>         _etext = .;                     /* End of text section */
>>
>> @@ -286,6 +276,15 @@ SECTIONS
>>         __initdata_end = .;
>>         __init_end = .;
>>
>> +       .got : { *(.got) }
>> +       /*
>> +        * Make sure that the .got.plt is either completely empty or it
>> +        * contains only the lazy dispatch entries.
>> +        */
>> +       .got.plt : { *(.got.plt) }
>> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> +              "Unexpected GOT/PLT entries detected!")
>> +
>>         _data = .;
>>         _sdata = .;
>>         RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
>> --
>> 2.40.1.495.gc816e09b53d-goog
>>
>>
>> >> +       /*
>> >> +        * Make sure that the .got.plt is either completely empty or it
>> >> +        * contains only the lazy dispatch entries.
>> >> +        */
>> >> +       .got.plt : { *(.got.plt) }
>> >> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> >> +              "Unexpected GOT/PLT entries detected!")
>> >> +
>> >>         __initdata_begin = .;
>> >>
>> >>         init_idmap_pg_dir = .;
>> >> --
>> >> 2.40.1.495.gc816e09b53d-goog
>> >>
