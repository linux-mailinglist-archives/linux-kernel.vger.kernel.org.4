Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEFA70F8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjEXOce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEXOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFF12E;
        Wed, 24 May 2023 07:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B038D63DCE;
        Wed, 24 May 2023 14:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157BAC433EF;
        Wed, 24 May 2023 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684938751;
        bh=ifJBDlw42lQEKWaVj8j5eUTS/S5Ep1/jzziFfDLCiO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=melxsfpBFtterXW0JEI2hR1uTm+mQVU/WRPDBctYpMXB5oHsEhxirRtVJoWadJbB+
         wm+j+6QppuphP9oXHCaBdahw5H1ZYuPJUGdgtdFdW95izchtrOT21G3jnyq5mUw0lJ
         da0i404+4aND5DSCX7KkT6yqfSSozVbvxwxa5GR+IW0ZKRMG8NLMIqO+9wzfZ8WoRg
         mcJuRH4XY3/uDJ7sSeKYUETKI3wLbdr7RANte6nVYD1eIH7ngUhE1mz4k1CB/j9IzN
         w41+PPU/Eu6FyDYyf13bHZEbaY7cUa/XxVEZexzaGtTJXHdMUTf+JaXpocqTBk0jp8
         h8MWRCYi6pl5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q1pXY-0000jp-U7; Wed, 24 May 2023 16:32:37 +0200
Date:   Wed, 24 May 2023 16:32:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Anjelique Melendez <quic_amelende@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2] leds: qcom-lpg: Fix PWM period limits
Message-ID: <ZG4gBE1rqkMIllV3@hovoldconsulting.com>
References: <20230515162604.649203-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515162604.649203-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:26:04AM -0700, Bjorn Andersson wrote:
> The introduction of high resolution PWM support changed the order of the
> operations in the calculation of min and max period. The result in both
> divisions is in most cases a truncation to 0, which limits the period to
> the range of [0, 0].
> 
> Both numerators (and denominators) are within 64 bits, so the whole
> expression can be put directly into the div64_u64, instead of doing it
> partially.
> 
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Pavel or Lee, could you pick this one up for 6.4 as it fixes a
regression (e.g. broken backlight on a number of laptops like the X13s)?

> ---
> 
> Changes since v1:
> - Reworded first sentence to express that it's the order and not the
>   previously non-existent parenthesis that changed...
> - Picked up review tags.
> 
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index c9cea797a697..7287fadc00df 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -312,14 +312,14 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
>  		max_res = LPG_RESOLUTION_9BIT;
>  	}
>  
> -	min_period = (u64)NSEC_PER_SEC *
> -			div64_u64((1 << pwm_resolution_arr[0]), clk_rate_arr[clk_len - 1]);
> +	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
> +			       clk_rate_arr[clk_len - 1]);
>  	if (period <= min_period)
>  		return -EINVAL;
>  
>  	/* Limit period to largest possible value, to avoid overflows */
> -	max_period = (u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV *
> -			div64_u64((1 << LPG_MAX_M), 1024);
> +	max_period = div64_u64((u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV * (1 << LPG_MAX_M),
> +			       1024);
>  	if (period > max_period)
>  		period = max_period;

Johan
