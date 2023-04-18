Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6A6E6890
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjDRPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDRPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7EF7A94;
        Tue, 18 Apr 2023 08:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D51C363583;
        Tue, 18 Apr 2023 15:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97802C433EF;
        Tue, 18 Apr 2023 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681832894;
        bh=8rSVJs5ZB9AE77oAoJxRwS82EyBCbeTxrwWs3YiHucc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFOEuWZtCZ6KUlC3wHjj+dMTODaUBC6G40j4Js1xLYnaQMv8siGOJpTPYWWv3Nm1e
         HWy2A3349+AEojsr95dYvS7foFv/l5EnQzOlW87NHscWLyVNIsTyzRnZ3BivZ0uQnr
         lsoTeoXk9nRE5kAjhckK4ReYYIuhERdFC8vNsTcfbcqB9b1Xn/QSadhf1sXixnv6T7
         zYujWrCEQ1wC1Ej8JiMYa1f4U8kUP4xeqNM0NzMWCHzL40HG/o55RCkcHlkNn33tRg
         HEksAyndTTTMFhqd67kOV2HLgLjT3BgRf8ztE8GkeIwqfF2O6evA6yF/8k9bpureQ7
         /WVSfmBc5+n8g==
Date:   Tue, 18 Apr 2023 08:51:46 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Set up CPU cooling maps
Message-ID: <20230418155146.3qpin45woex5sbli@ripper>
References: <20230418-topic-cool_bengal-v1-1-c5d53814dc74@linaro.org>
 <20230418130223.wvsu3bsm62i2gtpp@ripper>
 <139ea923-968b-cee2-15e0-3fb8112e15d9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139ea923-968b-cee2-15e0-3fb8112e15d9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:01:47PM +0200, Konrad Dybcio wrote:
> 
> 
> On 18.04.2023 15:02, Bjorn Andersson wrote:
> > On Tue, Apr 18, 2023 at 01:56:56PM +0200, Konrad Dybcio wrote:
> >> Set up CPU cooling maps to ensure the thermal framework is aware of
> >> the connection between the CPUs and the TSENS sensors.
> >>
> >> All of the maps refer to all 4 CPUs within a given cluster at a time,
> >> as that's what can be considered the smallest DVFS target unit - they
> >> all share the same voltage line and clock source.
> >>
> > 
> > Generally software based CPU cooling is considered too slow to cope with
> > CPU core temperature changes, and the limits hardware working together
> > with OSM/EPSS will do a better job maintaining appropriate core
> > temperature levels.
> > 
> > Is there a reason why this can't be used/relied upon on this platform?
> I haven't set up LMH yet and the default limits, at least with my dubious
> meta build, seem to let the board go to 75degC with just 4 cores working..
> 
> Not sure if there's a voltage droop when I let it go full throttle or
> something, but pushing it to the limit definitely causes the board to be
> (even) less stable..
> 
> > 
> > 
> > PS. Amending this mechanism with software based cooling to keep the
> > system at a reasonable/lower temperature is a good idea.
> We don't like burned chips around here!
> 

Limits hardware will help you with that, software based cooling will
help avoid burning the user.

Regards,
Bjorn

> Konrad
> > 
> > Regards,
> > Bjorn
> > 
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 137 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 137 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> index 631ca327e064..36ff913c1a60 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >> @@ -12,6 +12,7 @@
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  #include <dt-bindings/power/qcom-rpmpd.h>
> >> +#include <dt-bindings/thermal/thermal.h>
> >>  
> >>  / {
> >>  	interrupt-parent = <&intc>;
> >> @@ -47,6 +48,8 @@ CPU0: cpu@0 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_0>;
> >>  			qcom,freq-domain = <&cpufreq_hw 0>;
> >> +			#cooling-cells = <2>;
> >> +
> >>  			L2_0: l2-cache {
> >>  				compatible = "cache";
> >>  				cache-level = <2>;
> >> @@ -63,6 +66,7 @@ CPU1: cpu@1 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_0>;
> >>  			qcom,freq-domain = <&cpufreq_hw 0>;
> >> +			#cooling-cells = <2>;
> >>  		};
> >>  
> >>  		CPU2: cpu@2 {
> >> @@ -75,6 +79,7 @@ CPU2: cpu@2 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_0>;
> >>  			qcom,freq-domain = <&cpufreq_hw 0>;
> >> +			#cooling-cells = <2>;
> >>  		};
> >>  
> >>  		CPU3: cpu@3 {
> >> @@ -87,6 +92,7 @@ CPU3: cpu@3 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_0>;
> >>  			qcom,freq-domain = <&cpufreq_hw 0>;
> >> +			#cooling-cells = <2>;
> >>  		};
> >>  
> >>  		CPU4: cpu@100 {
> >> @@ -99,6 +105,8 @@ CPU4: cpu@100 {
> >>  			dynamic-power-coefficient = <282>;
> >>  			next-level-cache = <&L2_1>;
> >>  			qcom,freq-domain = <&cpufreq_hw 1>;
> >> +			#cooling-cells = <2>;
> >> +
> >>  			L2_1: l2-cache {
> >>  				compatible = "cache";
> >>  				cache-level = <2>;
> >> @@ -115,6 +123,7 @@ CPU5: cpu@101 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_1>;
> >>  			qcom,freq-domain = <&cpufreq_hw 1>;
> >> +			#cooling-cells = <2>;
> >>  		};
> >>  
> >>  		CPU6: cpu@102 {
> >> @@ -127,6 +136,7 @@ CPU6: cpu@102 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_1>;
> >>  			qcom,freq-domain = <&cpufreq_hw 1>;
> >> +			#cooling-cells = <2>;
> >>  		};
> >>  
> >>  		CPU7: cpu@103 {
> >> @@ -139,6 +149,7 @@ CPU7: cpu@103 {
> >>  			enable-method = "psci";
> >>  			next-level-cache = <&L2_1>;
> >>  			qcom,freq-domain = <&cpufreq_hw 1>;
> >> +			#cooling-cells = <2>;
> >>  		};
> >>  
> >>  		cpu-map {
> >> @@ -2471,6 +2482,24 @@ cpu4-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 6>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu4_alert0>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu4_alert1>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu4_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >> @@ -2497,6 +2526,24 @@ cpu5-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 7>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu5_alert0>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu5_alert1>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu5_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >> @@ -2523,6 +2570,24 @@ cpu6-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 8>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu6_alert0>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu6_alert1>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu6_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >> @@ -2549,6 +2614,24 @@ cpu7-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 9>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu7_alert0>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu7_alert1>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu7_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >> @@ -2575,6 +2658,24 @@ cpu45-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 10>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu45_alert0>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu45_alert1>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu45_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >> @@ -2601,6 +2702,24 @@ cpu67-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 11>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu67_alert0>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu67_alert1>;
> >> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu67_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >> @@ -2627,6 +2746,24 @@ cpu0123-thermal {
> >>  			polling-delay = <0>;
> >>  			thermal-sensors = <&tsens0 12>;
> >>  
> >> +			cooling-maps {
> >> +				map0 {
> >> +					trip = <&cpu0123_alert0>;
> >> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +
> >> +				map1 {
> >> +					trip = <&cpu0123_alert1>;
> >> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +				};
> >> +			};
> >> +
> >>  			trips {
> >>  				cpu0123_alert0: trip-point0 {
> >>  					temperature = <90000>;
> >>
> >> ---
> >> base-commit: 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b
> >> change-id: 20230418-topic-cool_bengal-2f5f3f47269c
> >>
> >> Best regards,
> >> -- 
> >> Konrad Dybcio <konrad.dybcio@linaro.org>
> >>
