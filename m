Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80F6EBFC5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDWNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:31:15 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659A1726
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:31:12 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Q48Kl1Qdyz9sTs;
        Sun, 23 Apr 2023 15:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1682256667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAz/UFBeFhKJZjIfr/COBnUte6wIEOR9FV2CuK4nvXI=;
        b=0Nl66lZcukxMY05O5jqLeBmtBFWcBakJGlvNPUB4xLTuo3ksqFo6skPiotRH0wcuUznFkW
        qpieXfG2ZFwXjvLv+v/n0Dxgy2mBcNdCGUO6iXGDX+LE8xjuH3WgP4GCDhN8tZxMmvoM48
        WhGDIzc4N3xGGdal2OPDrqytxk4MoZ8BKLWUdG4qv7A01+MDK6B040xP0m4cMiI8q9impD
        mtUIP9ntAqNwB5aEpVY3eKSDZKAhjuBPhyBfklbxCH7Oy1CVbclJy8ACxcQ6bab3p+JsQu
        FoFsV+HWLdYtz3e00KAQo7Dumep/l5bec+DR5m0w4R79bPZjc3ih8mO9hYI+IQ==
References: <20230418074008.69752-1-me@crly.cz>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Roman Beranek <me@crly.cz>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosp.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] drm: sun4i: set proper TCON0 DCLK rate in DSI mode
Date:   Sun, 23 Apr 2023 15:24:33 +0200
In-reply-to: <20230418074008.69752-1-me@crly.cz>
Message-ID: <87cz3uzpx1.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 2023-04-18 at 09:40:01 +0200, Roman Beranek <me@crly.cz> wrote:
> According to Allwinner's BSP code, in DSI mode, TCON0 clock needs to be
> running at what's effectively the per-lane datarate of the DSI link.
> Given that the TCON DCLK divider is fixed to 4 (SUN6I_DSI_TCON_DIV),
> DCLK can't be set equal to the dotclock. Therefore labeling TCON DCLK
> as sun4i_dotclock or tcon-pixel-clock shall be avoided.
>
> With bpp bits per pixel transmitted over n DSI lanes, the target DCLK
> rate for a given pixel clock is obtained as follows:
>
> DCLK rate = 1/4 * bpp / n * pixel clock
>
> Effect of this change can be observed through the rate of Vblank IRQs
> which should now match refresh rate implied by set display mode. It
> was verified to do so on a A64 board with a 2-lane and a 4-lane panel.
>
> v2:
> 1. prevent reparent of tcon0 to pll-video0-2x
> 2. include pll-video0 in setting TCON0 DCLK rate
> 3. tested the whole thing also on a PinePhone
>
> Roman Beranek (7):
>   clk: sunxi-ng: a64: propagate rate change from pll-mipi
>   clk: sunxi-ng: a64: export PLL_MIPI
>   clk: sunxi-ng: a64: prevent CLK_TCON0 being reparented
>   arm64: dts: allwinner: a64: assign PLL_MIPI to CLK_TCON0
>   ARM: dts: sunxi: rename tcon's clock output
>   drm: sun4i: rename sun4i_dotclock to sun4i_tcon_dclk
>   drm: sun4i: calculate proper DCLK rate for DSI
>
>  arch/arm/boot/dts/sun5i.dtsi                  |  2 +-
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi          |  2 +-
>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  2 +-
>  arch/arm/boot/dts/sun8i-v3s.dtsi              |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  4 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |  6 ++-
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h         |  4 +-
>  drivers/gpu/drm/sun4i/Makefile                |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c            | 46 +++++++++++--------
>  .../{sun4i_dotclock.c => sun4i_tcon_dclk.c}   |  2 +-
>  .../{sun4i_dotclock.h => sun4i_tcon_dclk.h}   |  0
>  include/dt-bindings/clock/sun50i-a64-ccu.h    |  1 +
>  12 files changed, 43 insertions(+), 30 deletions(-)
>  rename drivers/gpu/drm/sun4i/{sun4i_dotclock.c => sun4i_tcon_dclk.c} (99%)
>  rename drivers/gpu/drm/sun4i/{sun4i_dotclock.h => sun4i_tcon_dclk.h} (100%)
>
>
> base-commit: 4aa35a0130d6b8afbefc9ef530a521fb0fb9b8e1


I've tried your patches on my pinephone. I also set the panel's clock to
72 MHz, so at 24 bpp and 4 lanes that should result in a data clock of
108 MHz. This should be possible when pll-video0 is at 297 MHz.

Unfortunately, pll-video0 is not set and therefore the relevant part of
the clk_summary looks like this:

                          enable  prepare  protect              hardware
clock                      count    count    count        rate    enable
------------------------------------------------------------------------
 pll-video0                    1        1        1   294000000         Y
    hdmi                       0        0        0   294000000         N
    tcon1                      0        0        0   294000000         N
    pll-mipi                   1        1        1   431200000         Y
       tcon0                   2        2        1   431200000         Y
          tcon-data-clock      1        1        1   107800000         Y
    pll-video0-2x              0        0        0   588000000         Y

Note, I've cut the columns accuracy, phase, and duty cycle, because they
show the same values for all clocks (0, 0, 50000).

My understanding was that with this patchset setting the parent clock
should be possible. Do you have any idea why it doesn't work on the
pinephone? Or maybe it does work on yours and I'm making some kind of
mistake?

On a brighter note, when I initialize pll-video0 to 297 MHz in
sunxi-ng/ccu-sun50i-a64.c:sun50i_a64_ccu_probe() I get an even 108 Mhz
for the data clock. The patch is:

	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);

+	/*
+	 * Initialize PLL VIDEO0 to default values (297 MHz)
+	 * to clean up any changes made by bootloader
+	 */
+	writel(0x03006207, reg + 0x10);
+
	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_desc);
	if (ret)
		return ret;

Best,
  Frank
