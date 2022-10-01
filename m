Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A745F1D10
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJAO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJAO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622A9D51C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbBek+DLo1uAiT4bxT5GcOfjUqanpBLVsNY+19U/h8w=;
        b=eNyPeVYMMlBk062ZQbD0iPX/yzVBBm8RIGB9pBuvgp1EHMeZGkXiIPuC5phkTO7rfT87FR
        kMiR+qQcmjLV64F78KzU8G7dKZI85nip3YOQSVIxnOYtSXJZ3gidrpkqlLv0paqLlomgrs
        t8wU/gcjH754+/7fmiGzQKJLGAG/yak=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-r5B_i9gHNey1wq78Rbayqw-1; Sat, 01 Oct 2022 10:58:30 -0400
X-MC-Unique: r5B_i9gHNey1wq78Rbayqw-1
Received: by mail-ed1-f71.google.com with SMTP id x5-20020a05640226c500b00451ec193793so5651959edd.16
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fbBek+DLo1uAiT4bxT5GcOfjUqanpBLVsNY+19U/h8w=;
        b=tEN4rDOfBfwIYAeQADlAgPQe7z/xMABRfOuZUAOSPcgF7WNFp/WtJo04t0j1ETAymA
         Srf2ESKvO4UhXj536S4H8KbneckAU8ratYRZoDeP74dUSm+0TJ7+9hhrMSLJXLppXH3U
         bu4NRFy31P45q11AQVOlYY2Sr2g5kLbQEUQwUr5MX/WADwSb8QCgA85bAuM+wt6VSi6v
         ry0mhIWqm0uBg1nnKgYSNwRbtqdcy7/fFYPwDScinR/+c5Co4sDOY7ic7T6V6Uu1fKMv
         EeyYzhcq5uPRUeEF/E7JBmaVmF3kQ9Ky9l3skG0ufa9P90WjVgqEdk+8qEm/hGd0fHvY
         iiqg==
X-Gm-Message-State: ACrzQf37drYHCDbmU1gPVMzAZVv+J/ffaYMndhJoNyJHH3qxSpofaUAD
        7COkFELGsz47JZKgCsM9FhgccU5E8NE5WGYnfyOKsusqTgBOi3nYW6BCSR4O1AdNOOnGoQdg3zv
        0+jytKdmLYHs4QJAExenUTcNr
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr9754614ejb.551.1664636309696;
        Sat, 01 Oct 2022 07:58:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77lcdC7sJsRPEhN5747tLtzHdni0e5EG5ogppqYZX80M+PrQk5aORErJsk4Ntf6tTYwo6zXw==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr9754596ejb.551.1664636309517;
        Sat, 01 Oct 2022 07:58:29 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb15-20020a0564020b6f00b004576e3aee69sm3768376edb.4.2022.10.01.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:29 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 6/9] drm/fsl-dcu: plane: protect device resources after removal
Date:   Sat,  1 Oct 2022 16:57:59 +0200
Message-Id: <20221001145802.515916-7-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 24 +++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 23ff285da477..b1305f0af9d5 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -65,15 +66,21 @@ static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
 {
 	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(plane->dev);
 	unsigned int value;
-	int index;
+	int index, idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	index = fsl_dcu_drm_plane_index(plane);
 	if (index < 0)
-		return;
+		goto out;
 
 	regmap_read(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), &value);
 	value &= ~DCU_LAYER_EN;
 	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), value);
+
+out:
+	drm_dev_exit(idx);
 }
 
 static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
@@ -86,14 +93,17 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct drm_gem_dma_object *gem;
 	unsigned int alpha = DCU_LAYER_AB_NONE, bpp;
-	int index;
+	int index, idx;
 
-	if (!fb)
+	if (!drm_dev_enter(plane->dev, &idx))
 		return;
 
+	if (!fb)
+		goto out;
+
 	index = fsl_dcu_drm_plane_index(plane);
 	if (index < 0)
-		return;
+		goto out;
 
 	gem = drm_fb_dma_get_gem_obj(fb, 0);
 
@@ -126,7 +136,7 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 		bpp = FSL_DCU_YUV422;
 		break;
 	default:
-		return;
+		goto out;
 	}
 
 	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 1),
@@ -162,6 +172,8 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 			     DCU_LAYER_PRE_SKIP(0));
 	}
 
+out:
+	drm_dev_exit(idx);
 	return;
 }
 
-- 
2.37.3

