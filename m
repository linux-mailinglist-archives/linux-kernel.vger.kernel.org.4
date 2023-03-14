Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127AD6B91C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCNLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjCNLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:36:39 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2867033
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:36:35 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 576FF201E6;
        Tue, 14 Mar 2023 12:36:33 +0100 (CET)
Date:   Tue, 14 Mar 2023 12:36:31 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Move SDHC node(s)'s
 'pinctrl' properties to dts
Message-ID: <20230314113631.l6zimax4zhn5qvky@SoMainline.org>
References: <20230314074001.1873781-1-bhupesh.sharma@linaro.org>
 <426ca0fd-5119-7e3c-89ce-27590b11f63f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426ca0fd-5119-7e3c-89ce-27590b11f63f@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 11:09:41, Konrad Dybcio wrote:
> 
> 
> On 14.03.2023 08:40, Bhupesh Sharma wrote:
> > Normally the 'pinctrl' properties of a SDHC controller and the
> > chip detect pin settings are dependent on the type of the slots
> > (for e.g uSD card slot), regulators and GPIO(s) available on the
> > board(s).
> > 
> > So, move the same from the sm6115 dtsi file to the respective
> > board file(s).
> So, file or files? :D
> 
> > 
> > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Not sure if I still stand by this...

> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> > Changes since v1:
> > - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20221220113616.1556097-1-bhupesh.sharma@linaro.org/
> > - Colleted the R-B from Marijn.
> > - Rebased on linux-next/master
> > 
> >  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 10 +++++++++
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 22 -------------------
> >  2 files changed, 10 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > index a3f1c7c41fd73..329eb496bbc5f 100644
> > --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> > @@ -202,12 +202,22 @@ &sdhc_2 {
> >  	vqmmc-supply = <&vreg_l5a>;
> >  
> >  	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
> > +	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
> This should have been
> 
> pinctrl-n
> pinctrl-names
> 
> I made a mistake in my lenovo dts if that was your reference..
> 
> You should also mention that the implicit removal of sdhci1's
> gpio properties from the lenovo j606f and oneplus billie2 is intentional
> as they both use UFS instead of eMMC.

IMO we should keep the default sdc1_on/off_state in sdhci1 and sdhci2.
That node is disabled anyway.  Only removable sdhci's need the pinctrl
extended with the CD pin (and whether that's done with a new pinctrl
node, or by adding the pin to &sdcX_on/off_state varies per SoC).  I
mentioned this in:

https://lore.kernel.org/linux-arm-msm/48607619-3a7b-a9d7-1e6a-c24f52539671@linaro.org/

But no-one gave their opinion.

In other words: it seems odd to define the sdcX_on/off_state in SoC DTS,
but then always require the board DTS to wire it up to the specific
sdhc_X node (when that is only needed when extending pinctrl-X with an
extra CD state).

> And one more thing, you missed bringing the CD pin back into pinctrl-0/1
> in the tab dts. I'd really appreciate if you could fix up that ordering
> mess I mentioned above while at it.
> 
> Konrad
> >  
> >  	status = "okay";
> >  };
> >  
> >  &tlmm {
> >  	gpio-reserved-ranges = <14 4>;
> > +
> > +	sdc2_card_det_n: sd-card-det-n-state {
> > +		pins = "gpio88";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-pull-up;
> > +	};
> >  };
> >  
> >  &ufs_mem_hc {
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index fbd67d2c8d781..e8e5f2cafebb9 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -595,13 +595,6 @@ data-pins {
> >  					bias-pull-up;
> >  					drive-strength = <10>;
> >  				};
> > -
> > -				sd-cd-pins {
> > -					pins = "gpio88";
> > -					function = "gpio";
> > -					bias-pull-up;
> > -					drive-strength = <2>;
> > -				};
> >  			};
> >  
> >  			sdc2_state_off: sdc2-off-state {
> > @@ -622,13 +615,6 @@ data-pins {
> >  					bias-pull-up;
> >  					drive-strength = <2>;
> >  				};
> > -
> > -				sd-cd-pins {
> > -					pins = "gpio88";
> > -					function = "gpio";
> > -					bias-disable;
> > -					drive-strength = <2>;
> > -				};
> >  			};
> >  		};
> >  
> > @@ -731,10 +717,6 @@ sdhc_1: mmc@4744000 {
> >  				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
> >  			clock-names = "iface", "core", "xo", "ice";
> >  
> > -			pinctrl-0 = <&sdc1_state_on>;
> > -			pinctrl-1 = <&sdc1_state_off>;
> > -			pinctrl-names = "default", "sleep";
> > -

In other words, IMO this should stay:
- if it is not used for a removable card, this is adequate
  (only boards with a removable card on sdhc1 would have to update these
  properties or the referenced pinctrl state with CD pin);
- the node is disabled by default anyway.

> >  			bus-width = <8>;
> >  			status = "disabled";
> >  		};
> > @@ -753,10 +735,6 @@ sdhc_2: mmc@4784000 {
> >  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> >  			clock-names = "iface", "core", "xo";
> >  
> > -			pinctrl-0 = <&sdc2_state_on>;
> > -			pinctrl-1 = <&sdc2_state_off>;
> > -			pinctrl-names = "default", "sleep";
> > -

And we could keep this for exactly the same reason.

- Marijn

> >  			power-domains = <&rpmpd SM6115_VDDCX>;
> >  			operating-points-v2 = <&sdhc2_opp_table>;
> >  			iommus = <&apps_smmu 0x00a0 0x0>;
