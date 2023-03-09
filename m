Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304C86B2077
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCIJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjCIJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:43:59 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C9D7C0C;
        Thu,  9 Mar 2023 01:43:45 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 20B8824E231;
        Thu,  9 Mar 2023 17:43:44 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 17:43:44 +0800
Received: from [192.168.125.124] (183.27.96.115) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 17:43:43 +0800
Message-ID: <49ab1072-98ba-f364-9b66-68658566e732@starfivetech.com>
Date:   Thu, 9 Mar 2023 17:43:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 12/19] clk: starfive: Add StarFive JH7110 always-on
 clock driver
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-13-hal.feng@starfivetech.com>
 <CAJM55Z8H4qmy_BiD0SHW-w5ifzhzokdO-QxpUUz9aeUd+htrZg@mail.gmail.com>
 <8c30220a-abef-7518-cb44-abcea91408e2@starfivetech.com>
In-Reply-To: <8c30220a-abef-7518-cb44-abcea91408e2@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 10:42:35 +0800, Hal Feng wrote:
> On Sun, 26 Feb 2023 18:34:52 +0100, Emil Renner Berthing wrote:
>> On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>>
>>> Add driver for the StarFive JH7110 always-on clock controller
>>> and register an auxiliary device for always-on reset controller
>>> which is named as "reset-aon".
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> ---
>>>  drivers/clk/starfive/Kconfig                  |  11 ++
>>>  drivers/clk/starfive/Makefile                 |   1 +
>>>  .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++++++++++++++++
>>>  3 files changed, 168 insertions(+)
>>>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
>>>
>>> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
>>> index 4640d0665d1c..2aa664f2cdee 100644
>>> --- a/drivers/clk/starfive/Kconfig
>>> +++ b/drivers/clk/starfive/Kconfig
>>> @@ -31,3 +31,14 @@ config CLK_STARFIVE_JH7110_SYS
>>>         help
>>>           Say yes here to support the system clock controller on the
>>>           StarFive JH7110 SoC.
>>> +
>>> +config CLK_STARFIVE_JH7110_AON
>>> +       tristate "StarFive JH7110 always-on clock support"
>>> +       depends on CLK_STARFIVE_JH7110_SYS
>>> +       select AUXILIARY_BUS
>>> +       select CLK_STARFIVE_JH71X0
>>> +       select RESET_STARFIVE_JH7110
>>> +       default CLK_STARFIVE_JH7110_SYS
>> 
>> As far as I can tell the JH7110 boots fine without this driver and it
>> already depends on the _SYS driver above, so please do
>> 
>> default m if SOC_STARFIVE
> 
> OK. Will fix it.

Hi, Emil,

The AON clock driver provides clocks for gmac0 which is used frequently.
So I think it would be more convenient if we set "default y" here.

Best regards,
Hal
