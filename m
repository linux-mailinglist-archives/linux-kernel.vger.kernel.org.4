Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACFE620288
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiKGWsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiKGWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:48:38 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD7A1AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sySJwRNCJq4r2+3MMsumWj1zNyj1+FHPOHGSSLMipnw=; b=PmOycH+FYYcMYFjF5DfoMb6EF0
        sNyu4l8JB5jpS956w4cnqFv1zzZ1kWyP/QyrNrcvupvNaztDWMxcMkS5UT1OBZ02WwM4qWNd9LLDA
        Y3BI7IGwsDTul2bHuZSo2VkfjNKl1BBswS5wZqgt3CaGVpHRqHMy4YYnCJWUaWUWy1zFTsp6Ngc/Z
        cM4VFqZ8JBWwn8wHNVcWTNxRSPEffkZnC/oPPOMPf5W44VBKR206fLIxrusH5yWYFdrDWJTavCNt0
        rXSjiH5OB4ebHtvgfUwJRdbjOtmTouhELSxwRK7clTiy24cWM73DD4+57ZjxKkp1CRF9LsIHvU40U
        TL7+ADZQ==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1osAuv-00E9qX-5s; Mon, 07 Nov 2022 23:48:33 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 1/2] drm/v3d: switch to drmm_mutex_init
Date:   Mon,  7 Nov 2022 19:46:55 -0300
Message-Id: <20221107224656.278135-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107224656.278135-1-mcanal@igalia.com>
References: <20221107224656.278135-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex_init() is supposed to be balanced by a call to mutex_destroy(), but
this is not currently happening on the v3d driver.

Considering the introduction of a DRM-managed mutex_init variant, switch
to drmm_mutex_init.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index b8980440d137..96af1cb5202a 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -10,6 +10,7 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
+#include <drm/drm_managed.h>
 #include <drm/drm_syncobj.h>
 #include <uapi/drm/v3d_drm.h>
 
@@ -1075,10 +1076,18 @@ v3d_gem_init(struct drm_device *dev)
 
 	spin_lock_init(&v3d->mm_lock);
 	spin_lock_init(&v3d->job_lock);
-	mutex_init(&v3d->bo_lock);
-	mutex_init(&v3d->reset_lock);
-	mutex_init(&v3d->sched_lock);
-	mutex_init(&v3d->cache_clean_lock);
+	ret = drmm_mutex_init(dev, &v3d->bo_lock);
+	if (ret)
+		return ret;
+	ret = drmm_mutex_init(dev, &v3d->reset_lock);
+	if (ret)
+		return ret;
+	ret = drmm_mutex_init(dev, &v3d->sched_lock);
+	if (ret)
+		return ret;
+	ret = drmm_mutex_init(dev, &v3d->cache_clean_lock);
+	if (ret)
+		return ret;
 
 	/* Note: We don't allocate address 0.  Various bits of HW
 	 * treat 0 as special, such as the occlusion query counters
-- 
2.38.1

