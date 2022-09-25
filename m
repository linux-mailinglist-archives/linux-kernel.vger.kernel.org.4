Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32B5E96E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiIYXSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiIYXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 19:18:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3629824
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55214B8128D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B9DC433D6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664147920;
        bh=ir9kdaG2LaaAh6q3B/+kD0K7jgZwdQEk7RxO73YXov8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C6XHzStZMc34QAD1pUX5CZOj2iU/Xp8QgMlsGJ+JZJuiRN0ByXBaONRvBlamch0Ma
         tjA9bWK08q4nCunFBLTtCLYi9vxzDS+mA3bLG0gaVmJwXh/ukCZRq6C+H92QOBExgQ
         oKW5kSd9uZhha8Xy9WB9rmXoDSHbDM5MX0kGJ3RM9f3rP8ndFTqNkzMsbE6eNd4Eqy
         Rr8/NHSryP9ma+eeCjy+/wqgXi2TfdZZMmNtuXf8cj0m7QIk5wXUlajLGngXmiY77S
         CGnwFYJwj+HKgvxYgre5zBh5EEsreoXheuPiGAGmSEOxITXc1sGkzHgXkOL+LdAWk5
         eGAuEFfbyxM5w==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1278a61bd57so7219694fac.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:18:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf15ZU9JYevgqGt21dquGlyE6SUMW3c/xNw9XzYVv5dzgvHmaI4I
        F6IcODZf4UZBhWaUaERi/E5+pb6AS77c/B8XMSE=
X-Google-Smtp-Source: AMsMyM5En5NGgLYHFu5c/5LTPvS4iDYtENMXq3gobkQCiXjCYHqIzdAuJ14JOjvxpya8Hqmy0rIjUt08Rfjuo7MzuhY=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr17385757oao.112.1664147919201; Sun, 25
 Sep 2022 16:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220925175356.681-1-jszhang@kernel.org> <20220925175356.681-2-jszhang@kernel.org>
In-Reply-To: <20220925175356.681-2-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 26 Sep 2022 07:18:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSXDYLk07yYU-fUNg12k_7+Pmm8tQDnsRHw4Ka5vX8JyA@mail.gmail.com>
Message-ID: <CAJF2gTSXDYLk07yYU-fUNg12k_7+Pmm8tQDnsRHw4Ka5vX8JyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] riscv: remove extra level wrappers of trace_hardirqs_{on,off}
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

I would involve the patch in the generic entry series, okay?

On Mon, Sep 26, 2022 at 2:03 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Since riscv is converted to generic entry, there's no need for the
> extra wrappers of trace_hardirqs_{on,off}.
>
> Tested with llvm + irqsoff.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/Makefile    |  2 --
>  arch/riscv/kernel/trace_irq.c | 27 ---------------------------
>  arch/riscv/kernel/trace_irq.h | 11 -----------
>  3 files changed, 40 deletions(-)
>  delete mode 100644 arch/riscv/kernel/trace_irq.c
>  delete mode 100644 arch/riscv/kernel/trace_irq.h
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 01da14e21019..11ee206cc235 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -69,8 +69,6 @@ obj-$(CONFIG_CPU_PM)          += suspend_entry.o suspend.o
>  obj-$(CONFIG_FUNCTION_TRACER)  += mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)   += mcount-dyn.o
>
> -obj-$(CONFIG_TRACE_IRQFLAGS)   += trace_irq.o
> -
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                += sbi.o
> diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
> deleted file mode 100644
> index 095ac976d7da..000000000000
> --- a/arch/riscv/kernel/trace_irq.c
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
> - */
> -
> -#include <linux/irqflags.h>
> -#include <linux/kprobes.h>
> -#include "trace_irq.h"
> -
> -/*
> - * trace_hardirqs_on/off require the caller to setup frame pointer properly.
> - * Otherwise, CALLER_ADDR1 might trigger an pagging exception in kernel.
> - * Here we add one extra level so they can be safely called by low
> - * level entry code which $fp is used for other purpose.
> - */
> -
> -void __trace_hardirqs_on(void)
> -{
> -       trace_hardirqs_on();
> -}
> -NOKPROBE_SYMBOL(__trace_hardirqs_on);
> -
> -void __trace_hardirqs_off(void)
> -{
> -       trace_hardirqs_off();
> -}
> -NOKPROBE_SYMBOL(__trace_hardirqs_off);
> diff --git a/arch/riscv/kernel/trace_irq.h b/arch/riscv/kernel/trace_irq.h
> deleted file mode 100644
> index 99fe67377e5e..000000000000
> --- a/arch/riscv/kernel/trace_irq.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
> - */
> -#ifndef __TRACE_IRQ_H
> -#define __TRACE_IRQ_H
> -
> -void __trace_hardirqs_on(void);
> -void __trace_hardirqs_off(void);
> -
> -#endif /* __TRACE_IRQ_H */
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren
