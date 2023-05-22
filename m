Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3493070B7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjEVIdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjEVIdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD94BB;
        Mon, 22 May 2023 01:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B44A561825;
        Mon, 22 May 2023 08:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B26C433D2;
        Mon, 22 May 2023 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684744414;
        bh=Wv3m8nOFsRLwTg0GC/begIbxiUqM/YM8a3C1A+CGHKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXrj5C8iCl3PlcT9Q/UsRwdDx0MHcaaVpRf2pI0PTRXVCobXweIlOIwNkaZTdNBGt
         1GlW58Dv6R15J1rjeGQUkwT1Xj/bDrXYw4x12Nl635XCO2D9lLmm2fdZz+8o7YeK9y
         rpeMdoKAD2Wx/U3dT7n3h9vAq1wY11zvQNScw9H1u7UtykMsjU92R1JrS7IcUeNhW/
         87qho6ORkfnyBILUC7MoYCJOtJ89jCtEMo84noR3k8sAgeXamC1kXgvgDNob39dR2t
         IKA9HZMh0lejv7g25+SC5INnB85cGwuPcCLaK6JlO5zJRjD4sT87/m84obKzb4zZ/e
         KiY3GduLap80g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q10z0-0004Sm-1j; Mon, 22 May 2023 10:33:34 +0200
Date:   Mon, 22 May 2023 10:33:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] clk: qcom: Add lpass audio clock controller driver
 for SC8280XP
Message-ID: <ZGso3u6e0L5jXBLf@hovoldconsulting.com>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113800.339158-5-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:37:59PM +0100, Srinivas Kandagatla wrote:
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
> index 118320f8ee40..e221ae2d40ae 100644
> --- a/drivers/clk/qcom/lpasscc-sc8280xp.c
> +++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
> @@ -13,6 +13,26 @@
>  #include "common.h"
>  #include "reset.h"
>  
> +static const struct qcom_reset_map lpass_audio_csr_sc8280xp_resets[] = {
> +	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
> +	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
> +	[LPASS_AUDIO_SWR_WSA2_CGCR] =  { 0xd8, 1 },
> +};
> +
> +static struct regmap_config lpass_audio_csr_sc8280xp_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.name = "lpass-audio-csr",

Should you update this name to match the new compatible
("lpassaudiocc")?

> +	.max_register = 0x1000,
> +};
> +
> +static const struct qcom_cc_desc lpass_audio_csr_reset_sc8280xp_desc = {

Same here (and for the reset struct as well as previous patch).

> +	.config = &lpass_audio_csr_sc8280xp_regmap_config,
> +	.resets = lpass_audio_csr_sc8280xp_resets,
> +	.num_resets = ARRAY_SIZE(lpass_audio_csr_sc8280xp_resets),
> +};
> +
>  static const struct qcom_reset_map lpass_tcsr_sc8280xp_resets[] = {
>  	[LPASS_AUDIO_SWR_TX_CGCR] = { 0xc010, 1 },
>  };
> @@ -33,6 +53,9 @@ static const struct qcom_cc_desc lpass_tcsr_reset_sc8280xp_desc = {
>  
>  static const struct of_device_id lpasscc_sc8280xp_match_table[] = {
>  	{
> +		.compatible = "qcom,sc8280xp-lpassaudiocc",
> +		.data = &lpass_audio_csr_reset_sc8280xp_desc,
> +	}, {
>  		.compatible = "qcom,sc8280xp-lpasscc",
>  		.data = &lpass_tcsr_reset_sc8280xp_desc,
>  	},

Johan
