Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D8638818
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKYLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiKYLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:00:54 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 03:00:53 PST
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435814A5AE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:00:53 -0800 (PST)
Received: from localhost.localdomain (unknown [103.29.142.67])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id DB18820463;
        Fri, 25 Nov 2022 18:54:07 +0800 (CST)
From:   Qiqi Zhang <eddy.zhang@rock-chips.com>
To:     dianders@chromium.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qiqi Zhang <eddy.zhang@rock-chips.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Fix output polarity setting bug
Date:   Fri, 25 Nov 2022 18:45:58 +0800
Message-Id: <20221125104558.84616-1-eddy.zhang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEgfVh8fSk9NSxgfHR5CS1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46Pxw4Ej0uFho0GhYKPAEq
        HBoKCUJVSlVKTU1CSExITU9CS0NMVTMWGhIXVR4fHwJVARMaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNSk83Bg++
X-HM-Tid: 0a84ae6c5ef12eb6kusndb18820463
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the description in ti-sn65dsi86's datasheet:

CHA_HSYNC_POLARITY:
0 = Active High Pulse. Synchronization signal is high for the sync
pulse width. (default)
1 = Active Low Pulse. Synchronization signal is low for the sync
pulse width.

CHA_VSYNC_POLARITY:
0 = Active High Pulse. Synchronization signal is high for the sync
pulse width. (Default)
1 = Active Low Pulse. Synchronization signal is low for the sync
pulse width.

We should only set these bits when the polarity is negative.
Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 3c3561942eb6..eb24322df721 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -931,9 +931,9 @@ static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata)
 		&pdata->bridge.encoder->crtc->state->adjusted_mode;
 	u8 hsync_polarity = 0, vsync_polarity = 0;
 
-	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		hsync_polarity = CHA_HSYNC_POLARITY;
-	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		vsync_polarity = CHA_VSYNC_POLARITY;
 
 	ti_sn65dsi86_write_u16(pdata, SN_CHA_ACTIVE_LINE_LENGTH_LOW_REG,
-- 
2.25.1

