Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675536C8C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCYHqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCYHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:46:42 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B0221353B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:46:40 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:33334.1902543559
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id BAD471001EF;
        Sat, 25 Mar 2023 15:46:36 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id 5e01f141a15042c193eaa3c38bd182e1 for maarten.lankhorst@linux.intel.com;
        Sat, 25 Mar 2023 15:46:38 CST
X-Transaction-ID: 5e01f141a15042c193eaa3c38bd182e1
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>, liyi <liyi@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/fbdev-generic: optimize out a redundant assignment clause
Date:   Sat, 25 Mar 2023 15:46:36 +0800
Message-Id: <20230325074636.136833-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The assignment already done in drm_client_buffer_vmap(),
 just trival clean, no functional change.

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index 4d6325e91565..1da48e71c7f1 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -282,7 +282,7 @@ static int drm_fbdev_damage_blit(struct drm_fb_helper *fb_helper,
 				 struct drm_clip_rect *clip)
 {
 	struct drm_client_buffer *buffer = fb_helper->buffer;
-	struct iosys_map map, dst;
+	struct iosys_map map;
 	int ret;
 
 	/*
@@ -302,8 +302,7 @@ static int drm_fbdev_damage_blit(struct drm_fb_helper *fb_helper,
 	if (ret)
 		goto out;
 
-	dst = map;
-	drm_fbdev_damage_blit_real(fb_helper, clip, &dst);
+	drm_fbdev_damage_blit_real(fb_helper, clip, &map);
 
 	drm_client_buffer_vunmap(buffer);
 
-- 
2.25.1

