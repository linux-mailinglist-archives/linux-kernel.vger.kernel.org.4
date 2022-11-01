Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7961475B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKAKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKAKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:01:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13AC18E03
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:01:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so939800pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C5MT9pFJPIFyMQMUqsCPf2dIxLdEeAaS7OZYyjwAin4=;
        b=vLrovUn7NN6GLFWxM1wONYTxkGW3zbxw/+nu7rVxO7HcBM/vAG2IwkiAHvFnOrItf3
         APw52AtM3dtCiRg4x64sL9KpCRKzqfdKY9IrNBoO7ycNCzApUmKH/4qDPeUifjFvogh5
         ntHtGiLd16NHpuIzGrIKPzy8ys9kB/FQdX+50+szel1d5F+QM0fOsCBoCD93+7ZTwqag
         ktsWM9r2nMNuJ8DcECmRCl5gSgg/V5lyyCb1loueGEuNh0AxDUJzIUnlujA2M56DxD0p
         ok4U9A3YXV882ayb/Vi0PdowV1SObTNd6DqUgcznflh8q3Vu2E4MTvClKy9jjzk+Vtiv
         xMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5MT9pFJPIFyMQMUqsCPf2dIxLdEeAaS7OZYyjwAin4=;
        b=2Ak8+9h4JKBYVHKbrArjWTqayJe5g0orC+YChqrZFBreF+DPu4BScV3rP6aMM8M1hh
         yLYMqYIATyeAoUsVx3TjQmiJ17IfZGswFBzMNDWOP403mlMV06s1bA/F+Ant3YF9mmZP
         IcDWBFR52JT1Zh2deZhTzNXWKzibEQBAiqH2URQ1EVUraz+zEnf8quB29tyRVljK3sCx
         ItDVjonhJMuqchpx8IbZVtQWBdPQG3RFAQgd7r/2QAY8Z+hdgTWkJdxdssiMI2U/H32O
         6/OQt65eot2YWDQTEe3DWXgZTocpXsnrHedNrwWCWBXPxBFtCGNnpasoG6jjUXM9/w7e
         3ozw==
X-Gm-Message-State: ACrzQf1NZb+A7UsmKhRrLpJzVT1ApapF/uY2QeFvmRmZr9AbMav0XVBg
        B7cFskENKiX6XuLAzMlJ8ODhgVKLCibrNqIQmbiTWw==
X-Google-Smtp-Source: AMsMyM4bHEnfRhWl+iQhLC/OofGxaCzQnfDqCYyhMSIu6O+SCD51XE5TGkp7lLwyJtkmRS3ZUhUKFRlCYfkx1guE0Cw=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr19241016plb.148.1667296860898; Tue, 01
 Nov 2022 03:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024144304.198689-1-abel.vesa@linaro.org>
In-Reply-To: <20221024144304.198689-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Nov 2022 11:00:23 +0100
Message-ID: <CAPDyKFq1fvKBtPhmd3YbYcg-hWPRkqGoB=-f8SwTG2OSiKjzdw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Reverse the order of performance and
 enabling ops
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 at 16:44, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The ->set_performance_state() needs to be called before ->power_on()
> when a genpd is powered on, and after ->power_off() when a genpd is
> powered off. Do this in order to let the provider know to which
> performance state to power on the genpd, on the power on sequence, and
> also to maintain the performance for that genpd until after powering off,
> on power off sequence.
>
> There is no scenario where a consumer would need its genpd enabled and
> then its performance state increased. Instead, in every scenario, the
> consumer needs the genpd to be enabled from the start at a specific
> performance state.
>
> And same logic applies to the powering down. No consumer would need its
> genpd performance state dropped right before powering down.
>
> Now, there are currently two vendors which use ->set_performance_state()
> in their genpd providers. One of them is Tegra, but the only genpd provider
> (PMC) that makes use of ->set_performance_state() doesn't implement the
> ->power_on() or ->power_off(), and so it will not be affected by the ops
> reversal.
>
> The other vendor that uses it is Qualcomm, in multiple genpd providers
> actually (RPM, RPMh and CPR). But all Qualcomm genpd providers that make
> use of ->set_performance_state() need the order between enabling ops and
> the performance setting op to be reversed. And the reason for that is that
> it currently translates into two different voltages in order to power on
> a genpd to a specific performance state. Basically, ->power_on() switches
> to the minimum (enabling) voltage for that genpd, and then
> ->set_performance_state() sets it to the voltage level required by the
> consumer.
>
> By reversing the call order, we rely on the provider to know what to do
> on each call, but most popular usecase is to cache the performance state
> and postpone the voltage setting until the ->power_on() gets called.
>
> As for the reason of still needing the ->power_on() and ->power_off() for a
> provider which could get away with just having ->set_performance_state()
> implemented, there are consumers that do not (nor should) provide an
> opp-table. For those consumers, ->set_performance_state() will not be
> called, and so they will enable the genpd to its minimum performance state
> by a ->power_on() call. Same logic goes for the disabling.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ead135c7044c..e66a711fec88 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
>                 return 0;
>
>         genpd_lock(genpd);
> -       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_power_off(genpd, true, 0);
> +       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_unlock(genpd);
>
>         return 0;
> @@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
>                 goto out;
>
>         genpd_lock(genpd);
> +       genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
>         ret = genpd_power_on(genpd, 0);
> -       if (!ret)
> -               genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
>         genpd_unlock(genpd);
>
>         if (ret)
> @@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
>  err_poweroff:
>         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
>                 genpd_lock(genpd);
> -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>                 genpd_power_off(genpd, true, 0);
> +               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>                 genpd_unlock(genpd);
>         }
>
> @@ -2749,17 +2748,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>         dev->pm_domain->detach = genpd_dev_pm_detach;
>         dev->pm_domain->sync = genpd_dev_pm_sync;
>
> -       if (power_on) {
> -               genpd_lock(pd);
> -               ret = genpd_power_on(pd, 0);
> -               genpd_unlock(pd);
> -       }
> -
> -       if (ret) {
> -               genpd_remove_device(pd, dev);
> -               return -EPROBE_DEFER;
> -       }
> -
>         /* Set the default performance state */
>         pstate = of_get_required_opp_performance_state(dev->of_node, index);
>         if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
> @@ -2771,6 +2759,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                         goto err;
>                 dev_gpd_data(dev)->default_pstate = pstate;
>         }
> +
> +       if (power_on) {
> +               genpd_lock(pd);
> +               ret = genpd_power_on(pd, 0);
> +               genpd_unlock(pd);
> +       }
> +
> +       if (ret) {
> +               genpd_remove_device(pd, dev);
> +               return -EPROBE_DEFER;

If we manage to request a default performance state
(dev_gpd_data(dev)->default_pstate != 0) a few lines above, we should
probably drop that request before returning here.

Similar to what we do in genpd_dev_pm_detach().

> +       }
> +
>         return 1;
>
>  err:

Other than the rather small thing above, this looks good to me!

Kind regards
Uffe
