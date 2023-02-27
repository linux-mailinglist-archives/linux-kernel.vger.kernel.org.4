Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA6A6A363B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0BrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0BrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:47:21 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B5126D3;
        Sun, 26 Feb 2023 17:47:16 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id F35EC24E205;
        Mon, 27 Feb 2023 09:47:07 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 09:47:07 +0800
Received: from [192.168.125.128] (113.72.145.171) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 09:47:06 +0800
Message-ID: <0a1f48b4-8bba-afed-dd08-4d2c3d69cdb6@starfivetech.com>
Date:   Mon, 27 Feb 2023 09:47:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <CA6686A1-2336-442F-8C7B-7D8EFEEE1940@kernel.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CA6686A1-2336-442F-8C7B-7D8EFEEE1940@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/26 22:33, Conor Dooley wrote:
> 
> 
> On 26 February 2023 14:14:25 GMT, Emil Renner Berthing <emil.renner.berthing@canonical.com> wrote:
>>On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>>
>>> Add watchdog driver for the StarFive JH7110 SoC.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>>  MAINTAINERS                     |   7 +
>>>  drivers/watchdog/Kconfig        |   9 +
>>>  drivers/watchdog/Makefile       |   2 +
>>>  drivers/watchdog/starfive-wdt.c | 651 ++++++++++++++++++++++++++++++++
>>>  4 files changed, 669 insertions(+)
>>>  create mode 100644 drivers/watchdog/starfive-wdt.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 135d93368d36..6cbcf08fa76a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19933,6 +19933,13 @@ F:     Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>>>  F:     drivers/reset/reset-starfive-jh7100.c
>>>  F:     include/dt-bindings/reset/starfive-jh7100.h
>>>
>>> +STARFIVE JH7110 WATCHDOG DRIVER
>>> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
>>> +M:     Samin Guo <samin.guo@starfivetech.com>
>>> +S:     Supported
>>> +F:     Documentation/devicetree/bindings/watchdog/starfive*
>>> +F:     drivers/watchdog/starfive-wdt.c
>>> +
>>>  STATIC BRANCH/CALL
>>>  M:     Peter Zijlstra <peterz@infradead.org>
>>>  M:     Josh Poimboeuf <jpoimboe@kernel.org>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 0bc40b763b06..4608eb5c9501 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -2089,6 +2089,15 @@ config UML_WATCHDOG
>>>         tristate "UML watchdog"
>>>         depends on UML || COMPILE_TEST
>>>
>>> +config STARFIVE_WATCHDOG
>>> +       tristate "StarFive Watchdog support"
>>> +       depends on RISCV
>>
>>Let's do like the pinctrl and clock drivers and
>>
>>    depends SOC_STARFIVE || COMPILE_TEST
> 
> Or better yet, rebase on 6.3-rc1, and use ARCH_STARFIVE and save me a conversion!
> 

Will modify this.

Best regards,
Xingyu Wu
