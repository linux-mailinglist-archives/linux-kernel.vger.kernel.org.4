Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312385E75E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIWIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIWIfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4701B37F96
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663922105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rlVuqNZZ5WqICJ7b4y4WhBhxWjjwgqyMHyzMNeEa8ek=;
        b=Hm7Gg5AhjwZxdEDQ1GdWYA+I4q8JV9bd69g1ATNxMi7dEgrsYO485+nOP47TpIXVIGI9B6
        RnNmUPZVUGBPDFjVGiuwRKm4gFpZAbGq7gYb7sGXFPd03EX+NKjlKvE32eGnKWcKLFWBNV
        Gf26MAJNfsiM+B7eDzfMWYliFhn6DdY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-19--1unUZfjOcS_8UIA2f0B9g-1; Fri, 23 Sep 2022 04:35:03 -0400
X-MC-Unique: -1unUZfjOcS_8UIA2f0B9g-1
Received: by mail-wm1-f72.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so1584725wml.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rlVuqNZZ5WqICJ7b4y4WhBhxWjjwgqyMHyzMNeEa8ek=;
        b=5orNl9oB4pnP9pxKy2bjz4r0bEwWKqhXeVjfDtpnTk+ZsHpMxcteZrDagtFX9FomDl
         KdB+9W2xeM8WkKcdx6Eoi6JQ8i6Wzii6kN2pP58mg2qW7mc6KHO4Q1DyrlQS0jnLZBE+
         kHitmlLjTwS5tnv6VPNWkQqEWV1s6KXlq9COTro+xBkQKDQlQCLIeeci9299GwrwuOYG
         2sCq6XhXj54xLtx91c8GoWIbOBvnmK/ZhM4sOP00hWrVyXKIzQzgAIzSBnvJjQFTykEp
         Jn9BtoOYRwH133KnLP6garicfT1Dugfwu8zUIozN2HBw3Z2AmMqulCbSynMIJ5uHVE4m
         9YLA==
X-Gm-Message-State: ACrzQf14bQmD+cc270KdqH8uI43NE/bPgDrRoXBIFzEFL8Udu21BQ1EY
        +grtkqQ83mtmhLZWCCNKbAAU51B8A6k61W5n6ldqEjzY57UcOESAH64xiDTwYwEXuVdjmBkIFpC
        zi/hjGHv9oHWZGrErWp39DFm6TLwhlG7u6CSfOfv9CWaP1NADJYcVDRzK2bQEsEqQf7LBEoPIyk
        0=
X-Received: by 2002:a05:6000:1251:b0:22a:e60f:c080 with SMTP id j17-20020a056000125100b0022ae60fc080mr4237277wrx.95.1663922102448;
        Fri, 23 Sep 2022 01:35:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4qn2VHsYGBFqh6GRr7+ueBDf2FJ1K86J5WUS3SdSkpwtlpE8rfpk0x2WirT0LuFZOlmWvnVQ==
X-Received: by 2002:a05:6000:1251:b0:22a:e60f:c080 with SMTP id j17-20020a056000125100b0022ae60fc080mr4237248wrx.95.1663922102106;
        Fri, 23 Sep 2022 01:35:02 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm1964922wms.46.2022.09.23.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:35:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Use drm_atomic_get_new_plane_state()
Date:   Fri, 23 Sep 2022 10:34:47 +0200
Message-Id: <20220923083447.1679780-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct drm_plane .state shouldn't be accessed directly but instead the
drm_atomic_get_new_plane_state() helper function should be used.

This is based on a similar patch from Thomas Zimmermann for the simpledrm
driver. No functional changes.

Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 7fae9480aa11..a537692100d1 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -566,10 +566,10 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 }
 
 static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
-						       struct drm_atomic_state *old_state)
+						       struct drm_atomic_state *state)
 {
-	struct drm_plane_state *plane_state = plane->state;
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_device *drm = plane->dev;
 	struct drm_rect src_clip, dst_clip;
@@ -591,7 +591,7 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 }
 
 static void ssd130x_primary_plane_helper_atomic_disable(struct drm_plane *plane,
-							struct drm_atomic_state *old_state)
+							struct drm_atomic_state *state)
 {
 	struct drm_device *drm = plane->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
-- 
2.37.3

