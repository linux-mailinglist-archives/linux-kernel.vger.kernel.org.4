Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7A640D00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiLBSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiLBSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:20:43 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9B11C13;
        Fri,  2 Dec 2022 10:20:39 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5817B5FD0D;
        Fri,  2 Dec 2022 21:20:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1670005236;
        bh=lVVo71weIt+vHXOc869oAd9D4/vmfPmKx3pWAnQt/xg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=p+oPvJLLQDOGLCV4iYf4YWo0zMZunaoOlSvH81gnDYYC4jIjzrByi3bK4OqLvBhr1
         nyRWpXFcYHWT85OdnUVyjddx2TIzgJkZn1gdgFWQv/S6UqPyHgbwnHw85whKrsuqOX
         NU7w+Tn0zd2uygvXv4xxVQR/qVdXRLDjWFNcTxUOyW2KCdriFxoIB2qSbyviKq7b8L
         BKxXUUPZw1oxASaI5957UxLHVsK0dNwJw9ivb9ITp6WFuhMPU070JRUZosG9BQ0Fau
         kK3hmvXaJ8459jWe/96LOMZc4HBjPC0gLYsCbsosMiSbkvr4wPNu8mMXLmktBQQ424
         LWWFepozlDlGQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 21:20:35 +0300 (MSK)
Date:   Fri, 2 Dec 2022 21:20:35 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 07/11] clk: meson: a1: redesign Amlogic A1 PLL clock
 controller
Message-ID: <20221202182035.radbnv4eiuiekiqc@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-8-ddrokosov@sberdevices.ru>
 <1jtu2e6mn5.fsf@starbuckisacylon.baylibre.com>
 <20221202124730.uckax232hnjqg26a@CAB-WSD-L081021>
 <1jh6ye6js6.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jh6ye6js6.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 14:06:00 #20638022
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...

> >> > +static int meson_a1_pll_init(struct clk_hw *hw)
> >> > +{
> >> > +	struct clk_regmap *clk = to_clk_regmap(hw);
> >> > +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> >> > +
> >> > +	regmap_multi_reg_write(clk->map, pll->base.init_regs,
> >> > +			       pll->base.init_count);
> >> > +
> >> > +	return 0;
> >> 
> >> Looks the the default init mostly
> >> 
> >> Looks like you are trying the handle the absence of the rst bit.
> >> I'm pretty sure the hifi PLL of the SoC as one but you really don't want
> >> to poke, this can be in the generic driver, with MESON_PARM_APPLICABLE()
> >> test.
> >> 
> >> No need to redefine this
> >> 
> >
> > I've redefined it, because in the previous v7 you mentioned that's
> > not acceptable to mix init/enable/disable sequences between a1 pll and clk
> > common pll driver:
> >
> > https://lore.kernel.org/linux-amlogic/1jd0ac5kpk.fsf@starbuckisacylon.baylibre.com/
> >
> > Hmmm, looks like I've made a mistake. You meant only enable/disable
> > callbacks...
> >
> > Anyway, it doesn't matter to me. I think both approaches are okay:
> >     * clk-pll customization using MESON_PARM_APPLICABLE()
> >     * custom callbacks implementation for some clk_ops like implemented in
> >       this patchset.
> >
> > Please advise what's the best from you point of view?
> 
> It is a balance.
> 
> Everytime a new PLL comes up, it tends to treaded as a new ip block but,
> most of the time after some digging and rework, we learn new things and
> it ends up being compatible with the previous ones.
> 
> From what I see here
> * You are trying to make rst optional, that's fine. Do it with
>   MESON_PARM_APPLICABLE() in the main driver. Still I would recommend to
>   thorougly for this bit. I'm pretty sure the hifi pll has one.
> 
> * You add a new feature called current self-adaptation.
>   This can be made optional too in the enable sequence.
>   I would not be surprised to find out more PLL have that, even on
>   earlier SoC.

Okay, I see.
I will try to modify clk-pll driver in accurate way to support rst
optional bit and current self-adaptation optional IP.

...

-- 
Thank you,
Dmitry
