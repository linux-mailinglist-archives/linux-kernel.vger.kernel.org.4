Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895AB5F0626
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiI3ICE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiI3IB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88878129FC8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664524913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BhMohZdHv/NYPGl/GfX50VKPfe6Ysje6teOKPsKsTuI=;
        b=LNBUbUGsrVZqIMoEe/qQXOlnoobIED2BCMA1x2chBxAAWinnpByOB+kghq6lwzKWvOhYc3
        iCjY9s6JHo3Ikx6elSmrppTN1Gg4SyiYlu1JyaTH0vpCk7RkEFeVkayuFW1G6dsXrrYNss
        eqMrNV/b2n1YiId/4u8nQugIMAZBahg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-498-m8DJv3vbOSCbPaLOAy8A3w-1; Fri, 30 Sep 2022 04:01:36 -0400
X-MC-Unique: m8DJv3vbOSCbPaLOAy8A3w-1
Received: by mail-wr1-f70.google.com with SMTP id k30-20020adfb35e000000b0022e04708c18so11380wrd.22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BhMohZdHv/NYPGl/GfX50VKPfe6Ysje6teOKPsKsTuI=;
        b=H/P14pCEMQTCqbve2qw/rizmflN6/uEXuoNbN3L0caKZLW0pZCLIcKv1zsJBFYZxRY
         8nplal4TdVfPKYlSPoKbqVUBOYIfdg/wCmCJEvB/+bm4yvY4sWj/YvjdU9tYzDxWb7ey
         M4zqnadzKGSgtxTpOS8+USg6/GpwNRbecU++ZBFudyzgTF8WhAcrrFDqsf46Ag7mbOjI
         ObEDqag3yGmZdEMAujvcjkchKixJBJ4kBpMKGJzoHXFj8/SDDxOT9PLWIABTTth9a6qj
         Vza02YwVNvzqi5+PsuDBu4/YfwkgbRoikHt0t3FGL9Zf3RZPkhd+2DOmMRmIJgKDkMM/
         Iexw==
X-Gm-Message-State: ACrzQf1YT2kaLtQ/uOq4mjLmpAawVBU3FYn2tq52pU2Kytkpi8YtsjwX
        rfrhWNRgZ4oHCjuOoCWD2UAjQNdVg51lssolVM2kRRO3VZNrRPJ+W9GqDs1FsR5/l6czvCyHzn9
        awnHHXfvDANkufCJoA5Cuc3rN8ExtLsp9lXyy5tU0MBnANLHCVuBqwn/iSDDoOauHlE2Z28/2Ar
        w=
X-Received: by 2002:a05:600c:154a:b0:3b4:c9ec:41df with SMTP id f10-20020a05600c154a00b003b4c9ec41dfmr12720742wmg.109.1664524894795;
        Fri, 30 Sep 2022 01:01:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5yGOaIy8DNTYzVg8FcSH6ScnegHTEU3zr2MDt+3PC8y6XOkIEELa+/IJHNpMMyC7BlucDtDA==
X-Received: by 2002:a05:600c:154a:b0:3b4:c9ec:41df with SMTP id f10-20020a05600c154a00b003b4c9ec41dfmr12720716wmg.109.1664524894427;
        Fri, 30 Sep 2022 01:01:34 -0700 (PDT)
Received: from minerva.. ([90.167.94.196])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a601a1c2f7sm6474711wms.19.2022.09.30.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:01:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Iterate over damage clips instead of using a merged rect
Date:   Fri, 30 Sep 2022 10:01:23 +0200
Message-Id: <20220930080123.2441629-1-javierm@redhat.com>
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

 drivers/gpu/drm/solomon/ssd130x.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index bc41a5ae810a..2428f1813a8d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -578,21 +578,23 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
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
-		return;
-
 	dst_clip = plane_state->dst;
-	if (!drm_rect_intersect(&dst_clip, &src_clip))
-		return;
-
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
+	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		if (!drm_rect_intersect(&dst_clip, &damage))
+			continue;
+
+		ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &damage);
+	}
 
 	drm_dev_exit(idx);
 }
-- 
2.37.3

