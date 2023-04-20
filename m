Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE36E8D14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjDTIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjDTIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D753A8E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C44645FA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66E2C4339B;
        Thu, 20 Apr 2023 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681980447;
        bh=DRojeqZ6g7yN6t36jsupuApN+Q0hs/GcJWlfxdY0DDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U11jKWaGEjQE9fOFfDUs9GL7124gee3tlhiJ5VeXh/e+bqYrXHcI/E4meNXBWHS0+
         SZWdushTPXykNbM1pQnO+3qOgysmf58dXEZkP0w86vUp6mOhRSuJK1wQ0rafOsdXv3
         BeaoxsvR7R3+OSxZ7B9TH6arTlX4EOGmKyT2bauk80BHUJXanto8Yc8OMTsDnKJRIG
         Rxg+PWICvKL0HAtZhiMSIOWd3KLpN8kE3v+SH81orgaYKDxa5MpESmWOZnDxPFussj
         D4+xN3eY2reqzScCnPQhTjoSUlzfyrBHo7+EGRDBJmeVuAYPpz10aETTIq8oud+LNh
         azPEF3Rx4d4ug==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Huang <Leon.Huang1@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/amd/display: dumb_abm_lcd: avoid missing-prototype warnings
Date:   Thu, 20 Apr 2023 10:47:01 +0200
Message-Id: <20230420084711.3063453-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420084711.3063453-1-arnd@kernel.org>
References: <20230420084711.3063453-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dmub_abm_set_ambient_level() function has no caller and can
just be removed, the other ones have a declaration in the
header file and just need to see the prototype:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:122:14: error: no previous prototype for function 'dmub_abm_get_current_backlight' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:133:14: error: no previous prototype for function 'dmub_abm_get_target_backlight' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:144:6: error: no previous prototype for function 'dmub_abm_set_level' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:163:6: error: no previous prototype for function 'dmub_abm_set_ambient_level' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:183:6: error: no previous prototype for function 'dmub_abm_init_config' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:213:6: error: no previous prototype for function 'dmub_abm_set_pause' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:231:6: error: no previous prototype for function 'dmub_abm_set_pipe' [-Werror,-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:251:6: error: no previous prototype for function 'dmub_abm_set_backlight_level' [-Werror,-Wmissing-prototypes]

Fixes: b8fe56375f78 ("drm/amd/display: Refactor ABM feature")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index e152c68edfd1..39da73eba86e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -24,6 +24,7 @@
  */
 
 #include "dmub_abm.h"
+#include "dmub_abm_lcd.h"
 #include "dce_abm.h"
 #include "dc.h"
 #include "dc_dmub_srv.h"
@@ -159,27 +160,6 @@ bool dmub_abm_set_level(struct abm *abm, uint32_t level, uint8_t panel_mask)
 	return true;
 }
 
-#ifndef TRIM_AMBIENT_GAMMA
-void dmub_abm_set_ambient_level(struct abm *abm, unsigned int ambient_lux, uint8_t panel_mask)
-{
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = abm->ctx;
-
-	if (ambient_lux > 0xFFFF)
-		ambient_lux = 0xFFFF;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_set_ambient_level.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_ambient_level.header.sub_type = DMUB_CMD__ABM_SET_AMBIENT_LEVEL;
-	cmd.abm_set_ambient_level.abm_set_ambient_level_data.ambient_lux = ambient_lux;
-	cmd.abm_set_ambient_level.abm_set_ambient_level_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
-	cmd.abm_set_ambient_level.abm_set_ambient_level_data.panel_mask = panel_mask;
-	cmd.abm_set_ambient_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_ambient_level_data);
-
-	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-}
-#endif
-
 void dmub_abm_init_config(struct abm *abm,
 	const char *src,
 	unsigned int bytes,
-- 
2.39.2

