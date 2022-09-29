Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140F5EF919
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiI2Pe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiI2Pc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B20814CC;
        Thu, 29 Sep 2022 08:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC04618EA;
        Thu, 29 Sep 2022 15:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E28C433B5;
        Thu, 29 Sep 2022 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465531;
        bh=deF2FcKisyN76jbp5jOiTyccjfcKeOLLcy3mOidROng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nr4IAOAuWHll+BmxomIWuzsHt/jkkrEtWJnnvDlUqzR1/5hSqWBnIKiDslsAv0XTg
         MPpQvmbegbz1BxfgXdMgGubMwF2JW6H1guzPM5cgk82Th1nZs4Wt/I4335EqZag2Nr
         +huxVfGn1jfDy44wjtXvI7EZcKW9KE3D2BZDLxtBGm+LNUaK/qnIIQMsWWvP/moaj7
         WJx3t+N6koyWC+3LTf0i41TtlXHsCMSF2ELjt6u9bnVT2EWN/2h7sJYJnnsHPt8q64
         T4eRudc4EFB3oz4fQBdnmmMCcGxMm1G/akxvk0HkZaL4AnjugLfu6ATMfIjyB1d8qF
         scqeQ33I+OOgw==
Date:   Thu, 29 Sep 2022 16:32:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/30] soc: sifive: l2 cache: Convert to platform
 driver
Message-ID: <YzW6dEGsbSXKFtGu@spud>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929143225.17907-6-hal.feng@linux.starfivetech.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:32:00PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> This converts the driver to use the builtin_platform_driver_probe macro
> to initialize the driver. This macro ends up calling device_initcall as
> was used previously, but also allocates a platform device which gives us
> access to much nicer APIs such as platform_ioremap_resource,
> platform_get_irq and dev_err_probe.

You should resend the series ignoring this comment, but for v2, I think
you should pay attention to following patchset:

https://lore.kernel.org/linux-riscv/20220913061817.22564-1-zong.li@sifive.com/

Hopefully by the time you get to a v2, that patchset will have been
applied as 6.1 material..

Thanks,
Conor.

> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
>  drivers/soc/sifive/sifive_l2_cache.c | 79 ++++++++++++++--------------
>  1 file changed, 40 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index 59640a1d0b28..010d612f7420 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -7,9 +7,9 @@
>   */
>  #include <linux/debugfs.h>
>  #include <linux/interrupt.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_address.h>
> -#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>  #include <asm/cacheinfo.h>
>  #include <soc/sifive/sifive_l2_cache.h>
>  
> @@ -96,12 +96,6 @@ static void l2_config_read(void)
>  	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
>  }
>  
> -static const struct of_device_id sifive_l2_ids[] = {
> -	{ .compatible = "sifive,fu540-c000-ccache" },
> -	{ .compatible = "sifive,fu740-c000-ccache" },
> -	{ /* end of table */ },
> -};
> -
>  static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
>  
>  int register_sifive_l2_error_notifier(struct notifier_block *nb)
> @@ -192,36 +186,29 @@ static irqreturn_t l2_int_handler(int irq, void *device)
>  	return IRQ_HANDLED;
>  }
>  
> -static int __init sifive_l2_init(void)
> +static int __init sifive_l2_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np;
> -	struct resource res;
> -	int i, rc, intr_num;
> -
> -	np = of_find_matching_node(NULL, sifive_l2_ids);
> -	if (!np)
> -		return -ENODEV;
> -
> -	if (of_address_to_resource(np, 0, &res))
> -		return -ENODEV;
> -
> -	l2_base = ioremap(res.start, resource_size(&res));
> -	if (!l2_base)
> -		return -ENOMEM;
> -
> -	intr_num = of_property_count_u32_elems(np, "interrupts");
> -	if (!intr_num) {
> -		pr_err("L2CACHE: no interrupts property\n");
> -		return -ENODEV;
> -	}
> -
> -	for (i = 0; i < intr_num; i++) {
> -		g_irq[i] = irq_of_parse_and_map(np, i);
> -		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
> -		if (rc) {
> -			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
> -			return rc;
> -		}
> +	struct device *dev = &pdev->dev;
> +	int nirqs;
> +	int ret;
> +	int i;
> +
> +	l2_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(l2_base))
> +		return PTR_ERR(l2_base);
> +
> +	nirqs = platform_irq_count(pdev);
> +	if (nirqs <= 0)
> +		return dev_err_probe(dev, -ENODEV, "no interrupts\n");
> +
> +	for (i = 0; i < nirqs; i++) {
> +		g_irq[i] = platform_get_irq(pdev, i);
> +		if (g_irq[i] < 0)
> +			return g_irq[i];
> +
> +		ret = devm_request_irq(dev, g_irq[i], l2_int_handler, 0, pdev->name, NULL);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Could not request IRQ %d\n", g_irq[i]);
>  	}
>  
>  	l2_config_read();
> @@ -234,4 +221,18 @@ static int __init sifive_l2_init(void)
>  #endif
>  	return 0;
>  }
> -device_initcall(sifive_l2_init);
> +
> +static const struct of_device_id sifive_l2_match[] = {
> +	{ .compatible = "sifive,fu540-c000-ccache" },
> +	{ .compatible = "sifive,fu740-c000-ccache" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver sifive_l2_driver = {
> +	.driver = {
> +		.name = "sifive_l2_cache",
> +		.of_match_table = sifive_l2_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver_probe(sifive_l2_driver, sifive_l2_probe);
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
