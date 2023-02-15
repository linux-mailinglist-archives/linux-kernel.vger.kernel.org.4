Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A499697B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjBOL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjBOL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:58:33 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA12FF04
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:58:31 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n2so12357377pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676462310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iyovd/Dha7A89L4EPh+Q/qSsUwAvTTMJN53nXu7zGys=;
        b=XTpqPwh3gWAnki95S8puPpl0H0S0gBF60yF3WHrqCBqLn0o+VDDhANTe9lHwTNjcMS
         7WJiiyT+RY9khmZWAwK1F6+wJxO8Sx3qJm5M1O+4Inn5H3161J41uSCJzfUqmcNO+CcK
         wNWfo8z3D4uUytw+O2ZoWUR9Mwvc/5vUgqX3NBQdGBQkzG863+c2psSxVIibpLhuyGeV
         vTy2mh9WlZVbwpZv0HurX0fZ83el9A0coEEILUs45wzM5Mpq2RALS5knxVMMMP7bZJj1
         0d02Fz7jz8ERWhpIZXeioDf9qPmjW021HHBGYoexFMUhCW3KwiZggzeY/gdPNMfWfiH9
         FFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676462310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iyovd/Dha7A89L4EPh+Q/qSsUwAvTTMJN53nXu7zGys=;
        b=emdqol+kf/epP1/KbKWryMqbygHIL6n27rnBsybPQKp/nONdmsk10NeInBAVvQ4Bqp
         y6lHzK/KQobcZtwcY4H/Q6yeCLnF/Yx+vrwnhXiMpggaSdc4TA4jkJXYhwILU4m3txFb
         vacb6L+5F/QQNPAakq+KVxmDUfq+jSMBQr559tcuy6Mcuy4bXzxbn6S6Qf2iZ2DQW06d
         Zz18JThuufgGUS7NFLgHt3DntesevA8vPFSaXpNlmTS6qhx0ZgCDkgyUnxxhAq1CCe0Q
         GKG34XSLOc5WMwRfrplSELRWiwDZC0kOKzmD9YmqerG8tSR7eLLeaOshnbBMRYKLY5k3
         KLbA==
X-Gm-Message-State: AO0yUKUFikSVlYdLcDLHBaaOCKedOFVCKyRnT4/QnKl33WhM9urD0Ms9
        uGL3tA7JkBBaIhSR/uqAHtoMUtX1B540xI5D2WEnyQ==
X-Google-Smtp-Source: AK7set/Za4Jn0WPzezUn7SAUozXl4zWfHmxQz0ZodvbDSjFH2tNr7+Xm6nfUZRG6LQdURmj8BSJSj7zwQGERdeBpaOw=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr279345pfk.40.1676462310487; Wed, 15 Feb
 2023 03:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20230127104054.895129-1-abel.vesa@linaro.org>
In-Reply-To: <20230127104054.895129-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Feb 2023 12:57:54 +0100
Message-ID: <CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
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

On Fri, 27 Jan 2023 at 11:40, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Currently, there are cases when a domain needs to remain enabled until
> the consumer driver probes. Sometimes such consumer drivers may be built
> as modules. Since the genpd_power_off_unused is called too early for
> such consumer driver modules to get a chance to probe, the domain, since
> it is unused, will get disabled. On the other hand, the best time for
> an unused domain to be disabled is on the provider's sync_state
> callback. So, if the provider has registered a sync_state callback,
> assume the unused domains for that provider will be disabled on its
> sync_state callback. Also provide a generic sync_state callback which
> disables all the domains unused for the provider that registers it.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>
> This approach has been applied for unused clocks as well.
> With this patch merged in, all the providers that have sync_state
> callback registered will leave the domains enabled unless the provider's
> sync_state callback explicitly disables them. So those providers will
> need to add the disabling part to their sync_state callback. On the
> other hand, the platforms that have cases where domains need to remain
> enabled (even if unused) until the consumer driver probes, will be able,
> with this patch in, to run without the pd_ignore_unused kernel argument,
> which seems to be the case for most Qualcomm platforms, at this moment.

My apologies for the somewhat late reply. Please see my comments below.

>
> The v1 is here:
> https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/
>
> Changes since v1:
>  * added a generic sync state callback to be registered by providers in
>    order to disable the unused domains on their sync state. Also
>    mentioned this in the commit message.
>
>  drivers/base/power/domain.c | 17 ++++++++++++++++-
>  include/linux/pm_domain.h   |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 84662d338188..c2a5f77c01f3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
>         mutex_lock(&gpd_list_lock);
>
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> -               genpd_queue_power_off_work(genpd);
> +               if (!dev_has_sync_state(genpd->provider->dev))

Unfortunately, this doesn't really help, due to the fact that a
genpd's ->power_off() callback may get called anyway. At power off,
the genpd core only cares about those consumers that are currently
attached, not those that might get attached at some point later in
time.

In other words, it's the responsibility for each specific genpd
provider to cope with the condition that its ->sync_state() callback
may *not* have been called, while its ->power_off() callback is being
called.

In these cases, the genpd provider should probably make the
->power_off() callback to return -EBUSY. This is what we do in
psci_pd_power_off(), for example.

> +                       genpd_queue_power_off_work(genpd);
>
>         mutex_unlock(&gpd_list_lock);
>
> @@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
>  }
>  late_initcall(genpd_power_off_unused);
>
> +void genpd_power_off_unused_sync_state(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       mutex_lock(&gpd_list_lock);
> +
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> +               if (genpd->provider->dev == dev)
> +                       genpd_queue_power_off_work(genpd);
> +
> +       mutex_unlock(&gpd_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);

I don't think this function is needed at all.

In fact, this part of the problem that you are trying to solve should
already be managed by the driver core, as it calls
dev->pm_domain->sync() (which is assigned to genpd_dev_pm_sync()) , in
really_probe(). Or isn't that taking care of the problem for you?

> +
>  #ifdef CONFIG_PM_SLEEP
>
>  /**
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f776fb93eaa0..1fd5aa500c81 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>                                          unsigned int index);
>  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>                                            const char *name);
> +void genpd_power_off_unused_sync_state(struct device *dev);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>                                         struct generic_pm_domain *genpd)
> @@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
>         return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +static inline genpd_power_off_unused_sync_state(struct device *dev) {}
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
>  #ifdef CONFIG_PM
> --
> 2.34.1
>

Kind regards
Uffe
