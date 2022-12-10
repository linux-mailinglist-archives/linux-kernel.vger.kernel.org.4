Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DCE64901B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLJSHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLJSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:07:10 -0500
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Dec 2022 10:07:07 PST
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [5.45.198.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFF178B1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:07:07 -0800 (PST)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 798FF101AF4;
        Sat, 10 Dec 2022 21:01:47 +0300 (MSK)
Received: from vla5-1ef2161cc1d7.qloud-c.yandex.net (vla5-1ef2161cc1d7.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3607:0:640:1ef2:161c])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 74E1F13E80002;
        Sat, 10 Dec 2022 21:01:47 +0300 (MSK)
Received: by vla5-1ef2161cc1d7.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id j1gRoFCZEOs1-LYqGIaIh;
        Sat, 10 Dec 2022 21:01:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skif-web.ru; s=mail; t=1670695306;
        bh=d4LSP210pPsizDp0BFbLhYh/xU1PF2q/gTxyraEFraM=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=ojObATcgxbhAkntM7e5z327TbthRoYz/QbiRZaEzjRc/gdDlqzt+2mMwf+bH6tCnQ
         aiT/mHwkFWCPVDO9y0VNtBV1qdKqZmaz5qI1EgmFTP7ASBPo7fOZ5vjvzGMyri4vwk
         cwWcU+jaVX5kLFh9NaPyO7arokanAosSrZLiHHHc=
Authentication-Results: vla5-1ef2161cc1d7.qloud-c.yandex.net; dkim=pass header.i=@skif-web.ru
From:   Alexey Lukyanchuk <skif@skif-web.ru>
To:     tvrtko.ursulin@linux.intel.com
Cc:     Alexey Lukyanchuk <skif@skif-web.ru>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] fix dell wyse 3040 poweroff 
Date:   Sat, 10 Dec 2022 21:01:19 +0300
Message-Id: <20221210180118.22087-1-skif@skif-web.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dell wyse 3040 cat't poweroff aftet kernel 5.11.
It happens  because i915_driver_shutdown function.
Disabling of this function mitigate this problem.

Fixes: 440b354f3 ("drivers/gpu/drm:power off troubles on dell wyse 3040") 
Signed-off-by: Alexey Lukyanchuk <skif@skif-web.ru> 
---
There is trouble with i915_driver_shutdown function. After some diving I found that trouble looks like race condition in drm_atomic_get_connector_state function (drivers/gpu/drm/drm_atomic.c), maybe it linked to iterators. Now I fully exclude i915_driver_shutdown for wyse 3040 device.

Can any one comment on this one please ? 
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 25 +++++++++++++++++++++
 drivers/gpu/drm/i915/i915_driver.c          |  3 +++
 drivers/gpu/drm/i915/i915_drv.h             |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index e415cd7c0..a6a549d48 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -60,6 +60,12 @@ static void quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
 	drm_info(&i915->drm, "Applying no pps backlight power quirk\n");
 }
 
+static void quirk_wyse_3040_shutdown_fix(struct drm_i915_private *i915)
+{
+	i915->quirks |= QUIRK_WYSE_3040_SHUTDOWN_FIX;
+	drm_info(&i915->drm, "Applying wyse 3040 shutdown fix\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -85,6 +91,12 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int wyse_3040_shutdown_fix(const struct dmi_system_id *id)
+{
+	DRM_INFO("This device need help with poweroff %s\n", id->ident);
+	return 1;
+}
+
 static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 	{
 		.dmi_id_list = &(const struct dmi_system_id[]) {
@@ -131,6 +143,19 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
 		},
 		.hook = quirk_no_pps_backlight_power_hook,
 	},
+	{
+		.dmi_id_list = &(const struct dmi_system_id[]) {
+			{
+				.callback = wyse_3040_shutdown_fix,
+				.ident = "Dell Inc. 0G56C0",
+				.matches = {DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+					    DMI_EXACT_MATCH(DMI_BOARD_NAME, "0G56C0"),
+				},
+			},
+			{ }
+		},
+		.hook = quirk_wyse_3040_shutdown_fix,
+	},
 };
 
 static struct intel_quirk intel_quirks[] = {
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index deb8a8b76..af60fb79a 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1079,6 +1079,9 @@ static void intel_shutdown_encoders(struct drm_i915_private *dev_priv)
 
 void i915_driver_shutdown(struct drm_i915_private *i915)
 {
+	if (!(i915->quirks & QUIRK_WYSE_3040_SHUTDOWN_FIX))
+		return;
+
 	disable_rpm_wakeref_asserts(&i915->runtime_pm);
 	intel_runtime_pm_disable(&i915->runtime_pm);
 	intel_power_domains_disable(i915);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 086bbe894..fdd6866e7 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -200,6 +200,7 @@ struct drm_i915_display_funcs {
 #define QUIRK_INCREASE_T12_DELAY (1<<6)
 #define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
 #define QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK (1<<8)
+#define QUIRK_WYSE_3040_SHUTDOWN_FIX (1<<9)
 
 struct i915_suspend_saved_registers {
 	u32 saveDSPARB;
-- 
2.25.1

