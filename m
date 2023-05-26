Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A424F712662
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbjEZMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEZMOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C76A4;
        Fri, 26 May 2023 05:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1737E616C2;
        Fri, 26 May 2023 12:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C268C433D2;
        Fri, 26 May 2023 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685103259;
        bh=ie8W85JCZJw+1kXzwwRRA1xccIVhx8VKs9vozRVZDjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdrK5W0H6z9YKfWIyhCUvEC0fW9AEIu90sPg8kaPmERCGK6Y+tZPSpyxW14+IoIs3
         Q4k/FMVYBl3t+wb2kEiu5U0y57kx1/UaA7J9ORSnKQA+OttE//rIYiICgIgAMRbLbE
         1XIu1D348rIaX+t5O5p8FFrGvSTbaGOn95qnuHsEAOfJKyGudzAmJtbQifFinAN/2s
         UXsiDRhQ1GoUDlU47QIS8NyDLB46YhBBQ4wDpEyMp8p5USH2tPIdAKFz5nR7zOyUSN
         elabqyDgZmXSwYKV+Iafjamem9wbI8OCDnWfej7rrXhVdM3Bg648MTLUpBuh65as+y
         DnCCfw426BbKA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2WL1-00074s-7S; Fri, 26 May 2023 14:14:31 +0200
Date:   Fri, 26 May 2023 14:14:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] clk: qcom: Add lpass audio clock controller
 driver for SC8280XP
Message-ID: <ZHCip-9Fu4RaPlz0@hovoldconsulting.com>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525122930.17141-5-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:29:28PM +0100, Srinivas Kandagatla wrote:
> Add support for the lpass audio clock controller found on SC8280XP based
> devices. This would allow lpass peripheral loader drivers to control the
> clocks and bring the subsystems out of reset.
> 
> Currently this patch only supports resets as the Q6DSP is in control of
> LPASS IP which manages most of the clocks via Q6PRM service on GPR rpmsg
> channel.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/clk/qcom/lpasscc-sc8280xp.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/clk/qcom/lpasscc-sc8280xp.c b/drivers/clk/qcom/lpasscc-sc8280xp.c
> index 547f15d41a9d..60cc3c98d03d 100644
> --- a/drivers/clk/qcom/lpasscc-sc8280xp.c
> +++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
> @@ -14,6 +14,26 @@
>  #include "common.h"
>  #include "reset.h"
>  
> +static const struct qcom_reset_map lpass_audiocc_sc8280xp_resets[] = {
> +	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
> +	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
> +	[LPASS_AUDIO_SWR_WSA2_CGCR] =  { 0xd8, 1 },
> +};
> +
> +static struct regmap_config lpass_audiocc_sc8280xp_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.name = "lpass-audio-csr",
> +	.max_register = 0x1000,
> +};
> +
> +static const struct qcom_cc_desc lpass_audiocc_reset_sc8280xp_desc = {

Similar here, should this not be lpass_audiocc_sc8280xp_reset_desc or
similar for consistency?

> +	.config = &lpass_audiocc_sc8280xp_regmap_config,
> +	.resets = lpass_audiocc_sc8280xp_resets,
> +	.num_resets = ARRAY_SIZE(lpass_audiocc_sc8280xp_resets),
> +};
> +
>  static const struct qcom_reset_map lpasscc_sc8280xp_resets[] = {
>  	[LPASS_AUDIO_SWR_TX_CGCR] = { 0xc010, 1 },
>  };
> @@ -34,6 +54,9 @@ static const struct qcom_cc_desc lpasscc_reset_sc8280xp_desc = {
>  
>  static const struct of_device_id lpasscc_sc8280xp_match_table[] = {
>  	{
> +		.compatible = "qcom,sc8280xp-lpassaudiocc",
> +		.data = &lpass_audiocc_reset_sc8280xp_desc,
> +	}, {
>  		.compatible = "qcom,sc8280xp-lpasscc",
>  		.data = &lpasscc_reset_sc8280xp_desc,
>  	},

LGTM otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
