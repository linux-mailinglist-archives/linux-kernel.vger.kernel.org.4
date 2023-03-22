Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A676C40A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCVC7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCVC7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F66570B9;
        Tue, 21 Mar 2023 19:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C225061F0A;
        Wed, 22 Mar 2023 02:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40105C433D2;
        Wed, 22 Mar 2023 02:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679453946;
        bh=hbbRSvW3k2Vdsx6zL8t6kCVT4bupyyrB6lhawAkzPOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rC3XCQ7ZIjJ24wJUytONOtqdk/19S7cAHUzrah6RaVcKeQ2nOKwM1i7WLnnAKH1Jy
         ekEqCpg2HYn16FNnL2g2qsRs1Rst95TF4QtguJLSvWlOnxw+KwzhHgnHPiE14d7GnV
         iwMcyrcP8VwEhBAtC8yTOTJQ46kyeScn8uhesixRC3vop1KbrBFLEHrQA1F3Wg0wCe
         ZL4cpfWe27PXD6nZEVkMsiYp30VFibwprzWn8FFFvl1r54wjCt1DPxfQ0V9vCNm9MH
         cCPXP2cFTuY87pn2MUMomVtebHM1sSURpnYxDyWwZt2LIS3dys+j5Dz51eO3ItVbje
         i14FoaYo7Ntlw==
Date:   Tue, 21 Mar 2023 20:02:18 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH RFT v2 02/14] clk: qcom: smd-rpm: Add .is_enabled hook
Message-ID: <20230322030218.7xjrsgt3abqft2y7@ripper>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-2-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-2-ae80a325fe94@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:35:18PM +0100, Konrad Dybcio wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The RPM clock enabling state can be found with 'enabled' in struct
> clk_smd_rpm.  Add .is_enabled hook so that clk_summary in debugfs can
> show a correct enabling state for RPM clocks.
> 

I don't think .is_enabled should be implemented for clocks where the
actual state can't be queried.

E.g. should a clock which is is_enabled = false be unprepared during
disable_unused? It's already disabled...

Regards,
Bjorn

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> [Konrad: rebase]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 198886c1b6c8..ecacfbc4a16c 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -424,18 +424,27 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
>  	return 0;
>  }
>  
> +static int clk_smd_rpm_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
> +
> +	return r->enabled;
> +}
> +
>  static const struct clk_ops clk_smd_rpm_ops = {
>  	.prepare	= clk_smd_rpm_prepare,
>  	.unprepare	= clk_smd_rpm_unprepare,
>  	.set_rate	= clk_smd_rpm_set_rate,
>  	.round_rate	= clk_smd_rpm_round_rate,
>  	.recalc_rate	= clk_smd_rpm_recalc_rate,
> +	.is_enabled	= clk_smd_rpm_is_enabled,
>  };
>  
>  static const struct clk_ops clk_smd_rpm_branch_ops = {
>  	.prepare	= clk_smd_rpm_prepare,
>  	.unprepare	= clk_smd_rpm_unprepare,
>  	.recalc_rate	= clk_smd_rpm_recalc_rate,
> +	.is_enabled	= clk_smd_rpm_is_enabled,
>  };
>  
>  DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000);
> 
> -- 
> 2.39.2
> 
