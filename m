Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8E697BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjBOMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjBOMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:22:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19A34F6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:21:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso1432458wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RELpCW/oZXrkZpYRibECyc3kJCsC+qy7Qi3hEX89e/E=;
        b=w9OOW1XfvuTdpRcmAU7mVA29OsEzVzK+7kQZyb3OfU9XrdxZtGDKMmmy1LCfbjh/vo
         82PuAPYaemBlpXFWh2h56hdL+XgmAYbZyVHny7dT03oik0W6REGN+AEsrD8g1tPtSgWU
         wLU4ad+jykFcQogkFHtCDM9JDZvgJ+If5TQ8CP/I6RUAwO9LZw55arZ6YLA1cP1NBygY
         O+i3bL8hL6XXtJzRQ0pKVqUJqY9evvPbsmsP+asaROcgb68BzT0Uz0siflfzIT/CMuXV
         8FjGZo0v7hqwmrv+iC6pHcxBx4GPpvYmNGQ3f7eLI9Ng53kjTJHtZNa80u+16B6ilvqq
         pEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RELpCW/oZXrkZpYRibECyc3kJCsC+qy7Qi3hEX89e/E=;
        b=BObWO4V4HFNChpgBjWwDFqqhC/gVMbhIXirYj6zwnkbPXGAMfWr/t4KPItCOEwmeUH
         x3mMsgiR+Njye+RIyYBLTvjJwljn7oYknjnj88++gA+ZWwrKYhRhHDLUIpZ9K7Y27UMX
         B97drVRsThi+G1yjXPliex3enXmge5nhb+g78U4sTs+L06fcAEKQiNh5T9exP1Joe5pk
         qv5Lu+FpeTewUtm7DQWp6DFsTIFJxdf3SdAo0XLahuHJ7o+j/2JlvqmzfdVQm7XDO+e9
         bs+G+1xvILzfIDjeqA7UYKTOt2C6KDMAERjhxcHhn3Pus73tRUm7XYChmNamcu4VMuTL
         fnnA==
X-Gm-Message-State: AO0yUKWS4PlWux4dqszWPiFMYiudzlBSontcbnQmOHTOf4qQSjhhH8Oq
        dVqNtmJUXJ7qJ4rbM0ZThw9nhQ==
X-Google-Smtp-Source: AK7set/+tejIXJKfChexrtS8e4HURhrM7vZydB2uOd6HpyijLy3lPggZbrucOFHYgjS/skYe3YDPsg==
X-Received: by 2002:a05:600c:329a:b0:3db:15b1:fb28 with SMTP id t26-20020a05600c329a00b003db15b1fb28mr1771329wmp.19.1676463715219;
        Wed, 15 Feb 2023 04:21:55 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003dc53217e07sm2105310wmq.16.2023.02.15.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:21:54 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:21:53 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+zOYfSI7Zq5sll1@linaro.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-15 12:57:54, Ulf Hansson wrote:
> On Fri, 27 Jan 2023 at 11:40, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > Currently, there are cases when a domain needs to remain enabled until
> > the consumer driver probes. Sometimes such consumer drivers may be built
> > as modules. Since the genpd_power_off_unused is called too early for
> > such consumer driver modules to get a chance to probe, the domain, since
> > it is unused, will get disabled. On the other hand, the best time for
> > an unused domain to be disabled is on the provider's sync_state
> > callback. So, if the provider has registered a sync_state callback,
> > assume the unused domains for that provider will be disabled on its
> > sync_state callback. Also provide a generic sync_state callback which
> > disables all the domains unused for the provider that registers it.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >
> > This approach has been applied for unused clocks as well.
> > With this patch merged in, all the providers that have sync_state
> > callback registered will leave the domains enabled unless the provider's
> > sync_state callback explicitly disables them. So those providers will
> > need to add the disabling part to their sync_state callback. On the
> > other hand, the platforms that have cases where domains need to remain
> > enabled (even if unused) until the consumer driver probes, will be able,
> > with this patch in, to run without the pd_ignore_unused kernel argument,
> > which seems to be the case for most Qualcomm platforms, at this moment.
> 
> My apologies for the somewhat late reply. Please see my comments below.
> 
> >
> > The v1 is here:
> > https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/
> >
> > Changes since v1:
> >  * added a generic sync state callback to be registered by providers in
> >    order to disable the unused domains on their sync state. Also
> >    mentioned this in the commit message.
> >
> >  drivers/base/power/domain.c | 17 ++++++++++++++++-
> >  include/linux/pm_domain.h   |  3 +++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 84662d338188..c2a5f77c01f3 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
> >         mutex_lock(&gpd_list_lock);
> >
> >         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > -               genpd_queue_power_off_work(genpd);
> > +               if (!dev_has_sync_state(genpd->provider->dev))
> 
> Unfortunately, this doesn't really help, due to the fact that a
> genpd's ->power_off() callback may get called anyway. At power off,
> the genpd core only cares about those consumers that are currently
> attached, not those that might get attached at some point later in
> time.
> 
> In other words, it's the responsibility for each specific genpd
> provider to cope with the condition that its ->sync_state() callback
> may *not* have been called, while its ->power_off() callback is being
> called.
> 
> In these cases, the genpd provider should probably make the
> ->power_off() callback to return -EBUSY. This is what we do in
> psci_pd_power_off(), for example.
> 

Hmm, this might actually be a better idea. Bjorn, do you agree?

> > +                       genpd_queue_power_off_work(genpd);
> >
> >         mutex_unlock(&gpd_list_lock);
> >
> > @@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
> >  }
> >  late_initcall(genpd_power_off_unused);
> >
> > +void genpd_power_off_unused_sync_state(struct device *dev)
> > +{
> > +       struct generic_pm_domain *genpd;
> > +
> > +       mutex_lock(&gpd_list_lock);
> > +
> > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > +               if (genpd->provider->dev == dev)
> > +                       genpd_queue_power_off_work(genpd);
> > +
> > +       mutex_unlock(&gpd_list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);
> 
> I don't think this function is needed at all.
> 
> In fact, this part of the problem that you are trying to solve should
> already be managed by the driver core, as it calls
> dev->pm_domain->sync() (which is assigned to genpd_dev_pm_sync()) , in
> really_probe(). Or isn't that taking care of the problem for you?

Hmm, I missed the genpd_dev_pm_sync scenario entirely. Yes, that is
actually what is needed, and yes, this function I added here is useless
in this case.

> 
> > +
> >  #ifdef CONFIG_PM_SLEEP
> >
> >  /**
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index f776fb93eaa0..1fd5aa500c81 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> >                                          unsigned int index);
> >  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> >                                            const char *name);
> > +void genpd_power_off_unused_sync_state(struct device *dev);
> >  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> >  static inline int of_genpd_add_provider_simple(struct device_node *np,
> >                                         struct generic_pm_domain *genpd)
> > @@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
> >  {
> >         return ERR_PTR(-EOPNOTSUPP);
> >  }
> > +
> > +static inline genpd_power_off_unused_sync_state(struct device *dev) {}
> >  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
> >
> >  #ifdef CONFIG_PM
> > --
> > 2.34.1
> >
> 
> Kind regards
> Uffe
