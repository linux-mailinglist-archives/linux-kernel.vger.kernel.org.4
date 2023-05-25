Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881771136D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbjEYSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbjEYSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:15:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A612C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:15:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6239b45765eso394496d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685038508; x=1687630508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kORQ0kxylD+klUh/XfQrf70Rnqtt8Miucoug0od39Y=;
        b=E2IP6ni6Boo1i7RjjUBxNRcKeMwjtNobW6oMTFW4oTBCuUCdzHqBmpLfgEvnLtrF9+
         4yIowtKbBszlWWlNiqFclH6M7Odrm8haG4yHelabqAP1ZLJJs8PVgoFIdCbxJE37YHfo
         eyo8ocgxDWmTkfQhOCGs6hsVsVP1kyQPMJsmMBlnT/xHlU1VUTrmcPolceA0y5SnPYRP
         hJ8ohvbBYe7XMzMNQapefIX/QmkobOGdZ3Jf2YvAZ06PaLoTLQ6Rb6NJA1fh6TtyaBQ0
         0PGDmjh7umg1eEv9Ya8ctggQiCHVkSSiV/L8vgBDnjtxjCh8LQX5+6TUMS7WYiZxPMNA
         nOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038508; x=1687630508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kORQ0kxylD+klUh/XfQrf70Rnqtt8Miucoug0od39Y=;
        b=QRW33qKpWPXwG07Kz6xNuOPvcgwwPx7XNRDeVQTbZlTj9c56HQZlK0bhKgeyIqQZC7
         zkPrKj415FlbOngTKEikX4P69EGDJzZOFdXmyvxDjldT5q0c7cUxPELtHbkI0CdXhYpf
         usxm+a8mG5AVN8iNA7mwmTXqlQSCQZVCEk3Vw98S6PJY8mmqfFVvkh2x6vmEVxU+HMG1
         RxtIhaKkn9u7l1Ef2nJQ3agA+IbzTLNaxARsWrndFMUT+xI5pP6a3S9LiXgpVUBcDVw8
         wUgE0bZiLTL4B9GOlxLCvINy7ANh42Q9/C95MN/eMJCGezp3ObP2wpDwm7MGGptR7rj+
         qiYQ==
X-Gm-Message-State: AC+VfDx2ny/nQugmB8xkjCDXnKpWBPOughP5ajaVcB1VBezlcedq1Kk2
        DAHqE6N2QhuebsTVKJHlp5J0IjLHTrFF1K/L6wZkSw==
X-Google-Smtp-Source: ACHHUZ6rlhMG55IP7l3jgWhfEHpHr75y0ysIN+gjTiSddYUVrdniIw/u7dujQK06Fe5cJjEhoAw6BNykq7S5lgwBLBk=
X-Received: by 2002:ad4:5e8c:0:b0:625:af4b:415a with SMTP id
 jl12-20020ad45e8c000000b00625af4b415amr2557888qvb.19.1685038507822; Thu, 25
 May 2023 11:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-16-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-16-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 May 2023 11:14:56 -0700
Message-ID: <CAKwvOdmEAWdgvdbvVbUnbupP-j8W7hbr6-ajMbq7MwAZj98_Cg@mail.gmail.com>
Subject: Re: [PATCH v6 15/20] kbuild: implement CONFIG_TRIM_UNUSED_KSYMS
 without recursion
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
> the directory tree to determine which EXPORT_SYMBOL to trim. If an
> EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
> second traverse, where some source files are recompiled with their
> EXPORT_SYMBOL() tuned into a no-op.
>
> Linus stated negative opinions about this slowness in commits:
>
>  - 5cf0fd591f2e ("Kbuild: disable TRIM_UNUSED_KSYMS option")
>  - a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some guard=
ing")
>
> We can do this better now. The final data structures of EXPORT_SYMBOL
> are generated by the modpost stage, so modpost can selectively emit
> KSYMTAB entries that are really used by modules.
>
> Commit f73edc8951b2 ("kbuild: unify two modpost invocations") is another
> ground-work to do this in a one-pass algorithm. With the list of modules,
> modpost sets sym->used if it is used by a module. modpost emits KSYMTAB
> only for symbols with sym->used=3D=3Dtrue.
>
> BTW, Nicolas explained why the trimming was implemented with recursion:
>
>   https://lore.kernel.org/all/2o2rpn97-79nq-p7s2-nq5-8p83391473r@syhkavp.=
arg/
>
> Actually, we never achieved that level of optimization where the chain
> reaction of trimming comes into play because:
>
>  - CONFIG_LTO_CLANG cannot remove any unused symbols
>  - CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled only for vmlinux,
>    but not modules
>
> If deeper trimming is required, we need to revisit this, but I guess
> that is unlikely to happen.

I think this patch removes the only 2 references to
scripts/gen_autoksyms.sh in the tree. Can or should that be removed as
well?
The rest of the patch LGTM.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v5:
>   - Clean up more
>
>  .gitignore                  |  1 -
>  Makefile                    | 19 +---------
>  include/linux/export.h      | 65 +++++----------------------------
>  scripts/Makefile.build      |  7 ----
>  scripts/Makefile.modpost    |  7 ++++
>  scripts/adjust_autoksyms.sh | 73 -------------------------------------
>  scripts/basic/fixdep.c      |  3 +-
>  scripts/gen_ksymdeps.sh     | 30 ---------------
>  scripts/mod/modpost.c       | 54 ++++++++++++++++++++++++---
>  scripts/remove-stale-files  |  2 +
>  10 files changed, 70 insertions(+), 191 deletions(-)
>  delete mode 100755 scripts/adjust_autoksyms.sh
>  delete mode 100755 scripts/gen_ksymdeps.sh
>
> diff --git a/.gitignore b/.gitignore
> index 7f86e0837909..172e3874adfd 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -112,7 +112,6 @@ modules.order
>  #
>  /include/config/
>  /include/generated/
> -/include/ksym/
>  /arch/*/include/generated/
>
>  # stgit generated dirs
> diff --git a/Makefile b/Makefile
> index f836936fb4d8..ffc2c9b632fd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1193,28 +1193,13 @@ endif
>  export KBUILD_VMLINUX_LIBS
>  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
>
> -# Recurse until adjust_autoksyms.sh is satisfied
> -PHONY +=3D autoksyms_recursive
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
>  # For the kernel to actually contain only the needed exported symbols,
>  # we have to build modules as well to determine what those symbols are.
>  # (this can be evaluated only once include/config/auto.conf has been inc=
luded)
>  KBUILD_MODULES :=3D 1
> -
> -autoksyms_recursive: $(build-dir) modules.order
> -       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
> -         "$(MAKE) -f $(srctree)/Makefile autoksyms_recursive"
>  endif
>
> -autoksyms_h :=3D $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/aut=
oksyms.h)
> -
> -quiet_cmd_autoksyms_h =3D GEN     $@
> -      cmd_autoksyms_h =3D mkdir -p $(dir $@); \
> -                       $(CONFIG_SHELL) $(srctree)/scripts/gen_autoksyms.=
sh $@
> -
> -$(autoksyms_h):
> -       $(call cmd,autoksyms_h)
> -
>  # '$(AR) mPi' needs 'T' to workaround the bug of llvm-ar <=3D 14
>  quiet_cmd_ar_vmlinux.a =3D AR      $@
>        cmd_ar_vmlinux.a =3D \
> @@ -1223,7 +1208,7 @@ quiet_cmd_ar_vmlinux.a =3D AR      $@
>         $(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F =
-f $(srctree)/scripts/head-object-list.txt)
>
>  targets +=3D vmlinux.a
> -vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms=
_recursive FORCE
> +vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt FORCE
>         $(call if_changed,ar_vmlinux.a)
>
>  PHONY +=3D vmlinux_o
> @@ -1279,7 +1264,7 @@ scripts: scripts_basic scripts_dtc
>  PHONY +=3D prepare archprepare
>
>  archprepare: outputmakefile archheaders archscripts scripts include/conf=
ig/kernel.release \
> -       asm-generic $(version_h) $(autoksyms_h) include/generated/utsrele=
ase.h \
> +       asm-generic $(version_h) include/generated/utsrelease.h \
>         include/generated/compile.h include/generated/autoconf.h remove-s=
tale-files
>
>  prepare0: archprepare
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 32461a01608c..9bf081ff9903 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -37,30 +37,13 @@ extern struct module __this_module;
>  #define __EXPORT_SYMBOL_REF(sym)       .balign 4; .long sym
>  #endif
>
> -#define ____EXPORT_SYMBOL(sym, license, ns)                    \
> +#define ___EXPORT_SYMBOL(sym, license, ns)                     \
>         .section ".export_symbol","a" ;                         \
>         __export_symbol_##license##_##sym: ;                    \
>         .asciz ns ;                                             \
>         __EXPORT_SYMBOL_REF(sym) ;                              \
>         .previous
>
> -#ifdef __GENKSYMS__
> -
> -#define ___EXPORT_SYMBOL(sym, sec, ns) __GENKSYMS_EXPORT_SYMBOL(sym)
> -
> -#elif defined(__ASSEMBLY__)
> -
> -#define ___EXPORT_SYMBOL(sym, license, ns) \
> -       ____EXPORT_SYMBOL(sym, license, ns)
> -
> -#else
> -
> -#define ___EXPORT_SYMBOL(sym, license, ns)                     \
> -       __ADDRESSABLE(sym)                                      \
> -       asm(__stringify(____EXPORT_SYMBOL(sym, license, ns)))
> -
> -#endif
> -
>  #if !defined(CONFIG_MODULES) || defined(__DISABLE_EXPORTS)
>
>  /*
> @@ -70,50 +53,20 @@ extern struct module __this_module;
>   */
>  #define __EXPORT_SYMBOL(sym, sec, ns)
>
> -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> +#elif defined(__GENKSYMS__)
>
> -#include <generated/autoksyms.h>
> +#define __EXPORT_SYMBOL(sym, sec, ns)  __GENKSYMS_EXPORT_SYMBOL(sym)
>
> -/*
> - * For fine grained build dependencies, we want to tell the build system
> - * about each possible exported symbol even if they're not actually expo=
rted.
> - * We use a symbol pattern __ksym_marker_<symbol> that the build system =
filters
> - * from the $(NM) output (see scripts/gen_ksymdeps.sh). These symbols ar=
e
> - * discarded in the final link stage.
> - */
> +#elif defined(__ASSEMBLY__)
>
> -#ifdef __ASSEMBLY__
> -
> -#define __ksym_marker(sym)                                     \
> -       .section ".discard.ksym","a" ;                          \
> -__ksym_marker_##sym: ;                                         \
> -       .previous
> +#define __EXPORT_SYMBOL(sym, license, ns) \
> +       ___EXPORT_SYMBOL(sym, license, ns)
>
>  #else
>
> -#define __ksym_marker(sym)     \
> -       static int __ksym_marker_##sym[0] __section(".discard.ksym") __us=
ed
> -
> -#endif
> -
> -#define __EXPORT_SYMBOL(sym, sec, ns)                                  \
> -       __ksym_marker(sym);                                             \
> -       __cond_export_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
> -#define __cond_export_sym(sym, sec, ns, conf)                          \
> -       ___cond_export_sym(sym, sec, ns, conf)
> -#define ___cond_export_sym(sym, sec, ns, enabled)                      \
> -       __cond_export_sym_##enabled(sym, sec, ns)
> -#define __cond_export_sym_1(sym, sec, ns) ___EXPORT_SYMBOL(sym, sec, ns)
> -
> -#ifdef __GENKSYMS__
> -#define __cond_export_sym_0(sym, sec, ns) __GENKSYMS_EXPORT_SYMBOL(sym)
> -#else
> -#define __cond_export_sym_0(sym, sec, ns) /* nothing */
> -#endif
> -
> -#else
> -
> -#define __EXPORT_SYMBOL(sym, sec, ns)  ___EXPORT_SYMBOL(sym, sec, ns)
> +#define __EXPORT_SYMBOL(sym, license, ns)                      \
> +       __ADDRESSABLE(sym)                                      \
> +       asm(__stringify(___EXPORT_SYMBOL(sym, license, ns)))
>
>  #endif /* CONFIG_MODULES */
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index bd4123795299..8154bd962eea 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -215,18 +215,12 @@ is-standard-object =3D $(if $(filter-out y%, $(OBJE=
CT_FILES_NON_STANDARD_$(basetar
>
>  $(obj)/%.o: objtool-enabled =3D $(if $(is-standard-object),$(if $(delay-=
objtool),$(is-single-obj-m),y))
>
> -ifdef CONFIG_TRIM_UNUSED_KSYMS
> -cmd_gen_ksymdeps =3D \
> -       $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-ta=
rget).cmd
> -endif
> -
>  ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
>  cmd_warn_shared_object =3D $(if $(word 2, $(modname-multi)),$(warning $(=
kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
>  endif
>
>  define rule_cc_o_c
>         $(call cmd_and_fixdep,cc_o_c)
> -       $(call cmd,gen_ksymdeps)
>         $(call cmd,checksrc)
>         $(call cmd,checkdoc)
>         $(call cmd,gen_objtooldep)
> @@ -237,7 +231,6 @@ endef
>
>  define rule_as_o_S
>         $(call cmd_and_fixdep,as_o_S)
> -       $(call cmd,gen_ksymdeps)
>         $(call cmd,gen_objtooldep)
>         $(call cmd,gen_symversions_S)
>         $(call cmd,warn_shared_object)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 0980c58d8afc..1e0b47cbabd9 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -90,6 +90,13 @@ targets +=3D .vmlinux.objs
>  .vmlinux.objs: vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
>         $(call if_changed,vmlinux_objs)
>
> +ifdef CONFIG_TRIM_UNUSED_KSYMS
> +ksym-wl :=3D $(CONFIG_UNUSED_KSYMS_WHITELIST)
> +ksym-wl :=3D $(if $(filter-out /%, $(ksym-wl)),$(srctree)/)$(ksym-wl)
> +modpost-args +=3D -t $(addprefix -W, $(ksym-wl))
> +modpost-deps +=3D $(ksym-wl)
> +endif
> +
>  ifeq ($(wildcard vmlinux.o),)
>  missing-input :=3D vmlinux.o
>  output-symdump :=3D modules-only.symvers
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> deleted file mode 100755
> index f1b5ac818411..000000000000
> --- a/scripts/adjust_autoksyms.sh
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-only
> -
> -# Script to update include/generated/autoksyms.h and dependency files
> -#
> -# Copyright:   (C) 2016  Linaro Limited
> -# Created by:  Nicolas Pitre, January 2016
> -#
> -
> -# Update the include/generated/autoksyms.h file.
> -#
> -# For each symbol being added or removed, the corresponding dependency
> -# file's timestamp is updated to force a rebuild of the affected source
> -# file. All arguments passed to this script are assumed to be a command
> -# to be exec'd to trigger a rebuild of those files.
> -
> -set -e
> -
> -cur_ksyms_file=3D"include/generated/autoksyms.h"
> -new_ksyms_file=3D"include/generated/autoksyms.h.tmpnew"
> -
> -info() {
> -       if [ "$quiet" !=3D "silent_" ]; then
> -               printf "  %-7s %s\n" "$1" "$2"
> -       fi
> -}
> -
> -info "CHK" "$cur_ksyms_file"
> -
> -# Use "make V=3D1" to debug this script.
> -case "$KBUILD_VERBOSE" in
> -*1*)
> -       set -x
> -       ;;
> -esac
> -
> -# Generate a new symbol list file
> -$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh --modorder "$new_ksyms_f=
ile"
> -
> -# Extract changes between old and new list and touch corresponding
> -# dependency files.
> -changed=3D$(
> -count=3D0
> -sort "$cur_ksyms_file" "$new_ksyms_file" | uniq -u |
> -sed -n 's/^#define __KSYM_\(.*\) 1/\1/p' |
> -while read sympath; do
> -       if [ -z "$sympath" ]; then continue; fi
> -       depfile=3D"include/ksym/${sympath}"
> -       mkdir -p "$(dirname "$depfile")"
> -       touch "$depfile"
> -       # Filesystems with coarse time precision may create timestamps
> -       # equal to the one from a file that was very recently built and t=
hat
> -       # needs to be rebuild. Let's guard against that by making sure ou=
r
> -       # dep files are always newer than the first file we created here.
> -       while [ ! "$depfile" -nt "$new_ksyms_file" ]; do
> -               touch "$depfile"
> -       done
> -       echo $((count +=3D 1))
> -done | tail -1 )
> -changed=3D${changed:-0}
> -
> -if [ $changed -gt 0 ]; then
> -       # Replace the old list with tne new one
> -       old=3D$(grep -c "^#define __KSYM_" "$cur_ksyms_file" || true)
> -       new=3D$(grep -c "^#define __KSYM_" "$new_ksyms_file" || true)
> -       info "KSYMS" "symbols: before=3D$old, after=3D$new, changed=3D$ch=
anged"
> -       info "UPD" "$cur_ksyms_file"
> -       mv -f "$new_ksyms_file" "$cur_ksyms_file"
> -       # Then trigger a rebuild of affected source files
> -       exec $@
> -else
> -       rm -f "$new_ksyms_file"
> -fi
> diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> index fa562806c2be..84b6efa849f4 100644
> --- a/scripts/basic/fixdep.c
> +++ b/scripts/basic/fixdep.c
> @@ -246,8 +246,7 @@ static void *read_file(const char *filename)
>  /* Ignore certain dependencies */
>  static int is_ignored_file(const char *s, int len)
>  {
> -       return str_ends_with(s, len, "include/generated/autoconf.h") ||
> -              str_ends_with(s, len, "include/generated/autoksyms.h");
> +       return str_ends_with(s, len, "include/generated/autoconf.h");
>  }
>
>  /* Do not parse these files */
> diff --git a/scripts/gen_ksymdeps.sh b/scripts/gen_ksymdeps.sh
> deleted file mode 100755
> index 8ee533f33659..000000000000
> --- a/scripts/gen_ksymdeps.sh
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -set -e
> -
> -# List of exported symbols
> -#
> -# If the object has no symbol, $NM warns 'no symbols'.
> -# Suppress the stderr.
> -# TODO:
> -#   Use -q instead of 2>/dev/null when we upgrade the minimum version of
> -#   binutils to 2.37, llvm to 13.0.0.
> -ksyms=3D$($NM $1 2>/dev/null | sed -n 's/.*__ksym_marker_\(.*\)/\1/p')
> -
> -if [ -z "$ksyms" ]; then
> -       exit 0
> -fi
> -
> -echo
> -echo "ksymdeps_$1 :=3D \\"
> -
> -for s in $ksyms
> -do
> -       printf '    $(wildcard include/ksym/%s) \\\n' "$s"
> -done
> -
> -echo
> -echo "$1: \$(ksymdeps_$1)"
> -echo
> -echo "\$(ksymdeps_$1):"
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index f14fe9301ae6..516323c3910a 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -35,6 +35,9 @@ static bool warn_unresolved;
>
>  static int sec_mismatch_count;
>  static bool sec_mismatch_warn_only =3D true;
> +/* Trim EXPORT_SYMBOLs that are unused by in-tree modules */
> +static bool trim_unused_exports;
> +
>  /* ignore missing files */
>  static bool ignore_missing_files;
>  /* If set to 1, only warn (instead of error) about missing ns imports */
> @@ -217,6 +220,7 @@ struct symbol {
>         bool weak;
>         bool is_func;
>         bool is_gpl_only;       /* exported by EXPORT_SYMBOL_GPL */
> +       bool used;              /* there exists a user of this symbol */
>         char name[];
>  };
>
> @@ -1772,6 +1776,7 @@ static void check_exports(struct module *mod)
>                         continue;
>                 }
>
> +               exp->used =3D true;
>                 s->module =3D exp->module;
>                 s->crc_valid =3D exp->crc_valid;
>                 s->crc =3D exp->crc;
> @@ -1795,6 +1800,23 @@ static void check_exports(struct module *mod)
>         }
>  }
>
> +static void handle_white_list_exports(const char *white_list)
> +{
> +       char *buf, *p, *name;
> +
> +       buf =3D read_text_file(white_list);
> +       p =3D buf;
> +
> +       while ((name =3D strsep(&p, "\n"))) {
> +               struct symbol *sym =3D find_symbol(name);
> +
> +               if (sym)
> +                       sym->used =3D true;
> +       }
> +
> +       free(buf);
> +}
> +
>  static void check_modname_len(struct module *mod)
>  {
>         const char *mod_name;
> @@ -1865,10 +1887,14 @@ static void add_exported_symbols(struct buffer *b=
uf, struct module *mod)
>
>         /* generate struct for exported symbols */
>         buf_printf(buf, "\n");
> -       list_for_each_entry(sym, &mod->exported_symbols, list)
> +       list_for_each_entry(sym, &mod->exported_symbols, list) {
> +               if (trim_unused_exports && !sym->used)
> +                       continue;
> +
>                 buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
>                            sym->is_func ? "FUNC" : "DATA", sym->name,
>                            sym->is_gpl_only ? "_gpl" : "", sym->namespace=
);
> +       }
>
>         if (!modversions)
>                 return;
> @@ -1876,6 +1902,9 @@ static void add_exported_symbols(struct buffer *buf=
, struct module *mod)
>         /* record CRCs for exported symbols */
>         buf_printf(buf, "\n");
>         list_for_each_entry(sym, &mod->exported_symbols, list) {
> +               if (trim_unused_exports && !sym->used)
> +                       continue;
> +
>                 if (!sym->crc_valid)
>                         warn("EXPORT symbol \"%s\" [%s%s] version generat=
ion failed, symbol will not be versioned.\n"
>                              "Is \"%s\" prototyped in <asm/asm-prototypes=
.h>?\n",
> @@ -2039,9 +2068,6 @@ static void write_mod_c_file(struct module *mod)
>         char fname[PATH_MAX];
>         int ret;
>
> -       check_modname_len(mod);
> -       check_exports(mod);
> -
>         add_header(&buf, mod);
>         add_exported_symbols(&buf, mod);
>         add_versions(&buf, mod);
> @@ -2175,12 +2201,13 @@ int main(int argc, char **argv)
>  {
>         struct module *mod;
>         char *missing_namespace_deps =3D NULL;
> +       char *unused_exports_white_list =3D NULL;
>         char *dump_write =3D NULL, *files_source =3D NULL;
>         int opt;
>         LIST_HEAD(dump_lists);
>         struct dump_list *dl, *dl2;
>
> -       while ((opt =3D getopt(argc, argv, "ei:mnT:o:awENd:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "ei:mntT:tW:o:awENd:")) !=3D -=
1) {
>                 switch (opt) {
>                 case 'e':
>                         external_module =3D true;
> @@ -2205,6 +2232,12 @@ int main(int argc, char **argv)
>                 case 'T':
>                         files_source =3D optarg;
>                         break;
> +               case 't':
> +                       trim_unused_exports =3D true;
> +                       break;
> +               case 'W':
> +                       unused_exports_white_list =3D optarg;
> +                       break;
>                 case 'w':
>                         warn_unresolved =3D true;
>                         break;
> @@ -2234,6 +2267,17 @@ int main(int argc, char **argv)
>         if (files_source)
>                 read_symbols_from_files(files_source);
>
> +       list_for_each_entry(mod, &modules, list) {
> +               if (mod->from_dump || mod->is_vmlinux)
> +                       continue;
> +
> +               check_modname_len(mod);
> +               check_exports(mod);
> +       }
> +
> +       if (unused_exports_white_list)
> +               handle_white_list_exports(unused_exports_white_list);
> +
>         list_for_each_entry(mod, &modules, list) {
>                 if (mod->from_dump)
>                         continue;
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index 7f432900671a..8502a17d47df 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -33,3 +33,5 @@ rm -f rust/target.json
>  rm -f scripts/bin2c
>
>  rm -f .scmversion
> +
> +rm -rf include/ksym
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
