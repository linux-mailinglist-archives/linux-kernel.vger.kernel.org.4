Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E864774A5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjGFVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGFVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:13:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08919A7;
        Thu,  6 Jul 2023 14:13:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 366LCiYc031415;
        Thu, 6 Jul 2023 16:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688677964;
        bh=n1W53TeQDe5JDCf7UtyqlAcHmKtsABgVqfo1mFuklQc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xTREQGBcMBf3NLvztHSFWf8W8ieUtzsm3JJMAO+L9NTMlBIzMwpRkB+Z7QHKwil1R
         2ptXWyL/9WUHfr9DUMHPtUoRtPtqMRuLKud6HSdR3PGMApF/7Axfy+iUZeclJkjaR8
         2rkXK40iuyiOVacKm5VkV/UBVpIauPVDu+gMlQ9Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 366LCiob031221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jul 2023 16:12:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jul 2023 16:12:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jul 2023 16:12:43 -0500
Received: from [128.247.81.105] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 366LChjb027967;
        Thu, 6 Jul 2023 16:12:43 -0500
Message-ID: <aaf12da2-fbe4-eb30-81de-1c4ee41c2d4b@ti.com>
Date:   Thu, 6 Jul 2023 16:12:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] can: m_can: Add hrtimer to generate software
 interrupt
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
References: <20230705195356.866774-1-jm@ti.com>
 <20230705195356.866774-3-jm@ti.com>
 <20230706-unstopped-skedaddle-7168f2b12189-mkl@pengutronix.de>
 <0ba17779-9cd9-6cb2-a79c-6b14b73a42db@ti.com>
 <ZKciVy4juK55OUrG@francesco-nb.int.toradex.com>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <ZKciVy4juK55OUrG@francesco-nb.int.toradex.com>
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

Hi,

On 7/6/23 3:21 PM, Francesco Dolcini wrote:
> On Thu, Jul 06, 2023 at 10:20:59AM -0500, Judith Mendez wrote:
>> Hi Marc
>>
>> On 7/6/23 2:25 AM, Marc Kleine-Budde wrote:
>>> On 05.07.2023 14:53:56, Judith Mendez wrote:
>>>> Introduce timer polling method to MCAN since some SoCs may not
>>>> have M_CAN interrupt routed to A53 Linux and do not have
>>>> interrupt property in device tree M_CAN node.
>>>>
>>>> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
>>>> routed to A53 Linux, instead they will use timer polling method.
>>>>
>>>> Add an hrtimer to MCAN class device. Each MCAN will have its own
>>>> hrtimer instantiated if there is no hardware interrupt found in
>>>> device tree M_CAN node. The timer will generate a software
>>>> interrupt every 1 ms. In hrtimer callback, we check if there is
>>>> a transaction pending by reading a register, then process by
>>>> calling the isr if there is.
>>>>
>>>> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Verdin AM62
>>>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
> 
> ...
> 
>>>> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
>>>> index 94dc82644113..76d11ce38220 100644
>>>> --- a/drivers/net/can/m_can/m_can_platform.c
>>>> +++ b/drivers/net/can/m_can/m_can_platform.c
>>>> @@ -5,6 +5,7 @@
>>>>    //
>>>>    // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>>>> +#include <linux/hrtimer.h>
>>>>    #include <linux/phy/phy.h>
>>>>    #include <linux/platform_device.h>
>>>> @@ -96,12 +97,28 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>>>    		goto probe_fail;
>>>
>>> Please set "irq" to 0 during declaration.
>>
>> During declaration of irq, it is already set to 0:
>>
>> int irq, ret = 0;
> 
> The initialization here applies only to ret.
> 
> int irq = 0, ret = 0;

Understood, thanks!

> 
>>>>    	addr = devm_platform_ioremap_resource_byname(pdev, "m_can");
>>>> -	irq = platform_get_irq_byname(pdev, "int0");
>>>> -	if (IS_ERR(addr) || irq < 0) {
>>>> -		ret = -EINVAL;
>>>> +	if (IS_ERR(addr)) {
>>>> +		ret = PTR_ERR(addr);
>>>>    		goto probe_fail;
>>>>    	}
>>>> +	if (device_property_present(mcan_class->dev, "interrupts") ||
>>>> +	    device_property_present(mcan_class->dev, "interrupt-names")) {
>>>> +		irq = platform_get_irq_byname(pdev, "int0");
>>>> +		if (irq == -EPROBE_DEFER) {
>>>> +			ret = -EPROBE_DEFER;
>>>> +			goto probe_fail;
>>>> +		}
>>>> +		if (irq < 0) {
>>>> +			ret = -EINVAL;
>>>
>>> Please return the original error value.
>>
>> The original value returned is -EINVAL:
>>
>> -	if (IS_ERR(addr) || irq < 0) {
>> -		ret = -EINVAL;
>>
>> Perhaps I am missing something here?
> 
> if (irq < 0) {
> 	ret = irq;
> 	...
> }
> 
> And you can also get rid of the explicit test for -EPROBE_DEFER this
> way simplifying the code.

I misunderstood, thanks!!

~ Judith
