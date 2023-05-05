Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C189E6F7C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEEFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEEFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:21:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0957199D;
        Thu,  4 May 2023 22:21:29 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 440EA1BF20A;
        Fri,  5 May 2023 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1683264086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GRdOoP7K5t1Qmrug0XJy+c34os7rpF7gVntp5bQK458=;
        b=MHUcTg5y6RwNfqDH4nhHg2jVT68SY2Ni30HE0C+0bJZIHv7pXGu7TP0auq613VAvcx7Atr
        nRpeaPT5xAVxBE+vcB1RsIgtNIoIz73PQC4hma+ndYr8wOga6YbQT5yaHXm0o9iVhiRIps
        oNEPiXY+wOU37gA/U3adL9J7Ush70ixMokIFaYqqSbUmNQIvWf1Rsj70ErsszCOloyBnAp
        MtUydyM7/eo3M4M4fj7fUf2O+zTb/9m5ieB3VPFkWipEhz7rt8Zd/wBMtwwqiURu207uJD
        nmxmyelyX+jSrtuoPEen50qWTCErqWoGtethnfymqSiNQnbPbSxtUAcfwGgNaw==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] drm: sun4i: set proper TCON0 DCLK rate in DSI mode
Date:   Fri,  5 May 2023 07:21:06 +0200
Message-Id: <20230505052110.67514-1-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

v4:
1. keep pll-video0 as is
2. assign parent to TCON0 mux in sun50i_a64_ccu_probe (not in DT)

Roman Beranek (4):
  clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux
  ARM: dts: sunxi: rename tcon's clock output
  drm: sun4i: rename sun4i_dotclock to sun4i_tcon_dclk
  drm: sun4i: calculate proper DCLK rate for DSI

 arch/arm/boot/dts/sun5i.dtsi                  |  2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |  2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  2 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 14 +++++-
 drivers/gpu/drm/sun4i/Makefile                |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            | 46 +++++++++++--------
 .../{sun4i_dotclock.c => sun4i_tcon_dclk.c}   |  2 +-
 .../{sun4i_dotclock.h => sun4i_tcon_dclk.h}   |  0
 10 files changed, 46 insertions(+), 28 deletions(-)
 rename drivers/gpu/drm/sun4i/{sun4i_dotclock.c => sun4i_tcon_dclk.c} (99%)
 rename drivers/gpu/drm/sun4i/{sun4i_dotclock.h => sun4i_tcon_dclk.h} (100%)


base-commit: 8a91b29f1f50ce7742cdbe5cf11d17f128511f3f
-- 
2.32.0 (Apple Git-132)
