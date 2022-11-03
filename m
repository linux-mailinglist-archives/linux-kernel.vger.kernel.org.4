Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3125E61776E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKCHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKCHOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:14:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949ABB03
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:14:41 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qUQtofbR69RnzqUQtoOzUF; Thu, 03 Nov 2022 08:14:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Nov 2022 08:14:39 +0100
X-ME-IP: 86.243.100.34
Message-ID: <997182bc-f3de-71df-f241-dc6f52662f04@wanadoo.fr>
Date:   Thu, 3 Nov 2022 08:14:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 1/2] clocksource: loongson2_hpet: add hpet driver
 support
To:     zhuyinbo@loongson.cn
References: <20221103065351.32603-1-zhuyinbo@loongson.cn>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     chenhuacai@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, jiaxun.yang@flygoat.com,
        kernel@xen0n.name, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, liuyun@loongson.cn,
        loongarch@lists.linux.dev, lvjianmin@loongson.cn,
        robh+dt@kernel.org, tglx@linutronix.de, yang.lee@linux.alibaba.com
In-Reply-To: <20221103065351.32603-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2022 à 07:53, Yinbo Zhu a écrit :
> HPET (High Precision Event Timer) defines a new set of timers, which
> are used by the operating system to schedule threads, interrupt the
> kernel and interrupt the multimedia timer server. The operating
> system can assign different timers to different applications. By
> configuration, each timer can generate interrupt independently.
> 
> The Loongson-2 HPET module includes a main count and three comparators,
> all of which are 32 bits wide. Among the three comparators, only
> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
> ---

[...]

Hi, a few nits below.

> +static int hpet_request_irq(struct clock_event_device *cd)
> +{
> +	unsigned long flags = IRQD_NO_BALANCING | IRQF_TIMER;
> +
> +	if (request_irq(cd->irq, hpet_irq_handler, flags, "hpet", NULL)) {
> +		pr_err("Failed to register hpet interrupt\n");

Maybe s/register/request/ ?

> +		return -1;
> +	}
> +
> +	disable_irq(cd->irq);
> +	irq_set_affinity(cd->irq, cd->cpumask);
> +	enable_irq(cd->irq);
> +
> +	return 0;
> +}
> +

[...]

> +static int __init loongson2_hpet_init(struct device_node *np)
> +{
> +	int ret;
> +	struct clk *clk;
> +
> +	hpet_mmio_base = of_iomap(np, 0);
> +	if (!hpet_mmio_base) {
> +		pr_err("hpet: unable to map loongson2 hpet registers\n");
> +		goto err;

'ret' is un-initialised at this point, and of_iomap() has failed, so 
there is no need to undo it in the error handling path.

> +	}
> +
> +	ret = -EINVAL;

Could be done at declataion, a few lines above.

> +	hpet_t0_irq = irq_of_parse_and_map(np, 0);
> +	if (hpet_t0_irq <= 0) {
> +		pr_err("hpet: unable to get IRQ from DT, %d\n", hpet_t0_irq);
> +		goto err;
> +	}
> +
> +	clk = of_clk_get(np, 0);
> +	if (!IS_ERR(clk)) {
> +		hpet_freq = clk_get_rate(clk);
> +		clk_put(clk);
> +	} else
> +		goto err;

Test for:
	if (IS_ERR(clk))
		goto err;

and keep :
	hpet_freq = clk_get_rate(clk);
	clk_put(clk);

with less indentation in the normal path?

CJ

> +
> +	hpet_irq_flags = HPET_TN_LEVEL;
> +
> +	loongson2_hpet_clocksource_init();
> +
> +	loongson2_hpet_clockevent_init();
> +
> +	return 0;
> +
> +err:
> +	iounmap(hpet_mmio_base);
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(loongson2_hpet, "loongson,ls2k-hpet", loongson2_hpet_init);

