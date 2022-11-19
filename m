Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8D630BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 05:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKSEz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 23:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiKSEzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:55:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3222BA593
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:55:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3317760A0B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B5C4347C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668833720;
        bh=FWTQg1pMn1zoXjBhI3Oc+0x9wI/eH+gfle52gN1Vz08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lzt/x88aEOVDhrXosD7AQZ6LyUoIMvReP0aHrpOdk6BDSRbO+PxeVaYSUNK2Sa8Ah
         geq16iBW2jzgpd3rdBISjuKG6TAjHf8kgKvSYd5nflh1/ak8d9e8ZsYXH3V8WesZjE
         v+5CKVtLD/LBIW0cPr0TnSlDK/SisMP4wxtWUL0fiID7j6vP545KJMzEfaUD5Nynbt
         oqYlUAUfyNMHwV/oObssNVKeCSQPYhxBp0xbM/zs6koJ0Tm+/cA0kqUjyDHcWFgbOx
         PkxvO432xiStDZ6kaOpl/grbtWX6q7YptiMqlIqi9rkOIBEQl5owbc+nORjRLyYqNd
         GQIjzIVldSf8w==
Received: by mail-ed1-f53.google.com with SMTP id v17so9722516edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:55:20 -0800 (PST)
X-Gm-Message-State: ANoB5pn4YebeW+C3/2eeRu4aK70V5YBVqP+uJ4rNbWkqlA/5+twJ1v2k
        LWjNvWFLgN9HuAtz/AmvWShENcRdARXjW7+B9yc=
X-Google-Smtp-Source: AA0mqf6vESNiZK1hg9EvtRH5CNItebjZaMvWg4meVQ/Uu1xL3UdAOY5rd1r11JIbrI3+TW4wHj1dNo//J06bD0qKNv4=
X-Received: by 2002:a05:6402:5003:b0:462:a25f:f0f2 with SMTP id
 p3-20020a056402500300b00462a25ff0f2mr8632014eda.156.1668833718733; Fri, 18
 Nov 2022 20:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20221116082338.5145-1-zhangqing@loongson.cn>
In-Reply-To: <20221116082338.5145-1-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 19 Nov 2022 12:55:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qOW_qw3wD0bdO9P8sCYAoLUHcPS1rpVfMsS36RSX_ZQ@mail.gmail.com>
Message-ID: <CAAhV-H4qOW_qw3wD0bdO9P8sCYAoLUHcPS1rpVfMsS36RSX_ZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 0/9] LoongArch: Add ftrace support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

I have applied this series to
https://github.com/loongson/linux/commits/loongarch-next with some
slight modifications, please test that branch to see if everything is
correct.

Huacai

On Wed, Nov 16, 2022 at 4:23 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> This patch series to support basic and dynamic ftrace.
>
> 1) -pg
> Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
> Thus, it can be seen store RA and open stack before `call _mcount`.
> Find `open stack` at first, and then find `store RA`.
>
> 2) -fpatchable-function-entry=2
> The compiler has inserted 2 NOPs before the regular function prologue.
> T series registers are available and safe because of LoongArch psABI.
>
> At runtime, replace nop with bl to enable ftrace call and replace bl with
> nop to disable ftrace call. The bl requires us to save the original RA value,
> so here it saves RA at t0.
> details are:
>
> | Compiled   |       Disabled         |        Enabled         |
> +------------+------------------------+------------------------+
> | nop        | move     t0, ra        | move     t0, ra        |
> | nop        | nop                    | bl      ftrace_caller  |
> | func_body  | func_body              | func_body              |
>
> The RA value will be recovered by ftrace_regs_entry, and restored into RA
> before returning to the regular function prologue. When a function is not
> being traced, the move t0, ra is not harmful.
>
> performs a series of startup tests on ftrace and The test cases in selftests
> has passed on LoongArch.
>
> Changes in v2:
>  - Remove patch "LoongArch: ftrace: Add CALLER_ADDRx macros" there are other
>    better ways
>  Suggested by Steve:
>  - Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support (6/10)
>  Suggested by Jinyang:
>  - Change addu16id to lu12iw and Adjust module_finalize return value (7/10)
>  - Use the "jr" pseudo-instruction where applicable (1/10)
>  - Use the "la.pcrel" instead of "la" (3/10)
>
> Changes in v3:
>  Reported by Jeff:
>  - Fix unwind state when option func_stack_trace (10/10)
>
> Changes in v4:
>  - No comments. Just resend the series.
>  - Rebased onto v6.0.0-rc4.
>
> Changes in v5:
>  - Modify the indentation of Kconfig and small changes
>
> Changes in v6:
>  Suggested by Huacai:
>  - Adjusting the patch Sequence
>  - renamed mcount-dyn.S for consistency
>
> Changes in v7:
>  - delete redefinition
>
> Changes in v8:
>  - remove useless macro judgment and modify the return location
>  - move some code to Patch-3
>
> Qing Zhang (9):
>   LoongArch/ftrace: Add basic support
>   LoongArch/ftrace: Add recordmcount support
>   LoongArch/ftrace: Add dynamic function tracer support
>   LoongArch/ftrace: Add dynamic function graph tracer support
>   LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_REGS support
>   LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support
>   LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
>   LoongArch: modules/ftrace: Initialize PLT at load time
>   LoongArch: Enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS
>
>  arch/loongarch/Kconfig                     |   7 +
>  arch/loongarch/Makefile                    |   5 +
>  arch/loongarch/configs/loongson3_defconfig |   2 +
>  arch/loongarch/include/asm/ftrace.h        |  59 +++++
>  arch/loongarch/include/asm/inst.h          |  15 ++
>  arch/loongarch/include/asm/module.h        |   5 +-
>  arch/loongarch/include/asm/module.lds.h    |   1 +
>  arch/loongarch/include/asm/unwind.h        |   3 +-
>  arch/loongarch/kernel/Makefile             |  13 +
>  arch/loongarch/kernel/ftrace.c             |  74 ++++++
>  arch/loongarch/kernel/ftrace_dyn.c         | 264 +++++++++++++++++++++
>  arch/loongarch/kernel/inst.c               | 127 ++++++++++
>  arch/loongarch/kernel/mcount.S             |  94 ++++++++
>  arch/loongarch/kernel/mcount_dyn.S         | 154 ++++++++++++
>  arch/loongarch/kernel/module-sections.c    |  11 +
>  arch/loongarch/kernel/module.c             |  21 ++
>  arch/loongarch/kernel/unwind_guess.c       |   4 +-
>  arch/loongarch/kernel/unwind_prologue.c    |  46 +++-
>  scripts/recordmcount.c                     |  23 ++
>  19 files changed, 918 insertions(+), 10 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/ftrace.h
>  create mode 100644 arch/loongarch/kernel/ftrace.c
>  create mode 100644 arch/loongarch/kernel/ftrace_dyn.c
>  create mode 100644 arch/loongarch/kernel/mcount.S
>  create mode 100644 arch/loongarch/kernel/mcount_dyn.S
>
> --
> 2.36.0
>
>
