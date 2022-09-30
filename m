Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289B5F0EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiI3PaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiI3P3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B914F645
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664551790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A55Nw0d8fVm0KHqdmDBOMg24Woe2WzURM0qQejWLfmg=;
        b=KLUY9/UzOOp0E0giG0X6ePEy0n20Q28Erpe1iZ3etjd0OTCZ+vpoPk9Zn05xFHb3RwBjhh
        NacI5UOXp7iYCV6BSSIMNWT32d7D4eMFCIjqsvlHWo+9uS4E7u8I3sLenaOWxzzt5E3IHk
        irl2y6Gq4PegDnu6MvxTJhlvms32XzI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-0FteOuWLP7iU2x6Z-x0JPA-1; Fri, 30 Sep 2022 11:29:48 -0400
X-MC-Unique: 0FteOuWLP7iU2x6Z-x0JPA-1
Received: by mail-wm1-f72.google.com with SMTP id r9-20020a1c4409000000b003b3f017f259so2221922wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=A55Nw0d8fVm0KHqdmDBOMg24Woe2WzURM0qQejWLfmg=;
        b=XfPAU6qSrABVtQAxlAQoXIXbDGT6ve6n4MRZ4o5m5JEkZU8y8ZCDze7WGK1Rd5Ta3A
         a3Qk3xd2W8S+eNwrGHnG6itfz+NzY+j8R3qFoFmav5nNwOpaJOBtaKY1rVdW7Yw/45j4
         6tbmb/jj2xmkkAkaeLTYRCCDYwreIq/ZFA/cXddwWwa0CyZvG1QIM+lKVFkEVuMnXvJ+
         2qBwkfCOGJ5JVuzFG26FYwz71T7dfg8SE0LojCKcnJM0XeSkjHwf56V6NzgvNk3wPqLO
         AeykrrtlI1oGx0g0v8sGusnHDrdLLOjiA4pTEdyIOuxzJFsaMGZQpTbKkUCppGph5CoZ
         q4DA==
X-Gm-Message-State: ACrzQf0Gtt8Zw4MoNPgBY93B96KPXnRgJtKXJ4+qHGrTYsy6/kPOdVy+
        UqkkRLng/9TXojoQUk9oOAaiXaldvWXvg6gWbOPbZaaQDoNH44K+GaKHK4LRJs2g9YjIQ6cUi6J
        FeFQ02NHP+Xs89kasUxI9It10yMWY+XrKkIi8SkxmzJpbSDvEunMyhQeH0Q/HAIWTIniiRW0t0W
        4=
X-Received: by 2002:a05:6000:1f9d:b0:22a:fc9b:435c with SMTP id bw29-20020a0560001f9d00b0022afc9b435cmr6137935wrb.667.1664551787440;
        Fri, 30 Sep 2022 08:29:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6zijDovkMd1DACmjaenUTTlZq5pdpePWRbUt/YAjZBQyjsZOQ9yNCeJDt68gG5B+e4Ledw6w==
X-Received: by 2002:a05:6000:1f9d:b0:22a:fc9b:435c with SMTP id bw29-20020a0560001f9d00b0022afc9b435cmr6137910wrb.667.1664551787119;
        Fri, 30 Sep 2022 08:29:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm7799133wmc.14.2022.09.30.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:29:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/ssd130x: Iterate over damage clips instead of using a merged rect
Date:   Fri, 30 Sep 2022 17:29:44 +0200
Message-Id: <20220930152944.2584356-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
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

The drm_atomic_helper_damage_merged() helper merges all the damage clips
into one rectangle. If there are multiple damage clips that aren't close
to each other, the resulting rectangle could be quite big.

Instead of using that function helper, iterate over all the damage clips
and update them one by one.

Suggested-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Move the dst_clip assignment inside the drm_atomic_for_each_plane_damage()
  loop (Thomas Zimmermann).
- Pass dst_clip instead of damage area as argument to ssd130x_fb_blit_rect()
  function (Thomas Zimmermann)

 drivers/gpu/drm/solomon/ssd130x.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index bc41a5ae810a..f456b233d2e7 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -578,21 +578,24 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_atomic_helper_damage_iter iter;
 	struct drm_device *drm = plane->dev;
-	struct drm_rect src_clip, dst_clip;
+	struct drm_rect dst_clip;
+	struct drm_rect damage;
 	int idx;
 
-	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &src_clip))
+	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	dst_clip = plane_state->dst;
-	if (!drm_rect_intersect(&dst_clip, &src_clip))
-		return;
+	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		dst_clip = plane_state->dst;
 
-	if (!drm_dev_enter(drm, &idx))
-		return;
+		if (!drm_rect_intersect(&dst_clip, &damage))
+			continue;
 
-	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
+		ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
+	}
 
 	drm_dev_exit(idx);
 }
-- 
2.37.3

