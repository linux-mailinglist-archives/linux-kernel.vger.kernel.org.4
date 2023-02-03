Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17C4689015
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBCHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBCHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:05:11 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F08FB5B;
        Thu,  2 Feb 2023 23:04:51 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 281A924E1EC;
        Fri,  3 Feb 2023 15:04:48 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 15:04:48 +0800
Received: from [192.168.125.110] (113.72.144.84) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 15:04:47 +0800
Message-ID: <7c6583eb-2c03-a584-1faf-8cbd44674175@starfivetech.com>
Date:   Fri, 3 Feb 2023 15:04:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 4/5] pinctrl: starfive: Add StarFive JH7110 sys
 controller driver
Content-Language: en-US
To:     Andreas Schwab <schwab@suse.de>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005529.34744-1-hal.feng@starfivetech.com>
 <20221220005529.34744-5-hal.feng@starfivetech.com> <mvm4js6zthr.fsf@suse.de>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <mvm4js6zthr.fsf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.84]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 15:08:48 +0100, Andreas Schwab wrote:
> On Dez 20 2022, Hal Feng wrote:
> 
>> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
>> new file mode 100644
>> index 000000000000..85df9d0ae1de
>> --- /dev/null
>> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
>> @@ -0,0 +1,979 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Pinctrl / GPIO driver for StarFive JH7110 SoC
>> + *
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/io.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <linux/pinctrl/pinctrl.h>
>> +#include <linux/pinctrl/pinmux.h>
>> +
>> +#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
>> +
>> +#include "../core.h"
>> +#include "../pinctrl-utils.h"
>> +#include "../pinmux.h"
>> +#include "../pinconf.h"
>> +#include "pinctrl-starfive-jh7110.h"
> 
> This misses a couple of headers, see commit 042b93c9b666.
> 
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: In function 'jh7110_pin_dbg_show':
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:100:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
>   100 |         seq_printf(s, "%s", dev_name(pctldev->dev));
>       |         ^~~~~~~~~~
>       |         bstr_printf
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: At top level:
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:538:21: error: variable 'jh7110_pinconf_ops' has initializer but incomplete type
>   538 | static const struct pinconf_ops jh7110_pinconf_ops = {
>       |                     ^~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:539:10: error: 'const struct pinconf_ops' has no member named 'pin_config_get'
>   539 |         .pin_config_get         = jh7110_pinconf_get,
>       |          ^~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:539:35: warning: excess elements in struct initializer
>   539 |         .pin_config_get         = jh7110_pinconf_get,
>       |                                   ^~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:539:35: note: (near initialization for 'jh7110_pinconf_ops')
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:540:10: error: 'const struct pinconf_ops' has no member named 'pin_config_group_get'
>   540 |         .pin_config_group_get   = jh7110_pinconf_group_get,
>       |          ^~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:540:35: warning: excess elements in struct initializer
>   540 |         .pin_config_group_get   = jh7110_pinconf_group_get,
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:540:35: note: (near initialization for 'jh7110_pinconf_ops')
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:541:10: error: 'const struct pinconf_ops' has no member named 'pin_config_group_set'
>   541 |         .pin_config_group_set   = jh7110_pinconf_group_set,
>       |          ^~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:541:35: warning: excess elements in struct initializer
>   541 |         .pin_config_group_set   = jh7110_pinconf_group_set,
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:541:35: note: (near initialization for 'jh7110_pinconf_ops')
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:542:10: error: 'const struct pinconf_ops' has no member named 'pin_config_dbg_show'
>   542 |         .pin_config_dbg_show    = jh7110_pinconf_dbg_show,
>       |          ^~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:542:35: warning: excess elements in struct initializer
>   542 |         .pin_config_dbg_show    = jh7110_pinconf_dbg_show,
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:542:35: note: (near initialization for 'jh7110_pinconf_ops')
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:543:10: error: 'const struct pinconf_ops' has no member named 'is_generic'
>   543 |         .is_generic             = true,
>       |          ^~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:543:35: warning: excess elements in struct initializer
>   543 |         .is_generic             = true,
>       |                                   ^~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:543:35: note: (near initialization for 'jh7110_pinconf_ops')
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: In function 'jh7110_gpio_request':
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:548:16: error: implicit declaration of function 'pinctrl_gpio_request' [-Werror=implicit-function-declaration]
>   548 |         return pinctrl_gpio_request(gc->base + gpio);
>       |                ^~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: In function 'jh7110_gpio_free':
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:553:9: error: implicit declaration of function 'pinctrl_gpio_free' [-Werror=implicit-function-declaration]
>   553 |         pinctrl_gpio_free(gc->base + gpio);
>       |         ^~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: At top level:
> ../drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c:538:33: error: storage size of 'jh7110_pinconf_ops' isn't known
>   538 | static const struct pinconf_ops jh7110_pinconf_ops = {
>       |                                 ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[4]: *** [../scripts/Makefile.build:253: drivers/pinctrl/starfive/pinctrl-starfive-jh7110.o] Error 1

Will add the missing headers. Thanks for your feedback.

Best regards,
Hal
