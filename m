Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABA7472B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGDNY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGDNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:24:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338611D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:24:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c581c758ad8so1793943276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688477094; x=1691069094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XammPMRuFbJ7jZvdGT2m8llzDSyROEzD+mjdnEUmkvA=;
        b=d9WuFsaAYWcDLGtG3g5xafjQ2hE1ahocHZmcqZdYkuyPYnfAcrDb8ZQhyYdcmNIE9N
         cgfpjNvVr5B3wJriRNKorSj33dHjFdwSWcXtPfHyntNFnqU2ptxbKKApVZHAnZdmvZ3k
         EUCG9WQkMOK7FLMLQ8/NwM+8kD9GAej/lrESP98M+/F/Q59YukYe9MlNy64w75zhsAuo
         zEqyzmfvMFdp01dGuDuvi2ywTxUEOYgZpVjnYYZxpMtcgOGJ1mcHkHbhNkNZZBDSaNoh
         mGcKG2wq/YgMmLlV2wVT+zu2IxfJs1E7G/V4mjIsD8Hu7QXkno6bOlIknjpo6+qjVMT9
         io1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477094; x=1691069094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XammPMRuFbJ7jZvdGT2m8llzDSyROEzD+mjdnEUmkvA=;
        b=CToUrA1OXsWsBoCdoaIFyc2l4RtFdwHXBtzf1MVmR2KItUWE5nwwheVswYjxSHG+2V
         LaS5FeZhWchnhkA6PwdwND9q85ZbYZfdQOpKtlaasW1lkXdZA42N8Cb+hqn9Szfgx7Vb
         BhTXVeLalyojtvLpD2oS0AGsaBJQ8ZUoKjla8rbQYS35bLnaXrAMyMncpfExALAYozsY
         B1uamgu6lvEQ3uQxNPkdQv7UTtdV6Nh1hLOGgQ46mO29MmqZhWjM9+UWWkXds2oDIyiV
         9QBffIjbFkpZWsftedWUpHgLg+Qw7VGlmjWDAwItAcVgMbnmKQd5rl80fvvAEvrPPaLI
         tgsQ==
X-Gm-Message-State: ABy/qLbiwkbnKW8XQ5bNSzxRCCzf0IJTPe+wU6pwuTAbFHOVHhw0qLeH
        9zak4IJGTvH7JyfCp05T82CuRv6mmGOqhebZlmFKmA==
X-Google-Smtp-Source: APBJJlGumq+4hgA+gyaUbNRmbE2j9Mkzri7JWnTYYJEuFB1a9lo4lfPsWVBAW+46oQ8bdNhAddsq/k6xPGoPq6dz5jI=
X-Received: by 2002:a5b:243:0:b0:bcb:b9c3:f738 with SMTP id
 g3-20020a5b0243000000b00bcbb9c3f738mr10026998ybp.53.1688477093854; Tue, 04
 Jul 2023 06:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144019.3219858-1-abel.vesa@linaro.org> <20230621144019.3219858-4-abel.vesa@linaro.org>
In-Reply-To: <20230621144019.3219858-4-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Jul 2023 15:24:17 +0200
Message-ID: <CAPDyKFqczOR0GjdCpe=C5r8=RWQ9nkhMNP_Nok5_Jkw+LaSahw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/4] PM: domains: Ignore power off request for
 enabled unused domains
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Wed, 21 Jun 2023 at 16:40, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> First of, safekeep the boot state that is provided on init, then use this
> boot state to make decisions whether a power off request should be
> ignored or not. In case a domain was left enabled before boot, most
> likely such domain is needed and should not be disabled on the 'disable
> unused' late initcall, but rather needs to stay powered on until the
> consumer driver gets a chance to probe. In order to keep such domain
> powered on until the consumer handles it correctly, the domain needs to
> be registered by a provider that has a sync_state callback registered
> and said provider has state synced.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 49 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 51b9d4eaab5e..5967ade160e2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -654,6 +654,43 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
>         queue_work(pm_wq, &genpd->power_off_work);
>  }
>
> +/**
> + * genpd_keep_on - Tells if the domain should skip the power 'off' request
> + * @genpd: PM domain to be checked.
> + *
> + * If the domain's current state meets the following conditions:
> + *  - marked for being kept as enabled
> + *  - has a provider with a sync state callback registered
> + *  - the provider hasn't state synced yet
> + * then the power 'off' request should be skipped.
> + *
> + * This function should only be called from genpd_power_off and with
> + * the lock held.
> + */
> +static inline bool genpd_keep_on(struct generic_pm_domain *genpd)
> +{
> +       bool ret = false;
> +
> +       if (!(genpd->boot_keep_on))
> +               return false;
> +
> +       if (!genpd->has_provider)
> +               goto out;

Hmm, resetting the boot_keep_on flag based on the above condition
isn't really working, I think.

genpd_power_off() may be called before/after there is an OF provider
assigned/removed for the genpd. With the current genpd APIs
(pm_genpd_init() and of_genpd_add_provider_*()), we have at least two
separate function calls to complete the initialization of the genpd
provider(s). Theoretically, we can't know when genpd_power_off() may
be called, especially if there are child-domains being used too.

It looks to me that we should not clear the boot_keep_on flag at all
in this path. Instead, we should rather bail out and return false, to
prevent the genpd from being powered off. Although this should be fine
for most cases, we have some genpd providers, which don't use OF
providers at all (pm-s3c64xx, amdgpu_acp). To deal with these cases,
we seem to need an opt-out solution (maybe a new genpd configuration
bit) that they can set, before calling pm_genpd_init().

That said, it looks like the genpd->has_provider seems not to be
entirely protected by the genpd lock (not in this path, but in other
paths in genpd). I think we need to fix that too, in some way or the
other.

> +
> +       if (!dev_has_sync_state(genpd->provider->dev))
> +               goto out;
> +
> +       if (dev_is_drv_state_synced(genpd->provider->dev))
> +               goto out;
> +
> +       return true;
> +
> +out:
> +       genpd->boot_keep_on = false;
> +
> +       return ret;
> +}
> +
>  /**
>   * genpd_power_off - Remove power from a given PM domain.
>   * @genpd: PM domain to power down.
> @@ -682,6 +719,13 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>         if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
>                 return 0;
>
> +       /*
> +        * If the domain is enabled and unused, bail out and ignore
> +        * the 'off' request until the provider has state synced.
> +        */
> +       if (genpd_keep_on(genpd))
> +               return -EBUSY;
> +
>         /*
>          * Abort power off for the PM domain in the following situations:
>          * (1) The domain is configured as always on.
> @@ -2065,6 +2109,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         atomic_set(&genpd->sd_count, 0);
>         genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
>         genpd->device_count = 0;
> +       genpd->boot_keep_on = !is_off;
>         genpd->provider = NULL;
>         genpd->has_provider = false;
>         genpd->accounting_time = ktime_get_mono_fast_ns();
> @@ -2718,6 +2763,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>         if (IS_ERR(pd))
>                 return;
>
> +       genpd_lock(pd);
> +       pd->boot_keep_on = false;

This should not be needed. I think you can drop this.

> +       genpd_unlock(pd);
> +
>         genpd_queue_power_off_work(pd);
>  }
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f776fb93eaa0..3eb32c4b6d4f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -131,6 +131,7 @@ struct generic_pm_domain {
>         const char *name;
>         atomic_t sd_count;      /* Number of subdomains with power "on" */
>         enum gpd_status status; /* Current state of the domain */
> +       bool boot_keep_on;      /* Keep enabled during 'disable unused' late initcall */
>         unsigned int device_count;      /* Number of devices */
>         unsigned int suspended_count;   /* System suspend device counter */
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */

Kind regards
Uffe
