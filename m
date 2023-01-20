Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18067542F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjATMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjATMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6953A57BC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWxZ9+fZGD3CeqIp7txi3l7X00Lca9PNbV7a61jLAME=;
        b=PgpEEHpEKcR3NbB/Gp7OII0YDNJybGYkjaqHhipoDZpFEEzwGhbTIPmmCDnCbdgIdy0BBS
        j1YnKLvuY0ES+6Ge9YyimLSV4hckkF9yNWNhaLtmbpBbaYnq0oQvWOHtCze45iLls1vLsK
        YNlWCcjuulf+aZ1VeHuNcwxjp+8jiF0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-104-V9PzpMQqNxWeZcvD7hbDLw-1; Fri, 20 Jan 2023 07:08:33 -0500
X-MC-Unique: V9PzpMQqNxWeZcvD7hbDLw-1
Received: by mail-wr1-f71.google.com with SMTP id o15-20020a5d684f000000b002be540246e1so336494wrw.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWxZ9+fZGD3CeqIp7txi3l7X00Lca9PNbV7a61jLAME=;
        b=6l5CB9zjZr3/VbTrWjcWJot3tLx/IZcwz79mdX8PmKX4MWXy93Xj3aCRCItllY0NFC
         1pet7mirSe89OMixrdl5aP44yaydbTkhV9JVCUFsDsehjjFSNZ+NNRmkYYRaq6RDcrzA
         3ZcKVUgb35wNloMq9z/Yz3PAGQLitJbdIZgPhvck21MS9jFw5OoGImzELchi6BPhZn2Q
         7j2AxlcVpQ31nB/j7lON/KfLct9fVCQxPOqho6QMkytUcu5l0orcKQXnBriIldW4P7Qf
         7rXg3FQbU3hPYI7bmvgCU/5bRYLs3YrzjST1SGFdYjMyqZ+aeterEaCNxkc7ACo7sHNW
         CMYA==
X-Gm-Message-State: AFqh2koDjUbNDrKcTiFX5YvhlFyq4DbG/8chVr3nZVC3nW9IT6lfcax3
        z5avMrsjLeNVjgirJM5h2MaxBydacjUHFcXPOR96c36v2AAzRAkqE6X3dmPvdAQPUYoE3zARXAw
        /rzcFzjcGEg0SXc5/3hQRVqeizb73WTq2LPd5N4FhJ9eqjJ4bcZd72pRtTdRYKypRjTn9/llUVv
        w=
X-Received: by 2002:a05:6000:1708:b0:2bd:daf1:9e4c with SMTP id n8-20020a056000170800b002bddaf19e4cmr14292647wrc.43.1674216511898;
        Fri, 20 Jan 2023 04:08:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvGsPS+HlZRn7YsaFlYBOOufj3MRrLCyQgFoq48lMENq5yHr4MBJy40beCmvSbJT9GNsyOxg==
X-Received: by 2002:a05:6000:1708:b0:2bd:daf1:9e4c with SMTP id n8-20020a056000170800b002bddaf19e4cmr14292621wrc.43.1674216511626;
        Fri, 20 Jan 2023 04:08:31 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm32766336wrx.14.2023.01.20.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:08:30 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] drm/fb-helper: Check fb_deferred_io_init() return value
Date:   Fri, 20 Jan 2023 13:08:21 +0100
Message-Id: <20230120120822.2536032-3-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120120822.2536032-1-javierm@redhat.com>
References: <20230120120822.2536032-1-javierm@redhat.com>
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
---

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

