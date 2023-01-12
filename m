Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C828667120
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjALLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjALLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:40:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AB50F57;
        Thu, 12 Jan 2023 03:31:05 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:31:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673523064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQKzxWGlYcUEh4TPtYYTILu3zcGAYCnzPQyrQfdSwdk=;
        b=dSXoddQ72Rqbe6DDTUj4sQskN7vwSCOVRsqkK58/hdj6UsPQ3ThpCehVzlp6t2tiwCr2Xa
        XkohUyOWtAnV1vOEfDJk9OjP05EZopb41pmaJ58gRfs+anxkfFbZrL7dEtxyrSnOlv2TLx
        Wgv3LIYXqxxAyD0S2CFCZ0I9fBG22sej2TE12gLGiIYQtvlF6SbDV/Uv9+1Pi2r5oKtJxU
        VtWfoVwQvLbpWoZEo21AD5YB3/q9RDXF6SNGHW7sJpzEf2PLOpbWAmZdwlcef1tjfulJyE
        Kx0ccVpeEFWm6jl9uxgJRbIdksQuKX4v6K+f76dqgOI8smN426+adTUSUMpXjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673523064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQKzxWGlYcUEh4TPtYYTILu3zcGAYCnzPQyrQfdSwdk=;
        b=+KCMjXpngd1nZ5yDy9hP+czUOcsSDk5w7W2miPE1JxTfEWhSuQpLWIdDgicOHM93OEaJFV
        whNiykUIC1Aq7rAw==
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
Subject: Re: [PATCH v2 5/5] PM: domains: Do not call
 device_pm_check_callbacks() when holding genpd_lock()
Message-ID: <Y7/vdnD8qELX4A5m@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 16:15:03 [+0100], Krzysztof Kozlowski wrote:
> If PM domain on PREEMPT_RT is marked as GENPD_FLAG_RT_SAFE(), the
> genpd_lock() will be a raw spin lock, thus device_pm_check_callbacks()

a raw_spinlock_t

> must be called outside of the domain lock.

Right. First the sleeping lock, followed by the spinning locks. This is
covered in
	Documentation/locking/locktypes.rst

at the end.=20

> This solves on PREEMPT_RT:
Yes but
>   [ BUG: Invalid wait context ]

This "Invalid wait context" should also trigger on !PREEMPT_RT with
CONFIG_PROVE_RAW_LOCK_NESTING.

>   6.1.0-rt5-00325-g8a5f56bcfcca #8 Tainted: G        W
>   -----------------------------
>   swapper/0/1 is trying to lock:
>   ffff76e045dec9a0 (&dev->power.lock){+.+.}-{3:3}, at: device_pm_check_ca=
llbacks+0x20/0xf0
>   other info that might help us debug this:
>   context-{5:5}
>   3 locks held by swapper/0/1:
>    #0: ffff76e045deb8e8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x=
38/0x1c0
>    #1: ffffa92b81f825e0 (gpd_list_lock){+.+.}-{4:4}, at: __genpd_dev_pm_a=
ttach+0x7c/0x250
>    #2: ffff76e04105c7a0 (&genpd->rslock){....}-{2:2}, at: genpd_lock_raws=
pin+0x1c/0x30
>   stack backtrace:
>   CPU: 5 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rt5-00=
325-g8a5f56bcfcca #8
>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>   Call trace:
>    dump_backtrace.part.0+0xe0/0xf0
>    show_stack+0x18/0x40
>    dump_stack_lvl+0x8c/0xb8
>    dump_stack+0x18/0x34
>    __lock_acquire+0x938/0x2100
>    lock_acquire.part.0+0x104/0x28c
>    lock_acquire+0x68/0x84
>    rt_spin_lock+0x40/0x100
>    device_pm_check_callbacks+0x20/0xf0
>    dev_pm_domain_set+0x54/0x64
>    genpd_add_device+0x258/0x340
>    __genpd_dev_pm_attach+0xa8/0x250
>    genpd_dev_pm_attach_by_id+0xc4/0x190
>    genpd_dev_pm_attach_by_name+0x3c/0x60
>    dev_pm_domain_attach_by_name+0x20/0x30
>    dt_idle_attach_cpu+0x24/0x90
>    psci_cpuidle_probe+0x300/0x4b0
>    platform_probe+0x68/0xe0
>    really_probe+0xbc/0x2dc
>    __driver_probe_device+0x78/0xe0
>    driver_probe_device+0x3c/0x160
>    __device_attach_driver+0xb8/0x140
>    bus_for_each_drv+0x78/0xd0
>    __device_attach+0xa8/0x1c0
>    device_initial_probe+0x14/0x20
>    bus_probe_device+0x9c/0xa4
>    device_add+0x3b4/0x8dc
>    platform_device_add+0x114/0x234
>    platform_device_register_full+0x108/0x1a4
>    psci_idle_init+0x6c/0xb0
>    do_one_initcall+0x74/0x450
>    kernel_init_freeable+0x2e0/0x350
>    kernel_init+0x24/0x130
>    ret_from_fork+0x10/0x20

I would prefer a description of the issue instead hacing this
backtrace.

> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/base/power/domain.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4dfce1d476f4..db499ba40497 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1666,10 +1666,14 @@ static int genpd_add_device(struct generic_pm_dom=
ain *genpd, struct device *dev,
>  	if (ret)
>  		goto out;
> =20
> +
> +	/* PREEMPT_RT: Must be outside of genpd_lock */

Could this comment be rewritten if needed?
The callback, which acquires sleeping locks on PREEMPT_RT, can be moved
before genpd_lock() because it does not rely on this lock. It must be
moved because the latter may acquire spinning locks.

It might be also be part of the commit message=E2=80=A6

> +	device_pm_check_callbacks(dev);
> +
>  	genpd_lock(genpd);
> =20
>  	genpd_set_cpumask(genpd, gpd_data->cpu);
> -	dev_pm_domain_set(dev, &genpd->domain);
> +	dev_pm_domain_set_no_cb(dev, &genpd->domain);
> =20
>  	genpd->device_count++;
>  	if (gd)

Sebastian
