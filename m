Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D16648E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjAJSQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbjAJSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:15:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC6E65E3;
        Tue, 10 Jan 2023 10:13:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B92BB81904;
        Tue, 10 Jan 2023 18:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F6EC433F2;
        Tue, 10 Jan 2023 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673374411;
        bh=0FExIvtCBuDgN4Q1DsAwXCC705QWCujVlzrI+6iicBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ds02guDfC3kBWRPNotDONLCnVWWbw/azwOtWDTHxR6O34rPma3RbnYjtCp6gwDjsH
         +0SxyskEkYVNrxvsScRGKgb+mr6PMbd5BlW1snEW5Eaw4tsPsn1D7BVcPviEIom2Oi
         9NFt6fSpllWOb7rdLtvc+GuiJ7wntTpCgc5PtyrJ5ZIJPBzW478rpsrqbDcSr/v3/7
         bpsC2QoBRBHMabYTOPAwvJLGnYMtG+BvN5ZbGQp5nN5qPY8srbZzdt1oLsCPX1i2P5
         LrhwkYetp8r40o8FCQ5dCaEW9Zke6aINQXH/Gt4jAIkQqdqq5JNMX+7x7Jf9Tgafoe
         w41kc/jHDUK9A==
Date:   Tue, 10 Jan 2023 12:13:28 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/qcom: Remove duplicate set next trip
 point interrupt code
Message-ID: <20230110181328.el2kicyrg2j554c2@builder.lan>
References: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:34:20AM +0100, Daniel Lezcano wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The tsens driver reprogram the next trip points in the irq
> handler. This function then call thermal_zone_device_update().
> 
> However, thermal_zone_device_update() calls thermal_zone_set_trips()
> and from there it calls the backend 'set_trips' ops. This one in turn
> reprogram the next trip points (low/high).
> 
> Consequently, the code setting the next trip points interrupt in the
> interrupt handle is not needed and could be removed.
> 


Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>

The last one should be the address you sent your patch from, and that
was the first one. So I think you should drop this one.

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens.c | 46 +-----------------------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b5b136ff323f..58693ee8c430 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -472,52 +472,8 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>  			continue;
>  		if (!tsens_threshold_violated(priv, hw_id, &d))
>  			continue;
> -		ret = get_temp_tsens_valid(s, &temp);
> -		if (ret) {
> -			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
> -				hw_id, __func__);
> -			continue;
> -		}
>  
> -		spin_lock_irqsave(&priv->ul_lock, flags);
> -
> -		tsens_read_irq_state(priv, hw_id, s, &d);
> -
> -		if (d.up_viol &&
> -		    !masked_irq(hw_id, d.up_irq_mask, tsens_version(priv))) {
> -			tsens_set_interrupt(priv, hw_id, UPPER, disable);
> -			if (d.up_thresh > temp) {
> -				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> -					hw_id, __func__);
> -				tsens_set_interrupt(priv, hw_id, UPPER, enable);
> -			} else {
> -				trigger = true;
> -				/* Keep irq masked */
> -			}
> -		} else if (d.low_viol &&
> -			   !masked_irq(hw_id, d.low_irq_mask, tsens_version(priv))) {
> -			tsens_set_interrupt(priv, hw_id, LOWER, disable);
> -			if (d.low_thresh < temp) {
> -				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
> -					hw_id, __func__);
> -				tsens_set_interrupt(priv, hw_id, LOWER, enable);
> -			} else {
> -				trigger = true;
> -				/* Keep irq masked */
> -			}
> -		}
> -
> -		spin_unlock_irqrestore(&priv->ul_lock, flags);
> -
> -		if (trigger) {
> -			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> -				hw_id, __func__, temp);
> -			thermal_zone_device_update(s->tzd,
> -						   THERMAL_EVENT_UNSPECIFIED);
> -		} else {
> -			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> -				hw_id, __func__, temp);
> -		}
> +		thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
>  
>  		if (tsens_version(priv) < VER_0_1) {
>  			/* Constraint: There is only 1 interrupt control register for all
> -- 
> 2.34.1
> 
