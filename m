Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D126B73FB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjF0Lpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjF0Lpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD050F4;
        Tue, 27 Jun 2023 04:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4452661166;
        Tue, 27 Jun 2023 11:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E79FC433C0;
        Tue, 27 Jun 2023 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687866344;
        bh=1hnYTqMzhlhytwgb/6vjrVjvJJ91r+9AWszFEARG5vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5KUs9BF50Gr9OBt+4gfgvGUWeIe8DIeta9/O/XtmP6gecIhJOc6C3VuXgF/u+qE0
         ACLxga2WT6GhMLd27ObnNT/U5S2BKB9fiavY/eU+Z4+0Jin0cna+0dw2KpYpxKTzgR
         uSXwJK9DGzZIi5rgG+KZSka/9XRKbqwLzY8Edhco1d1d3GmspUOlQz7xNqOaBJyXqQ
         1ShrAv3C7iHnZTKUbcD8s13BRxSDA4JTTRSB3/tJMwwa9TXbqHqb6ouDDPzZumwCsE
         qwgKDF22VFW1yJ0ylPuyq+AGigdbz8JehfWb4UxMVv8fFTND4KHr3Ra79gftNyC6iL
         PYXCJ55tCb6yA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qE78f-0003E8-1K; Tue, 27 Jun 2023 13:45:41 +0200
Date:   Tue, 27 Jun 2023 13:45:41 +0200
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
Subject: Re: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZJrL5SXrSiYbvq2o@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-4-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-4-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:06:21AM +0530, Krishna Kurapati wrote:
> Currently host-only capable DWC3 controllers support Multiport.
> Temporarily map XHCI address space for host-only controllers and parse
> XHCI Extended Capabilities registers to read number of usb2 ports and
> usb3 ports present on multiport controller. Each USB Port is at least HS
> capable.
> 
> The port info for usb2 and usb3 phy are identified as num_usb2_ports
> and num_usb3_ports. The intention is as follows:
> 
> Wherever we need to perform phy operations like:
> 
> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
> {
> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
> }
> 
> If number of usb2 ports is 3, loop can go from index 0-2 for
> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
> if the first 2 ports are SS capable or some other ports like (2 and 3)
> are SS capable. So instead, num_usb2_ports is used to loop around all
> phy's (both hs and ss) for performing phy operations. If any
> usb3_generic_phy turns out to be NULL, phy operation just bails out.
> 
> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
> phy's as we need to know how many SS capable ports are there for this.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |  9 ++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f6689b731718..32ec05fc242b 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -39,6 +39,7 @@
>  #include "io.h"
>  
>  #include "debug.h"
> +#include "../host/xhci-ext-caps.h"
>  
>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>  
> @@ -1767,6 +1768,52 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>  	return 0;
>  }
>  
> +static int dwc3_read_port_info(struct dwc3 *dwc)
> +{
> +	void __iomem *base;
> +	u8 major_revision;
> +	u32 offset = 0;
> +	int ret = 0;

ret is never modified, so drop and return 0 unconditionally below.

You can add it back later in the series when you start using it.

> +	u32 val;
> +
> +	/*
> +	 * Remap xHCI address space to access XHCI ext cap regs,
> +	 * since it is needed to get port info.
> +	 */
> +	base = ioremap(dwc->xhci_resources[0].start,
> +				resource_size(&dwc->xhci_resources[0]));
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	do {
> +		offset = xhci_find_next_ext_cap(base, offset,
> +				XHCI_EXT_CAPS_PROTOCOL);
> +

You can drop this newline.

> +		if (!offset)
> +			break;
> +
> +		val = readl(base + offset);
> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
> +
> +		val = readl(base + offset + 0x08);
> +		if (major_revision == 0x03) {
> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else if (major_revision <= 0x02) {
> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else {
> +			dev_err(dwc->dev,
> +				"Unrecognized port major revision %d\n",
> +							major_revision);
> +		}
> +	} while (1);
> +
> +	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
> +			dwc->num_usb2_ports, dwc->num_usb3_ports);
> +
> +	iounmap(base);

Nit: I'd add a newline here.

> +	return ret;
> +}
> +
>  static int dwc3_probe(struct platform_device *pdev)
>  {
>  	struct device		*dev = &pdev->dev;
> @@ -1774,6 +1821,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  	void __iomem		*regs;
>  	struct dwc3		*dwc;
>  	int			ret;
> +	unsigned int		hw_mode;
>  
>  	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>  	if (!dwc)
> @@ -1854,6 +1902,20 @@ static int dwc3_probe(struct platform_device *pdev)
>  			goto err_disable_clks;
>  	}
>  
> +	/*
> +	 * Currently only DWC3 controllers that are host-only capable
> +	 * support Multiport.
> +	 */
> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
> +		ret = dwc3_read_port_info(dwc);
> +		if (ret)
> +			goto err_disable_clks;
> +	} else {
> +		dwc->num_usb2_ports = 1;
> +		dwc->num_usb3_ports = 1;
> +	}
> +
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8b1295e4dcdd..42fb17aa66fa 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -33,6 +33,10 @@
>  
>  #include <linux/power_supply.h>
>  
> +#define XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
> +#define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
> +#define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)

Again, don't copy defines from xhci.

Looks like these should be moved to the xhci-ext-caps.h header along
with struct xhci_protocol_caps.

> +
>  #define DWC3_MSG_MAX	500
>  
>  /* Global constants */
> @@ -1029,6 +1033,8 @@ struct dwc3_scratchpad_array {
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
>   * @usb3_generic_phy: pointer to USB3 PHY
> + * @num_usb2_ports: number of USB2 ports.
> + * @num_usb3_ports: number of USB3 ports.

Again, please drop the full stops ('.').

Johan
