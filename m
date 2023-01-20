Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D18675390
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjATLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjATLn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:43:56 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3829DCA0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=KN0W4cFj0cNukrPJD6vipzylE7T5CRhghDMb5r+iSYY=; b=v5
        LlvNmiAVpTvzhcvCm9UDD3fHdLaOC9AIG32VqlGioRrnvWSVTGPQRBxk/a/SrnJh+kG1idogG0Z5F
        4gbBv281XQ2Mfr2I2IaOrBr6QhrdMHutJ+OKB+vHDhbldcFLyWRK4gB/21dBlA6jiPEX9bS4nQij2
        cOIrDRjAAQfuw+NVcskI6ufqqYoz+333++G3Kovk3f4IsT37JeWk27MZ03XqOh8Blwue1vacnYGMI
        7aZQ3SuKgiuyLEZT2kOTlRjLgmk6q3bFO6ZMZl6ccrCIeiHNwkeTRTQCnD0amvjDeOz0Qs036gyAO
        /77HeurpSJmlwjYr+2lVEaqX0nRNkMwg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pIpnr-00007e-Tn;
        Fri, 20 Jan 2023 11:43:28 +0000
From:   John Keeping <john@metanate.com>
To:     dri-devel@lists.freedesktop.org
Cc:     John Keeping <john@metanate.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: panel: Set orientation on panel_bridge connector
Date:   Fri, 20 Jan 2023 11:43:12 +0000
Message-Id: <20230120114313.2087015-1-john@metanate.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 15b9ca1641f0 ("drm: Config orientation property if panel provides
it") added a helper to set the panel panel orientation early but only
connected this for drm_bridge_connector, which constructs a panel bridge
with DRM_BRIDGE_ATTACH_NO_CONNECTOR and creates the connector itself.

When the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is not specified and the
panel_bridge creates its own connector the orientation is not set unless
the panel does it in .get_modes which is too late and leads to a warning
splat from __drm_mode_object_add() because the device is already
registered.

Call the necessary function to set add the orientation property when the
connector is created so that it is available before the device is
registered.

Fixes: 15b9ca1641f0 ("drm: Config orientation property if panel provides it")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/bridge/panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index e8aae3cdc73d..d4b112911a99 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -81,6 +81,8 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 		return ret;
 	}
 
+	drm_panel_bridge_set_orientation(connector, bridge);
+
 	drm_connector_attach_encoder(&panel_bridge->connector,
 					  bridge->encoder);
 
-- 
2.39.1

