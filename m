Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A87021B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEOC2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjEOC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:28:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BE19BE;
        Sun, 14 May 2023 19:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B030661DAF;
        Mon, 15 May 2023 02:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDD7C433A0;
        Mon, 15 May 2023 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684117009;
        bh=4BY0lMs9sfv6UZLqV2INWTuZMr7qywgOSBpnpI+KUTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpZcxfWw723lqm23ztb4WFTnvYT+IhL7AlF5GXQ6QI4ZjKL5o7lOj1KCDlTWJuAco
         B8QLFpqXRR/CI2eMq8LAWdufdzAoAX24gUBaw6uZsCmZDSRcG6QR0OKvvO5vCdmwz4
         fplQZmC5fB3gT+hs4IdAShG24dC+d01StjcRIVBnWRjHi/4OAQQxIf8fVosH2hyaOV
         FZ8WuCJiMykUW6//oi06sub5ZVoXc8PFsoE0oyALEw0DaJz9HZ0rKxy0MGLBjwwDY7
         6SOJHuDJyBCfSt8jFamX2rbXyrmjvUW55Mw1ESao4aszxmQI3bZ9A1KNzq5Hp8vDUl
         AkYdxo6t/1INw==
Date:   Sun, 14 May 2023 19:20:41 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] leds: qcom-lpg: Fix PWM period limits
Message-ID: <20230515022041.4i2w36vubzggpdt6@ripper>
References: <20230512165524.3367443-1-quic_bjorande@quicinc.com>
 <cab829ec-5763-1352-618a-adad8c01227d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab829ec-5763-1352-618a-adad8c01227d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 10:09:49AM +0000, Caleb Connolly wrote:
> 
> 
> On 12/05/2023 16:55, Bjorn Andersson wrote:
> > The introduction of high resolution PWM support moved the parenthesis of
> > the divisions in the calculation of min and max period. The result in
> > both divisions is in most cases truncation to 0, which limits the period
> > to the range of [0, 0].
> 
> Huh, TIL C gives multiplication and division the same precedence when
> deciding order of operations.

There where no explicit parenthesis in the original implementation. So
I guess it would be more correct to state that parenthesis was
introduced around part of the expression?

Let me know if you think the wording matters and you would prefer me to
rewrite it.

Regards,
Bjorn

> > 
> > Both numerators (and denominators) are within 64 bits, so the whole
> > expression can be put directly into the div64_u64, instead of doing it
> > partially.
> > 
> > Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> > 
> > This fixes the regression in v6.4-rc1.
> > 
> >  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> > index c9cea797a697..7287fadc00df 100644
> > --- a/drivers/leds/rgb/leds-qcom-lpg.c
> > +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> > @@ -312,14 +312,14 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> >  		max_res = LPG_RESOLUTION_9BIT;
> >  	}
> >  
> > -	min_period = (u64)NSEC_PER_SEC *
> > -			div64_u64((1 << pwm_resolution_arr[0]), clk_rate_arr[clk_len - 1]);
> > +	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
> > +			       clk_rate_arr[clk_len - 1]);
> >  	if (period <= min_period)
> >  		return -EINVAL;
> >  
> >  	/* Limit period to largest possible value, to avoid overflows */
> > -	max_period = (u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV *
> > -			div64_u64((1 << LPG_MAX_M), 1024);
> > +	max_period = div64_u64((u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV * (1 << LPG_MAX_M),
> > +			       1024);
> >  	if (period > max_period)
> >  		period = max_period;
> >  
> 
> -- 
> Kind Regards,
> Caleb (they/them)
