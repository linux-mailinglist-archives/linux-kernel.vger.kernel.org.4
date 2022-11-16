Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFE62BE94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiKPMsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiKPMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:48:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9231F2D7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:48:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id io19so16309701plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eSzffJBrVCy3/z2tnTtbEHU2Kk87PZcwLcd/j4teoJk=;
        b=eD1ioZZQaziEoFDL5ESBkSydCqoh9G9oa361VCF7qvpE3ci4+pwUEINbDg4TkxCDYd
         sETTbrv/j5w0PP+oIFheiGFkgYgN8HLKuuQcaRgYMlAwGpfFz8CzFCl1Ah/ppAxOn6J4
         DbxhwfjfZ5IqY8L2FT7qmh4ghbdgKRg3cI83G7kisvAGpCKts/cCUfQpCuxit5OiEiOl
         JQYxnveRBEIYNR1+YfZIpFeC0aJSNAUzUzfXoIU83Vsa3HoO9pbXCmLXZj8eGVYZGUUL
         GGItvK9kJ5EBX8BRLKsXtWwJ+yfthWXktUaKvSwagXaMYQC08RqUUE2eB+B2jEaGMIbZ
         CCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSzffJBrVCy3/z2tnTtbEHU2Kk87PZcwLcd/j4teoJk=;
        b=TrqLnlvv6codQSgMG03tK6y56cK1rmHtesF1IfvEJadl7vg+cPzuavS5PwTHcTtQq+
         zRl9kH8lCAxvk9fDXlZrNVPiPn+DexmPT6Q344TJU1iQ788qHLtuczQnh52nPSu9WqNS
         OvTMPh0sdpzxEQfi1CvzZJEiaie+XyI+1NzWyXoJgm2rbb3avwS4tB9OQxt6jL9fz30z
         WYoWbk7w4PJ7pWZd09Ds4Ri8z47mGMdU9IdmcbNhmN5ZBuHIsIgoTVoVT6/g6sggK72r
         D9lrO6L8ubmqP8F+unIqY92ga+LEybc228+Gc5h71GEJuMjHum7xDZGHfHtVG/FMtDn6
         pXPg==
X-Gm-Message-State: ANoB5pl5E5vhJ+H5yQLE70oj02osWanvINPDFhn81nwwTiGNrTuSm5Mx
        JZbqMebSypp+715994LzDFQGA4HtPolFoOXAp9L3Ow==
X-Google-Smtp-Source: AA0mqf5KENeqGQxFf+C610MaiXm0MBtK1RuUC3P9xWHLORKcjGEacy32+GzcOKr3LRHkSICCcxE1LctpchyL1JoFxLk=
X-Received: by 2002:a17:90a:138a:b0:213:dce7:e12b with SMTP id
 i10-20020a17090a138a00b00213dce7e12bmr3638670pja.164.1668602893191; Wed, 16
 Nov 2022 04:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20221115212543.1745498-1-abel.vesa@linaro.org>
In-Reply-To: <20221115212543.1745498-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 13:47:36 +0100
Message-ID: <CAPDyKFoTWrei3QdL27bAtUFOidZ7FsQ41CdY31vxh6NwNEEWWw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Reverse the order of performance and
 enabling ops
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 at 22:25, Abel Vesa <abel.vesa@linaro.org> wrote:
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes since v1:
>  - Added performance state drop on power on failure, like Ulf suggested
>
>  drivers/base/power/domain.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e5f4e5a2eb9e..967bcf9d415e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -964,8 +964,8 @@ static int genpd_runtime_suspend(struct device *dev)
>                 return 0;
>
>         genpd_lock(genpd);
> -       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_power_off(genpd, true, 0);
> +       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_unlock(genpd);
>
>         return 0;
> @@ -1003,9 +1003,8 @@ static int genpd_runtime_resume(struct device *dev)
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
> @@ -1043,8 +1042,8 @@ static int genpd_runtime_resume(struct device *dev)
>  err_poweroff:
>         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
>                 genpd_lock(genpd);
> -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>                 genpd_power_off(genpd, true, 0);
> +               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>                 genpd_unlock(genpd);
>         }
>
> @@ -2733,17 +2732,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
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
> @@ -2755,6 +2743,24 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
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
> +               /* Drop the default performance state */
> +               if (dev_gpd_data(dev)->default_pstate) {
> +                       dev_pm_genpd_set_performance_state(dev, 0);
> +                       dev_gpd_data(dev)->default_pstate = 0;
> +               }
> +
> +               genpd_remove_device(pd, dev);
> +               return -EPROBE_DEFER;
> +       }
> +
>         return 1;
>
>  err:
> --
> 2.34.1
>
