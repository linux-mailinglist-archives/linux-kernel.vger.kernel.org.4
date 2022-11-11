Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB49E6255B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiKKIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKIs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:48:56 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C466A77E;
        Fri, 11 Nov 2022 00:48:54 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Nov 2022 17:48:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 4ECE42059027;
        Fri, 11 Nov 2022 17:48:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 17:48:54 +0900
Received: from [10.212.156.100] (unknown [10.212.156.100])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 63B18B62AE;
        Fri, 11 Nov 2022 17:48:53 +0900 (JST)
Message-ID: <afdb63d2-217b-1ed5-3398-3e610bce8ecb@socionext.com>
Date:   Fri, 11 Nov 2022 17:48:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/5] arm64: dts: uniphier: Add NX1 SoC and boards
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-6-hayashi.kunihiko@socionext.com>
 <f8f83839-2e76-e500-a16e-5fd2985a278d@linaro.org>
 <df21cfca-67ed-0c78-7f1e-13e321edabe1@socionext.com>
 <a1e4a039-3b65-2f2b-2196-340cc754b1c1@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <a1e4a039-3b65-2f2b-2196-340cc754b1c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/09 0:11, Krzysztof Kozlowski wrote:
> On 08/11/2022 15:30, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
>> On 2022/11/08 20:13, Krzysztof Kozlowski wrote:
>>> On 07/11/2022 11:34, Kunihiko Hayashi wrote:
>>>> Initial version of devicetree sources for NX1 SoC and boards.
>>>>
>>>> NX1 SoC belongs to the UniPhier armv8 architecture platform, and is
>>>> designed for IoT and AI/ML application fields.
>>>>
>>>
>>>> +
>>>> +		soc_glue: syscon@1f800000 {
>>>> +			compatible = "socionext,uniphier-nx1-soc-glue",
>>>> +				     "simple-mfd", "syscon";
>>>> +			reg = <0x1f800000 0x2000>;
>>>> +
>>>> +			pinctrl: pinctrl {
>>>> +				compatible = "socionext,uniphier-nx1-pinctrl";
>>>
>>> So instead of documenting the hardware precisily, you have one big bag
>>> for everything under simple-mfd. This is not how the SoC should be
>>> described in DTS.
>>
>> Sorry I don't understand. This is inherited from the previous
>> descriptions,
>> but is there some example to express DTS correctly about that?
> 
> I think yes, although it actually depends what is this hardware.
> Generally speaking, do not use simple-mfd and syscon when these are not
> really simple devices. There are quite many in your DTS, which got my
> attention. Instead - have regular device with or without children.
> 
> There is no real need to have this a simple-mfd with one children
> without any resources (no address space, no clocks, no interrupts, nothing).
> 
> Why this syscon/mfd and pinctrl is not a regular, one device?

The mfd/syscon.yaml says:
   System controller node represents a register region containing a set
   of miscellaneous registers.

The "soc-glue" is exactly this, it contains various register functions
and might be referred to the drivers.

For example in this NX1 dts, ethernet node points to "soc-glue" node.

     eth: ethernet@15000000 {
         compatible = "socionext,uniphier-nx1-ave4";
         ...
         socionext,syscon-phy-mode = <&soc_glue 0>;
     };

Since such register region is not often systematically designed,
it is tough to cut out as specific memory region for "pinctrl".

And more, the existing pinctrl driver uses of_get_parent() and
syscon_node_to_regmap(), so this change breaks compatibility.

>>>> +			};
>>>> +		};
>>>> +
>>>> +		soc-glue@1f900000 {
>>>> +			compatible = "simple-mfd";
>>>
>>> No, it is not allowed on its own. You need a specific compatible and
>>> bindings describing its children.
>>
>> I saw the definition of "simple-mfd" itself is only in mfd/mfd.txt.
>>
>> Currently there are only efuse devices as children, and this space means
>> nothing. I think it had better define the devices directly.
> 
> You need to start describe the hardware. efuse is an efuse, not MFD.
> pinctrl is pinctrl not MFD + pinctrl.

This region also has multiple functions, though, the efuse might be
cut out as specific region without "simple-mfd", unlike pinctrl.

Thank you,

---
Best Regards
Kunihiko Hayashi
