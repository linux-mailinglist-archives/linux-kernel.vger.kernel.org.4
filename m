Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B755B538D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiILF3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILF3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:16 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1AA248DF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k13so2304157ilc.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XL7ChPS99XFJL4oCOKSZfP/JHI1hyG5bYnzMTIDbg5Q=;
        b=ZPz/N1MZg7ftF0tlcoRwr9HNj0wMrzzU21myESb5DbbDCQo4xNwx0qr2GossY/Q+uO
         ZdpsYR6a9TLoWWI0eDoBTYm4MnozH77pypOSGaDyQIl4oefREBwcO/EJS16nj18QJtwq
         0TwpXRFSqPJodz6YVHbri98npEro/MGK6/DNd2yaWRYDZS/AV7i5FvuiVN1NH6w9hDQX
         f3U/bWFDOcVK9ezCKsiVEVx1FsO0cVIIZUyHq0XODhXrol856oqiGW4oq7Evgh4EM5oO
         lRuFkAM/jpe7Ztz6wB17kJCX/13m/ha0hPZ/RzLt0H9haHMTvpcVsVvKOa+E/Rlucqbh
         muxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XL7ChPS99XFJL4oCOKSZfP/JHI1hyG5bYnzMTIDbg5Q=;
        b=c5py7ZTLAdr+7vYR6I+jbaju4VOXPBLVma975uOhzQEVuOCEF5MdOE+eBY7Z4rVRp1
         2FjD5nn0nNoWPS3YXWHBTyetoUuKXRcnxdVtNDRzHn9s9obWtsSd7X9vsZ3CPLKxTV+b
         inUVIhT6cF0j8kWw4CcTH7ZYH9ZXv8mu9+8OSXVmzuS5sR6WdoHRtcxt30mlyHwkyMoM
         8BuoQbUAbd+F9VqIPFKdznGhmPn38dGzvRUHhQliNv1hWRrt/amVIMdTWrxqO5SKvxP8
         1atUDCwBEToVmi8nSSX3ULco4jmRcWTJtgADBGBn1LjEML9SXy1kkAh+FWnBqqtkJvxe
         FoZA==
X-Gm-Message-State: ACgBeo3GTuHYkj6KBPOFmLe2Xe9ZdK16Z1OaEpQPhmdNCibQxmXJBP+e
        MA/+DQ+Sdj9uL4kYl8daWYU=
X-Google-Smtp-Source: AA6agR47BQemS+MqJvt/2ptLpkQUnDhJDO4pC9EpCD+Bj0LzBAng5f40HRcbFyGQO4ZMBWidtzdolA==
X-Received: by 2002:a05:6e02:2195:b0:2eb:8a31:43d8 with SMTP id j21-20020a056e02219500b002eb8a3143d8mr9194040ila.315.1662960552177;
        Sun, 11 Sep 2022 22:29:12 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 7/9] drm_print: optimize drm_debug_enabled for jump-label
Date:   Sun, 11 Sep 2022 23:28:50 -0600
Message-Id: <20220912052852.1123868-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220912052852.1123868-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DRM_USE_DYNAMIC_DEBUG=y, the drm.debug API (a macro stack,
calling _+drm_*dbg() eventually) invokes a dyndbg Factory macro to
create a descriptor for each callsite, thus making them individually
>control-able.

In this case, the calls to _drm_*dbg are unreachable unless the
callsite is enabled.  So those calls can short-circuit their early
do-nothing returns.  Provide and use __drm_debug_enabled(), to do this
when config'd, or the _raw flags-check otherwize.

And since dyndbg is in use, lets also instrument the remaining users
of drm_debug_enabled, by wrapping the _raw in a macro with a:

  pr_debug("todo: is this frequent enough to optimize ?\n");

For CONFIG_DRM_USE_DYNAMIC_DEBUG=n, do no site instrumenting at all,
since JUMP_LABEL might be off, and we don't want to make work.

With drm, amdgpu, i915, nouveau loaded, heres remaining uses of
drm_debug_enabled(), which costs ~1.5kb data to control the
pr_debug("todo:..")s.

Some of those uses might be ok to use __drm_debug_enabled() by
inspection, others might warrant conversion to use dyndbg Factory
macros, and that would want callrate data to estimate the savings
possible.  TBH, any remaining savings are probably small; drm.debug
covers the vast bulk of the uses.  Maybe "vblank" is the exception.

:#> grep todo /proc/dynamic_debug/control | wc
     21     168    2357
:#> grep todo /proc/dynamic_debug/control
drivers/gpu/drm/drm_edid_load.c:178 [drm]edid_load =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:410 [drm]drm_crtc_accurate_vblank_count =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:787 [drm]drm_crtc_vblank_helper_get_vblank_timestamp_internal =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:1491 [drm]drm_vblank_restore =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_vblank.c:1433 [drm]drm_vblank_enable =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/drm_plane.c:2168 [drm]drm_mode_setplane =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:1359 [drm_display_helper]drm_dp_mst_wait_tx_reply =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:2864 [drm_display_helper]process_single_tx_qlock =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:2909 [drm_display_helper]drm_dp_queue_down_tx =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/display/drm_dp_mst_topology.c:1686 [drm_display_helper]drm_dp_mst_update_slots =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_dp.c:1111 [i915]intel_dp_print_rates =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_backlight.c:5434 [i915]cnp_enable_backlight =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_backlight.c:5459 [i915]intel_backlight_device_register =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_opregion.c:43 [i915]intel_opregion_notify_encoder =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_opregion.c:53 [i915]asle_set_backlight =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_bios.c:1088 [i915]intel_bios_is_dsi_present =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/display/intel_display_debugfs.c:6153 [i915]i915_drrs_ctl_set =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/intel_pcode.c:26 [i915]snb_pcode_read =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/i915/i915_getparam.c:785 [i915]i915_getparam_ioctl =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:282 [amdgpu]vcn_v2_5_process_interrupt =_ "todo: maybe avoid via dyndbg\n"
drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:433 [amdgpu]vcn_v2_0_process_interrupt =_ "todo: maybe avoid via dyndbg\n"
:#>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
- simplify drm-debug-enabled choices, @DanVet
---
 drivers/gpu/drm/drm_print.c |  4 ++--
 include/drm/drm_print.h     | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 29a29949ad0b..cb203d63b286 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -285,7 +285,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
@@ -308,7 +308,7 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index dfdd81c3287c..9af57d3df259 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -321,11 +321,30 @@ enum drm_debug_category {
 	DRM_UT_DRMRES
 };
 
-static inline bool drm_debug_enabled(enum drm_debug_category category)
+static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
 {
 	return unlikely(__drm_debug & BIT(category));
 }
 
+#define drm_debug_enabled_instrumented(category)			\
+	({								\
+		pr_debug("todo: is this frequent enough to optimize ?\n"); \
+		drm_debug_enabled_raw(category);			\
+	})
+
+#if defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+/*
+ * the drm.debug API uses dyndbg, so each drm_*dbg macro/callsite gets
+ * a descriptor, and only enabled callsites are reachable.  They use
+ * the private macro to avoid re-testing the enable-bit.
+ */
+#define __drm_debug_enabled(category)	true
+#define drm_debug_enabled(category)	drm_debug_enabled_instrumented(category)
+#else
+#define __drm_debug_enabled(category)	drm_debug_enabled_raw(category)
+#define drm_debug_enabled(category)	drm_debug_enabled_raw(category)
+#endif
+
 /*
  * struct device based logging
  *
-- 
2.37.3

