Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA34620856
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKHElQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKHElN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:41:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A035E0C5;
        Mon,  7 Nov 2022 20:41:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2400B61466;
        Tue,  8 Nov 2022 04:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17A9C433C1;
        Tue,  8 Nov 2022 04:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667882471;
        bh=u+aMSC7NtK/eF/XnaxPejrZT3LQ1++Bwr4IovOzzV24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWRfF3klqBvKduJp26siphyeNq3/RNm+nQkelqIna629PgV8dlx2m5+L7iJ/t2Isl
         CEBTukWsBpBnf8uLp9k3v3BvT8dovqFTIaIlF0vSt2euKYlIZFQe4PgFSYulFmmAEr
         Zk3KiHQMNF8skaoacDySPbl2cYzMTSuoVikmI66kLBdfqMXz/6XmabefgHk22meK1A
         vxhHNPSX0nLU0airdnO+Jm4QT2lPKkvK/t2lB1yTAnXy2kyVCn9FOAaA6BsWm6gK55
         4h3E+//4Ae+v3izNeGulcQpVBmWZGbcS7yZmWPjAlzrUH8r8693DBVsYaS7OkSwnLR
         QpYkHuETB4zRg==
Date:   Mon, 7 Nov 2022 22:41:08 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996pro-xiaomi-scorpio: Remove DSI
 PHY clocks from MMCC
Message-ID: <20221108044108.se3et4do5q2dspsb@builder.lan>
References: <20221107114016.356112-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107114016.356112-1-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:40:17PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Having DSI PHY clocks listed in the MMCC node while MDSS is disabled makes
> it defer probe indefinitely, resulting in simplefb and other blocks that
> depend on its clocks to defer probe as well. Remove DSI PHY clocks from
> MMCC to let it probe with MDSS disabled.
> 

Isn't this a generic problem that we will have all over the place, where
we describe incoming clocks from all PHYs and then only enable the ones
actually available on each platform?

Am I missing something special with this case? I think the kernel need
to handle this.

Regards,
Bjorn

> Fixes: 48aa636285ad ("arm64: dts: qcom: msm8996: add clocks to the MMCC device node")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts     | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
> index 7bf6ad1a214b..c68c2dadd7b4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
> @@ -113,6 +113,19 @@ &mdss {
>  	status = "disabled";
>  };
>  
> +&mmcc {
> +	/*
> +	 * Remove non-essential DSI PHY clocks to allow MMCC to probe
> +	 * with MDSS disabled.
> +	 */
> +	clocks = <&xo_board>,
> +		 <&gcc GCC_MMSS_NOC_CFG_AHB_CLK>,
> +		 <&gcc GPLL0>;
> +	clock-names = "xo",
> +		      "gcc_mmss_noc_cfg_ahb_clk",
> +		      "gpll0";
> +};
> +
>  &mss_pil {
>  	firmware-name = "qcom/msm8996/scorpio/mba.mbn",
>  			"qcom/msm8996/scorpio/modem.mbn";
> -- 
> 2.38.1
> 
