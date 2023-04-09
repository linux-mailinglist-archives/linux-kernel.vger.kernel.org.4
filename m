Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772506DC029
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjDINrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDINrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:47:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E33A9A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:47:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ga37so7340050ejc.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681048020; x=1683640020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qVGkKW+EWENAWvp7HsvarUoEIpNCD9RuGiyODmnzCnc=;
        b=MlGNCGh7gUXfpxxJNU0rhD1Z3MIzdG+6Vob7AZk5xWdHu5NeG10zyJW+OMB7jG8i9C
         7CkLwh82F4WGwXIQ2r0cSe4ChD2wEohl9GucqPRnhmIFn27VE2fv7Q3ETdBzQv0InIIF
         EMIvVphhah7+ztg3WkzuU3hwR4CzOcL8bDW/f5c6atRqOuSmogdZRijtYMCZRHP3VJ4j
         5oEyitgSp4uVb2MUt64wV9eoSzHRiYoNnTV2DG52+vKzLoercbG8/9RsD88fVwF5Ckmk
         ovtTZm+FClsgr7E0nDVXB7GOGQaZtDCSE4KunajR71YY9rM9b3fOj6KWB5DzsVHjKjSJ
         1VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681048020; x=1683640020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVGkKW+EWENAWvp7HsvarUoEIpNCD9RuGiyODmnzCnc=;
        b=Q4FIX8LU2bDRaz6hzckuMkdwk19fEgzaTLGOiBw7HP49ukZrRKxuG7VS3mjByNSVaA
         mCgCpeZJoKEQTBmfwuXBGL8cz0Og+P1W3TZJv1Ch5BrnTAGnstFJ3UnitUt7Zv1AcPwi
         QrputgD6VV9Hj97/wNVbUAtjDYihmjLy9MKt1ZyPSbSNPvz0k/TgwaKLb7Cozt+VpC2R
         PwqQQRwXrf+kL4m6DUejkuxAkVUjKxKYEgvONLPdVNRSuBZGvNjnPo03/wBF1ot6sQBc
         Mu7Ermnamuun8ltdkkclz7c6BZ8FNcfl/Ou6GBmtYU3gjT0zbflu4PgstWxVQ/XXKeW8
         XQGw==
X-Gm-Message-State: AAQBX9cXpqeJq1oRqM2ryGxhkSUS1I+z5GYjq8nLyAYGWBw8HVk4EjIc
        2sV/BdRWfHsj7P5FEpEo/PP3AA==
X-Google-Smtp-Source: AKy350a9atDUbjvFebF9fjuKLp2tJILWMQN2IzhGZ3vG1rLblRY3qOoDuOlRPPUEl+cWm5WPkMRyaQ==
X-Received: by 2002:a17:907:1111:b0:947:7a69:96cf with SMTP id qu17-20020a170907111100b009477a6996cfmr4505983ejb.22.1681048019783;
        Sun, 09 Apr 2023 06:46:59 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id re9-20020a170906d8c900b0093dbb008281sm4162829ejb.130.2023.04.09.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:46:59 -0700 (PDT)
Date:   Sun, 9 Apr 2023 16:46:57 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH V3 5/7] clk: imx: imx93: add mcore_booted module
 paratemter
Message-ID: <ZDLB0SMCyYFFovI/@linaro.org>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
 <20230403095300.3386988-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403095300.3386988-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-03 17:52:58, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add mcore_booted boot parameter which could simplify AMP clock
> management. To i.MX93, there is CCM(clock control Module) to generate
> clock root clock, anatop(analog PLL module) to generate PLL, and LPCG
> (clock gating) to gate clocks to peripherals. As below:
> anatop->ccm->lpcg->peripheral
> 
> Linux handles the clock management and the auxiliary core is under
> control of Linux. Although there is per hardware domain control for LPCG
> and CCM, auxiliary core normally only use LPCG hardware domain control
> to avoid linux gate off the clk to peripherals and leave CCM ana anatop
> to Linux.
> 
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-composite-93.c | 8 +++++++-
>  drivers/clk/imx/clk-imx93.c        | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
> index 74a66b0203e4..81164bdcd6cc 100644
> --- a/drivers/clk/imx/clk-composite-93.c
> +++ b/drivers/clk/imx/clk-composite-93.c
> @@ -222,7 +222,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
>  		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
>  					       mux_hw, &clk_mux_ro_ops, div_hw,
>  					       &clk_divider_ro_ops, NULL, NULL, flags);
> -	} else {
> +	} else if (!mcore_booted) {
>  		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
>  		if (!gate)
>  			goto fail;
> @@ -238,6 +238,12 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
>  					       &imx93_clk_composite_divider_ops, gate_hw,
>  					       &imx93_clk_composite_gate_ops,
>  					       flags | CLK_SET_RATE_NO_REPARENT);
> +	} else {
> +		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
> +					       &imx93_clk_composite_divider_ops, NULL,
> +					       &imx93_clk_composite_gate_ops,
> +					       flags | CLK_SET_RATE_NO_REPARENT);
>  	}
>  
>  	if (IS_ERR(hw))
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 8d0974db6bfd..de1ed1d8ba54 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -352,6 +352,8 @@ static struct platform_driver imx93_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx93_clk_driver);
> +module_param(mcore_booted, bool, 0444);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>  
>  MODULE_DESCRIPTION("NXP i.MX93 clock driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.37.1
> 
