Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC566E538E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDQVDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDQVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A5D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CC362203
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8945AC433D2;
        Mon, 17 Apr 2023 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681765415;
        bh=gogdJk9IwdJmU/4O0CfzvIr5faBCNTXnnyqgTDbDnEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=L9k78zW6bp/+0gKaf+zI2V7sM8f5vbcCdNMSIaG/vw1yKpclaAd+swwvkijbpGXii
         kMWNDQpqC2yeyoNdzrhwiNufp/TJf27oWWk/GJCqC877ocah9+oPqRS2bHY4ePf4UC
         r/dNyfPcNreSohJYevJwIGjl6VqyMsKF9GeGriPZ7tHrguHk9WXRM0WPhchY6LYEPK
         a3gf2KBQ+Qhn9t3hjNNF2+im/rx0X4IfXIXzn+Ze1Sw6/NUxPU2Wo7WXLooCujjjJ6
         1uoGRqF+Cai/AxwIvgULiCfJiCPFt4EcEzFjgGXvvJWHG07l3KZCORSYKAmnO7CCie
         7SLuaedzsZ5Lg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: dispnv50: fix missing-prototypes warning
Date:   Mon, 17 Apr 2023 23:03:23 +0200
Message-Id: <20230417210329.2469722-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

nv50_display_create() is declared in another header, along with
a couple of declarations that are now outdated:

drivers/gpu/drm/nouveau/dispnv50/disp.c:2517:1: error: no previous prototype for 'nv50_display_create'

Fixes: ba801ef068c1 ("drm/nouveau/kms: display destroy/init/fini hooks can be static")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 1 +
 drivers/gpu/drm/nouveau/nv50_display.h  | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 5bb777ff1313..9b6824f6b9e4 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -64,6 +64,7 @@
 #include "nouveau_connector.h"
 #include "nouveau_encoder.h"
 #include "nouveau_fence.h"
+#include "nv50_display.h"
 
 #include <subdev/bios/dp.h>
 
diff --git a/drivers/gpu/drm/nouveau/nv50_display.h b/drivers/gpu/drm/nouveau/nv50_display.h
index fbd3b15583bc..60f77766766e 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.h
+++ b/drivers/gpu/drm/nouveau/nv50_display.h
@@ -31,7 +31,5 @@
 #include "nouveau_reg.h"
 
 int  nv50_display_create(struct drm_device *);
-void nv50_display_destroy(struct drm_device *);
-int  nv50_display_init(struct drm_device *);
-void nv50_display_fini(struct drm_device *);
+
 #endif /* __NV50_DISPLAY_H__ */
-- 
2.39.2

