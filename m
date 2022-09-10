Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A95B4AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIJWwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIJWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:52:19 -0400
X-Greylist: delayed 203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Sep 2022 15:52:18 PDT
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82B4F186
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:52:18 -0700 (PDT)
Received: from MTA-10-4.privateemail.com (mta-10-1.privateemail.com [68.65.122.30])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id 04BEB6141B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 22:48:54 +0000 (UTC)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id 1819218000A1;
        Sat, 10 Sep 2022 18:48:52 -0400 (EDT)
Received: from hal-station.. (bras-base-toroon4321w-grc-49-76-69-77-8.dsl.bell.ca [76.69.77.8])
        by mta-10.privateemail.com (Postfix) with ESMTPA id 756A618000A2;
        Sat, 10 Sep 2022 18:48:37 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: it6505: use drm_debug_enabled() in it6505_debug_print()
Date:   Sat, 10 Sep 2022 18:48:16 -0400
Message-Id: <20220910224816.15058-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As made mention of in commit 9f0ac028410f ("drm/print: rename drm_debug
to __drm_debug to discourage use"), we shouldn't explicitly refer to
__drm_debug in this context. So, use drm_debug_enabled() instead.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 4b673c4792d7..875f87c576cb 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -554,7 +554,7 @@ static void it6505_debug_print(struct it6505 *it6505, unsigned int reg,
 	struct device *dev = &it6505->client->dev;
 	int val;
 
-	if (likely(!(__drm_debug & DRM_UT_DRIVER)))
+	if (!drm_debug_enabled(DRM_UT_DRIVER))
 		return;
 
 	val = it6505_read(it6505, reg);
-- 
2.37.3

