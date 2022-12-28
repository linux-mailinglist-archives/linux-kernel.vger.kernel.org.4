Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179236585D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiL1SnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiL1SnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:43:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BA11277B;
        Wed, 28 Dec 2022 10:43:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F2561562;
        Wed, 28 Dec 2022 18:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ED9C433F0;
        Wed, 28 Dec 2022 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672252987;
        bh=FMJ5UprBCwio09MGzEBkUZaQkPXuO1St7XOYtOcq3Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6FBiBiHDhwAsFIJNB1hrFP7NA11M+ifgxvfPjZe8sppWBJesiG+sQKAG3vwPUsWS
         nuDCIzxJZLuygfp1EfMEcl+7QMxwXFjf4C00CE0VPzs8TWnP/WLl+G4cS7JbZm9nzl
         5qleLgrKBaoDOksDzEgE+p+1H9UoHntcA26Je/9XFinRdAjU4R+2PjeXllRqEbz0zo
         kuTC9AqebM5bpHz6NPsp7U1IRH2K4I8bSiFpjwrMXpy94YQZ0Oe8+W8A2MuyZNZuPf
         8P8oPw0b6Ds3FcUVxYo8b9bDbsNDE7/5V47PiYD+TSA6qnRXjhc6tCDswU49mMr+QF
         fpazVm/rSojjA==
Date:   Wed, 28 Dec 2022 12:43:04 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] PM: domains: Allow a genpd consumer to require a
 synced power off
Message-ID: <20221228184304.4lldh7dxp2pnplzc@builder.lan>
References: <1671642843-5244-1-git-send-email-quic_akhilpo@quicinc.com>
 <20221221224338.v4.1.I3e6b1f078ad0f1ca9358c573daa7b70ec132cdbe@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221224338.v4.1.I3e6b1f078ad0f1ca9358c573daa7b70ec132cdbe@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:43:59PM +0530, Akhil P Oommen wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Some genpd providers doesn't ensure that it has turned off at hardware.
> This is fine until the consumer really requires during some special
> scenarios that the power domain collapse at hardware before it is
> turned ON again.
> 
> An example is the reset sequence of Adreno GPU which requires that the
> 'gpucc cx gdsc' power domain should move to OFF state in hardware at
> least once before turning in ON again to clear the internal state.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

@Rafael, would you be willing to share an immutable branch with this
change? Or would you be okay with me doing so from the qcom clock tree?

Regards,
Bjorn

> ---
> 
> Changes in v4:
> - Update genpd function documentation (Ulf)
> 
> Changes in v2:
> - Minor formatting fix
> 
>  drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 967bcf9d415e..84662d338188 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -519,6 +519,31 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_get_next_hrtimer);
>  
> +/*
> + * dev_pm_genpd_synced_poweroff - Next power off should be synchronous
> + *
> + * @dev: A device that is attached to the genpd.
> + *
> + * Allows a consumer of the genpd to notify the provider that the next power off
> + * should be synchronous.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + */
> +void dev_pm_genpd_synced_poweroff(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return;
> +
> +	genpd_lock(genpd);
> +	genpd->synced_poweroff = true;
> +	genpd_unlock(genpd);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>  	unsigned int state_idx = genpd->state_idx;
> @@ -562,6 +587,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  
>  out:
>  	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
> +	genpd->synced_poweroff = false;
>  	return 0;
>  err:
>  	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 1cd41bdf73cf..f776fb93eaa0 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -136,6 +136,7 @@ struct generic_pm_domain {
>  	unsigned int prepared_count;	/* Suspend counter of prepared devices */
>  	unsigned int performance_state;	/* Aggregated max performance state */
>  	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
> +	bool synced_poweroff;		/* A consumer needs a synced poweroff */
>  	int (*power_off)(struct generic_pm_domain *domain);
>  	int (*power_on)(struct generic_pm_domain *domain);
>  	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
> @@ -235,6 +236,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
>  void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
>  ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
> +void dev_pm_genpd_synced_poweroff(struct device *dev);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -300,6 +302,9 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
>  {
>  	return KTIME_MAX;
>  }
> +static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
> +{ }
> +
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
> -- 
> 2.7.4
> 
