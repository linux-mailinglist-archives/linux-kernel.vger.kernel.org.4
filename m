Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8C73FBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjF0MJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjF0MJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7971BCB;
        Tue, 27 Jun 2023 05:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 842DE60F56;
        Tue, 27 Jun 2023 12:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFB9C433CA;
        Tue, 27 Jun 2023 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687867774;
        bh=o/NmjEG+5s686IfEFNzrvwqoyugmv7rCTYWZI4R95Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIsQTa4zihp51cJM/gA0L9IfnedQoY2cY2y1+KGNAJhh8ddEXHu9W+OGF2pn1gWpt
         n/PmVnyB4smAVe2ZOUqdC/suqNljeWt5Ienf98x29va5zSoWJEf8lsPcZwzZP+5HOX
         5aWwR3jCn8OuK/aJiUEaLhwVfvOlAjJhmdQVZmugt7dj2VmTIL1Kj8gQBH5r9XUchA
         OrYNRhqT9f1y7oC3R//KZUPfrfY4cq8bPbSg2VpCu+P6e0TzVXCHCWQUOI8HMToS86
         B0tUzz0pWEMZNqgq8ikgouDyv9oluTRByDlaPxERhfXlg4byOWzhLr8Fh4gHEKMH/w
         leQAMO+uXtTrA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qE7Vj-0003MX-Dm; Tue, 27 Jun 2023 14:09:32 +0200
Date:   Tue, 27 Jun 2023 14:09:31 +0200
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
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 05/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZJrRe7HtMs0KbsCy@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-6-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-6-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:06:23AM +0530, Krishna Kurapati wrote:
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
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> [Krishna: Modifed logic for generic phy and rebased the patch]
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

As I already said:

	If Harsh is the primary author you need to add a From: line at
	the beginning of the patch.

	Either way, you need his SoB as well as your Co-developed-by tag.

	All this is documented under Documentation/process/ somewhere.

The above is missing a From line and two Co-developed-by tags at least.

> ---
>  drivers/usb/dwc3/core.c | 252 ++++++++++++++++++++++++++++------------
>  drivers/usb/dwc3/core.h |  11 +-
>  drivers/usb/dwc3/drd.c  |  15 ++-
>  3 files changed, 192 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index e1ebae54454f..2ac72525de7d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -120,10 +120,11 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  	struct dwc3 *dwc = work_to_dwc(work);
> +	u32 desired_dr_role;
>  	unsigned long flags;
>  	int ret;
>  	u32 reg;
> -	u32 desired_dr_role;

This is an unrelated change. Just add int i at the end.

> +	int i;
>  
>  	mutex_lock(&dwc->mutex);
>  	spin_lock_irqsave(&dwc->lock, flags);

> @@ -746,23 +779,34 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
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
> +		if (ret < 0)
> +			goto err_exit_usb2_phy;
> +	}
>  
> -	ret = phy_init(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_exit_usb2_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_init(dwc->usb3_generic_phy[i]);
> +		if (ret < 0)
> +			goto err_exit_usb3_phy;
> +	}
>  
>  	return 0;
>  
> +err_exit_usb3_phy:
> +	for (j = i-1; j >= 0; j--)

Missing spaces around - here and below.

> +		phy_exit(dwc->usb3_generic_phy[j]);
> +	i = dwc->num_usb2_ports;
>  err_exit_usb2_phy:
> -	phy_exit(dwc->usb2_generic_phy);
> -err_shutdown_usb3_phy:
> +	for (j = i-1; j >= 0; j--)
> +		phy_exit(dwc->usb2_generic_phy[j]);
> +

Again:

	The above is probably better implemented as a *single* loop over
	num_usb2_ports where you enable each USB2 and USB3 PHY. On
	errors you use the loop index to disable the already enabled
	PHYs in reverse order below (after disabling the USB2 PHY if
	USB3 phy init fails).

with emphasis on "single" added.

>  	usb_phy_shutdown(dwc->usb3_phy);
>  	usb_phy_shutdown(dwc->usb2_phy);

> @@ -781,23 +829,34 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
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
> +		if (ret < 0)
> +			goto err_power_off_usb2_phy;
> +	}
>  
> -	ret = phy_power_on(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_power_off_usb2_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		ret = phy_power_on(dwc->usb3_generic_phy[i]);
> +		if (ret < 0)
> +			goto err_power_off_usb3_phy;
> +	}

Again: These loops should be merged too as for phy_init.

>  	return 0;
>  
> +err_power_off_usb3_phy:
> +	for (j = i-1; j >= 0; j--)
> +		phy_power_off(dwc->usb3_generic_phy[i]);
> +	i = dwc->num_usb2_ports;
>  err_power_off_usb2_phy:
> -	phy_power_off(dwc->usb2_generic_phy);
> -err_suspend_usb3_phy:
> +	for (j = i-1; j >= 0; j--)
> +		phy_power_off(dwc->usb2_generic_phy[i]);
> +
>  	usb_phy_set_suspend(dwc->usb3_phy, 1);
>  	usb_phy_set_suspend(dwc->usb2_phy, 1);
>  

> @@ -1290,7 +1358,9 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  {
>  	struct device		*dev = dwc->dev;
>  	struct device_node	*node = dev->of_node;
> +	char phy_name[11];
>  	int ret;
> +	int i;
>  
>  	if (node) {
>  		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> @@ -1316,22 +1386,36 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>  	}
>  
> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> -	if (IS_ERR(dwc->usb2_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb2_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb2_generic_phy = NULL;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		if (dwc->num_usb2_ports == 1)
> +			sprintf(phy_name, "usb2-phy");
>  		else
> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> -	}
> +			sprintf(phy_name, "usb2-port%d", i);
> +
> +		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb2_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb2_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret,
> +					"no %s phy configured\n", phy_name);

I still believe

	"failed to lookup phy %s"

is better.

> +		}
>  
> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> -	if (IS_ERR(dwc->usb3_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb3_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb3_generic_phy = NULL;
> +		if (dwc->num_usb2_ports == 1)
> +			sprintf(phy_name, "usb3-phy");
>  		else
> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +			sprintf(phy_name, "usb3-port%d", i);
> +
> +		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb3_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb3_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret,
> +					"no %s phy configured\n", phy_name);

Same here.

> +		}
>  	}
>  
>  	return 0;

> @@ -1821,6 +1908,9 @@ static int dwc3_read_port_info(struct dwc3 *dwc)
>  	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
>  			dwc->num_usb2_ports, dwc->num_usb3_ports);
>  
> +	if (dwc->num_usb2_ports > DWC3_MAX_PORTS)
> +		ret = -ENOMEM;

You also need to add a check for num_usb3_ports as I already mentioned.

> +
>  	iounmap(base);
>  	return ret;
>  }

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 42fb17aa66fa..b2bab23ca22b 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -37,6 +37,9 @@
>  #define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
>  #define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
>  
> +/* Number of ports supported by a multiport controller */
> +#define DWC3_MAX_PORTS 4

You did not answer my question about whether this was an arbitrary
implementation limit (i.e. just reflecting the only currently supported
multiport controller)?

> +
>  #define DWC3_MSG_MAX	500
>  
>  /* Global constants */
> @@ -1031,8 +1034,8 @@ struct dwc3_scratchpad_array {
>   * @usb_psy: pointer to power supply interface.
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
> - * @usb2_generic_phy: pointer to USB2 PHY
> - * @usb3_generic_phy: pointer to USB3 PHY
> + * @usb2_generic_phy: pointer to array of USB2 PHY
> + * @usb3_generic_phy: pointer to array of USB3 PHY
>   * @num_usb2_ports: number of USB2 ports.
>   * @num_usb3_ports: number of USB3 ports.
>   * @phys_ready: flag to indicate that PHYs are ready
> @@ -1171,8 +1174,8 @@ struct dwc3 {
>  	struct usb_phy		*usb2_phy;
>  	struct usb_phy		*usb3_phy;
>  
> -	struct phy		*usb2_generic_phy;
> -	struct phy		*usb3_generic_phy;
> +	struct phy		*usb2_generic_phy[DWC3_MAX_PORTS];
> +	struct phy		*usb3_generic_phy[DWC3_MAX_PORTS];
>  
>  	u8			num_usb2_ports;
>  	u8			num_usb3_ports;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 039bf241769a..18a247ff75ac 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -327,10 +327,11 @@ static void dwc3_otg_device_exit(struct dwc3 *dwc)
>  
>  void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  {
> +	unsigned long flags;
>  	int ret;
>  	u32 reg;
>  	int id;
> -	unsigned long flags;
> +	int i;
>  
>  	if (dwc->dr_mode != USB_DR_MODE_OTG)
>  		return;
> @@ -386,9 +387,11 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  		} else {
>  			if (dwc->usb2_phy)
>  				otg_set_vbus(dwc->usb2_phy->otg, true);
> -			if (dwc->usb2_generic_phy)
> -				phy_set_mode(dwc->usb2_generic_phy,
> -					     PHY_MODE_USB_HOST);
> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
> +				if (dwc->usb2_generic_phy[i])
> +					phy_set_mode(dwc->usb2_generic_phy[i],
> +						     PHY_MODE_USB_HOST);

While not strictly necessary, adding bracket around multiline statements
is usually preferred as it improves readability.

> +			}
>  		}
>  		break;
>  	case DWC3_OTG_ROLE_DEVICE:
> @@ -400,8 +403,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  
>  		if (dwc->usb2_phy)
>  			otg_set_vbus(dwc->usb2_phy->otg, false);
> -		if (dwc->usb2_generic_phy)
> -			phy_set_mode(dwc->usb2_generic_phy,
> +		if (dwc->usb2_generic_phy[0])
> +			phy_set_mode(dwc->usb2_generic_phy[0],
>  				     PHY_MODE_USB_DEVICE);

Same here, but this is probably better just left at 85 columns after
removing the line break.

>  		ret = dwc3_gadget_init(dwc);
>  		if (ret)

Johan
