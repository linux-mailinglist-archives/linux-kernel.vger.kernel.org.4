Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F56927AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjBJULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjBJULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:11:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8978A7715E;
        Fri, 10 Feb 2023 12:11:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15063B825BC;
        Fri, 10 Feb 2023 20:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBF0C433EF;
        Fri, 10 Feb 2023 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676059878;
        bh=UpLsLM0dIW1xKYTe7eiNA2wMsEDJQCI2zofHYA76W+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhDDjyNffMpyzcxqdJp3keekiun++iUZGFJkYpug1EcH92rH9HsZfz/isR+1UHks+
         aw07VDMic8SHjvJNYxnmJhEn2sES5pZLqGxK8u3D+UazeYWoSI6SAzp2wsp1bQgg3M
         8W+tv30v0hv9rBlFOvRBFn+1qmSf90Zq8H1svr5bPMZheeycFsPgBTAbrVeKCZFKLt
         6Rc1PvZUGHYQgCROtYukYJFYftOBgQAeqP2Re8phZhgmIbf25nV5vthqYR3MYsfW6d
         ZaVJvYatnCrAuW3gVBc97F1CbCp3ChCFHD/ktzGCLvU+N7wPejA9DjEgkweB+Zi46V
         /2M3ME2nAJuUg==
Date:   Fri, 10 Feb 2023 12:13:27 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: sm8350-hdk: add pmic glink
 node
Message-ID: <20230210201327.fboziimwky2wffiw@ripper>
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-8-71fea256474f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-8-71fea256474f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:02:11PM +0100, Neil Armstrong wrote:
> Add the pmic glink node linked with the DWC3 USB controller
> switched to OTG mode and tagged with usb-role-switch.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 77 ++++++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 54654eb75c28..28fc9a835c5d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -31,6 +31,40 @@ hdmi_con: endpoint {
>  		};
>  	};
>  
> +	pmic-glink {
> +		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_hs_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_hs>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_ss_in: endpoint {
> +						remote-endpoint = <&usb_1_dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> @@ -666,23 +700,42 @@ &usb_1 {
>  };
>  
>  &usb_1_dwc3 {
> -	/* TODO: Define USB-C connector properly */
> -	dr_mode = "peripheral";
> -};
> +	dr_mode = "otg";
> +	usb-role-switch;
>  
> -&usb_1_hsphy {
> -	status = "okay";
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -	vdda-pll-supply = <&vreg_l5b_0p88>;
> -	vdda18-supply = <&vreg_l1c_1p8>;
> -	vdda33-supply = <&vreg_l2b_3p07>;
> +		port@0 {
> +			reg = <0>;
> +
> +			usb_1_dwc3_hs: endpoint {
> +				remote-endpoint = <&pmic_glink_hs_in>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			usb_1_dwc3_ss: endpoint {
> +				remote-endpoint = <&pmic_glink_ss_in>;

The connector is indeed the next active component on the SuperSpeed
lanes for USB. But as you're targeting to introduce QMP on that path,
connector@0/port@1 would be pointing to QMP/ports/port@N.

Do you plan to express the datapath between USB and QMP using this port
at that time? (It's the correct thing to do...)

Or will we not describe the SS lanes in this scenario?

Regards,
Bjorn

> +			};
> +		};
> +	};
>  };
>  
> -&usb_1_qmpphy {
> -	status = "okay";
> +&usb_1_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
>  
> -	vdda-phy-supply = <&vreg_l6b_1p2>;
> -	vdda-pll-supply = <&vreg_l1b_0p88>;
> +&usb_1_dwc3_hs {
> +	remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_1_dwc3_ss {
> +	remote-endpoint = <&pmic_glink_ss_in>;
>  };
>  
>  &usb_2 {
> 
> -- 
> 2.34.1
> 
