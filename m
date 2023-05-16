Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895567053E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjEPQbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEPQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:30:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9155A6;
        Tue, 16 May 2023 09:30:07 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GGTwMA064586;
        Tue, 16 May 2023 11:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684254599;
        bh=q4p/q6fKRi0HDifLb9cFkQsbiK2S5lYUgZu+peL5kcA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=drCu5VTDWOTTHmhQRPnxHBrwDiod4y1OqHZDrbUBHwVozWmOCeyRqGQVSw/EIUNHG
         paj4oY4b7fIlMq2VSfUaXKyqkVJPe1EkjPWJW0YuoKxDtzuzriXIuF2h5Y+5TXCPsq
         TA4uAt8CSWcgP2TfozGFc3QjRE9P2rnGvZk37lF8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GGTwcM030637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 11:29:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 11:29:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 11:29:58 -0500
Received: from [10.250.35.184] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GGTwpO065903;
        Tue, 16 May 2023 11:29:58 -0500
Message-ID: <558ebfaf-bd7e-1760-5799-8ed430acad7a@ti.com>
Date:   Tue, 16 May 2023 11:29:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
 <13c1f6ea-63b5-9667-18a2-705829c46437@axentia.se>
 <895c84f5-4a3c-fd2c-2b43-1a1996862e15@ti.com>
 <7d73a37f-80b7-b623-1b71-fa19bf379713@linaro.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <7d73a37f-80b7-b623-1b71-fa19bf379713@linaro.org>
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

On 5/16/23 11:19 AM, Krzysztof Kozlowski wrote:
> On 16/05/2023 17:18, Andrew Davis wrote:
>> On 5/15/23 4:14 PM, Peter Rosin wrote:
>>> Hi!
>>>
>>> 2023-05-15 at 21:19, Andrew Davis wrote:
>>>> The DT binding for the reg-mux compatible states it can be used when the
>>>> "parent device of mux controller is not syscon device". It also allows
>>>> for a reg property. When the parent device is indeed not a syscon device,
>>>> nor is it a regmap provider, we should fallback to using that reg
>>>> property to identify the address space to use for this mux.
>>>
>>> We should? Says who?
>>>
>>> Don't get me wrong, I'm not saying the change is bad or wrong, I would just
>>> like to see an example where it matters. Or, at least some rationale for why
>>> the code needs to change other than covering some case that looks like it
>>> could/should be possible based on the binding. I.e., why is it not better to
>>> "close the hole" in the binding instead?
>>>
>>
>> Sure, so this all stated when I was building a checker to make sure that drivers
>> are not mapping overlapping register spaces. I noticed syscon nodes are a source
>> of that so I'm trying to look into their usage.
>>
>> To start, IHMO there is only one valid use for syscon and that is when more than
>> one driver needs to access shared bits in a single register. DT has no way to
> 
> It has... what about all existing efuse/nvmem devices?
> 
>> describe down to the bit granular level, so one must give that register to
>> a "syscon node", then have the device node use a phandle to the syscon node:
>>
>> common_reg: syscon@10000 {
>> 	compatible = "syscon";
>> 	reg = <0x10000 0x4>;
>> };
>>
>> consumer@1 {
>> 	syscon-efuse = <&common_reg 0x1>;
>> };
>>
>> consumer@2 {
>> 	syscon-efuse = <&common_reg 0x2>;
>> };
>>
>> Something like that, then regmap will take care of synchronizing access.
> 
> Syscon is not for this.
> 

That is how it is used today, and in 5 other ways too and there is
no guidance on it. Let me know what syscon is for then.

>>
> 
> ...
> 
>>
>> Ideally DT nodes all describe their register space in a "reg"
>> property and all the "large collection of devices" spaces become
>> "simple-bus" nodes. "syscon" nodes can then be limited to only the
>> rare case when multiple devices share bits in a single register.
>>
>> If Rob and Krzysztof agree I can send a patch with the above
>> guidance to the Devicetree Specification repo also.
> 
> Agree on what?
> 

That we should provide the above guidance on when and how to use syscon
nodes. Right now it is a free for all and it is causing issues.

Andrew

> 
> Best regards,
> Krzysztof
> 
