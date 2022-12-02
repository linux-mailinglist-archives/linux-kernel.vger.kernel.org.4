Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18951640717
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiLBMrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLBMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:47:36 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002F125;
        Fri,  2 Dec 2022 04:47:33 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7238E5FD0B;
        Fri,  2 Dec 2022 15:47:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669985251;
        bh=wfLZbBkRuDXGRbC747nZq24iP/3vhUnV5t5N2sq8W3E=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Sw99EL1lopB7C/pOC15Z9vV22NAqivw2bNEO0ApW/yjHcrsplEAKJ1v6/AE2onvbE
         v4vpYg+F3kd913b5CCuV9vJUQyZaracHpnsXZN2gSD0e4UUl/OpmcNtRPOTo9QTMs7
         exA9/pWBEgGbNnk9mbXFvj6AFeQBkaIQ6Z8nIROmmQowfGh0bhZu6clcltjX07hLvV
         wrdZ6oNSjbaer7NWBuWaOB7/JPQwM7AsW33kvYX5Xb/V5gCYOaSf5BRhPRUuiPMlpd
         YbsKpLMO4K0wfzH+f57MFl5CRHUGGqAtF0rZYEHls5BvDddRDuiqJ+IfsxvthqslX4
         QdeC1Z87kAVBQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 15:47:31 +0300 (MSK)
Date:   Fri, 2 Dec 2022 15:47:30 +0300
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
Message-ID: <20221202124730.uckax232hnjqg26a@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-8-ddrokosov@sberdevices.ru>
 <1jtu2e6mn5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jtu2e6mn5.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 11:15:00 #20637218
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:42:17PM +0100, Jerome Brunet wrote:
> 
> On Fri 02 Dec 2022 at 01:56, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > Summary changes:
> >     - supported meson-a1-clkc common driver
> >     - inherited from the base clk-pll driver, implemented own version of
> >       init/enable/disable/enabled routines; rate calculating logic is
> >       fully the same
> >     - aligned CLKID-related definitions with CLKID list from order
> >       perspective to remove holes and permutations
> >     - corrected Kconfig dependencies and types
> >     - provided correct MODULE_AUTHORs() and MODULE_LICENSE()
> >     - optimized and fix up some clock relationships
> >     - removed unused register offset definitions (ANACTRL_* group)
> 
> This patch mix PLL stuff, factorization change, etc ...
> In general, when your commit description is a list, it is a hint that
> you are doing more than one thing in it. It is unlikely to be OK then

It will be fixed by itself, when I'll squash patches.

> > +static int meson_a1_pll_init(struct clk_hw *hw)
> > +{
> > +	struct clk_regmap *clk = to_clk_regmap(hw);
> > +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> > +
> > +	regmap_multi_reg_write(clk->map, pll->base.init_regs,
> > +			       pll->base.init_count);
> > +
> > +	return 0;
> 
> Looks the the default init mostly
> 
> Looks like you are trying the handle the absence of the rst bit.
> I'm pretty sure the hifi PLL of the SoC as one but you really don't want
> to poke, this can be in the generic driver, with MESON_PARM_APPLICABLE()
> test.
> 
> No need to redefine this
> 

I've redefined it, because in the previous v7 you mentioned that's
not acceptable to mix init/enable/disable sequences between a1 pll and clk
common pll driver:

https://lore.kernel.org/linux-amlogic/1jd0ac5kpk.fsf@starbuckisacylon.baylibre.com/

Hmmm, looks like I've made a mistake. You meant only enable/disable
callbacks...

Anyway, it doesn't matter to me. I think both approaches are okay:
    * clk-pll customization using MESON_PARM_APPLICABLE()
    * custom callbacks implementation for some clk_ops like implemented in
      this patchset.

Please advise what's the best from you point of view?

> > +}
> > +
> > +static int meson_a1_pll_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct clk_regmap *clk = to_clk_regmap(hw);
> > +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> > +
> > +	if (MESON_PARM_APPLICABLE(&pll->base.rst) &&
> > +	    meson_parm_read(clk->map, &pll->base.rst))
> > +		return 0;
> > +
> > +	if (!meson_parm_read(clk->map, &pll->base.en) ||
> > +	    !meson_parm_read(clk->map, &pll->base.l))
> > +		return 0;
> > +
> 
> Same here, pretty sure rst is there and the generic function works but
> if this update is required, it seems safe to do in the generic driver.

The same thing... in the v7 version you suggested to not touch clk-pll
driver.

https://lore.kernel.org/linux-amlogic/1jd0ac5kpk.fsf@starbuckisacylon.baylibre.com/

...

-- 
Thank you,
Dmitry
