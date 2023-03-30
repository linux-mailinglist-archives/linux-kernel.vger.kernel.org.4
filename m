Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608216D0076
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjC3KAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjC3J7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:59:52 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D8130
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:59:51 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id AD06E20FA7;
        Thu, 30 Mar 2023 11:59:49 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] drm/bridge: tc358768: Add parallel data format cfg
Date:   Thu, 30 Mar 2023 11:59:40 +0200
Message-Id: <20230330095941.428122-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330095941.428122-1-francesco@dolcini.it>
References: <20230330095941.428122-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add configuration for parallel data format register, tc358768 supports
different mapping on the parallel input RGB interface, enable the
configuration for it.

Valid values, and the related meaning, are:
  0 = R[7:0], G[7:0], B[7:0]
  1 = R[1:0], G[1:0], B[1:0], R[7:2], G[7:2], B[7:2]
  2 = 8’b0, R[4:0], G[5:0], B[4:0]

Use 0 by default, consistently with the HW default.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index f4499ae7bee6..4462264274af 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -854,6 +854,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0), BIT(0));
 
+	/* PDataF: Parallel Data Format */
+	val = 0;
+	of_property_read_u32(bridge->of_node, "toshiba,input-rgb-mode", &val);
+	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(8) | BIT(9), val << 8);
+
 	/* Start DSI Tx */
 	tc358768_write(priv, TC358768_DSI_START, 0x1);
 
-- 
2.25.1

