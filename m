Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B36390AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKYUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKYUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:31:15 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E031370
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:31:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:d898:271f:7512:e47f])
        by michel.telenet-ops.be with bizsmtp
        id okX62800N4su47u06kX6c2; Fri, 25 Nov 2022 21:31:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oyfLj-001aQ7-Sv; Fri, 25 Nov 2022 21:31:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oyfLj-003Kwy-F9; Fri, 25 Nov 2022 21:31:03 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 1/2] drm/modes: parse_cmdline: Make mode->*specified handling more uniform
Date:   Fri, 25 Nov 2022 21:31:00 +0100
Message-Id: <a1eb3580021afc5a6a50c8f049d78c66ab8c7177.1669405382.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669405382.git.geert@linux-m68k.org>
References: <cover.1669405382.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various mode->*specified flags are not handled in an uniform way:
some flags are set by the corresponding drm_mode_parse_cmdline_*()
function, some flags by the caller of the function, and some flags by
both.

Make this uniform by making this the responsibility of the various
parsing helpers, i.e.
  - Move the setting of mode->specified from caller to callee,
  - Drop the duplicate setting of mode->bpp_specified and
    mode->refresh_specified from callers.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
v3:
  - Add Acked-by,

v2:
  - Add Reviewed-by, Acked-by,
---
 drivers/gpu/drm/drm_modes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 3c8034a8c27bd25a..45b9e6aab766002a 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1605,6 +1605,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 	mode->yres = yres;
 	mode->cvt = cvt;
 	mode->rb = rb;
+	mode->specified = true;
 
 	return 0;
 }
@@ -1921,8 +1922,6 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 						      mode);
 		if (ret)
 			return false;
-
-		mode->specified = true;
 	}
 
 	/* No mode? Check for freestanding extras and/or options */
@@ -1944,8 +1943,6 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 		ret = drm_mode_parse_cmdline_bpp(bpp_ptr, &bpp_end_ptr, mode);
 		if (ret)
 			return false;
-
-		mode->bpp_specified = true;
 	}
 
 	if (refresh_ptr) {
@@ -1953,8 +1950,6 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 						     &refresh_end_ptr, mode);
 		if (ret)
 			return false;
-
-		mode->refresh_specified = true;
 	}
 
 	/*
-- 
2.25.1

