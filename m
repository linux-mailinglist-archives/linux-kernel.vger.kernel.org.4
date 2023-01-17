Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8866E225
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjAQP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjAQP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:28:01 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18B41B42
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:27:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 20so6564096plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gobzy2RWh1vkr75dKqDRtJk/P/N6hPvkHDSqKPoN9mg=;
        b=FSO4Anby4vf8KMsQOkMMkuFByuQQThhnyuRaD6/Iqv+zsm/0UTLOFPq4glPCSa6h9f
         FzJ8C1MFy8IkX/KoXDImV9Kdcmqrh7zQNldMmYlQoDM3axnDy0lAjfRoVts9AHtEnuWM
         4u3HWA9IVdbOk10L0WZgzEI1MHqu+xeVZ66rP7od2d5tC8N2dzaVoKirPeoKw8xXEsnI
         R2NS+o56Szm2GCV1OQkbX8k3Cqbbhm9YLyIeBfDqjzC1zg7OpwytFfkX/XTMoD5PY0my
         zgFu3yoyjrDVkF3zcqgQUu5r90hPuyrusgrTzZB/j4zPh4ORbXo5P4JTgbWGKhkUYJJK
         79Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gobzy2RWh1vkr75dKqDRtJk/P/N6hPvkHDSqKPoN9mg=;
        b=t7k3pIHHDHr6ubAu+CPP80y0YTPiTJdWm7JK11X8Ganj4MVm9gSQeMX45+tdc3luj2
         ZUF7MI3QH8ieMcbiolNhCMRgK2QLzzjpz1LFjbBrDK8f8seEXQBUWZbywcJ4P/i4kThq
         YkzLoMvZu2XqbtQRt4/Nn4rB+JiIUOSBRnAr9m1+OCugzFGgnLRR0iivPKmLkg963zUB
         9X8/IlyWB9xv9dWQtD6tT6jScARAo0FT9oOUksxx4mw4keqPUdNxelhbOZiGIUARk8wL
         2BPqmk/mVjLJOFsRHyL2hKCtw07MfTlOkrYz0gcC/AnXXbTs5FY7ucDPw1MwQEmWqfgJ
         0/+g==
X-Gm-Message-State: AFqh2kqX6CwM8yPkqQSZ/yPO/WeHwOLyRQBHHpnz9ePD+4VGvacn04Gm
        +oFYSV79nYz9iTP+L+VlLUFC1BBRh+qcCvJfmFsNnA==
X-Google-Smtp-Source: AMrXdXu8aE8vDN73XMbQCM3e4NayaEJRfnIWh3H8kCDPmUH1kqA18EU12WhE/pSyGOPJ2Np0SpL8zjT5+IuytD/479k=
X-Received: by 2002:a17:90a:730a:b0:229:7d95:a476 with SMTP id
 m10-20020a17090a730a00b002297d95a476mr364182pjk.84.1673969277822; Tue, 17 Jan
 2023 07:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org> <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Jan 2023 16:27:21 +0100
Message-ID: <CAPDyKFr=-Mts4QtdizW5-D5qO3aP=9ODMhgST4Nx74n5xXxi5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The PSCI cpuidle power domain in power_off callback uses
> __this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in
> Realtime kernels and solves errors like:
>
>   BUG: scheduling while atomic: swapper/2/0/0x00000002
>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>   Call trace:
>    dump_backtrace.part.0+0xe0/0xf0
>    show_stack+0x18/0x40
>    dump_stack_lvl+0x68/0x84
>    dump_stack+0x18/0x34
>    __schedule_bug+0x60/0x80
>    __schedule+0x628/0x800
>    schedule_rtlock+0x28/0x5c
>    rtlock_slowlock_locked+0x360/0xd30
>    rt_spin_lock+0x88/0xb0
>    genpd_lock_nested_spin+0x1c/0x30
>    genpd_power_off.part.0.isra.0+0x20c/0x2a0
>    genpd_runtime_suspend+0x150/0x2bc
>    __rpm_callback+0x48/0x170
>    rpm_callback+0x6c/0x7c
>    rpm_suspend+0x108/0x660
>    __pm_runtime_suspend+0x4c/0x8c
>    __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
>    psci_enter_domain_idle_state+0x18/0x2c
>    cpuidle_enter_state+0x8c/0x4e0
>    cpuidle_enter+0x38/0x50
>    do_idle+0x248/0x2f0
>    cpu_startup_entry+0x24/0x30
>    secondary_start_kernel+0x130/0x154
>    __secondary_switched+0xb0/0xb4
>
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index c80cf9ddabd8..d15a91fb7048 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -62,7 +62,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>         if (!pd_provider)
>                 goto free_pd;
>
> -       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> +       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_RT_SAFE | \
> +                    GENPD_FLAG_CPU_DOMAIN;

My main concern with this, is that it will affect the parent domains
too. Whether those would be able to use the GENPD_FLAG_RT_SAFE or not,
is a different story.

In one way or the other, I think it would be better to limit the
GENPD_FLAG_RT_SAFE to be used only for PREEMPT_RT kernels.

>
>         /* Allow power off when OSI has been successfully enabled. */
>         if (use_osi)
> --
> 2.34.1
>

Kind regards
Uffe
