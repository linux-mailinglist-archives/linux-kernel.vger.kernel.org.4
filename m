Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D0665282
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAKDxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAKDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:53:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AAFD1B;
        Tue, 10 Jan 2023 19:53:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B710B81AD0;
        Wed, 11 Jan 2023 03:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF6DC433EF;
        Wed, 11 Jan 2023 03:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673409181;
        bh=T7FhHoEa7nYm7x1Iy7W8NajyWkx8N093eEfZQPjIfQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSy9Lwdyep2M9NF/8P9BVApfKuhCD5kCzCiGjdegEGSc3p08rW8hVE3mYFz1jKPDp
         ZY62hT3Adbm2QVX/EO+f8P/o5oJd4VGagxgAvqDcG4EnvRDMyzxxWxVwzKFhdnngKo
         BnRDH2Py29eOZQSucFEXuxCJvcLJiJt6rlnn3srQRZ/c1Yt0Zzm5sI73H0IXW63P3J
         1cMCdZVvQiiBRrykBSmb484kxmYL2qulco+ZZeSDjfRe4+xECAhhcFGKvpYHVR/gBl
         dXEe+7KerZmFVxXqu0pcdmfaLADkiW+nw8uu6Z0/otFYp8si2Ir7UE5gY/WicBn2Kv
         GlLYBCQ/JF5Fw==
Date:   Tue, 10 Jan 2023 21:52:59 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: sc8280xp: Define some of the
 display blocks
Message-ID: <20230111035259.tumavuzrgsoi5u7h@builder.lan>
References: <20230110145751.2654795-1-quic_bjorande@quicinc.com>
 <20230110145751.2654795-2-quic_bjorande@quicinc.com>
 <6adb959a-1337-f0a7-49e7-bae499ebbbc7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6adb959a-1337-f0a7-49e7-bae499ebbbc7@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:04:18PM +0100, Konrad Dybcio wrote:
> On 10.01.2023 15:57, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Define the display clock controllers, the MDSS instances, the DP phys
> > and connect these together.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > 
> > Changes since v5:
> > - Moved displayport controllers to MMCX
> > - Dropped required-opps = <nom> leftover in dispcc nodes
> > - Moved status property last
> > 
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 836 +++++++++++++++++++++++++
> >  1 file changed, 836 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 0ea2f19d471b..2f42814f23ab 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -4,6 +4,7 @@
> >   * Copyright (c) 2022, Linaro Limited
> >   */
> >  
> > +#include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
> >  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> >  #include <dt-bindings/interconnect/qcom,osm-l3.h>
> > @@ -2097,6 +2098,44 @@ usb_1_qmpphy: phy@8903000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		mdss1_dp0_phy: phy@8909a00 {
> Hm, on sc7280 these are children of mdss..
> 

The DP controller is part of the MDSS block, but the PHY is not. So this
representation matches the documentation.

> > +			compatible = "qcom,sc8280xp-dp-phy";
> > +			reg = <0 0x08909a00 0 0x19c>,
> We settled on 0x0 for zeroes in reg.
> 

That's okay with me, but I don't want to have a mix of them in the same
file. I also dislike the idea of seeing a patch fixing the 1400
occurrences we seem to have currently.

> 
> > +			      <0 0x08909200 0 0xec>,
> > +			      <0 0x08909600 0 0xec>,
> > +			      <0 0x08909000 0 0x1c8>;
> > +
> > +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> > +			clock-names = "aux", "cfg_ahb";
> > +
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		mdss1_dp1_phy: phy@890ca00 {
> > +			compatible = "qcom,sc8280xp-dp-phy";
> > +			reg = <0 0x0890ca00 0 0x19c>,
> > +			      <0 0x0890c200 0 0xec>,
> > +			      <0 0x0890c600 0 0xec>,
> > +			      <0 0x0890c000 0 0x1c8>;
> > +
> > +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
> > +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> > +			clock-names = "aux", "cfg_ahb";
> > +
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> >  		pmu@9091000 {
> >  			compatible = "qcom,sc8280xp-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
> >  			reg = <0 0x9091000 0 0x1000>;
> > @@ -2303,6 +2342,325 @@ usb_1_dwc3: usb@a800000 {
> >  			};
> >  		};
> >  
> > +		mdss0: display-subsystem@ae00000 {
> > +			compatible = "qcom,sc8280xp-mdss";
> > +			reg = <0 0x0ae00000 0 0x1000>;
> > +			reg-names = "mdss";
> > +
> > +			power-domains = <&dispcc0 MDSS_GDSC>;
> > +
> > +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> > +				 <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
> > +			clock-names = "iface",
> > +				      "ahb",
> > +				      "core";
> > +
> > +			resets = <&dispcc0 DISP_CC_MDSS_CORE_BCR>;
> > +
> > +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +
> > +			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
> > +			interconnect-names = "mdp0-mem", "mdp1-mem";
> > +
> Please do
> interrupt*
> 
> clock*
> 
> reset*
> 
> power-domain*
> 
> interconnect

This order doesn't make any sense to me.

I like the prospect of keeping the dts neat and tidy, but if you expect
to enforce this someone will have to implement tooling.

And this needs to be documented, in the tree!

> > +			iommus = <&apps_smmu 0x1000 0x402>;
> > +
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +
> > +			status = "disabled";
> > +
> > +			mdss0_mdp: display-controller@ae01000 {
> > +				compatible = "qcom,sc8280xp-dpu";
> > +				reg = <0 0x0ae01000 0 0x8f000>,
> > +				      <0 0x0aeb0000 0 0x2008>;
> > +				reg-names = "mdp", "vbif";
> > +
> > +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> > +					 <&gcc GCC_DISP_SF_AXI_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_MDP_LUT_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
> > +				clock-names = "bus",
> > +					      "nrt_bus",
> > +					      "iface",
> > +					      "lut",
> > +					      "core",
> > +					      "vsync";
> > +
> > +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
> > +						  <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
> > +				assigned-clock-rates = <460000000>,
> > +						       <19200000>;
> Not sure if assigning MDP is necessary
> 

I think you're right, the "core" clock is adjusted based on the
opp-table anyways.

> > +
> > +				operating-points-v2 = <&mdss0_mdp_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				interrupt-parent = <&mdss0>;
> > +				interrupts = <0>;
> Similarly here
> 
> 
> and similar comments for the rest of the nodes
> (and wow that's a lot)

Thanks,
Bjorn

> 
> Konrad
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@5 {
> > +						reg = <5>;
> > +						mdss0_intf5_out: endpoint {
> > +							remote-endpoint = <&mdss0_dp3_in>;
> > +						};
> > +					};
> > +
> > +					port@6 {
> > +						reg = <6>;
> > +						mdss0_intf6_out: endpoint {
> > +							remote-endpoint = <&mdss0_dp2_in>;
> > +						};
> > +					};
> > +				};
> > +
> > +				mdss0_mdp_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-200000000 {
> > +						opp-hz = /bits/ 64 <200000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-300000000 {
> > +						opp-hz = /bits/ 64 <300000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-375000000 {
> > +						opp-hz = /bits/ 64 <375000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-500000000 {
> > +						opp-hz = /bits/ 64 <500000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +					opp-600000000 {
> > +						opp-hz = /bits/ 64 <600000000>;
> > +						required-opps = <&rpmhpd_opp_turbo_l1>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss0_dp2: displayport-controller@ae9a000 {
> > +				compatible = "qcom,sc8280xp-dp";
> > +				reg = <0 0xae9a000 0 0x200>,
> > +				      <0 0xae9a200 0 0x200>,
> > +				      <0 0xae9a400 0 0x600>,
> > +				      <0 0xae9b000 0 0x400>;
> > +				interrupt-parent = <&mdss0>;
> > +				interrupts = <14>;
> > +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
> > +				clock-names = "core_iface", "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface", "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
> > +						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss0_dp2_phy 0>, <&mdss0_dp2_phy 1>;
> > +
> > +				phys = <&mdss0_dp2_phy>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&mdss0_dp2_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss0_dp2_in: endpoint {
> > +							remote-endpoint = <&mdss0_intf6_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +					};
> > +				};
> > +
> > +				mdss0_dp2_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-160000000 {
> > +						opp-hz = /bits/ 64 <160000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss0_dp3: displayport-controller@aea0000 {
> > +				compatible = "qcom,sc8280xp-dp";
> > +				reg = <0 0xaea0000 0 0x200>,
> > +				      <0 0xaea0200 0 0x200>,
> > +				      <0 0xaea0400 0 0x600>,
> > +				      <0 0xaea1000 0 0x400>;
> > +				interrupt-parent = <&mdss0>;
> > +				interrupts = <15>;
> > +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
> > +					 <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
> > +				clock-names = "core_iface", "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface", "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
> > +						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss0_dp3_phy 0>, <&mdss0_dp3_phy 1>;
> > +
> > +				phys = <&mdss0_dp3_phy>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&mdss0_dp3_opp_table>;
> > +				power-domains = <&dispcc0 MDSS_GDSC>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss0_dp3_in: endpoint {
> > +							remote-endpoint = <&mdss0_intf5_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +					};
> > +				};
> > +
> > +				mdss0_dp3_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-160000000 {
> > +						opp-hz = /bits/ 64 <160000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +
> > +		mdss0_dp2_phy: phy@aec2a00 {
> > +			compatible = "qcom,sc8280xp-dp-phy";
> > +			reg = <0 0x0aec2a00 0 0x19c>,
> > +			      <0 0x0aec2200 0 0xec>,
> > +			      <0 0x0aec2600 0 0xec>,
> > +			      <0 0x0aec2000 0 0x1c8>;
> > +
> > +			clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> > +				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
> > +			clock-names = "aux", "cfg_ahb";
> > +
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		mdss0_dp3_phy: phy@aec5a00 {
> > +			compatible = "qcom,sc8280xp-dp-phy";
> > +			reg = <0 0x0aec5a00 0 0x19c>,
> > +			      <0 0x0aec5200 0 0xec>,
> > +			      <0 0x0aec5600 0 0xec>,
> > +			      <0 0x0aec5000 0 0x1c8>;
> > +
> > +			clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> > +				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
> > +			clock-names = "aux", "cfg_ahb";
> > +
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		dispcc0: clock-controller@af00000 {
> > +			compatible = "qcom,sc8280xp-dispcc0";
> > +			reg = <0 0x0af00000 0 0x20000>;
> > +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&sleep_clk>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <&mdss0_dp2_phy 0>,
> > +				 <&mdss0_dp2_phy 1>,
> > +				 <&mdss0_dp3_phy 0>,
> > +				 <&mdss0_dp3_phy 1>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>;
> > +			power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +			#power-domain-cells = <1>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> >  		pdc: interrupt-controller@b220000 {
> >  			compatible = "qcom,sc8280xp-pdc", "qcom,pdc";
> >  			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
> > @@ -2925,6 +3283,484 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
> >  				qcom,remote-pid = <12>;
> >  			};
> >  		};
> > +
> > +		mdss1: display-subsystem@22000000 {
> > +			compatible = "qcom,sc8280xp-mdss";
> > +			reg = <0 0x22000000 0 0x1000>;
> > +			reg-names = "mdss";
> > +
> > +			power-domains = <&dispcc1 MDSS_GDSC>;
> > +
> > +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> > +				 <&dispcc1 DISP_CC_MDSS_MDP_CLK>;
> > +			clock-names = "iface",
> > +				      "ahb",
> > +				      "core";
> > +
> > +			resets = <&dispcc1 DISP_CC_MDSS_CORE_BCR>;
> > +
> > +			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +
> > +			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&mmss_noc MASTER_MDP_CORE1_1 0 &mc_virt SLAVE_EBI1 0>;
> > +			interconnect-names = "mdp0-mem", "mdp1-mem";
> > +
> > +			iommus = <&apps_smmu 0x1800 0x402>;
> > +
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +
> > +			status = "disabled";
> > +
> > +			mdss1_mdp: display-controller@22001000 {
> > +				compatible = "qcom,sc8280xp-dpu";
> > +				reg = <0 0x22001000 0 0x8f000>,
> > +				      <0 0x220b0000 0 0x2008>;
> > +				reg-names = "mdp", "vbif";
> > +
> > +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> > +					 <&gcc GCC_DISP_SF_AXI_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_MDP_LUT_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_MDP_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
> > +				clock-names = "bus",
> > +					      "nrt_bus",
> > +					      "iface",
> > +					      "lut",
> > +					      "core",
> > +					      "vsync";
> > +
> > +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_MDP_CLK>,
> > +						  <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
> > +				assigned-clock-rates = <460000000>,
> > +						       <19200000>;
> > +
> > +				operating-points-v2 = <&mdss1_mdp_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				interrupt-parent = <&mdss1>;
> > +				interrupts = <0>;
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss1_intf0_out: endpoint {
> > +							remote-endpoint = <&mdss1_dp0_in>;
> > +						};
> > +					};
> > +
> > +					port@4 {
> > +						reg = <4>;
> > +						mdss1_intf4_out: endpoint {
> > +							remote-endpoint = <&mdss1_dp1_in>;
> > +						};
> > +					};
> > +
> > +					port@5 {
> > +						reg = <5>;
> > +						mdss1_intf5_out: endpoint {
> > +							remote-endpoint = <&mdss1_dp3_in>;
> > +						};
> > +					};
> > +
> > +					port@6 {
> > +						reg = <6>;
> > +						mdss1_intf6_out: endpoint {
> > +							remote-endpoint = <&mdss1_dp2_in>;
> > +						};
> > +					};
> > +				};
> > +
> > +				mdss1_mdp_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-200000000 {
> > +						opp-hz = /bits/ 64 <200000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-300000000 {
> > +						opp-hz = /bits/ 64 <300000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-375000000 {
> > +						opp-hz = /bits/ 64 <375000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-500000000 {
> > +						opp-hz = /bits/ 64 <500000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +					opp-600000000 {
> > +						opp-hz = /bits/ 64 <600000000>;
> > +						required-opps = <&rpmhpd_opp_turbo_l1>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss1_dp0: displayport-controller@22090000 {
> > +				compatible = "qcom,sc8280xp-dp";
> > +				reg = <0 0x22090000 0 0x200>,
> > +				      <0 0x22090200 0 0x200>,
> > +				      <0 0x22090400 0 0x600>,
> > +				      <0 0x22091000 0 0x400>;
> > +				interrupt-parent = <&mdss1>;
> > +				interrupts = <12>;
> > +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> > +				clock-names = "core_iface", "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface", "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> > +						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>;
> > +
> > +				phys = <&mdss1_dp0_phy>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&mdss1_dp0_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss1_dp0_in: endpoint {
> > +							remote-endpoint = <&mdss1_intf0_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +					};
> > +				};
> > +
> > +				mdss1_dp0_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-160000000 {
> > +						opp-hz = /bits/ 64 <160000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +
> > +			};
> > +
> > +			mdss1_dp1: displayport-controller@22098000 {
> > +				compatible = "qcom,sc8280xp-dp";
> > +				reg = <0 0x22098000 0 0x200>,
> > +				      <0 0x22098200 0 0x200>,
> > +				      <0 0x22098400 0 0x600>,
> > +				      <0 0x22099000 0 0x400>;
> > +				interrupt-parent = <&mdss1>;
> > +				interrupts = <13>;
> > +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
> > +				clock-names = "core_iface", "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface", "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
> > +						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>;
> > +
> > +				phys = <&mdss1_dp1_phy>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&mdss1_dp1_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss1_dp1_in: endpoint {
> > +							remote-endpoint = <&mdss1_intf4_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +					};
> > +				};
> > +
> > +				mdss1_dp1_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-160000000 {
> > +						opp-hz = /bits/ 64 <160000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss1_dp2: displayport-controller@2209a000 {
> > +				compatible = "qcom,sc8280xp-dp";
> > +				reg = <0 0x2209a000 0 0x200>,
> > +				      <0 0x2209a200 0 0x200>,
> > +				      <0 0x2209a400 0 0x600>,
> > +				      <0 0x2209b000 0 0x400>;
> > +				interrupt-parent = <&mdss1>;
> > +				interrupts = <14>;
> > +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
> > +				clock-names = "core_iface", "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface", "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
> > +						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss1_dp2_phy 0>, <&mdss1_dp2_phy 1>;
> > +
> > +				phys = <&mdss1_dp2_phy>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&mdss1_dp2_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss1_dp2_in: endpoint {
> > +							remote-endpoint = <&mdss1_intf6_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +					};
> > +				};
> > +
> > +				mdss1_dp2_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-160000000 {
> > +						opp-hz = /bits/ 64 <160000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss1_dp3: displayport-controller@220a0000 {
> > +				compatible = "qcom,sc8280xp-dp";
> > +				reg = <0 0x220a0000 0 0x200>,
> > +				      <0 0x220a0200 0 0x200>,
> > +				      <0 0x220a0400 0 0x600>,
> > +				      <0 0x220a1000 0 0x400>;
> > +				interrupt-parent = <&mdss1>;
> > +				interrupts = <15>;
> > +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
> > +					 <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
> > +				clock-names = "core_iface", "core_aux",
> > +					      "ctrl_link",
> > +					      "ctrl_link_iface", "stream_pixel";
> > +
> > +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
> > +						  <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss1_dp3_phy 0>, <&mdss1_dp3_phy 1>;
> > +
> > +				phys = <&mdss1_dp3_phy>;
> > +				phy-names = "dp";
> > +
> > +				#sound-dai-cells = <0>;
> > +
> > +				operating-points-v2 = <&mdss1_dp3_opp_table>;
> > +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +
> > +				status = "disabled";
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss1_dp3_in: endpoint {
> > +							remote-endpoint = <&mdss1_intf5_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +					};
> > +				};
> > +
> > +				mdss1_dp3_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-160000000 {
> > +						opp-hz = /bits/ 64 <160000000>;
> > +						required-opps = <&rpmhpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-270000000 {
> > +						opp-hz = /bits/ 64 <270000000>;
> > +						required-opps = <&rpmhpd_opp_svs>;
> > +					};
> > +
> > +					opp-540000000 {
> > +						opp-hz = /bits/ 64 <540000000>;
> > +						required-opps = <&rpmhpd_opp_svs_l1>;
> > +					};
> > +
> > +					opp-810000000 {
> > +						opp-hz = /bits/ 64 <810000000>;
> > +						required-opps = <&rpmhpd_opp_nom>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +
> > +		mdss1_dp2_phy: phy@220c2a00 {
> > +			compatible = "qcom,sc8280xp-dp-phy";
> > +			reg = <0 0x220c2a00 0 0x19c>,
> > +			      <0 0x220c2200 0 0xec>,
> > +			      <0 0x220c2600 0 0xec>,
> > +			      <0 0x220c2000 0 0x1c8>;
> > +
> > +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> > +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> > +			clock-names = "aux", "cfg_ahb";
> > +
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		mdss1_dp3_phy: phy@220c5a00 {
> > +			compatible = "qcom,sc8280xp-dp-phy";
> > +			reg = <0 0x220c5a00 0 0x19c>,
> > +			      <0 0x220c5200 0 0xec>,
> > +			      <0 0x220c5600 0 0xec>,
> > +			      <0 0x220c5000 0 0x1c8>;
> > +
> > +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> > +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> > +			clock-names = "aux", "cfg_ahb";
> > +
> > +			power-domains = <&rpmhpd SC8280XP_MX>;
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		dispcc1: clock-controller@22100000 {
> > +			compatible = "qcom,sc8280xp-dispcc1";
> > +			reg = <0 0x22100000 0 0x20000>;
> > +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <0>,
> > +				 <&mdss1_dp0_phy 0>,
> > +				 <&mdss1_dp0_phy 1>,
> > +				 <&mdss1_dp1_phy 0>,
> > +				 <&mdss1_dp1_phy 1>,
> > +				 <&mdss1_dp2_phy 0>,
> > +				 <&mdss1_dp2_phy 1>,
> > +				 <&mdss1_dp3_phy 0>,
> > +				 <&mdss1_dp3_phy 1>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>,
> > +				 <0>;
> > +			power-domains = <&rpmhpd SC8280XP_MMCX>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +			#power-domain-cells = <1>;
> > +
> > +			status = "disabled";
> > +		};
> >  	};
> >  
> >  	sound: sound {
