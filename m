Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE76E2CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNXb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:31:54 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05BC9;
        Fri, 14 Apr 2023 16:31:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4341724DB83;
        Sat, 15 Apr 2023 07:31:47 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 15 Apr
 2023 07:31:47 +0800
Received: from [192.168.0.6] (113.102.16.222) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 15 Apr
 2023 07:31:46 +0800
Message-ID: <2aa668e3-d065-7376-5d41-ef855afa8518@starfivetech.com>
Date:   Sat, 15 Apr 2023 07:31:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: starfive: Avoid casting iomem pointers
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <patches@lists.linux.dev>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230413205528.4044216-1-sboyd@kernel.org>
 <b41d8cf4-70aa-3b64-5254-46d92a188f63@starfivetech.com>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <b41d8cf4-70aa-3b64-5254-46d92a188f63@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.102.16.222]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 09:58:47 +0800, Xingyu Wu wrote:
> On 2023/4/14 4:55, Stephen Boyd wrote:
>> Let's use a wrapper struct for the auxiliary_device made in
>> jh7110_reset_controller_register() so that we can stop casting iomem
>> pointers. The casts trip up tools like sparse, and make for some awkward
>> casts that are largely unnecessary. While we're here, change the
>> allocation from devm and actually free the auxiliary_device memory in
>> the release function. This avoids any use after free problems where the
>> parent device driver is unbound from the device but the
>> auxiliuary_device is still in use accessing devm freed memory.
>> 
>> Cc: Tommaso Merciai <tomm.merciai@gmail.com>
>> Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Cc: Hal Feng <hal.feng@starfivetech.com>
>> Cc: Conor Dooley <conor.dooley@microchip.com>
>> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
>> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
>> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>> ---
>> 
>> I can take this via clk tree.
>> 
>>  drivers/clk/starfive/clk-starfive-jh7110-sys.c | 15 ++++++++++++---
>>  drivers/reset/starfive/reset-starfive-jh7110.c |  9 ++++++---
>>  include/soc/starfive/reset-starfive-jh71x0.h   | 17 +++++++++++++++++
>>  3 files changed, 35 insertions(+), 6 deletions(-)
>>  create mode 100644 include/soc/starfive/reset-starfive-jh71x0.h
>> 
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> index 5ec210644e1d..851b93d0f371 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> @@ -11,6 +11,9 @@
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include <soc/starfive/reset-starfive-jh71x0.h>
>>  
>>  #include <dt-bindings/clock/starfive,jh7110-crg.h>
>>  
>> @@ -335,26 +338,32 @@ static void jh7110_reset_unregister_adev(void *_adev)
>>  	struct auxiliary_device *adev = _adev;
>>  
>>  	auxiliary_device_delete(adev);
>> +	auxiliary_device_uninit(adev);
>>  }
>>  
>>  static void jh7110_reset_adev_release(struct device *dev)
>>  {
>>  	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
>>  
>> -	auxiliary_device_uninit(adev);
>> +	kfree(rdev);
>>  }
>>  
>>  int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>>  				     const char *adev_name,
>>  				     u32 adev_id)
>>  {
>> +	struct jh71x0_reset_adev *rdev;
>>  	struct auxiliary_device *adev;
>>  	int ret;
>>  
>> -	adev = devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
>> -	if (!adev)
>> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>> +	if (!rdev)
>>  		return -ENOMEM;
>>  
>> +	rdev->base = priv->base;
>> +
>> +	adev = &rdev->adev;
>>  	adev->name = adev_name;
>>  	adev->dev.parent = priv->dev;
>>  	adev->dev.release = jh7110_reset_adev_release;
>> diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
>> index c1b3a490d951..2d26ae95c8cc 100644
>> --- a/drivers/reset/starfive/reset-starfive-jh7110.c
>> +++ b/drivers/reset/starfive/reset-starfive-jh7110.c
>> @@ -7,6 +7,8 @@
>>  
>>  #include <linux/auxiliary_bus.h>
>>  
>> +#include <soc/starfive/reset-starfive-jh71x0.h>
>> +
>>  #include "reset-starfive-jh71x0.h"
>>  
>>  #include <dt-bindings/reset/starfive,jh7110-crg.h>
>> @@ -33,14 +35,15 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
>>  			      const struct auxiliary_device_id *id)
>>  {
>>  	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
>> -	void __iomem **base = (void __iomem **)dev_get_drvdata(adev->dev.parent);
> 
> Thank you for doing that. BTW, if drop the dev_get_drvdata(), the dev_set_drvdata() should also be dropped.
> 
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
> index a2799fe8a234..62954eb7b50a 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
> @@ -83,8 +83,6 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
> 
> -       dev_set_drvdata(priv->dev, (void *)(&priv->base));
> -
>         for (idx = 0; idx < JH7110_AONCLK_END; idx++) {
>                 u32 max = jh7110_aonclk_data[idx].max;
>                 struct clk_parent_data parents[4] = {};
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 5ec210644e1d..0cda33fd47f8 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -393,8 +393,6 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
> 
> -       dev_set_drvdata(priv->dev, (void *)(&priv->base));
> -
>         /*
>          * These PLL clocks are not actually fixed factor clocks and can be
>          * controlled by the syscon registers of JH7110. They will be dropped
>

Hi, Stephen,

Thanks for your fix to my previous patches, and I have tested this patch
on VisionFive 2 board. As Xingyu said above, I think dev_set_drvdata()
should also be dropped in clk-starfive-jh7110-sys.c and
clk-starfive-jh7110-aon.c.

Best regards,
Hal
