Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CC620163
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiKGVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiKGVmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:42:36 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82659286F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:42:33 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 23BE720177;
        Mon,  7 Nov 2022 22:42:30 +0100 (CET)
Date:   Mon, 7 Nov 2022 22:42:28 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] arm64: dts: qcom: sm6125: fix SDHCI CQE reg names
Message-ID: <20221107214228.d6a635d3jrsfkyc2@SoMainline.org>
References: <20221026163646.37433-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026163646.37433-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-26 12:36:46, Krzysztof Kozlowski wrote:
> SM6125 comes with SDCC (SDHCI controller) v5, so the second range of
> registers is cqhci, not core.
> 
> Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not tested on hardware, but no practical impact is expected, because
> supports-cqe is not defined.

Thanks for this!  According to my downstream sources this reg is called
cmdq_mem, that's not core indeed.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # Sony Xperia 10 II

And also according to my downstream sources, this SoC should support it.
When adding supports-cqe _together with your patch_:

    [    0.391950] sdhci_msm 4744000.mmc: mmc0: CQE init: success

I'll send a followup to that effect.  Thanks again for bringing this to
my attention!

- Marijn

> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index af49a748e511..24ee7c0c1195 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -458,7 +458,7 @@ rpm_msg_ram: sram@45f0000 {
>  		sdhc_1: mmc@4744000 {
>  			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
> -			reg-names = "hc", "core";
> +			reg-names = "hc", "cqhci";
>  
>  			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.34.1
> 
