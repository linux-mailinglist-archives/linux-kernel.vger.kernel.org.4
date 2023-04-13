Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECDC6E0ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjDMNfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjDMNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:34:48 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42592AF39;
        Thu, 13 Apr 2023 06:32:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7C5D124E1CE;
        Thu, 13 Apr 2023 21:32:11 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 21:32:11 +0800
Received: from [192.168.125.131] (183.27.97.249) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 21:32:10 +0800
Message-ID: <4ed4d0e6-8da5-7eef-8713-44854b8d4a9b@starfivetech.com>
Date:   Thu, 13 Apr 2023 21:31:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 07/10] clk: starfive: Add StarFive JH7110 Video-Output
 clock driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230411135558.44282-1-xingyu.wu@starfivetech.com>
 <20230411135558.44282-8-xingyu.wu@starfivetech.com>
 <683cbe934d1df9436e003466d2a419ef.sboyd@kernel.org>
 <463ee23c-f617-bed0-27a8-56c6fb40d092@starfivetech.com>
 <cd4a11ae65e186799145410969d40421.sboyd@kernel.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <cd4a11ae65e186799145410969d40421.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/13 12:04, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-04-11 23:15:26)
>> On 2023/4/12 2:33, Stephen Boyd wrote:
>> > Quoting Xingyu Wu (2023-04-11 06:55:55)
>> >> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
>> >> new file mode 100644
>> >> index 000000000000..4c6f5ae198cf
>> >> --- /dev/null
>> >> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
>> >> @@ -0,0 +1,239 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +/*
>> >> + * StarFive JH7110 Video-Output Clock Driver
>> >> + *
>> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> >> + */
>> >> +
>> >> +#include <linux/clk.h>
>> >> +#include <linux/clk-provider.h>
>> >> +#include <linux/io.h>
>> >> +#include <linux/platform_device.h>
>> >> +#include <linux/pm_runtime.h>
>> >> +#include <linux/reset.h>
>> > 
>> > Include module.h, device.h, and kernel.h for things like ERR_PTR().
>> 
>> The local headfile 'clk-starfive-jh71x0.h' from the basic JH71x0 clock driver
>> already includes the device.h. 
>> And I found the module.h is included in device/driver.h file and then it is included
>> in the device.h file.
>> The kernel.h is included in the clk.h file.
>> So do I still need to list them?
> 
> Yes.

OK, will fix.

> 
>> 
>> > Probably need to include a reset header as well for reset APIs.
>> 
>> The reset APIs like devm_reset_control_get_shared() and reset_control_deassert()
>> come from the reset.h file and I have included it.
> 
> Cool, I missed it.
> 
>> 
>> > 
>> >> +
>> >> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
>> >> +
>> >> +#include "clk-starfive-jh7110.h"
>> >> +
>> >> +/* external clocks */
>> >> +#define JH7110_VOUTCLK_VOUT_SRC                        (JH7110_VOUTCLK_END + 0)
>> >> +#define JH7110_VOUTCLK_VOUT_TOP_AHB            (JH7110_VOUTCLK_END + 1)
>> >> +#define JH7110_VOUTCLK_VOUT_TOP_AXI            (JH7110_VOUTCLK_END + 2)
>> >> +#define JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK   (JH7110_VOUTCLK_END + 3)
>> >> +#define JH7110_VOUTCLK_I2STX0_BCLK             (JH7110_VOUTCLK_END + 4)
>> >> +#define JH7110_VOUTCLK_HDMITX0_PIXELCLK                (JH7110_VOUTCLK_END + 5)
>> >> +#define JH7110_VOUTCLK_EXT_END                 (JH7110_VOUTCLK_END + 6)
>> >> +
>> >> +/* VOUT domian clocks */
>> >> +struct vout_top_crg {
>> >> +       struct clk_bulk_data *top_clks;
>> >> +       int top_clks_num;
>> > 
>> > size_t?
>> 
>> Will modify to 'unsigned int'.
> 
> Why not size_t?

OK,I will use size_t. 

> 
>> 
>> > 
>> >> +       if (ret < 0)
>> >> +               return dev_err_probe(priv->dev, ret, "failed to turn on power\n");
>> >> +
>> >> +       ret = jh7110_vout_top_crg_init(priv, top);
>> >> +       if (ret)
>> >> +               goto err_clk;
>> >> +
>> >> +       top->base = priv->base;
>> >> +       dev_set_drvdata(priv->dev, (void *)(&top->base));
>> > 
>> > See comment later about setting this to 'top' instead. Casting away
>> > iomem markings is not good hygiene.
>> 
>> JH7110 resets as the auxiliary device of clocks use the same iomem as the clocks
>> and the iomem will be got by dev_get_drvdata() in the 7110 reset drivers when registering reset.
>> So I follow the basic 7110 reset driver and also set the iomem not top_crg struct.
> 
> Oh I totally missed that this is how it's been done for the other
> starfive driver. It's still not good hygiene to stash the iomem pointer
> that way because the iomem marking is lost and has to be recovered. Can
> you make a wrapper struct, either for the adev or to pass in struct
> device::platform_data?
> 
> ---8<---
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 5ec210644e1d..851b93d0f371 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -11,6 +11,9 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <soc/starfive/reset-starfive-jh71x0.h>
>  
>  #include <dt-bindings/clock/starfive,jh7110-crg.h>
>  
> @@ -335,26 +338,32 @@ static void jh7110_reset_unregister_adev(void *_adev)
>  	struct auxiliary_device *adev = _adev;
>  
>  	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
>  }
>  
>  static void jh7110_reset_adev_release(struct device *dev)
>  {
>  	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
>  
> -	auxiliary_device_uninit(adev);
> +	kfree(rdev);
>  }
>  
>  int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>  				     const char *adev_name,
>  				     u32 adev_id)
>  {
> +	struct jh71x0_reset_adev *rdev;
>  	struct auxiliary_device *adev;
>  	int ret;
>  
> -	adev = devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
> -	if (!adev)
> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);

Can there use 'devm_kzalloc'? Are you not using this because the struct is public and clock driver
and reset driver both use it. But I think the both clock driver and reset driver are the same
device and can use 'devm_kzalloc'.

> +	if (!rdev)
>  		return -ENOMEM;
>  
> +	rdev->base = priv->base;
> +
> +	adev = &rdev->adev;
>  	adev->name = adev_name;
>  	adev->dev.parent = priv->dev;
>  	adev->dev.release = jh7110_reset_adev_release;
> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
> index c1b3a490d951..2d26ae95c8cc 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7110.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
> @@ -7,6 +7,8 @@
>  
>  #include <linux/auxiliary_bus.h>
>  
> +#include <soc/starfive/reset-starfive-jh71x0.h>
> +
>  #include "reset-starfive-jh71x0.h"
>  
>  #include <dt-bindings/reset/starfive,jh7110-crg.h>
> @@ -33,14 +35,15 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
>  			      const struct auxiliary_device_id *id)
>  {
>  	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
> -	void __iomem **base = (void __iomem **)dev_get_drvdata(adev->dev.parent);
> +	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
> +	void __iomem *base = rdev->base;
>  
>  	if (!info || !base)
>  		return -ENODEV;
>  
>  	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
> -					      *base + info->assert_offset,
> -					      *base + info->status_offset,
> +					      base + info->assert_offset,
> +					      base + info->status_offset,
>  					      NULL,
>  					      info->nr_resets,
>  					      NULL);
> diff --git a/include/soc/starfive/reset-starfive-jh71x0.h b/include/soc/starfive/reset-starfive-jh71x0.h
> new file mode 100644
> index 000000000000..47b486ececc5
> --- /dev/null
> +++ b/include/soc/starfive/reset-starfive-jh71x0.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_STARFIVE_RESET_JH71X0_H
> +#define __SOC_STARFIVE_RESET_JH71X0_H
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/compiler_types.h>
> +#include <linux/container_of.h>
> +
> +struct jh71x0_reset_adev {
> +	void __iomem *base;
> +	struct auxiliary_device adev;
> +};
> +
> +#define to_jh71x0_reset_adev(_adev) \
> +	container_of((_adev), struct jh71x0_reset_adev, adev)
> +
> +#endif

That's great. It don't need to set iomem to driver_data and I can set the struct data like 'top_crg'
to driver_data in VOUTCRG and ISPCRG driver. I try to modify it in next patchset.
Thanks for your suggestion.

Best regards,
Xingyu Wu

