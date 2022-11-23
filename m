Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE586350C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiKWHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiKWHA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:00:27 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D11ED714;
        Tue, 22 Nov 2022 23:00:26 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34BC288F;
        Wed, 23 Nov 2022 08:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669186824;
        bh=Knz0JCCrfCqQxJejdfCSEXVWPhZVH+yr9Z4AiAaBvFg=;
        h=From:To:Cc:Subject:Date:From;
        b=oRRanw51554oiR9W7rj4aus04gF+aGASx6InEVVf73OEMWWbYnl1jgaPxSFCiL5w1
         gGYB856SbsrKDl6gJxt1XEON195cLORWienlYPruWVzg1GUpaUTOvhCcroJ6/N5Ska
         w0hCCsucGs5sdv73p3jqDpECgOkBIMHoCgozUSY8=
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
Subject: [PATCH v2 0/7] Renesas V4H DSI & DP output support
Date:   Wed, 23 Nov 2022 08:59:39 +0200
Message-Id: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
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

Changes in v2:
- A few cosmetic changes
- Increase vspd address range in dts to 0x7000
- Arrange nodes in dts by the block address
- Use gen = 4 for r8a779g0 du
- Drop the CLOCKSET1 hack patch

The CLOCKSET1 patch is apparently not needed to get the DSI & DP
working. Which is baffling, as I'm quite sure it was needed. There are a
few possible explanations: 1) it was never needed and I was just messing
things up, 2) it was needed, but some of my later improvements made it
unnecessary, 3) Whitehawk board firmware was updated in the middle of
the development of this series, possibly the firmware made the patch
unnecessary.

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
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       |  14 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  22 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c       |   2 +-
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c       | 484 ++++++++++++++----
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h  |   6 +-
 9 files changed, 649 insertions(+), 108 deletions(-)

-- 
2.34.1

