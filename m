Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A71F6AB7F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCFII1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCFIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:08:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B7B93E6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BBE960C19
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E746BC4339E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678090096;
        bh=InTHjoY7IHjYGOge2xtjXx++Yn/E+Bilz80BtlawvMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j2RPowZFjt3/lAmnPiLqbIXbp05Tb0FwtEvABvGSQXlfRJs2Qrom9TtNneGlYy+6p
         JJGce8ulZ5uhDmVvOtOpZoFNFIVDCf0vqgdvw75Izi5rZLCSHdNtNt5TFKv9UDgDRv
         2q/ctsnREW0ueRQT+NNXgoAWPbnOJETWZ7Fto4ghQuN9KJ/p31yvmoyc0o/Q+yOTEj
         ftKWIBLxDYQyq42CV7lvKEfOZDXFV1VYJWB79Jtd/ReG4ZenkaasFiJxY7rE74XTLw
         x59d6cuccSzVYR9VOnG0M8BsLAHT9NuetancbtR1cDj3zcqyx7g8hjqCKIc8MCBIGd
         lgmJT++ZbJnUg==
Received: by mail-lj1-f174.google.com with SMTP id f16so8671084ljq.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:08:16 -0800 (PST)
X-Gm-Message-State: AO0yUKUmFsHf17veYzNc8OJTxtyNCJudw+RwFLH6T5DS3eV5PFd8OVxt
        qH7SZb5uhx+KrChyUhFoU9yJWdvzctByQj6WzcU=
X-Google-Smtp-Source: AK7set/u2iI2GmPpi74ma3lbh9gCKEtqWTLFne3S0kGYtghedVx/axHU4rUI/K3IRXkDs2jwtzKDYRytPptbGrlkDII=
X-Received: by 2002:a05:651c:1725:b0:295:8ef2:8707 with SMTP id
 be37-20020a05651c172500b002958ef28707mr2846606ljb.2.1678090094989; Mon, 06
 Mar 2023 00:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20230306030305.15595-1-kernelfans@gmail.com>
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Mar 2023 09:08:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
Message-ID: <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
To:     Pingfan Liu <kernelfans@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Mark)

Hello Pingfan,

Thanks for working on this.

On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
>
> After introducing zboot image, kexec_file can not load and jump to the
> new style image. Hence it demands a method to load the new kernel.
>
> The crux of the problem lies in when and how to decompress the Image.gz.
> There are three possible courses to take: -1. in user space, but hard to
> achieve due to the signature verification inside the kernel.

That depends. The EFI zboot image encapsulates another PE/COFF image,
which could be signed as well.

So there are at least three other options here:
- sign the encapsulated image with the same key as the zboot image
- sign the encapsulated image with a key that is only valid for kexec boot
- sign the encapsulated image with an ephemeral key that is only valid
for a kexec'ing an image that was produced by the same kernel build

>  -2. at the
> boot time, let the efi_zboot_entry() handles it, which means a simulated
> EFI service should be provided to that entry, especially about how to be
> aware of the memory layout.

This is actually an idea I intend to explore: with the EFI runtime
services regions mapped 1:1, it wouldn't be too hard to implement a
minimal environment that can run the zboot image under the previous
kernel up to the point where it call ExitBootServices(), after which
kexec() would take over.

>  -3. in kernel space, during the file load
> of the zboot image. At that point, the kernel masters the whole memory
> information, and easily allocates a suitable memory for the decompressed
> kernel image. (I think this is similar to what grub does today).
>

GRUB just calls LoadImage(), and the decompression code runs in the EFI context.

> The core of this series is [5/6].  [3,6/6] handles the config option.
> The assumption of [3/6] is kexec_file_load is independent of zboot,
> especially it can load kernel images compressed with different
> compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> decompression method should be included.
>
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: kexec@lists.infradead.org
> To: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org
>
> Pingfan Liu (6):
>   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
>   lib/decompress: Introduce decompress_method_by_name()
>   arm64: Kconfig: Pick decompressing method for kexec file load
>   lib/decompress: Keep decompress routines based on selection
>   arm64: kexec: Introduce zboot image loader
>   init/Kconfig: Select decompressing method if compressing kernel
>
>  arch/arm64/Kconfig                            |  59 ++++++
>  arch/arm64/include/asm/kexec.h                |   4 +-
>  arch/arm64/kernel/Makefile                    |   2 +-
>  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
>  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
>  arch/arm64/kernel/machine_kexec.c             |   1 +
>  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
>  include/linux/decompress/generic.h            |   2 +
>  include/linux/decompress/mm.h                 |   9 +-
>  include/linux/zboot.h                         |  26 +++
>  init/Kconfig                                  |   7 +
>  lib/Kconfig                                   |   3 +
>  lib/decompress.c                              |  17 +-
>  13 files changed, 314 insertions(+), 7 deletions(-)
>  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
>  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
>  create mode 100644 include/linux/zboot.h
>
> --
> 2.31.1
>
