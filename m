Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFEF6069EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJTUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJTUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:55:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C03100BE6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:55:33 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id g10so991196oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udeMwJR6RHU8GcCEPzr8LmpawXN04cnbwas6lSAlJBo=;
        b=KVeaHUE9jUea0XpTgtJ1rn6HLB6rg4ZxwSNVxLOW+RekAIAIa0w7ibtTvmZ1Dc/w8v
         EBjJJ6oUkVCbEoDvth0/lNO0SegakBo+Ra8ipV2bzD/4NFlGJwWkgM85g1L8XucV/qlP
         R8Oj9MEqLhM0BNB8rJOlAi5MGlV2hG5XomR3q0JI6rSaY7WYCJwm1WW61FxYaC9JsaXh
         PSKCR7cpBAdGnzxO2Rrdb7nM1ta0NDWjow6e9zF94ykwi/J5zin7vJE3qTm0wymkp1V5
         mub4o3P52y2p3URtUU/Mj/3VB3vIrQRRTfSTndMGA9SoSdq9w3P51Fa9jY5QH5PA4BoE
         c7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udeMwJR6RHU8GcCEPzr8LmpawXN04cnbwas6lSAlJBo=;
        b=vy2Un9A3ywOb5kVWFTn5YAvoJ4iqZLdNuQXFpNPldAmTm/7xYVfbLFI93mwfHu5b38
         8ATfc7hbWg8vz5IXioXyiphfchtTfj+q3ycgv0aYd+BK85jiTx5Gve7k8Nz6mOC5kM0Y
         esPqWRyqkCyXYjkfyGXrA5eBiISr3cO1zrV1PeHYGlpUcLS8MW4z8mLOXetQqTnP5XZm
         8rIXLiBz84xIrjL20U1DdFr5GIVrWOSVE/Ylolwgzr2FzoB/8CrCfE1s0f2fJDRonQcI
         a3WHD0ega2F5Bbp8dhmS+qxVcla4oLDqHm/mQkKogphhAylWKXhSxGKdsxii91h65hn8
         viDw==
X-Gm-Message-State: ACrzQf10BKvX+dplWN6ns5FRyD9xNvF9VSsPUk/tqu5P4dTU1Vebu+5I
        1/aZb58Z3DXqW+30J+mUH8M=
X-Google-Smtp-Source: AMsMyM7JTAhKBFETi+TX2Um7WHi5Qv9p2x0L/gDsY8hD/VabFzthQFSlJTkKqGOCCYvsOoAdK14ydQ==
X-Received: by 2002:a05:6808:1998:b0:355:3480:51b9 with SMTP id bj24-20020a056808199800b00355348051b9mr7658382oib.195.1666299331988;
        Thu, 20 Oct 2022 13:55:31 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id h5-20020a4aa9c5000000b00480e77f90f9sm2129998oon.41.2022.10.20.13.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:55:31 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     rodrigo.siqueira@amd.com
Cc:     Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        harry.wentland@amd.com, linux-kernel@vger.kernel.org,
        samsagax@gmail.com, sunpeng.li@amd.com
Subject: [PATCH] drm/amd/display: Revert logic for plane modifiers
Date:   Thu, 20 Oct 2022 17:53:18 -0300
Message-Id: <20221020205317.96136-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <ea5d60cd-8d0b-7018-425e-b91e5750a830@amd.com>
References: <ea5d60cd-8d0b-7018-425e-b91e5750a830@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was split in commit 5d945cbcd4b16a29d6470a80dfb19738f9a4319f
("drm/amd/display: Create a file dedicated to planes") and the logic in
dm_plane_format_mod_supported() function got changed by a switch logic.
That change broke drm_plane modifiers setting on series 5000 APUs
(tested on OXP mini AMD 5800U and HP Dev One 5850U PRO)
leading to Gamescope not working as reported on GitHub[1]

To reproduce the issue, enter a TTY and run:

$ gamescope -- vkcube

With said commit applied it will abort. This one restores the old logic,
fixing the issue that affects Gamescope.

[1](https://github.com/Plagman/gamescope/issues/624)

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 51 +++----------------
 1 file changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index dfd3be49eac8..1d47d2d69781 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1369,7 +1369,8 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
-	struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
+
+	int i;

 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;

@@ -1386,49 +1387,13 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return true;
 	}

-	/* check if swizzle mode is supported by this version of DCN */
-	switch (asic_id.chip_family) {
-	case FAMILY_SI:
-	case FAMILY_CI:
-	case FAMILY_KV:
-	case FAMILY_CZ:
-	case FAMILY_VI:
-		/* asics before AI does not have modifier support */
-		return false;
-	case FAMILY_AI:
-	case FAMILY_RV:
-	case FAMILY_NV:
-	case FAMILY_VGH:
-	case FAMILY_YELLOW_CARP:
-	case AMDGPU_FAMILY_GC_10_3_6:
-	case AMDGPU_FAMILY_GC_10_3_7:
-		switch (AMD_FMT_MOD_GET(TILE, modifier)) {
-		case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D:
-			return true;
-		default:
-			return false;
-		}
-		break;
-	case AMDGPU_FAMILY_GC_11_0_0:
-	case AMDGPU_FAMILY_GC_11_0_1:
-		switch (AMD_FMT_MOD_GET(TILE, modifier)) {
-		case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
-		case AMD_FMT_MOD_TILE_GFX9_64K_D:
-			return true;
-		default:
-			return false;
-		}
-		break;
-	default:
-		ASSERT(0); /* Unknown asic */
-		break;
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
+			break;
 	}
+	if (i == plane->modifier_count)
+		return false;

 	/*
 	 * For D swizzle the canonical modifier depends on the bpp, so check
--
2.38.1

