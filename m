Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543FC617B90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKCLds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCLdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:33:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E92C272E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:33:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qYTZoLdYwnj75qYTZogmIz; Thu, 03 Nov 2022 12:33:41 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Nov 2022 12:33:41 +0100
X-ME-IP: 86.243.100.34
Message-ID: <3dd246b0-ead3-e1e8-8700-22d68fc82042@wanadoo.fr>
Date:   Thu, 3 Nov 2022 12:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v9 1/2] clocksource: loongson2_hpet: add hpet driver
 support
Content-Language: fr
To:     zhuyinbo@loongson.cn
References: <20221103095403.6856-1-zhuyinbo@loongson.cn>
Cc:     chenhuacai@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, jiaxun.yang@flygoat.com,
        kernel@xen0n.name, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, liuyun@loongson.cn,
        loongarch@lists.linux.dev, lvjianmin@loongson.cn,
        robh+dt@kernel.org, tglx@linutronix.de, yang.lee@linux.alibaba.com
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221103095403.6856-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2022 à 10:54, Yinbo Zhu a écrit :
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

> +static int __init loongson2_hpet_init(struct device_node *np)
> +{
> +	struct clk *clk;
> +	int ret = -EINVAL;
> +
> +	hpet_mmio_base = of_iomap(np, 0);
> +	if (!hpet_mmio_base) {
> +		pr_err("hpet: unable to map loongson2 hpet registers\n");
> +		goto err;

Hi,

It looks odd to iounmap() after a failed of_iomap().
It is maybe fine on your arch, but still looks odd.

CJ

> +	}
> +
> +	hpet_t0_irq = irq_of_parse_and_map(np, 0);
> +	if (hpet_t0_irq <= 0) {
> +		pr_err("hpet: unable to get IRQ from DT, %d\n", hpet_t0_irq);
> +		goto err;
> +	}
> +
> +	clk = of_clk_get(np, 0);
> +	if (IS_ERR(clk))
> +		goto err;
> +
> +	hpet_freq = clk_get_rate(clk);
> +	clk_put(clk);
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

