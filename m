Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB9622AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKILhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKILhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:37:09 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A22A716;
        Wed,  9 Nov 2022 03:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667993821; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HeCzuAd5DrGQl3yX0PoEWG+18EHx/4Mkssb32++3BI=;
        b=WwCPTNJPOIDWtdzd5piGmEgZU4J4b1t9NVy+qRbY3+ISBvVQ6apE6t+8jx2p/zEgIxnja5
        9nWJEIf1duGHYh5JmCtFyh2CbFVaBUveP5Si2RGhwuWsnzKNfsXmdpkN0q+yUABhtgFuRh
        Y+C1HQZU871ihv7USL4Dk3I6J/l65gU=
Date:   Wed, 09 Nov 2022 11:36:35 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 56/65] clk: ingenic: cgu: Switch to determine_rate
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andreas =?iso-8859-1?q?F=E4rber?= <afaerber@suse.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        David Airlie <airlied@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Lechner <david@lechnology.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        patches@opensource.cirrus.com, linux-tegra@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-Id: <Z8W2LR.DTD355V5EAE02@crapouillou.net>
In-Reply-To: <20221109105301.ueus7o3b75j5yeff@houat>
References: <20221018-clk-range-checks-fixes-v2-0-f6736dec138e@cerno.tech>
        <20221018-clk-range-checks-fixes-v2-56-f6736dec138e@cerno.tech>
        <80VTKR.CE8RVN8M3ZYK3@crapouillou.net>
        <20221104145946.orsyrhiqvypisl5j@houat>
        <IOEVKR.TWFKJND2FJ473@crapouillou.net>
        <20221109105301.ueus7o3b75j5yeff@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Le mer. 9 nov. 2022 =E0 11:53:01 +0100, Maxime Ripard=20
<maxime@cerno.tech> a =E9crit :
> Hi Paul,
>=20
> On Sat, Nov 05, 2022 at 10:33:54AM +0000, Paul Cercueil wrote:
>>  Hi Maxime,
>>=20
>>  Le ven. 4 nov. 2022 =E0 15:59:46 +0100, Maxime Ripard=20
>> <maxime@cerno.tech> a
>>  =E9crit :
>>  > Hi Paul,
>>  >
>>  > On Fri, Nov 04, 2022 at 02:31:20PM +0000, Paul Cercueil wrote:
>>  > >  Le ven. 4 nov. 2022 =E0 14:18:13 +0100, Maxime Ripard
>>  > > <maxime@cerno.tech> a
>>  > >  =E9crit :
>>  > >  > The Ingenic CGU clocks implements a mux with a set_parent=20
>> hook,
>>  > > but
>>  > >  > doesn't provide a determine_rate implementation.
>>  > >  >
>>  > >  > This is a bit odd, since set_parent() is there to, as its=20
>> name
>>  > > implies,
>>  > >  > change the parent of a clock. However, the most likely=20
>> candidate
>>  > > to
>>  > >  > trigger that parent change is a call to clk_set_rate(), with
>>  > >  > determine_rate() figuring out which parent is the best=20
>> suited for
>>  > > a
>>  > >  > given rate.
>>  > >  >
>>  > >  > The other trigger would be a call to clk_set_parent(), but=20
>> it's
>>  > > far less
>>  > >  > used, and it doesn't look like there's any obvious user for=20
>> that
>>  > > clock.
>>  > >  >
>>  > >  > So, the set_parent hook is effectively unused, possibly=20
>> because
>>  > > of an
>>  > >  > oversight. However, it could also be an explicit decision by=20
>> the
>>  > >  > original author to avoid any reparenting but through an=20
>> explicit
>>  > > call to
>>  > >  > clk_set_parent().
>>  > >  >
>>  > >  > The driver does implement round_rate() though, which means=20
>> that
>>  > > we can
>>  > >  > change the rate of the clock, but we will never get to=20
>> change the
>>  > >  > parent.
>>  > >  >
>>  > >  > However, It's hard to tell whether it's been done on purpose=20
>> or
>>  > > not.
>>  > >  >
>>  > >  > Since we'll start mandating a determine_rate()=20
>> implementation,
>>  > > let's
>>  > >  > convert the round_rate() implementation to a=20
>> determine_rate(),
>>  > > which
>>  > >  > will also make the current behavior explicit. And if it was=20
>> an
>>  > >  > oversight, the clock behaviour can be adjusted later on.
>>  > >
>>  > >  So it's partly on purpose, partly because I didn't know about
>>  > >  .determine_rate.
>>  > >
>>  > >  There's nothing odd about having a lonely .set_parent=20
>> callback; in
>>  > > my case
>>  > >  the clocks are parented from the device tree.
>>  > >
>>  > >  Having the clocks driver trigger a parent change when=20
>> requesting a
>>  > > rate
>>  > >  change sounds very dangerous, IMHO. My MMC controller can be
>>  > > parented to the
>>  > >  external 48 MHz oscillator, and if the card requests 50 MHz, it
>>  > > could switch
>>  > >  to one of the PLLs. That works as long as the PLLs don't change
>>  > > rate, but if
>>  > >  one is configured as driving the CPU clock, it becomes messy.
>>  > >  The thing is, the clocks driver has no way to know whether or=20
>> not
>>  > > it is
>>  > >  "safe" to use a designated parent.
>>  > >
>>  > >  For that reason, in practice, I never actually want to have a=20
>> clock
>>  > >  re-parented - it's almost always a bad idea vs. sticking to the
>>  > > parent clock
>>  > >  configured in the DTS.
>>  >
>>  > Yeah, and this is totally fine. But we need to be explicit about=20
>> it. The
>>  > determine_rate implementation I did in all the patches is an exact
>>  > equivalent to the round_rate one if there was one. We will never=20
>> ask to
>>  > change the parent.
>>  >
>>  > Given what you just said, I would suggest to set the
>>  > CLK_SET_RATE_NO_REPARENT flag as well.
>>=20
>>  But that would introduce policy into the driver...
>=20
> I'm not sure why you're bringing policies into that discussion.=20
> There's
> plenty of policy in the driver already, and the current code doesn't=20
> do
> something that the old wasn't doing (implicitly).

Yes, I was just talking about the CLK_SET_RATE_NO_REPARENT flag adding=20
policy. The fact that there's plenty of policy in the driver already is=20
not an argument for adding some more.

> And there's plenty of policies in drivers in general. Whether you=20
> limit
> the rate or not, whether you allow reparenting or not, even the
> CLK_SET_RATE_NO_REPARENT flag mentioned above is a policy decision set
> by drivers.

Allowing reparenting and not limiting the rates is not a policy, it's=20
just following what the hardware allows you to do. The absence of=20
policy means that the driver allows you to configure the hardware in=20
any way you might want to.

Limiting rates, forbidding reparenting, that's policy, and it doesn't=20
belong in a driver.

You can argue that choosing not to reparent on rate change is a policy,=20
and it is. That's why we need a way to enforce these policies outside=20
the driver.

>>  The fact that I don't want the MMC parented to the PLLs, doesn't=20
>> mean
>>  that it's an invalid configuration per se.
>=20
> Sure, and that's another policy :)

A policy that is not enforced by the driver.

Going back to the patch itself... I am fine with the change, although=20
the patch description should probably be updated. We have .set_parent=20
callbacks to configure clocks from DT, there's nothing more to it.

Cheers,
-Paul


