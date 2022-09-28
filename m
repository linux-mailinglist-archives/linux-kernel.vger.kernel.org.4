Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE845EE82F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiI1VSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiI1VSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:18:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569C76752
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:13:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z20so5888945plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v0k9ORqQb3RbZ04b8VgsYD7iTc3Y46CtHEmVrhJH2aA=;
        b=fDfRgrlfSwRvlwVBa7jPlMJDqaCg6wsEHOT7OqSyBKAwnbZk6dz9cP4cMffi0sp/Yg
         fypu2QW/qpEFEenbak6VjgyLvGsb45/wHZrOWfvj5mMxNp1NiOt62JtWip07ZAcQNBSX
         SPhKDIg/NI9KoQR2FwaZ6LlP9suMPm8BiBT9Ernxw8IpwhJ5SD34AEJT0yOKm8xlcoVe
         eUhZ1K5yQOPppu8f6js57n9XanNs8w844SysHgQWa3uTQTP26mMUvEE1lwd0wHXyqvk5
         yndOqptt7kEva4tqdWYz7DIS8xize+NdLxGSKJkvw/Ft8LmNvbchLTmnH7x9fLvQz8Qx
         gZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v0k9ORqQb3RbZ04b8VgsYD7iTc3Y46CtHEmVrhJH2aA=;
        b=cu3l76j/+UoT97ZTZMti7GcIbMskP0rL/VAZ4wsA/rCU4boDFZc58nQ3vMAV/+05IT
         GNpXD5NjabYHcKdwD8OduRx9J4D2KgVVyRoAC1ZzFoiCF3R0rkXd8MMEr2D7Aih7+xy9
         TBjlZdVa/FjnrN8aVoNCRtX3ppa4BvOGIO3Hn12AZWHEfi+2yGR8DUCrfKbMkpJJboZj
         lpH+tVxasC9vmnu/G1yyjk1wbb76AiS/lI4v58t7kGybZKGwyv66ErHqC86Siniku9bO
         A2fJCEODIRQDDnQ44614JsUWO2cFvApjDnZFKpqsJfAnnESG06XKliNqrxTWJPIeBRG/
         M4xA==
X-Gm-Message-State: ACrzQf08uPprJe07nwWOlx9TBHqwijGl706EtCp6DMTGFpQdXWe1pGVJ
        oht9OEzIJe1iI9Lr7DQJo5NCSu9sA41XTfyGuY7Bvw==
X-Google-Smtp-Source: AMsMyM5UboqUpZNmThgqY9aypu7QDq6EQiZROsKNTuF1cWEnMhwu6Bc1VIOtQQrULDIr++MWCEcRuu19vGWr2u4E0Kk=
X-Received: by 2002:a17:90b:1d0f:b0:202:be3e:a14a with SMTP id
 on15-20020a17090b1d0f00b00202be3ea14amr12512808pjb.102.1664399639224; Wed, 28
 Sep 2022 14:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220928182523.3105953-1-nathan@kernel.org>
In-Reply-To: <20220928182523.3105953-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Sep 2022 14:13:47 -0700
Message-ID: <CAKwvOdmPLqX=oCwg43TYHj=tdoaU5OYc=bO906u=LeqcSrx+Dw@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
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

On Wed, Sep 28, 2022 at 11:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
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
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  lib/Kconfig.debug | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d3e5f36bb01e..19de03ead2ed 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -231,6 +231,9 @@ config DEBUG_INFO
>           in the "Debug information" choice below, indicating that debug
>           information will be generated for build targets.
>
> +config AS_HAS_NON_CONST_LEB128
> +       def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
> +
>  choice
>         prompt "Debug information"
>         depends on DEBUG_KERNEL
> @@ -277,6 +280,10 @@ config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
>         select DEBUG_INFO
>         depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +       # Clang is known to generate .{s,u}leb128 with symbol deltas with
> +       # DWARF5, which some targets may not support.
> +       # https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> +       depends on !CC_IS_CLANG || AS_HAS_NON_CONST_LEB128

Reraising my concern from
https://github.com/ClangBuiltLinux/linux/issues/1719#issuecomment-1258678969

We've put a fair amount of work into getting CC=clang LLVM_IAS=0 to
work for DWARF v5 (both on the GNU binutils side, and Kbuild), I'd
hate to see that effectively knee-capped because of an issue in GNU
binutils that is only relevant for one architecture.

I'd concede support for ARCH=riscv, but not for all other
architectures, which this effectively does.

>         help
>           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
>           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
>
> base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
> --
> 2.37.3
>
>


-- 
Thanks,
~Nick Desaulniers
