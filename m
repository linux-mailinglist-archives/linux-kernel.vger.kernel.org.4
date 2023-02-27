Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152F6A4218
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB0M5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB0M5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:57:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925AF1CAC1;
        Mon, 27 Feb 2023 04:57:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D1E160DF6;
        Mon, 27 Feb 2023 12:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9101AC433A8;
        Mon, 27 Feb 2023 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677502628;
        bh=zedX3PdU562c+Q1Gru7wIFDB2Pb4iAhIkFLPWy35NEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sgKlU8T7UnCzCGpc2Ptin2Yo+usa0g1LIyoX6AHWNJX+cAeTVWPsCekMElbdRZTd7
         yVAuodfK5Yk9dM3GAv7cLT/0VnAMP2q/IQIBs4NE2iWBp59pO1k9yXRxxpq0N5iS7C
         rt3PXCYzUMbQqcfRjrfZZQa9FitCYgCft7Q6YEUgs/EXLC/lGv3h0wbs4cLNPIbfLf
         pVRJTJBrQdPFhAH8PTAqJoax84OVsNw6oXmhrM9gdYt/s8uXBWB7erR/+WyDocXkPm
         +nKIjmNwA/XTUezg1EVIp3ki9wyobdAwaq48s1YpJMRTj6JHTl9MTCLeZilzOT5J/Z
         TwuTLiafgIBcg==
Received: by mail-lf1-f45.google.com with SMTP id f18so8428006lfa.3;
        Mon, 27 Feb 2023 04:57:08 -0800 (PST)
X-Gm-Message-State: AO0yUKU9fxwMau8imkqxiDdjpYX238H4FDMh1RDWhudzDrdc75nmzapK
        WYf2BIh3YESJEM1sndBVlALiCuDP50rnriaIWyI=
X-Google-Smtp-Source: AK7set9VVtyfreeHcNt3/ckrXOFuAsLW/BdgFHIDhxvPasrYVOh6UMsLhaVKKjKkGGJH2QPPePGPWvRpd3iC4i7i69A=
X-Received: by 2002:ac2:44a8:0:b0:4d8:6fd3:b8bf with SMTP id
 c8-20020ac244a8000000b004d86fd3b8bfmr7422782lfm.7.1677502626519; Mon, 27 Feb
 2023 04:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20230224100218.1824569-1-alexghiti@rivosinc.com>
 <20230224100218.1824569-2-alexghiti@rivosinc.com> <Y/yilORflGv3vXjX@wendy>
In-Reply-To: <Y/yilORflGv3vXjX@wendy>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Feb 2023 13:56:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGCkqpHY7rHZv0EFKhPNk6jpbh1OfG_Jm3vSW8c5Y+9_A@mail.gmail.com>
Message-ID: <CAMj1kXGCkqpHY7rHZv0EFKhPNk6jpbh1OfG_Jm3vSW8c5Y+9_A@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] riscv: Allow to downgrade paging mode from the
 command line
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        nathan@kernel.org, llvm@lists.linux.dev, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 13:32, Conor Dooley <conor.dooley@microchip.com> wro=
te:
>
> Hey Alex, clang/llvm folk,
>
> On Fri, Feb 24, 2023 at 11:02:18AM +0100, Alexandre Ghiti wrote:
> > Add 2 early command line parameters that allow to downgrade satp mode
> > (using the same naming as x86):
> > - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> > - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
> >
> > Note that going through the device tree to get the kernel command line
> > works with ACPI too since the efi stub creates a device tree anyway wit=
h
> > the command line.
> >
> > In KASAN kernels, we can't use the libfdt that early in the boot proces=
s
> > since we are not ready to execute instrumented functions. So instead of
> > using the "generic" libfdt, we compile our own versions of those functi=
ons
> > that are not instrumented and that are prefixed so that they do not
> > conflict with the generic ones. We also need the non-instrumented versi=
ons
> > of the string functions and the prefixed versions of memcpy/memmove.
> >
> > This is largely inspired by commit aacd149b6238 ("arm64: head: avoid
> > relocating the kernel twice for KASLR") from which I removed compilatio=
n
> > flags that were not relevant to RISC-V at the moment (LTO, SCS, pie).
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  5 +-
> >  arch/riscv/kernel/Makefile                    |  2 +
> >  arch/riscv/kernel/pi/Makefile                 | 37 +++++++++++
> >  arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
>
> +      4 ld.lld: warning: vmlinux.a(arch/riscv/kernel/pi/string.pi.o):(.i=
nit.sdata) is being placed in '.init.sdata'
>
> I'm getting 4 new linker warnings with LLVM=3D1 clang-15 allmodconfig
> builds - but I don't really understand this issue.
> Is this spurious, and a just consequence of...
>
> > diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makef=
ile
> > new file mode 100644
> > index 000000000000..4002ed94b6d3
> > --- /dev/null
> > +++ b/arch/riscv/kernel/pi/Makefile
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# This file was copied from arm64/kernel/pi/Makefile.
> > +
> > +KBUILD_CFLAGS        :=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)=
) \
> > +                -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLU=
GIN) \
> > +                $(call cc-option,-mbranch-protection=3Dnone) \
> > +                -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
> > +                -D__DISABLE_EXPORTS -ffreestanding \
> > +                -fno-asynchronous-unwind-tables -fno-unwind-tables \
> > +                $(call cc-option,-fno-addrsig)
> > +
> > +CFLAGS_cmdline_early.o +=3D -D__NO_FORTIFY
> > +CFLAGS_lib-fdt_ro.o +=3D -D__NO_FORTIFY
> > +
> > +GCOV_PROFILE :=3D n
> > +KASAN_SANITIZE       :=3D n
> > +KCSAN_SANITIZE       :=3D n
> > +UBSAN_SANITIZE       :=3D n
> > +KCOV_INSTRUMENT      :=3D n
> > +
> > +$(obj)/%.pi.o: OBJCOPYFLAGS :=3D --prefix-symbols=3D__pi_ \
> > +                            --remove-section=3D.note.gnu.property \
> > +                            --prefix-alloc-sections=3D.init
>
> ...this?
>

Yes. if the input object has a .sdata section, the output .pi.o object
will have a .init.sdata section, and if the common linker script does
not place it explicitly, you will get a warning. Note that we switched
to --orphan-handling=3Derror on other arches, as the linker sometimes
does unexpected things with sections it doesn't know about.

I'd imagine this needs to be combined with .init.data
