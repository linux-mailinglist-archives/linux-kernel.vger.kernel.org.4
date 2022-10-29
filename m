Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DBF6124ED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ2Sn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 14:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ2SnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:43:25 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650C40BC6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:43:23 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13c2cfd1126so9707083fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57RVFwJZ3iFyz/7pgcHKldBgiU0NMfJt4GoVXyg5tyw=;
        b=SjDvVlPBZ2PiKAi+9C6+buDBdSeaLu2FPV7dopY6H2t/EzsyqOVceneXRO6uq7jVZU
         7nTEiRra7/HOgK/ro0ucbD+RRKmzb/tphWhcwBiGB7EU6J2ZZDGpNSZL6kmgS7mq+3El
         lTSSOnxPfeZtvHzDA93lggQ4RJRCuOEvZYJTvVUr0pwMNRAS7iEbFSPK7+DzPW3I2O3D
         ggQ2ntiR+8hiVBqmmJAmPQNmwUALUoAVGod0ql2y0WM/rQOcKO3EJgVKIUB45fIEvten
         aBBJAsp021jcg92bFUbd+jUKm4PVPO6UVb9QZpz/+JY+5FH12iI25zfO8aL8aHXBaV3b
         Wrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57RVFwJZ3iFyz/7pgcHKldBgiU0NMfJt4GoVXyg5tyw=;
        b=mcWtEI3c24yOmi38flJ86lT8ObGdAeRmL1yOnMyNVgX52P2XJUC6atVVnEFLYi7kV6
         ynNsOpqW3JuDWzxx7rzmg7fLD8EuqR2TOxIXCiTp8fBz+7PPwuSLXUHtwRYd3mi4Ubfg
         Vji31qVNrMuOixQOvqy4yg9c5yRgymzfE9EF/ic9jUKJr+Nu5r3Sh9gfI65yAZ2dSyfO
         X5r2wxhWtycUMn/IFYZMDFATvccHzcwkqHf54VxfFVjx4l3NSVRQyceqLvFq6YsjiDgC
         SzxQeB4VvpM+bGLAOSHGZGQdvu3FB3PDdJv9l1cI+2EVwEIw+vqeG64TG8ivwXtecvRm
         afMQ==
X-Gm-Message-State: ACrzQf2tltWjfSoLEnxISYk9LgyJQ0yFBBgdSfFzQa+QNL33DuUZxVvS
        qzbNma69KJMXcgHoaT+d488oE5+p0ywzm2Sj
X-Google-Smtp-Source: AMsMyM50ufWSgBjfzZB6/E6vwfiM1/oZHheFjGzT0+KACVd090SUDpidYuUQA/FCYl90RsFjrF83QA==
X-Received: by 2002:a05:6870:612c:b0:132:a4d3:e0d8 with SMTP id s44-20020a056870612c00b00132a4d3e0d8mr2970057oae.95.1667069002990;
        Sat, 29 Oct 2022 11:43:22 -0700 (PDT)
Received: from antonio-Lenovo-Legion-5-15IMH05H.multilaserwifi.com.br ([45.163.246.1])
        by smtp.googlemail.com with ESMTPSA id o22-20020a9d7656000000b006619533d1ddsm855436otl.76.2022.10.29.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:43:22 -0700 (PDT)
From:   antoniospg <antoniospg100@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     antoniospg <antoniospg100@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH] drm/nouveau: Adding support to control backlight using bl_power for nva3.
Date:   Sat, 29 Oct 2022 15:42:55 -0300
Message-Id: <20221029184255.24041-1-antoniospg100@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Test plan:

* Turn off:
echo 1 > /sys/class/backlight/nv_backlight/bl_power

* Turn on:
echo 0 > /sys/class/backlight/nv_backlight/bl_power

Signed-off-by: antoniospg <antoniospg100@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index a2141d3d9b1d..855d0ce9f7fa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -263,7 +263,16 @@ nva3_set_intensity(struct backlight_device *bd)
 	u32 div, val;
 
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
-	val = (bd->props.brightness * div) / 100;
+
+	switch (bd->props.power) {
+	case FB_BLANK_UNBLANK:
+		val = (bd->props.brightness * div) / 100;
+		break;
+	default:
+		val = 0;
+		break;
+	}
+
 	if (div) {
 		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
 			  val |
-- 
2.25.1

