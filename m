Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB25B6F6C37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjEDMpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB7618C;
        Thu,  4 May 2023 05:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB03633F5;
        Thu,  4 May 2023 12:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFB6C4339B;
        Thu,  4 May 2023 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683204311;
        bh=gPDpwHaZLpcuwo+yeaqsdX5K3yYZqbkDzLbGHNtw1pw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RjLxLXt5ENZAg0ev79QkpNelt/7kWF6OLdvDHCxmsfT/MBEm1F1iLm+9duMLTby4P
         Gi660e14sDdDwvBAEWytKF3IJHOYEovEoKD7VZgq8o+E86waVKuo9ltMLaRA58gbWg
         PuqBlmCZwk3G62h/MI+IxERiM8OsJYsaDAWngtjH4s/451K4V1rk+BVWPnr5LF8YL2
         SR2pSWYWdSTxA5qj5ZW7cudG/Nd7iAtXU+89O0NYZYxjsP+sH0WOiXb/N6HkR5yLCh
         rMshAEc2N2n2gydOGWcid6NuOKTMcottLSHMA4Yta/FHpajGqbcjcgT99+dv5HV9cX
         C65pI45OVTykA==
Message-ID: <8bedea06-b68e-0f17-87fc-5d1317f315eb@kernel.org>
Date:   Thu, 4 May 2023 15:45:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] usb: cdns3: cdns3-plat: Add clk and reset init
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230502081805.112149-1-minda.chen@starfivetech.com>
 <20230502081805.112149-3-minda.chen@starfivetech.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230502081805.112149-3-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/05/2023 11:18, Minda Chen wrote:
> Add gereric clk and reset init codes to Cadence USBSS
> controller. The codes has been tested by starfive vf2
> board.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/usb/cdns3/cdns3-plat.c | 52 ++++++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/core.h       |  3 ++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index 2bc5d094548b..1820844c74d2 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -12,11 +12,13 @@
>   *         Roger Quadros <rogerq@ti.com>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  
>  #include "core.h"
>  #include "gadget-export.h"
> @@ -43,6 +45,34 @@ static void set_phy_power_off(struct cdns *cdns)
>  	phy_power_off(cdns->usb2_phy);
>  }
>  
> +static int cdns3_clk_rst_init(struct cdns *cdns)
> +{
> +	int ret;
> +
> +	if (cdns->num_clks) {
> +		ret = clk_bulk_prepare_enable(cdns->num_clks, cdns->clks);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = reset_control_deassert(cdns->resets);
> +	if (ret && cdns->num_clks)
> +		goto err_clk_init;

if (ret)
	goto err_clk_init;

> +
> +	return ret;
> +
> +err_clk_init:
> +	clk_bulk_disable_unprepare(cdns->num_clks, cdns->clks);

if (cdns->num_clks)
	clk_bulk_disable_unprepare(cdns->num_clks, cdns->clks);

This way is more nicer I think.

> +	return ret;
> +}
> +
> +static void cdns3_clk_rst_deinit(struct cdns *cdns)
> +{
> +	reset_control_assert(cdns->resets);
> +	if (cdns->num_clks)
> +		clk_bulk_disable_unprepare(cdns->num_clks, cdns->clks);
> +}
> +
>  /**
>   * cdns3_plat_probe - probe for cdns3 core device
>   * @pdev: Pointer to cdns3 core platform device
> @@ -116,6 +146,16 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  		cdns->wakeup_irq = 0x0;
>  	}
>  
> +	ret = devm_clk_bulk_get_all(dev, &cdns->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	cdns->num_clks = ret;
> +
> +	cdns->resets = devm_reset_control_array_get_optional_exclusive(dev);
> +	if (IS_ERR(cdns->resets))
> +		return PTR_ERR(cdns->resets);
> +
>  	cdns->usb2_phy = devm_phy_optional_get(dev, "cdns3,usb2-phy");
>  	if (IS_ERR(cdns->usb2_phy))
>  		return PTR_ERR(cdns->usb2_phy);
> @@ -128,6 +168,10 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  	if (IS_ERR(cdns->usb3_phy))
>  		return PTR_ERR(cdns->usb3_phy);
>  
> +	ret = cdns3_clk_rst_init(cdns);
> +	if (ret)
> +		return ret;
> +
>  	ret = phy_init(cdns->usb3_phy);
>  	if (ret)
>  		goto err_phy3_init;
> @@ -165,6 +209,7 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  	phy_exit(cdns->usb3_phy);
>  err_phy3_init:
>  	phy_exit(cdns->usb2_phy);
> +	cdns3_clk_rst_deinit(cdns);
>  
>  	return ret;
>  }
> @@ -187,6 +232,8 @@ static int cdns3_plat_remove(struct platform_device *pdev)
>  	set_phy_power_off(cdns);
>  	phy_exit(cdns->usb2_phy);
>  	phy_exit(cdns->usb3_phy);
> +	cdns3_clk_rst_deinit(cdns);
> +
>  	return 0;
>  }
>  
> @@ -220,6 +267,8 @@ static int cdns3_controller_suspend(struct device *dev, pm_message_t msg)
>  
>  	cdns3_set_platform_suspend(cdns->dev, true, wakeup);
>  	set_phy_power_off(cdns);
> +	if (!PMSG_IS_AUTO(msg))
> +		cdns3_clk_rst_deinit(cdns);

If you reset the controller here all state will be lost.
How is it expected to work on system resume?

>  	spin_lock_irqsave(&cdns->lock, flags);
>  	cdns->in_lpm = true;
>  	spin_unlock_irqrestore(&cdns->lock, flags);
> @@ -237,6 +286,9 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
>  	if (!cdns->in_lpm)
>  		return 0;
>  
> +	if (!PMSG_IS_AUTO(msg))
> +		cdns3_clk_rst_init(cdns);
> +
>  	if (cdns_power_is_lost(cdns)) {
>  		phy_exit(cdns->usb2_phy);
>  		ret = phy_init(cdns->usb2_phy);
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 2d332a788871..b894768ee485 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -111,6 +111,9 @@ struct cdns {
>  	struct mutex			mutex;
>  	enum usb_dr_mode		dr_mode;
>  	struct usb_role_switch		*role_sw;
> +	struct reset_control *resets;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
>  	bool				in_lpm;
>  	bool				wakeup_pending;
>  	struct cdns3_platform_data	*pdata;

cheers,
-roger
