Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9A5EF869
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiI2PLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiI2PL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:11:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6382012518E;
        Thu, 29 Sep 2022 08:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4871B824D3;
        Thu, 29 Sep 2022 15:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66E7C433D6;
        Thu, 29 Sep 2022 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664464284;
        bh=TG7+rWU884/Oq8a/z1jdR74kaf5vTAccbPkrPjPqVj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSmzAfvm0466RLeAiUizse5MLIazXbDuAxg6k6HpHKqE/H9aXrRnTrSS9dMpGYHpj
         MACq2v6s/Kd+npv9u1pbkvdR7VFMyi0vy60o55bJVJw4eolCMj6juH9KLir4RmNswk
         TwcEX/mE5oOWy1dljls32bQHtuytAVwuiyhNaIM3MNtAL+kwVdidNkIBfqSrMvD5Uh
         j69PY8SQvo9b07RnGhDiONpsmxalMlJf8brQOh1gHSib0N6Gp8+BDbPbER9DRqn3Fc
         SzZdXgUVTalyc/VmKixcCaqodxhrSqT/j+hTFfYpipNsnucMiC+SKwsKoO0eyNX0gq
         FdZ0LhiEfVYAA==
Date:   Thu, 29 Sep 2022 10:11:21 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 2/2] clk: qcom: sdm845: Add clk_sync_state_disable_unused
 as sync_state
Message-ID: <20220929151121.a3nosyqh4jx3jjdt@builder.lan>
References: <20220706150411.708213-1-abel.vesa@linaro.org>
 <20220706150411.708213-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706150411.708213-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 06:04:11PM +0300, Abel Vesa wrote:
> By adding the newly added clk_sync_state_disable_unused as sync_state
> callback to all sdm845 clock providers, we make sure that no clock
> belonging to these providers gets disabled on clk_disable_unused,
> but rather they are disabled on sync_state, when it is safe, since
> all the consumers build as modules have their chance of enabling
> their own clocks.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/camcc-sdm845.c  | 1 +
>  drivers/clk/qcom/dispcc-sdm845.c | 1 +
>  drivers/clk/qcom/gcc-sdm845.c    | 1 +
>  drivers/clk/qcom/gpucc-sdm845.c  | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm845.c
> index 27d44188a7ab..e5aeb832e47b 100644
> --- a/drivers/clk/qcom/camcc-sdm845.c
> +++ b/drivers/clk/qcom/camcc-sdm845.c
> @@ -1743,6 +1743,7 @@ static struct platform_driver cam_cc_sdm845_driver = {
>  	.driver	= {
>  		.name = "sdm845-camcc",
>  		.of_match_table = cam_cc_sdm845_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
> index 735adfefc379..1810d58bad09 100644
> --- a/drivers/clk/qcom/dispcc-sdm845.c
> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> @@ -869,6 +869,7 @@ static struct platform_driver disp_cc_sdm845_driver = {
>  	.driver		= {
>  		.name	= "disp_cc-sdm845",
>  		.of_match_table = disp_cc_sdm845_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 58aa3ec9a7fc..5db75d5ba584 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3624,6 +3624,7 @@ static struct platform_driver gcc_sdm845_driver = {
>  	.driver		= {
>  		.name	= "gcc-sdm845",
>  		.of_match_table = gcc_sdm845_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
> index 110b54401bc6..622a54a67d32 100644
> --- a/drivers/clk/qcom/gpucc-sdm845.c
> +++ b/drivers/clk/qcom/gpucc-sdm845.c
> @@ -205,6 +205,7 @@ static struct platform_driver gpu_cc_sdm845_driver = {
>  	.driver = {
>  		.name = "sdm845-gpucc",
>  		.of_match_table = gpu_cc_sdm845_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> -- 
> 2.34.3
> 
