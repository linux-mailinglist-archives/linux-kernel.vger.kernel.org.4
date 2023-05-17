Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD2706DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEQQTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjEQQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC0A5C5;
        Wed, 17 May 2023 09:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5460F6494C;
        Wed, 17 May 2023 16:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B059C433D2;
        Wed, 17 May 2023 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684340266;
        bh=AY5A1hYu1RLVk+v1p8YuhzNp4ErIpaq/MI2LxjMx3Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZDsUKFBl/bU7TbW57eeE3wNn0+8FoGG4o0e6J8xVtMzti5t1/bOIREEgnOORSL9y
         E4SQVJ6beTDQa1l95QoAsIUJNyEq+wsfxcRafPEuOmrJA18YRsuqAr+c0tJ/HaV8G0
         vkkXl3sSHSIt5dI+m/2mB+0qkjeOQ99atDsFhXBl2MmyGHkJGT9XfVMYJ+frnzDAi9
         Ls6tDPVPJomLKIyy0b3cD4CeZxT5dlePk2TO+1DJVm7wF1Igyl8CYR0ujrKTncnGTB
         qRxQ1rNJvnwVms6i2Thko9ePhQBczpkmwXXKaYydcC06jCf/QV7IAhaTrwgvaRq2dP
         jxDLVi1mn1WTg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzJqV-0006Ns-88; Wed, 17 May 2023 18:17:47 +0200
Date:   Wed, 17 May 2023 18:17:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZGT-K1PW66kEEYIJ@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-6-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514054917.21318-6-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:19:13AM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller
> which requires at most one HS and one SS PHY.
> 
> But the DWC3 USB controller can be connected to multiple ports and
> each port can have their own PHYs. Each port of the multiport
> controller can either be HS+SS capable or HS only capable
> Proper quantification of them is required to modify GUSB2PHYCFG
> and GUSB3PIPECTL registers appropriately.
> 
> Add support for detecting, obtaining and configuring phy's supported
> by a multiport controller and limit the max number of ports
> supported to 4.
> 
> Co-developed-by: Harsh Agarwal <quic_harshq@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

If Harsh is the primary author you need to add a From: line at the
beginning of the patch.

Either way, you need his SoB as well as your Co-developed-by tag.

All this is documented under Documentation/process/ somewhere.

> +/**
> + * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
> + * @dwc: Pointer to our controller context structure
> + *
> + * Returns 0 on success. The USB PHY interfaces are configured but not
> + * initialized. The PHY interfaces and the PHYs get initialized together with
> + * the core in dwc3_core_init.
> + */
> +static int dwc3_phy_setup(struct dwc3 *dwc)
> +{
> +	int i;
> +	int ret;

Please try to use reverse xmas style for declaration throughout (i.e.
place the longest declarations first).

> +
> +	for (i = 0; i < dwc->num_usb3_ports; i++) {
> +		ret = dwc3_ss_phy_setup(dwc, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = dwc3_hs_phy_setup(dwc, i);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -744,22 +777,38 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  static int dwc3_phy_init(struct dwc3 *dwc)
>  {
>  	int ret;
> +	int i;
> +	int j;
>  
>  	usb_phy_init(dwc->usb2_phy);
>  	usb_phy_init(dwc->usb3_phy);
>  
> -	ret = phy_init(dwc->usb2_generic_phy);
> -	if (ret < 0)
> -		goto err_shutdown_usb3_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_init(dwc->usb2_generic_phy[i]);
> +		if (ret < 0) {
> +			/* clean up prior initialized HS PHYs */
> +			for (j = 0; j < i; j++)
> +				phy_exit(dwc->usb2_generic_phy[j]);
> +			goto err_shutdown_usb3_phy;
> +		}
> +	}
>  
> -	ret = phy_init(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_exit_usb2_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_init(dwc->usb3_generic_phy[i]);
> +		if (ret < 0) {
> +			/* clean up prior initialized SS PHYs */
> +			for (j = 0; j < i; j++)
> +				phy_exit(dwc->usb3_generic_phy[j]);
> +			goto err_exit_usb2_phy;
> +		}
> +	}

The above is probably better implemented as a single loop over
num_usb2_ports where you enable each USB2 and USB3 PHY. On errors you
use the loop index to disable the already enabled PHYs in reverse
order below (after disabling the USB2 PHY if USB3 phy init fails).

>  	return 0;
>  
>  err_exit_usb2_phy:
> -	phy_exit(dwc->usb2_generic_phy);
> +	for (i = 0; i < dwc->num_usb2_ports; i++)
> +		phy_exit(dwc->usb2_generic_phy[i]);
> +

No need for a newline separator.

>  err_shutdown_usb3_phy:
>  	usb_phy_shutdown(dwc->usb3_phy);
>  	usb_phy_shutdown(dwc->usb2_phy);
> @@ -769,8 +818,12 @@ static int dwc3_phy_init(struct dwc3 *dwc)
>  
>  static void dwc3_phy_exit(struct dwc3 *dwc)
>  {
> -	phy_exit(dwc->usb3_generic_phy);
> -	phy_exit(dwc->usb2_generic_phy);
> +	int i;
> +
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		phy_exit(dwc->usb3_generic_phy[i]);
> +		phy_exit(dwc->usb2_generic_phy[i]);
> +	}

For symmetry, I'd probably do this in reverse order to.

>  	usb_phy_shutdown(dwc->usb3_phy);
>  	usb_phy_shutdown(dwc->usb2_phy);
> @@ -779,22 +832,38 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
>  static int dwc3_phy_power_on(struct dwc3 *dwc)
>  {
>  	int ret;
> +	int i;
> +	int j;
>  
>  	usb_phy_set_suspend(dwc->usb2_phy, 0);
>  	usb_phy_set_suspend(dwc->usb3_phy, 0);
>  
> -	ret = phy_power_on(dwc->usb2_generic_phy);
> -	if (ret < 0)
> -		goto err_suspend_usb3_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_power_on(dwc->usb2_generic_phy[i]);
> +		if (ret < 0) {
> +			/* Turn off prior ON'ed HS Phy's */
> +			for (j = 0; j < i; j++)
> +				phy_power_off(dwc->usb2_generic_phy[j]);
> +			goto err_suspend_usb3_phy;
> +		}
> +	}
>  
> -	ret = phy_power_on(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_power_off_usb2_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_power_on(dwc->usb3_generic_phy[i]);
> +		if (ret < 0) {
> +			/* Turn of prior ON'ed SS Phy's */
> +			for (j = 0; j < i; j++)
> +				phy_power_off(dwc->usb3_generic_phy[j]);
> +			goto err_power_off_usb2_phy;
> +		}
> +	}

These loops should be merged too as for phy_init.

>  	return 0;
>  
>  err_power_off_usb2_phy:
> -	phy_power_off(dwc->usb2_generic_phy);
> +	for (i = 0; i < dwc->num_usb2_ports; i++)
> +		phy_power_off(dwc->usb2_generic_phy[i]);
> +
>  err_suspend_usb3_phy:
>  	usb_phy_set_suspend(dwc->usb3_phy, 1);
>  	usb_phy_set_suspend(dwc->usb2_phy, 1);

> +static int dwc3_get_multiport_phys(struct dwc3 *dwc)
> +{
> +	int ret;
> +	struct device *dev = dwc->dev;
> +	int i;
> +	char phy_name[11];

As an example, for reverse xmas style this should be

	struct device *dev = dwc->dev;
	char phy_name[11];
	int ret;
	int i;

which tends to be more readable.

> +
> +	/*
> +	 * Each port is at least HS capable. So loop over num_usb2_ports
> +	 * to get available phy's.
> +	 */
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		sprintf(phy_name, "usb2-port%d", i);
> +		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb2_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb2_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "usb2 phy: %s not configured\n", phy_name);

This can just be

	"phy %s not configured"

or perhaps better

	"failed to lookup phy %s"

> +		}
> +
> +		sprintf(phy_name, "usb3-port%d", i);
> +		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb3_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb3_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "usb3 phy: %s not configured\n", phy_name);
> +		}
> +	}
> +
> +	return 0;
> +}

I think you should drop this helper and use the same loop for both
single and multiport controllers below.

Just use the old phy names if num_usb2_ports is 1, for example:

	if (dwc->num_usb2_ports == 1)
		sprintf(phy_name, "usb2-phy");
	else
		sprintf(phy_name, "usb2-port%d", i);

> +
>  static int dwc3_core_get_phy(struct dwc3 *dwc)
>  {
>  	struct device		*dev = dwc->dev;
> @@ -1314,20 +1428,23 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>  	}
>  
> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> -	if (IS_ERR(dwc->usb2_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb2_generic_phy);
> +	if (dwc->num_usb2_ports > 1)
> +		return dwc3_get_multiport_phys(dwc);
> +
> +	dwc->usb2_generic_phy[0] = devm_phy_get(dev, "usb2-phy");
> +	if (IS_ERR(dwc->usb2_generic_phy[0])) {
> +		ret = PTR_ERR(dwc->usb2_generic_phy[0]);
>  		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb2_generic_phy = NULL;
> +			dwc->usb2_generic_phy[0] = NULL;
>  		else
>  			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>  	}
>  
> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> -	if (IS_ERR(dwc->usb3_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb3_generic_phy);
> +	dwc->usb3_generic_phy[0] = devm_phy_get(dev, "usb3-phy");
> +	if (IS_ERR(dwc->usb3_generic_phy[0])) {
> +		ret = PTR_ERR(dwc->usb3_generic_phy[0]);
>  		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb3_generic_phy = NULL;
> +			dwc->usb3_generic_phy[0] = NULL;
>  		else
>  			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>  	}
 
>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  {
> +	int i;

Add this declaration last instead (and similar throughout).

>  	unsigned long	flags;
>  	u32 reg;

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index d3401963bc27..84f6303922aa 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -35,6 +35,9 @@
>  
>  #define DWC3_MSG_MAX	500
>  
> +/* Number of ports supported by a multiport controller */
> +#define MAX_PORTS_SUPPORTED	4

This define should have a DWC3 prefix (e.g. DWC3_MAX_PORTS, "SUPPORTED"
doesn't seem to add much).

Is this just an arbitrary implementation limit?

> +
>  /* Define XHCI Extcap register offsets for getting multiport info */
>  #define XHCI_HCC_PARAMS_OFFSET	0x10
>  #define DWC3_XHCI_HCSPARAMS1	0x04
> @@ -1038,8 +1041,8 @@ struct dwc3_scratchpad_array {
>   * @usb3_phy: pointer to USB3 PHY
>   * @num_usb2_ports: number of usb2 ports.
>   * @num_usb3_ports: number of usb3 ports.
> - * @usb2_generic_phy: pointer to USB2 PHY
> - * @usb3_generic_phy: pointer to USB3 PHY
> + * @usb2_generic_phy: pointer to array of USB2 PHY
> + * @usb3_generic_phy: pointer to array of USB3 PHY
>   * @phys_ready: flag to indicate that PHYs are ready
>   * @ulpi: pointer to ulpi interface
>   * @ulpi_ready: flag to indicate that ULPI is initialized
> @@ -1178,8 +1181,8 @@ struct dwc3 {
>  	u8			num_usb2_ports;
>  	u8			num_usb3_ports;
>  
> -	struct phy		*usb2_generic_phy;
> -	struct phy		*usb3_generic_phy;
> +	struct phy		*usb2_generic_phy[MAX_PORTS_SUPPORTED];
> +	struct phy		*usb3_generic_phy[MAX_PORTS_SUPPORTED];

As I mentioned in a comment to one of the earlier patches, you need to
add a sanity check when parsing the port counts to avoid accessing data
beyond these arrays when looping over the PHYs.

>  
>  	bool			phys_ready;

Johan
