Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2072BA59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjFLIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjFLIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:23:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9B115
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:23:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7ebb2b82cso42126125e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686558227; x=1689150227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3syFK18W0x1MXZeXQYRchVrFaPqAMr+pqA7DuRcsYMA=;
        b=ylTAA8QlrBqMuraIbm1w7bKvtYTyva4XcKAYVkJWL9v2NSi6BuH0RwJtMXZllapArk
         C+wTtynfpchd648WB6+TWK7SGU8Vi8o2VJ8rPKTwdwVz/FKg49th3RtCE4YD63n38JUF
         VbE6Fn4AFfviuqGRWiWcTmlfY3bychJtBtcbWxkgMuYscw5daM8ckZgGC3ub9xcLuqUW
         WZ4P1CyYMUQI5DTiRoSe5lYPbkR16yW8VI17lbH4s6V/w012JmV2M/1XOxcK5Cqa17QZ
         rJg3kNeiPf3Ko3hRftQrrS1FwIju8d9sPI0SayMtrcBvXxTaTXvK8Km7MxfHPDIukxmi
         HR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558227; x=1689150227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3syFK18W0x1MXZeXQYRchVrFaPqAMr+pqA7DuRcsYMA=;
        b=hMUMJnZFF5fZSXgRzbRQGY5ZdTr/ki8/2vfOryEf1YpMHMNqtj5iwllzS8dPtxNwI1
         C+9b2bnvtK79+VWnv6b1cwp7uJSza0AebFpg1cCjmfpdeafg4E6FCBwzYVWL2X448njs
         ljx+21qf4nlMZ+5CcGRvIdgouf5m5oEh4musA8rr4aBLn2oQeDTY9jk+Ljh7XxmdXgpK
         4G1ZDXVFvH6QHmJl7VyzrLP9EcZNvv04p6CtlBSPMP1P7e5xsbszOoyal8xBKt1gm2aP
         Ny3hfPYm1AyvGqU4s3zEHgV1BRriVaW/f4rtj8h6CQCnMyh6o9XFFgEdcoxCwD4YJ2SX
         tkIg==
X-Gm-Message-State: AC+VfDwCU/9Nt42KvUBfGGHT0Vb3JiSbveZRjKGkkEQpk0b2raUNYtgx
        pFIiwIBWRVRyJRTbcpM58AnspQ==
X-Google-Smtp-Source: ACHHUZ6Ynod2i9gs6NbQKZFbzx3ODJoQ+VZ1ZQXuEQh4aOJesHajKIm1t1uIdfbd6P2o8CDLR1ZEPw==
X-Received: by 2002:a5d:522b:0:b0:30f:c1f5:e91e with SMTP id i11-20020a5d522b000000b0030fc1f5e91emr1390141wra.27.1686558227544;
        Mon, 12 Jun 2023 01:23:47 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0030ae93bd196sm11655199wrr.21.2023.06.12.01.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:23:47 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:23:45 +0300
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
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx93: fix memory leak and missing unwind goto
 in imx93_clocks_probe
Message-ID: <ZIbWEW7MNCaqXq+k@linaro.org>
References: <20230601033825.336558-1-zero12113@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601033825.336558-1-zero12113@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-01 03:38:25, Zhanhao Hu wrote:
> In function probe(), it returns directly without unregistered hws
> when error occurs.
> 
> Fix this by adding 'goto unregister_hws;' on line 295 and
> line 310.
> 
> Use devm_kzalloc() instead of kzalloc() to automatically
> free the memory using devm_kfree() when error occurs.
> 
> Replace of_iomap() with devm_of_iomap() to automatically
> handle the unused ioremap region and delete 'iounmap(anatop_base);'
> in unregister_hws.
> 
> Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> Signed-off-by: Zhanhao Hu <zero12113@hust.edu.cn>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> V1 -> V2 : Rephrase commit message in imperative mood.
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
