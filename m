Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29B7009BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbjELOBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbjELOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:01:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6113C0A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:00:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306dbad5182so6638699f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683900054; x=1686492054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZTBhI8WbVwatkb4NYJFwNjU8zCWiGxjcfs72+Uqg0s=;
        b=qMkQbvxAC2CEszBSGG2OCKh/YDmt7+6DPvo4kAkYiaPeP4mYr3nqr3UGNKdA91FYfD
         1P/2Fce83EnJbUyzAu3rcyn3uYJGZDTevO/Ia7oPB6v75enCd8kB+Ob5foHVqn0S1YIg
         R6EOJG4kWKq8XWjTIIuymT+YMDuv8ijmTX3nKeBY9OcYg+RhZH9IE19D274/5Jcdy1ZV
         qgJ8HPf3qvBhd9bgDH6sLh8PYdzTyq511nN7ZSQtdi5MRRna3+u+gfXxQSz9L2zu2dVL
         bqPpTgnaYuMe/YefKrnWpWqA+nzVXkPz5FG9latdfTq3BhiTmKNNbvjq8gkNY/BTt/Zy
         uJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900054; x=1686492054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZTBhI8WbVwatkb4NYJFwNjU8zCWiGxjcfs72+Uqg0s=;
        b=gvM58JX/0c3nQVQu9mztB4h+7U8CT5aJihlaky8kZ5lJVJaH1s7sTdAnQXZ9mG81cX
         s9d7qBB7Y0iIbTeXWAiU0z+RRuAFrPylAmHdJAbThtRPiSxirr1PGwqoPAvVnn3br2/0
         1uriytiejz/L+9s+AOxVscBGzpHhTni3KPHYFRiXvPJOAFTv1xYCM8C8WceMKfZ0SJrx
         ajmnmIpnBoQTVirWOPGyDZyZVF1BOtvQT0+KTMCOLDpe+wziWs+A+ON6IE0FLoI/xGnI
         YW67q2jp1Y674Vl9SaHxua7KcWrFvVc1JW8ke0R3xV74T0Mdxmq5kapYn/8TsKcakYm3
         swuQ==
X-Gm-Message-State: AC+VfDzA4Wwf3VjajqO16UYuYa1rfcNqiVL1Rh7OMH9f3NoVFiHoyvrZ
        z3Mjc+SE6r6sjfSN1P0RVIWPvw==
X-Google-Smtp-Source: ACHHUZ4kNwv3cDr0xN4V/C2Hts5rmuiXYr3NgdImv65NIcgXDbOUwrHJnIlxUMCK1b/wB4987mMUKg==
X-Received: by 2002:a5d:51c4:0:b0:306:37ec:656c with SMTP id n4-20020a5d51c4000000b0030637ec656cmr17349120wrv.66.1683900053995;
        Fri, 12 May 2023 07:00:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d460e000000b003047ae72b14sm23588654wrq.82.2023.05.12.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:00:53 -0700 (PDT)
Date:   Fri, 12 May 2023 15:00:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/10] arm64: kgdb: Roundup cpus using IPI as NMI
Message-ID: <20230512140051.GA217273@aspen.lan>
References: <20230419225604.21204-1-dianders@chromium.org>
 <20230419155341.v8.9.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419155341.v8.9.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:56:03PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
>
> arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> leveraged to roundup CPUs which are stuck in hard lockup state with
> interrupts disabled that wouldn't be possible with a normal IPI.
>
> So instead switch to roundup CPUs using IPI turned as NMI. And in
> case a particular arm64 platform doesn't supports pseudo NMIs,
> it will switch back to default kgdb CPUs roundup mechanism.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/kernel/ipi_nmi.c |  5 +++++
>  arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index c592e92b8cbf..2adaaf1519e5 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kgdb.h>
>  #include <linux/nmi.h>
>  #include <linux/smp.h>
>
> @@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  static irqreturn_t ipi_nmi_handler(int irq, void *data)
>  {
>  	irqreturn_t ret = IRQ_NONE;
> +	unsigned int cpu = smp_processor_id();

Does this play nice with CONFIG_DEBUG_PREEMPT? I may have missed
something about the NMI entry but a quick scan of the arm64
arch_irq_disabled() suggests that debug_smp_processor_id() will issue
warnings at this point...

Other than I didn't see anything I don't like here.


Daniel.
