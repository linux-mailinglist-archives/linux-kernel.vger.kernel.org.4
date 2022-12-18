Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423CF64FE91
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLRLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiLRLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:10:49 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44AF8;
        Sun, 18 Dec 2022 03:10:47 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D707D3EF28;
        Sun, 18 Dec 2022 12:10:43 +0100 (CET)
Date:   Sun, 18 Dec 2022 12:10:37 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: sm6125: Add apps_smmu with
 streamID to SDHCI 1/2 nodes
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Message-Id: <P133NR.LVIGH61OCZ6C2@somainline.org>
In-Reply-To: <20221216215819.1164973-4-marijn.suijten@somainline.org>
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
        <20221216215819.1164973-4-marijn.suijten@somainline.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Dec 16 2022 at 10:58:18 PM +01:00:00, Marijn Suijten 
<marijn.suijten@somainline.org> wrote:
> When enabling the APPS SMMU the mainline driver reconfigures the SMMU
> from its bootloader configuration, loosing the stream mapping for 
> (among
> which) the SDHCI hardware and breaking its ADMA feature.  This feature
> can be disabled with:
> 
>     sdhci.debug_quirks=0x40
> 
> But it is of course desired to have this feature enabled and working
> through the SMMU.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi 
> b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 347665c2067c..f560499cc0ca 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -468,6 +468,7 @@ sdhc_1: mmc@4744000 {
>  				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&xo_board>;
>  			clock-names = "iface", "core", "xo";
> +			iommus = <&apps_smmu 0x160 0>;
> 
>  			power-domains = <&rpmpd SM6125_VDDCX>;
> 
> @@ -494,6 +495,7 @@ sdhc_2: mmc@4784000 {
>  				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&xo_board>;
>  			clock-names = "iface", "core", "xo";
> +			iommus = <&apps_smmu 0x180 0>;
> 
>  			pinctrl-0 = <&sdc2_on_state>;
>  			pinctrl-1 = <&sdc2_off_state>;
> --
> 2.39.0
> 
With 0x0 as mask

Reviewed-by: Martin Botka <martin.botka@somainline.org>

-Martin


