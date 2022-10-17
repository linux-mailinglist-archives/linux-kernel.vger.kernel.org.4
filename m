Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27660193A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJQUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJQURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:17:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF84317A88;
        Mon, 17 Oct 2022 13:17:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58BEB113E;
        Mon, 17 Oct 2022 13:17:10 -0700 (PDT)
Received: from bogus (unknown [10.57.36.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CF8F3F67D;
        Mon, 17 Oct 2022 13:17:00 -0700 (PDT)
Date:   Mon, 17 Oct 2022 21:16:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sm8250: Add cpuidle states"
Message-ID: <20221017201654.u7x5vrjsad653kma@bogus>
References: <20221017164005.2622934-1-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017164005.2622934-1-amit.pundir@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:10:05PM +0530, Amit Pundir wrote:
> This reverts commit 32bc936d732171d48c9c8f96c4fa25ac3ed7e1c7.
> 
> This patch was part of a patch series to add APSS RSC to
> Cluster power domain
> https://patchwork.kernel.org/project/linux-pm/cover/1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com/
> but the rest of the patches in this series got NACKed and didn't land.
> 
> These cpuidle states made RB5 (sm8250) highly unstable and I run into
> following crash every now and then:
> 
> [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> 
> I reported this breakage earlier this year as well:
> https://lore.kernel.org/all/CAMi1Hd2Sngya_2m2odkjq4fdV8OiiXsFMEX1bb807cWMC7H-sg@mail.gmail.com/
> I can confirm that if I cherry-pick the rest of the patches from the
> series then I can't reproduce this crash, but I'm not sure when the rest
> of the patches are going to land though.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 105 ---------------------------
>  1 file changed, 105 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a5b62cadb129..a2c15da1a450 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -101,8 +101,6 @@ CPU0: cpu@0 {
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
>  			next-level-cache = <&L2_0>;
> -			power-domains = <&CPU_PD0>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -125,8 +123,6 @@ CPU1: cpu@100 {
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
>  			next-level-cache = <&L2_100>;
> -			power-domains = <&CPU_PD1>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -146,8 +142,6 @@ CPU2: cpu@200 {
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
>  			next-level-cache = <&L2_200>;
> -			power-domains = <&CPU_PD2>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -167,8 +161,6 @@ CPU3: cpu@300 {
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
>  			next-level-cache = <&L2_300>;
> -			power-domains = <&CPU_PD3>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -188,8 +180,6 @@ CPU4: cpu@400 {
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <379>;
>  			next-level-cache = <&L2_400>;
> -			power-domains = <&CPU_PD4>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -209,8 +199,6 @@ CPU5: cpu@500 {
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <379>;
>  			next-level-cache = <&L2_500>;
> -			power-domains = <&CPU_PD5>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -231,8 +219,6 @@ CPU6: cpu@600 {
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <379>;
>  			next-level-cache = <&L2_600>;
> -			power-domains = <&CPU_PD6>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -252,8 +238,6 @@ CPU7: cpu@700 {
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <444>;
>  			next-level-cache = <&L2_700>;
> -			power-domains = <&CPU_PD7>;
> -			power-domain-names = "psci";
>  			qcom,freq-domain = <&cpufreq_hw 2>;
>  			operating-points-v2 = <&cpu7_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -300,42 +284,6 @@ core7 {
>  				};
>  			};
>  		};
> -
> -		idle-states {
> -			entry-method = "psci";
> -
> -			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> -				compatible = "arm,idle-state";
> -				idle-state-name = "silver-rail-power-collapse";
> -				arm,psci-suspend-param = <0x40000004>;
> -				entry-latency-us = <360>;
> -				exit-latency-us = <531>;
> -				min-residency-us = <3934>;
> -				local-timer-stop;

If this is temporary fix for some broke firmware or setup, I suggest to
just add status = "disabled" for these states. Also worth checking if keeping
the cpu states is okay and only cluster state is the issue or everything
needs to be disabled. That way it would avoid the churn when re-enabling it.

-- 
Regards,
Sudeep
