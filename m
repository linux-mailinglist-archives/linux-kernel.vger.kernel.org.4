Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB075BF302
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUBoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiIUBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2871995;
        Tue, 20 Sep 2022 18:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB6E762EEC;
        Wed, 21 Sep 2022 01:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5ECC43145;
        Wed, 21 Sep 2022 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663724649;
        bh=a4MbeyDQ0cNKqjKPlY+9BYkCDy+gVjRncnZlwoiA8Uw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hPk4rLVaP1dvrnGGN/a3RnxHQUejYh7dooTCeIz3MG+8l6cv95S745Ks1PSoi1XQ8
         yK2g3x5E8WhOABaPVmbC5CBUbMy5Licj5ljtzI8TXD+WjBNDoEsi06z9Cl64hKASA+
         GhwivC1JRJ6oMxXDhqO8zH7Fsd6MoqhR3rehU0p1SV9XwUlvPgkgaExXDhej62QIP3
         2+E2/uiHmQdNuFJXrVvZY2rKwdCAMVfEiBCI3oQ6Jyy6VRWy047sTsnUjpSlQxqQrY
         9SEK6QZ93QxMf/r94qFOSMTduwpSxEbH0RnLrHFfIJcZoni/daMyKbwDUW3n08WXGI
         V8SwTrPjmdbdw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11e9a7135easo6992207fac.6;
        Tue, 20 Sep 2022 18:44:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf3+55zMsIvZtkW5AZaouuZT22iyO+XHkFBe4DK5/Oet8F0XuvDN
        8dUhrodw2gEN/Z6N9gao5bp4tN8zuqgQAY1NMc8=
X-Google-Smtp-Source: AMsMyM4d2nVe6tz0uQHzZD860Q0dajKQ1oPLYnVeebGVKCry3Aiz7sHwFGiJCCURnxU4pnGh56XEMrDZA8kfi2pRxTg=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr3618516oap.19.1663724648463; Tue, 20 Sep
 2022 18:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220920151202.180057-1-chenzhongjin@huawei.com> <20220920151202.180057-7-chenzhongjin@huawei.com>
In-Reply-To: <20220920151202.180057-7-chenzhongjin@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 09:43:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSQAzqLcJSp4B=8vPTb10+TieZXDJPAigCBgm5iVYpdTg@mail.gmail.com>
Message-ID: <CAJF2gTSQAzqLcJSp4B=8vPTb10+TieZXDJPAigCBgm5iVYpdTg@mail.gmail.com>
Subject: Re: [PATCH -next 6/7] riscv: stacktrace: Fix unwinding on ftrace_regs_call
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, nsaenzju@redhat.com, frederic@kernel.org,
        changbin.du@intel.com, vincent.chen@sifive.com, ardb@kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, keescook@chromium.org,
        catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 11:15 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> When unwinding on ftrace_regs_call, the traced function will be skipped
> because ftrace_regs_caller doesn't save the fp and ra.
>
> Save the encoded fp so that we can get the pt_regs so that we can unwind
> from ftrace_regs_call to the traced function.
>
> Also the pt_regs->status should be set as kernel mode.
>
> Stacktrace before this patch:
>
>  Call Trace:
>   ...
>   [<ffffffff0161a0e0>] handler_pre+0x30/0x4a [kprobe_unwind]
>   [<ffffffff800bce92>] aggr_pre_handler+0x60/0x94
>   [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
>   [<ffffffff80008e7e>] ftrace_regs_call+0x8/0x10
>   [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
>   [<ffffffff8008a4e6>] do_init_module+0x56/0x210
>  ...
>
> Stacktrace after this patch:
>
>  Call Trace:
>   ...
>   [<ffffffff016150e0>] handler_pre+0x30/0x4a [kprobe_unwind]
>   [<ffffffff800bce96>] aggr_pre_handler+0x60/0x94
>   [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
>   [<ffffffff80008e82>] ftrace_regs_call+0x8/0x10
> + [<ffffffff01615000>] empty_call+0x0/0x1e [kprobe_unwind]
>   [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
>   [<ffffffff8008a4ea>] do_init_module+0x56/0x210
>   ...
>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/riscv/kernel/mcount-dyn.S | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index d171eca623b6..56a4014c392f 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -10,6 +10,8 @@
>  #include <asm/asm-offsets.h>
>  #include <asm-generic/export.h>
>  #include <asm/ftrace.h>
> +#include <asm/frame.h>
> +#include <asm/csr.h>
>
>         .text
>
> @@ -97,6 +99,11 @@
>         REG_S x29, PT_T4(sp)
>         REG_S x30, PT_T5(sp)
>         REG_S x31, PT_T6(sp)
> +
> +#ifdef CONFIG_FRAME_POINTER
> +       li s0, SR_PP
> +       REG_S s0, PT_STATUS(sp)
Change another register.

> +#endif
>         .endm
>
>         .macro RESTORE_ALL
> @@ -172,6 +179,7 @@ ENDPROC(ftrace_caller)
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  ENTRY(ftrace_regs_caller)
>         SAVE_ALL
> +       ENCODE_FRAME_POINTER
Maybe the patch should merge with others, so separated make it hard to review.

>
>         addi    a0, ra, -FENTRY_RA_OFFSET
>         la      a1, function_trace_op
> --
> 2.17.1
>


--
Best Regards
 Guo Ren
