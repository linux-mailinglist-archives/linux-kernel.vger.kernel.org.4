Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6295FF598
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJNVwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:52:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA7186CD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:52:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pq16so6111542pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+V1yq5kutqjuC703osZedH3rmdy8U8JIzTiIx0RrC4=;
        b=nk+ppu6DZAbdjE0NaDIGVOIK4xC/wOk+IqBr0PnQsL96JO9Cwh8C5QM7ZtJQR2Sm4u
         ZJAEwsrYBL/agkUk4PrOSJPZx+FjRj+Ua535NVuQO+3m4dK/VJeFD+W9y8rT3zYVUtlH
         89D24IB+UaC8X9gvX59f+M/duyYgJA6Xrf+TfvpxmjN5HplOQQig/MEeQysG3VSHkmEr
         PWSexmvNPCx6Y6qjv0TSXERh6818GwgMx463xig3lGWS72V9oPljwTxH1UlIDrHxBSx0
         M+kINgtYCMJioajJP65SnSoeaURwMFUFq/NxHnp/uazNYt2K9s/crf6+Cos951bhdsUH
         DAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+V1yq5kutqjuC703osZedH3rmdy8U8JIzTiIx0RrC4=;
        b=xa1Us7vUV9BRVBb3Isy+IH2qEISSuGFkuyO/q/U9xnCWqIOTPUftkqk7mOcJBd01pD
         BR6TW9K++gwpg1iloqYYmyWN5xOSDl5Ps278/+n55N9H6JLfeOIbLH2aDPRsx+F6FUnl
         NE2lhUnslAA2n5N3TDHToyCc9Mkh1AZwd09whoMJ0ZeE9xDrT3MCfLR6u5mNqnOa32rW
         15vjUy5zQ+SrEeHMh6fKQvRunm9bGDCFc8fTlWaKMuuORMn9wXOXVIv5ZWlmkpr7/yHP
         l5Fevu/rzYK6fHzuQDzfLeIDcgyb6QyY0KskBAbjwo4lUz9cRB1pblbOwOZ9gF7OeoVA
         4wbA==
X-Gm-Message-State: ACrzQf3o6ePo+BoDS0rr03zmJd7g4J/vRjni0TjNJMn/yJKT3PleEBhE
        Z47DU7gzIQFf549cN0EKqPWCYtg3bLT8be3bwGsObg==
X-Google-Smtp-Source: AMsMyM4ibZr+rEpY29bo3KcS2btMSVY8Lobg4hRbJlHPqrOKhBqk+gVVAhOrbTPvX7M08QjdnH2iaOcaxvx+g1V5rMM=
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id
 t24-20020a170902b21800b00184710c8c52mr7304165plr.95.1665784323454; Fri, 14
 Oct 2022 14:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221014204210.383380-1-nathan@kernel.org>
In-Reply-To: <20221014204210.383380-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Oct 2022 14:51:51 -0700
Message-ID: <CAKwvOdmvqoO1220ac7RVbVzvmbJB0wYq5WOfuz=T8hd+CkijBg@mail.gmail.com>
Subject: Re: [PATCH v2] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 14, 2022 at 1:48 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building with a RISC-V kernel with DWARF5 debug info using clang
> and the GNU assembler, several instances of the following error appear:
>
>   /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported
>
> Dumping the .s file reveals these .uleb128 directives come from
> .debug_loc and .debug_ranges:
>
>   .Ldebug_loc0:
>           .byte   4                               # DW_LLE_offset_pair
>           .uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
>           .uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
>           .byte   1                               # Loc expr size
>           .byte   90                              # DW_OP_reg10
>           .byte   0                               # DW_LLE_end_of_list
>
>   .Ldebug_ranges0:
>           .byte   4                               # DW_RLE_offset_pair
>           .uleb128 .Ltmp6-.Lfunc_begin0           #   starting offset
>           .uleb128 .Ltmp27-.Lfunc_begin0          #   ending offset
>           .byte   4                               # DW_RLE_offset_pair
>           .uleb128 .Ltmp28-.Lfunc_begin0          #   starting offset
>           .uleb128 .Ltmp30-.Lfunc_begin0          #   ending offset
>           .byte   0                               # DW_RLE_end_of_list
>
> There is an outstanding binutils issue to support a non-constant operand
> to .sleb128 and .uleb128 in GAS for RISC-V but there does not appear to
> be any movement on it, due to concerns over how it would work with
> linker relaxation.
>
> To avoid these build errors, prevent DWARF5 from being selected when
> using clang and an assembler that does not have support for these symbol
> deltas, which can be easily checked in Kconfig with as-instr plus the
> small test program from the dwz test suite from the binutils issue.
>
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> Link: https://github.com/ClangBuiltLinux/linux/issues/1719
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for keeping these LLVM_IAS=0 builds alive a little longer.  My
hope is the GNU binutils can relax their requirement for debug info
sections to improve support for DWARF v5.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


> ---
>
> v2:
>     - Rebase on commit bb1435f3f575 ("Kconfig.debug: add toolchain
>       checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT") from the kbuild
>       tree.
>     - Limit CONFIG_AS_HAS_NON_CONST_LEB128 dependency to GNU as. There
>       is no point to applying this dependency to the integrated
>       assembler because it will always pass.
>     - Apply the CONFIG_AS_HAS_NON_CONST_LEB128 dependency to
>       CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as well, due to the
>       aforementioned kbuild change.
>     - Move comment block to above CONFIG_AS_HAS_NON_CONST_LEB128, as the
>       configuration is now used in two places.
>     - Drop Conor's tested by, as the patch is different enough to
>       potentially require new testing.
>
> v1: https://lore.kernel.org/20220928182523.3105953-1-nathan@kernel.org/
>
>  lib/Kconfig.debug | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index db8d9271cabf..5c1c63575895 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -231,6 +231,11 @@ config DEBUG_INFO
>           in the "Debug information" choice below, indicating that debug
>           information will be generated for build targets.
>
> +# Clang is known to generate .{s,u}leb128 with symbol deltas with DWARF5, which
> +# some targets may not support: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> +config AS_HAS_NON_CONST_LEB128
> +       def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
> +
>  choice
>         prompt "Debug information"
>         depends on DEBUG_KERNEL
> @@ -253,7 +258,7 @@ config DEBUG_INFO_NONE
>  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>         bool "Rely on the toolchain's implicit default DWARF version"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> +       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
>         help
>           The implicit default version of DWARF debug info produced by a
>           toolchain changes over time.
> @@ -277,7 +282,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
>         help
>           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
>           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
>
> base-commit: bb1435f3f575b5213eaf27434efa3971f51c01de
> --
> 2.38.0
>


--
Thanks,
~Nick Desaulniers
