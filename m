Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E474735B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGDNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGDNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:55:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF1F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:55:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c581c758ad8so1824368276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688478904; x=1691070904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbInuMOaeGH2/pfUXBP7Ae3B0+gOG6gDsXRs6oqX8sQ=;
        b=B68oywBDw6QM9sPH3nKNiCHT/pSIoiCPuIIkzAkCxCa8GJ5lpYfWjfDdH0trlCaTJd
         2xK/cpi/YT3sxzulpr3nj7jYseH50FY4ahSlV4PfRQzRvZwgKh9pOb4hfs8EwW4ovnNp
         Ju6CXm1AvuUp/Y4cp94R1qefX9ERrpQJto1M4iRQiIQEMybWzU4iCYjJLHo1UEZC95Tt
         +EgY7Q8FnyB6hjhllftqxmwgCaqTUMtD6gKvd9Wsaj1XoO7T+70WMobYUaP3QofKXC1I
         52FEykZzJyaJMWXRy27mu3oi48ll39hqlYQKQoZUMp4JlG1KCgZejX9l2AG1uFWaxBPY
         6PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478904; x=1691070904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbInuMOaeGH2/pfUXBP7Ae3B0+gOG6gDsXRs6oqX8sQ=;
        b=TjyKbartPKAKaI85IAXmC0NWlNPUcM2weYPpM8fIatZaCJoqQlmOt2vVuzJAKS6/b2
         U7Udfwr3+f0jezGdFBIt0MSbOEKZKWXWhAVt+5NiXVFtzX69pTeEyjgo0qtDvNcmS6/U
         Phc5R3bXXKevH/HJaSWyMCodErSOPwvGqNe7CgGEoHGPkZ2eWoFyeBuIjrH/PFDFHUM0
         Sfm/uFEnHCUP8I0sN7rGIqgn4Im2keLtdd9fzRfuZHLWm4DLMNiZ+cUKYvLUCyriUybK
         dnoYryfSed8aWK195Nd9yGGNQJEunucCXHi1d1U2oxLuGrg3uiesqqvjdc1vbMiILvxp
         uKkQ==
X-Gm-Message-State: ABy/qLacLdlYOQfO6KOjh29NpkumKE5HQbpvRi4fzNbZgN7YkUiyPaDp
        Xeliz38jyEZ9SbI2ZTfLHQw1ONtXioPTZXQ+lWpkgw==
X-Google-Smtp-Source: APBJJlE/ZZiKuvpdnr9LwWHHgdmOPydDsK5lYvgSF5VC1VJFhX6g20gb+lSl/bQIvqlE5yD64J2YYrOM5X4CtMON5GA=
X-Received: by 2002:a25:b326:0:b0:c01:287b:41f9 with SMTP id
 l38-20020a25b326000000b00c01287b41f9mr10447897ybj.59.1688478904309; Tue, 04
 Jul 2023 06:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144019.3219858-1-abel.vesa@linaro.org> <20230621144019.3219858-5-abel.vesa@linaro.org>
In-Reply-To: <20230621144019.3219858-5-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Jul 2023 15:54:28 +0200
Message-ID: <CAPDyKFpPNYYxECPpk0Qbos70WeZgOXCtu7qXGGzvLLizzrdjtA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 4/4] PM: domains: Add and set generic sync state callback
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
> For every provider that doesn't register a sync_state callback,
> register a generic one. This new generic sync_state callback queues up a
> power off request.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 23 +++++++++++++++++++++++
>  include/linux/pm_domain.h   |  3 +++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5967ade160e2..ec16db0599ac 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -654,6 +654,27 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
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
> +               if (genpd->provider && genpd->provider->dev == dev)

Not all genpds have the ->provider assigned. Moreover, the
of_genpd_mutex is protecting the list of providers, we should use that
instead.

> +                       genpd_queue_power_off_work(genpd);
> +
> +       mutex_unlock(&gpd_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_power_off_unused_sync_state);

Why does this need to be exported? Is there a provider that assigns
it's own sync state callback that needs to call this? If that is the
case, I would prefer to see a user of this API as a part of the series
too.

> +
>  /**
>   * genpd_keep_on - Tells if the domain should skip the power 'off' request
>   * @genpd: PM domain to be checked.
> @@ -2329,6 +2350,8 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>         cp->xlate = xlate;
>         fwnode_dev_initialized(&np->fwnode, true);
>
> +       dev_set_drv_sync_state(np->fwnode.dev, pm_genpd_power_off_unused_sync_state);
> +
>         mutex_lock(&of_genpd_mutex);
>         list_add(&cp->link, &of_genpd_providers);
>         mutex_unlock(&of_genpd_mutex);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3eb32c4b6d4f..78164244b89f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -279,6 +279,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
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
