Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE95F40C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJDK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BED2C118
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A368461331
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0467C433D6;
        Tue,  4 Oct 2022 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664879322;
        bh=ryVpB+LKQQQ4quiFtv8DMhrBs37TnZOj1Qh2Qxiebb8=;
        h=From:To:Cc:Subject:Date:From;
        b=uoCAGHK9IvNL5yez4HaM8LeFWDgWv4HdJGlVc22aarJYXyj0RnupQ/zdfFvaHYKg+
         fR8pqliXREvhQDMFBkToD6qkZGZ9KRkutj1Ynczr6qEKdHSDebCcXYbMOekZVRzf04
         es7Thw7JFpx4Fonq3UFVHB93il3Jz5bhVViuzDZY3PctZFK1Vh7IZZvz1V/iUzVvak
         hCwTCDK51pI0WLqAolXokW/sfF9vpHR7Lpz6juGmm+URC36sEvAmDJpTHZ0pnw6C19
         FJ/Af3xyKHLzazZDh7KOE4pZjJtpBkFbQpYHMnkjPr5nZcx2m7/hvbc3dA6blUZkyv
         yqnWfbiGjj65A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     jani.nikula@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>
Subject: [PATCH 1/2] drm/i915/display: fix randconfig build
Date:   Tue,  4 Oct 2022 12:28:36 +0200
Message-Id: <20221004102837.12181-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DRM_I915=y and BACKLIGHT_CLASS_DEVICE=m, the build fails:
ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_register':
intel_backlight.c:(.text+0x5587): undefined reference to `backlight_device_get_by_name'

ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_unregister':
intel_backlight.c:(.text+0x576e): undefined reference to `backlight_device_unregister'

To fix this, use IS_REACHABLE(), not IS_ENABLED() in backlight. That is,
with the above config, backlight support is disabled.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Reported-by: Martin Liška <mliska@suse.cz>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_backlight.c | 2 +-
 drivers/gpu/drm/i915/display/intel_backlight.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index beba39a38c87..c1ba68796b6d 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -825,7 +825,7 @@ void intel_backlight_enable(const struct intel_crtc_state *crtc_state,
 	mutex_unlock(&dev_priv->display.backlight.lock);
 }
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 static u32 intel_panel_get_backlight(struct intel_connector *connector)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu/drm/i915/display/intel_backlight.h
index 339643f63897..207fe1c613d8 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.h
+++ b/drivers/gpu/drm/i915/display/intel_backlight.h
@@ -36,7 +36,7 @@ u32 intel_backlight_invert_pwm_level(struct intel_connector *connector, u32 leve
 u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
 u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
 int intel_backlight_device_register(struct intel_connector *connector);
 void intel_backlight_device_unregister(struct intel_connector *connector);
 #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
-- 
2.37.3

