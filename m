Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351966CFEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjC3Itb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC3It1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:49:27 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C5EE61A5;
        Thu, 30 Mar 2023 01:49:24 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:44746.1405145320
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id A48DB100207;
        Thu, 30 Mar 2023 16:49:22 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-ljp89 with ESMTP id 2a8c5f62236a4e4db151dd2bf1489911 for maarten.lankhorst@linux.intel.com;
        Thu, 30 Mar 2023 16:49:23 CST
X-Transaction-ID: 2a8c5f62236a4e4db151dd2bf1489911
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     nathan@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 3/3] drm/fbdev-generic: optimize out a redundant assignment clause
Date:   Thu, 30 Mar 2023 16:49:11 +0800
Message-Id: <20230330084911.1565071-3-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330084911.1565071-1-15330273260@189.cn>
References: <20230330084911.1565071-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

 The assignment already done in drm_client_buffer_vmap(), this patch save
 a copy. No functional change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index 8e5148bf40bb..be4522268927 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -183,7 +183,7 @@ static int drm_fbdev_generic_damage_blit(struct drm_fb_helper *fb_helper,
 					 struct drm_clip_rect *clip)
 {
 	struct drm_client_buffer *buffer = fb_helper->buffer;
-	struct iosys_map map, dst;
+	struct iosys_map map;
 	int ret;
 
 	/*
@@ -203,8 +203,7 @@ static int drm_fbdev_generic_damage_blit(struct drm_fb_helper *fb_helper,
 	if (ret)
 		goto out;
 
-	dst = map;
-	drm_fbdev_generic_damage_blit_real(fb_helper, clip, &dst);
+	drm_fbdev_generic_damage_blit_real(fb_helper, clip, &map);
 
 	drm_client_buffer_vunmap(buffer);
 
-- 
2.25.1

