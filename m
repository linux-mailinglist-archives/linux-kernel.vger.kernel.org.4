Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538B631CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKUJXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKUJXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:23:47 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D52233B9;
        Mon, 21 Nov 2022 01:23:40 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4D39E24E226;
        Mon, 21 Nov 2022 17:23:39 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 17:23:39 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 17:23:38 +0800
Message-ID: <4dd7ebaf-89db-3c22-e8bc-e9f7211fa06b@starfivetech.com>
Date:   Mon, 21 Nov 2022 17:23:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 04/14] reset: starfive: Factor out common JH71X0 reset
 code
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
 <20221118010627.70576-5-hal.feng@starfivetech.com>
 <CAJM55Z8z9OLU5_Z0HiyKN0mMZHrKSkGJqbP_1QOw3nEt6b5MxQ@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z8z9OLU5_Z0HiyKN0mMZHrKSkGJqbP_1QOw3nEt6b5MxQ@mail.gmail.com>
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

On Sat, 19 Nov 2022 00:39:35 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
> > diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
> > similarity index 50%
> > copy from drivers/reset/starfive/reset-starfive-jh7100.c
> > copy to drivers/reset/starfive/reset-starfive-jh71x0.c
> > index fc44b2fb3e03..1e230f3f9841 100644
> > --- a/drivers/reset/starfive/reset-starfive-jh7100.c
> > +++ b/drivers/reset/starfive/reset-starfive-jh71x0.c

[...]

> > -static int __init jh7100_reset_probe(struct platform_device *pdev)
> > +int reset_starfive_jh7100_register(struct device *dev, struct device_node *of_node,
> > +                                  void __iomem *assert, void __iomem *status,
> > +                                  const u64 *asserted, unsigned int nr_resets,
> > +                                  bool is_module)
> >  {
> >         struct jh7100_reset *data;
> >
> > -       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >         if (!data)
> >                 return -ENOMEM;
> >
> > -       data->base = devm_platform_ioremap_resource(pdev, 0);
> > -       if (IS_ERR(data->base))
> > -               return PTR_ERR(data->base);
> > -
> >         data->rcdev.ops = &jh7100_reset_ops;
> > -       data->rcdev.owner = THIS_MODULE;
> > -       data->rcdev.nr_resets = JH7100_RSTN_END;
> > -       data->rcdev.dev = &pdev->dev;
> > -       data->rcdev.of_node = pdev->dev.of_node;
> > +       if (is_module)
> > +               data->rcdev.owner = THIS_MODULE;
> 
> nit: consider just passing the owner directly, so this would just be
> data->rcdev.owner = owner;
> 
> ..and callers that used false can just pass NULL.

Yeah, will fix it.

> 
> > +       data->rcdev.nr_resets = nr_resets;
> > +       data->rcdev.dev = dev;
> > +       data->rcdev.of_node = of_node;
> 
> Is it important to register this with the auxiliary device and not
> just use the parent device?

I'm not sure whether it still works if we use the same device, but
it's general to separate the devices of clock and reset. They have
different device names and different drivers.

Best regards,
Hal

> If not you can just always pass the device that has the right of_node
> and have this be
> 
> data->rcdev.of_node = dev->of_node;
> 
> > +
> >         spin_lock_init(&data->lock);
> > +       data->assert = assert;
> > +       data->status = status;
> > +       data->asserted = asserted;
> >
> > -       return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> > +       return devm_reset_controller_register(dev, &data->rcdev);
> >  }

