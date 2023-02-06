Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7997C68C363
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBFQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:31:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0427495
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:31:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so10954734wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5bjcHFpmFVH3KXyAiC17ebDFZXrFoaWMGOWdWjJid8=;
        b=juATuULNtPkiFSg/8BBW6AN+k06PLQIav/v2MR0xneT3eVbLtakvFqICe5KlRxBwiQ
         WrmP22Qah2Yu0bplNBqQvjmM1ozth7ybdONprgD+uc1NFohq9p8egsueG8PMGmIFdVYB
         RBhdRbUptzbR6qVGVJVfYU2xbEOY2FO2ctYwD9wuhnIKAbDpwT6cVI/8OlNp5vxCydY2
         Olti5REy7CZQjcP9T6uQkt/yk1cu0s0inpSaJbYox/QgYhO4gk1VzbmBRW+86FlGwhLa
         5XH+1C8SjTmRORjUZz1Si1Sv1ebGqlXf6JNK5+zkLAOwpohZX7RgeClhdIHLqSCehycH
         W4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5bjcHFpmFVH3KXyAiC17ebDFZXrFoaWMGOWdWjJid8=;
        b=FMuXlY1EEcBli1PWEEOkeKuTf4VyLpxPuU18qFU80Y3ALfOdDFFztnv4/0qjtIBnz7
         +JDW8L88Pz7mo9ZSBeXpPv1yQmHtgcrLqzqt3SeHId0RxsGV6tf20pomZnG7BetxWVIJ
         cGYOkfew05jJtFInqQ+fYptiISfGNsuykXLVpHU01n48R+qkp1amsU/5YrT9Ia5wzynI
         3jKNZMAZMv/730jYNoHMYp2foTPH/XWBNfWNp45N2TNwoiZYihEmyqn3MBXbcuPoQPdL
         Adc629eQSSB/z8DtL8kLQRE3CBes6fbgMWfzlgz6tFvIuNhk1SEa+CecSPlqC4Z9vMRX
         X6nA==
X-Gm-Message-State: AO0yUKXD27AOyNIg4BwCyPlfqtgVXv4c+9gORl2fNBqxgf43oR9f28/B
        la4ZsaYGy1iKteLtUu5LydLYXQ==
X-Google-Smtp-Source: AK7set9FCxgGOIkd4YfSDh4BJEQ7VfKvPjFWkq+zcTrZmBe5u5FZoI+6B1BrRcGLpoRHpMmwrSpIQw==
X-Received: by 2002:adf:e192:0:b0:2bc:846a:8ead with SMTP id az18-20020adfe192000000b002bc846a8eadmr18992629wrb.37.1675701083988;
        Mon, 06 Feb 2023 08:31:23 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b002c3efca57e1sm1272703wrt.110.2023.02.06.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:31:23 -0800 (PST)
Date:   Mon, 6 Feb 2023 18:31:21 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <Y+ErWTyV8CnE3Hl+@linaro.org>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <Y9v/z8CYik3faHh7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9v/z8CYik3faHh7@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-02 18:24:15, Matthias Kaehlcke wrote:
> Hi Abel,
> 
> On Fri, Jan 27, 2023 at 12:40:53PM +0200, Abel Vesa wrote:
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
> I recently encountered a related issue on a Qualcomm platform with a
> v6.2-rc kernel, which includes 3a39049f88e4 ("soc: qcom: rpmhpd: Use
> highest corner until sync_state"). The issue involves a DT node with a
> rpmhpd, the DT node is enabled, however the corresponding device driver
> is not enabled in the kernel. In such a scenario the sync_state callback
> is never called, because the genpd consumer never probes. As a result
> the Always-on subsystem (AOSS) of the SoC doesn't enter sleep mode during
> system suspend, which results in a substantially higher power consumption
> in S3.

If I get this correctly, one of the providers is missing (doesn't matter
the reason), in which case, your kernel needs that driver, period. There
is no reason why you would expect the consumer to work without the
provider. Or, you could just remove the property in the devicetree node,
the property that makes the consumer wait for that provider. Anyway, you
should never end up with a consumer provider relationship in devicetree
without providing the provider driver.

> 
> I wonder if genpd (and some other frameworks) needs something like
> regulator_init_complete(), which turns off unused regulators 30s after
> system boot. That's conceptually similar to the current
> genpd_power_off_unused(), but would provide time for modules being loaded.

NACK, timeouts are just another hack in this case, specially when we
have a pretty reliable mechanism like sync_state.

> 
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
> >  	mutex_lock(&gpd_list_lock);
> >  
> >  	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > -		genpd_queue_power_off_work(genpd);
> > +		if (!dev_has_sync_state(genpd->provider->dev))
> > +			genpd_queue_power_off_work(genpd);
> >  
> >  	mutex_unlock(&gpd_list_lock);
> >  
> > @@ -1107,6 +1108,20 @@ static int __init genpd_power_off_unused(void)
> >  }
> >  late_initcall(genpd_power_off_unused);
> >  
> > +void genpd_power_off_unused_sync_state(struct device *dev)
> > +{
> > +	struct generic_pm_domain *genpd;
> > +
> > +	mutex_lock(&gpd_list_lock);
> > +
> > +	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > +		if (genpd->provider->dev == dev)
> > +			genpd_queue_power_off_work(genpd);
> > +
> > +	mutex_unlock(&gpd_list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(genpd_power_off_unused_sync_state);
> > +
> >  #ifdef CONFIG_PM_SLEEP
> >  
> >  /**
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index f776fb93eaa0..1fd5aa500c81 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -351,6 +351,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> >  					 unsigned int index);
> >  struct device *genpd_dev_pm_attach_by_name(struct device *dev,
> >  					   const char *name);
> > +void genpd_power_off_unused_sync_state(struct device *dev);
> >  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> >  static inline int of_genpd_add_provider_simple(struct device_node *np,
> >  					struct generic_pm_domain *genpd)
> > @@ -419,6 +420,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
> >  {
> >  	return ERR_PTR(-EOPNOTSUPP);
> >  }
> > +
> > +static inline genpd_power_off_unused_sync_state(struct device *dev) {}
> >  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
> >  
> >  #ifdef CONFIG_PM
> > -- 
> > 2.34.1
> > 
