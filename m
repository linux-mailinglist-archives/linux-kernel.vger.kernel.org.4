Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA369F650
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjBVOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjBVOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:18:06 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090CA211B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:18:03 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 91652C800A8;
        Wed, 22 Feb 2023 15:18:01 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1677075481; x=1678889882; bh=Dr
        Ii1vuCf0M2qkQQn1lUvMJ7ABWpWQc5qIqqv1HPM50=; b=Fq9S7N0c+dEIgnEHyc
        On4fqdsfakUPcCu8AU0KxA+72yqCncWNwK6E20AmhN3NjRgP0OxedOLuiE02WjTK
        lp8oXvdtB4lCDdRBIFj6l60uo4brLpDJT87FRbbBdCrfdYiWtr9LtXmEAveT0AcE
        UwUR33QIsWI1z9EwZ8eCww7bQ=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id ssDc2LTHyjkA; Wed, 22 Feb 2023 15:18:01 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 5CECEC800A5;
        Wed, 22 Feb 2023 15:18:00 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, jose.souza@intel.com,
        jouni.hogander@intel.com, mika.kahola@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        Diego.SantaCruz@spinetix.com, wse@tuxedocomputers.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Add quirk to disable PSR 2 on a per device basis
Date:   Wed, 22 Feb 2023 15:17:54 +0100
Message-Id: <20230222141755.1060162-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222141755.1060162-1-wse@tuxedocomputers.com>
References: <20230222141755.1060162-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the possibility to disable PSR 2 explicitly using the intel
quirk table for devices where PSR 2 is borked, but PSR 1 works fine.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c    | 4 +++-
 drivers/gpu/drm/i915/display/intel_quirks.c | 6 ++++++
 drivers/gpu/drm/i915/display/intel_quirks.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 5b678916e6db5..4607f3c4cf592 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -37,6 +37,7 @@
 #include "intel_psr.h"
 #include "intel_snps_phy.h"
 #include "skl_universal_plane.h"
+#include "intel_quirks.h"
 
 /**
  * DOC: Panel Self Refresh (PSR/SRD)
@@ -851,7 +852,8 @@ static bool intel_psr2_config_valid(struct intel_dp *intel_dp,
 	int crtc_vdisplay = crtc_state->hw.adjusted_mode.crtc_vdisplay;
 	int psr_max_h = 0, psr_max_v = 0, max_bpp = 0;
 
-	if (!intel_dp->psr.sink_psr2_support)
+	if (!intel_dp->psr.sink_psr2_support ||
+	    intel_has_quirk(dev_priv, QUIRK_NO_PSR2))
 		return false;
 
 	/* JSL and EHL only supports eDP 1.3 */
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 6e48d3bcdfec5..ce6d0fe6448f5 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -65,6 +65,12 @@ static void quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
 	drm_info(&i915->drm, "Applying no pps backlight power quirk\n");
 }
 
+static void quirk_no_psr2(struct drm_i915_private *i915)
+{
+	intel_set_quirk(i915, QUIRK_NO_PSR2);
+	drm_info(&i915->drm, "Applying No PSR 2 quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 10a4d163149fd..2e0b788a44a1e 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -17,6 +17,7 @@ enum intel_quirk_id {
 	QUIRK_INVERT_BRIGHTNESS,
 	QUIRK_LVDS_SSC_DISABLE,
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
+	QUIRK_NO_PSR2,
 };
 
 void intel_init_quirks(struct drm_i915_private *i915);
-- 
2.34.1

