Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1A5BB29F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiIPTF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIPTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:05:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C0A59B1;
        Fri, 16 Sep 2022 12:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24D68B82743;
        Fri, 16 Sep 2022 19:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E108AC433D7;
        Fri, 16 Sep 2022 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663355148;
        bh=1Z3c+DrbRBcE+n2RlslO48Lc5eYsY1eHVvVDRXZsivI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOTgeoop2h3tQUyP5Qo8T+GBANRLzjMcohpSFMynxGp/1y9p2p+7fkzf+xCJ2neu1
         F+GyLvTR3tgB8DTyxKPJA5FpbAdB09MIZYUAfM/5T00xRkObW2NdOJXQ8c1RqgDTQB
         zI64c2gAMsiMYhgQzq0cwVa4qQ8tKicHBtUaqTiXtbVEUcM12013+dumFtxk4fN1qI
         W00M0Z9CUOGg2lJ9iXcgS9VVEjId0FWklRRZyVZG4S/BVQzcMKGdq+AvTyTxTEGKRM
         y5ps5NxVLgl6sRxnIWYo25h/0t1FRU9SJEcY1SOxLZxeTZk9DAj2LMFaP42cjhHq5t
         xKCycWzw1/Bkw==
Date:   Fri, 16 Sep 2022 14:05:45 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org, linux-clk@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v2 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
Message-ID: <20220916190545.4yadf4effjeipawu@builder.lan>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916102417.24549-1-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:54:15PM +0530, Rajendra Nayak wrote:
> GDSCs cannot be transitioned into a Retention state in SW.
> When either the RETAIN_MEM bit, or both the RETAIN_MEM and
> RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
> takes care of retaining the memory/logic for the domain when
> the parent domain transitions to low power state.
> The existing logic handling the PWRSTS_RET seems to set the
> RETAIN_MEM/RETAIN_PERIPH bits but then explicitly turns the
> GDSC OFF as part of _gdsc_disable(). Fix that by leaving the
> GDSC in ON state.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> No changes in v2: 
> 
> There are a few existing users of PWRSTS_RET and I am not
> sure if they would be impacted with this change
> 
> 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
> gdsc is actually transitioning to OFF and might be left
> ON as part of this change, atleast till we hit system wide
> low power state.
> If we really leak more power because of this
> change, the right thing to do would be to update .pwrsts for
> mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
> I dont have a msm8974 hardware, so if anyone who has can report
> any issues I can take a look further on how to fix it.
> 
> 2. gpu_gx_gdsc in gpucc-msm8998.c and
>    gpu_gx_gdsc in gpucc-sdm660.c
> Both of these seem to add support for 3 power state
> OFF, RET and ON, however I dont see any logic in gdsc
> driver to handle 3 different power states.
> So I am expecting that these are infact just transitioning
> between ON and OFF and RET state is never really used.
> The ideal fix for them would be to just update their resp.
> .pwrsts to PWRSTS_OFF_ON only.
> 
>  drivers/clk/qcom/gdsc.c | 10 ++++++++++
>  drivers/clk/qcom/gdsc.h |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index d3244006c661..ccf63771e852 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -368,6 +368,16 @@ static int _gdsc_disable(struct gdsc *sc)
>  	if (sc->pwrsts & PWRSTS_OFF)
>  		gdsc_clear_mem_on(sc);
>  
> +	/*
> +	 * If the GDSC supports only a Retention state, apart from ON,
> +	 * leave it in ON state.
> +	 * There is no SW control to transition the GDSC into
> +	 * Retention state. This happens in HW when the parent
> +	 * domain goes down to a Low power state
> +	 */
> +	if (sc->pwrsts == PWRSTS_RET_ON)
> +		return 0;
> +
>  	ret = gdsc_toggle_logic(sc, GDSC_OFF);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 5de48c9439b2..981a12c8502d 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -49,6 +49,11 @@ struct gdsc {
>  	const u8			pwrsts;
>  /* Powerdomain allowable state bitfields */
>  #define PWRSTS_OFF		BIT(0)
> +/*
> + * There is no SW control to transition a GDSC into
> + * PWRSTS_RET. This happens in HW when the parent
> + * domain goes down to a low power state
> + */
>  #define PWRSTS_RET		BIT(1)
>  #define PWRSTS_ON		BIT(2)
>  #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
> -- 
> 2.17.1
> 
