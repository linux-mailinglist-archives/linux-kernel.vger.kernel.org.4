Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6385604044
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiJSJpm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Oct 2022 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiJSJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:42:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA5D7E07;
        Wed, 19 Oct 2022 02:19:07 -0700 (PDT)
Received: from p508fdae2.dip0.t-ipconnect.de ([80.143.218.226] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ol5C7-0004cp-PN; Wed, 19 Oct 2022 11:16:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, wxt@rock-chips.com,
        kever.yang@rock-chips.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] ARM: dts: rk3288: add the interrupts property for PWM
Date:   Wed, 19 Oct 2022 11:16:58 +0200
Message-ID: <5883380.DvuYhMxLoT@phil>
In-Reply-To: <20221019072621.lh5hcznggbcscihf@pengutronix.de>
References: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com> <7ae39c9c-8424-8b65-ac09-c0e87f3b0f01@arm.com> <20221019072621.lh5hcznggbcscihf@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. Oktober 2022, 09:26:21 CEST schrieb Uwe Kleine-König:
> On Thu, Sep 29, 2022 at 04:50:43PM +0100, Robin Murphy wrote:
> > On 2022-09-29 15:04, Johan Jonker wrote:
> > > The Rockchip rk3288 SoC has 4-built-in PWM channels.
> > > 
> > > Configurable to operate in capture mode.
> > > Measures the high/low polarity effective cycles of this input waveform
> > > Generates a single interrupt at the transition of input waveform polarity
> > > 
> > > Configurable to operate in continuous mode or one-shot mode.
> > > One-shot operation will produce N + 1 periods of the waveform,
> > > where N is the repeat counter value, and generates a single interrupt at
> > > the end of operation.
> > > Continuous mode generates the waveform continuously and
> > > do not generates any interrupts.
> > > 
> > > Add interrupts property to rk3288 PWM nodes.
> > 
> > As far as I can make out from the TRM, these are only valid when
> > GRF_SOC_CON2[0] = 0, otherwise it's in "new" RK_PWM mode using SPI 78 for
> > all channels. Which apparently will be the case for anyone using upstream
> > U-Boot:
> > 
> > https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-rockchip/rk3288/rk3288.c#L83
> 
> Huh, so it depends on a (software) setting which irqs are in use?

In the past when Rockchip swapped one IP block for another they often
had both in a soc for one generation (as a safeguard probably)
So the rk3288 has two different pwm implementations and the GRF
register selects which one is active.

Heiko

> So the
> patch isn't correct as is, but I have no idea how to make it right.
> Should we rely on the bootloader to fixup the dtb correctly?
> 
> Anyhow, I'm marking the patch as 'changes-requested' in our patchwork
> instance.
> 
> Best regards
> Uwe
> 
> 




