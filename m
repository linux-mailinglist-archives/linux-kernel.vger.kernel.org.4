Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB806F8DC2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjEFBub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjEFBu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:50:28 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCE3C14;
        Fri,  5 May 2023 18:50:26 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4E4ED24E1BA;
        Sat,  6 May 2023 09:50:25 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 09:50:25 +0800
Received: from [192.168.125.108] (183.27.98.219) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 6 May
 2023 09:50:24 +0800
Message-ID: <7c1a344b-38f8-23c5-f813-2670665f2a93@starfivetech.com>
Date:   Sat, 6 May 2023 09:50:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] usb: cdns3: cdns3-plat: Add clk and reset init
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230502081805.112149-1-minda.chen@starfivetech.com>
 <20230502081805.112149-3-minda.chen@starfivetech.com>
 <8bedea06-b68e-0f17-87fc-5d1317f315eb@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <8bedea06-b68e-0f17-87fc-5d1317f315eb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/4 20:45, Roger Quadros wrote:
> Hi,
> 
> On 02/05/2023 11:18, Minda Chen wrote:
>> Add gereric clk and reset init codes to Cadence USBSS
>> controller. The codes has been tested by starfive vf2
>> board.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  drivers/usb/cdns3/cdns3-plat.c | 52 ++++++++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/core.h       |  3 ++
>>  2 files changed, 55 insertions(+)
>> 
>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
>> index 2bc5d094548b..1820844c74d2 100644
>> --- a/drivers/usb/cdns3/cdns3-plat.c
>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>> @@ -12,11 +12,13 @@
>>   *         Roger Quadros <rogerq@ti.com>
>>   */
>>  
>> +#include <linux/clk.h>
>>  #include <linux/module.h>
>>  #include <linux/irq.h>
>>  #include <linux/kernel.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>>  
>>  #include "core.h"
>>  #include "gadget-export.h"
>> @@ -43,6 +45,34 @@ static void set_phy_power_off(struct cdns *cdns)
>>  	phy_power_off(cdns->usb2_phy);
>>  }
>>  
>> +static int cdns3_clk_rst_init(struct cdns *cdns)
>> +{
>> +	int ret;
>> +
>> +	if (cdns->num_clks) {
>> +		ret = clk_bulk_prepare_enable(cdns->num_clks, cdns->clks);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = reset_control_deassert(cdns->resets);
>> +	if (ret && cdns->num_clks)
>> +		goto err_clk_init;
> 
> if (ret)
> 	goto err_clk_init;
> 
>> +
>> +	return ret;
>> +
>> +err_clk_init:
>> +	clk_bulk_disable_unprepare(cdns->num_clks, cdns->clks);
> 
> if (cdns->num_clks)
> 	clk_bulk_disable_unprepare(cdns->num_clks, cdns->clks);
> 
> This way is more nicer I think.
> 
OK, thanks.
>> +	return ret;
>> +}
>> +
>> +static void cdns3_clk_rst_deinit(struct cdns *cdns)
>> +{
>> +	reset_control_assert(cdns->resets);
>> +	if (cdns->num_clks)
>> +		clk_bulk_disable_unprepare(cdns->num_clks, cdns->clks);
>> +}
>> +
>>  /**
>>   * cdns3_plat_probe - probe for cdns3 core device
>>   * @pdev: Pointer to cdns3 core platform device
>> @@ -116,6 +146,16 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>>  		cdns->wakeup_irq = 0x0;
>>  	}
>>  
>> +	ret = devm_clk_bulk_get_all(dev, &cdns->clks);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	cdns->num_clks = ret;
>> +
>> +	cdns->resets = devm_reset_control_array_get_optional_exclusive(dev);
>> +	if (IS_ERR(cdns->resets))
>> +		return PTR_ERR(cdns->resets);
>> +
>>  	cdns->usb2_phy = devm_phy_optional_get(dev, "cdns3,usb2-phy");
>>  	if (IS_ERR(cdns->usb2_phy))
>>  		return PTR_ERR(cdns->usb2_phy);
>> @@ -128,6 +168,10 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>>  	if (IS_ERR(cdns->usb3_phy))
>>  		return PTR_ERR(cdns->usb3_phy);
>>  
>> +	ret = cdns3_clk_rst_init(cdns);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = phy_init(cdns->usb3_phy);
>>  	if (ret)
>>  		goto err_phy3_init;
>> @@ -165,6 +209,7 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>>  	phy_exit(cdns->usb3_phy);
>>  err_phy3_init:
>>  	phy_exit(cdns->usb2_phy);
>> +	cdns3_clk_rst_deinit(cdns);
>>  
>>  	return ret;
>>  }
>> @@ -187,6 +232,8 @@ static int cdns3_plat_remove(struct platform_device *pdev)
>>  	set_phy_power_off(cdns);
>>  	phy_exit(cdns->usb2_phy);
>>  	phy_exit(cdns->usb3_phy);
>> +	cdns3_clk_rst_deinit(cdns);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -220,6 +267,8 @@ static int cdns3_controller_suspend(struct device *dev, pm_message_t msg)
>>  
>>  	cdns3_set_platform_suspend(cdns->dev, true, wakeup);
>>  	set_phy_power_off(cdns);
>> +	if (!PMSG_IS_AUTO(msg))
>> +		cdns3_clk_rst_deinit(cdns);
> 
> If you reset the controller here all state will be lost.
> How is it expected to work on system resume?
> 
I will delete them. This is platform codes. 
>>  	spin_lock_irqsave(&cdns->lock, flags);
>>  	cdns->in_lpm = true;
>>  	spin_unlock_irqrestore(&cdns->lock, flags);
>> @@ -237,6 +286,9 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
>>  	if (!cdns->in_lpm)
>>  		return 0;
>>  
>> +	if (!PMSG_IS_AUTO(msg))
>> +		cdns3_clk_rst_init(cdns);
>> +
>>  	if (cdns_power_is_lost(cdns)) {
>>  		phy_exit(cdns->usb2_phy);
>>  		ret = phy_init(cdns->usb2_phy);
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 2d332a788871..b894768ee485 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -111,6 +111,9 @@ struct cdns {
>>  	struct mutex			mutex;
>>  	enum usb_dr_mode		dr_mode;
>>  	struct usb_role_switch		*role_sw;
>> +	struct reset_control *resets;
>> +	struct clk_bulk_data *clks;
>> +	int num_clks;
>>  	bool				in_lpm;
>>  	bool				wakeup_pending;
>>  	struct cdns3_platform_data	*pdata;
> 
> cheers,
> -roger
