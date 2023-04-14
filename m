Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888D16E1AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDNDT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:19:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F162D40;
        Thu, 13 Apr 2023 20:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5C76436E;
        Fri, 14 Apr 2023 03:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5367C433EF;
        Fri, 14 Apr 2023 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681442364;
        bh=vlw0OmtIzS4my0jpfElfN6XPYFN+jvlhz6GJBl5P+ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffhTovzFt5dgn0/lkuY96gCun0Lf20ZOPrqnan6D2cpCkrDMmVq/2FIfi87zMsApk
         u3mPWR5FlEtK4FWU0S4Ul501qwyX12nLIP8msdxLmvlA+3/yHcXcbVnZQAGFoO7Xi0
         wOjV1EPH15ljIO+4CeixKRL4df5VLILFHVSSXqSSUoqfzWdmV2jBlc8FQM6v3+Cj/g
         0JESLeYGN+VD1tUy86Z0TlxtKfft0sudnROBhQQrtHlHpFT24g9Qtwl2qVMVn2I/9l
         gFNTaTErYDJKxh/lxP30/8mOXvdAeF45KoFfGnfIt8z5LB7P6JDBIgTJqopVSzkB8y
         gTa5I975RZN9g==
Date:   Thu, 13 Apr 2023 20:23:02 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
Message-ID: <20230414032302.bmrsntx6h7slbxu7@ripper>
References: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
 <20230412-topic-qcm_dispcc-v1-1-bf2989a75ae4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-topic-qcm_dispcc-v1-1-bf2989a75ae4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:53:05PM +0200, Konrad Dybcio wrote:
> BI_TCXO_AO was previously shoved in under the name of its non-AO
> sibling in parent_map_2. Resolve it.
> 
> Fixes: cc517ea3333f ("clk: qcom: Add display clock controller driver for QCM2290")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/dispcc-qcm2290.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
> index cbb5f1ec6a54..0f516c72e624 100644
> --- a/drivers/clk/qcom/dispcc-qcm2290.c
> +++ b/drivers/clk/qcom/dispcc-qcm2290.c
> @@ -24,6 +24,7 @@
>  
>  enum {
>  	P_BI_TCXO,
> +	P_BI_TCXO_AO,
>  	P_DISP_CC_PLL0_OUT_MAIN,
>  	P_DSI0_PHY_PLL_OUT_BYTECLK,
>  	P_DSI0_PHY_PLL_OUT_DSICLK,
> @@ -83,7 +84,7 @@ static const struct clk_parent_data disp_cc_parent_data_1[] = {
>  };
>  
>  static const struct parent_map disp_cc_parent_map_2[] = {
> -	{ P_BI_TCXO, 0 },
> +	{ P_BI_TCXO_AO, 0 },

I think the commit message fails to explain why the parent clock for the
AHB clocks should be active-only. Are you sure, can you please
elaborate?

Thanks,
Bjorn

>  	{ P_GPLL0_OUT_MAIN, 4 },
>  };
>  
> @@ -154,7 +155,7 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
>  };
>  
>  static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
> -	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(19200000, P_BI_TCXO_AO, 1, 0, 0),
>  	F(37500000, P_GPLL0_OUT_MAIN, 8, 0, 0),
>  	F(75000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
>  	{ }
> 
> -- 
> 2.40.0
> 
