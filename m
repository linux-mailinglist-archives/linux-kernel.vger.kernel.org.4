Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2916C2E61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCUKFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:05:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390B22C93;
        Tue, 21 Mar 2023 03:04:59 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:04:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679393098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gs+5h35jpcBbsUqy1yYnuNWbnvGi9SFjCXiZrEILP6Y=;
        b=FX37LclzSzYNgjIXv1slzw45d7o/t37Dt6f6cQy1Q+ttyiUKTSr8tBvL0J5ctMdZCO+mA2
        ELa71WycrZ9+5KSzPrADLDDbP7m8EmQKibSTHo6kyamjv6dOuCTBXKG4Oj2n9M1NzuQ/R/
        WqaLaOzKJ6ozvUPtWZT1Iii2uPlZsEi3Zg/n567JK1DyECKh6wd9jg5ePhnlwtngLfsmt0
        Vfc89XhdhTr6xkJnH2B9PwIRVW+3EVf6LuuKTGHcfQZFDOv+bGh0DIUk2B5sd1kE5LrwJc
        nT8aEy54Y4cPJ/P7uhAKuLS+vDDZWL5KdfPX+HjLztcgF92Jd5UfbPcTxURuIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679393098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gs+5h35jpcBbsUqy1yYnuNWbnvGi9SFjCXiZrEILP6Y=;
        b=9b1LJ3Zuvi3m6zmWVdQdswxY1suryCcv+pBjseZEqLO/gRie3U6Hg2Mvr2dQGXB/1JM3HU
        Gce2ECbXXVRL3oBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
Message-ID: <20230321100456.0_DhhkZJ@linutronix.de>
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-15 17:49:10 [+0100], Krzysztof Kozlowski wrote:
> Qualcomm cpufreq driver configures interrupts with affinity to each
> cluster, e.g.  dcvsh-irq-0, dcvsh-irq-4 and dcvsh-irq-7 on SM8250.
> Triggered interrupt will schedule delayed work, but, since workqueue
> prefers local CPUs, it might get executed on a CPU dedicated to realtime
> tasks causing unexpected latencies in realtime workload.
> 
> Use unbound workqueue for such case.  This might come with performance
> or energy penalty, e.g. because of cache miss or when other CPU is
> sleeping.

I miss the point where it explains that only PREEMPT_RT is affected by
this.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 2f581d2d617d..c5ff8d25fabb 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -390,7 +390,16 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
>  
>  	/* Disable interrupt and enable polling */
>  	disable_irq_nosync(c_data->throttle_irq);
> -	schedule_delayed_work(&c_data->throttle_work, 0);
> +
> +	/*
> +	 * Workqueue prefers local CPUs and since interrupts have set affinity,
> +	 * the work might execute on a CPU dedicated to realtime tasks.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		queue_delayed_work_on(WORK_CPU_UNBOUND, system_unbound_wq,
> +				      &c_data->throttle_work, 0);
> +	else
> +		schedule_delayed_work(&c_data->throttle_work, 0);

You isolated CPUs and use this on PREEMPT_RT. And this special use-case
is your reasoning to make this change and let it depend on PREEMPT_RT?

If you do PREEMPT_RT and you care about latency I would argue that you
either disable cpufreq and set it to PERFORMANCE so that the highest
available frequency is set once and not changed afterwards.

>  	if (qcom_cpufreq.soc_data->reg_intr_clr)
>  		writel_relaxed(GT_IRQ_STATUS,
> -- 
> 2.34.1
> 
