Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489E712CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbjEZS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjEZS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B510135;
        Fri, 26 May 2023 11:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38217637F7;
        Fri, 26 May 2023 18:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2CC433EF;
        Fri, 26 May 2023 18:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685127514;
        bh=CqdMwZ4bk5DlDgrri3qNV5ero1jQrn4fYGUAfHX4GI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNmOttSNBunNfBl45V3AOvpdHcU8RAMknFnb9vdZDwwauyeyozyaVoQYkyEwBgHnt
         InThQNCXF91iIRALCrBx6cKHtIOw6cbemr+h/tL96SzhVk4liLo8P60rIiS6eXFE2A
         iNSuIHEAmzP6t1TAzH/A1nKRuca0ILD04tHXuT+rJtdYKP5pNQ7s0Gaqfb0G0rRt2Y
         mdZ3BOh/DgbrCfspTpWLEip6CQtMU5/axPsc49MTmdZkfmPDYyadj7olU0j98Qw+7b
         HdhY1xkJM/pdiaqfyni5TA30jIOM/F1iH8vvFGDCYhRMZcfnqvsv4oVT4BeLyUClSG
         2KJhR4M7aMawg==
Date:   Fri, 26 May 2023 12:02:22 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, quic_schowdhu@quicinc.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Message-ID: <20230526190222.2dyopipjz2llclus@ripper>
References: <20230104101228.3964304-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104101228.3964304-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 03:42:28PM +0530, Bhupesh Sharma wrote:
> Add the Embedded USB Debugger(EUD) device tree node for
> SM6115 / SM4250 SoC.
> 
> The node contains EUD base register region, EUD mode manager
> register region and TCSR Check register region along with the
> interrupt entry.
> 
> Also add the typec connector node for EUD which is attached to
> EUD node via port. EUD is also attached to DWC3 node via port.
> 
> To enable the role switch, we need to set dr_mode = "otg" property
> for 'usb_dwc3' sub-node in the board dts file.
> 
> Also the EUD device can be enabled on a board once linux is boot'ed
> by setting:
>  $ echo 1 > /sys/bus/platform/drivers/qcom_eud/../enable
> 

I was under the impression that you where working on some updates to EUD
and was going to resend this, but I don't find a new version, and I
don't see an on-list reply from me.

So just to make sure this isn't lost any longer... Can you please respin
this to correct the dtc warnings?

Thanks,
Bjorn

> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> - v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230104052047.3945983-1-bhupesh.sharma@linaro.org
> - In v3, fix the errors reported by '$ make dtbs_check' for the port sub node:
>   ports:
>     'oneOf' conditional failed, one must be fixed:
>         'port' is a required property
>         '#address-cells' is a required property
>         '#size-cells' is a required property
> - This patch is based on my earlier sm6115 usb related changes, which can
>   be seen here:
>   https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
> - This patch is also dependent on my sm6115 eud dt-binding and driver changes
>   (v2) sent earlier, which can be seen here:
>   https://lore.kernel.org/linux-arm-msm/20230103150419.3923421-1-bhupesh.sharma@linaro.org/
> 
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 46 ++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 030763187cc3f..a1a4f659587f3 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -170,6 +170,18 @@ core3 {
>  		};
>  	};
>  
> +	eud_typec: connector {
> +		compatible = "usb-c-connector";
> +
> +		ports {
> +			port@0 {
> +				con_eud: endpoint {
> +					remote-endpoint = <&eud_con>;
> +				};
> +			};
> +		};
> +	};
> +
>  	firmware {
>  		scm: scm {
>  			compatible = "qcom,scm-sm6115", "qcom,scm";
> @@ -565,6 +577,33 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		eud: eud@1610000 {
> +			compatible = "qcom,sm6115-eud", "qcom,eud";
> +			reg = <0x01610000 0x2000>,
> +			      <0x01612000 0x1000>,
> +			      <0x003e5018 0x4>;
> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +					eud_ep: endpoint {
> +						remote-endpoint = <&usb2_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					eud_con: endpoint {
> +						remote-endpoint = <&con_eud>;
> +					};
> +				};
> +			};
> +		};
> +
>  		usb_hsphy: phy@1613000 {
>  			compatible = "qcom,sm6115-qusb2-phy";
>  			reg = <0x01613000 0x180>;
> @@ -1064,6 +1103,13 @@ usb_dwc3: usb@4e00000 {
>  				snps,has-lpm-erratum;
>  				snps,hird-threshold = /bits/ 8 <0x10>;
>  				snps,usb3_lpm_capable;
> +				usb-role-switch;
> +
> +				port {
> +					usb2_role_switch: endpoint {
> +						remote-endpoint = <&eud_ep>;
> +					};
> +				};
>  			};
>  		};
>  
> -- 
> 2.38.1
> 
