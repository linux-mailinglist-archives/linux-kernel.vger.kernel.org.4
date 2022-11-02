Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B472616142
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKBKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKBKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737371403C;
        Wed,  2 Nov 2022 03:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DD5617F0;
        Wed,  2 Nov 2022 10:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E06C433C1;
        Wed,  2 Nov 2022 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667386376;
        bh=NDOSDtF1moYJudFzXEU8Fr9+WFsHcE/xRnSi1+ZcO7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Na/BGUedFirgHaWPiyVX6ER5jxLKzRsnHS04v8ArlXi3JkKsB/MkA6Ku0a5LwoLb+
         Dprv7i13JLcDhxy+iOP0LhPs//an9FpJoDmAgmfDxG6BetwzK+vivLBPCobjj19FEV
         aweGk86xTmX1kj2fJVg0+2dK4TavfmqBzmV417uvcpPAar7D/czSTLme1Wm4OGaSHQ
         qhzgURPCc3B4GQvVHW9Nte7PvR/QiIEu2vKD44OHHezyAIv+5LYWsMkPAIzyG9Lt8z
         dOm+0GbTP/xoDc5T+TDeetUejclFfv+icFJ4LkGzyWVwntGPeeYp+s3x3w2UNfpI5R
         8HKwfwX8j/zFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqBMN-000123-Hg; Wed, 02 Nov 2022 11:52:40 +0100
Date:   Wed, 2 Nov 2022 11:52:39 +0100
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
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
Message-ID: <Y2JL9/HFrb3E+CYY@hovoldconsulting.com>
References: <20221101233421.997149-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101233421.997149-1-swboyd@chromium.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 04:34:21PM -0700, Stephen Boyd wrote:
> We shouldn't be calling runtime PM APIs from within the genpd
> enable/disable path for a couple reasons.
> 
> First, this causes an AA lockdep splat because genpd can call into genpd
> code again while holding the genpd lock.
> 
> WARNING: possible recursive locking detected
> 5.19.0-rc2-lockdep+ #7 Not tainted
> --------------------------------------------
> kworker/2:1/49 is trying to acquire lock:
> ffffffeea0370788 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
> 
> but task is already holding lock:
> ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&genpd->mlock);
>   lock(&genpd->mlock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation

I've seen this splat on sc8280xp as well but haven't had time to look
into it yet.

> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Satya Priya <quic_c_skakit@quicinc.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Reported-by: Stephen Boyd <swboyd@chromium.org>

We typically don't add Reported-by tags for bugs we find and fix
ourselves.

> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/clk/qcom/gdsc.c | 64 ++++++-----------------------------------
>  1 file changed, 8 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 7cf5e130e92f..a775ce1b7d8a 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c

> @@ -495,14 +451,11 @@ static int gdsc_init(struct gdsc *sc)
>  		sc->pd.power_on = gdsc_enable;
>  
>  	ret = pm_genpd_init(&sc->pd, NULL, !on);
> -	if (ret)
> -		goto err_put_rpm;
> +	if (!ret)
> +		goto err_disable_supply;

The logic should not be inverted here (and only happens to work
currently when you have no regulator or the gdsc was off).

>  	return 0;
>  
> -err_put_rpm:
> -	if (on)
> -		gdsc_pm_runtime_put(sc);
>  err_disable_supply:
>  	if (on && sc->rsupply)
>  		regulator_disable(sc->rsupply);

Johan
