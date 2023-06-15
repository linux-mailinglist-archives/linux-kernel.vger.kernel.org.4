Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FB731635
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245566AbjFOLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjFOLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:13:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BF2707
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:13:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9827109c6e9so224185666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1686827628; x=1689419628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6/FpzPNAHlY54Fo7NVW+A1R/BCk1nUaPcq02OwjE/0=;
        b=GJaxW8E7JufGmT2esS3ot3JA2VgRzFAaOrNNcXx6K5actcLiW8n7qr+SW3tu4z23TA
         X+4gbv4MLyBXljQpCsDSFuv33hgrmEqwNtcwQUQLoBG/mPz1++6O+ibHfnlROvWehg8q
         EOCMYHF4g90zikooEWE1iYPhSpqiRGLLGxcmXqO+m3FOXC4P6y+mfI4Gp+1CGka64hCB
         rVklWkiXY9YOXbiDmhUftAsLcYKrSxjLeqXL9ovIp+XRiHjtyzTcAu5n0UWKh9JL4GVt
         X1MvoYf21N/JhA8s345T9WOWF1BJV7D44Xi+dOxTldx2EHMMFTTzaPQ3pbnleiFCu5DS
         vTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686827628; x=1689419628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6/FpzPNAHlY54Fo7NVW+A1R/BCk1nUaPcq02OwjE/0=;
        b=dr8RMAG1rRZoYvnL3Ib7Qf/BUPDfJJh+bHhby0IjSMty4Ye5Asm7lMWwxu5lAmkWOi
         EdgNRkbouMWx+5CL3VtYiSnaXBsY7FJrgMd/uPM/TD8gWmOvlxmhmhx8+oZ/W5jHB5ky
         1npg85gxrXJHJS8CukDvYB1U30GBKOXbLKt8ILpomwoiDXFHJIBM36F5X1eTT0IXJ0Rq
         TYj9g6aFs5pzA3ZGCqEVoHMDtragCYDSn8LYNkCNhXHniIZkY5qWVHSfsR+TRq9Ie1IF
         Vx4XZACSUeJ3iz/wqhCeO7WazS3VKRWDjn9/5YkwiPCYpAq7DhGNV35ivzs9ixw5s2Wh
         Nqbw==
X-Gm-Message-State: AC+VfDwuAP7sDfRR/dPsvXLQcggMM8IrBK3z7mJMnmouxQ4b+fYHNDQ+
        8sFRmfLHeNKoFN2W4FwKkFYWWw==
X-Google-Smtp-Source: ACHHUZ5qmMgVWsBkgVzr3bL0y21dv6cCP43HOR7ykOJuIK6oyweHnGyCtLeODqvEVxohVh2p05UIdQ==
X-Received: by 2002:a17:907:3eaa:b0:970:1b2d:45bf with SMTP id hs42-20020a1709073eaa00b009701b2d45bfmr17300569ejc.61.1686827628017;
        Thu, 15 Jun 2023 04:13:48 -0700 (PDT)
Received: from ?IPV6:2003:f6:af1c:2300:fa33:8d65:b4c4:3ebe? (p200300f6af1c2300fa338d65b4c43ebe.dip0.t-ipconnect.de. [2003:f6:af1c:2300:fa33:8d65:b4c4:3ebe])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906164600b0096f71ace804sm1937357ejd.99.2023.06.15.04.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 04:13:47 -0700 (PDT)
Message-ID: <bead7acb-ed71-4a14-0094-f8e39323a3b5@grsecurity.net>
Date:   Thu, 15 Jun 2023 13:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
Content-Language: en-US, de-DE
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Luiz Capitulino <luizcap@amazon.com>,
        Sven-Haegar Koch <haegar@sdinet.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
 <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
 <23fb8ad7-beb0-ae1c-fa5a-a682a57f79b0@grsecurity.net>
 <20230615091830.RxMV2xf_@linutronix.de>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230615091830.RxMV2xf_@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.06.23 11:18, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The tick period is aligned very early while the first clock_event_device
> is registered. The system runs in periodic mode and switches later to
> one-shot mode if possible.
> 
> The next wake-up event is programmed based on aligned value
> (tick_next_period) but the delta value, that is used to program the
> clock_event_device, is computed based on ktime_get().
> 
> With the subtracted offset, the devices fires in less than the exacted
> time frame. With a large enough offset the system programs the timer for
> the next wake-up and the remaining time left is too little to make any
> boot progress. The system hangs.
> 
> Move the alignment later to the setup of tick_sched timer. At this point
> the system switches to oneshot mode and a highres clocksource is
> available. It safe to update tick_next_period ktime_get() will now
> return accurate (not jiffies based) time.
> 
> [bigeasy: Patch description + testing].
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
> Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")

Cc: stable, maybe? This commit already ended up in quite a few "stable"
kernels (v6.3.2, v6.2.15, v6.1.28, v5.15.111, v5.10.180 and v5.4.243)
and it might be better to list them explicitly to avoid one of them
getting missed.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
> Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com
> ---
>  kernel/time/tick-common.c | 11 +----------
>  kernel/time/tick-sched.c  | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 65b8658da829e..b85f2f9c32426 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -218,19 +218,10 @@ static void tick_setup_device(struct tick_device *td,
>  		 * this cpu:
>  		 */
>  		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
> -			ktime_t next_p;
> -			u32 rem;
>  
>  			tick_do_timer_cpu = cpu;
>  
> -			next_p = ktime_get();
> -			div_u64_rem(next_p, TICK_NSEC, &rem);
> -			if (rem) {
> -				next_p -= rem;
> -				next_p += TICK_NSEC;
> -			}
> -
> -			tick_next_period = next_p;
> +			tick_next_period = ktime_get();
>  #ifdef CONFIG_NO_HZ_FULL
>  			/*
>  			 * The boot CPU may be nohz_full, in which case set
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 52254679ec489..42c0be3080bde 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
>  	raw_spin_lock(&jiffies_lock);
>  	write_seqcount_begin(&jiffies_seq);
>  	/* Did we start the jiffies update yet ? */
> -	if (last_jiffies_update == 0)
> +	if (last_jiffies_update == 0) {
> +		u32 rem;
> +
> +		/*
> +		 * Ensure that the tick is aligned to a multiple of
> +		 * TICK_NSEC.
> +		 */
> +		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
> +		if (rem)
> +			tick_next_period += TICK_NSEC - rem;
> +
>  		last_jiffies_update = tick_next_period;
> +	}
>  	period = last_jiffies_update;
>  	write_seqcount_end(&jiffies_seq);
>  	raw_spin_unlock(&jiffies_lock);

Hah, nice spot. So you implemented what I suggested and it, indeed,
works as expected, thereby:

Tested-by: Mathias Krause <minipli@grsecurity.net>

Thanks,
Mathias
