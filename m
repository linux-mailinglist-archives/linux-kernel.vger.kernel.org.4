Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1B687446
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBBEJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBEJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:09:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE1761DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:09:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id be12so776408edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 20:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTJu9WAGKrGHk/ml0vQ4sKDRHcICD0LMTOQAJoDVC9E=;
        b=viDjWUlS5WJStNg7sBNUvwL5mMHZQuzjK5aEYNb4Ft0akFH4gBbFQcToKZTrK+KGd8
         s/PbmEkIy7XGRnNBo0ZzG9leDOUseTpyoRWdjForYYbc232Mt8t/k9FIL9kZ2GHTQ8lJ
         yFD6nB7uBZTe07suK8Peq63Tqcu4dF/RLoVoW7xskUMa6TkwIpF8+eFKQjM/q2xMCA6H
         1r7++suCgkT3RryiPexXMJ8bT3yn6w0ZRpcn6bkK/wcQSuKy47F4UYsaOLdxxPTTDpnt
         /k/nMiLdN3bx1yM7ggNgLEfyX6zn0Ttx71A8XGM8yPQT+Mav8JkiN2jl7XyQrmJjJ0O6
         U4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTJu9WAGKrGHk/ml0vQ4sKDRHcICD0LMTOQAJoDVC9E=;
        b=PG0JFO6RZ7hjv3SuFgEW111QurT6YUa6kDQcxvYVGyj0qgIrloVJUkBN/A4d04b3VT
         dTGR3LVWeuxQuvan7pEwQSvbRn3LuYj5aHYWfccb/2QJOyOF9h1aa+T5BwZefwoScZVb
         36nlrWDsWdwf1JlSSYMva372RVblRxzVVYh6TpNVZWyca9iMhTb0V6i/xqjJ4PZoWS7k
         F36RD4uXYi7GhVd15EWIMKAWVHzwIHVehaPhL1XdM4NbjMzrBD6y9E1DTQaDc0ioLEMP
         AaLu6G3t9iTq7GhfcjH7Xi/UPQyPLXibhNounGRP+O0vm+IVsA00ftDP6iiZ1wf3Zbd3
         AMhw==
X-Gm-Message-State: AO0yUKWmfTJu4LvnaqjJuB2/db/ulqbIrXkozH4CExBh7+r7v3YItcGS
        NB51drfeg4ZcLNQYMvW0uMKq9defJ7u/dplB2Nysb+xGA4TgfA==
X-Google-Smtp-Source: AK7set9QzhOs2N4Qnsql14QROCMN0P3BspaWH8gwT5Gx/aBQLnwv74nrpL40AUNFn8KZ/a7tcpPDNQauWdF2KKCDNkY=
X-Received: by 2002:a05:6402:25c1:b0:49c:1316:d9d1 with SMTP id
 x1-20020a05640225c100b0049c1316d9d1mr1478262edb.12.1675310964502; Wed, 01 Feb
 2023 20:09:24 -0800 (PST)
MIME-Version: 1.0
References: <CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com>
In-Reply-To: <CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 2 Feb 2023 09:39:14 +0530
Message-ID: <CAAhSdy3PB6tM=Q9fXn_Hs95UvkXT7kyuWvw5S1Fqimwf7qB2TA@mail.gmail.com>
Subject: Re: [PATCH V2] clocksource: riscv: Patch riscv_clock_next_event()
 jump before first use
To:     Matt Evans <mev@rivosinc.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 1:19 AM Matt Evans <mev@rivosinc.com> wrote:
>
> A static key is used to select between SBI and Sstc timer usage in
> riscv_clock_next_event(), but currently the direction is resolved
> after cpuhp_setup_state() is called (which sets the next event).  The
> first event will therefore fall through the sbi_set_timer() path; this
> breaks Sstc-only systems.  So, apply the jump patching before first
> use.
>
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Signed-off-by: Matt Evans <mev@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>
> V1 -> V2: Commit msg tweak.
>
>  drivers/clocksource/timer-riscv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 969a552da8d2..a36d173fd6cd 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -177,6 +177,11 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>                 return error;
>         }
>
> +       if (riscv_isa_extension_available(NULL, SSTC)) {
> +               pr_info("Timer interrupt in S-mode is available via sstc extension\n");
> +               static_branch_enable(&riscv_sstc_available);
> +       }
> +
>         error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>                          "clockevents/riscv/timer:starting",
>                          riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> @@ -184,11 +189,6 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>                 pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>                        error);
>
> -       if (riscv_isa_extension_available(NULL, SSTC)) {
> -               pr_info("Timer interrupt in S-mode is available via sstc extension\n");
> -               static_branch_enable(&riscv_sstc_available);
> -       }
> -
>         return error;
>  }
>
> --
> 2.30.2
>
>
