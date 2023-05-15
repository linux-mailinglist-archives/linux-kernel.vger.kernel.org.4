Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADE1704006
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbjEOVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245631AbjEOVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:43:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37E37DAA;
        Mon, 15 May 2023 14:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908C66153D;
        Mon, 15 May 2023 21:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88361C4339E;
        Mon, 15 May 2023 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684187020;
        bh=b+pXr4Hrxo2j7GrVI2Y1r49la08BF7ssH996PN0WsJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoiPYmWfQxUh4yS2f9BOVWk4MJtIqlqiw0TaU1DxI8jJitoIaE3iWpUKUB83n8lSF
         Lf5e/onvs8yvVj8g1eYGgmEUA2SptH8QRh7dCUYpygfQGEcNo9n887hfKBxC83o6kl
         M7ouOIlsUVU9TC3wVRt/GZgtJRTABw/sDSu8UFUAnolgZNTgfqs8k1FwZsspMpGVnb
         cpacoB+hmpZ141HUzvcJFYqMoXsGadxNrcs7H0yOYZD4kD4SpXoGKBpbsTd9zsSloS
         ZIpI1Uj1EDEqYRxxOyTHIPT4e5+bX18jBW2LVQ86YTO+nOJ1U3HSfruX426QZzigMI
         GkoHNgtRaUYBg==
Date:   Mon, 15 May 2023 14:47:30 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <20230515214730.epeelsnp3bznssr5@ripper>
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

Please include Harsh's signed-off-by as well here, to clarify that you
both certify the origin of this patch.

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 266 ++++++++++++++++++++++++++++++----------
>  drivers/usb/dwc3/core.h |  11 +-
>  drivers/usb/dwc3/drd.c  |  13 +-
>  3 files changed, 213 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
[..]
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

The idiomatic form is to goto err_exit_usb2_phy and let it phy_exit()
from i - 1 to 0. That would avoid duplicating this snippet.

> +		}
> +	}
>  
> -	ret = phy_init(dwc->usb3_generic_phy);
> -	if (ret < 0)
> -		goto err_exit_usb2_phy;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {

When you call dwc3_ss_phy_setup() the index refer to port0, port1... but
when you refer to the phys you consistently loops over num_usb2_ports.

The only case I can think of where this would be useful is if it's not
the first N ports that are SS-capable (e.g. port0 and port can do SS).

If this is the case, is it correct that this should not be reflected in
the index passed to e.g. dwc3_ss_phy_setup()?

If this is not the case, could you please transition these SS-related
loops to iterate over usb3_generic_phy[0..num_usb3_ports)?

> +		ret = phy_init(dwc->usb3_generic_phy[i]);
> +		if (ret < 0) {
> +			/* clean up prior initialized SS PHYs */
> +			for (j = 0; j < i; j++)
> +				phy_exit(dwc->usb3_generic_phy[j]);
> +			goto err_exit_usb2_phy;

For the purpose of symmetry, same suggestion as above. phy_exit() i - 1
through 0, then reset j to dwc->num_usb2_ports and fall through to
err_exit_usb2_phy.

> +		}
> +	}
>  
>  	return 0;
>  
>  err_exit_usb2_phy:
> -	phy_exit(dwc->usb2_generic_phy);
> +	for (i = 0; i < dwc->num_usb2_ports; i++)
> +		phy_exit(dwc->usb2_generic_phy[i]);
> +
>  err_shutdown_usb3_phy:
>  	usb_phy_shutdown(dwc->usb3_phy);
>  	usb_phy_shutdown(dwc->usb2_phy);
> @@ -769,8 +818,12 @@ static int dwc3_phy_init(struct dwc3 *dwc)
[..]
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

As above, I'd prefer that you don't duplicate the phy_power_off() loop.

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
>  
>  	return 0;
[..]
> +static int dwc3_get_multiport_phys(struct dwc3 *dwc)
> +{
> +	int ret;
> +	struct device *dev = dwc->dev;
> +	int i;
> +	char phy_name[11];

It would be prettier if you sorted these lines by length, longest
first...

[..]
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

I think it would be preferred to prefix this DWC3_ (so perhaps just
DWC3_MAX_PORTS, to keep it shorter)

Regards,
Bjorn

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
>  
>  	bool			phys_ready;

