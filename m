Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A873D34F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjFYTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYTgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:36:54 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865EB197
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:36:52 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 00A623EECD;
        Sun, 25 Jun 2023 21:36:49 +0200 (CEST)
Date:   Sun, 25 Jun 2023 21:36:48 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 14/15] arm64: dts: qcom: sm6125: Add display hardware
 nodes
Message-ID: <m6lxgnupiymr4ffmds6lcpn2ya63bpdkmubfnoyccubapguvun@ryhmw7dogzxu>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-14-1d5a638cebf2@somainline.org>
 <d8f4e665-984a-5a36-3ffe-14e33d09f031@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f4e665-984a-5a36-3ffe-14e33d09f031@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-24 04:05:07, Konrad Dybcio wrote:
> On 24.06.2023 02:41, Marijn Suijten wrote:
> > Add the DT nodes that describe the MDSS hardware on SM6125, containing
> > one MDP (display controller) together with a single DSI and DSI PHY.  No
> > DisplayPort support is added for now.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6125.dtsi | 190 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 186 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > index 7d78b4e48ebe..6852dacf54e6 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > @@ -1204,16 +1204,198 @@ sram@4690000 {
> >  			reg = <0x04690000 0x10000>;
> >  		};
> >  
> > +		mdss: display-subsystem@5e00000 {
> > +			compatible = "qcom,sm6125-mdss";
> > +			reg = <0x05e00000 0x1000>;
> > +			reg-names = "mdss";
> > +
> > +			power-domains = <&dispcc MDSS_GDSC>;
> > +
> > +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> > +				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> > +			clock-names = "iface", "ahb", "core";
> One per line would be nice

Sure, it's all over the place elsewhere though.

> > +
> > +			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +
> > +			iommus = <&apps_smmu 0x400 0x0>;
> > +
> Every node has a different scramble of property orders :P
> 
> To roughly align with what I ask most people to do (and what I should
> work on codifying and automating ehhh) would be:

Exactly.  Until this automated - or even documented - there is barely
any point to manually deal with this.

> [compat]
> [reg]
> 
> [interrupt]

Also interrupt-cells here, since that's only related to
interrupt-controller; and not interrupts=<>;?

> 
> [clock]
> 
> [reset]
> (btw there should be a MDSS_CORE reset at DISP_CC+0x2000, try writing 1 there
> and see if MDSS dies)
> 
> [opp]
> [pd]
> 
> [iommus]
> [icc]
> 
> [phy]
> 
> [addresssizeranges]
> 
> [status]

Sure, have reordered them like this for v2.

> 
> > +			status = "disabled";
> > +
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +
> > +			mdss_mdp: display-controller@5e01000 {
> > +				compatible = "qcom,sm6125-dpu";
> > +				reg = <0x05e01000 0x83208>,
> > +				      <0x05eb0000 0x2008>;
> > +				reg-names = "mdp", "vbif";
> > +
> > +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_ROT_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> > +				clock-names = "bus",
> > +					      "iface",
> > +					      "rot",
> > +					      "lut",
> > +					      "core",
> > +					      "vsync";
> > +				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> > +				assigned-clock-rates = <19200000>;
> > +
> > +				operating-points-v2 = <&mdp_opp_table>;
> > +				power-domains = <&rpmpd SM6125_VDDCX>;
> > +
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <0>;
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						dpu_intf1_out: endpoint {
> > +							remote-endpoint = <&mdss_dsi0_in>;
> > +						};
> > +					};
> > +				};
> > +
> > +				mdp_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-192000000 {
> > +						opp-hz = /bits/ 64 <192000000>;
> > +						required-opps = <&rpmpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-256000000 {
> > +						opp-hz = /bits/ 64 <256000000>;
> > +						required-opps = <&rpmpd_opp_svs>;
> > +					};
> > +
> > +					opp-307200000 {
> > +						opp-hz = /bits/ 64 <307200000>;
> > +						required-opps = <&rpmpd_opp_svs_plus>;
> > +					};
> > +
> > +					opp-384000000 {
> > +						opp-hz = /bits/ 64 <384000000>;
> > +						required-opps = <&rpmpd_opp_nom>;
> > +					};
> > +
> > +					opp-400000000 {
> > +						opp-hz = /bits/ 64 <400000000>;
> > +						required-opps = <&rpmpd_opp_turbo>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss_dsi0: dsi@5e94000 {
> > +				compatible = "qcom,sm6125-dsi-ctrl", "qcom,mdss-dsi-ctrl";
> > +				reg = <0x05e94000 0x400>;
> > +				reg-names = "dsi_ctrl";
> > +
> > +				interrupt-parent = <&mdss>;
> > +				interrupts = <4>;
> > +
> > +				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
> > +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +					 <&gcc GCC_DISP_HF_AXI_CLK>;
> > +				clock-names = "byte",
> > +					      "byte_intf",
> > +					      "pixel",
> > +					      "core",
> > +					      "iface",
> > +					      "bus";
> > +
> > +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
> > +						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> > +				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> > +
> > +				operating-points-v2 = <&dsi_opp_table>;
> > +				power-domains = <&rpmpd SM6125_VDDMX>;
> CX

Downstream says MX (and only on the phy... but it is the dsi node that
defines the corresponding rpmpd opps).

Do you have a source to back this up?

> 
> > +
> > +				phys = <&mdss_dsi0_phy>;
> > +				phy-names = "dsi";
> > +
> > +				status = "disabled";
> > +
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				ports {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					port@0 {
> > +						reg = <0>;
> > +						mdss_dsi0_in: endpoint {
> > +							remote-endpoint = <&dpu_intf1_out>;
> > +						};
> > +					};
> > +
> > +					port@1 {
> > +						reg = <1>;
> > +						mdss_dsi0_out: endpoint {
> > +						};
> > +					};
> > +				};
> > +
> > +				dsi_opp_table: opp-table {
> > +					compatible = "operating-points-v2";
> > +
> > +					opp-164000000 {
> > +						opp-hz = /bits/ 64 <164000000>;
> > +						required-opps = <&rpmpd_opp_low_svs>;
> > +					};
> > +
> > +					opp-187500000 {
> > +						opp-hz = /bits/ 64 <187500000>;
> > +						required-opps = <&rpmpd_opp_svs>;
> > +					};
> > +				};
> > +			};
> > +
> > +			mdss_dsi0_phy: phy@5e94400 {
> > +				compatible = "qcom,dsi-phy-14nm-6125";
> > +				reg = <0x05e94400 0x100>,
> > +				      <0x05e94500 0x300>,
> > +				      <0x05e94800 0x188>;
> > +				reg-names = "dsi_phy",
> > +					    "dsi_phy_lane",
> > +					    "dsi_pll";
> > +
> > +				#clock-cells = <1>;
> > +				#phy-cells = <0>;
> > +
> > +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> > +				clock-names = "iface", "ref";
> > +
> > +				status = "disabled";
> > +			};
> > +		};
> > +
> >  		dispcc: clock-controller@5f00000 {
> >  			compatible = "qcom,sm6125-dispcc";
> >  			reg = <0x05f00000 0x20000>;
> >  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> > +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
> > +				 <&mdss_dsi0_phy 0>,
> > +				 <&mdss_dsi0_phy 1>,
> >  				 <0>,
> >  				 <0>,
> > -				 <0>,
> > -				 <0>,
> > -				 <0>,
> > -				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> > +				 <0>;
> >  			clock-names = "bi_tcxo",
> Wrong patch

Yup, as said by many folks in many places.  It seems the --fixup went to
the wrong commit, even though the clock-names were fixup'ed into the
right one...

Have fixed this for v2.

- Marijn

> 
> Konrad
> >  				      "gcc_disp_gpll0_div_clk_src",
> >  				      "dsi0_phy_pll_out_byteclk",
> > 
