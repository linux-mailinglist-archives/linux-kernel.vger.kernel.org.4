Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87856130B7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJaGt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaGtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:49:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422E9FF8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 23:49:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64CA81F86C;
        Mon, 31 Oct 2022 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667198961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0gFm01OHWbj+XsDZdv3TJX5nsOjli+kx7EDEAKVTL8Y=;
        b=N+uZXUALEGXXc3IoVl7BMnua/r1pMEbVnX5vRTbdZA5sJR7Mc11H568DT4SS1QYeFj9STp
        ij2IIzzfAKrSvqS4LXhrRWbOKMzIN/+VADVzpuEHJbVsADmqD3bbfyktLYymw1RZ+kasTG
        erPwFbeiQ8ctVPgL3zG8sf8rfItXoUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667198961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0gFm01OHWbj+XsDZdv3TJX5nsOjli+kx7EDEAKVTL8Y=;
        b=XMCem/z6POVnz7jeoJ/nK5GR5s86SuSbgbCvQKdjqU8zWu3GeYmFsMYtuzqBte5MzOZ9wI
        pyvPOkUad1ysz8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E09213AAD;
        Mon, 31 Oct 2022 06:49:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +1/KBfFvX2M+DwAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 31 Oct 2022 06:49:21 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Use a local mutex for bind/unbind protection
Date:   Mon, 31 Oct 2022 07:49:18 +0100
Message-Id: <20221031064918.14178-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used drm_modeset_lock_all() for protecting the audio component
bind/unbind operations against the notification, but it seems leading
to kernel WARNING and Oops.  Moreover, the use of
drm_modeset_lock_all() is rather an overkill only for this
protection.

This patch introduces a new mutex that protects just the bind/unbind
and the notify calls and replaces the drm_modeset_lock with it.

Fixes: 34d84636e5e0 ("drm/radeon: Add HD-audio component notifier support (v4)")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1569
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/radeon/radeon.h        |  1 +
 drivers/gpu/drm/radeon/radeon_audio.c  | 21 ++++++++++++---------
 drivers/gpu/drm/radeon/radeon_device.c |  1 +
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index d82424525f5a..2e7161acd443 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1799,6 +1799,7 @@ struct r600_audio {
 	struct radeon_audio_basic_funcs *funcs;
 	struct drm_audio_component *component;
 	bool component_registered;
+	struct mutex component_mutex;
 };
 
 /*
diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 4ceb90556127..71b67d4efe08 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -181,8 +181,7 @@ static struct radeon_audio_funcs dce6_dp_funcs = {
 	.dpms = evergreen_dp_enable,
 };
 
-static void radeon_audio_component_notify(struct drm_audio_component *acomp,
-					  int port);
+static void radeon_audio_component_notify(struct radeon_device *rdev, int port);
 
 static void radeon_audio_enable(struct radeon_device *rdev,
 				struct r600_audio_pin *pin, u8 enable_mask)
@@ -212,7 +211,7 @@ static void radeon_audio_enable(struct radeon_device *rdev,
 	if (rdev->audio.funcs->enable)
 		rdev->audio.funcs->enable(rdev, pin, enable_mask);
 
-	radeon_audio_component_notify(rdev->audio.component, pin->id);
+	radeon_audio_component_notify(rdev, pin->id);
 }
 
 static void radeon_audio_interface_init(struct radeon_device *rdev)
@@ -731,12 +730,16 @@ unsigned int radeon_audio_decode_dfs_div(unsigned int div)
 /*
  * Audio component support
  */
-static void radeon_audio_component_notify(struct drm_audio_component *acomp,
-					  int port)
+static void radeon_audio_component_notify(struct radeon_device *rdev, int port)
 {
+	struct drm_audio_component *acomp;
+
+	mutex_lock(&rdev->audio.component_mutex);
+	acomp = rdev->audio.component;
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
 		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
 						 port, -1);
+	mutex_unlock(&rdev->audio.component_mutex);
 }
 
 static int radeon_audio_component_get_eld(struct device *kdev, int port,
@@ -787,11 +790,11 @@ static int radeon_audio_component_bind(struct device *kdev,
 	if (WARN_ON(!device_link_add(hda_kdev, kdev, DL_FLAG_STATELESS)))
 		return -ENOMEM;
 
-	drm_modeset_lock_all(dev);
+	mutex_lock(&rdev->audio.component_mutex);
 	acomp->ops = &radeon_audio_component_ops;
 	acomp->dev = kdev;
 	rdev->audio.component = acomp;
-	drm_modeset_unlock_all(dev);
+	mutex_unlock(&rdev->audio.component_mutex);
 
 	return 0;
 }
@@ -805,11 +808,11 @@ static void radeon_audio_component_unbind(struct device *kdev,
 
 	device_link_remove(hda_kdev, kdev);
 
-	drm_modeset_lock_all(dev);
+	mutex_lock(&rdev->audio.component_mutex);
 	rdev->audio.component = NULL;
 	acomp->ops = NULL;
 	acomp->dev = NULL;
-	drm_modeset_unlock_all(dev);
+	mutex_unlock(&rdev->audio.component_mutex);
 }
 
 static const struct component_ops radeon_audio_component_bind_ops = {
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 17bfbbe906c8..2e13ce2b65d3 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1312,6 +1312,7 @@ int radeon_device_init(struct radeon_device *rdev,
 	mutex_init(&rdev->pm.mutex);
 	mutex_init(&rdev->gpu_clock_mutex);
 	mutex_init(&rdev->srbm_mutex);
+	mutex_init(&rdev->audio.component_mutex);
 	init_rwsem(&rdev->pm.mclk_lock);
 	init_rwsem(&rdev->exclusive_lock);
 	init_waitqueue_head(&rdev->irq.vblank_queue);
-- 
2.35.3

