Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD2617F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKCObh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:31:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3815A13D0D;
        Thu,  3 Nov 2022 07:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA0C5B8286C;
        Thu,  3 Nov 2022 14:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4E3C433C1;
        Thu,  3 Nov 2022 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667485887;
        bh=cV+KPyo1HQl6I0TSS6Fbc5Uo/+IhyGzcIW29pZoKBcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jr41Zc8YDx1Cj+LFsLPTp5IYwG1Re1+DvzBrPQIqRN/U5oYmxSA4oNrK/LInnYf4V
         cWgQf22o/uwDyprHyHFmOMhQtrq9e9+uMbkM5Yx+2nPksMAOt0lEo7QAPy744im/w+
         9tWXvBnG/B8z+cxERP3UVhPJEk0+srFYUchnOso65PmvBzc31ddrTosVdL8Q/RxZa7
         y5zFATXwrkf6uH8aISo0wX2mq60fDuGUtjv4wEKg3Yr8E4fPhrUdl5UM37hIU+jFqE
         T0Jen93iuCtldUiL7fX3rhMPnU0XBKrACdRA66C2EhAzViKJVVYUyav3M19ElRd0iu
         ehYxWu1msl3Cg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqbFN-0002UL-9F; Thu, 03 Nov 2022 15:31:10 +0100
Date:   Thu, 3 Nov 2022 15:31:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] clk: qcom: gdsc: Remove direct runtime PM calls
Message-ID: <Y2PQrRkGTEE40m4Q@hovoldconsulting.com>
References: <20221102170717.1262547-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102170717.1262547-1-swboyd@chromium.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:07:17AM -0700, Stephen Boyd wrote:
> We shouldn't be calling runtime PM APIs from within the genpd
> enable/disable path for a couple reasons.
> 
> First, this causes an AA lockdep splat because genpd can call into genpd
> code again while holding the genpd lock.
> 
> WARNING: possible recursive locking detected

> Second, this confuses runtime PM on CoachZ for the camera devices by
> causing the camera clock controller's runtime PM usage_count to go
> negative after resuming from suspend. This is because runtime PM is
> being used on the clock controller while runtime PM is disabled for the
> device.
> 
> The reason for the negative count is because a GDSC is represented as a
> genpd and each genpd that is attached to a device is resumed during the
> noirq phase of system wide suspend/resume (see the noirq suspend ops
> assignment in pm_genpd_init() for more details). The camera GDSCs are
> attached to camera devices with the 'power-domains' property in DT.
> Every device has runtime PM disabled in the late system suspend phase
> via __device_suspend_late(). Runtime PM is not usable until runtime PM
> is enabled in device_resume_early(). The noirq phases run after the
> 'late' and before the 'early' phase of suspend/resume. When the genpds
> are resumed in genpd_resume_noirq(), we call down into gdsc_enable()
> that calls pm_runtime_resume_and_get() and that returns -EACCES to
> indicate failure to resume because runtime PM is disabled for all
> devices.

Probably worth mentioning the fact that those runtime PM calls
unconditionally failing during resume means that the GDSCs are never
even enabled.

Seems like the PM runtime usage counters would still be balanced after
this though as they are decremented also on failure during suspend (i.e.
domain remains off and no usage counter is incremented during resume).

But this is clearly just very broken.

> Upon closer inspection, calling runtime PM APIs like this in the GDSC
> driver doesn't make sense. It was intended to make sure the GDSC for the
> clock controller providing other GDSCs was enabled, specifically the
> MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
> that GDSC register accesses succeeded. That will already happen because
> we make the 'dev->pm_domain' a parent domain of each GDSC we register in
> gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
> are accessed, we'll enable the parent domain (in this specific case
> MMCX).
> 
> We also remove any getting of runtime PM during registration, because
> when a genpd is registered it increments the count on the parent if the
> genpd itself is already enabled. And finally, the runtime PM state of
> the clk controller registering the GDSC shouldn't matter to the
> subdomain setup. Therefore we always assign 'dev' unconditionally so
> when GDSCs are removed we properly unlink the GDSC from the clk
> controller's pm_domain.

This last bit makes no sense as 'dev' was only used for the runtime PM
management and should be removed by this patch.

> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Satya Priya <quic_c_skakit@quicinc.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1 (https://lore.kernel.org/r/20221101233421.997149-1-swboyd@chromium.org):
>  * Fix ret thinko
>  * Update kerneldoc on 'dev' member

No credit to reviewers (e.g. names in parentheses)?

>  drivers/clk/qcom/gdsc.c | 62 +++++------------------------------------
>  drivers/clk/qcom/gdsc.h |  2 +-
>  2 files changed, 8 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 7cf5e130e92f..36d44eec03b6 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c

> @@ -56,22 +55,6 @@ enum gdsc_status {
>  	GDSC_ON
>  };
>  
> -static int gdsc_pm_runtime_get(struct gdsc *sc)
> -{
> -	if (!sc->dev)
> -		return 0;
> -
> -	return pm_runtime_resume_and_get(sc->dev);
> -}
> -
> -static int gdsc_pm_runtime_put(struct gdsc *sc)
> -{
> -	if (!sc->dev)
> -		return 0;
> -
> -	return pm_runtime_put_sync(sc->dev);
> -}
> -
 
> -static int gdsc_enable(struct generic_pm_domain *domain)
> +static int gdsc_disable(struct generic_pm_domain *domain)
>  {
>  	struct gdsc *sc = domain_to_gdsc(domain);
>  	int ret;
>  
> -	ret = gdsc_pm_runtime_get(sc);
> -	if (ret)
> -		return ret;
> -
> -	return _gdsc_enable(sc);
> -}
 
> -static int gdsc_disable(struct generic_pm_domain *domain)
> -{
> -	struct gdsc *sc = domain_to_gdsc(domain);
> -	int ret;
> -
> -	ret = _gdsc_disable(sc);
> -
> -	gdsc_pm_runtime_put(sc);
> -
> -	return ret;
> -}

> @@ -541,8 +494,7 @@ int gdsc_register(struct gdsc_desc *desc,
>  	for (i = 0; i < num; i++) {
>  		if (!scs[i])
>  			continue;
> -		if (pm_runtime_enabled(dev))
> -			scs[i]->dev = dev;
> +		scs[i]->dev = dev;

As mentioned above, the gdsc dev pointer is now unused and should be
removed.

>  		scs[i]->regmap = regmap;
>  		scs[i]->rcdev = rcdev;
>  		ret = gdsc_init(scs[i]);
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 981a12c8502d..47de72834a85 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -30,7 +30,7 @@ struct reset_controller_dev;
>   * @resets: ids of resets associated with this gdsc
>   * @reset_count: number of @resets
>   * @rcdev: reset controller
> - * @dev: the device holding the GDSC, used for pm_runtime calls
> + * @dev: the device providing the GDSC
>   */
>  struct gdsc {
>  	struct generic_pm_domain	pd;
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780

Johan
