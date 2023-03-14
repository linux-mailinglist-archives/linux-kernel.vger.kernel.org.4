Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3A6B91FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCNLqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjCNLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:46:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA495E29
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:45:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k2so8402933pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678794349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qV3+UTpq0pSz8mRuhUKGGTuipB28dMrQVCgnigpzu1A=;
        b=O2B7CVGfEgWoI6RYFDWPugPGwgPAETohlAGWwrHjyPunHR5yEIt1R3oBNw2xqNBzuR
         cfG0Wiwm+Q/piOb2kw5qZwnKh5t56N3vVWwGB76aEYE1yLs0/fCfssteSt2Fjhx5gmit
         zv280aTKo/+pGmWKfqm6A3T9jEFmlr0FqWjl+hHIpMIRYb7gEq4+3nlBY71Kyc0Xjxl4
         j/kfPqgBjBFltqN4iatQWK7dO9RO2eLIDMLIHctDuPPNat5Kg7G4Xju+AvxV3hc+EB/N
         aS4ziw4svSiL3+hRQCpzlZMKiJpwhJm52J2ZkxnxbhkeE0UXiUBDNJH+Lx3j64JtpMeF
         MeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678794349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qV3+UTpq0pSz8mRuhUKGGTuipB28dMrQVCgnigpzu1A=;
        b=gqOgbR2m5mfcyu6GwwvDarT3kBGqcwb91Ytnx2KWcyALyoxi13P16OLguYQwk4+PEK
         R0CN/X3RuQrrUvk1H2UfJ8NRV1JZQO2sk0wdHDLuQwq/T9g6i4h0xM4fTCqYJCUbCrdP
         gx8cFDK9tME5j/N9lxVLgyytQrGBSq58lLPkhGz73/B7Z0zTTkx+SlFuGgMP71WrvOQD
         to88JQPQKONScCjqc+R8OPl3S/TPkxenWwJzm0b9nG6YVXM7D7j090dnXnz2B1lW97Sk
         PAd9oIiHY977Ac1nnhmhxpOfIyQzI+TVLaXiFWMavIYoWsNRCreUwBV14URPOC14FdHh
         pNNA==
X-Gm-Message-State: AO0yUKUmOYDVqu02uOd95hkS2kPVKI4xkg2aITL9FOTnHwsSvU4O9YHb
        EmqntB5hhM/B/C8dHwG+UZIM0DYttwc=
X-Google-Smtp-Source: AK7set9PKfihUYTXB8p+orPWZbQgLOddt/tlxE2NkCMzZJS9SJRZO8ZIWfXsulm4WK7zjuOS8xRniw==
X-Received: by 2002:a17:90b:2241:b0:237:29b1:1893 with SMTP id hk1-20020a17090b224100b0023729b11893mr37600112pjb.46.1678794349047;
        Tue, 14 Mar 2023 04:45:49 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902a5c300b0019a6e8ceb49sm1540101plq.259.2023.03.14.04.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 04:45:48 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] drm/panel: Fix panel mode type setting logic
Date:   Tue, 14 Mar 2023 19:44:51 +0800
Message-Id: <20230314114451.8872-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some panels set mode type to DRM_MODE_TYPE_PREFERRED by the number
of modes. It isn't reasonable, so set the first mode type to
DRM_MODE_TYPE_PREFERRED. This should be more reasonable.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c     | 2 +-
 drivers/gpu/drm/panel/panel-auo-a030jtn01.c      | 2 +-
 drivers/gpu/drm/panel/panel-edp.c                | 4 ++--
 drivers/gpu/drm/panel/panel-innolux-ej030na.c    | 2 +-
 drivers/gpu/drm/panel/panel-newvision-nv3051d.c  | 2 +-
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c  | 2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c    | 2 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c    | 2 +-
 drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 2 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c      | 4 ++--
 drivers/gpu/drm/panel/panel-simple.c             | 4 ++--
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
index 1cc0f1d09684..9ce62513e3a5 100644
--- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
+++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
@@ -240,7 +240,7 @@ static int y030xx067a_get_modes(struct drm_panel *panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
index 3c976a98de6a..3850dc5a1eb1 100644
--- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
+++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
@@ -151,7 +151,7 @@ static int a030jtn01_get_modes(struct drm_panel *panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 01bfe0783304..df7e59485793 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -260,7 +260,7 @@ static unsigned int panel_edp_get_timings_modes(struct panel_edp *panel,
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
 
-		if (panel->desc->num_timings == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
@@ -289,7 +289,7 @@ static unsigned int panel_edp_get_display_modes(struct panel_edp *panel,
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
 
-		if (panel->desc->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_set_name(mode);
diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
index b2b0ebc9e943..6c49c93eaa23 100644
--- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
+++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
@@ -166,7 +166,7 @@ static int ej030na_get_modes(struct drm_panel *panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
index a07958038ffd..65ff9a3df62a 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
@@ -331,7 +331,7 @@ static int panel_nv3051d_get_modes(struct drm_panel *panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index cf078f0d3cd3..70a7b36c2956 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -347,7 +347,7 @@ static int nv3052c_get_modes(struct drm_panel *panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index abf752b36a52..62f7895af072 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -508,7 +508,7 @@ static int nt35950_get_modes(struct drm_panel *panel,
 		drm_mode_set_name(mode);
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
-		if (nt->desc->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index f58cfb10b58a..7938dd68f4f4 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -216,7 +216,7 @@ static int nt39016_get_modes(struct drm_panel *drm_panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
index e46be5014d42..d232c02eba20 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
@@ -206,7 +206,7 @@ static int ota5601a_get_modes(struct drm_panel *drm_panel,
 		drm_mode_set_name(mode);
 
 		mode->type = DRM_MODE_TYPE_DRIVER;
-		if (panel_info->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 76160e5d43bd..dad103615c7f 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -80,7 +80,7 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel,
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
 
-		if (panel->desc->num_timings == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
@@ -100,7 +100,7 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel,
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
 
-		if (panel->desc->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_set_name(mode);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 065f378bba9d..fc617969c2be 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -185,7 +185,7 @@ static unsigned int panel_simple_get_timings_modes(struct panel_simple *panel,
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
 
-		if (panel->desc->num_timings == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_probed_add(connector, mode);
@@ -214,7 +214,7 @@ static unsigned int panel_simple_get_display_modes(struct panel_simple *panel,
 
 		mode->type |= DRM_MODE_TYPE_DRIVER;
 
-		if (panel->desc->num_modes == 1)
+		if (i == 0)
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		drm_mode_set_name(mode);
-- 
2.39.2

