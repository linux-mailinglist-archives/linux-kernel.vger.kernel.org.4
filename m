Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B56B1A08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCIDjG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Mar 2023 22:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCIDjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:39:04 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6511A48A;
        Wed,  8 Mar 2023 19:38:59 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 42F1624E06F;
        Thu,  9 Mar 2023 11:38:57 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 11:38:57 +0800
Received: from [192.168.125.128] (183.27.96.115) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 11:38:55 +0800
Message-ID: <23e38b7a-69fd-f7a8-4948-6d44bea1caf2@starfivetech.com>
Date:   Thu, 9 Mar 2023 11:38:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/3] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-3-xingyu.wu@starfivetech.com>
 <CAJM55Z9LvQZjeEY92bZETBYhp9sSavTNkKT4T-gpsHPTQ2_LAA@mail.gmail.com>
 <0b467896-17d4-c355-da86-437b45f089d4@roeck-us.net>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <0b467896-17d4-c355-da86-437b45f089d4@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/8 23:17, Guenter Roeck wrote:
> On 3/8/23 07:07, Emil Renner Berthing wrote:
>> On Wed, 8 Mar 2023 at 04:43, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>>
>>> Add watchdog driver for the StarFive JH7100 and JH7110 SoC.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>
>> Hi Xingyu,
>>
>> Thanks for adding the JH7100 support. I tried it on my Starlight board
>> and it seems to work fine except systemd complains about not being
>> able to set a 10min timeout on reboot:
>> systemd-shutdown[1]: Using hardware watchdog 'StarFive Watchdog',
>> version 0, device /dev/watchdog0
>> systemd-shutdown[1]: Failed to set timeout to 10min: Invalid argument
>> systemd-shutdown[1]: Syncing filesystems and block devices.
>> systemd-shutdown[1]: Sending SIGTERM to remaining processes...
>>
>> The systemd runtime watchdog seems to work, so I guess this is just
>> because 10min is too long a timeout for the StarFive watchdog.
>>
> 
> Correct, the driver would have to be implemented slightly differently
> for the watchdog subsystem to accept larger timeout values.
> 

Oh, this watchdog is a 32 bit counter and the core clock rate is 24MHz.
Computational formula: 0xffffffff / 24000000 = 178
So it's the max timeout is 178 seconds almost just 2 minutes.
And JH7110 watchdog has two timeout phases and the max timeout is 356 seconds.
So it would be failed to set 10 minutes to reboot and this is limited by hardware.


>> More comments below.
>>
>>> ---
>>>   MAINTAINERS                     |   7 +
>>>   drivers/watchdog/Kconfig        |   9 +
>>>   drivers/watchdog/Makefile       |   2 +
>>>   drivers/watchdog/starfive-wdt.c | 675 ++++++++++++++++++++++++++++++++
>>>   4 files changed, 693 insertions(+)
>>>   create mode 100644 drivers/watchdog/starfive-wdt.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8d5bc223f305..721d0e4e8a0d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19962,6 +19962,13 @@ S:     Supported
>>>   F:     Documentation/devicetree/bindings/rng/starfive*
>>>   F:     drivers/char/hw_random/jh7110-trng.c
>>>
>>> +STARFIVE WATCHDOG DRIVER
>>> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
>>> +M:     Samin Guo <samin.guo@starfivetech.com>
>>> +S:     Supported
>>> +F:     Documentation/devicetree/bindings/watchdog/starfive*
>>> +F:     drivers/watchdog/starfive-wdt.c
>>> +
>>>   STATIC BRANCH/CALL
>>>   M:     Peter Zijlstra <peterz@infradead.org>
>>>   M:     Josh Poimboeuf <jpoimboe@kernel.org>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index f0872970daf9..9d825ffaf292 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -2090,6 +2090,15 @@ config UML_WATCHDOG
>>>          tristate "UML watchdog"
>>>          depends on UML || COMPILE_TEST
>>>
>>> +config STARFIVE_WATCHDOG
>>> +       tristate "StarFive Watchdog support"
>>> +       depends on ARCH_STARFIVE || COMPILE_TEST
>>> +       select WATCHDOG_CORE
>>> +       default ARCH_STARFIVE
>>> +       help
>>> +         Say Y here to support the watchdog of StarFive JH7100 and JH7110
>>> +         SoC. This driver can also be built as a module if choose M.
>>
>> This file seems to be sorted by architecture, so you probably want to
>> add something like this at the appropriate place
>>
>> # RISC-V Architecture
>>
>> config STARFIVE_WATCHDOG
>> ...
>>
>>
>>>   #
>>>   # ISA-based Watchdog Cards
>>>   #
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 9cbf6580f16c..4c0bd377e92a 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -211,6 +211,8 @@ obj-$(CONFIG_WATCHDOG_SUN4V)                += sun4v_wdt.o
>>>   # Xen
>>>   obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>>>
>>> +obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
>>
>> Again please follow the layout of the file. Eg. something like this at
>> the appropriate place
>>
>> # RISC-V Architecture
>> obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
>>
>>>   # Architecture Independent
>>>   obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
>>>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>>> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
>>> new file mode 100644
>>> index 000000000000..8ce9f985f068
>>> --- /dev/null
>>> +++ b/drivers/watchdog/starfive-wdt.c
>>> @@ -0,0 +1,675 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Starfive Watchdog driver
>>> + *
>>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/reset.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +/* JH7100 Watchdog register define */
>>> +#define STARFIVE_WDT_JH7100_INTSTAUS   0x000   /* RO: [4]: Watchdog Interrupt status */
>>> +#define STARFIVE_WDT_JH7100_CONTROL    0x104   /* RW: reset enable */
>>> +#define STARFIVE_WDT_JH7100_LOAD       0x108   /* RW: Watchdog Load register */
>>> +#define STARFIVE_WDT_JH7100_EN         0x110   /* RW: Watchdog Enable Register */
>>> +#define STARFIVE_WDT_JH7100_RELOAD     0x114   /* RW: Write 0 or 1 to reload preset value */
>>> +#define STARFIVE_WDT_JH7100_VALUE      0x118   /* RO: The current value for watchdog counter */
>>> +#define STARFIVE_WDT_JH7100_INTCLR     0x120   /*
>>> +                                                * RW: Watchdog Clear Interrupt Register
>>> +                                                * [0]: Write 1 to clear interrupt
>>> +                                                * [1]: 1 mean clearing and 0 mean complete
>>> +                                                */
>>> +#define STARFIVE_WDT_JH7100_LOCK       0x13c   /* RW: Lock Register, write 0x378f0765 to unlock */
>>> +
>>> +/* JH7110 Watchdog register define */
>>> +#define STARFIVE_WDT_JH7110_LOAD       0x000   /* RW: Watchdog Load register */
>>> +#define STARFIVE_WDT_JH7110_VALUE      0x004   /* RO: The current value for watchdog counter */
>>> +#define STARFIVE_WDT_JH7110_CONTROL    0x008   /*
>>> +                                                * RW:
>>> +                                                * [0]: reset enable;
>>> +                                                * [1]: int enable/wdt enable/reload counter;
>>> +                                                * [31:2]: reserved.
>>> +                                                */
>>> +#define STARFIVE_WDT_JH7110_INTCLR     0x00c   /* WO: clear intterupt && reload the counter */
>>> +#define STARFIVE_WDT_JH7110_IMS                0x014   /* RO: Enabled interrupt status from the counter */
>>> +#define STARFIVE_WDT_JH7110_LOCK       0xc00   /* RW: Lock Register, write 0x1ACCE551 to unlock */
>>
>> Since these register offsets are only used to fill in the
>> starfive_wdt_variant structures, consider just adding them directly
>> there with the comments.
>>
> 
> As maintainer, I prefer defines, even if only used oonce.
> 

So I will put some generic comments to fill in the structure,
and leave some special and different register comments here.
Is that OK?

Best regards,
Xingyu Wu

