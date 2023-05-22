Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721E270B868
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjEVJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjEVJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:04:50 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5355FBB;
        Mon, 22 May 2023 02:04:45 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6DE185FD4B;
        Mon, 22 May 2023 12:04:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684746276;
        bh=wEI77Dmm7dPcR3e6cE8UurpF6btsHpNI9N3cHPdCHgg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=kjIQtaqzZTeaK3MsNvTta8NF2eb1ev6Gt5gaIQb0J4QprOlhnjFGf2OYzcZuBzo5P
         2AIcLGghhfeSZ/cyS298KOobXlC+YyOY3N9pnFvCQ+aVkpA4u7VuPOq9P8iDwwM53U
         ooi4KP+QNxhSuU0U76maTa5AqOyktd0A0GwAOvG8RxwWO5Clt+cxFFYprDo/T8LqmW
         z82wnDDhYxEnmtvn8+xZW53/1enK2JveMZTbPI1yMyC1ux+RBug2oVOJ3cDHvJ/ML5
         Te1n5iwhnnEpRtVblI9K1cVQ49hgGaRWhrCUsYi5ZvuomxswN6Fm99Px7l6UXyVfNL
         9malwIi21ia7w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 22 May 2023 12:04:31 +0300 (MSK)
Date:   Mon, 22 May 2023 12:04:31 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Vyacheslav <adeep@lexina.in>,
        George Stark <gnstark@sberdevices.ru>, <jic23@kernel.org>,
        <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <andy.shevchenko@gmail.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Message-ID: <20230522090431.cioenszeafwprtad@CAB-WSD-L081021>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in>
 <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/22 04:49:00 #21364689
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

On Wed, May 17, 2023 at 09:28:58PM +0200, Martin Blumenstingl wrote:
> Hello Vyacheslav, George and Dmitry,
> 
> On Wed, May 17, 2023 at 1:37 PM Vyacheslav <adeep@lexina.in> wrote:
> >
> > Hi, Martin,
> >
> > On 16.05.2023 22:08, Martin Blumenstingl wrote:
> > > Hi George,
> > >
> > > thank you for this patch!
> > >
> > > On Mon, May 15, 2023 at 11:06 PM George Stark <gnstark@sberdevices.ru> wrote:
> > >>
> > >> From: George Stark <GNStark@sberdevices.ru>
> > >>
> > >> According to datasheets of supported meson SOCs
> > >> length of ADC_CLK_DIV field is 6 bits long
> > > I have a question about this sentence which doesn't affect this patch
> > > - it's only about managing expectations:
> > > Which SoC are you referring to?
> >
> > I checked the 905x, 905x3, a113x datasheets - there is the same register
> > with 6 bits for  ADC_CLK_DIV
> This highlights a common issue I have seen with Amlogic datasheets:
> parts of the datasheet are outdated (or incorrect in one way or
> another).
> For my following explanation I will refer to the public S905X3
> datasheet from [0].
> 
> The documentation for SAR_ADC_REG3 on page 1065 states that this
> register contains:
> - bit 30: SAR ADC_CLK_EN: 1 = enable the SAR ADC clock
> - bits 10-15: ADC_CLK_DIV: The ADC clock is derived by dividing the
> 27Mhz crystal by N+1. This value divides the 27Mhz clock to generate
> an ADC clock. A value of 20 for example divides the 27Mhz clock by 21
> to generate an equivalent 1.28Mhz clock
> 
> The first problem with this part of the documentation is that there's
> no 27MHz crystal on the Amlogic SoCs listed (S905X, S905X3), only a
> 24MHz one.
> I'm also human, I'm not perfect so typos and mistakes happen. If you
> look at the S805 datasheet (from year 2015) on page 116/117 you'll see
> that even back then it said 27MHz - and even that SoC generation
> (Meson8b) had a 24MHz crystal, not a 27MHz one. In over five years
> that typo has not been fixed.
> 
> Let's focus on the S905X3 datasheet again, this time page 101 where it
> has "Figure 7-8 AO Clock Sources".
> Note that the register offsets listed in that section need to be
> multiplied by 4 to get the actual offset in IO memory.
> It describes the "sar_adc_clk" with:
> - first mux at register 0x90 (= 0x24 * 4) bits [10:9] (inputs are: 0 =
> XTAL, 1 = clk81, 2 and 3 are grounded)
> - gate at register 0x90 (= 0x24 * 4) bit 8
> - divider at register 0x90 (= 0x24 * 4) bits [7:0]
> - second mux at register 0x90 (= 0x24 * 4) bit 0 (inputs are: 0 =
> divider from above, 1 = XTAL)
> 
> Looking at drivers/clk/meson/g12a-aoclk.c this is what we implement
> (apart form the second mux, which seems to be missing).
> But this now gets confusing: why are there now two dividers and two
> gates (one the SAR ADC registers and another on in the AO clock
> controller registers)?
> 
> Looking at my board (G12A X96 Max in this case, but it's uses the same
> clock controller drivers as SM1/S905X3) where &saradc is not enabled
> (meaning: it uses SoC defaults or values initialized by the vendor
> u-boot/TF-A):
> $ grep adc /sys/kernel/debug/clk/clk_summary
>    g12a_ao_saradc_mux                0        0        0    24000000
>       g12a_ao_saradc_div             0        0        0     1142858
>          g12a_ao_saradc_gate         0        0        0     1142858
>                         g12a_ao_saradc       0        0        0   166666664
>                         g12a_adc       0        0        0   166666664
> (output is shortened to make it easier to read)
> 
> 1142858Hz is 24MHz divided by 21 (as described in the SAR ADC register
> space - but these values are from the AO clock controller registers).
> So my thought is: if the clock has been programmed in the AO clock
> register space then the divider and gate from the SAR ADC register
> space are not used (anymore) on this SoC generation.
> 
> My understanding so far (matching experiments I made long time ago) is:
> - the gate and divider within the SAR ADC register space are only
> relevant for SoCs that predate the GXBB generation
> - SoCs starting from the GXBB SoC generation (that includes GXL, SM1,
> ...) use a dedicated SAR ADC clock provided by some clock controller
> (see the output of $ git grep -E "sar[_]?adc" drivers/clk/meson/ |
> grep name | grep -v _div | grep -v _mux | grep -v _sel)
> -- I think this even applies to the A1 SoC, looking at "clk: meson:
> a1: add Amlogic A1 Peripherals clock controller driver" [2] from
> Dmitry the peripheral clock controller has a "saradc" clock tree (with
> mux, divider, gate)
> 
> As result of my understanding meson_saradc.c will only register the
> divider and gate (using meson_sar_adc_clk_init()) if no ADC clock is
> provided via the .dtb.
> On GXBB and newer SoCs meson_sar_adc_clk_init() is not called and the
> divider and gate from the SAR ADC registers are not used.
> 
> Amlogic has debug tool IP block in these SoCs called "clock  measurer"
> which can measure various clocks.
> We provide a debugfs interface in
> /sys/kernel/debug/meson-clk-msr/measure_summary
> My suggestion is to play around with the SAR ADC clock (both, the one
> from the peripheral clock controller on your SoC and the one inside
> the SAR ADC registers) and see which clock has an impact on the
> measured clock rate.
> 
> PS: I apologize for this long mail. I want to make clear that it's not
> a rant towards you.
> My thought is to share some of the experiences I made in the past.
> I'm always hoping that the quality of the datasheets improves over
> time. In some regards they do (a lot more IPs are documented compared
> to older generations).
> Missing details in the datasheet or incorrect descriptions have cost
> me a lot of time previously.
> My ultimate suggestion is to double check (for example with the clock
> measurer, a scope, ...) what's written in the datasheet so you're not
> wasting time like I did.
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://dn.odroid.com/S905X3/ODROID-C4/Docs/S905X3_Public_Datasheet_Hardkernel.pdf
> [1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> [2] https://lore.kernel.org/linux-amlogic/20230517133309.9874-7-ddrokosov@sberdevices.ru/T/#u

Thank you very much for providing such a detailed description of all the
circumstances that could be valuable in this situation. I completely
agree with you that experiments are required here, so we will definitely
run them. Additionally, we will reach out to Amlogic regarding this
strange behavior and share the results with you and the community. I
believe that this will be important as well.

-- 
Thank you,
Dmitry
