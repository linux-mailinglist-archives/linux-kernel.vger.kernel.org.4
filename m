Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC261770F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKCHBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKCHBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:01:44 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79068DB3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:01:43 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13c569e5ff5so1199004fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFl2tiLTXJHgEZTu1xIg/gZ9TOZ7sZx0xZjb4nLSMXI=;
        b=LudiUqHjGWLNiypWWy7zwlu/lwyQQFFTrVfRVN77odSuy+yfFQ7WAzfy6anrgzNQO6
         RTpZjr62UuMQtqCdMpxV4aejSX3SFmmUNjgzOd88enksbA+XTt0QxrtZF2l0NcUiFKHa
         LO8jjsPTbfV4wrY3di29eYaCg0jtVH0gJHVNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFl2tiLTXJHgEZTu1xIg/gZ9TOZ7sZx0xZjb4nLSMXI=;
        b=elxCw6/sLu6vDXe8crmirr1rX6c35ii0e3zT5f1omXsGFZeaUbHaS3D+YyfghSERqp
         D2zBdek+o7+VscwjyoFj+fVzKCGRYIjIrMODBevsPfwicgPIisVg5rfeVdK+M3QHfpay
         awHhDoMZfSSofTuhs+sN64UaOLZ1f89QB3j2ab7UTQOA6UzVbhwXWgJqy2Nv7SjNsJX4
         1c2c+++c9Bez5skFi0JAGgilgT/ziU+6kMutRTK5lPK5USkJJAwJZzhUmHQnNWOKebAG
         ZnjYTw+ByeDIkjlfOt3rDqvINFJLL0lwynRYZdBpVRDeCn6ULxBXTBKhFGhj24lwyUMF
         YtBA==
X-Gm-Message-State: ACrzQf2oHmtYXrv2Ucd44VCWFSd+VzPQpO9jWBiIk8XSxt+/TSvaKSNb
        TWMquSfCBkOObJJC7v8ObRKd6VL2L6djREAPTrVBp87b9w==
X-Google-Smtp-Source: AMsMyM6mancOWurIa1sMKWFiSwhCtQ5JKZTWkDDFIpQ+TyrpcY4TVnJfKYmexvi1zHnIsgXUg3Y76Gf8nQXi420QfvM=
X-Received: by 2002:a05:6870:8921:b0:13c:39cc:e168 with SMTP id
 i33-20020a056870892100b0013c39cce168mr26457854oao.274.1667458902866; Thu, 03
 Nov 2022 00:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221101143400.690000-1-apatel@ventanamicro.com> <20221101143400.690000-8-apatel@ventanamicro.com>
In-Reply-To: <20221101143400.690000-8-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 3 Nov 2022 00:01:31 -0700
Message-ID: <CAOnJCUJDbV_0WPM9dbsqq60Y_=mEPknEZDGFCFbmxK-FVgn22Q@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] RISC-V: Use IPIs for remote icache flush when possible
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:35 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> If we have specialized interrupt controller (such as AIA IMSIC) which
> allows supervisor mode to directly inject IPIs without any assistance
> from M-mode or HS-mode then using such specialized interrupt controller,
> we can do remote icache flushe directly from supervisor mode instead of
> using the SBI RFENCE calls.
>
> This patch extends remote icache flush functions to use supervisor mode
> IPIs whenever direct supervisor mode IPIs.are supported by interrupt
> controller.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/mm/cacheflush.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 57b40a350420..f10cb47eac3a 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -19,7 +19,7 @@ void flush_icache_all(void)
>  {
>         local_flush_icache_all();
>
> -       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +       if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
>                 sbi_remote_fence_i(NULL);
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> @@ -67,7 +67,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                  * with flush_icache_deferred().
>                  */
>                 smp_mb();
> -       } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> +       } else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> +                  !riscv_use_ipi_for_rfence()) {
>                 sbi_remote_fence_i(&others);
>         } else {
>                 on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
