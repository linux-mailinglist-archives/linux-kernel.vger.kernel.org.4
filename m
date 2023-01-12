Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE41666FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjALKkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbjALKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:38:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06A5A448;
        Thu, 12 Jan 2023 02:33:01 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:32:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673519580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34ygEy1+GS0Y/qu3m/B5kUuzoRWt1oEYp4NuIKDOfqY=;
        b=Uy3MOEEdxIX5mg+VrtgEzoJZGRwbT/EYIUGW3M5gs4VXaf9ZH19kCW2Pr0L58TYEEfPzOS
        NrGRLqvmqtl7uLz6VARLu+A5YwX6e6288ukUyBDL9SrCR2owQUgLM2G2B22EPN4VkI2T5R
        ggs3DO2viFcgIUh2YXKZNEvQAYWkhsOn/4jPsMqTe/1cP7kNz+9y4TFPYOHLezoowN8xHF
        6WlozPfs/Qfh8j6KviLoYwfXFT2lDH0o9D8MdwB0B+N6DD60TYO5llYDoCqtkPmUwNcDFG
        S8cB1UMjYdPg4IbmYhtvR9X735C+ZsU6NeLTicwio2+bYnrOnFfy9bKtr69nBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673519580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34ygEy1+GS0Y/qu3m/B5kUuzoRWt1oEYp4NuIKDOfqY=;
        b=8I/zqzp3u/8aTJZeP1Ni7RVtF+/L3mzeJMhGFzxBwi1H+CHnN0CurxqB08sdhdDyry5F9e
        wgObcssitOZxPzAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Message-ID: <Y7/h2n271HBeXDl6@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 16:14:59 [+0100], Krzysztof Kozlowski wrote:
> Realtime kernels with PREEMPT_RT must use raw_spinlock_t for domains
> which are invoked from CPU idle (thus from atomic section).  Example is
> cpuidle PSCI domain driver which itself is PREEMPT_RT safe, but is being
> called as part of cpuidle.

I think it needs to be clarified what PREEMPT_RT safe means. PSCI is an
external interface which does not inform us what it does and how long
the operation will take.
The ACPI table for instance populate several idle states and their
entry/exit time. Then you can decide if and when an entry/exit latency
of 500us is PREEMPT_RT safe.

> Add a flag allowing a power domain provider to indicate it is RT safe.
> The flag is supposed to be used with existing GENPD_FLAG_IRQ_SAFE.
>=20
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
=E2=80=A6
> index 1cd41bdf73cf..0a1600244963 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -61,6 +61,14 @@
>   * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
>   *				components' next wakeup when determining the
>   *				optimal idle state.
> + *
> + * GENPD_FLAG_RT_SAFE:		When used with GENPD_FLAG_IRQ_SAFE, this informs
> + *				genpd that its backend callbacks, ->power_on|off(),
> + *				do not use other spinlocks. They might use
> + *				raw_spinlocks or other pre-emption-disable
> + *				methods, all of which are PREEMPT_RT safe. Note

Please use spinlock_t and raw_spinlock_t. Wouldn't it be better to write
"preemption" instead "pre-emption"?
The important part is probably that once a raw_spinlock_t has been
acquired, it is not possible to invoke any function that acquries
sleeping locks (which includes memory allocations). While even without
that flag it is possible to invoke a function which disables and enables
preemption on its own.

> + *				that, a genpd having this flag set, requires its
> + *				masterdomains to also have it set.

This could be verified upon registration, no?
It might be worth noting that preemption-off section during PM
operations contribute to the system's max latency. Depending on how low
the operation is, it may or may not be a problem.
The ->power_on|off() refers to the sate of the component, right?

>   */
>  #define GENPD_FLAG_PM_CLK	 (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)

Sebastian
