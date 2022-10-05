Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF15F5666
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJEO2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJEO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:28:45 -0400
X-Greylist: delayed 2389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Oct 2022 07:28:41 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5863FF4;
        Wed,  5 Oct 2022 07:28:41 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1og4lM-00A4pc-UQ; Wed, 05 Oct 2022 14:48:42 +0100
Message-ID: <4d8a199b-f22a-a421-aae4-64e538cb97f4@codethink.co.uk>
Date:   Wed, 5 Oct 2022 14:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 05/30] soc: sifive: l2 cache: Convert to platform
 driver
Content-Language: en-GB
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Ben Dooks <ben.dooks@sifive.com>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
 <40d0abb6-88dc-d315-f768-27a623f60986@sifive.com>
 <CAJM55Z-PzvM_-_6jTWX+Jyy2FQ3TJdh4uYj0evpktnEENHL6WA@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAJM55Z-PzvM_-_6jTWX+Jyy2FQ3TJdh4uYj0evpktnEENHL6WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2022 14:44, Emil Renner Berthing wrote:
> On Thu, 29 Sept 2022 at 19:59, Ben Dooks <ben.dooks@sifive.com> wrote:
>>
>> On 29/09/2022 15:32, Hal Feng wrote:
>>> From: Emil Renner Berthing <kernel@esmil.dk>
>>>
>>> This converts the driver to use the builtin_platform_driver_probe macro
>>> to initialize the driver. This macro ends up calling device_initcall as
>>> was used previously, but also allocates a platform device which gives us
>>> access to much nicer APIs such as platform_ioremap_resource,
>>> platform_get_irq and dev_err_probe.
>>
>> This is useful, but also there are other changes currently being sorted
>> out by Zong Li (cc'd into this message) which have already been reviewed
>> and are hopefully queued for the next kernel release.
>>
>>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>>> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> 
> I'm ok with something like this being merged, but please note that if
> we ever want to support the JH7100 which uses registers in this
> peripheral to flush the cache for its non-coherent DMAs then this
> driver needs to be loaded before other peripherals or we will trigger
> the 2nd warning in arch/riscv/mm/dma-noncoherent.c. I'm not sure we
> can do that when it's a platform driver. See this patch for an
> alternative to support the JH71x0s:
> https://github.com/esmil/linux/commit/9c5b29da56ae29159c9572c5bb195fe3a1b535c5
> 
> /Emil

Are you replying to your own patch that does the conversion to
platform driver and then saying that it could actually cause
issues?

I'm all for dropping this for the moment and keeping the old
early init for the ccache.


>>>    drivers/soc/sifive/sifive_l2_cache.c | 79 ++++++++++++++--------------
>>>    1 file changed, 40 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
>>> index 59640a1d0b28..010d612f7420 100644
>>> --- a/drivers/soc/sifive/sifive_l2_cache.c
>>> +++ b/drivers/soc/sifive/sifive_l2_cache.c
>>> @@ -7,9 +7,9 @@
>>>     */
>>>    #include <linux/debugfs.h>
>>>    #include <linux/interrupt.h>
>>> -#include <linux/of_irq.h>
>>> -#include <linux/of_address.h>
>>> -#include <linux/device.h>
>>> +#include <linux/io.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/platform_device.h>
>>>    #include <asm/cacheinfo.h>
>>>    #include <soc/sifive/sifive_l2_cache.h>
>>>
>>> @@ -96,12 +96,6 @@ static void l2_config_read(void)
>>>        pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
>>>    }
>>>
>>> -static const struct of_device_id sifive_l2_ids[] = {
>>> -     { .compatible = "sifive,fu540-c000-ccache" },
>>> -     { .compatible = "sifive,fu740-c000-ccache" },
>>> -     { /* end of table */ },
>>> -};
>>> -
>>>    static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
>>>
>>>    int register_sifive_l2_error_notifier(struct notifier_block *nb)
>>> @@ -192,36 +186,29 @@ static irqreturn_t l2_int_handler(int irq, void *device)
>>>        return IRQ_HANDLED;
>>>    }
>>>
>>> -static int __init sifive_l2_init(void)
>>> +static int __init sifive_l2_probe(struct platform_device *pdev)
>>>    {
>>> -     struct device_node *np;
>>> -     struct resource res;
>>> -     int i, rc, intr_num;
>>> -
>>> -     np = of_find_matching_node(NULL, sifive_l2_ids);
>>> -     if (!np)
>>> -             return -ENODEV;
>>> -
>>> -     if (of_address_to_resource(np, 0, &res))
>>> -             return -ENODEV;
>>> -
>>> -     l2_base = ioremap(res.start, resource_size(&res));
>>> -     if (!l2_base)
>>> -             return -ENOMEM;
>>> -
>>> -     intr_num = of_property_count_u32_elems(np, "interrupts");
>>> -     if (!intr_num) {
>>> -             pr_err("L2CACHE: no interrupts property\n");
>>> -             return -ENODEV;
>>> -     }
>>> -
>>> -     for (i = 0; i < intr_num; i++) {
>>> -             g_irq[i] = irq_of_parse_and_map(np, i);
>>> -             rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
>>> -             if (rc) {
>>> -                     pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
>>> -                     return rc;
>>> -             }
>>> +     struct device *dev = &pdev->dev;
>>> +     int nirqs;
>>> +     int ret;
>>> +     int i;
>>> +
>>> +     l2_base = devm_platform_ioremap_resource(pdev, 0);
>>> +     if (IS_ERR(l2_base))
>>> +             return PTR_ERR(l2_base);
>>> +
>>> +     nirqs = platform_irq_count(pdev);
>>> +     if (nirqs <= 0)
>>> +             return dev_err_probe(dev, -ENODEV, "no interrupts\n");
>>
>> I wonder if zero irqs is an actual issue here?
>>
>>> +     for (i = 0; i < nirqs; i++) {
>>> +             g_irq[i] = platform_get_irq(pdev, i);
>>
>> I wonder if we need to keep g_irq[] around now? Is it going to be useful
>> in the future?
>>
>>> +             if (g_irq[i] < 0)
>>> +                     return g_irq[i];
>>> +
>>> +             ret = devm_request_irq(dev, g_irq[i], l2_int_handler, 0, pdev->name, NULL);
>>> +             if (ret)
>>> +                     return dev_err_probe(dev, ret, "Could not request IRQ %d\n", g_irq[i]);
>>>        }
>>>
>>>        l2_config_read();
>>> @@ -234,4 +221,18 @@ static int __init sifive_l2_init(void)
>>>    #endif
>>>        return 0;
>>>    }
>>> -device_initcall(sifive_l2_init);
>>> +
>>> +static const struct of_device_id sifive_l2_match[] = {
>>> +     { .compatible = "sifive,fu540-c000-ccache" },
>>> +     { .compatible = "sifive,fu740-c000-ccache" },
>>> +     { /* sentinel */ }
>>> +};
>>> +
>>> +static struct platform_driver sifive_l2_driver = {
>>> +     .driver = {
>>> +             .name = "sifive_l2_cache",
>>> +             .of_match_table = sifive_l2_match,
>>> +             .suppress_bind_attrs = true,
>>> +     },
>>> +};
>>> +builtin_platform_driver_probe(sifive_l2_driver, sifive_l2_probe);
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

