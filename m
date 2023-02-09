Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E25691224
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBIUgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:36:20 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1972D156
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:36:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o13so3218042pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FP60phxXmm0WhYSgn3CIO/JFGc6EWI16kLsCgTK4Og=;
        b=dHLK4TkOa4fkDNGjjnndev7N6sTnN1ObsXe852ON+Wo0CtTcV8zZTJjA8r13ULTZ4m
         63TaM2RMtSeWZ5B7+8khmTUqvXcjkOeBkI9YgI93UU4S3GRDlXO/Xsi23Ek0v5xq5c+u
         aImS6U2j0R/qu8EXGaN1w+9Yv6oIWYc4yqUKFNAXNfNxKzQ+3aTJ0cTQyZ6IutUjc8Bd
         2OkP8wANfxcFy8Bwtck0ejj0rIXtJEbZbSlLNL+hM4X2dILI1Ncy0CUSvsbiaXxujGYu
         g73TfxUgDhgbRQRV/NOQURDMxd0kTazmBwxtVcUj45HSypSDWcJ8jKz4sPEfqCltMiQz
         U2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FP60phxXmm0WhYSgn3CIO/JFGc6EWI16kLsCgTK4Og=;
        b=bwxtnU47iAszyr6KlVLLkbi3apXQROWZ1vKUv6mLAOg7XGO4QRuDW36hkLInJx/eB9
         /idfJXRCposPZ4dysJituTzNJ5PoKXcCshlaQ84jl43m3EJQCyFCDi38jfibIY+Uckxh
         ervnnLi41QoqlqU3bpffkTb3AiMGXMro2FZ/Ql4uGTNgt/R0O98NMTemZSK4TW5cUti1
         t7Tl4VVkvYW9gNKzsMoszQb/5cBbRq6gLGbD8E2ggbCu1YeirO9s0I71sukqnoYFxPjJ
         gK7fw8eTk2D+ihNCp6rCGpA8ol1p4skQCWG/4C1aeoIbIZTTNrrtjM2vNHYk2YHNLemA
         ChYg==
X-Gm-Message-State: AO0yUKXwWZ1SZlFvDN+IgyunHyXluLjaQGAHqAyT+sPfyb1w7VGuZa9g
        qjd8JKMn+OmumxF/AZI3KN8ZgE72T9oi/CpB
X-Google-Smtp-Source: AK7set8ueCh8MZ68Gx41h0zuuIYyT5ckl5K+XpwKeZssGWuFXzxg/dzRNOmdnmUTitBHnloSbZoqow==
X-Received: by 2002:a17:902:f30d:b0:19a:68b2:5458 with SMTP id c13-20020a170902f30d00b0019a68b25458mr1323828ple.63.1675974974870;
        Thu, 09 Feb 2023 12:36:14 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jf19-20020a170903269300b0019a6cce205bsm468321plb.154.2023.02.09.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:36:14 -0800 (PST)
Date:   Thu, 09 Feb 2023 12:36:14 -0800 (PST)
X-Google-Original-Date: Thu, 09 Feb 2023 12:35:31 PST (-0800)
Subject:     Re: [PATCH V2] clocksource: riscv: Patch riscv_clock_next_event() jump before first use
In-Reply-To: <CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com>
CC:     daniel.lezcano@linaro.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Matt Evans <mev@rivosinc.com>, tglx@linutronix.de
Message-ID: <mhng-6fc3dd67-9502-4c46-91b8-4837116d097f@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Feb 2023 11:49:42 PST (-0800), Matt Evans wrote:
> A static key is used to select between SBI and Sstc timer usage in
> riscv_clock_next_event(), but currently the direction is resolved
> after cpuhp_setup_state() is called (which sets the next event).  The
> first event will therefore fall through the sbi_set_timer() path; this
> breaks Sstc-only systems.  So, apply the jump patching before first
> use.
>
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Signed-off-by: Matt Evans <mev@rivosinc.com>
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
>  		return error;
>  	}
>  
> +	if (riscv_isa_extension_available(NULL, SSTC)) {
> +		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
> +		static_branch_enable(&riscv_sstc_available);
> +	}
> +
>  	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> @@ -184,11 +189,6 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>  		       error);
>  
> -	if (riscv_isa_extension_available(NULL, SSTC)) {
> -		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
> -		static_branch_enable(&riscv_sstc_available);
> -	}
> -
>  	return error;
>  }
>  
> -- 
> 2.30.2

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks like I've taken stuff here before, but I'm also happy to have the 
clocksource folks pick this up so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I don't think this is a particularly critical fix, as IIUC there's still 
no Sstc-only hardware in the real world.  Given how late we are I'd err 
towards putting this on for-next anyway, so I'll give the clocksource 
folks a bit more time to chime in.  Otherwise I'll put it on for-next 
before the merge window (assuming we're got an rc8 coming).

Thanks!
