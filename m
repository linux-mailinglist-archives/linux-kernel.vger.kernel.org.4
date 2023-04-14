Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B796E19CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDNBiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDNBin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:38:43 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F52697;
        Thu, 13 Apr 2023 18:38:39 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1D2778086;
        Fri, 14 Apr 2023 09:38:27 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Apr
 2023 09:38:26 +0800
Received: from [192.168.125.131] (183.27.97.249) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Apr
 2023 09:38:25 +0800
Message-ID: <f020e55c-d4e4-dbb9-d658-7bef2b8bd94b@starfivetech.com>
Date:   Fri, 14 Apr 2023 09:37:29 +0800
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
 <4ed4d0e6-8da5-7eef-8713-44854b8d4a9b@starfivetech.com>
 <d70886f6ee13e70845a72354fe9a2b7d.sboyd@kernel.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <d70886f6ee13e70845a72354fe9a2b7d.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 2:38, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-04-13 06:31:12)
>> On 2023/4/13 12:04, Stephen Boyd wrote:
>> > diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> > index 5ec210644e1d..851b93d0f371 100644
>> > --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> > +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> > @@ -11,6 +11,9 @@
>> >  #include <linux/init.h>
>> >  #include <linux/io.h>
>> >  #include <linux/platform_device.h>
>> > +#include <linux/slab.h>
>> > +
>> > +#include <soc/starfive/reset-starfive-jh71x0.h>
>> >  
>> >  #include <dt-bindings/clock/starfive,jh7110-crg.h>
>> >  
>> > @@ -335,26 +338,32 @@ static void jh7110_reset_unregister_adev(void *_adev)
>> >       struct auxiliary_device *adev = _adev;
>> >  
>> >       auxiliary_device_delete(adev);
>> > +     auxiliary_device_uninit(adev);
>> >  }
>> >  
>> >  static void jh7110_reset_adev_release(struct device *dev)
>> >  {
>> >       struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> > +     struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
>> >  
>> > -     auxiliary_device_uninit(adev);
>> > +     kfree(rdev);
>> >  }
>> >  
>> >  int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>> >                                    const char *adev_name,
>> >                                    u32 adev_id)
>> >  {
>> > +     struct jh71x0_reset_adev *rdev;
>> >       struct auxiliary_device *adev;
>> >       int ret;
>> >  
>> > -     adev = devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
>> > -     if (!adev)
>> > +     rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>> 
>> Can there use 'devm_kzalloc'? Are you not using this because the struct is public and clock driver
>> and reset driver both use it. But I think the both clock driver and reset driver are the same
>> device and can use 'devm_kzalloc'.
> 
> No. The release function for the auxiliary_device is supposed to free
> the memory. It shouldn't be tied to the lifetime of anything like the
> lifetime of the clk driver being bound.

Get it. Thanks.

Best regards,
Xingyu Wu
