Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230DA744B2E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjGAVqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 17:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 17:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043AF199B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 14:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688247918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjYFztOePLsPaJm5e5mc9Fspsz0Ww9J9HtOwfHiQKzE=;
        b=XrxwHu/jVsOzCAkjlA6VyPW2JrkpXcF6gvQXDTeZgSraPtt6P8USh2An5iS3LbML7LZaE1
        zH6NSFH4T/aT3B9TDSGynbrWchR9Dv/26rlGacciBWvYIYf1h+9aluW5tw4GNj2WCSupSD
        EGpzDxBUx7qA5cCVq8RrxT0M2sEHvKI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-UvxPXOCgM2a_1Wv1gUqZ5g-1; Sat, 01 Jul 2023 17:45:16 -0400
X-MC-Unique: UvxPXOCgM2a_1Wv1gUqZ5g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fb40ec952bso18345625e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 14:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688247915; x=1690839915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjYFztOePLsPaJm5e5mc9Fspsz0Ww9J9HtOwfHiQKzE=;
        b=fWEA1pyAHl6/+YwneQ7wFyh1h45FC4CKSWNbAMW/iOhuKFFDrsYnmZi1CVp+050d5r
         w5R92pzANXkIk5z/nnzmrGkILlIqZYUMRogBNExW/qkp8Ca66wh94DJUWi7XfMU6/hkL
         3GLXNC4LBOoL98pRZ6DcpNYf5mo12XwtnammDpQcvx2z6cxC/0gUR6eK8cTcyMfEQ0zo
         NMtZiIpAHsdNtqtMI7CxsRjB3VpKa8i2g51cqwFOWCWBtYbQSF9imN7HDbnHBKA8S1sx
         KR4mDYWf0U5rR0X3mAW9VIXTqeh58avvfITAa4l715YaHhhetJRzsa38G2X6J2sGqdsX
         MSyA==
X-Gm-Message-State: AC+VfDwY7WH4KUWpTqezubxuu+Uh/gbuE264NpX23Xyo6q3WxJ6+D2Z9
        mh+bz54a464R0iEEhcfs8gPWrRAOZxQXLftBXWf/Drvelgxua8dD3M27vX67ALAdVWR7ZjMf6C6
        U7YQ5WOsD3Ydfk+BiTzs5JVNVbKU652RC2i2Uilj+8mZByx2mx3Rjw3lVVor8smjJY5S9eTKV18
        r8LR1XjDc=
X-Received: by 2002:a05:600c:2181:b0:3fa:96ae:fd78 with SMTP id e1-20020a05600c218100b003fa96aefd78mr5114283wme.29.1688247915550;
        Sat, 01 Jul 2023 14:45:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QL/alylsKkmsCF50GPU6dzPKVvFKUXejyBEKTLhORjiMD3xe/aN1kkO/WkkVl4mUmO/qwpg==
X-Received: by 2002:a05:600c:2181:b0:3fa:96ae:fd78 with SMTP id e1-20020a05600c218100b003fa96aefd78mr5114264wme.29.1688247915076;
        Sat, 01 Jul 2023 14:45:15 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbc0ea491dsm6913800wmc.40.2023.07.01.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 14:45:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm: Make fbdev emulation select FB_CORE instead of depends on FB
Date:   Sat,  1 Jul 2023 23:44:51 +0200
Message-ID: <20230701214503.550549-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701214503.550549-1-javierm@redhat.com>
References: <20230701214503.550549-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the fbdev core has been split in FB_CORE and FB, make DRM fbdev
emulation layer to just select the former.

This allows to disable the CONFIG_FB option if is not needed, which will
avoid the need to explicitly disable each of the legacy fbdev drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index afb3b2f5f425..d9b1710e3ad0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -132,7 +132,7 @@ config DRM_DEBUG_MODESET_LOCK
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM_KMS_HELPER
-	depends on FB=y || FB=DRM_KMS_HELPER
+	select FB_CORE
 	select FRAMEBUFFER_CONSOLE if !EXPERT
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
 	default y
-- 
2.41.0

