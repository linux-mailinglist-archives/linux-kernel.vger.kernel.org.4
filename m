Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4646DF88F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjDLOdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDLOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:33:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA747ED1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:32:51 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pmbWS-0001es-VB; Wed, 12 Apr 2023 16:32:33 +0200
Message-ID: <6953b608-973f-c603-f852-edf7ba183e64@pengutronix.de>
Date:   Wed, 12 Apr 2023 16:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Content-Language: en-US, de-DE
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        jun.li@nxp.com, haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
 <20230405112118.1256151-2-j.zink@pengutronix.de>
 <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
 <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
 <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
 <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
 <20230412133921.GA2017891-robh@kernel.org>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20230412133921.GA2017891-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/12/23 15:39, Rob Herring wrote:
> On Tue, Apr 11, 2023 at 04:22:37PM +0200, Johannes Zink wrote:
>> Hi Krzystof,
>>
>> thank you for your explanations. As I'm still quite new to writing
>> bindings, I still have some questions:
>>
>> On Fri, 2023-04-07 at 11:03 +0200, Krzysztof Kozlowski wrote:
>>> On 05/04/2023 14:14, Johannes Zink wrote:
>>>> Hi Krysztof,
>>>>
>>>> thanks for your review, please find my questions below.
>>>>
>>>> On Wed, 2023-04-05 at 13:51 +0200, Krzysztof Kozlowski wrote:
>>>>> [snip]
>>>>>>         A phandle to the regulator for USB VBUS.
>>>>>>   
>>>>>> +  fsl,phy-tx-vref-tune:
>>>>>> +    description:
>>>>>> +      HS DC Voltage level adjustment
>>>>>
>>>>> "Level" in what units?
>>>>>
>>>>
>>>> The datasheet just shows percent, ranging from -6 to +24%, in 2%
>>>> increments. What unit would you suggest?
>>>
>>> percent
>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>
>> I am still a bit confused how to use this properly. How can I restrict
>> the values to multiples of 2 in order to avoid illegal values?
>>
>> At the moment the only thing I could come up with is something like
>>
>> fsl,phy-tx-vref-tune-percent:
>>    description: |
>>      Adjusts the high-speed DC level voltage
>>    $ref: /schemas/types.yaml#/definitions/int32
> 
> Note that with standard unit suffixes, you don't need a type.
> 
>>    minimum: -6
>>    maximum: 24
>>    default: 0
>>
>> Does something like this work? I am not quite sure if I am on the right
>> track here, especially as this requires a signed int, of which I have
>> not seen many examples so far.
> 
> We'd have to change the type for -percent to signed. That's possible,
> but for vendor specific properties there's not much advantage to use
> standard units instead of just using the register values directly.
> 

I don't have any objections to that, this is pretty much what I sent in 
my v1 patch <20230405112118.1256151-2-j.zink@pengutronix.de>, but 
Krzysztof requested to change the vendor specific properties to use 
property-units.

Would something along the lines of the st,trim-hs-current on 
Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml be 
acceptable (i.e. use an enum and annotate the meaning of the values in 
the description)?

I will, nevertheless, try to make the descriptions a bit more verbose in 
my v2 (wherever the datasheet gives me proper informations), as 
Krzysztof requested.

Best regards
Johannes

> Rob
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

