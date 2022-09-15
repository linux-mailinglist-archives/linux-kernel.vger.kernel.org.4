Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DE5B91C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIOAeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIOAdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF058D3D1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtNtNsp7OqPqPE1l1U/CkF2qeKiAYQ9N67dyPKGWxE4=;
        b=jRtZwV7GIpVBggCrgeYjmMCHwItkbfmaZI4+nRgP6ZrM53fK5cJ089Q0NEpOSaEnv0n1qs
        gyc/9TUEPZWRVkfJbBxBd2OfCS3R/Fns4TC3MYYD4vFizYkrevF8pEk2Oxh2MJ2E8XFDX7
        xcH2yU/OJ4uVBtEdUyQSfmR6x0eE0Yo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-163-AU7zZzpsOXO8MiZWMmKuWw-1; Wed, 14 Sep 2022 20:33:03 -0400
X-MC-Unique: AU7zZzpsOXO8MiZWMmKuWw-1
Received: by mail-ed1-f72.google.com with SMTP id dz21-20020a0564021d5500b0045217702048so6509788edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FtNtNsp7OqPqPE1l1U/CkF2qeKiAYQ9N67dyPKGWxE4=;
        b=uKOZKhXAZ0uMFmV4/VwqMISg5iF/VtQmEE/pT9hKoczfdZA43Sj6f8t/0y+AC+XLhO
         QTB+kPZYIVVfvcU5cRnKsyPuwh/32X/0kxqHycUwq/tEwBV3kql0gBwpXJkDgBQodq9Q
         vhUyWPJs6MJKnBnIuYjNRlHQNPd4c4pXLZdqJC01ITzIHUe54tT9pUoEVbpbjRc+P8so
         fbQCWVeBSX9TYto7E0Zoh4IG4x3YoPzC8opPmcxcppraRWcW6H50K2E9MRQwt2Ujr5cE
         wYBqCsViJcNAk2BqtSGQKXgjhGrdH9Z359FRicJ0eBLWEwyDc4xV953A4BGZ4xvQeAt7
         il6Q==
X-Gm-Message-State: ACgBeo3duo1NAeRkzzEXM6wazGYUB9xQm0qpVJFIfCzDhvPwBRxW8X1J
        bD+L9FY4YSDHWNaWzq+phxMyvIXA63TdLtJLAMrw5hoR25fRrDyfSvOtbSCAxF5U3aT51nfKdtJ
        C3N7uyV+kz63LC9BQ5451xIDM
X-Received: by 2002:a17:907:e9e:b0:77f:9688:2714 with SMTP id ho30-20020a1709070e9e00b0077f96882714mr9587299ejc.208.1663201982187;
        Wed, 14 Sep 2022 17:33:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZRBZU53BRdNeyOhVVcill9G3iLRkCUJ/jYRhr4Dk+1M2YpVqKN5hH2aUWRV4Wra1YNWfF2A==
X-Received: by 2002:a17:907:e9e:b0:77f:9688:2714 with SMTP id ho30-20020a1709070e9e00b0077f96882714mr9587289ejc.208.1663201981992;
        Wed, 14 Sep 2022 17:33:01 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id kx25-20020a170907775900b0073d70df6e56sm8240280ejc.138.2022.09.14.17.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:33:01 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 6/8] drm/fsl-dcu: plane: protect device resources after removal
Date:   Thu, 15 Sep 2022 02:32:29 +0200
Message-Id: <20220915003231.363447-7-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915003231.363447-1-dakr@redhat.com>
References: <20220915003231.363447-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 23ff285da477..1be3062a95df 100644
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
@@ -65,7 +66,10 @@ static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
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
@@ -74,6 +78,8 @@ static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
 	regmap_read(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), &value);
 	value &= ~DCU_LAYER_EN;
 	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), value);
+
+	drm_dev_exit(idx);
 }
 
 static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
@@ -86,7 +92,10 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct drm_gem_dma_object *gem;
 	unsigned int alpha = DCU_LAYER_AB_NONE, bpp;
-	int index;
+	int index, idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	if (!fb)
 		return;
@@ -162,6 +171,7 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 			     DCU_LAYER_PRE_SKIP(0));
 	}
 
+	drm_dev_exit(idx);
 	return;
 }
 
-- 
2.37.3

