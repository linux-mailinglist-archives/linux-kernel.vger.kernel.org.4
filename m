Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358A96B358C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCJEWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCJEVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:21:23 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F214EA2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:17:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn12so4153106pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 20:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678421845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU4apqaTRhvF7Rao6hZgNCQ5bmYVq7gw3Mf+gBiqigE=;
        b=pYTx65/TDFzzGD3U9Ia1TQ/VM0xQnU2LBWqzSyUpfrXb0caFoymwlvwmeY7WJSEtTm
         F3Xt8ykXyCEENrlyj4sMYBFTkSB8VSpIxolDyGBdCOLkmMupjVWAQI4mTtdK74BE+PdX
         OvWg+ZWAca45zBzEcZmhI++JF7SykdducaZ8a2MFEfnIY5l8qA/BzsRIdfGblbl/6hZ/
         nf0FynJcElVc/F+gKz4TsiBBMZa5tMvL4E11qycBkT8nWjAnfLqZAP6VOlrls6XsURaj
         ro4d8NnNQpWXtoSV5MNNF0aGslduW4fhH6EKrv0H9g/c0mqK8LIFN51E0Ix/Bnu7ejhx
         RKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU4apqaTRhvF7Rao6hZgNCQ5bmYVq7gw3Mf+gBiqigE=;
        b=UdzshSaCUBtgi4m3wnRsjrN4qlrAB+kikFaVSnjM5Vx0XuN4p1kwkAQzuI20LFmhHq
         BU5L4IMO4DWp0UJQaG8+6wFrF+fOWIb/qVB5v3TPbPBxlrA1Cy/YrPg+EUNY+3drG5e4
         yf8e/caxMKZ94jf/65ky5W6EPWXvi0G5Pi77s4MVWyb+lGmcspx1bBEgGPhCdTpgOBl+
         CG3RfRB534Jvn9aPO+iawJWBfA26AQ7YX9pGfMtu6qaFybktA/zrPUNAkEhU4hEHvoz0
         wJrW2+eCLZgXfG1tmpl8ZvB5VHarVxQ9MQMH173xbETw7e1oD2PGQlSR8dKMbLijiPwa
         uurA==
X-Gm-Message-State: AO0yUKVd8ZcRRnowJhJ7X+Z9HLwWIn0rjKTPMQyXzR1fRoaklwMFzjm4
        1uX8NtmhgjpiVdIxqFL0FA==
X-Google-Smtp-Source: AK7set/lC7bwOfFt1xEFfH4Q2bMEjvqYBbPhBM5Dm1RxGyhtvDximq8Rla8hJPopnXt92tvy5nxhBA==
X-Received: by 2002:a17:90b:1b4e:b0:23a:5f51:6ee5 with SMTP id nv14-20020a17090b1b4e00b0023a5f516ee5mr25386228pjb.12.1678421845114;
        Thu, 09 Mar 2023 20:17:25 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090a119000b002367325203fsm699285pja.50.2023.03.09.20.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:17:24 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:17:19 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Message-ID: <ZAqvTyv3C+Hvl9cR@piliu.users.ipa.redhat.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
 <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
 <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:08:55PM +0800, Pingfan Liu wrote:
> Hi Ard,
> 
> Thanks for sharing your idea. Please see the comment.
> 
> On Mon, Mar 06, 2023 at 09:08:03AM +0100, Ard Biesheuvel wrote:
> > (cc Mark)
> > 
> > Hello Pingfan,
> > 
> > Thanks for working on this.
> > 
> > On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > After introducing zboot image, kexec_file can not load and jump to the
> > > new style image. Hence it demands a method to load the new kernel.
> > >
> > > The crux of the problem lies in when and how to decompress the Image.gz.
> > > There are three possible courses to take: -1. in user space, but hard to
> > > achieve due to the signature verification inside the kernel.
> > 
> > That depends. The EFI zboot image encapsulates another PE/COFF image,
> > which could be signed as well.
> > 
> > So there are at least three other options here:
> > - sign the encapsulated image with the same key as the zboot image
> > - sign the encapsulated image with a key that is only valid for kexec boot
> > - sign the encapsulated image with an ephemeral key that is only valid
> > for a kexec'ing an image that was produced by the same kernel build
> > 
> > >  -2. at the
> > > boot time, let the efi_zboot_entry() handles it, which means a simulated
> > > EFI service should be provided to that entry, especially about how to be
> > > aware of the memory layout.
> > 
> > This is actually an idea I intend to explore: with the EFI runtime
> > services regions mapped 1:1, it wouldn't be too hard to implement a
> > minimal environment that can run the zboot image under the previous
> 
> The idea of the minimal environment lools amazing. After digging
> more deeply into it, I think it means to implement most of the function
> members in efi_boot_services, besides that, some UEFI protocols due to
> the reference of efi_call_proto(). So a clear boundary between zboot and
> its dependent EFI service is demanded before the work.
> 

Looking deeper into it. This approach may be splitted into the following
chunks:
-1. Estimation the memory demanded by the decompression of zboot, which
roughly includes the size of Image, the size of the emulated service and
the stack used by zboot. Finally we need a kexec_add_buffer() for this
range.

-2. The emulated EFI services and some initial data such as the physical
address of dtb, the usable memory start address and size should be set
by kexec_purgatory_get_set_symbol()

-3. Set up an identity mapping of the usable memory by zboot, prepare
stack and turn on MMU at the last point just before 'br efi_zboot_entry'
in relocate_kernel.S, which means relocate_kernel.S should support two
kinds of payload.

-4. For efi_zboot_entry(), if jumping from kexec, limit its requirement
to only a few boot services: e.g. allocate_pages, allocate_pool. So the
emulated services can be deduced.

> > kernel up to the point where it call ExitBootServices(), after which
> > kexec() would take over.
> > 
> 
> IIUC, after kexec switches to efi_zboot_entry(), it will not return,
> right?
> 

I have this assumption because letting the control path switch between
kernel and non-kernel code is not a good idea.


Thanks,

Pingfan

> > >  -3. in kernel space, during the file load
> > > of the zboot image. At that point, the kernel masters the whole memory
> > > information, and easily allocates a suitable memory for the decompressed
> > > kernel image. (I think this is similar to what grub does today).
> > >
> > 
> > GRUB just calls LoadImage(), and the decompression code runs in the EFI context.
> > 
> 
> Ah, thanks for the correcting. I had made an wrong assumption of grub
> based on [1], from which, I thought that grub is the case "For
> compatibility with non-EFI loaders, the payload can be decompressed and
> executed by the loader as well, provided that the loader implements the
> decompression algorithm and that non-EFI boot is supported by the
> encapsulated image" 
> 
> 
> [1]: https://www.phoronix.com/news/Linux-6.1-Generic-EFI-Zboot
> 
> 
> Eager to find a solution to kexec a zboot image. Hope it will come soon.
> 
> 
> Thanks,
> 
> 	Pingfan
> > > The core of this series is [5/6].  [3,6/6] handles the config option.
> > > The assumption of [3/6] is kexec_file_load is independent of zboot,
> > > especially it can load kernel images compressed with different
> > > compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> > > decompression method should be included.
> > >
> > >
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: kexec@lists.infradead.org
> > > To: linux-arm-kernel@lists.infradead.org
> > > To: linux-kernel@vger.kernel.org
> > >
> > > Pingfan Liu (6):
> > >   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
> > >   lib/decompress: Introduce decompress_method_by_name()
> > >   arm64: Kconfig: Pick decompressing method for kexec file load
> > >   lib/decompress: Keep decompress routines based on selection
> > >   arm64: kexec: Introduce zboot image loader
> > >   init/Kconfig: Select decompressing method if compressing kernel
> > >
> > >  arch/arm64/Kconfig                            |  59 ++++++
> > >  arch/arm64/include/asm/kexec.h                |   4 +-
> > >  arch/arm64/kernel/Makefile                    |   2 +-
> > >  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
> > >  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
> > >  arch/arm64/kernel/machine_kexec.c             |   1 +
> > >  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
> > >  include/linux/decompress/generic.h            |   2 +
> > >  include/linux/decompress/mm.h                 |   9 +-
> > >  include/linux/zboot.h                         |  26 +++
> > >  init/Kconfig                                  |   7 +
> > >  lib/Kconfig                                   |   3 +
> > >  lib/decompress.c                              |  17 +-
> > >  13 files changed, 314 insertions(+), 7 deletions(-)
> > >  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
> > >  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
> > >  create mode 100644 include/linux/zboot.h
> > >
> > > --
> > > 2.31.1
> > >
