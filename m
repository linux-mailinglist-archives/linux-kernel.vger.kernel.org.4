Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B285F1DC6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJAQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJAQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C332047
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4+Ptu+qDGFqb0SHVblFALZEdZlh0sqNqyuMfzJpFUM=;
        b=a7rmAE96/IKnQePJD6jJL3OBXxu9hyqUxsZuBqg5/KV9UnqcKkWEUeIuHWZRHPNcF1ubys
        XDQPXNorJTiFL0jx6vQ5Wy7ma6TKTOyQD47NNUyrgf0G0iC3Z+xmL/C3YTCD0Gbt7xZLhg
        OSbJ6nsv9zwdkfuigMqst/cbKflrtBg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-Z-CWaDvpOUeSNUTNRUFzkg-1; Sat, 01 Oct 2022 12:40:13 -0400
X-MC-Unique: Z-CWaDvpOUeSNUTNRUFzkg-1
Received: by mail-ed1-f72.google.com with SMTP id z9-20020a05640240c900b00458dae4ed9cso94871edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X4+Ptu+qDGFqb0SHVblFALZEdZlh0sqNqyuMfzJpFUM=;
        b=cbSrtC2z0pjYeLpRxDkiiB3H88YefXjCFgi+G6HKrKR1uBMH3V4u+V8McLYjijs+vT
         V7SPkwuRQkAyLkQi/v5YgpyzJsD6qUmwqOMZ5y3aq7v+KEcY/fwFvjhXFgeIhCQxyrIz
         hyskTGpwq1W0WLbacsB1cp02BCcQGuC74go/qgSnZ35Cx6t0q8a60izUsjRJmAkEQ6AK
         vp9fnvyawqrDVoPrDDyHBWguTP5VJy5TwoEhv8wPnYAivN/2YonsYC6FIxkmx402TOcU
         3Ychp+ZvBMi0K5Ublrf+MIV4jbOusCPnQ+4FVzZKYBOUBv41PyQCWYM1xb3aE1lsSdHo
         CTAw==
X-Gm-Message-State: ACrzQf2VcbtPLIgheWOtGZr/I45cRniEU76rJe74v1X4pIU2gqBwT3Za
        rO9/dA5CWLIDTMHkzEeSV/c9dklO/obEdq4m2ZOgnDTXV7sj9P8Xvd2klT4sAbIjWfhdgR3YyOL
        rjVJE4EYWtE1yTZHawiFmIjk0
X-Received: by 2002:a17:906:db02:b0:780:24e:cf9 with SMTP id xj2-20020a170906db0200b00780024e0cf9mr10115644ejb.460.1664642411747;
        Sat, 01 Oct 2022 09:40:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sqRzShEvzcXK3sHQwN9XIDX9ReJ+nLvVhphfWZ1v1LAlyL8kh4A0p/0J+VR7oZU5jC9b3Sw==
X-Received: by 2002:a17:906:db02:b0:780:24e:cf9 with SMTP id xj2-20020a170906db0200b00780024e0cf9mr10115640ejb.460.1664642411595;
        Sat, 01 Oct 2022 09:40:11 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090630d200b0073dd8e5a39fsm2888945ejb.156.2022.10.01.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 6/9] drm/arm/malidp: plane: protect device resources after removal
Date:   Sat,  1 Oct 2022 18:39:43 +0200
Message-Id: <20221001163946.534067-7-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001163946.534067-1-dakr@redhat.com>
References: <20221001163946.534067-1-dakr@redhat.com>
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
 drivers/gpu/drm/arm/malidp_planes.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 34547edf1ee3..d2ea60549454 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -790,9 +790,12 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	u16 pixel_alpha = new_state->pixel_blend_mode;
 	u8 plane_alpha = new_state->alpha >> 8;
 	u32 src_w, src_h, dest_w, dest_h, val;
-	int i;
+	int i, idx;
 	struct drm_framebuffer *fb = plane->state->fb;
 
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
+
 	mp = to_malidp_plane(plane);
 
 	/*
@@ -897,16 +900,24 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 
 	malidp_hw_write(mp->hwdev, val,
 			mp->layer->base + MALIDP_LAYER_CONTROL);
+
+	drm_dev_exit(idx);
 }
 
 static void malidp_de_plane_disable(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
 	struct malidp_plane *mp = to_malidp_plane(plane);
+	int idx;
+
+	if (!drm_dev_enter(plane->dev, &idx))
+		return;
 
 	malidp_hw_clearbits(mp->hwdev,
 			    LAYER_ENABLE | LAYER_FLOWCFG(LAYER_FLOWCFG_MASK),
 			    mp->layer->base + MALIDP_LAYER_CONTROL);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_plane_helper_funcs malidp_de_plane_helper_funcs = {
-- 
2.37.3

