Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7AF6D94A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjDFLDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbjDFLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F377EE4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680778974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9cjdA8/GM7kIIzZALenJgnn3cYAeF/whaYu+OzAjvc=;
        b=K1iCrkl234kDhxu3E0FGC7rI9XjELtk6uLlo/WKAxvwJB8IoKP/BaHfJcqxb0+2+/zRBTE
        WaQp44FmH7i6k/3NHFT1OOQvwZT/3iK6D6/tXJNMCCeWbdKfgCzUBge86LXPSSz+LODDSO
        k4OSOSBEXNTGYbkaOvmwcWOTUgaPsmw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-6u50CUASN52u7nT0RUQMJw-1; Thu, 06 Apr 2023 07:02:53 -0400
X-MC-Unique: 6u50CUASN52u7nT0RUQMJw-1
Received: by mail-wm1-f71.google.com with SMTP id r11-20020a05600c458b00b003eea8d25f06so18536636wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9cjdA8/GM7kIIzZALenJgnn3cYAeF/whaYu+OzAjvc=;
        b=yZAy4MvFr5Ww774oIHpcU94yB9T733O5pUydS9ZeldmWXst2F8Kq80AT6BRnlyRDrW
         lXaGZiatDXeE+qzXfnvEu22KyNnCV6uURo3GDyV11jD8DmcIb2EgSOLHGwWmB6pcuFom
         H9j5aHBAu7hB8Rp/qKndztbx67a+W4j/CA810o702QW1r8Ka44yvS5Xqs7Pt1ljz+lxf
         dA1plLg/D1XVc1xmLfxJOWYtwu0nCZSD5ooHbcRaDloMgn4h6VZQkOVnt/OdfyENC95U
         aALp69b6klWM528fwadAsMNnhB+R/8woYitRKVFYqLh0xtIX3Z2KDVWJtQtFREq+5AHC
         buyw==
X-Gm-Message-State: AAQBX9fy0ZgZZ1mgP+DOiYQ3z5SkwxHoi6LnKMflClQWg7o+kkMI7YyL
        b4lkMrTKTLj5ljuKCg69smxQDVC0tZPa/DxK97wIAIsUIvL/yKLfCS67RKMXFRoX8zI+GDA9Lhi
        4eKGpRIxkihjDLaeDgp1UyHtNsKKz4zrDTNtQ7AwE4/7lUPAKlAebYWT4eQlw3Ww2dMBoI1YKG0
        CnQZM8KJY=
X-Received: by 2002:adf:f28a:0:b0:2d2:f3e3:115d with SMTP id k10-20020adff28a000000b002d2f3e3115dmr6654969wro.59.1680778972392;
        Thu, 06 Apr 2023 04:02:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZhDfxJ48AEmW3f3aTzEoMHnQcU1JUU1xAt9aEv3bXUTNXx0HNCm06lU7fTSOAH8n5JDmM9ng==
X-Received: by 2002:adf:f28a:0:b0:2d2:f3e3:115d with SMTP id k10-20020adff28a000000b002d2f3e3115dmr6654939wro.59.1680778971990;
        Thu, 06 Apr 2023 04:02:51 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b6-20020a05600010c600b002d8566128e5sm1472401wrx.25.2023.04.06.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:02:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/vkms: Drop vkms_connector_destroy() wrapper
Date:   Thu,  6 Apr 2023 13:02:34 +0200
Message-Id: <20230406110235.3092055-2-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406110235.3092055-1-javierm@redhat.com>
References: <20230406110235.3092055-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is just a wrapper that calls drm_connector_cleanup(), there's
no need to have another level of indirection.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/vkms/vkms_output.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 991857125bb4..4de6f8ae38be 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -6,14 +6,9 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
-static void vkms_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-}
-
 static const struct drm_connector_funcs vkms_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = vkms_connector_destroy,
+	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-- 
2.40.0

