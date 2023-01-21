Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44935676876
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAUT0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjAUT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9DD2A161
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674329089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oGQt8CSMw4GzppBRa4wPVT549mMixHHzNT+6I/9DSU=;
        b=Z/VPGsVC5C/AdxQdFF/5dER3gWMBVU70XT6JwuDKHIgo6BX27x2W1h9HUb9K+1jwjk9ujn
        dRpgnb/iegJ9utMZvYgsanSjzF4Xhrje3gsejLqASvbXohFK19rXDsmmOH55v1PpDJwJK7
        I0xYFJ3Kp2uASmCcEsShUvQKGv0NOU4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-8E-b9dHXMRScImc2FIZbfw-1; Sat, 21 Jan 2023 14:24:48 -0500
X-MC-Unique: 8E-b9dHXMRScImc2FIZbfw-1
Received: by mail-wr1-f72.google.com with SMTP id v20-20020adfc5d4000000b002bdfcdb4c51so1410342wrg.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oGQt8CSMw4GzppBRa4wPVT549mMixHHzNT+6I/9DSU=;
        b=L22jn+erI15/9Uk2xhqwNAfw3kNqjzcmdPcE/9fBBGF5YmgBUkwrZLoKTPstbLQBp3
         e8HzRPEVW+8bwMT5ej3BdbXjj9MQZCEQPwAVJuxyQIr0u0ecLoIn0cE+Ult356Mbr+RU
         Sn3hfcTIMdU16dKlHTjDMB321qPUHl8HtgCAZLf8StY099BlO4kpQe1rw0hK0W5h6eK+
         YYKA43mAPNZFv/P9VVOgYAYDAvdIFeqBnJZu5THvOCkgdSRzp6Ib03XSqPQkMfhj1gca
         OpU9sGRvKPxLaq0upEW65JeNPtnEJmumS4XxeEyevpq9pn4F2Tu/GLLE4jt+ELiAKMIH
         OUew==
X-Gm-Message-State: AFqh2kqkN3Kf2HukbS+937ncBj3cLFW7OPNqKoctO3bGCNgrZhDnpxdd
        oJ9UA/Gbq34jUxj4L5Mx8zYwZORzxKXex+7YZAlLPhhBZpN76OuJayIWnZ3sX2knglZQb1ZM4mr
        S+SCyqcv43TnnOY/kIUaONBXKy4+AaTNqhEhH87/PND695yqKZUgy4/yciNZvppKPEBxBo+mUy0
        w=
X-Received: by 2002:a05:600c:1c23:b0:3db:b9f:f2e with SMTP id j35-20020a05600c1c2300b003db0b9f0f2emr16681542wms.14.1674329087186;
        Sat, 21 Jan 2023 11:24:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvo4YuYvz9GiFn0zs6xKas3bTc88JqL7+8XVAEOB/6LyNKyp/RA7k5MmpDB75tEJqJVBJytCg==
X-Received: by 2002:a05:600c:1c23:b0:3db:b9f:f2e with SMTP id j35-20020a05600c1c2300b003db0b9f0f2emr16681525wms.14.1674329086970;
        Sat, 21 Jan 2023 11:24:46 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm8544321wmg.27.2023.01.21.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:24:46 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/fb-helper: Check fb_deferred_io_init() return value
Date:   Sat, 21 Jan 2023 20:24:17 +0100
Message-Id: <20230121192418.2814955-3-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121192418.2814955-1-javierm@redhat.com>
References: <20230121192418.2814955-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fb_deferred_io_init() can fail and return an errno code but currently
there is no check for its return value.

Fix that and propagate to errno to the caller in the case of a failure.

Fixes: d536540f304c ("drm/fb-helper: Add generic fbdev emulation .fb_probe function")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/gpu/drm/drm_fbdev_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index 0a4c160e0e58..b2df8c03594c 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -223,7 +223,9 @@ static int drm_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
 		fbi->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
 
 		fbi->fbdefio = &drm_fbdev_defio;
-		fb_deferred_io_init(fbi);
+		ret = fb_deferred_io_init(fbi);
+		if (ret)
+			return ret;
 	} else {
 		/* buffer is mapped for HW framebuffer */
 		ret = drm_client_buffer_vmap(fb_helper->buffer, &map);
-- 
2.39.0

