Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01D46119F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJ1SOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJ1SOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:14:48 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931D399D9;
        Fri, 28 Oct 2022 11:14:45 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id l28so3985556qtv.4;
        Fri, 28 Oct 2022 11:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97AQWmEatqBegigv9Bw4x+oKbVYTdEMST5QdXz0824I=;
        b=vUc2GBF562O4HY/dA/pAVRplF1OS5AGQmcNLUZLYaUTWJW0GSwrGDYHpRWuL54OTUi
         FsO0jiSfcK1LjZnKDsmzi6tED+m5d7WWxA1tYvdeKjlb/pu07y5fljNYu4bmGtg61Pyk
         PgwyxV+h4I90unAVSv3RW5OcbYrugFF4WIN+WXgKGb55PC5DVqoca5Qe9v/8ikkzHkEt
         iRUh/ue4tDppCpUqWlu0tL5qACu4udeuK0Q96OgBtv5fxwB9VC8hoKfl08XudfOtO51t
         N0A+RAzs5S+Ub9THdA2AVc/SDC4bzNNaXTbijTazmQQ1CslHZy1sOz8dCbMvUqm99ITX
         O5rA==
X-Gm-Message-State: ACrzQf2JfytnzNQ+ZgE8HPujYwnb1c69JCtqNLRDvaqFwYJHzmf+lWzS
        3fHDkCF3li4ZgsFa5Gl3eSspBM9CZldM1aZMSVk=
X-Google-Smtp-Source: AMsMyM4+IKWlCKddvGVb3fzRqd7M3BIPJLLB7Hxcrz30rb9HC1gnM7eG/qEU68m7Kz1QWCPg2C6CuATH5PO170aRIwg=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr670755qtb.147.1666980884970; Fri, 28
 Oct 2022 11:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221024144304.198689-1-abel.vesa@linaro.org>
In-Reply-To: <20221024144304.198689-1-abel.vesa@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 20:14:34 +0200
Message-ID: <CAJZ5v0hKhXfQhDdh-GSFSuW7NWCWLO1up+p7WrLe5Vz+bd2igw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Reverse the order of performance and
 enabling ops
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 5:52 PM Abel Vesa <abel.vesa@linaro.org> wrote:
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

Ulf, any comments?

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
> +       }
> +
>         return 1;
>
>  err:
> --
> 2.34.1
>
