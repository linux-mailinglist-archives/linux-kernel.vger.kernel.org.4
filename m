Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1F74460D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 04:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGACJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 22:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjGACJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 22:09:39 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9A1997
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HPO0XUJvL8MHQ9quXzm+tMdaWyxXHw4tFqRhJIQaDP4=; b=G81G6jtzf5peArDdZPEHo5CFND
        9ShevZnQGMgqjIxJa8fJvELfg5qHbJpntuyUtQyljiOgRr00DsNj0pIb9i7kfq5Ar6aFMWsZrpD05
        AwlRe/nsLRKLaDUtiEMgPPijGxLzDmpTs/WOpKeUWfXJ65CONWQFUhwxoQQfM2XqO4xLqFb1tux1P
        oraLfPnC4/2W3gEwfeZSCfxviWGgka8EUWyjkuo5AkzrVG/W4gxVDTaQwBGpUuDn4SZgEcGJ9VCtK
        6SMHc7OWFITQUT6bOwQsXMdoYP+c7qg4hoL0Gd8nh6kmYLY/HssVVGJ1uNzftRxSm3Te6PkhEYILP
        XcKuM40A==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qFQ3L-006abr-S9; Sat, 01 Jul 2023 04:09:36 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Italo Nicola <italonicola@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 2/6] drm: introduce DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
Date:   Fri, 30 Jun 2023 23:09:13 -0300
Message-ID: <20230701020917.143394-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701020917.143394-1-andrealmeid@igalia.com>
References: <20230701020917.143394-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Ser <contact@emersion.fr>

This new kernel capability indicates whether async page-flips are
supported via the atomic uAPI. DRM clients can use it to check
for support before feeding DRM_MODE_PAGE_FLIP_ASYNC to the kernel.

Make it clear that DRM_CAP_ASYNC_PAGE_FLIP is for legacy uAPI only.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: no changes
---
 drivers/gpu/drm/drm_ioctl.c |  5 +++++
 include/uapi/drm/drm.h      | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 7c9d66ee917d..8f756b99260d 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -302,6 +302,11 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
 		req->value = 1;
 		break;
+	case DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP:
+		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
+			     dev->mode_config.async_page_flip &&
+			     !dev->mode_config.atomic_async_page_flip_not_supported;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index a87bbbbca2d4..54c558f81f3c 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -706,7 +706,8 @@ struct drm_gem_open {
 /**
  * DRM_CAP_ASYNC_PAGE_FLIP
  *
- * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC.
+ * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for legacy
+ * page-flips.
  */
 #define DRM_CAP_ASYNC_PAGE_FLIP		0x7
 /**
@@ -767,6 +768,13 @@ struct drm_gem_open {
  * Documentation/gpu/drm-mm.rst, section "DRM Sync Objects".
  */
 #define DRM_CAP_SYNCOBJ_TIMELINE	0x14
+/**
+ * DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
+ *
+ * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for atomic
+ * commits.
+ */
+#define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
 
 /* DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
-- 
2.41.0

