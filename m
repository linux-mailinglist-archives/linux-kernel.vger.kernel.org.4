Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9E700581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjELKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjELKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:30:53 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36899FD;
        Fri, 12 May 2023 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XO4oiI1WNZCBGXID74Maj061GJZrrhbmIDz22HJ58gU=; b=wBAyUpI+5/KekxytWPe3rJjhGr
        GnFgPUT2WkeD4vrpjTvrRLSlb+mVCIVoqQ5/uSIKIk75LIUmbZhQDsrMh5D6yrxXDaYNG0mNd7Bsi
        3kyhEDKXkZO6QOQKt/7rMjV9FkRm9ABhR8PQM5K+fUGSCwlW4OYxg+5juPqokJJMXz4RryO3gUnZZ
        yd2yClocyD3omuW3VwwxhiCA+gxonVCejBEbipm8VRU8TSItJH0vCfnL6v2HFEenbtcvnqQQ/whmP
        njSw0sBxqCiK9aMV0lH2JgLtXILMqL2t3s6kJkkDQp2htNEzaXxLK088p/3Mb7kEETiadBHSkohpD
        DHKB7Ssw==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pxQ2i-00AGrY-Rx; Fri, 12 May 2023 11:30:32 +0100
Date:   Fri, 12 May 2023 11:30:32 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: dts: axp209: Add iio-hwmon node for internal
 temperature
Message-ID: <ZF4VSCxvb6ihw9JL@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <2a9bd53a65c4a154cccba622c60cbffcdceaeb95.1683719613.git.noodles@earth.li>
 <3421275.QJadu78ljV@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3421275.QJadu78ljV@jernej-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 06:11:49PM +0200, Jernej Škrabec wrote:
> Dne sreda, 10. maj 2023 ob 14:02:28 CEST je Jonathan McDowell napisal(a):
> > This adds a DT node to hook up the internal temperature ADC to the
> > iio-hwmon driver. The various voltage + current ADCs are consumed and
> > exposed by their respective drivers, but this is not and is always
> > available. Naming chosen to match the axp20x_ prefix the power sensors
> > use.
> 
> Sorry for maybe obvious thing, but where are other ADC channels exposed?

In the associated power drivers; e.g. axp20x_ac_power, axp20x_usb_power
+ axp20x_battery. The internal temperature is the only one that
logically belongs to the chip as a whole rather than one of the
subfunctions.

root@chip:~# sensors
axp20x_battery-isa-0000
Adapter: ISA adapter
in0:           0.00 V
curr1:         0.00 A

pmic_temp-isa-0000
Adapter: ISA adapter
temp1:        +42.5°C

axp20x_ac-isa-0000
Adapter: ISA adapter
in0:           0.00 V
curr1:         0.00 A

axp20x_usb-isa-0000
Adapter: ISA adapter
in0:           4.93 V  (min =  +4.00 V)
curr1:       330.00 mA (max =  +0.00 A)

> > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/axp209.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> > index ca240cd6f6c3..469d0f7d5185 100644
> > --- a/arch/arm/boot/dts/axp209.dtsi
> > +++ b/arch/arm/boot/dts/axp209.dtsi
> > @@ -48,6 +48,13 @@
> >   * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
> >   */
> > 
> > +/ {
> > +	pmic-temp {
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&axp_adc 4>; /* Internal temperature */
> > +	};
> > +};
> > +
> >  &axp209 {
> >  	compatible = "x-powers,axp209";
> >  	interrupt-controller;

J.

-- 
/-\                             |  Synonym: word used when you can't
|@/  Debian GNU/Linux Developer |       spell the one you want
\-                              |
