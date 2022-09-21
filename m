Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5AC5BF356
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIUCOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIUCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:14:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACA57C1F7;
        Tue, 20 Sep 2022 19:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 312DBB82D5D;
        Wed, 21 Sep 2022 02:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E0EC4347C;
        Wed, 21 Sep 2022 02:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663726452;
        bh=qI7h/5oDIg8KfeFQUixqYzNKwl6VFPqXAJjhtSbuMi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RCWADFT0FYCuKHjJOaL1bTscBnD+CJHvzrIflu0vrtjEq+XDtYR6luTG0RrfCVKXT
         zqeADrU7M0ulVNWynrS3swEBDzod6A3vsWB4CrJfg0Yox8J4b1C3NutSRePRbwANnN
         g3/V50iOphmleNsFLtDPf1Wnz0+4If40uRG6f/wzF82kKJukOAt68ALyK+hGChw3rF
         56lNNI5bO4Q2sLr/kEiK6544PdAuv/w8HqNCWTBJrxAPzBsNJiSSix3RnsOMvnMtIc
         EANrNFVKE2XpYalKJhOjDHJ/zOoi31UhRRLYG3rJwcByuo1lQPx2LEipklt0eOk1QH
         2nwhGmzlhyoOQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1279948d93dso7049706fac.10;
        Tue, 20 Sep 2022 19:14:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf1q9Ilm8M/wzPJIc1m69o7Pb/qncoFtK4iM3MiN/j9JcUQe4VT0
        36CQ+53vRoM26yhPLvMraOmAPKAbpax/rdBkDu8=
X-Google-Smtp-Source: AMsMyM6IwqZwyLI7janQ1zDjXRLjdc4ym5Cy+EMmk9dbqWgfBFb8S6xJgFzOVD03EiTmLaz3UFMA/qSfiCqmy97Kl/E=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr3833650oao.112.1663726451988; Tue, 20
 Sep 2022 19:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220920151202.180057-1-chenzhongjin@huawei.com> <20220920151202.180057-4-chenzhongjin@huawei.com>
In-Reply-To: <20220920151202.180057-4-chenzhongjin@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 10:13:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS1=xSrsaABLzbRwq2V=Wj3_SyHtooXosfY7L9zAwf=NA@mail.gmail.com>
Message-ID: <CAJF2gTS1=xSrsaABLzbRwq2V=Wj3_SyHtooXosfY7L9zAwf=NA@mail.gmail.com>
Subject: Re: [PATCH -next 3/7] riscv: stacktrace: Save pt_regs in encoded fp
 on irq entry
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

Reviewed-by: Guo Ren <guoren@kernel.org>

ENCODE fp with BIT[0] is okay.

On Tue, Sep 20, 2022 at 11:15 PM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> To support stack unwinding at irq entry, the position of pt_regs saved
> on stack is nessesary. Because for some functions, compiler only push
> s0/fp on stack without ra.
>
> As the situation described in
> commit f766f77a74f5("riscv/stacktrace: Fix stack output without ra on the stack top")
>
> When irq happens there, the the function frame looks like:
>
> prev function   |       ...       |
>                 |                 |
> normal function +-----------------+
>                 | ra to prev      |
>                 | s0 of prev      |
>                 |       ...       |<-+
> leaf function   +-----------------+  |
>                 | s0 of normal    |  |
>                 | empty slot      |  |
> irq pt_regs     +-----------------+  |
>                 | epc (ra to leaf)|  |
>                 | ra  (ra to norm)|  |
>                 | ...             |  |
>                 | s0 of leaf      |--+
>                 | ...             |
>                 +-----------------+
>
> If the position of register in pt_regs is {epc, s0}, we can easily
> unwind from irq frame to leaf function, as normal functions do.
>
> However when unwinding from unwinding from leaf to normal, beacause
> (ra to norm) is saved in pt_regs, but not stackframe of leaf, we
> have to get pt_regs for that.
>
> To get pt_regs position on stack, we can save the encoded *pt_regs
> in s0, as x86 architecture did. Then we can get s0, epc and ra
> easily.
>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  arch/riscv/include/asm/frame.h | 45 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/entry.S      |  3 +++
>  2 files changed, 48 insertions(+)
>  create mode 100644 arch/riscv/include/asm/frame.h
>
> diff --git a/arch/riscv/include/asm/frame.h b/arch/riscv/include/asm/frame.h
> new file mode 100644
> index 000000000000..2a1f45cf3a4e
> --- /dev/null
> +++ b/arch/riscv/include/asm/frame.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_FRAME_H
> +#define _ASM_RISCV_FRAME_H
> +
> +#include <asm/asm.h>
> +
> +#ifdef CONFIG_FRAME_POINTER
> +
> +#ifdef __ASSEMBLY__
> +
> +/*
> + * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
> + * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
> + * is just setting the LSB, which makes it an invalid stack address and is also
> + * a signal to the unwinder that it's a pt_regs pointer in disguise.
> + *
> + * This macro must be used when sp point to pt_regs
> + */
> +.macro ENCODE_FRAME_POINTER
> +       add s0, sp, 0x1
> +.endm
> +
> +#else /* !__ASSEMBLY__ */
> +
> +#define ENCODE_FRAME_POINTER                   \
> +       "add s0, sp, 0x1\n\t"
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#else /* !CONFIG_FRAME_POINTER */
> +
> +#ifdef __ASSEMBLY__
> +
> +.macro ENCODE_FRAME_POINTER ptregs_offset=0
> +.endm
> +
> +#else /* !__ASSEMBLY */
> +
> +#define ENCODE_FRAME_POINTER
> +
> +#endif /* !__ASSEMBLY */
> +
> +#endif /* CONFIG_FRAME_POINTER */
> +
> +#endif /* _ASM_RISCV_FRAME_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..ecb15c7430b4 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -13,6 +13,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/errata_list.h>
> +#include <asm/frame.h>
>
>  #if !IS_ENABLED(CONFIG_PREEMPTION)
>  .set resume_kernel, restore_all
> @@ -95,6 +96,8 @@ _save_context:
>         REG_S s4, PT_CAUSE(sp)
>         REG_S s5, PT_TP(sp)
>
> +       ENCODE_FRAME_POINTER
> +
>         /*
>          * Set the scratch register to 0, so that if a recursive exception
>          * occurs, the exception vector knows it came from the kernel
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren
