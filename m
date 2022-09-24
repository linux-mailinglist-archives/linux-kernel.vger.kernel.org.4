Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B846C5E874A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIXCMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIXCMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:12:19 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B64F12207C;
        Fri, 23 Sep 2022 19:12:17 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28O2Bfdm025412;
        Sat, 24 Sep 2022 11:11:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28O2Bfdm025412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663985502;
        bh=6Hlf2BvYbfxejRTXIBzKxD5+iCaELXc5Klin1gIOowA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0FxiNVchwhMG7OoeeuUC4sjth4/B8/53u9Ta0LjiAnXtnajvaH+wRBXoGeZbVoz08
         xrcEPa4vdfGOQ5k/6LY7/rHLO277jwqWt3KwRAC/ucwgboie8Bw5O3eSoa+ngC2XlA
         ZFX3wNYtmGTLqPyBvMOoSZYq2jUt/32/O0TtQ1kFdq+S/aDBGZDzeMP5Q3iMNHLBD/
         1yEudmXreQLBI7UpH+PpNUOUjZJOD4gdlM/FcthSTshf1BZt8k0TERkkBYyn+pDJfC
         rSDH/+M2GmX0sfNlFvmHSE8wVcSjqtfCOC5qMui4ju5pt+pRdUlyhQxOdpmdnnpDKo
         goMZN+iTxVtPA==
X-Nifty-SrcIP: [209.85.210.43]
Received: by mail-ot1-f43.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso1114182otb.6;
        Fri, 23 Sep 2022 19:11:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ynHYrgtWRPfkRhiqrTlXVSg/EbcTgeu9jPr+fgNMq9M4hordd
        xodMX3CnG2qwcaIj2oMUXuKTmhE00myUrF6lrdU=
X-Google-Smtp-Source: AMsMyM4fQFXNfqWNA0dWKe0+VAyxV57dVXqCA0y7qQ45RqDQPhjwPVUwoNjHtHoP6cJpgKdvxXJS6ymTPe05QlOFasQ=
X-Received: by 2002:a05:6830:658b:b0:63b:3501:7167 with SMTP id
 cn11-20020a056830658b00b0063b35017167mr5425169otb.343.1663985500605; Fri, 23
 Sep 2022 19:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919174547.3730737-1-ndesaulniers@google.com>
In-Reply-To: <20220919174547.3730737-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 24 Sep 2022 11:11:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5xSQTjDuu+dsNW2fOz1-s7x0gsCLmfQOnGpb5CY06KA@mail.gmail.com>
Message-ID: <CAK7LNAS5xSQTjDuu+dsNW2fOz1-s7x0gsCLmfQOnGpb5CY06KA@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.debug: re-enable debug info for .S files
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 2:45 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Alexey reported that the fraction of unknown filename instances in
> kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
> to assembler defined symbols, which regressed as a result of:
>
> commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
>
> In that commit, I allude to restoring debug info for assembler defined
> symbols in a follow up patch, but it seems I forgot to do so in
>
> commit a66049e2cf0e ("Kbuild: make DWARF version a choice")
>
> Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> Reported-by: Alexey Alexandrov <aalexand@google.com>
> Reported-by: Bill Wendling <morbo@google.com>
> Reported-by: Greg Thelen <gthelen@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v3 -> v4:
> * Break out into its own patch.
> * Move addition of debug-flags-y to DEBUG_CFLAGS and KBUILD_AFLAGS up
>   grouping the -gdwarf-* handling together.
>
>  lib/Kconfig.debug      |  4 +++-
>  scripts/Makefile.debug | 18 +++++++++---------
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index bcbe60d6c80c..d3e5f36bb01e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -264,8 +264,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  config DEBUG_INFO_DWARF4
>         bool "Generate DWARF Version 4 debuginfo"
>         select DEBUG_INFO
> +       depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
>         help
> -         Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> +         Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
> +         if using clang without clang's integrated assembler, and gdb 7.0+.
>
>           If you have consumers of DWARF debug info that are not ready for
>           newer revisions of DWARF, you may wish to choose this or have your
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 26d6a9d97a20..d6aecd78b942 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -4,15 +4,15 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS   += -gsplit-dwarf
>  endif
>
> -ifndef CONFIG_AS_IS_LLVM
> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> -endif
> -
> -ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> -dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> -dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> -DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> +debug-flags-$(CONFIG_DEBUG_INFO_DWARF4)        += -gdwarf-4
> +debug-flags-$(CONFIG_DEBUG_INFO_DWARF5)        += -gdwarf-5
> +ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_AS_IS_GNU),yy)
> +# Clang does not pass -g or -gdwarf-* option down to GAS.




This patch still misses the debug info for *.S files
for the combination of LLVM_IAS=0 and
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
because, as the comment says, Clang does not pass -g down to GAS.


With "[v4] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT"
and this one applied,



$ grep CONFIG_DEBUG_INFO_DWARF .config
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
$ make LLVM=1 LLVM_IAS=0 arch/x86/kernel/irqflags.o
  SYNC    include/config/auto.conf.cmd
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  HOSTCC  arch/x86/tools/relocs_32.o
  [snip]
  AS      arch/x86/kernel/irqflags.o
$ objdump  -h arch/x86/kernel/irqflags.o | grep debug
$








I think the following fix-up is needed on top.




diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index d6aecd78b942..8cf1cb22dd93 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -1,4 +1,5 @@
-DEBUG_CFLAGS   := -g
+DEBUG_CFLAGS   :=
+debug-flags-y  := -g

 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS   += -gsplit-dwarf




Then, I can see the debug sections.



$ make LLVM=1 LLVM_IAS=0 arch/x86/kernel/irqflags.o
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  AS      arch/x86/kernel/irqflags.o
$ objdump -h arch/x86/kernel/irqflags.o | grep debug
  6 .debug_line   00000050  0000000000000000  0000000000000000  0000008f  2**0
  7 .debug_info   0000002e  0000000000000000  0000000000000000  000000f8  2**0
  8 .debug_abbrev 00000014  0000000000000000  0000000000000000  000001d0  2**0
  9 .debug_aranges 00000030  0000000000000000  0000000000000000  000001f0  2**4
 10 .debug_str    0000004d  0000000000000000  0000000000000000  00000250  2**0





If you agree, I can locally fix it up as such.





--
Best Regards
Masahiro Yamada
