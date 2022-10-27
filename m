Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5760EFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiJ0FvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ0FvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2B152C64;
        Wed, 26 Oct 2022 22:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FE4462159;
        Thu, 27 Oct 2022 05:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F288C433C1;
        Thu, 27 Oct 2022 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666849878;
        bh=1mbV3RdqjE6KV4n2taMEXH1Jcp+4IaSQg47Tn36Ycq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miP6PrREIACJwtX4UGpxujoCLSKiS0Wz8KKjBWZpMZ3+k49+y1nG9Pae97/x2cbHX
         pH/ClKnV/39W7rOOZaD7nsbIJhlzn/g6ak8nTAfhcwmI4x8O5o/TGVFNstvnIra5Qf
         346xVGqoIkhY+hVl96HebzGPc05ad00F0ue9kb7qRGbkdJ8SDcjNIVyLuBpPig2If9
         OFITXihSc6iTETfV9a1y/nLFrF3uCJb3kJJBk/xcyFWM/3uj04MeYKUfD5vPCyaHx0
         3mvJLz0MIGvCBVfu2WNfIUHZFRDKSgT5twvpSIYaYikrO3y2VsJ7YXHCfJJWI3p9lp
         ieQ9dCQkclLrA==
Date:   Thu, 27 Oct 2022 13:51:12 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     jun.li@nxp.com, a-govindraju@ti.com, gregkh@linuxfoundation.org,
        hzpeterchen@gmail.com, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pawell@cadence.com, rogerq@kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 1/1] usb: cdns3: host: fix endless superspeed hub port
 reset
Message-ID: <20221027055112.GA74576@nchen-desktop>
References: <20221026190749.2280367-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026190749.2280367-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-26 15:07:49, Frank Li wrote:
> From: Li Jun <jun.li@nxp.com>
> 
> When usb 3.0 hub connect with one USB 2.0 device and NO USB 3.0 device,
> some usb hub reports endless port reset message.
> 
> [  190.324169] usb 2-1: new SuperSpeed USB device number 88 using xhci-hcd
> [  190.352834] hub 2-1:1.0: USB hub found
> [  190.356995] hub 2-1:1.0: 4 ports detected
> [  190.700056] usb 2-1: USB disconnect, device number 88
> [  192.472139] usb 2-1: new SuperSpeed USB device number 89 using xhci-hcd
> [  192.500820] hub 2-1:1.0: USB hub found
> [  192.504977] hub 2-1:1.0: 4 ports detected
> [  192.852066] usb 2-1: USB disconnect, device number 89
> 
> The reason is the runtime pm state of USB2.0 port is active and
> USB 3.0 port is suspend, so parent device is active state.
> 
>  cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/usb2/power/runtime_status
> 
>  suspended
> 
>  cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/usb1/power/runtime_status
> 
>  active
> 
>  cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/xhci-hcd.1.auto/power/runtime_status
> 
>  active
> 
>  cat /sys/bus/platform/devices/5b110000.usb/5b130000.usb/power/runtime_status
> 
>  active
> 
> So xhci_cdns3_suspend_quirk() have not called. U3 configure is not applied.
> 
> move U3 configure into host start. Reinit again in resume function in case
> controller power lost during suspend.
> 
> Cc: stable@vger.kernel.org 5.10
> Signed-off-by: Li Jun <jun.li@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Change from V1 to V2. 
>  - call xhci_cdns3_plat_start() in xhci_cdns3_resume_quirk
> in case power lost during suspend

Reviewed-by: Peter Chen <peter.chen@kernel.org>

> 
>  drivers/usb/cdns3/host.c | 56 ++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index 9643b905e2d8..6164fc4c96a4 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -24,11 +24,37 @@
>  #define CFG_RXDET_P3_EN		BIT(15)
>  #define LPM_2_STB_SWITCH_EN	BIT(25)
>  
> -static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd);
> +static void xhci_cdns3_plat_start(struct usb_hcd *hcd)
> +{
> +	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +	u32 value;
> +
> +	/* set usbcmd.EU3S */
> +	value = readl(&xhci->op_regs->command);
> +	value |= CMD_PM_INDEX;
> +	writel(value, &xhci->op_regs->command);
> +
> +	if (hcd->regs) {
> +		value = readl(hcd->regs + XECP_AUX_CTRL_REG1);
> +		value |= CFG_RXDET_P3_EN;
> +		writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
> +
> +		value = readl(hcd->regs + XECP_PORT_CAP_REG);
> +		value |= LPM_2_STB_SWITCH_EN;
> +		writel(value, hcd->regs + XECP_PORT_CAP_REG);
> +	}
> +}
> +
> +static int xhci_cdns3_resume_quirk(struct usb_hcd *hcd)
> +{
> +	xhci_cdns3_plat_start(hcd);
> +	return 0;
> +}
>  
>  static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
>  	.quirks = XHCI_SKIP_PHY_INIT | XHCI_AVOID_BEI,
> -	.suspend_quirk = xhci_cdns3_suspend_quirk,
> +	.plat_start = xhci_cdns3_plat_start,
> +	.resume_quirk = xhci_cdns3_resume_quirk,
>  };
>  
>  static int __cdns_host_init(struct cdns *cdns)
> @@ -90,32 +116,6 @@ static int __cdns_host_init(struct cdns *cdns)
>  	return ret;
>  }
>  
> -static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
> -{
> -	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> -	u32 value;
> -
> -	if (pm_runtime_status_suspended(hcd->self.controller))
> -		return 0;
> -
> -	/* set usbcmd.EU3S */
> -	value = readl(&xhci->op_regs->command);
> -	value |= CMD_PM_INDEX;
> -	writel(value, &xhci->op_regs->command);
> -
> -	if (hcd->regs) {
> -		value = readl(hcd->regs + XECP_AUX_CTRL_REG1);
> -		value |= CFG_RXDET_P3_EN;
> -		writel(value, hcd->regs + XECP_AUX_CTRL_REG1);
> -
> -		value = readl(hcd->regs + XECP_PORT_CAP_REG);
> -		value |= LPM_2_STB_SWITCH_EN;
> -		writel(value, hcd->regs + XECP_PORT_CAP_REG);
> -	}
> -
> -	return 0;
> -}
> -
>  static void cdns_host_exit(struct cdns *cdns)
>  {
>  	kfree(cdns->xhci_plat_data);
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen
