Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432DB6F43AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjEBMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjEBMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A86DB;
        Tue,  2 May 2023 05:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0281623C6;
        Tue,  2 May 2023 12:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1D2C433EF;
        Tue,  2 May 2023 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683030140;
        bh=F0jPa7tNnQ7D5aJHQ4nzmWOU1N0VFYe0lBrk9O1VlPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk6YMvjU9y/Qp3ns9rsftJIWNO8/ESFTf+Z9h2R3TytencJLZiVoZ3TWpLcd+5uWl
         RnkW77KMyU/VgjCjV3fibO3kfBkgcgNnOym89+3IGbHOEtsC1l2UvKKjA8cLARdSYL
         8yEexMexUq06xN72hlervrUJ26BrSpHFMPuHfXw4vv2OYA25tuYsXY0+TSiPTcxszh
         RUe8PPTQNU2eWCdBn4L+Pvf5JmkcrbtU6Xv3VXruPjTtkXlkGyIkV6maTN/ZNjhVPD
         QX9jxCN6oMYvhOBTGF4l/WbfG17eFQP1AmYyh2a51Gtth5wjWi+DnLY5zsuXyZtobO
         IJRDAGyiuBF1w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ptp1S-0003lW-CA; Tue, 02 May 2023 14:22:23 +0200
Date:   Tue, 2 May 2023 14:22:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sc8280xp-crd: Add QMP to
 SuperSpeed graph
Message-ID: <ZFEAfv2GnGeblk-x@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-7-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-7-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:40:09PM -0700, Bjorn Andersson wrote:
> With support for the QMP combo phy to react to USB Type-C switch events,
> introduce it as the next hop for the SuperSpeed lanes of the two USB
> Type-C connectors, and connect the output of the DisplayPort controller
> to the QMP combo phy.
> 
> This allows the TCPM to perform orientation switching of both USB and
> DisplayPort signals.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 28 ++++++++++++++++---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 34 +++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 547277924ea3..33c973661fa5 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -64,7 +64,7 @@ port@1 {
>  					reg = <1>;
>  
>  					pmic_glink_con0_ss: endpoint {
> -						remote-endpoint = <&mdss0_dp0_out>;
> +						remote-endpoint = <&usb_0_qmpphy_out>;
>  					};
>  				};
>  
> @@ -99,7 +99,7 @@ port@1 {
>  					reg = <1>;
>  
>  					pmic_glink_con1_ss: endpoint {
> -						remote-endpoint = <&mdss0_dp1_out>;
> +						remote-endpoint = <&usb_1_qmpphy_out>;
>  					};
>  				};
>  
> @@ -412,7 +412,7 @@ &mdss0_dp0 {
>  
>  &mdss0_dp0_out {
>  	data-lanes = <0 1>;
> -	remote-endpoint = <&pmic_glink_con0_ss>;
> +	remote-endpoint = <&usb_0_qmpphy_dp_in>;
>  };

It's a bit hard to follow what going on when using place holder nodes
from the dtsi like this (instead of describing all the ports directly in
the board dts). IIRC we went a bit back and forth over this earlier and
we already use this scheme for the display port controllers, so I guess
this is the price we pay for being consistent.

>  &mdss0_dp1 {
> @@ -421,7 +421,7 @@ &mdss0_dp1 {
>  
>  &mdss0_dp1_out {
>  	data-lanes = <0 1>;
> -	remote-endpoint = <&pmic_glink_con1_ss>;
> +	remote-endpoint = <&usb_1_qmpphy_dp_in>;
>  };
>  
>  &mdss0_dp3 {
> @@ -670,9 +670,19 @@ &usb_0_qmpphy {
>  	vdda-phy-supply = <&vreg_l9d>;
>  	vdda-pll-supply = <&vreg_l4d>;
>  
> +	orientation-switch;
> +
>  	status = "okay";
>  };
>  
> +&usb_0_qmpphy_dp_in {
> +	remote-endpoint = <&mdss0_dp0_out>;
> +};
> +
> +&usb_0_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_con0_ss>;
> +};
> +
>  &usb_0_role_switch {
>  	remote-endpoint = <&pmic_glink_con0_hs>;
>  };
> @@ -697,9 +707,19 @@ &usb_1_qmpphy {
>  	vdda-phy-supply = <&vreg_l4b>;
>  	vdda-pll-supply = <&vreg_l3b>;
>  
> +	orientation-switch;
> +
>  	status = "okay";
>  };
>  
> +&usb_1_qmpphy_dp_in {
> +	remote-endpoint = <&mdss0_dp1_out>;
> +};
> +
> +&usb_1_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_con1_ss>;
> +};
> +
>  &usb_1_role_switch {
>  	remote-endpoint = <&pmic_glink_con1_hs>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 0e691bb0120c..1eb3a295e8fa 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3006,6 +3006,23 @@ usb_0_qmpphy: phy@88eb000 {
>  			#phy-cells = <1>;
>  
>  			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usb_0_qmpphy_out: endpoint {};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usb_0_qmpphy_dp_in: endpoint {};
> +				};
> +			};
>  		};

The binding describes three ports, where dp-in is port 2.

Perhaps you don't need to describe ss-in yet, but shouldn't the port
numbers match? Should some of these be described as required in the
binding?

Johan
