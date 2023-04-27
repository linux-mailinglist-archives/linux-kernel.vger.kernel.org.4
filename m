Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C86F0773
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244061AbjD0Oa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbjD0OaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:30:19 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32F5BAD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:29:44 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 6502D20B47;
        Thu, 27 Apr 2023 16:29:39 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] drm/bridge: tc358768: various fixes on PLL calculation and DSI timings
Date:   Thu, 27 Apr 2023 16:29:25 +0200
Message-Id: <20230427142934.55435-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series includes multiple fixes on the tc358768 parallel RGB to DSI driver.

With the following changes I am able to have a stable display output using a TI
SN65DSI83 (DSI-LVDS bridge) and a 1280 x 800 LVDS display panel and the
register values are coherent with Toshiba documentation and configuration
spreadsheet, I was not able to test any other display sink.

= DSI Video Mode =

The driver uses the MIPI_DSI_MODE_LPM flag not correctly, because of that no HS
Video is sent at all when this flag is set by the DSI slave.

= DSI Timing Parameters =

Multiple DSI timing parameters are not correct and this was leading to black or
not stable images on some display output. The new formulas were verified with
the datasheet and a configuration spread sheet from Toshiba.

I did split the change in multiple commits, I can squash all of them together
if this is considered better for any reason, including bisect-ability.

= PLL computation =

Two issues on the PLL computation, one is a required fix to have the bridge
working when the parallel RGB input width is not 24, the second one is just
following a prescription from the Toshiba documentation. In my test it was not
making any difference.

Francesco Dolcini (9):
  drm/bridge: tc358768: always enable HS video mode
  drm/bridge: tc358768: fix PLL parameters computation
  drm/bridge: tc358768: fix PLL target frequency
  drm/bridge: tc358768: fix TCLK_ZEROCNT computation
  drm/bridge: tc358768: fix TCLK_TRAILCNT computation
  drm/bridge: tc358768: fix THS_ZEROCNT computation
  drm/bridge: tc358768: fix TXTAGOCNT computation
  drm/bridge: tc358768: fix THS_TRAILCNT computation
  drm/bridge: tc358768: remove unused variable

 drivers/gpu/drm/bridge/tc358768.c | 53 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

-- 
2.25.1

