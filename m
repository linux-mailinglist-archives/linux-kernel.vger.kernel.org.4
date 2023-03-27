Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C386CA204
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC0LEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjC0LEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:04:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE574483;
        Mon, 27 Mar 2023 04:04:11 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 606B524E114;
        Mon, 27 Mar 2023 19:04:04 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Mar
 2023 19:04:04 +0800
Received: from [192.168.125.108] (113.72.145.117) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Mar
 2023 19:04:03 +0800
Message-ID: <20774e11-b7d4-e895-13f1-ea6dad130e4e@starfivetech.com>
Date:   Mon, 27 Mar 2023 19:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/5] usb: cdns3: add StarFive JH7110 USB driver.
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-5-minda.chen@starfivetech.com>
 <2c99725a0bf259203a5b00f4c752eeb1b6596f59.camel@pengutronix.de>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <2c99725a0bf259203a5b00f4c752eeb1b6596f59.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.117]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/23 17:29, Philipp Zabel wrote:
> On Mi, 2023-03-15 at 18:44 +0800, Minda Chen wrote:
>> There is a Cadence USB3 core for JH7110 SoCs, the cdns
>> core is the child of this USB wrapper module device.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
> [...]
>> diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
>> new file mode 100644
>> index 000000000000..a99f98f85235
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-starfive.c
>> @@ -0,0 +1,305 @@
> [...]
>> +static int cdns_clk_rst_init(struct cdns_starfive *data)
>> +{
>> +	int ret;
>> +
>> +	data->num_clks = devm_clk_bulk_get_all(data->dev, &data->clks);
>> +	if (data->num_clks < 0)
>> +		return dev_err_probe(data->dev, -ENODEV,
>> +			"Failed to get clocks\n");
>> +
>> +	ret = clk_bulk_prepare_enable(data->num_clks, data->clks);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +			"failed to enable clocks\n");
> 
> In general, it's better to acquire all resources first and only then
> start interacting with them, and to order all devm_ calls before non-
> devm calls to make sure cleanup is done in reverse order.
> 
> In this case you can switch clk_bulk_prepare_enable() with
> devm_reset_control_array_get_exclusive() and simplify the error path.
> 
OK, thanks
>> +	data->resets = devm_reset_control_array_get_exclusive(data->dev);
>> +	if (IS_ERR(data->resets)) {
>> +		ret = dev_err_probe(data->dev, PTR_ERR(data->resets),
>> +			"Failed to get resets");
>> +		goto err_clk_init;
>> +	}
>> +
>> +	ret = reset_control_deassert(data->resets);
>> +	if (ret) {
>> +		ret = dev_err_probe(data->dev, ret,
>> +			"failed to reset clocks\n");
>> +		goto err_clk_init;
>> +	}
>> +
>> +	return ret;
>> +
>> +err_clk_init:
>> +	clk_bulk_disable_unprepare(data->num_clks, data->clks);
>> +	return ret;
>> +}
> 
> regards
> Philipp
