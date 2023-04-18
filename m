Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3586E66CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDROMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjDROMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:12:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002BD14F62;
        Tue, 18 Apr 2023 07:12:11 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pom3u-0003l7-Rd; Tue, 18 Apr 2023 16:12:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add rk3588 timer
Date:   Tue, 18 Apr 2023 16:12:01 +0200
Message-ID: <2828868.BjyWNHgNrj@diego>
In-Reply-To: <e2e59d5d-89cb-ba82-f0fc-ecddb9bdfc2a@collabora.com>
References: <20230418095344.274025-1-cristian.ciocaltea@collabora.com>
 <a8a9e82b-996e-2b0d-4e3b-9ceda0ab81e4@gmail.com>
 <e2e59d5d-89cb-ba82-f0fc-ecddb9bdfc2a@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 18. April 2023, 13:53:23 CEST schrieb Cristian Ciocaltea:
> 
> On 4/18/23 14:29, Johan Jonker wrote:
> > 
> > 
> > On 4/18/23 11:53, Cristian Ciocaltea wrote:
> >> Add DT node for Rockchip RK3588/RK3588S SoC timer.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> index 657c019d27fa..acd89a55374a 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> @@ -1400,6 +1400,14 @@ i2c5: i2c@fead0000 {
> >>  		status = "disabled";
> >>  	};
> >>  
> > 
> >> +	rktimer: timer@feae0000 {
> > 
> > There are multiple timers.
> > Use a label in line with the TRM.
> > Maybe change your label to "timer0" in that trend?
> 
> Sure, will use "timer0".
> 
> >> +		compatible = "rockchip,rk3588-timer", "rockchip,rk3288-timer";
> >> +		reg = <0x0 0xfeae0000 0x0 0x20>;
> > 
> >> +		clocks = <&cru PCLK_BUSTIMER0>, <&cru CLK_BUSTIMER0>;
> >> +		clock-names = "pclk", "timer";
> >> +		interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
> > 
> > Heiko's sort rules:
> > 
> > compatible
> > reg
> > interrupts
> > [alphabetical]
> > status [if needed]
> 
> Thanks for pointing this out! The sort rule was not obvious as there are
> many other nodes that don't conform.

hmm, that is probably an oversight then :-) . Though looking through
rk3588s.dtsi and rk3588.dtsi, it looks like most peripherals follow that
sorting quite nicely.

But there is also a bit of leeway ... aka there can be an argument made
that assigned-clocks might want to live near clocks or regulator-properties
could be sorted somewhat differently.

So general ideal is alphabetically for the random properties to give some
guidance on sorting.

And compatible, regs, interrupts at the top + status at the bottom makes
it way easier to establish a reading pattern, when looking for something
in the file :-) .


Heiko


