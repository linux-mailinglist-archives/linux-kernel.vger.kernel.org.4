Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942006953EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBMWbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBMWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:31:08 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1C1CF7C;
        Mon, 13 Feb 2023 14:31:00 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B93E1CDFDF;
        Mon, 13 Feb 2023 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676327428; bh=W5e6SYUWX17zrMB98W//q9HU+zE0DKgEBiyUmTDCQWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KU+C4uBtvCf7rgcT20qCwmxXtxu8zgGNHy3EKJ1DQiSulaQIKrqnk82aM79i9n/7C
         uKY3XYez7l8aY/5Rfj1ZFKgLZK41EA0ahbCPgxZdCR9N11/M4hBjhj5Tph6hi2Rc1F
         o85Xk6aza9AHxMVOT+L0589qUlC51FciJ0xoKG1I=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: qcom: camcc-sm6350: add pm_runtime support
Date:   Mon, 13 Feb 2023 23:30:27 +0100
Message-ID: <4777254.GXAFRqVoOG@z3ntu.xyz>
In-Reply-To: <20230213-sm6350-camcc-runtime_pm-v2-1-60a507bf3e68@z3ntu.xyz>
References: <20230213-sm6350-camcc-runtime_pm-v2-0-60a507bf3e68@z3ntu.xyz>
 <20230213-sm6350-camcc-runtime_pm-v2-1-60a507bf3e68@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 13. Februar 2023 14:08:06 CET Luca Weiss wrote:
> Make sure that we can enable and disable the power domains used for
> camcc when the clocks are and aren't used.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Apparently I messed up v2 too and had the wrong email in my git config. Will 
send a v3 to fix that as well...

> ---
>  drivers/clk/qcom/camcc-sm6350.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/camcc-sm6350.c
> b/drivers/clk/qcom/camcc-sm6350.c index acba9f99d960..dd65f3ef0857 100644
> --- a/drivers/clk/qcom/camcc-sm6350.c
> +++ b/drivers/clk/qcom/camcc-sm6350.c
> @@ -7,6 +7,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> 
>  #include <dt-bindings/clock/qcom,sm6350-camcc.h>
> @@ -1869,6 +1871,19 @@ MODULE_DEVICE_TABLE(of, camcc_sm6350_match_table);
>  static int camcc_sm6350_probe(struct platform_device *pdev)
>  {
>  	struct regmap *regmap;
> +	int ret;
> +
> +	ret = devm_pm_runtime_enable(&pdev->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_pm_clk_create(&pdev->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pm_runtime_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> 
>  	regmap = qcom_cc_map(pdev, &camcc_sm6350_desc);
>  	if (IS_ERR(regmap))
> @@ -1879,14 +1894,26 @@ static int camcc_sm6350_probe(struct platform_device
> *pdev) clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
> clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
> 
> -	return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
> +	ret = qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
> +	pm_runtime_put(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register CAM CC 
clocks\n");
> +		return ret;
> +	}
> +
> +	return 0;
>  }
> 
> +static const struct dev_pm_ops camcc_pm_ops = {
> +	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> +};
> +
>  static struct platform_driver camcc_sm6350_driver = {
>  	.probe = camcc_sm6350_probe,
>  	.driver = {
>  		.name = "sm6350-camcc",
>  		.of_match_table = camcc_sm6350_match_table,
> +		.pm = &camcc_pm_ops,
>  	},
>  };




