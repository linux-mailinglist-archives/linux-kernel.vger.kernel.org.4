Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33AC6C2FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCUK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCUK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0194B2FCF4;
        Tue, 21 Mar 2023 03:57:37 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:57:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679396256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2c2FXwkwu2a7pTgBYID1e1ZvubF8W+pwt+MlZiF2uo=;
        b=CFXmA3oRucB6khZI3QyKBsXLWjR3X/BjTrO4bj0BnyQeI6DWirDRdQQ1tu0Q1bDYvMb2nM
        p0BSv5EYMqiV24QOUUPN5PU7pyBqu4r8Eb0A2Quz21xTPKTiBx0mDZopMzVhDIoyOs4ubm
        EPYVlfF0m+P/CWXFne/En2wqF8yeue6iHGN0HTk959dZ1P6mHKYTaOg6luPRSOOivBFvz/
        sJEFcVRNq0Q1wf9vGGnudhc3P+TYR4ZAdLWcmrdvh2oK+YNSxgfzG0KGHV3423bIItiQD/
        koIpufbjMNMbhkBzf899oqZxl4j70eYPYjBnUFUp/LNrcYFwOZdoayF/FAUNgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679396256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2c2FXwkwu2a7pTgBYID1e1ZvubF8W+pwt+MlZiF2uo=;
        b=moZ61AqTHHrhIAi7KhS6vSjXYjNisECyrkxQR+hn325W+DbQvsHHN9/jCm6LKtEp++2HBo
        REsQ/peqMk8JMFCg==
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
Message-ID: <20230321105734.Z7F3Uvf1@linutronix.de>
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
 <20230321100456.0_DhhkZJ@linutronix.de>
 <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21 11:24:46 [+0100], Krzysztof Kozlowski wrote:
> >> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> @@ -390,7 +390,16 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
> >>  
> >>  	/* Disable interrupt and enable polling */
> >>  	disable_irq_nosync(c_data->throttle_irq);
> >> -	schedule_delayed_work(&c_data->throttle_work, 0);
> >> +
> >> +	/*
> >> +	 * Workqueue prefers local CPUs and since interrupts have set affinity,
> >> +	 * the work might execute on a CPU dedicated to realtime tasks.
> >> +	 */
> >> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >> +		queue_delayed_work_on(WORK_CPU_UNBOUND, system_unbound_wq,
> >> +				      &c_data->throttle_work, 0);
> >> +	else
> >> +		schedule_delayed_work(&c_data->throttle_work, 0);
> > 
> > You isolated CPUs and use this on PREEMPT_RT. And this special use-case
> > is your reasoning to make this change and let it depend on PREEMPT_RT?
> > 
> > If you do PREEMPT_RT and you care about latency I would argue that you
> > either disable cpufreq and set it to PERFORMANCE so that the highest
> > available frequency is set once and not changed afterwards.
> 
> The cpufreq is set to performance. It will be changed anyway because
> underlying FW notifies through such interrupts about thermal mitigation
> happening.

I still fail to understand why this is PREEMPT_RT specific and not a
problem in general when it comes not NO_HZ_FULL and/ or CPU isolation.
However the thermal notifications have nothing to do with cpufreq.

> The only other solution is to disable the cpufreq device, e.g. by not
> compiling it.

People often disable cpufreq because _usually_ the system boots at
maximum performance. There are however exceptions and even x86 system
are configured sometimes to a lower clock speed by the firmware/ BIOS.
In this case it is nice to have a cpufreq so it is possible to set the
system during boot to a higher clock speed. And then remain idle unless
the cpufreq governor changed.

> Best regards,
> Krzysztof

Sebastian
