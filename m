Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD96DCFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDKDDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDKDCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC092D6D;
        Mon, 10 Apr 2023 20:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A187A6209E;
        Tue, 11 Apr 2023 03:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA33DC433EF;
        Tue, 11 Apr 2023 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681182169;
        bh=W5LkOo7VObRorAOwM+Ysl+U3TaX0yQUWO6dGaS2s9/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3UF/BZ1HAjWlEtz7VkRn9CMskyu9E3pWhCFv8dX+rD0WHM5TvoWMJOSojWd6ntPA
         ywa0+1Vd1zQOH6mNDSWreD/s+oFdVDHbbFpjlbUikUQl4XBe4bZf7mbI8U6G6lPIhQ
         HChDd563Gum1iJAVIq6EjBOKtyiZO2VcZ15ctRDv3tHCIGlLD2k1Q17+/PA6TLPZca
         qyzonBkzId5V2HCtlAQIV/uLbchVJfjwsOL9RelF4pU2cg20P+Ird99MQX0lGhHMh8
         kCcpOXFDb+c4P2bMnDfsiljROzSXHiDjbKD98aRtbtGtZz7xnXlBK5S4UMNzG49O2/
         mOAfMORkyFA5w==
Date:   Mon, 10 Apr 2023 20:06:30 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 2/4] soc: qcom: rpmhpd: Do proper power off when state
 synced
Message-ID: <20230411030630.z5nl5ynjl6wzp3bh@ripper>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <20230327193829.3756640-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327193829.3756640-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:38:27PM +0300, Abel Vesa wrote:
> Instead of aggregating different corner values on sync state callback,
> call the genpd API for queuing up the power off. This will also mark the
> domain as powered off in the debugfs genpd summary. Also, until sync
> state has been reached, return busy on power off request, in order to
> allow genpd core to know that the actual domain hasn't been powered of
> from the "disable unused" late initcall.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/soc/qcom/rpmhpd.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index f20e2a49a669..ec7926820772 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -649,8 +649,12 @@ static int rpmhpd_power_off(struct generic_pm_domain *domain)
>  	mutex_lock(&rpmhpd_lock);
>  
>  	ret = rpmhpd_aggregate_corner(pd, 0);
> -	if (!ret)
> -		pd->enabled = false;
> +	if (!ret) {
> +		if (!pd->state_synced)
> +			ret = -EBUSY;
> +		else
> +			pd->enabled = false;
> +	}
>  
>  	mutex_unlock(&rpmhpd_lock);
>  
> @@ -810,10 +814,8 @@ static void rpmhpd_sync_state(struct device *dev)
>  {
>  	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
>  	struct rpmhpd **rpmhpds = desc->rpmhpds;
> -	unsigned int corner;
>  	struct rpmhpd *pd;
>  	unsigned int i;
> -	int ret;
>  
>  	mutex_lock(&rpmhpd_lock);
>  	for (i = 0; i < desc->num_pds; i++) {
> @@ -822,14 +824,7 @@ static void rpmhpd_sync_state(struct device *dev)
>  			continue;
>  
>  		pd->state_synced = true;
> -		if (pd->enabled)
> -			corner = max(pd->corner, pd->enable_corner);

Note that the intent of this line is to lower the corner from max to
either a requested performance_state or the lowest non-disabled corner.
I don't think your solution maintains this behavior?

> -		else
> -			corner = 0;
> -
> -		ret = rpmhpd_aggregate_corner(pd, corner);
> -		if (ret)
> -			dev_err(dev, "failed to sync %s\n", pd->res_name);
> +		pm_genpd_queue_power_off(&pd->pd);

In the event that the power-domain has a single device attached, and no
subdomains, wouldn't pm_genpd_queue_power_off() pass straight through
all checks and turn off the power domain? Perhaps I'm just missing
something?

Regards,
Bjorn

>  	}
>  	mutex_unlock(&rpmhpd_lock);
>  }
> -- 
> 2.34.1
> 
