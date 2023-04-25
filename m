Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1966EE1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjDYMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDYMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:33:35 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF226D314;
        Tue, 25 Apr 2023 05:33:08 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 71A9B5FD05;
        Tue, 25 Apr 2023 15:33:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682425986;
        bh=M8TJz6TMqm7slfXEipNmibDQJ7voQTFLqHG+/oEd4jc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=s9kUrL+T6Zn4L1hYQXkZPtfb5nCqgVi5eojV/l3rBAA12rYmOn7TiAAuw1FcVm04X
         H0udYw/FFlfCPMMChyes0CubfCt/lquS07lpaAO9rjRauSmIgn0nSBQnsaadh30nYi
         d22INMAJPcrjAgRZK48IszAfv2bSJgdCERitydKeKlKnN4NxbvDc/ibCi7VQR17GJ0
         jFXNTwEGfeqc5br/Rc79cofD/kRRUJx5qV7u47XJtN6AQK2TqQFctg75/MC5UrgVpY
         ghuzBSxS37f8+Kwhy20kTi/BYga3kabJPsBmkwBX1HEpjncwlaI2nLmSD9wfa2jX6h
         cuW6PQoyVBt9g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Apr 2023 15:33:05 +0300 (MSK)
Date:   Tue, 25 Apr 2023 15:33:04 +0300
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
Message-ID: <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021>
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-5-ddrokosov@sberdevices.ru>
 <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/25 07:55:00 #21159618
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On Sun, Apr 23, 2023 at 11:12:27PM +0200, Martin Blumenstingl wrote:
> Hello Dmitry,
> 
> currently Jerome is busy so I am trying to continue where he left off.
> I have followed the previous iterations a bit but may have missed some
> details. So apologies if I'm repeating some questions that Jerome
> previously asked.
> 

Thank you very much for your effort! Please feel free to ask any
questions you may have, without any hesitation.

> On Wed, Apr 5, 2023 at 9:59 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > +config COMMON_CLK_A1_PLL
> > +       tristate "Meson A1 SoC PLL controller support"
> Should this be "Amlogic A1 SoC PLL controller support"?
> My understanding is that the "meson" name was dropped for this
> generation of SoCs.
> 
> [...]

Yep, that's good point. Will change it in the next version.

> > +static const struct of_device_id a1_pll_clkc_match_table[] = {
> > +       { .compatible = "amlogic,a1-pll-clkc", },
> > +       {},
> nit-pick: please drop the comma after {}
> This empty entry is a sentinel, no other entries are supposed to come
> after this - so a trailing comma is not necessary.
> 
> [...]

OK

> > +/* PLL register offset */
> > +#define ANACTRL_FIXPLL_CTRL0   0x0
> > +#define ANACTRL_FIXPLL_CTRL1   0x4
> > +#define ANACTRL_FIXPLL_STS     0x14
> > +#define ANACTRL_HIFIPLL_CTRL0  0xc0
> > +#define ANACTRL_HIFIPLL_CTRL1  0xc4
> > +#define ANACTRL_HIFIPLL_CTRL2  0xc8
> > +#define ANACTRL_HIFIPLL_CTRL3  0xcc
> > +#define ANACTRL_HIFIPLL_CTRL4  0xd0
> > +#define ANACTRL_HIFIPLL_STS    0xd4
> Here I have a question that will potentially affect patch 3/6
> ("dt-bindings: clock: meson: add A1 PLL clock controller bindings").
> In the cover-letter you mentioned that quite a few clocks have been omitted.
> Any dt-bindings that we create need to be stable going forward. That
> means: the dt-bindings will always need to describe what the hardware
> is capable of, not what the driver implements.
> So my question is: do we have all needed inputs described in the
> dt-bindings (even though we're omitting quite a few registers here
> that will only be added/used in the future)?
> Older SoCs require (temporarily) using the XTAL clock for CPU clock
> tree changes. To make a long story short: I'm wondering if - at least
> - the XTAL clock input is missing.

The Amlogic A1 clock engine comprises four clock controllers for
peripherals, PLL, CPU, and audio. While the first two have been
introduced in the current patch series, the last two will be sent in the
next iteration.
Presently, the PLL controller driver includes all the required bindings,
and the peripherals controller driver has all bindings except for the
CPU-related clock.
However, I do not believe this to be a significant issue. The clock DT
bindings are organized to simplify the process of introducing new bindings,
whether public or private. For instance, we may add new bindings to
include/dt-bindings at the end of the list and increase the overall number,
without disrupting the DT bindings ABI (the old numbers will remain
unchanged).

> 
> PS: I don't have an A1 datasheet nor a vendor kernel source (and even
> less a board for testing). So I can't verify any of this myself and
> I'm asking questions instead.
> 

-- 
Thank you,
Dmitry
