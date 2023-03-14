Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA26B8694
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCNAHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCNAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9E8F536;
        Mon, 13 Mar 2023 17:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE4B6156E;
        Tue, 14 Mar 2023 00:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F64CC433EF;
        Tue, 14 Mar 2023 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678752449;
        bh=h/UVjlSeJJlCHc13eSCIs+dPLaiOpX+QcoENoNGRfQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU4X/iO6jwlcMlsudZJq2upVoVNhUDMH6y/xF+NrCX51oL6aTdP2oWXbDhdWeXx7D
         8+fiCjBYPsmbickq/mjxEHsajJMpbm7hD/C40wk1FKyPr1NSELmd3eHpnY3uVRI3NP
         tEEg/ZuVQTI4KtCM/rYTfalQoxg4WLhhGjQJEb8jPPHczskJ1ZFXDn9pfD4xTrFe73
         NAEo77WIH0Jcdu+IkAJAlHr4YyETwSAp42C3irTdzCN/mK0e6xNkiS8LgVBXf/gc2F
         c3GQhh1O51nlmulQxTYgi47KRK6RuZJafZHkIC5LSrl23l3kQMkOCsvT6jzVdByN4L
         KCb1sNSn5SgGw==
Date:   Mon, 13 Mar 2023 17:10:52 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Split out SA8155P and use correct
 RPMh power domains
Message-ID: <20230314001052.7qvgbwkl73x22oll@ripper>
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
 <20230214095435.2192153-3-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214095435.2192153-3-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:54:35AM +0100, Konrad Dybcio wrote:
> The RPMhPD setup on SA8155P is different compared to SM8150. Correct
> it to ensure the platform will not try accessing forbidden/missing
> RPMh entries at boot, as a bad vote will hang the machine.
> 

I don't see that this will scale, as soon as someone adds a new device
in sm8150.dtsi that has the need to scale a power rail this will be
forgotten and we will have a mix of references to the SM8150 and SA8155P
value space.

That said, I think it's reasonable to avoid duplicating the entire
sm8150.dtsi.

How about making the SA8155P_* macros match the SM8150_* macros?
That way things will fail gracefully if a device node references a
resource not defined for either platform...

Regards,
Bjorn

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  2 +-
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi    | 51 ++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8155p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 459384ec8f23..9454e8e4e517 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -7,7 +7,7 @@
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include "sm8150.dtsi"
> +#include "sa8155p.dtsi"
>  #include "pmm8155au_1.dtsi"
>  #include "pmm8155au_2.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> new file mode 100644
> index 000000000000..f2fd7c28764e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + *
> + * SA8155P is an automotive variant of SM8150, with some minor changes.
> + * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone.
> + */
> +
> +#include "sm8150.dtsi"
> +
> +&dispcc {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> +
> +&mdss_mdp {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> +
> +&mdss_dsi0 {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> +
> +&mdss_dsi1 {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> +
> +&remoteproc_adsp {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> +
> +&remoteproc_cdsp {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> +
> +&remoteproc_mpss {
> +	power-domains = <&rpmhpd SA8155P_CX>,
> +			<&rpmhpd SA8155P_MSS>;
> +};
> +
> +&remoteproc_slpi {
> +	power-domains = <&rpmhpd SA8155P_CX>,
> +			<&rpmhpd SA8155P_MX>;
> +};
> +
> +&rpmhpd {
> +	compatible = "qcom,sa8155p-rpmhpd";
> +};
> +
> +&sdhc_2 {
> +	power-domains = <&rpmhpd SA8155P_CX>;
> +};
> -- 
> 2.39.1
> 
