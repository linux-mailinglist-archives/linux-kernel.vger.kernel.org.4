Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F76262E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiKKU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiKKU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:27:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9276F80;
        Fri, 11 Nov 2022 12:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A31C5620E0;
        Fri, 11 Nov 2022 20:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1F3C433C1;
        Fri, 11 Nov 2022 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668198475;
        bh=Y5Dw/OOyI6sYBlM0cZs0xJ8i4Ulq91X+S48irGu3LUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnrQAizhs2WWMYfybXQ6nVwA7jJG9M0+Z8/Fot/G1aJVbjTSWyGULYrfAqmOGCQa3
         5ubmZZu/5J0hE7aHgW9uHwSM1jOG7rwLjHtEV7UDVWBlBopNewIgBJfjRgMmcX4hER
         mjB2yjHKFx31u4XIa+GIzsqGl4pZIztfvJyLMqYscnYDdFxu2yP/GBOmlKlc/9zVit
         U5Bpdx0bBYk37xnmLbHMsJW4QxGDSLpdmfYjt47I9w2YO1iAKMC+OXu4LqldPwpqnK
         aTB9696SJWs+x62UnaDWH1+3Vg4Eq9GoTyG2Px+pmvH2iEzJlEm79gIYgZNQGsIh4u
         X/lo+tXVm+57A==
Date:   Fri, 11 Nov 2022 14:27:52 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: qcom-qmp-usb: drop sc8280xp reference-clock
 source
Message-ID: <20221111202752.s2ob3fft5ndh7elj@builder.lan>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
 <20221111093857.11360-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111093857.11360-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:38:56AM +0100, Johan Hovold wrote:
> The source clock for the reference clock is not used by the PHY directly
> and should not be described by the devicetree (instead this relationship
> should be modelled in the clock driver).
> 
> Drop the driver management of the reference-clock source for SC8280XP.
> 
> Once the other clock drivers have been updated, the corresponding change
> can be done also for the other QMP v4 platforms.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 372f9853c749..9b1f8c9d0eb8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1523,6 +1523,10 @@ static const char * const qmp_v3_phy_clk_l[] = {
>  };
>  
>  static const char * const qmp_v4_phy_clk_l[] = {
> +	"aux", "ref", "com_aux",
> +};
> +
> +static const char * const qmp_v4_ref_phy_clk_l[] = {
>  	"aux", "ref_clk_src", "ref", "com_aux",
>  };
>  
> @@ -1729,8 +1733,8 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_pcs_tbl),
>  	.pcs_usb_tbl		= sm8150_usb3_pcs_usb_tbl,
>  	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_pcs_usb_tbl),
> -	.clk_list		= qmp_v4_phy_clk_l,
> -	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
> +	.clk_list		= qmp_v4_ref_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
>  	.reset_list		= msm8996_usb3phy_reset_l,
>  	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> @@ -1755,8 +1759,8 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_tbl),
>  	.pcs_usb_tbl		= sm8150_usb3_uniphy_pcs_usb_tbl,
>  	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_usb_tbl),
> -	.clk_list		= qmp_v4_phy_clk_l,
> -	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
> +	.clk_list		= qmp_v4_ref_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
>  	.reset_list		= msm8996_usb3phy_reset_l,
>  	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> @@ -1806,8 +1810,8 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
>  	.pcs_usb_tbl		= sm8250_usb3_uniphy_pcs_usb_tbl,
>  	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_usb_tbl),
> -	.clk_list		= qmp_v4_phy_clk_l,
> -	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
> +	.clk_list		= qmp_v4_ref_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
>  	.reset_list		= msm8996_usb3phy_reset_l,
>  	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> @@ -1907,8 +1911,8 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
>  	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
>  	.pcs_usb_tbl		= sm8350_usb3_uniphy_pcs_usb_tbl,
>  	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_usb_tbl),
> -	.clk_list		= qmp_v4_phy_clk_l,
> -	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
> +	.clk_list		= qmp_v4_ref_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
>  	.reset_list		= msm8996_usb3phy_reset_l,
>  	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
>  	.vreg_list		= qmp_phy_vreg_l,
> -- 
> 2.37.4
> 
