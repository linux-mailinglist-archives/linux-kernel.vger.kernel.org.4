Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3D5EFAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiI2Qen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiI2Qei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:34:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2167FCD3;
        Thu, 29 Sep 2022 09:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6338BB82521;
        Thu, 29 Sep 2022 16:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9C3C433C1;
        Thu, 29 Sep 2022 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469273;
        bh=I8OdO1deCrkb3ClOcVF2l3RDoH9nq3daODkvsy0yJpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axUDzaCzBnb1rnf/xbz7PMTZ5m7hqudin7KZP4K1JivUK3xmwDQCjYpRU1jgzqrwn
         m7l+RoQMCrN4PsPG4NYKb2B6/WIAbwTFx4U+ahzFxIS/Mqo046EGPeL0yBH/skDghy
         xjNQWkW/ou3hfqNuk/rosERQhOJBUutabOgbU6nttkOSHoPUZoM9P7Li+nY+iRBdi7
         k5ueLgYVq8UcAMNHg9VIZs/a/sUxwVzcM0uKbEIe1RDu5aQGIjLaX9g99zzYdEfXkm
         Qw+n05WnHqUxHmILDobeldIwlQaccExF7pobHHv7MVPMuGRl+Ocnjw9ntP7rbBOyKW
         eta7iCJqLc8Xg==
Date:   Thu, 29 Sep 2022 11:34:30 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: add missing error handling
Message-ID: <20220929163430.ozkfdiv5n2snwhkn@builder.lan>
References: <20220929155816.17425-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929155816.17425-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:58:16PM +0200, Johan Hovold wrote:
> Since commit 7eb231c337e0 ("PM / Domains: Convert pm_genpd_init() to
> return an error code") pm_genpd_init() can return an error which the
> caller must handle.
> 
> The current error handling was also incomplete as the runtime PM and
> regulator use counts were not balanced in all error paths.
> 
> Add the missing error handling to the GDSC initialisation to avoid
> continuing as if nothing happened on errors.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/gdsc.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index e1d6574d2797..0b67bd72e217 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -451,11 +451,8 @@ static int gdsc_init(struct gdsc *sc)
>  
>  		/* ...and the power-domain */
>  		ret = gdsc_pm_runtime_get(sc);
> -		if (ret) {
> -			if (sc->rsupply)
> -				regulator_disable(sc->rsupply);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_disable_supply;
>  
>  		/*
>  		 * Votable GDSCs can be ON due to Vote from other masters.
> @@ -464,14 +461,14 @@ static int gdsc_init(struct gdsc *sc)
>  		if (sc->flags & VOTABLE) {
>  			ret = gdsc_update_collapse_bit(sc, false);
>  			if (ret)
> -				return ret;
> +				goto err_put_rpm;
>  		}
>  
>  		/* Turn on HW trigger mode if supported */
>  		if (sc->flags & HW_CTRL) {
>  			ret = gdsc_hwctrl(sc, true);
>  			if (ret < 0)
> -				return ret;
> +				goto err_put_rpm;
>  		}
>  
>  		/*
> @@ -498,9 +495,21 @@ static int gdsc_init(struct gdsc *sc)
>  		sc->pd.power_off = gdsc_disable;
>  	if (!sc->pd.power_on)
>  		sc->pd.power_on = gdsc_enable;
> -	pm_genpd_init(&sc->pd, NULL, !on);
> +
> +	ret = pm_genpd_init(&sc->pd, NULL, !on);
> +	if (ret)
> +		goto err_put_rpm;
>  
>  	return 0;
> +
> +err_put_rpm:
> +	if (on)
> +		gdsc_pm_runtime_put(sc);
> +err_disable_supply:
> +	if (on && sc->rsupply)
> +		regulator_disable(sc->rsupply);
> +
> +	return ret;
>  }
>  
>  int gdsc_register(struct gdsc_desc *desc,
> -- 
> 2.35.1
> 
