Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328627058FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjEPUh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEPUhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:37:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5112118;
        Tue, 16 May 2023 13:37:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GKbh9q125127;
        Tue, 16 May 2023 15:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684269463;
        bh=23jWeIzwjHXS053lTFKWVYf5LEtJvgXIpAiMY2rLlAc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HEYfmCAr/8CzStpM8REQNxNAZD1k7NeKE/JgIJoHy4IbF0yZRi+pqNp3kL4wkJdRq
         wxIS6UZA9lGZcUI6lVdgLhVYjB8sE2DBwajBZiZYKRPYBbDIG2+PFJjflRG9AWu2oC
         YaPQFtw5AYVjJUKZ1xVlIoBZ2DzoFya5HA5yCCn0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GKbhL3026662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 15:37:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 15:37:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 15:37:43 -0500
Received: from [10.250.35.184] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GKbgCm010402;
        Tue, 16 May 2023 15:37:42 -0500
Message-ID: <68457fec-f947-553f-af51-8c15c4199145@ti.com>
Date:   Tue, 16 May 2023 15:37:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515191909.611241-1-afd@ti.com>
 <21429720-e27f-bf26-64e7-ace1186da31b@linaro.org>
 <367e0b47-eb36-c169-7f4f-c004c6f5ac84@linaro.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <367e0b47-eb36-c169-7f4f-c004c6f5ac84@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 1:44 PM, Krzysztof Kozlowski wrote:
> On 16/05/2023 20:37, Krzysztof Kozlowski wrote:
>> On 15/05/2023 21:19, Andrew Davis wrote:
>>> The DT binding for the reg-mux compatible states it can be used when the
>>> "parent device of mux controller is not syscon device". It also allows
>>> for a reg property. When the parent device is indeed not a syscon device,
>>> nor is it a regmap provider, we should fallback to using that reg
>>> property to identify the address space to use for this mux.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   drivers/mux/mmio.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
>>> index 44a7a0e885b8..42e00b9fd0a9 100644
>>> --- a/drivers/mux/mmio.c
>>> +++ b/drivers/mux/mmio.c
>>> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>>>   	int ret;
>>>   	int i;
>>>   
>>> -	if (of_device_is_compatible(np, "mmio-mux"))
>>> +	if (of_device_is_compatible(np, "mmio-mux")) {
>>>   		regmap = syscon_node_to_regmap(np->parent);
>>> -	else
>>> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>>> +	} else {
>>> +		regmap = dev_get_regmap(dev->parent, NULL);
>>> +		if (!regmap)
>>> +			regmap = device_node_to_regmap(np) ?: ERR_PTR(-ENODEV);
>>
>> Unless I miss something obvious, the original code is simply bogus and
>> wrong. I would like to give here Rb tag... but maybe I miss something
>> obvious. Why mux cannot be a device with MMIO itself? Binding allows it
>> which would be perfectly proper description of hardware.
> 
> OK, I see now original binding and it did not allow 'reg' property, thus
> binding was matching driver. Commit 9b358af7c818 ("dt-bindings: mux:
> Convert mux controller bindings to schema") introduced reg, which is
> reasonable.
> 
> The driver change is reasonable as well - we should not need syscon
> parent... however, I think the code should be different. If reg is
> present you should use it first. If reg is missing, use parent. This
> solves the case when node with reg will be put inside something else
> which has regmap, but should not be used for reg-mux.
> 

Makes sense to me. I didn't do that to begin with to keep the
functionality the same, but I don't see any users of this with both
"reg" and a parent with regmap today. Will flip the logic for v2.

Thanks,
Andrew

> Best regards,
> Krzysztof
> 
