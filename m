Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5006A63351C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiKVGMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiKVGMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:12:51 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06E15806;
        Mon, 21 Nov 2022 22:12:47 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E55F624E0AC;
        Tue, 22 Nov 2022 14:12:44 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 14:12:44 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 14:12:44 +0800
Message-ID: <fdcb8ddd-f68b-0f01-9cce-ad61d47a3b7d@starfivetech.com>
Date:   Tue, 22 Nov 2022 14:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 14/14] clk: starfive: jh71x0: Don't register aux
 devices if JH7110 reset is disabled
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
 <20221118010627.70576-15-hal.feng@starfivetech.com>
 <CAJM55Z8t8yotMTWVw2J7gtGMyx5no2onj-YcfB6d1BY0ACeDJg@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z8t8yotMTWVw2J7gtGMyx5no2onj-YcfB6d1BY0ACeDJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 01:18:18 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> The JH7110 clock drivers will not register redundant auxiliary
>> devices if the JH7110 reset auxiliary driver is disabled.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  drivers/clk/starfive/clk-starfive-jh71x0.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
>> index dda19c6937cb..4e69f56b00cc 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
>> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
>> @@ -333,7 +333,7 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
>>  }
>>  EXPORT_SYMBOL_GPL(starfive_jh71x0_clk_ops);
>>
>> -#if IS_ENABLED(CONFIG_CLK_STARFIVE_JH7110_SYS)
>> +#if IS_ENABLED(CONFIG_RESET_STARFIVE_JH7110)
> 
> I don't see any reason you'd want to build a kernel that needs the
> clock driver but not the resets, so I don't think this is something we
> should optimize for. I'd just drop this patch and let such broken
> kernels register the auxiliary devices even when no reset driver is
> there to use them.

You're right. I made this patch just following the style of jh7100.
And I think it's better to select RESET_STARFIVE_JH7110 in config
CLK_STARFIVE_JH7110_SYS.

Best regards,
Hal

> 
>>  static void jh7110_reset_unregister_adev(void *_adev)
>>  {
>> @@ -384,4 +384,13 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>>  }
>>  EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
>>
>> +#else /* !CONFIG_RESET_STARFIVE_JH7110 */
>> +
>> +int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>> +                                    const char *adev_name,
>> +                                    u32 adev_id)
>> +{
>> +       return 0;
>> +}
>> +
>>  #endif

