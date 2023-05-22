Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A170C229
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjEVPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjEVPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:18:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42543BB;
        Mon, 22 May 2023 08:18:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34MFHc9K072745;
        Mon, 22 May 2023 10:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684768658;
        bh=VulXzECh78KJhnSArOUyVchGW3xPms9BERDoN3K5Ls0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Tq+e/pYjfFxmlsRY7LpcwjdcVduvSYvgtGBvti5HeFjy7Fbk+lbdsx0becACnaA8H
         ts13cqcDCli+aesM3rAwS8vRvexMiz955p4UGG6TOuKZ+iQfaAj0GBD/beVMa5zn82
         3kx55JseS2PCKmg5Am6/z6eLFCpvrCg85cKBe3bg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34MFHcfY123686
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 May 2023 10:17:38 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 May 2023 10:17:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 May 2023 10:17:38 -0500
Received: from [128.247.81.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34MFHcgD013731;
        Mon, 22 May 2023 10:17:38 -0500
Message-ID: <3859166d-fc78-f42d-1553-282e4140325a@ti.com>
Date:   Mon, 22 May 2023 10:17:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/2] can: m_can: Add hrtimer to generate software
 interrupt
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230518193613.15185-1-jm@ti.com>
 <20230518193613.15185-3-jm@ti.com>
 <20230519-morbidity-directory-dbe704584aa3-mkl@pengutronix.de>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20230519-morbidity-directory-dbe704584aa3-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On 5/19/23 2:16 AM, Marc Kleine-Budde wrote:
> On 18.05.2023 14:36:13, Judith Mendez wrote:
>> Add an hrtimer to MCAN class device. Each MCAN will have its own
>> hrtimer instantiated if there is no hardware interrupt found and
>> poll-interval property is defined in device tree M_CAN node.
>>
>> The hrtimer will generate a software interrupt every 1 ms. In
>> hrtimer callback, we check if there is a transaction pending by
>> reading a register, then process by calling the isr if there is.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
> 
> [...]

Missed this poll-interval, thanks.

> 
>> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
>> index 94dc82644113..3e60cebd9d12 100644
>> --- a/drivers/net/can/m_can/m_can_platform.c
>> +++ b/drivers/net/can/m_can/m_can_platform.c
>> @@ -5,6 +5,7 @@
>>   //
>>   // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>>   
>> +#include <linux/hrtimer.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>>   
>> @@ -96,12 +97,40 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>   		goto probe_fail;
>>   
>>   	addr = devm_platform_ioremap_resource_byname(pdev, "m_can");
>> -	irq = platform_get_irq_byname(pdev, "int0");
>> -	if (IS_ERR(addr) || irq < 0) {
>> -		ret = -EINVAL;
>> +	if (IS_ERR(addr)) {
>> +		ret = PTR_ERR(addr);
>>   		goto probe_fail;
>>   	}
>>   
> 
> As we don't use an explicit "poll-interval" anymore, this needs some
> cleanup. The flow should be (pseudo code, error handling omitted):
> 
> if (device_property_present("interrupts") {
>          platform_get_irq_byname();
>          polling = false;
> } else {
>          hrtimer_init();
>          polling = true;
> }

Ok.

> 
>> +	irq = platform_get_irq_byname_optional(pdev, "int0");
> 
> Remove the "_optional" and....

On V2, you asked to add the _optional?.....

 >  	irq = platform_get_irq_byname(pdev, "int0");

use platform_get_irq_byname_optional(), it doesn't print an error
message.

> 
>> +	if (irq == -EPROBE_DEFER) {
>> +		ret = -EPROBE_DEFER;
>> +		goto probe_fail;
>> +	}
>> +
>> +	if (device_property_present(mcan_class->dev, "interrupts") ||
>> +	    device_property_present(mcan_class->dev, "interrupt-names"))
>> +		mcan_class->polling = false;
> 
> ...move the platform_get_irq_byname() here

ok,

> 
>> +	else
>> +		mcan_class->polling = true;
>> +
>> +	if (!mcan_class->polling && irq < 0) {
>> +		ret = -ENXIO;
>> +		dev_err_probe(mcan_class->dev, ret, "IRQ int0 not found, polling not activated\n");
>> +		goto probe_fail;
>> +	}
> 
> Remove this check.

Should we not go to 'probe fail' if polling is not activated and irq is 
not found?

> 
>> +
>> +	if (mcan_class->polling) {
>> +		if (irq > 0) {
>> +			mcan_class->polling = false;
>> +			dev_info(mcan_class->dev, "Polling enabled, using hardware IRQ\n");
> 
> Remove this.

Remove the dev_info?

> 
>> +		} else {
>> +			dev_dbg(mcan_class->dev, "Polling enabled, initialize hrtimer");
>> +			hrtimer_init(&mcan_class->hrtimer, CLOCK_MONOTONIC,
>> +				     HRTIMER_MODE_REL_PINNED);
> 
> move this backwards, where you set "polling = true"

ok,
> 
>> +		}
>> +	}
>> +
>>   	/* message ram could be shared */
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
>>   	if (!res) {
>> -- 
>> 2.17.1

- judith
