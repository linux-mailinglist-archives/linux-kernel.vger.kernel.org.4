Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10F67D3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjAZSTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:19:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B585E504;
        Thu, 26 Jan 2023 10:19:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2258DB81EC9;
        Thu, 26 Jan 2023 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22712C433EF;
        Thu, 26 Jan 2023 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674757177;
        bh=fMbvpdY4LhT/plsYFJopPqhOxAufgim8fKxCWytJLaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcILIp7kPxYF23bBgm/G20DBJ9ES7nqnnZX4jep/Ttz/YQIA6rYoViK0wToZ+aRiS
         FmchqdUTmyQn5u+t3FWe64ZJwf0vaBvLH+axoImbEOK1lQirPGXRxEeqiJn282cCL8
         tUfkku3R5jQwEl4AmjVrA308mKS5Rwatj6rUjxctbYlFDx66cOwWUdD5SLbVh8zX8V
         RzQ+2M31UdObPbquc7jk0CYZyoDZIFiND4wGLdCvG9VVfn8TlCmVjZ6/60imsqCQA8
         va6Ny9rMFUieaUxczbUwHyDRfFDLnJZgD3hWXRQM4hCx7KQndmfs4dlCvSZ0rBUJko
         ja3VL4rnEDlSw==
Date:   Thu, 26 Jan 2023 12:19:35 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: qcom: Add GPU clock controller driver for SM6125
Message-ID: <20230126181935.mg7eida2e5vp42hc@builder.lan>
References: <20230126144033.216206-1-konrad.dybcio@linaro.org>
 <20230126144033.216206-3-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126144033.216206-3-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:40:29PM +0100, Konrad Dybcio wrote:
> diff --git a/drivers/clk/qcom/gpucc-sm6125.c b/drivers/clk/qcom/gpucc-sm6125.c
[..]
> +static int gpu_cc_sm6125_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	unsigned int value, mask;
> +
> +	regmap = qcom_cc_map(pdev, &gpu_cc_sm6125_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	clk_alpha_pll_configure(&gpu_cc_pll0_out_aux2, regmap, &gpu_pll0_config);
> +	clk_alpha_pll_configure(&gpu_cc_pll1_out_aux2, regmap, &gpu_pll1_config);
> +
> +	/* Recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
> +	mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
> +	mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
> +	value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;

Perhaps I'm missing something here, but isn't mask == value after this?

Feels like this could be written cleaner using FIELD_PREP(), or perhaps
even moved to a helper function, so that we don't need to open code this
if it's needed in other places?

> +	regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, mask, value);
> +
> +	/* Set up PERIPH/MEM retain on the GPU core clock */
> +	regmap_update_bits(regmap, gpu_cc_gx_gfx3d_clk.halt_reg,
> +			   (BIT(14) | BIT(13)), (BIT(14) | BIT(13)));

You don't need the extra parenthesis here.

> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm6125_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm6125_driver = {
> +	.probe = gpu_cc_sm6125_probe,
> +	.driver = {
> +		.name = "gpucc-sm6125",
> +		.of_match_table = gpu_cc_sm6125_match_table,
> +	},
> +};
> +
> +static int __init gpu_cc_sm6125_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sm6125_driver);
> +}
> +subsys_initcall(gpu_cc_sm6125_init);

You don't need GPU at subsys, module_platform_driver() should be
sufficient (and =m in defconfig).

Thanks,
Bjorn
