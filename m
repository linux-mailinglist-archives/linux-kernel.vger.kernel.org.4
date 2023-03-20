Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29C6C0C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCTIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCTIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:24:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F91B328;
        Mon, 20 Mar 2023 01:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABC44B80CAA;
        Mon, 20 Mar 2023 08:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A44C433D2;
        Mon, 20 Mar 2023 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679300661;
        bh=ZqJq4Y8DDKXjFJd8m4XeNm2gxgygqQgB80Tk3YOtJHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JXsJIW/w6mD5JE3/237K85EkwZcygc1eQnXEaibtn2Ic96bucxydyCr0COUrWiZwb
         tlCq+HeOkoN0C0nYD2ugLgdRqpQmTRUvv5PpejClFGbztuQndnpWVk9/Xz7d5YU6RV
         orD+w0I8Ue2eOvXCMtXo0STkmhKOta2XwE5Gzx1FvvvRSp8p9FX3Tr26ZZmjHACxTp
         hO9Sj1N4bHUx0Ngg0LlHryjvpkhoFzLg7PFGceFMsljqw1pI3NuMXoqA4uCk8O6kuJ
         nV9pKnU0H9GOMuRfUp11V3QKfD0l5R6byb8XVfwzKJOPuRzMw6kZOh/zsCGRA6uq0G
         YYM1jsQK6yu1g==
Message-ID: <64adaa25-9179-3805-8d71-38418dc1bd54@kernel.org>
Date:   Mon, 20 Mar 2023 10:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] usb: dwc3-am62: Fix up wake-up configuration and
 spurious wake up
Content-Language: en-US
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316131226.89540-1-rogerq@kernel.org>
 <20230316131226.89540-4-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230316131226.89540-4-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/03/2023 15:12, Roger Quadros wrote:
> Explicitly set and clear wakeup config so we don't leave anything
> to chance.
> 
> Clear wakeup status on suspend so we know what caused wake up.
> 
> The LINESTATE wake up should not be enabled in device mode
> if we are not connected to a USB host else it will cause spurious
> wake up.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-am62.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> index 859b48279658..af0524e2f1e1 100644
> --- a/drivers/usb/dwc3/dwc3-am62.c
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -60,6 +60,13 @@
>  #define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
>  #define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
>  
> +#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
> +				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
> +				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
> +				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
> +
> +#define USBSS_WAKEUP_CFG_NONE	0
> +
>  /* WAKEUP STAT register bits */
>  #define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
>  #define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
> @@ -103,6 +110,7 @@ struct dwc3_data {
>  	struct regmap *syscon;
>  	unsigned int offset;
>  	unsigned int vbus_divider;
> +	u32 wakeup_stat;
>  };
>  
>  static const int dwc3_ti_rate_table[] = {	/* in KHZ */
> @@ -294,6 +302,7 @@ static int dwc3_ti_suspend_common(struct device *dev)
>  {
>  	struct dwc3_data *data = dev_get_drvdata(dev);
>  	u32 reg, current_prtcap_dir;
> +	u32 vbus_stat;
>  
>  	if (device_may_wakeup(dev)) {
>  		reg = dwc3_ti_readl(data, USBSS_CORE_STAT);
> @@ -302,12 +311,20 @@ static int dwc3_ti_suspend_common(struct device *dev)
>  		/* Set wakeup config enable bits */
>  		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
>  		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
> -			reg |= USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
> +			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
>  		} else {
> -			reg |= USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
> -			       USBSS_WAKEUP_CFG_VBUSVALID_EN;
> +			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
> +			/*
> +			 * Enable LINESTATE wake up only if connected to bus else
> +			 * it causes spurious wake-up.
> +			 */
> +			vbus_stat = dwc3_ti_readl(data, USBSS_VBUS_STAT);
> +			if (vbus_stat & (USBSS_VBUS_STAT_SESSVALID | USBSS_VBUS_STAT_VBUSVALID))
> +				reg |= USBSS_WAKEUP_CFG_LINESTATE_EN;

There is one corner case where a spurious wake-up still happens.
i.e. If we are not in USB_SUSPEND state while entering SoC sleep.

So looks like we need to check if we are in USB SUSPEND before enabling
LINESTATE wakeup enable.

>  		}
>  		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
> +		/* clear wakeup status so we know what caused the wake up */
> +		dwc3_ti_writel(data, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
>  	}
>  
>  	clk_disable_unprepare(data->usb2_refclk);
> @@ -324,16 +341,11 @@ static int dwc3_ti_resume_common(struct device *dev)
>  
>  	if (device_may_wakeup(dev)) {
>  		/* Clear wakeup config enable bits */
> -		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
> -		reg &= ~(USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
> -			 USBSS_WAKEUP_CFG_VBUSVALID_EN);
> -		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
> +		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
>  	}
>  
>  	reg = dwc3_ti_readl(data, USBSS_WAKEUP_STAT);
> -	/* Clear the wakeup status with wakeup clear bit */
> -	reg |= USBSS_WAKEUP_STAT_CLR;
> -	dwc3_ti_writel(data, USBSS_WAKEUP_STAT, reg);
> +	data->wakeup_stat = reg;
>  
>  	return 0;
>  }

cheers,
-roger
