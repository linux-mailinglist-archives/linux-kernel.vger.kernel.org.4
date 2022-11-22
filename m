Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE606334EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiKVF40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiKVF4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:56:05 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AC62654E;
        Mon, 21 Nov 2022 21:55:32 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 73B0B24DCA6;
        Tue, 22 Nov 2022 13:55:29 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 13:55:29 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 13:55:28 +0800
Message-ID: <62d63104-e392-b002-717d-682193d21c27@starfivetech.com>
Date:   Tue, 22 Nov 2022 13:55:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 13/14] reset: starfive: Add StarFive JH7110 reset
 driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-14-hal.feng@starfivetech.com>
 <CAJM55Z8Vfoi5bPLNUOX-F5R5hfwg_20HiGLyjcmziYMiz24xBQ@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z8Vfoi5bPLNUOX-F5R5hfwg_20HiGLyjcmziYMiz24xBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 01:14:50 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
>> new file mode 100644
>> index 000000000000..00f3b4ecfb02
>> --- /dev/null
>> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Reset driver for the StarFive JH7110 SoC
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Copyright (C) 2022 Hal Feng <hal.feng@starfivetech.com>
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +
>> +#include "reset-starfive-jh71x0.h"
>> +
>> +#include <dt-bindings/reset/starfive-jh7110.h>
>> +
>> +static int jh7110_reset_probe(struct auxiliary_device *adev,
>> +                             const struct auxiliary_device_id *id)
>> +{
>> +       struct reset_info *info = (struct reset_info *)(id->driver_data);
>> +       void __iomem *base = dev_get_drvdata(adev->dev.parent);
>> +
>> +       if (!info || !base)
>> +               return -ENODEV;
>> +
>> +       return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
>> +                                             base + info->assert_offset,
>> +                                             base + info->status_offset,
>> +                                             info->asserted,
>> +                                             info->nr_resets,
>> +                                             false);
>> +}
>> +
>> +static const struct reset_info jh7110_sys_info = {
>> +       .nr_resets = JH7110_SYSRST_END,
>> +       .assert_offset = 0x2F8,
>> +       .status_offset = 0x308,
>> +       .asserted = NULL,
>> +};
>> +
>> +static const struct reset_info jh7110_aon_info = {
>> +       .nr_resets = JH7110_AONRST_END,
>> +       .assert_offset = 0x38,
>> +       .status_offset = 0x3C,
>> +       .asserted = NULL,
>> +};
> 
> It doesn't seem like syscrg, aoncrg or stgcrg have any inverted lines.
> Do you know if any other CRGs do? If not you can just leave out the
> .asserted member and always pass NULL.

All JH7110 CRGs don't have inverted lines, and it could be modified as
what you said.

> 
>> +static const struct auxiliary_device_id jh7110_reset_ids[] = {
>> +       {
>> +               .name = "clk_starfive_jh71x0.reset-sys",
>> +               .driver_data = (kernel_ulong_t)&jh7110_sys_info,
>> +       },
>> +       {
>> +               .name = "clk_starfive_jh71x0.reset-aon",
>> +               .driver_data = (kernel_ulong_t)&jh7110_aon_info,
>> +       },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, jh7110_reset_ids);
>> +
>> +static struct auxiliary_driver jh7110_reset_driver = {
>> +       .probe          = jh7110_reset_probe,
>> +       .id_table       = jh7110_reset_ids,
>> +};
>> +module_auxiliary_driver(jh7110_reset_driver);
>> +
>> +MODULE_DESCRIPTION("StarFive JH7110 Reset Driver");
>> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
>> index e6b27110de48..63a94ee1b395 100644
>> --- a/drivers/reset/starfive/reset-starfive-jh71x0.h
>> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
>> @@ -6,6 +6,13 @@
>>  #ifndef __RESET_STARFIVE_JH71X0_H
>>  #define __RESET_STARFIVE_JH71X0_H
>>
>> +struct reset_info {
>> +       unsigned int nr_resets;
>> +       unsigned int assert_offset;
>> +       unsigned int status_offset;
>> +       const u32 *asserted;
>> +};
> 
> This struct isn't used outside of reset-starfive-jh7110.c, so no need
> to define it in this header.
> Also consider calling it jh7110_reset_info so it blends in with the
> functions defined in that file.

Maybe it can be used in JH7100 audio reset?

Best regards,
Hal

> 
>>  int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
>>                                    void __iomem *assert, void __iomem *status,
>>                                    const u32 *asserted, unsigned int nr_resets,
