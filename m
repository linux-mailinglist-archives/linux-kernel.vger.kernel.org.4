Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E761089F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiJ1DRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiJ1DRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:17:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D282E57E38
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:17:02 -0700 (PDT)
X-QQ-mid: bizesmtp88t1666926984tgsd2v4z
Received: from [192.168.125.106] ( [113.72.144.82])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 11:16:22 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: U9wPccABgDip1FKIehWf+rKGzOfQUrcaLv6isVqH4IX4RyIUWUIb8pvz7qTwA
        lrdMLNQ9Orrxza945lLeldjlqKldGelyB05s5BiKKCMNXKcKFBB6cTuVVlEP5RlylkxSj7w
        jtBfhHnSBmWNzO2/sfVlAyrVMrPcCsPzhpcgrxYCHm7gDd6cZBj5TqRP3TKKNDHoGFPb8+A
        CCnkifwYTmhc5jGO1KWpPAOTrmHijf7SvKV3hqkU8u95Gvc2ZjGlUqGT/s0n9l3Bu2jJili
        zWGXBwofjwthLsWyyX2jSB/4uqRIFQiLzd8f743aa2iCp2YY+geZeLC344E9zpxkDwsR/jj
        VRojGyoyCxsI0ciYp3EUt1fRe05fW1hD5kAVh/ShsfJRcgduwvrz3fQGtAcn8jo20WsKZih
X-QQ-GoodBg: 0
Message-ID: <614933BF5EA65346+2b45bc7f-c6e3-0f70-5661-5b91839afc9b@linux.starfivetech.com>
Date:   Fri, 28 Oct 2022 11:16:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 15/30] clk: starfive: Use regmap APIs to operate
 registers
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175602.19946-1-hal.feng@linux.starfivetech.com>
 <20220930214824.A14ACC433D6@smtp.kernel.org>
 <CAJM55Z8xxrKqaN64KAP9miTis4wFbL2S9uhV5h-SOiYjbYng+g@mail.gmail.com>
 <20221012230525.C6E58C433D7@smtp.kernel.org>
 <07B628ED6CABEF1D+932737cc-7d4b-4071-531e-82f88d89a872@linux.starfivetech.com>
 <4AF0F174-CB35-447A-9F22-7D300B225011@kernel.org>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <4AF0F174-CB35-447A-9F22-7D300B225011@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022 11:25:26 +0100, Conor Dooley wrote:
> On 23 October 2022 05:11:41 IST, Hal Feng <hal.feng@linux.starfivetech.com> wrote:
> >On Wed, 12 Oct 2022 16:05:23 -0700, Stephen Boyd wrote:
> >> Quoting Emil Renner Berthing (2022-10-05 06:14:44)
> >> > > > @@ -295,11 +296,13 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
> >> > > >         if (!priv)
> >> > > >                 return -ENOMEM;
> >> > > >
> >> > > > -       spin_lock_init(&priv->rmw_lock);
> >> > > >         priv->dev = &pdev->dev;
> >> > > > -       priv->base = devm_platform_ioremap_resource(pdev, 0);
> >> > > > -       if (IS_ERR(priv->base))
> >> > > > -               return PTR_ERR(priv->base);
> >> > > > +       priv->regmap = device_node_to_regmap(priv->dev->of_node);
> >> > >
> >> > > This is sad. Why do we need to make a syscon? Can we instead use the
> >> > > auxiliary bus to make a reset device that either gets a regmap made here
> >> > > in this driver or uses a void __iomem * mapped with ioremap
> >> > > (priv->base)?
> >> > 
> >> > In my original code the clock driver just registers the resets too
> >> > similar to other combined clock and reset drivers. I wonder what you
> >> > think about that approach:
> >> > https://github.com/esmil/linux/commit/36f15e1b827b02d7f493dc5fce31060b21976e68
> >> > and
> >> > https://github.com/esmil/linux/commit/4ccafadb72968480aa3dd28c227fcccae411c13b#diff-ffec81f902f810cb210012c25e8d88217ea5b4021419a4206d1fd4dd19edfce8R471
> >> 
> >> I think we should use auxiliary bus and split the driver logically into
> >> a reset driver in drivers/reset and a clk driver in drivers/clk. That
> >> way the appropriate maintainers can review the code. There is only one
> >> platform device with a single reg property and node in DT, but there are
> >> two drivers. 
> >
> >Yes, I agree that the reset driver and the clock driver should be split.
> >However, I think using auxiliary bus is a little bit complicated in this
> >case, because the reset is not a part of functionality of the clock in 
> >JH7110. They just share a common register base address. I think it is 
> >better to use ioremap for the same address, and the dt will be like
> >
> >syscrg_clk: clock-controller@13020000 {
> >	compatible = "starfive,jh7110-clkgen-sys";
> >	reg = <0x0 0x13020000 0x0 0x10000>;
> >	...
> >};
> >syscrg_rst: reset-controller@13020000 {
> >	compatible = "starfive,jh7110-reset-sys";
> >	reg = <0x0 0x13020000 0x0 0x10000>;
> >	...
> >};
> >
> >What do you think of this approach? I would appreciate your suggestions.
> 
> No, the dtb checks will all start warning for this.
> Aux bus is not that difficult, you can likely copy much of what I did recently in clk-mpfs.c

Thanks for reminding and your helpful example.

Best regards,
Hal

