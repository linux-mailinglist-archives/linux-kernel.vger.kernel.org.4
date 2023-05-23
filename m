Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB65D70E740
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjEWVVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWVU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:20:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E1E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:20:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96aae59bbd6so13001366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684876855; x=1687468855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77vshvp41bukXkaBQCstB9hsqVQeWFOjbLVsOOf4RiY=;
        b=hFvGXinPKssThZK/pAXYPEm+Ow3eMYAZmIQER5Ts6cdvS9WIhb6MsfLRBAszf/WYFo
         rO1/L4178BJcYM8ITpbhPf7xU+uHaEYYsc4apo1Du/d2diSsZX6CbxbWlb6x3uYGXsRo
         sf2IsWiW/eUkB3rrMjNiEzMtUy0wUZ+r9za6w9Mez7NmN33RZvRQp4EPdqwjgWGOtB7g
         w3T+RmdYvpKAJEk6XjB7+SC7aa3Ip6IFTu3ksQhWo+slA8Mg2F12O2TvPQrhxfr/ywWf
         nla6JITgJOrIe/Ma+mlSsnLjgaWYdJWmHk3edjRWVqRWHBL7vfLEMi+VstrodS5zClzy
         KuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684876855; x=1687468855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77vshvp41bukXkaBQCstB9hsqVQeWFOjbLVsOOf4RiY=;
        b=cZrR7xrbM7MtE845Lonp/qdN4yUD0qmd7kAocfm/joH28Qro556fHCgQJrtkRWT7WD
         0z0FwBHQ26HH1+XBC0fV8gcGV45U0k+ldUjEd56NEeIRDqqsRWwwRIvBWZLDg5m2ydnj
         TXJaoRXF50UTEZ4bc7SVpv+uU2yeBT6pqi9i3he9aE5Ed1zTroV9R3rLN44ooO8RBdYs
         p11HNVanmo+x7l3OFOK3xsIOoKBpG1dxKeBeGzjIOBMuLl6YE66m8wNUktv9KYINoXvH
         pFzQfL3XUyT3xt7PdBmxHy+CvGrgcfOA/uAwcHPEs4oSFlMwh1lP9svwPyvSEIB57YFq
         W7Xw==
X-Gm-Message-State: AC+VfDxk5Zh01BgzjfqNbWMtrxFGZ4ZyMPCX6XDVa3yL8ialW8DTuR9c
        5FvU3h6DcLfm37Cg1nUKu8k=
X-Google-Smtp-Source: ACHHUZ7w6Xn++2uHIoRKaXVLEbyMFKPna0sHTuomnld3Bm1/QCiT6F1yZT/MA3bMW2bH/J7nd+adpg==
X-Received: by 2002:a17:907:26ca:b0:969:bac4:8e22 with SMTP id bp10-20020a17090726ca00b00969bac48e22mr13848584ejc.26.1684876855458;
        Tue, 23 May 2023 14:20:55 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id kl3-20020a170907994300b00966392de4easm4856953ejc.14.2023.05.23.14.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:20:55 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, thierry.reding@gmail.com,
        David Airlie <airlied@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH] drm/panel: samsung-s6d7aa0: use pointer for drm_mode in panel desc struct
Date:   Tue, 23 May 2023 23:20:50 +0200
Message-Id: <20230523212050.9970-1-aweber.kernel@gmail.com>
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

Fixes compilation errors on older GCC versions (before 8.x) and Clang
after changes introduced in commit 6810bb390282 ("drm/panel: Add
Samsung S6D7AA0 panel controller driver"). Tested with GCC 13.1.1,
GCC 6.4.0 and Clang 16.0.3.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
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

