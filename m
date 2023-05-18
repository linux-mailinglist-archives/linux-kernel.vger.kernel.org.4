Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F2707E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjERKep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjERKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:34:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073301BFB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:34:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso207897366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684406080; x=1686998080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RC/1sciy0QBoH7anRgTXBV0jA9fPxn+8CaU4uzDVkg=;
        b=k053xBGCAuTA7fiT+gWM+OUIhtRRJHqt9y+xrqsH+KibV4Izto85yaYxnKEw19EUmc
         CiS07hAIYgKUm+mmPfagMcAN6ZrpIFc2NXLYZDSqUbuxWzkxn3bwUnN9/KsirxF19FXs
         E6YaPCbF2jqs1WDIpoRJFlYkKwodbtpj4FgBkDz6pMimjhrrZkZCGvYRexHAlVp47S7c
         RP3RJ1dyUTpw6maxUdVM0tXbBEnmrBCqWuLBpW3g4VfDmydtcW5ddOOkh6KuXRfWVftc
         dzG3T/cfHScb/1waO/w5qe666b0bUn1jpjOw0+smonZDNpL9eRPY6FsTlgVusPtdfV3G
         qVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684406080; x=1686998080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RC/1sciy0QBoH7anRgTXBV0jA9fPxn+8CaU4uzDVkg=;
        b=E/glRrKrxprJhsxgegaK+WOmFKZthSn/twmOQnmZ2mG9BFQ0cLRpOlAAdT6XGDVLKs
         7KfhyKG/y9Tp5xdw96NQb3MrLgSov6ppSuqd+1bU1kJZhGD15AUNeR+GZ07/3pSjeZrI
         5omOVpIE8WD9/aE3QqEfs9zfb86APRMX4QgFREszvKuRPYQpboBU24Kjs/oo8xcgDOGW
         0kJhryqmSaJ09e/BodwoGeoPy2lktC49IgAWkJ7RhXj/YOJ7/zlAFLe2NhxlLiBNm3Il
         WUlplrk0xilebK1IJJu1RQoaOapkkpW9IvVpqrqXyF2v4tBhgywJgk7FmPz/fMR0WZ5X
         CDBg==
X-Gm-Message-State: AC+VfDwj6zvAYFlyqc10td8xURpHTk6mjHhsVPGCUtrFZAcR8mSJr+LU
        1EqS4QJ1W4ojNZhajMBpQEQiFg==
X-Google-Smtp-Source: ACHHUZ4XPTb5278IzXALjeOxwbpWuF0b2L1XTq/bU/Bhzm9pn7WtM6on4sTP5U3OkI4HD4X97c8PkQ==
X-Received: by 2002:a17:907:9411:b0:969:2df9:a0dd with SMTP id dk17-20020a170907941100b009692df9a0ddmr4846983ejc.25.1684406080432;
        Thu, 18 May 2023 03:34:40 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id og19-20020a1709071dd300b0096f00d79d6asm795300ejc.54.2023.05.18.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:34:39 -0700 (PDT)
Date:   Thu, 18 May 2023 13:34:38 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Kai Ma <kaima@hust.edu.cn>, Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: clk-imxrt1050: fix memory leak in
 imxrt1050_clocks_probe
Message-ID: <ZGX/PjYBVGuECcPg@linaro.org>
References: <20230418113451.151312-1-kaima@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418113451.151312-1-kaima@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-18 11:34:51, Kai Ma wrote:
> Use devm_of_iomap() instead of of_iomap() to automatically
> handle the unused ioremap region. If any error occurs, regions allocated by
> kzalloc() will leak, but using devm_kzalloc() instead will automatically
> free the memory using devm_kfree().
> 
> Also, fix error handling of hws by adding unregister_hws label, which
> unregisters remaining hws when iomap failed.
> 
> Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
> Signed-off-by: Kai Ma <kaima@hust.edu.cn>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Stephen, can you apply this through clk-fixes?

> ---
> The issue is found by static analysis and remains untested.
> ---
>  drivers/clk/imx/clk-imxrt1050.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index fd5c51fc92c0..08d155feb035 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -42,7 +42,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	struct device_node *anp;
>  	int ret;
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>  					  IMXRT1050_CLK_END), GFP_KERNEL);
>  	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
> @@ -53,10 +53,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	hws[IMXRT1050_CLK_OSC] = imx_get_clk_hw_by_name(np, "osc");
>  
>  	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
> -	pll_base = of_iomap(anp, 0);
> +	pll_base = devm_of_iomap(dev, anp, 0, NULL);
>  	of_node_put(anp);
> -	if (WARN_ON(!pll_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(pll_base))) {
> +		ret = PTR_ERR(pll_base);
> +		goto unregister_hws;
> +	}
>  
>  	/* Anatop clocks */
>  	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
> @@ -104,8 +106,10 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  
>  	/* CCM clocks */
>  	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(ccm_base)))
> -		return PTR_ERR(ccm_base);
> +	if (WARN_ON(IS_ERR(ccm_base))) {
> +		ret = PTR_ERR(ccm_base);
> +		goto unregister_hws;
> +	}
>  
>  	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
>  	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
> @@ -149,8 +153,12 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
> -		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
> +		goto unregister_hws;
>  	}
> +	return 0;
> +
> +unregister_hws:
> +	imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
>  	return ret;
>  }
>  static const struct of_device_id imxrt1050_clk_of_match[] = {
> -- 
> 2.34.1
> 
