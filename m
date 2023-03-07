Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED26AD8C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCGIJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCGIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:09:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAEF50983
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:09:03 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ky4so13253884plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678176541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5zZrovIRs5zLJv0G+iS2mKyTpyGJ8bky1sIW7/neCY=;
        b=m8OxLTzPl5iPiawWVFI1+BNlPyv1wKgsXEbJBkslhBiY8dheVnaRyijBo9KRfTFDbi
         3U7n6UD3qANq8Z20nnwhlw65qmr7pZgXP/3UckK6C0K9jDL+sv4cBg1r8Al98rHprBtJ
         qo7D3GQvUCmNJRd4MJ/vmGiYLIYeku3p74VVfC/+LreVUNFlnRW+MJZIbY+pJRVhmoGx
         XbFYrkHyf+DedkljOOdxhPvgeFsjR5cKXybth7jwsyAmcBgRN5kIuAZ4TERj+j0fdzr3
         WxTesprLD0E+Tq2HDV0sk2cI3pBHiG7ih24DE0Oi6BgenAILg9t0e+5Ve0vGKp3zOl+2
         HbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5zZrovIRs5zLJv0G+iS2mKyTpyGJ8bky1sIW7/neCY=;
        b=GOellUPPLDmGeiIKi1dnPKv4hwPR6Cr/Q0I3CJCJku0KZt4XhkVWPjUWx9Ra79fwZF
         +PblUSStTygBxa/X6UZy95Z8cj2UQRujYVYRa+4RACFfOvTv06Q3iYhLUWxCI9cVzC+u
         h4e/Qv4UA7sxgpsFHMJRWxQ8B9ILgtduRCrtfZlf/clz7iFFFJooDmyICetRzC87M3Y/
         aOt4iHuQeLap7MupUHxt9tkIcOmxB0tr4GF1n2uRMpuYJYd811UzXX43P+tAjNkhVyEk
         GE8tuNvLcieLVebHoCSTUq1EtpWfb1wgob5yfoaNUJW3Pxm5gSqhb2QDhOlaHl6hl370
         y3Fg==
X-Gm-Message-State: AO0yUKViv827c1Q+VV6CWab2ziV2udWPbUrkgHZFHT+3rXFjvMgs/cZa
        9w9eu+svEFKOw36Gg7aZeg==
X-Google-Smtp-Source: AK7set8Z+BUR8AwsCrasOZRglrMO4TGwh/SjdjgmzTf5p3052x3E2Cc9Q5pK4PgMa8K9mB8ivsTYQw==
X-Received: by 2002:a05:6a21:78a6:b0:cc:5f27:d003 with SMTP id bf38-20020a056a2178a600b000cc5f27d003mr14752364pzc.56.1678176541057;
        Tue, 07 Mar 2023 00:09:01 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e1-20020a631e01000000b004fb681ea0e1sm7290405pge.84.2023.03.07.00.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:09:00 -0800 (PST)
Date:   Tue, 7 Mar 2023 16:08:55 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Message-ID: <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
 <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

Thanks for sharing your idea. Please see the comment.

On Mon, Mar 06, 2023 at 09:08:03AM +0100, Ard Biesheuvel wrote:
> (cc Mark)
> 
> Hello Pingfan,
> 
> Thanks for working on this.
> 
> On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > After introducing zboot image, kexec_file can not load and jump to the
> > new style image. Hence it demands a method to load the new kernel.
> >
> > The crux of the problem lies in when and how to decompress the Image.gz.
> > There are three possible courses to take: -1. in user space, but hard to
> > achieve due to the signature verification inside the kernel.
> 
> That depends. The EFI zboot image encapsulates another PE/COFF image,
> which could be signed as well.
> 
> So there are at least three other options here:
> - sign the encapsulated image with the same key as the zboot image
> - sign the encapsulated image with a key that is only valid for kexec boot
> - sign the encapsulated image with an ephemeral key that is only valid
> for a kexec'ing an image that was produced by the same kernel build
> 
> >  -2. at the
> > boot time, let the efi_zboot_entry() handles it, which means a simulated
> > EFI service should be provided to that entry, especially about how to be
> > aware of the memory layout.
> 
> This is actually an idea I intend to explore: with the EFI runtime
> services regions mapped 1:1, it wouldn't be too hard to implement a
> minimal environment that can run the zboot image under the previous

The idea of the minimal environment lools amazing. After digging
more deeply into it, I think it means to implement most of the function
members in efi_boot_services, besides that, some UEFI protocols due to
the reference of efi_call_proto(). So a clear boundary between zboot and
its dependent EFI service is demanded before the work.

> kernel up to the point where it call ExitBootServices(), after which
> kexec() would take over.
> 

IIUC, after kexec switches to efi_zboot_entry(), it will not return,
right?

> >  -3. in kernel space, during the file load
> > of the zboot image. At that point, the kernel masters the whole memory
> > information, and easily allocates a suitable memory for the decompressed
> > kernel image. (I think this is similar to what grub does today).
> >
> 
> GRUB just calls LoadImage(), and the decompression code runs in the EFI context.
> 

Ah, thanks for the correcting. I had made an wrong assumption of grub
based on [1], from which, I thought that grub is the case "For
compatibility with non-EFI loaders, the payload can be decompressed and
executed by the loader as well, provided that the loader implements the
decompression algorithm and that non-EFI boot is supported by the
encapsulated image" 


[1]: https://www.phoronix.com/news/Linux-6.1-Generic-EFI-Zboot


Eager to find a solution to kexec a zboot image. Hope it will come soon.


Thanks,

	Pingfan
> > The core of this series is [5/6].  [3,6/6] handles the config option.
> > The assumption of [3/6] is kexec_file_load is independent of zboot,
> > especially it can load kernel images compressed with different
> > compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> > decompression method should be included.
> >
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: kexec@lists.infradead.org
> > To: linux-arm-kernel@lists.infradead.org
> > To: linux-kernel@vger.kernel.org
> >
> > Pingfan Liu (6):
> >   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
> >   lib/decompress: Introduce decompress_method_by_name()
> >   arm64: Kconfig: Pick decompressing method for kexec file load
> >   lib/decompress: Keep decompress routines based on selection
> >   arm64: kexec: Introduce zboot image loader
> >   init/Kconfig: Select decompressing method if compressing kernel
> >
> >  arch/arm64/Kconfig                            |  59 ++++++
> >  arch/arm64/include/asm/kexec.h                |   4 +-
> >  arch/arm64/kernel/Makefile                    |   2 +-
> >  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
> >  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
> >  arch/arm64/kernel/machine_kexec.c             |   1 +
> >  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
> >  include/linux/decompress/generic.h            |   2 +
> >  include/linux/decompress/mm.h                 |   9 +-
> >  include/linux/zboot.h                         |  26 +++
> >  init/Kconfig                                  |   7 +
> >  lib/Kconfig                                   |   3 +
> >  lib/decompress.c                              |  17 +-
> >  13 files changed, 314 insertions(+), 7 deletions(-)
> >  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
> >  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
> >  create mode 100644 include/linux/zboot.h
> >
> > --
> > 2.31.1
> >
