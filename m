Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866870C2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjEVPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVPv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:51:29 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A684A9;
        Mon, 22 May 2023 08:51:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-76fe43b85e4so253093939f.1;
        Mon, 22 May 2023 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770688; x=1687362688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhuzJwhh6mnZlX4PQopnboCuSOMKbOzXG9sCr2vCvAE=;
        b=GyKNmw4M61HlUKBmnJPPQdV+xuIVSgNOTjin1tPfYgKQLY3lqXt9GGGeg3LqIHYLuk
         DhfNvaXVBWierYQ+zWgQgKWuqQzJ9TDqVHzXLwSezPx1I6pxysuLL0Dpg7MU7suOGtxi
         rkdXMOtlu9u70RUnNqCmkBV0yP+uLHGk5rVxvE9Xa7CwRT8fFnd5qxB0ik20mz6mWuuw
         VPF3Rkfwd3qnZKRpY+RO52vO9TFiZ6tRCI/idfRjWUw0pFHBFLNd9YiWTvY3Pp7C3pOx
         4KX1Jhxo9eCTsypu+avRJ02gkinD3l7v1LADVIbK6QzrCXpVO0fH1rVf8+rxH7HIGyD7
         LYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770688; x=1687362688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhuzJwhh6mnZlX4PQopnboCuSOMKbOzXG9sCr2vCvAE=;
        b=gPP5GmmmK2FdJVo3tpvEvG/4owKmWlY19mpK6x6R1B9ANjex5/vI3a1TsTRJxGxHd9
         1hFylwJ8OBYJXEy7yW01QkRbNUNVZYxWZeLj58fhqO9KCqLYNejonPR1ex9uZ1i3Nkl4
         L3AoXfQlN0IgQi3F8xNSz/9a3v9l1Uju6Vu+DqiYJ8hX53X8ZcpSVs1A1TSQ820CINi6
         0dUH5+GCX49I35yh3jH+6fkDDxI21ItMZvpNY43ODn/fojPCHgqkucHD1KH31RY49pc1
         TQIJ7xEJhtrg+4HqlEWw+2Hk2WABRscfPvj2UCjpwqO3XHmXiy1RvpxX3iBa74n8anga
         Bf3g==
X-Gm-Message-State: AC+VfDxjA7dgzhxvzP1i2ShKPHQNVdrlV5pbJqEvI8spmRg7JBwy+Qbf
        4waaMOGJpQPJRUYaDv46yG0=
X-Google-Smtp-Source: ACHHUZ50S0WdrHtGiSqdzAgGyIj68c4wFN8q4WJZnLuyt1t64JmYhQnvvzndzV1N5JjZUZhaApRjpQ==
X-Received: by 2002:a92:c98b:0:b0:335:2e4c:f0e5 with SMTP id y11-20020a92c98b000000b003352e4cf0e5mr6867585iln.13.1684770688239;
        Mon, 22 May 2023 08:51:28 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id b7-20020a056638150700b0040fbb3bd38csm1831753jat.145.2023.05.22.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:51:27 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Lyude Paul <lyude@redhat.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/display/dp_mst: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 15:51:24 +0000
Message-ID: <20230522155124.2336545-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c       |    2 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c |    2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 16565a0a5da6..e6a78fd32380 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2103,7 +2103,7 @@ int drm_dp_aux_register(struct drm_dp_aux *aux)
 	aux->ddc.owner = THIS_MODULE;
 	aux->ddc.dev.parent = aux->dev;
 
-	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(aux->dev),
+	strscpy(aux->ddc.name, aux->name ? aux->name : dev_name(aux->dev),
 		sizeof(aux->ddc.name));
 
 	ret = drm_dp_aux_register_devnode(aux);
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 38dab76ae69e..8f7403149b2b 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5702,7 +5702,7 @@ static int drm_dp_mst_register_i2c_bus(struct drm_dp_mst_port *port)
 	aux->ddc.dev.parent = parent_dev;
 	aux->ddc.dev.of_node = parent_dev->of_node;
 
-	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(parent_dev),
+	strscpy(aux->ddc.name, aux->name ? aux->name : dev_name(parent_dev),
 		sizeof(aux->ddc.name));
 
 	return i2c_add_adapter(&aux->ddc);
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 3fd6c733ff4e..6252ac01e945 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -223,7 +223,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 
 	device_set_node(&dsi->dev, of_fwnode_handle(info->node));
 	dsi->channel = info->channel;
-	strlcpy(dsi->name, info->type, sizeof(dsi->name));
+	strscpy(dsi->name, info->type, sizeof(dsi->name));
 
 	ret = mipi_dsi_device_add(dsi);
 	if (ret) {

