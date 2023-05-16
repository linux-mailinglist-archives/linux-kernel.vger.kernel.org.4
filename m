Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329027051EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjEPPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjEPPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:18:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FB40E8;
        Tue, 16 May 2023 08:18:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GFI3Sb033412;
        Tue, 16 May 2023 10:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684250283;
        bh=UbUu4epEpJqM+mgfcMP6uajWlBTsDzn2pXsdVgLPZb8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IB+qiRh689H0WN7a81On+d84dgLC2wkQnMcBoG5VjGUMCTgQpvUkjkiJ5dUNINiLE
         WWfcNNfBHJ6+9hOrxHlQlIyuXXsEemhs+XCqRs8bZle/HuaqhaUzn+0uogBOrN8cS/
         2fG8bE4iHXPn6GCR5pzM1h3kgF5AKHluJTppyIj0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GFI3Z1039485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 10:18:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 10:18:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 10:18:02 -0500
Received: from [10.250.35.184] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GFI252058644;
        Tue, 16 May 2023 10:18:02 -0500
Message-ID: <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
Date:   Tue, 16 May 2023 10:18:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515191909.611241-1-afd@ti.com>
 <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
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

On 5/15/23 4:14 PM, Peter Rosin wrote:
> Hi!
> 
> 2023-05-15 at 21:19, Andrew Davis wrote:
>> The DT binding for the reg-mux compatible states it can be used when the
>> "parent device of mux controller is not syscon device". It also allows
>> for a reg property. When the parent device is indeed not a syscon device,
>> nor is it a regmap provider, we should fallback to using that reg
>> property to identify the address space to use for this mux.
> 
> We should? Says who?
> 
> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
> like to see an example where it matters. Or, at least some rationale for why
> the code needs to change other than covering some case that looks like it
> could/should be possible based on the binding. I.e., why is it not better to
> "close the hole" in the binding instead?
> 

Sure, so this all stated when I was building a checker to make sure that drivers
are not mapping overlapping register spaces. I noticed syscon nodes are a source
of that so I'm trying to look into their usage.

To start, IHMO there is only one valid use for syscon and that is when more than
one driver needs to access shared bits in a single register. DT has no way to
describe down to the bit granular level, so one must give that register to
a "syscon node", then have the device node use a phandle to the syscon node:

common_reg: syscon@10000 {
	compatible = "syscon";
	reg = <0x10000 0x4>;
};

consumer@1 {
	syscon-efuse = <&common_reg 0x1>;
};

consumer@2 {
	syscon-efuse = <&common_reg 0x2>;
};

Something like that, then regmap will take care of synchronizing access.

Unfortunately I see lots of syscon anti-patterns in use today. First
type is mapping an entire multi-device space into one big syscon node,
then having all the device nodes live on the top level and simply
point into the syscon node. This does not follow the normal DT
structure and hides the true memory map.

large_collection_of_devices: syscon@10000 {
	compatible = "syscon", "simple-mfd";
	reg = <0x10000 0x4000000>;

	some-device-inside@12000 {
		reg = <0x12000 0x400>;
	};
};

some-device-outside {
	hacky_syscon_pointer = <&large_collection_of_devices 0x8000>;
};

An example of the inside-device would be "ti,am654-chipid", this
is a simple device, sometimes placed as a child of syscon node
and sometimes not. It does not use the syscon parent either
way, and so when placed as a child there ends up two mappings to
the same memory resources. Not a huge problem, but it could be
avoided by removing the overuse of syscon.

Another case is "ti,am654-phy-gmii-sel" which depends on the
parent being a syscon node, but uses the "reg" property to
only define the offset into that space. This isn't necessarily
wrong, but it does contrast with the devices that make their
own regmap, in which case one needs to have the parent syscon
node contain "ranges" to do the translation, this is the more
idiomatic way to use "reg" properies.

"ti,am64-epwm-tbclk" is yet another type of use. It marks
itself as a "syscon" node, just to make use of the helper
syscon_node_to_regmap(). Using it on itself to get a regmap
without all the otherwise required regmap setup (which I like
the idea of having all the info needed to setup a regmap for
a given node handled in DT, but again, inconsistent).

For more examples feel free to scan for "ti,keystone-dsp-gpio"
or  "pinctrl-single" in K3 devices for more syscon oddness.


So what causes this and what is my solution? I believe the
root cause is in devices that force the parent node to be
a syscon node. This then forces that devices' parent to
be a syscon node even when that doesn't make sense in that
given case. "mmio-mux" is one such driver. Luckily we have
"reg-mux" which is the same, but according to the binding,
does not need the parent to be a syscon node, perfect,
let's use that here, not "close the hole" in the binding :)

The issue is that it still does require the parent to be a
regmap provider, and that is what this patch fixes. With
this we can start the cleanup, in fact we already have
patches in-flight that require this patch[0].

Ideally DT nodes all describe their register space in a "reg"
property and all the "large collection of devices" spaces become
"simple-bus" nodes. "syscon" nodes can then be limited to only the
rare case when multiple devices share bits in a single register.

If Rob and Krzysztof agree I can send a patch with the above
guidance to the Devicetree Specification repo also.

Andrew

[0] https://lore.kernel.org/lkml/20230513123313.11462-4-vaishnav.a@ti.com/T/

> Cheers,
> Peter
> 
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/mux/mmio.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
>> index 44a7a0e885b8..42e00b9fd0a9 100644
>> --- a/drivers/mux/mmio.c
>> +++ b/drivers/mux/mmio.c
>> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>>   	int ret;
>>   	int i;
>>   
>> -	if (of_device_is_compatible(np, "mmio-mux"))
>> +	if (of_device_is_compatible(np, "mmio-mux")) {
>>   		regmap = syscon_node_to_regmap(np->parent);
>> -	else
>> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>> +	} else {
>> +		regmap = dev_get_regmap(dev->parent, NULL);
>> +		if (!regmap)
>> +			regmap = device_node_to_regmap(np) ?: ERR_PTR(-ENODEV);
>> +	}
>>   	if (IS_ERR(regmap)) {
>>   		ret = PTR_ERR(regmap);
>>   		dev_err(dev, "failed to get regmap: %d\n", ret);
