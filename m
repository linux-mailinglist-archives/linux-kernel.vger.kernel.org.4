Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3561909A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKDF6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiKDF5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:57:46 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D70C5FA2;
        Thu,  3 Nov 2022 22:57:42 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Nov 2022 14:57:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 4696E2059027;
        Fri,  4 Nov 2022 14:57:41 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 4 Nov 2022 14:57:41 +0900
Received: from [10.212.159.130] (unknown [10.212.159.130])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 75251B62A4;
        Fri,  4 Nov 2022 14:57:40 +0900 (JST)
Subject: Re: [PATCH 4/4] arm64: dts: uniphier: Add NX1 SoC and boards support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
 <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
 <a05535bc-ba18-0296-b387-d2c9c759d6f2@linaro.org>
 <54206dca-0583-88c0-9924-a80dfaf0ba94@socionext.com>
 <f1b5e138-e708-8aeb-9b59-96403f996fbd@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <3e0a7894-677d-33fc-6b3c-a7561e18a93b@socionext.com>
Date:   Fri, 4 Nov 2022 14:57:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f1b5e138-e708-8aeb-9b59-96403f996fbd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/03 1:48, Krzysztof Kozlowski wrote:
> On 01/11/2022 05:02, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
> 
> 
>>>> +				compatible = "socionext,uniphier-nx1-clock";
>>>> +				#clock-cells = <1>;
>>>> +			};
>>>> +
>>>> +			sys_rst: reset {
>>>
>>> reset-controller
>>>
>>>> +				compatible = "socionext,uniphier-nx1-reset";
>>>> +				#reset-cells = <1>;
>>>> +			};
>>>> +
>>>> +			watchdog {
>>>> +				compatible = "socionext,uniphier-wdt";
>>>> +			};
>>>> +
>>>> +			pvtctl: thermal-sensor {
>>>> +				compatible = "socionext,uniphier-nx1-thermal";
>>>> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>>>> +				#thermal-sensor-cells = <0>;
>>>> +				socionext,tmod-calibration = <0x0f22 0x68ee>;
>>>> +			};
>>>> +		};
>>>> +
>>>> +		spi0: spi@14006000 {
>>>> +			compatible = "socionext,uniphier-scssi";
>>>> +			status = "disabled";
>>>> +			reg = <0x14006000 0x100>;
>>>
>>> Reg is second property. Status goes last. The same in other nodes.
>>
>> Hmm, I've put "status" here according to the existing (uniphier's) DT
>> policy
>> and this should rewrite the policy. Is there documentation somewhere that
>> recommends the order? Or, should I refer to previous comments?
> 
> Hm, your decision (as arch maintainer) is then preferred, not mine.
> Although it is quite unusual to find status, not reg, as the second
> property.

Okay, however, if there are no examples where the second is "status",
I think it is better to follow the many descriptions for new additions.

> compatible followed by reg is not documented anywhere, it's just the
> most used style. And actually most sensible as it answers to questions
> from highest importance to lowest:
> 1. What is this device? compatible
> 2. Where is it? Does it match unit address? reg
> 3. all other properties
> 4. Is it off or on? status as optional property

I think it is reasonable to arrange the properties in order of importance.
I'll put "reg" second in this addition in the next.

Thank you,

---
Best Regards
Kunihiko Hayashi
