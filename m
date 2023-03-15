Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543906BC042
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjCOW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCOW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:57:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A53265AF;
        Wed, 15 Mar 2023 15:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37974B81F93;
        Wed, 15 Mar 2023 22:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F9C433D2;
        Wed, 15 Mar 2023 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678921023;
        bh=WYdSkFlklt/aLVMWRbk3cQYdrAgkrVG+2rIXXjj8NvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ManoxYmz3/Gmm0JnkEQCYIlLOtDkYeMMovTzwhQY8Q4RjqZ7T6Cc8Mr0AajlivAGM
         z5/X5Bm/PdgBC8AL5O/FTR9lWZlTYHCaGoSOmPznFIArdYxKu6sI/6inlODN9864M7
         x3HbOsa6FeeL8lOa8ZtYUcA/BzXcqirb6uH2xbj1V+tj/solavN0KGL8D4QAmIlx+i
         m2Ey2fok6dok0SmnL4ME3BKMl3seyJ/XJjUEy8v+nPGsNawuTBBwc8JBsFoTF/HvjI
         /cGGP5nUp0Yik/IIqMZXK1dEWNOnALq1wFXVBklHlC545mJFfDLIUFVfYP9ha4ETX6
         I++gd8hQi0vSg==
Date:   Wed, 15 Mar 2023 16:00:24 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Split out SA8155P and use correct
 RPMh power domains
Message-ID: <20230315230024.wxuqthay74i5zgrq@ripper>
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
 <20230214095435.2192153-3-konrad.dybcio@linaro.org>
 <20230314001052.7qvgbwkl73x22oll@ripper>
 <eaf2ca0d-4d90-b68b-3b36-8bb0148cfb95@linaro.org>
 <ee1ebac4-bf18-019a-f770-5cb88703d06b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1ebac4-bf18-019a-f770-5cb88703d06b@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:41:45PM +0100, Konrad Dybcio wrote:
> 
> 
> On 14.03.2023 12:36, Konrad Dybcio wrote:
> > 
> > 
> > On 14.03.2023 01:10, Bjorn Andersson wrote:
> >> On Tue, Feb 14, 2023 at 10:54:35AM +0100, Konrad Dybcio wrote:
> >>> The RPMhPD setup on SA8155P is different compared to SM8150. Correct
> >>> it to ensure the platform will not try accessing forbidden/missing
> >>> RPMh entries at boot, as a bad vote will hang the machine.
> >>>
> >>
> >> I don't see that this will scale, as soon as someone adds a new device
> >> in sm8150.dtsi that has the need to scale a power rail this will be
> >> forgotten and we will have a mix of references to the SM8150 and SA8155P
> >> value space.
> >>
> >> That said, I think it's reasonable to avoid duplicating the entire
> >> sm8150.dtsi.
> > Yeah, this problem has no obvious good solutions and even though it's
> > not very elegant, this seems to be the less bad one..
> > 
> >>
> >> How about making the SA8155P_* macros match the SM8150_* macros?
> >> That way things will fail gracefully if a device node references a
> >> resource not defined for either platform...
> > Okay, let's do that
> Re-thinking it, it's good that the indices don't match, as this way the
> board will (should) refuse to function properly if there's an oversight,
> which may have gone unnoticed if they were matching, so this only guards
> us against programmer error which is not great :/
> 

Right, ensuring that the resource indices never collides would be a good
way to capture this issue, as well as copy-paste errors etc. My
pragmatic proposal is that we make SA8155P_x == SM8150_x where a match
exist, and for the ones that doesn't match we pick numbers that doesn't
collide between the platforms.

The alternative is to start SA8155P_x at 11, but it's different and
forces sa8155p.dtsi to redefine every single power-domains property...


This does bring back the feeling that it was a mistake to include the
platform name in these defines in the first place... Not sure if it's
worth mixing generic defines into the picture at this point, given that
we I don't see a way to use them on any existing platform.

Regards,
Bjorn

> Konrad
> > 
> > Konrad
> >>
> >> Regards,
> >> Bjorn
> >>
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  2 +-
> >>>  arch/arm64/boot/dts/qcom/sa8155p.dtsi    | 51 ++++++++++++++++++++++++
> >>>  2 files changed, 52 insertions(+), 1 deletion(-)
> >>>  create mode 100644 arch/arm64/boot/dts/qcom/sa8155p.dtsi
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> >>> index 459384ec8f23..9454e8e4e517 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> >>> @@ -7,7 +7,7 @@
> >>>  
> >>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>>  #include <dt-bindings/gpio/gpio.h>
> >>> -#include "sm8150.dtsi"
> >>> +#include "sa8155p.dtsi"
> >>>  #include "pmm8155au_1.dtsi"
> >>>  #include "pmm8155au_2.dtsi"
> >>>  
> >>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> >>> new file mode 100644
> >>> index 000000000000..f2fd7c28764e
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> >>> @@ -0,0 +1,51 @@
> >>> +// SPDX-License-Identifier: BSD-3-Clause
> >>> +/*
> >>> + * Copyright (c) 2023, Linaro Limited
> >>> + *
> >>> + * SA8155P is an automotive variant of SM8150, with some minor changes.
> >>> + * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone.
> >>> + */
> >>> +
> >>> +#include "sm8150.dtsi"
> >>> +
> >>> +&dispcc {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> +
> >>> +&mdss_mdp {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> +
> >>> +&mdss_dsi0 {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> +
> >>> +&mdss_dsi1 {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> +
> >>> +&remoteproc_adsp {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> +
> >>> +&remoteproc_cdsp {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> +
> >>> +&remoteproc_mpss {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>,
> >>> +			<&rpmhpd SA8155P_MSS>;
> >>> +};
> >>> +
> >>> +&remoteproc_slpi {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>,
> >>> +			<&rpmhpd SA8155P_MX>;
> >>> +};
> >>> +
> >>> +&rpmhpd {
> >>> +	compatible = "qcom,sa8155p-rpmhpd";
> >>> +};
> >>> +
> >>> +&sdhc_2 {
> >>> +	power-domains = <&rpmhpd SA8155P_CX>;
> >>> +};
> >>> -- 
> >>> 2.39.1
> >>>
