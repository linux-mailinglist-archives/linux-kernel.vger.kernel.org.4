Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0725BFC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIUKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiIUKOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:14:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA28E9352A;
        Wed, 21 Sep 2022 03:14:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E9313D5;
        Wed, 21 Sep 2022 03:14:20 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71CA13F73D;
        Wed, 21 Sep 2022 03:14:11 -0700 (PDT)
Message-ID: <567e9e6c-e34c-4ded-9622-9ad8387dd24b@arm.com>
Date:   Wed, 21 Sep 2022 11:14:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
 <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
 <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-21 10:26, Krzysztof Kozlowski wrote:
> On 21/09/2022 11:20, Lad, Prabhakar wrote:
>>>
>>> What do you mean? Macros support string concatenation and simple
>>> arithmetic like adding numbers. I just tested it.
>>>
>> I did try the below:
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> index 689aa4ba416b..0f923c276cd3 100644
>> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> @@ -8,6 +8,8 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/r9a07g043-cpg.h>
>>
>> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr na
>> +
>>   / {
>>       compatible = "renesas,r9a07g043";
>>       #address-cells = <2>;
>> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>>               compatible = "renesas,r9a07g043-ssi",
>>                        "renesas,rz-ssi";
>>               reg = <0 0x1004a000 0 0x400>;
>> -            interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>> +            interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
>>                        <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
>>                        <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
>>
>> This worked as expected, but couldn't get the arithmetic operation
>> working. Could you please provide an example?
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> index ff6aab388eb7..0ecca775fa3f 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -8,6 +8,8 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/r9a07g043-cpg.h>
>   
> +#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)
>   / {
>          compatible = "renesas,r9a07g043";
>          #address-cells = <2>;
> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>                          compatible = "renesas,r9a07g043-ssi",
>                                       "renesas,rz-ssi";
>                          reg = <0 0x1004a000 0 0x400>;
> -                       interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +                       interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
> 
> 
> 
> Or any other method like that....

Which will generate the text:

	"interrupts = <GIC_SPI 330 (IRQ_TYPE_LEVEL_HIGH + 32)>,"

(give or take some whitespace)

CPP supports constant expressions in #if and #elif directives, but 
macros are purely literal text replacement. It might technically be 
achievable with some insane CPP metaprogramming, but for all practical 
purposes this is a non-starter unless dtc itself grows the ability to 
process arithmetic expressions.

Thanks,
Robin.
