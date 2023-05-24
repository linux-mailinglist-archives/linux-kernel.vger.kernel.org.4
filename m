Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F1270F009
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjEXH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEXH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:57:55 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E4393;
        Wed, 24 May 2023 00:57:52 -0700 (PDT)
Received: from [IPV6:2001:250:4000:511d:8894:e09e:de:de24] ([172.16.0.254])
        (user=lyx2022@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 34O7rxBA003146-34O7rxBB003146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 24 May 2023 15:53:59 +0800
Message-ID: <60946593-0df4-a131-fc4b-5c43b73df6ea@hust.edu.cn>
Date:   Wed, 24 May 2023 15:53:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] clk: imx: clk-imx8mp: improve error handling in
 imx8mp_clocks_probe()
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230503070607.2462-1-lyx2022@hust.edu.cn>
From:   Yuxing Liu <lyx2022@hust.edu.cn>
In-Reply-To: <20230503070607.2462-1-lyx2022@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lyx2022@hust.edu.cn
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

在 2023/5/3 15:06, Yuxing Liu 写道:
> Replace of_iomap() and kzalloc() with devm_of_iomap() and devm_kzalloc()
> which can automatically release the related memory when the device
> or driver is removed or unloaded to avoid potential memory leak.
>
> In this case, iounmap(anatop_base) in line 427,433 are removed
> as manual release is not required.
>
> Besides, referring to clk-imx8mq.c, check the return code of
> of_clk_add_hw_provider, if it returns negtive, print error info
> and unregister hws, which makes the program more robust.
>
> Fixes: 9c140d992676 ("clk: imx: Add support for i.MX8MP clock driver")
> Signed-off-by: Yuxing Liu <lyx2022@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> This issue is found by static analysis and remains untested.
> ---
>   drivers/clk/imx/clk-imx8mp.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 3253589851ff..de7d2d2176be 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -414,25 +414,22 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np;
>   	void __iomem *anatop_base, *ccm_base;
> +	int err;
>   
>   	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
> -	anatop_base = of_iomap(np, 0);
> +	anatop_base = devm_of_iomap(dev, np, 0, NULL);
>   	of_node_put(np);
> -	if (WARN_ON(!anatop_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(anatop_base)))
> +		return PTR_ERR(anatop_base);
>   
>   	np = dev->of_node;
>   	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(ccm_base))) {
> -		iounmap(anatop_base);
> +	if (WARN_ON(IS_ERR(ccm_base)))
>   		return PTR_ERR(ccm_base);
> -	}
>   
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> -	if (WARN_ON(!clk_hw_data)) {
> -		iounmap(anatop_base);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
>   		return -ENOMEM;
> -	}
>   
>   	clk_hw_data->num = IMX8MP_CLK_END;
>   	hws = clk_hw_data->hws;
> @@ -721,7 +718,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>   
>   	imx_check_clk_hws(hws, IMX8MP_CLK_END);
>   
> -	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register hws for i.MX8MP\n");
> +		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
> +		return err;
> +	}
>   
>   	imx_register_uart_clocks();
>   
