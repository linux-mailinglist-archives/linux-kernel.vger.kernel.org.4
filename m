Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06DA6F0337
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbjD0JQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjD0JQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:16:54 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E7E1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:16:52 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F5721BF20B;
        Thu, 27 Apr 2023 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1682587010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qyG9+gfvXxHgY4xjE51TQp+TEhpzgbUoMouaN8SoApA=;
        b=Q3NOrROXvABtDDchHYtp2kMYBn5EktZ7FWG2pI8mE0i3ZMHsSKepON8uIQCTNEG+VkCZ1R
        eRXBCHVzdEldNX0d5jTA1BZgLw/gHdRlHzuy0/g4A0hgxE0oVHrWt6uHnaAVOIx75fwGv2
        dwK93MwV/HDF1ykZr8095sJa+XI9ddXM1FDlxr+Ty70yeViCGHOoHDspxVb9sI0YkA2CQp
        GFteNZeEhq7M0cdSHI9VDv3rf//uPzooRWwD/3wxCNSEJZNIZ6Kf24GR207BoXlGurDSn+
        RrUyb3DFuosiIpBxX2sz0RV8Lg9EGFqECBqLcOVhBmbmnzv3EmedwHWvEE66LQ==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7]  drm: sun4i: set proper TCON0 DCLK rate in DSI mode
Date:   Thu, 27 Apr 2023 11:16:04 +0200
Message-Id: <20230427091611.99044-1-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Allwinner's BSP code, in DSI mode, TCON0 clock needs to be
running at what's effectively the per-lane datarate of the DSI link.
Given that the TCON DCLK divider is fixed to 4 (SUN6I_DSI_TCON_DIV),
DCLK can't be set equal to the dotclock. Therefore labeling TCON DCLK
as sun4i_dotclock or tcon-pixel-clock shall be avoided.

With bpp bits per pixel transmitted over n DSI lanes, the target DCLK
rate for a given pixel clock is obtained as follows:

DCLK rate = 1/4 * bpp / n * pixel clock

Effect of this change can be observed through the rate of Vblank IRQs
which should now match refresh rate implied by set display mode. It
was verified to do so on a A64 board with a 2-lane and a 4-lane panel.

v2:
1. prevent reparent of tcon0 to pll-video0-2x
2. include pll-video0 in setting TCON0 DCLK rate
3. tested the whole thing also on a PinePhone

v3:
1. accept that pll-video0 can't be included in setting TCON0 DCLK rate
2. reset pll-video0 to its default rate in case u-boot changed it

Roman Beranek (7):
  clk: sunxi-ng: a64: export PLL_MIPI
  clk: sunxi-ng: a64: prevent CLK_TCON0 being reparented
  arm64: dts: allwinner: a64: assign PLL_MIPI to CLK_TCON0
  arm64: dts: allwinner: a64: reset pll-video0 rate
  ARM: dts: sunxi: rename tcon's clock output
  drm: sun4i: rename sun4i_dotclock to sun4i_tcon_dclk
  drm: sun4i: calculate proper DCLK rate for DSI

 arch/arm/boot/dts/sun5i.dtsi                  |  2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |  2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  2 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  7 ++-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |  3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h         |  4 +-
 drivers/gpu/drm/sun4i/Makefile                |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            | 46 +++++++++++--------
 .../{sun4i_dotclock.c => sun4i_tcon_dclk.c}   |  2 +-
 .../{sun4i_dotclock.h => sun4i_tcon_dclk.h}   |  0
 include/dt-bindings/clock/sun50i-a64-ccu.h    |  1 +
 12 files changed, 44 insertions(+), 29 deletions(-)
 rename drivers/gpu/drm/sun4i/{sun4i_dotclock.c => sun4i_tcon_dclk.c} (99%)
 rename drivers/gpu/drm/sun4i/{sun4i_dotclock.h => sun4i_tcon_dclk.h} (100%)


base-commit: 40aeab044a352b9af106960542257c1b9b652e8a
-- 
2.34.1

