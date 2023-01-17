Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A882066E1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjAQPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjAQPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:11:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA202104
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:11:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so15914339pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xUcKWpwPhTRCrCYmeiWFa+p8NZqQHVS8dp2x80vvN2E=;
        b=i5FxZgEumiJ8FnuC6w3ZPlpjI2uIk1GxX/D13B6iZ8gelXMF9326oWDdxQJWWlPQum
         w9o9XpXMLM+bl3gIz4dn2sqwz3JMe4Bz+FS0zOQeDms1skkuM+kkfWKKYt5BQYTAlwZK
         ikGYF2SWASfsFOwDIx0YFFKWv6mthFGwptf5UT+I0fd5TWOOc4EU1H9ZbX7Ta4vwgapf
         UVEU3KA53mPjf1kTqf8mLWBkotyJN+UC0OZhZjg1KWnWWsLBZ1K8T2oKRGVvVwUuZlRl
         nrIJIQXZDBaJ2/4iQEQxYXcK5o/64ujWJaG6d2EQTakAPrHLYbZZkVomso52WzaDS85s
         Ffaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUcKWpwPhTRCrCYmeiWFa+p8NZqQHVS8dp2x80vvN2E=;
        b=LRtnLGbWT5G1ZeNa78r2KRuRhQAo4M1V4BCE8HV8l1xb2gH/N0DQhvPVu0nitwk+BY
         ohMID8pk77rhDEAX6G2HXCbukXE5ASM518eWFI9/ETHKc5EXdIoQ60TPZ4nZpeBL4h0q
         naJgNAWE9zQzFb1SEMwrOUlM68CO4vbKRFrZ54S2pmjtfMf12eZ4EKw5VKKjtuq6PO3z
         faULSJbK25zp6Lwl0njVaYsHaKDE5j9qrJji9bIZTmpDXLku+0Ay7utz1qIkQC6N9HMx
         Ed9V4bV3DwtaE1Kup/Fs9waZKKQX6RuTy/ia6JnKs1DZosNTU/tTjvwH/ShF+8WWM+ny
         5yRA==
X-Gm-Message-State: AFqh2krlbM4/5rpUcXwgUMCwN+S+R3LpQiR62xMMCreG/Wdc9mFsS5jo
        zGDnkgMP9BxC+34nJxppSmG3vdYdWloIrAkAjVLG2w==
X-Google-Smtp-Source: AMrXdXtpuDodVQl3BW9NsJpqFbWNMxfzSa4qQxrarcGmm4jmlom2dliA3FVJGFz0n30PGkZH6+LMAScxQ86s5PwdPIE=
X-Received: by 2002:a17:90a:1d07:b0:228:f08f:a9b3 with SMTP id
 c7-20020a17090a1d0700b00228f08fa9b3mr335881pjd.202.1673968314504; Tue, 17 Jan
 2023 07:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org> <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Jan 2023 16:11:18 +0100
Message-ID: <CAPDyKFoHx+cr-kO-E8mH2UMbs-sH4LY78+1VzJrkS+kGVKvYeQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] PM: domains: Do not call device_pm_check_callbacks()
 when holding genpd_lock()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> If PM domain on PREEMPT_RT is marked as GENPD_FLAG_RT_SAFE(), the
> genpd_lock() will be a raw spin lock, thus device_pm_check_callbacks()
> must be called outside of the domain lock.
>
> This solves on PREEMPT_RT:
>
>   [ BUG: Invalid wait context ]
>   6.1.0-rt5-00325-g8a5f56bcfcca #8 Tainted: G        W
>   -----------------------------
>   swapper/0/1 is trying to lock:
>   ffff76e045dec9a0 (&dev->power.lock){+.+.}-{3:3}, at: device_pm_check_callbacks+0x20/0xf0
>   other info that might help us debug this:
>   context-{5:5}
>   3 locks held by swapper/0/1:
>    #0: ffff76e045deb8e8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x38/0x1c0
>    #1: ffffa92b81f825e0 (gpd_list_lock){+.+.}-{4:4}, at: __genpd_dev_pm_attach+0x7c/0x250
>    #2: ffff76e04105c7a0 (&genpd->rslock){....}-{2:2}, at: genpd_lock_rawspin+0x1c/0x30
>   stack backtrace:
>   CPU: 5 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8
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
>
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/base/power/domain.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4dfce1d476f4..db499ba40497 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1666,10 +1666,14 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (ret)
>                 goto out;
>
> +
> +       /* PREEMPT_RT: Must be outside of genpd_lock */
> +       device_pm_check_callbacks(dev);
> +
>         genpd_lock(genpd);
>
>         genpd_set_cpumask(genpd, gpd_data->cpu);
> -       dev_pm_domain_set(dev, &genpd->domain);
> +       dev_pm_domain_set_no_cb(dev, &genpd->domain);
>
>         genpd->device_count++;
>         if (gd)

Rather than splitting up the assignment in two steps, I think it
should be perfectly fine to move the call to dev_pm_domain_set()
outside the genpd lock.

Note that, genpd_add_device() is always being called with
gpd_list_lock mutex being held. This prevents the genpd from being
removed, while we use it here.

Moreover, we need a similar change for the call to dev_pm_domain_set()
in genpd_remove_device().

> --
> 2.34.1
>

Kind regards
Uffe
