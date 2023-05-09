Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90906FC99F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjEIOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjEIOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:54:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF83A80
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:54:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9a6d9dcbebso5250527276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683644065; x=1686236065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMoWAG5YcLWd7jHxPm4FwUTroek8lWQak19WkRdudgo=;
        b=Io/MN5XgfwjV4qEXrXT32vfMuqvum8Uppk+n3hqfOVTQ1gxgSj1XFABZv0bPjPfx2f
         zTw2QtEud5iDlPYOrkN4FfLhE63KI5GegvMmc0IJsLD57pEOdUUy1Ti4BygSEbQFg6Ox
         Y80vZPlPGVwTBUR2qjtAfCSMLLYSvLAnvRYXWPrud4kxDexFthHqWcydfo402zB4N1/c
         /EEDSSb4xG5/+qa8inlFTddjIMuXINnnhVfcZdRmk24Oakw89tXkYGpuROtu+AyviUFH
         7NB2jj9ldu3myKEheVxcuNALFIAKmIlNyn+PEbJVbGGZDQ4euzXQDFTzxRlEaBIWdL/X
         JQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644065; x=1686236065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMoWAG5YcLWd7jHxPm4FwUTroek8lWQak19WkRdudgo=;
        b=Pb9COs+o4Z5UrGxDcklLMAERtlEZeslGtVXjmsCq4p/O6rXMBoBmclDLBN+YRjDvc4
         Vo0xvYBoNsm6lBFNM+HsA99bgFqLLRPoVataLRB7ExVloyTY1Eacc3Br4Qb4x1Cyhpla
         f53L9/Tuv7uW4nG0daZgVCCyjWcxzKApLRjAxk4VfQjidALbryINsyMuBm350N5gU+5j
         7IcG9APwjcmgbCbwNIyKnhaZnWPaBiuHbofllRnP97+MVStDw1P43S6X2StFHShdqehf
         iOitv/Y8IMYPoD5Jw+3Ht6WDsO8kufDqGgPh4ZKzV/JFhkuk8hWKXh0cZik0kixBgdUM
         n1oQ==
X-Gm-Message-State: AC+VfDyarBR6QiF1FFTVYH7NsGd/TIg5WRMqzQYX4AHxBa20QLQj2VCw
        lsKSr0IhWIKBHhbjtldQSGy5KgLqalK4lzo7GCBg4w==
X-Google-Smtp-Source: ACHHUZ6XS+Ciur4SJIYYmUxd/gl1SYLo4597xYrxEiSUH/3NIDIuEChvMl/HS9/Wg+rGPbQFz9pgMzgViPVv95JQEcI=
X-Received: by 2002:a25:15ca:0:b0:b9e:2697:9d96 with SMTP id
 193-20020a2515ca000000b00b9e26979d96mr13164782ybv.3.1683644065358; Tue, 09
 May 2023 07:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230505150241.3469424-1-abel.vesa@linaro.org> <20230505150241.3469424-3-abel.vesa@linaro.org>
In-Reply-To: <20230505150241.3469424-3-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 16:53:49 +0200
Message-ID: <CAPDyKFrphhrA5a5NBVji6p_w8=acjgZhvL=HeOtqsng+MVdxhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] PM: domains: Skip disabling unused until sync state
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 17:02, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> By storing the status of the domain at boot, specified by the provider,
> we can decide to skip powering 'off' the domain on the late initcall,
> strictly based on the status boot being 'on' or 'unknown', and then
> assume the provider will disable it from its sync state callback.
> Also, provide a generic genpd sync state callback for those providers
> that only need that when they state synced.

If I understand correctly, this means that providers that don't use
the sync state callback, will be kept powered-on until the late
initcall, even if those could be turned off at an earlier point. Is
this really what we want?

>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 51 +++++++++++++++++++++++++++++++++++--
>  include/linux/pm_domain.h   |  5 ++++
>  2 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 33a3945c023e..9cc0ce43b47b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -125,6 +125,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_unlock(p)                        p->lock_ops->unlock(p)
>
>  #define genpd_status_on(genpd)         (genpd->status == GENPD_STATE_ON)
> +#define genpd_boot_keep_on(genpd)      (!(genpd->boot_status == GENPD_STATE_OFF))

This seems a bit unnecessarily complicated. Can't we just use bool in
the genpd struct, to track whether we should allow powering off or
not, based upon the boot condition.

>  #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>  #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> @@ -654,6 +655,29 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
>         queue_work(pm_wq, &genpd->power_off_work);
>  }
>
> +/**
> + * pm_genpd_power_off_unused_sync_state - Power off all domains for provider.
> + * @dev: Provider's device.
> + *
> + * Request power off for all unused domains of the provider.
> + * This should be used exclusively as sync state callback for genpd providers.
> + */
> +void pm_genpd_power_off_unused_sync_state(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       mutex_lock(&gpd_list_lock);
> +
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node)

It looks like we need the of_genpd_mutex here as well, as it's really
the list of providers that we want to protect too.

> +               if (genpd->provider->dev == dev && genpd_boot_keep_on(genpd)) {
> +                       genpd->boot_status = GENPD_STATE_OFF;

This needs to be done while holding the genpd's lock.

> +                       genpd_queue_power_off_work(genpd);
> +               }
> +
> +       mutex_unlock(&gpd_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_power_off_unused_sync_state);
> +
>  /**
>   * genpd_power_off - Remove power from a given PM domain.
>   * @genpd: PM domain to power down.
> @@ -674,6 +698,12 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>         unsigned int not_suspended = 0;
>         int ret;
>
> +       /*
> +        * If the domain was left enabled at boot stage,
> +        * abort power off until sync state is reached.
> +        */
> +       if (genpd_boot_keep_on(genpd))
> +               return -EBUSY;
>         /*
>          * Do not try to power off the domain in the following situations:
>          * (1) The domain is already in the "power off" state.
> @@ -763,6 +793,12 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>         struct gpd_link *link;
>         int ret = 0;
>
> +       /*
> +        * Just in case this is the first power on request, mark the boot
> +        * status of it as 'off'.
> +        */
> +       genpd->boot_status = GENPD_STATE_OFF;
> +
>         if (genpd_status_on(genpd))
>                 return 0;
>
> @@ -1095,8 +1131,16 @@ static int __init genpd_power_off_unused(void)
>
>         mutex_lock(&gpd_list_lock);
>
> +       /*
> +        * If the provider has registered a 'sync state' callback,
> +        * assume that callback will power off its registered unused domains,
> +        * otherwise we power them off from here.
> +        */
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> -               genpd_queue_power_off_work(genpd);
> +               if (!dev_has_sync_state(&genpd->dev)) {

The genpd->dev isn't really the one that is used by the genpd provider
driver, hence this doesn't work.

In the code you introduced above, you used the "genpd->provider->dev",
which is probably what we want here too, right?

> +                       genpd->boot_status = GENPD_STATE_OFF;

Updating this needs to be protected by the genpd's lock.

> +                       genpd_queue_power_off_work(genpd);
> +               }

The above said - I am concerned about having to hold each genpd's lock
in this path.

I realize that we need to update the genpd->boot_status at some point,
but let me think a bit if we can do that in a slightly better way,
without holding all the locks.

>
>         mutex_unlock(&gpd_list_lock);
>
> @@ -1124,6 +1168,9 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  {
>         struct gpd_link *link;
>
> +       if (genpd_boot_keep_on(genpd))
> +               return;
> +
>         if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
>                 return;
>
> @@ -2064,7 +2111,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->gov = gov;
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>         atomic_set(&genpd->sd_count, 0);
> -       genpd->status = boot_status;
> +       genpd->status = genpd->boot_status = boot_status;
>         genpd->device_count = 0;
>         genpd->provider = NULL;
>         genpd->has_provider = false;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index c545e44ee52b..86bb531a319c 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -132,6 +132,7 @@ struct generic_pm_domain {
>         const char *name;
>         atomic_t sd_count;      /* Number of subdomains with power "on" */
>         enum gpd_status status; /* Current state of the domain */
> +       enum gpd_status boot_status;    /* Boot state of the domain */
>         unsigned int device_count;      /* Number of devices */
>         unsigned int suspended_count;   /* System suspend device counter */
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
> @@ -233,6 +234,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                   struct dev_power_governor *gov,
>                   enum gpd_status boot_status);
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
> +void pm_genpd_power_off_unused_sync_state(struct device *dev);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
> @@ -281,6 +283,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>         return -EOPNOTSUPP;
>  }
>
> +static inline void pm_genpd_power_off_unused_sync_state(struct device *dev)
> +{ }
> +
>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>                                                      unsigned int state)
>  {

Kind regards
Uffe
