Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B2D63ED09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLAJ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiLAJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:56:52 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420CB89ADA;
        Thu,  1 Dec 2022 01:56:51 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 563D22D9;
        Thu,  1 Dec 2022 10:56:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669888609;
        bh=lU6WFQO+ANPHh+59bZX1mhx10a4JQsmhkgd4Z7i9JxY=;
        h=From:To:Cc:Subject:Date:From;
        b=wFBq5XU4Uso7tqsIOn7UU1ogQtahSun3K7AO/aos19wrZ0271qTViOzDEKMEUhbY1
         j5k2q5Sc4y+lWCytRFzFRs1X90Rvv1K+qU8vf5ga8TSCJfk7SgAhcsYiUOCXQwyWRI
         PC6YqQyiNeVNKl7cXU5knXqbmfMnT3ZMPUXaC25s=
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v5 0/7] Renesas V4H DSI & DP output support
Date:   Thu,  1 Dec 2022 11:56:24 +0200
Message-Id: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Hi,

These add support for DSI on V4H SoC (r8a779g0) and DP for Whitehawk
board.

I'm sending the full series for clarity.

Changes to v4:

- Changes in "clk: renesas: r8a779g0: Add display related clocks":
	* Fix formatting
	* Use R8A779G0_CLK_VIOBUSD2 as the source for all video related
	  clocks.

 Tomi

Tomi Valkeinen (7):
  dt-bindings: display: renesas,du: Provide bindings for r8a779g0
  dt-bindings: display: bridge: renesas,dsi-csi2-tx: Add r8a779g0
  clk: renesas: r8a779g0: Add display related clocks
  arm64: dts: renesas: r8a779g0: Add display related nodes
  arm64: dts: renesas: white-hawk-cpu: Add DP output support
  drm: rcar-du: Add r8a779g0 support
  drm: rcar-du: dsi: Add r8A779g0 support

 .../display/bridge/renesas,dsi-csi2-tx.yaml   |   3 +-
 .../bindings/display/renesas,du.yaml          |   2 +
 .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi  |  94 ++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     | 130 +++++
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       |   9 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  22 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c       |   2 +-
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c       | 497 +++++++++++++-----
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h  |   6 +-
 9 files changed, 635 insertions(+), 130 deletions(-)

-- 
2.34.1

