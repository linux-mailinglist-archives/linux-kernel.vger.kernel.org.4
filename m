Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56655BB83D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 08:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIQMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 08:38:37 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF872C658
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 05:38:34 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.72.neoplus.adsl.tpnet.pl [95.49.30.72])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 85E0F3F654;
        Sat, 17 Sep 2022 14:38:30 +0200 (CEST)
Message-ID: <6b32824f-5334-9866-57d0-5fd2b9de9237@somainline.org>
Date:   Sat, 17 Sep 2022 14:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        mka@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org, linux-clk@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220916102417.24549-1-quic_rjendra@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.09.2022 12:24, Rajendra Nayak wrote:
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

Adding AGDR's new email to CC.


Konrad
