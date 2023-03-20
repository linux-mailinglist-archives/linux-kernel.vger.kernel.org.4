Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0296C2035
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCTSoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCTSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:43:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448303A4C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:36:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o11so13504267ple.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679337342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBIl2PWRcHeYzQ9ABWRCPOq3QoTVxUFeIIxTv/pav1A=;
        b=TUO9Wfgh09wDgxw22v5tTr+AP20sMvc8HV/V0RplKkyKnycMGQFB3QdPZDz64R13/J
         EPmT1ENRDnwub7hrMvy4S+DIDM57OS+sjlrl0SsQXc+n2I+Ndvsrflh5D2skNTkgA9Xn
         dUSS3M3Y7Kr/G56Dbbe+JTPhfsnyYoonh0OX7C1+jmn9Hme2yWE7cEIfAvAJQnbzPBdp
         YXOulWUIJCsS21BbTQdJxy30wqKO7yaON3hMk9DzEPId6FQCIF5UYoDiZvtFGVHIIoHX
         4DF01+LCmsy8R98AApC8YMB/b+bSyxcd57HezeN1XbNin8HGwReF6l0CxW5Dw5X6Ui5g
         0dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBIl2PWRcHeYzQ9ABWRCPOq3QoTVxUFeIIxTv/pav1A=;
        b=eKKqc2J2qcCPcUCmoL6/XDKq/gAvwIbfI7S2+qX9/ZohxMW1tvKCF+/q1QsvPifcGD
         yuPzxMPFO0eTmVZ0/8xoXc3vKwlyzn37EwxY8UvanU7qvUoblOlrQR6Xmx4ryv3IdOFX
         myO/TsM8eFXdxxJMl+BeW7bNl6ZyAI6iT1mn5btJDiQtc0TqsQV4Fu8QQJCeSLg8peKa
         3VDB1aI2L4K+Zr39UkLW42Wdzmmp4xTXQ9I66BVXV7A9PYGFGwXwBGGBPcoudHdyVdCA
         fiEQvd5LoqqjwC1YjeJmo05pCzHcU6YIFBhXND0cVZbTudHe3OHXPcsZWNFTKJnAlIzw
         HqZQ==
X-Gm-Message-State: AO0yUKVHtsXQ2lCoQ4y5USMUQRwlM1dNH+p+uIynwf7QYOplfPDswhhG
        4/+Q5vXcLl/MdQNHwpgBl/pVsb8ZIoiU4XFd0Qt5SH6zVNlq1TeXKK7MNwjp
X-Google-Smtp-Source: AK7set/s6BHfuCrf+r5ad8FHtC6QyXWvZpvg3aBDjLTGoAytFMuK97cpZm63QPbMMn7E1HIxebrVR064vmhz20AEzOA=
X-Received: by 2002:a17:902:e749:b0:1a0:4aa3:3a9a with SMTP id
 p9-20020a170902e74900b001a04aa33a9amr6942617plf.2.1679337342303; Mon, 20 Mar
 2023 11:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230320121006.4863-1-petr.pavlu@suse.com>
In-Reply-To: <20230320121006.4863-1-petr.pavlu@suse.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Mar 2023 11:35:30 -0700
Message-ID: <CAKwvOdkFvMgYypc4w+UChO2O50wSHqXJUct2fkxrd+Qgn2C4Cg@mail.gmail.com>
Subject: Re: [PATCH v5] x86: Avoid relocation information in final vmlinux
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        nathan@kernel.org, trix@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 5:10=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> The Linux build process on x86 roughly consists of compiling all input
> files, statically linking them into a vmlinux ELF file, and then taking
> and turning this file into an actual bzImage bootable file.
>
> vmlinux has in this process two main purposes:
> 1) It is an intermediate build target on the way to produce the final
>    bootable image.
> 2) It is a file that is expected to be used by debuggers and standard
>    ELF tooling to work with the built kernel.
>
> For the second purpose, a vmlinux file is typically collected by various
> package build recipes, such as distribution spec files, including the
> kernel's own tar-pkg target.
>
> When building a kernel supporting KASLR with CONFIG_X86_NEED_RELOCS,
> vmlinux contains also relocation information produced by using the
> --emit-relocs linker option. This is utilized by subsequent build steps
> to create vmlinux.relocs and produce a relocatable image. However, the
> information is not needed by debuggers and other standard ELF tooling.
>
> The issue is then that the collected vmlinux file and hence distribution
> packages end up unnecessarily large because of this extra data. The
> following is a size comparison of vmlinux v6.0 with and without the
> relocation information:
> | Configuration      | With relocs | Stripped relocs |
> | x86_64_defconfig   |       70 MB |           43 MB |
> | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |

Thanks for getting this to work with llvm-objcopy.  It's a pretty big
win for us, especially for thin-lto builds which produce a ridiculous
amount of debug info duplication (something I'm petitioning our DWARF
folks to look into for DWARFv6) some measurements (all LLVM=3D1):

Before this patch:
defconfig:
76M vmlinux
DEBUG_INFO:
510M vmlinux
DEBUG_INFO+LTO_CLANG_THIN:
796M vmlinux

after:
defconfig:
48M vmlinux (-36.8%)
DEBUG_INFO:
270M vmlinux (-47%)
LTO_CLANG_THIN:
400M vmlinux (-49.8%)

So basically a 50% reduction in vmlinux size, depending on the precise
configs selected. That's pretty great!

Android usually keeps around vmlinux artifacts as well as the
compressed image in case we need to debug the image later, this should
help us cut our storage costs for those quite a bit.  arm64 is more
common for Android, but x86_64 is pretty helpful for a virtualized
target; we do use it alot for first party development.

I also tested that I could still boot the result in QEMU, attach GDB,
and still hit breakpoints in the resulting vmlinux.  I also tested
that there were no more rel/rela sections missed in the resulting
vmlinux images.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Some minor review comments below.


I do also wonder if linkers have something like --emit-relocs, but the
option to produce it in an additional file. That would help us avoid
producing it only to split it out in the first place.

>
> Optimize a resulting vmlinux by adding a postlink step that splits the
> relocation information into vmlinux.relocs and then strips it from the
> vmlinux binary.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>
> Changes since v4 [1]:
> - Update the example target which is mentioned in the patch description
>   to collect vmlinux from binrpm-pkg to tar-pkg, to reflect fc8c2d8ff206
>   ("kbuild: Stop including vmlinux.bz2 in the rpm's").
>
> Changes since v3 [2]:
> - Update the Kbuild.include path in arch/x86/Makefile.postlink to work
>   after 67d7c3023a67 ("kbuild: remove --include-dir MAKEFLAG from top
>   Makefile").
>
> Changes since v2 [3]:
> - Ignore only the moved vmlinux.relocs, add it to .gitignore and
>   Documentation/dontdiff.
> - Clean up the patch description.
>
> Changes since v1 [4]:
> - Fix the command to remove relocations to work with llvm-objcopy too.
>
> [1] https://lore.kernel.org/lkml/20230227131829.26824-1-petr.pavlu@suse.c=
om/
> [2] https://lore.kernel.org/lkml/20221211141227.7622-1-petr.pavlu@suse.co=
m/
> [3] https://lore.kernel.org/lkml/20220927084632.14531-1-petr.pavlu@suse.c=
om/
> [4] https://lore.kernel.org/lkml/20220913132911.6850-1-petr.pavlu@suse.co=
m/
>
>  .gitignore                          |  1 +
>  Documentation/dontdiff              |  1 +
>  arch/x86/Makefile.postlink          | 41 +++++++++++++++++++++++++++++
>  arch/x86/boot/compressed/.gitignore |  1 -
>  arch/x86/boot/compressed/Makefile   | 10 +++----
>  5 files changed, 47 insertions(+), 7 deletions(-)
>  create mode 100644 arch/x86/Makefile.postlink
>
> diff --git a/.gitignore b/.gitignore
> index 70ec6037fa7a..9bafd3c6bb5f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -65,6 +65,7 @@ modules.order
>  /vmlinux
>  /vmlinux.32
>  /vmlinux.map
> +/vmlinux.relocs

Why do you move this from the arch/x86/boot/compressed/ dir?

>  /vmlinux.symvers
>  /vmlinux-gdb.py
>  /vmlinuz
> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
> index 3c399f132e2d..a62ad01e6d11 100644
> --- a/Documentation/dontdiff
> +++ b/Documentation/dontdiff
> @@ -254,6 +254,7 @@ vmlinux.aout
>  vmlinux.bin.all
>  vmlinux.lds
>  vmlinux.map
> +vmlinux.relocs
>  vmlinux.symvers
>  vmlinuz
>  voffset.h
> diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
> new file mode 100644
> index 000000000000..195af937aa4d
> --- /dev/null
> +++ b/arch/x86/Makefile.postlink
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +# Post-link x86 pass
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +#
> +# 1. Separate relocations from vmlinux into vmlinux.relocs.
> +# 2. Strip relocations from vmlinux.
> +
> +PHONY :=3D __archpost
> +__archpost:
> +
> +-include include/config/auto.conf
> +include $(srctree)/scripts/Kbuild.include
> +
> +CMD_RELOCS =3D arch/x86/tools/relocs
> +quiet_cmd_relocs =3D RELOCS  $@.relocs
> +      cmd_relocs =3D $(CMD_RELOCS) $@ > $@.relocs;$(CMD_RELOCS) --abs-re=
locs $@
> +
> +quiet_cmd_strip_relocs =3D RSTRIP  $@
> +      cmd_strip_relocs =3D $(OBJCOPY) --remove-section=3D'.rel.*' --remo=
ve-section=3D'.rel__*' --remove-section=3D'.rela.*' --remove-section=3D'.re=
la__*' $@

This line is pretty long (146 chars), can you use \ here to wrap it?

> +
> +# `@true` prevents complaint when there is nothing to be done
> +
> +vmlinux: FORCE
> +       @true
> +ifeq ($(CONFIG_X86_NEED_RELOCS),y)
> +       $(call cmd,relocs)
> +       $(call cmd,strip_relocs)
> +endif
> +
> +%.ko: FORCE
> +       @true
> +
> +clean:
> +       @rm -f vmlinux.relocs
> +
> +PHONY +=3D FORCE clean
> +
> +FORCE:
> +
> +.PHONY: $(PHONY)
> diff --git a/arch/x86/boot/compressed/.gitignore b/arch/x86/boot/compress=
ed/.gitignore
> index 25805199a506..b2968175fc27 100644
> --- a/arch/x86/boot/compressed/.gitignore
> +++ b/arch/x86/boot/compressed/.gitignore
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  relocs
>  vmlinux.bin.all
> -vmlinux.relocs
>  vmlinux.lds
>  mkpiggy
>  piggy.S
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed=
/Makefile
> index 6b6cfe607bdb..19d1fb601796 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -121,14 +121,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>
>  targets +=3D $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vm=
linux.relocs
>
> -CMD_RELOCS =3D arch/x86/tools/relocs
> -quiet_cmd_relocs =3D RELOCS  $@
> -      cmd_relocs =3D $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
> -$(obj)/vmlinux.relocs: vmlinux FORCE
> -       $(call if_changed,relocs)
> +# vmlinux.relocs is created by the vmlinux postlink step.
> +vmlinux.relocs: vmlinux
> +       @true
>
>  vmlinux.bin.all-y :=3D $(obj)/vmlinux.bin
> -vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) +=3D $(obj)/vmlinux.relocs
> +vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) +=3D vmlinux.relocs

Why do you remove $(obj) here? I'm guessing that's why you moved
vmlinux.relocs between .gitignore files?

>
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
>         $(call if_changed,gzip)
> --
> 2.35.3
>


--=20
Thanks,
~Nick Desaulniers
