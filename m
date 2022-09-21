Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8815BFC52
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIUK1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIUK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:27:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F45F3ECDD;
        Wed, 21 Sep 2022 03:27:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2B5143D;
        Wed, 21 Sep 2022 03:27:28 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C259B3F73D;
        Wed, 21 Sep 2022 03:27:18 -0700 (PDT)
Message-ID: <146a749f-f4f0-c188-d6a3-1b41d88487ec@arm.com>
Date:   Wed, 21 Sep 2022 11:27:14 +0100
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
 <567e9e6c-e34c-4ded-9622-9ad8387dd24b@arm.com>
 <b49de03c-2d88-ad81-7bdb-a33e6841481e@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b49de03c-2d88-ad81-7bdb-a33e6841481e@linaro.org>
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

On 2022-09-21 11:17, Krzysztof Kozlowski wrote:
> On 21/09/2022 12:14, Robin Murphy wrote:
>>> +#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
>>> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)
>>>    / {
>>>           compatible = "renesas,r9a07g043";
>>>           #address-cells = <2>;
>>> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>>>                           compatible = "renesas,r9a07g043-ssi",
>>>                                        "renesas,rz-ssi";
>>>                           reg = <0 0x1004a000 0 0x400>;
>>> -                       interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>>> +                       interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
>>>
>>>
>>>
>>> Or any other method like that....
>>
>> Which will generate the text:
>>
>> 	"interrupts = <GIC_SPI 330 (IRQ_TYPE_LEVEL_HIGH + 32)>,"
>>
>> (give or take some whitespace)
>>
>> CPP supports constant expressions in #if and #elif directives, but
>> macros are purely literal text replacement. It might technically be
>> achievable with some insane CPP metaprogramming, but for all practical
>> purposes this is a non-starter unless dtc itself grows the ability to
>> process arithmetic expressions.
> 
> Except I put it into flags, not to IRQ number, it works, so I am not
> sure why do you call it non-starter?

Oh, it seems dtc *does* understand arithmetic already, that's what I was 
missing.

$ echo "/dts-v1/;/{foo = <(2 + 3)>;};" | dtc -Odts
/dts-v1/;

/ {
         foo = <0x05>;
};

Thanks for teaching me something new!

Robin.
