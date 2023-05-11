Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6227A6FF2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbjEKN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbjEKN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:28:29 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED5100FE;
        Thu, 11 May 2023 06:27:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4E1985FD40;
        Thu, 11 May 2023 16:26:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683811569;
        bh=X8sp8BnRLsbotgh3wMKDsGz1HrXXLMBA8aUq/cYdwbQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=I4aAEX5uUuvWnWH4G7i+enK0VORj7KilyLDzU7iPw5S1o3GJ9j4bVsa64oqW7SHlz
         SLyFMgub3pz4WK4gtokdU54f+eu+BPx24MEREsVgU2ykBzmsr5yGU3fzg25xJzwV+X
         GruApxhENXfHCBpDhYgnMevjqROnWnBJ8/sTBMTYnFjzuZh9O2inSPIRWfjDKVsg/r
         VtjGgwtHRJryGOanm6USD9eKGCkeoPGaFQqSCczwAETo4ey9/47sdaHWhhDK+go/pr
         bt7lIh1uvSZ8mIEt4GiqKVWb5J+hzhvJnFUHDHiQny3sk/wzGpD87MhccCVpUIDWzF
         WYzuAtIdvzcrg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 May 2023 16:26:07 +0300 (MSK)
Date:   Thu, 11 May 2023 16:26:06 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 4/6] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Message-ID: <20230511132606.vk52yorf43alwgew@CAB-WSD-L081021>
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-5-ddrokosov@sberdevices.ru>
 <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
 <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021>
 <CAFBinCCqx1oHf+PcXBkeRYHnGQChbTTPRyD8SJU+ait+TG+AjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCqx1oHf+PcXBkeRYHnGQChbTTPRyD8SJU+ait+TG+AjQ@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 10:21:00 #21259776
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

I apologize for the delayed response as I was on vacation without email
access. I hope this is not a problem.

On Mon, May 01, 2023 at 08:39:20PM +0200, Martin Blumenstingl wrote:
> Hello Dmitry,
> 
> (I'm aware you already posted a v14 - but I'm still replying here to
> continue the discussion on one question I had to keep the context)
> 

Sure, please find, my thoughts below.

> On Tue, Apr 25, 2023 at 2:33 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > > > +/* PLL register offset */
> > > > +#define ANACTRL_FIXPLL_CTRL0   0x0
> > > > +#define ANACTRL_FIXPLL_CTRL1   0x4
> > > > +#define ANACTRL_FIXPLL_STS     0x14
> > > > +#define ANACTRL_HIFIPLL_CTRL0  0xc0
> > > > +#define ANACTRL_HIFIPLL_CTRL1  0xc4
> > > > +#define ANACTRL_HIFIPLL_CTRL2  0xc8
> > > > +#define ANACTRL_HIFIPLL_CTRL3  0xcc
> > > > +#define ANACTRL_HIFIPLL_CTRL4  0xd0
> > > > +#define ANACTRL_HIFIPLL_STS    0xd4
> > > Here I have a question that will potentially affect patch 3/6
> > > ("dt-bindings: clock: meson: add A1 PLL clock controller bindings").
> > > In the cover-letter you mentioned that quite a few clocks have been omitted.
> > > Any dt-bindings that we create need to be stable going forward. That
> > > means: the dt-bindings will always need to describe what the hardware
> > > is capable of, not what the driver implements.
> > > So my question is: do we have all needed inputs described in the
> > > dt-bindings (even though we're omitting quite a few registers here
> > > that will only be added/used in the future)?
> > > Older SoCs require (temporarily) using the XTAL clock for CPU clock
> > > tree changes. To make a long story short: I'm wondering if - at least
> > > - the XTAL clock input is missing.
> >
> > The Amlogic A1 clock engine comprises four clock controllers for
> > peripherals, PLL, CPU, and audio. While the first two have been
> > introduced in the current patch series, the last two will be sent in the
> > next iteration.
> I (think that I) understand this part.
> 
> > Presently, the PLL controller driver includes all the required bindings,
> > and the peripherals controller driver has all bindings except for the
> > CPU-related clock.
> Let's stick to the PLL controller bindings for the next part.
> My understanding is that the PLL clock controller registers
> (ANACTRL_*) are managing the following clocks:
> - fixed_pll
> - sys_pll
> - hifi_pll
> - whatever "AUDDDS" is
> - and some miscellaneous registers like ANACTRL_POR_CNTL and
> ANACTRL_MISCTOP_CTRL0
> 
> I *think* you got the dt-bindings correct:
> Even though the driver part does not support the hifi_pll yet, this IP
> block seems to have a "hifipll_in" clock input.
> Since the dt-bindings describes the hardware it may describe (for
> example) clock inputs that are not used by the driver yet.
> 
> If you agree with my statement from above I'll be able to make my
> original question more specific:
> Since we know that we have all the required inputs for fixed_pll,
> sys_pll and hifi_pll - do you know what AUDDDS is and whether it
> requires any specific clock inputs (other than "fixpll_in" and
> "hifipll_in")?
> 

To be honest, I have prepared A1 peripherals and A1 PLL drivers based on very
poor Amlogic datasheets and custom 4.19-based vendor drivers.
The vendor driver has an AUDDDS clock in the PLL clock part, but it is not
used anywhere. Unfortunately, as usual, the datasheet doesn't provide any
information or explanation about what it is. However, the driver has a few
lines of comments that indicate:

    /*
     * aud dds clock is not pll clock, not divider clock,
     * No clock model can describe it.
     * So we regard it as a gate, and the gate ops
     * should realize lonely.
     */

Additionally, the vendor driver states that AUDDDS has a 49Mhz clock,
but I do not see any relationship with other clocks (including the exported
GENCLK).
Jian did not include it in the first version of the PLL driver, and I have
decided not to change it either.

I also noticed a few lines of AUDDDS initialization sequences in the vendor
driver, which may affect CPU clock objects (from my point of view).
However, they are currently under development, and I will try to figure it
out with Amlogic support.

> > However, I do not believe this to be a significant issue. The clock DT
> > bindings are organized to simplify the process of introducing new bindings,
> > whether public or private. For instance, we may add new bindings to
> > include/dt-bindings at the end of the list and increase the overall number,
> > without disrupting the DT bindings ABI (the old numbers will remain
> > unchanged).
> Yep, this part is clear to me. I should have been more specific that I
> was asking about the inputs that are described in the .yaml file, not
> the clock IDs.

Actually, AUDDDS has an xtal2dds parent clock, and if we need to have
the AUDDDS clock in the PLL driver, we should add one more link between
peripherals and PLL drivers.

Let me know if you have any questions.

-- 
Thank you,
Dmitry
