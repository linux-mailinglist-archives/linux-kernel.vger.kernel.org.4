Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6F7083FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjEROhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjEROhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:37:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62050E1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:37:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30626f4d74aso1435752f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684420624; x=1687012624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuGTxg0Bi/ffAC7iy/DtX+nu1bNY6UiYni6S2M+CTBo=;
        b=uu6zp1lK/hmMYrNMGLBtZREqtb7Tu+8G65p8ZUDUwaLdTMlj+UlOePKjfCN/GuBkzr
         F4vu8SLwLHOnZgwdkzLpQ7TEZNPGJyaZ8EVhBMICnr9WtiqZBWJKaAQ6iyVVT69/BinU
         RFsOcXPuYQoKpgMFdIKp6UBt0oBB603zNxYojH7jg8LOpQUNg4LzKnmaJceWG0nq6vkl
         01N4Nmy5kfh5IWX7dTfKa0+45woOKASQW7VEPBf3NT2pW25a1PEuzs6Rd8tqpNN5dfn5
         6MjtRjasIyyQiBiY4Iz0BWSRxUJf1ZrKSlnGzjEIhvVKzbFIBfQprtTC7oEh0Mc5B2iz
         Jbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684420624; x=1687012624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuGTxg0Bi/ffAC7iy/DtX+nu1bNY6UiYni6S2M+CTBo=;
        b=Y0Iu3BOreggQX8UWWSij4I1F9DpgNO1RzQ9NfcB8dSWVP0PL8PztqoiWC9Q9h8M6KD
         0dWO+92Ry4yEsf2obl2EUusNXOSHCrGO3Q4nmKy7nghDBl9nSCKUPoNBRS0JzF3isiGV
         3EOt2et4ldGQiXDNGlFuZD9mc0PP5VfRfUoT2AFdv+ECglA4oOo9UpcNdmA84WLiYwz+
         4/lVCthH80bakX46lCj7toLPMuxKy0SiIOEL7ml3ATeymy5/F23KIj3UDey7ZO8FRtRJ
         ukcDaJmsH9NOWdJ0kHQ2E6aziBl/Z4CQ0odb9FmBliC0NCqaOA9xrixSzQPBGgpV3oVs
         LyOQ==
X-Gm-Message-State: AC+VfDzUg3ar8RSl0KXnDxj6+IHE0QvD7wis37lKZz02XEOR01oIbEYe
        RH9GWQ1UrbhEHAPtwf/9oJsOurxuXy2xD6d9HVw=
X-Google-Smtp-Source: ACHHUZ7NJGL16Mofflwp6cgsGutN16kV09se5SAVk1PwcuHN/HbYK5qIkbY4G9uUq8a2s04i0T001Q==
X-Received: by 2002:adf:f0cc:0:b0:306:2e48:6ded with SMTP id x12-20020adff0cc000000b003062e486dedmr1774419wro.13.1684420623773;
        Thu, 18 May 2023 07:37:03 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d5189000000b003063176ef09sm2424748wrv.6.2023.05.18.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:37:03 -0700 (PDT)
Date:   Thu, 18 May 2023 17:37:01 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Zhanhao Hu <zero12113@hust.edu.cn>
Cc:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx93: fix memory leak and missing unwind goto in
 imx93_clocks_probe
Message-ID: <ZGY4DQ7JKvC1fMyt@linaro.org>
References: <20230426142552.217435-1-zero12113@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426142552.217435-1-zero12113@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-26 14:25:52, Zhanhao Hu wrote:
> In function probe(), it returns directly without unregistered hws
> when error occurs.
> 
> I fix this by adding 'goto unregister_hws;' on line 295 and
> line 310.

Hi Zhanhao,

I like your patch, but there are some things to improve in the commit
message.

Have a read here before rephrasing it:
https://docs.kernel.org/process/submitting-patches.html

Quoting the above doc:
"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
do frotz", as if you are giving orders to the codebase to change its
behaviour."

> 
> Besides, I use devm_kzalloc() instead of kzalloc() to automatically
> free the memory using devm_kfree() when error occurs.

So this should be rephrased like:

Use devm_kzalloc instead of kzalloc, to automatically free the memory...

> 
> Similarly, I replace of_iomap() with devm_of_iomap() to automatically
> handle the unused ioremap region. So I delete 'iounmap(anatop_base);'
> in unregister_hws.

Same here. Make it imperative rather than mentioning what you're doing
in this patch.

With the commit rephrased in a new version, I'll be more than happy to
apply it.

> 
> Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> Signed-off-by: Zhanhao Hu <zero12113@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> This issue is found by static analysis and remains untested.
> ---
>  drivers/clk/imx/clk-imx93.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 07b4a043e449..b6c7c2725906 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -264,7 +264,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  	void __iomem *base, *anatop_base;
>  	int i, ret;
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>  					  IMX93_CLK_END), GFP_KERNEL);
>  	if (!clk_hw_data)
>  		return -ENOMEM;
> @@ -288,10 +288,12 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  								    "sys_pll_pfd2", 1, 2);
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
> -	anatop_base = of_iomap(np, 0);
> +	anatop_base = devm_of_iomap(dev, np, 0, NULL);
>  	of_node_put(np);
> -	if (WARN_ON(!anatop_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(anatop_base))) {
> +		ret = PTR_ERR(base);
> +		goto unregister_hws;
> +	}
>  
>  	clks[IMX93_CLK_ARM_PLL] = imx_clk_fracn_gppll_integer("arm_pll", "osc_24m",
>  							      anatop_base + 0x1000,
> @@ -304,8 +306,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  	np = dev->of_node;
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (WARN_ON(IS_ERR(base))) {
> -		iounmap(anatop_base);
> -		return PTR_ERR(base);
> +		ret = PTR_ERR(base);
> +		goto unregister_hws;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
> @@ -345,7 +347,6 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  
>  unregister_hws:
>  	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
> -	iounmap(anatop_base);
>  
>  	return ret;
>  }
> -- 
> 2.34.1
> 
