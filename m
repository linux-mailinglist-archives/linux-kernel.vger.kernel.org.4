Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9394A6E1AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNDVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNDVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656522D40;
        Thu, 13 Apr 2023 20:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD4D664337;
        Fri, 14 Apr 2023 03:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A3EC433D2;
        Fri, 14 Apr 2023 03:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681442469;
        bh=Djr/EyzdyP74eCkHVTABOcQP+MzKJ4RKp9Nj+Tms4SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEu9cQWik9DprlY3c368E3poUdVwDmzOJCu1Anf6o+tSvz771TpnfPZly7u38pYXK
         dS6cvRKiYXnT4DaYb/Wb+0jr4v1nZRp2+S+oyE9Xzl8BrMMyaXhVlIsfN5Yb2TWDC1
         0ngc+aI7GwXzJrUCKpunKngH+GC0f3wstX8UiaS0sR45hBnG0YnCSb/UkMoCXZ2Nb5
         MRemtwXKdFq9PQM2mT72jf+ew3CamESuuGjz/dZs7I8nZXd/JGxuCaSoeONTXXm+6W
         9BQTgLFto9gIvQlQBWncG+X2jS6/m7F4DmPa4GSknIRZE51j3tXqicFw/UJw+/+ZGc
         x7GaX4KY40dfg==
Date:   Thu, 13 Apr 2023 20:24:47 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling
Message-ID: <20230414032447.gwcn2akewuunvydf@ripper>
References: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
 <20230412-topic-qcm_dispcc-v1-3-bf2989a75ae4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-topic-qcm_dispcc-v1-3-bf2989a75ae4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:53:07PM +0200, Konrad Dybcio wrote:
> GPLL0_OUT_DIV was previously shoved in under the name of its undivided
> sibling in parent_map_2. Resolve it.
> 

I'm afraid I don't understand what you're saying here, can you please
rework it?

Thanks,
Bjorn

> Fixes: cc517ea3333f ("clk: qcom: Add display clock controller driver for QCM2290")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/dispcc-qcm2290.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
> index ee62aca4e5bb..44dd5cfcc150 100644
> --- a/drivers/clk/qcom/dispcc-qcm2290.c
> +++ b/drivers/clk/qcom/dispcc-qcm2290.c
> @@ -28,6 +28,7 @@ enum {
>  	P_DISP_CC_PLL0_OUT_MAIN,
>  	P_DSI0_PHY_PLL_OUT_BYTECLK,
>  	P_DSI0_PHY_PLL_OUT_DSICLK,
> +	P_GPLL0_OUT_DIV,
>  	P_GPLL0_OUT_MAIN,
>  	P_SLEEP_CLK,
>  };
> @@ -84,7 +85,7 @@ static const struct clk_parent_data disp_cc_parent_data_1[] = {
>  
>  static const struct parent_map disp_cc_parent_map_2[] = {
>  	{ P_BI_TCXO_AO, 0 },
> -	{ P_GPLL0_OUT_MAIN, 4 },
> +	{ P_GPLL0_OUT_DIV, 4 },
>  };
>  
>  static const struct clk_parent_data disp_cc_parent_data_2[] = {
> @@ -153,8 +154,8 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
>  
>  static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
>  	F(19200000, P_BI_TCXO_AO, 1, 0, 0),
> -	F(37500000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> -	F(75000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	F(37500000, P_GPLL0_OUT_DIV, 8, 0, 0),
> +	F(75000000, P_GPLL0_OUT_DIV, 4, 0, 0),
>  	{ }
>  };
>  
> 
> -- 
> 2.40.0
> 
