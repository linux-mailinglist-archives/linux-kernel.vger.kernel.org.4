Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7070F149
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjEXInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbjEXInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:43:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC835196
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:43:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97392066d04so8872066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684917810; x=1687509810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRFW8amomk7cHauT5OPSpuEFTZHvDiSnrk3yilDRGQQ=;
        b=VzO2dPId7R8TSz+9RVrYXUZgPjQlydar9Chu6+BZadQMy87hH1heZ3G5OVcAyKSxzp
         VDjJjZdlmnjy+gMlVOGTtb8VhgH6lzanw918iFjmQT+xKaCpRcVsPPHTmQRimD2aVF15
         g4juA+2Z2sYZyZ13Mbhi76rcSAmQi6OYgjh+TRyjE+3BhUnh7u1Oa3EI3RjLjcejEq5w
         Td6+p9Udgd3sPdxbZ7Op3f/zP6H0qNiMGOMbVp1VB9qvRpoATQi3YOS5IW2QIo4B0fWK
         y6H1k0gk+J3RjQjmAbfVy2nPuxeQxrRtsila/0MIM7t8TzWf5Egln4wrqJo81rAeh5L2
         0ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917810; x=1687509810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRFW8amomk7cHauT5OPSpuEFTZHvDiSnrk3yilDRGQQ=;
        b=Bpe9BlbbdOgFEh18GXKmaF14pvfjXbpJtndvkH7N2cS6l7H6i9EK1HtWHtSwtHQUR/
         mftX6kYQ4E9fodprkQq4TwBcrYfLaVyhq+KASbgzpN5xID8eD+/8VOZJYPrR0YL4LJKM
         AuAun2E65iwm94wCjvAokTgFgz5Oe59nEAxl2CIJoFnpa4x6U3QH4o0XOzFpPDqQoRSw
         5lnVt8CPvMMuzyzpBm2OwQKtNHB5OsnlowGnfvII3xT1qXZXl8RXkyNy8A3AvFbn3L4C
         tQwJoLAT0u5q5Z289EWVK4P1+ovr4mjRDHYX84Oi/JFlFlP3eJ2eCVhfUYepNhlnQB/W
         xPYQ==
X-Gm-Message-State: AC+VfDyqwjWw1dGheGenkS84rEzZwLWt/qlCvXXWoGZuLl3wrw4BoihC
        s/ITvKBgUaabwKtyOOkRq8Q=
X-Google-Smtp-Source: ACHHUZ51yrxj5JtyZU5cz8XFL1Q5VOn4jIdeSTS4cSJIBt+kn9rioJjx0Fjz5nr6NZvuPQqzGHmyEw==
X-Received: by 2002:a17:907:2d0d:b0:966:629a:884a with SMTP id gs13-20020a1709072d0d00b00966629a884amr18871266ejc.41.1684917810123;
        Wed, 24 May 2023 01:43:30 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090619ce00b0096f84292cf5sm5452854ejd.132.2023.05.24.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:43:29 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     thierry.reding@gmail.com, Nikita Travkin <nikita@trvn.ru>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Artur Weber <aweber.kernel@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>
Subject: [PATCH v2] drm/panel: samsung-s6d7aa0: use pointer for drm_mode in panel desc struct
Date:   Wed, 24 May 2023 10:43:24 +0200
Message-Id: <20230524084324.11840-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Fixes compilation issues with older GCC versions and Clang after
changes introduced in commit 6810bb390282 ("drm/panel: Add Samsung
S6D7AA0 panel controller driver"). Tested with GCC 13.1.1, GCC 6.4.0
and Clang 16.0.3.

Fixes the following errors with Clang:

  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: error: initializer element is not a compile-time constant
          .drm_mode = s6d7aa0_lsl080al02_mode,
                      ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: error: initializer element is not a compile-time constant
          .drm_mode = s6d7aa0_lsl080al03_mode,
                      ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: error: initializer element is not a compile-time constant
          .drm_mode = s6d7aa0_ltl101at01_mode,
                      ^~~~~~~~~~~~~~~~~~~~~~~
  3 errors generated.

Fixes the following errors with GCC:

  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: error: initializer element is not constant
    .drm_mode = s6d7aa0_lsl080al02_mode,
                ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:312:14: note: (near initialization for 's6d7aa0_lsl080al02_desc.drm_mode')
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: error: initializer element is not constant
    .drm_mode = s6d7aa0_lsl080al03_mode,
                ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:415:14: note: (near initialization for 's6d7aa0_lsl080al03_desc.drm_mode')
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: error: initializer element is not constant
    .drm_mode = s6d7aa0_ltl101at01_mode,
                ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c:443:14: note: (near initialization for 's6d7aa0_ltl101at01_desc.drm_mode')

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/20230523180212.GA1401867@dev-arch.thelio-3990X
Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/llvm/646c6def.a70a0220.58c1a.903d@mx.google.com
Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
v2: expanded commit message
---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index f532aa018428..102e1fc7ee38 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -37,7 +37,7 @@ struct s6d7aa0_panel_desc {
 	unsigned int panel_type;
 	int (*init_func)(struct s6d7aa0 *ctx);
 	int (*off_func)(struct s6d7aa0 *ctx);
-	const struct drm_display_mode drm_mode;
+	const struct drm_display_mode *drm_mode;
 	unsigned long mode_flags;
 	u32 bus_flags;
 	bool has_backlight;
@@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
 	.panel_type = S6D7AA0_PANEL_LSL080AL02,
 	.init_func = s6d7aa0_lsl080al02_init,
 	.off_func = s6d7aa0_lsl080al02_off,
-	.drm_mode = s6d7aa0_lsl080al02_mode,
+	.drm_mode = &s6d7aa0_lsl080al02_mode,
 	.mode_flags = MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_NO_HFP,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 
@@ -412,7 +412,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al03_desc = {
 	.panel_type = S6D7AA0_PANEL_LSL080AL03,
 	.init_func = s6d7aa0_lsl080al03_init,
 	.off_func = s6d7aa0_lsl080al03_off,
-	.drm_mode = s6d7aa0_lsl080al03_mode,
+	.drm_mode = &s6d7aa0_lsl080al03_mode,
 	.mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET,
 	.bus_flags = 0,
 
@@ -440,7 +440,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_ltl101at01_desc = {
 	.panel_type = S6D7AA0_PANEL_LTL101AT01,
 	.init_func = s6d7aa0_lsl080al03_init, /* Similar init to LSL080AL03 */
 	.off_func = s6d7aa0_lsl080al03_off,
-	.drm_mode = s6d7aa0_ltl101at01_mode,
+	.drm_mode = &s6d7aa0_ltl101at01_mode,
 	.mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET,
 	.bus_flags = 0,
 
@@ -458,7 +458,7 @@ static int s6d7aa0_get_modes(struct drm_panel *panel,
 	if (!ctx)
 		return -EINVAL;
 
-	mode = drm_mode_duplicate(connector->dev, &ctx->desc->drm_mode);
+	mode = drm_mode_duplicate(connector->dev, ctx->desc->drm_mode);
 	if (!mode)
 		return -ENOMEM;
 

base-commit: 37cee4876a45a5c3da79a83d34ed4f3c68548aef
-- 
2.40.1

