Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64C6B9C53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCNQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCNQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:57:43 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B202B1B2F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:57:34 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:51764.1378362099
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 1024910029F;
        Wed, 15 Mar 2023 00:57:25 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-698c9d7bb7-s8g24 with ESMTP id 9cace5e29154469986979a83f13f6eed for maarten.lankhorst@linux.intel.com;
        Wed, 15 Mar 2023 00:57:32 CST
X-Transaction-ID: 9cace5e29154469986979a83f13f6eed
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
Subject: [PATCH] drm/vram-helper: remove a redundant iosys_map_clear call in move_notify
Date:   Wed, 15 Mar 2023 00:57:22 +0800
Message-Id: <20230314165722.2290209-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 As it is already called in ttm_bo_vunmap()

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 0bea3df2a16d..b0c2a7ef91bf 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -558,7 +558,6 @@ static void drm_gem_vram_bo_driver_move_notify(struct drm_gem_vram_object *gbo)
 		return;
 
 	ttm_bo_vunmap(bo, &gbo->map);
-	iosys_map_clear(&gbo->map); /* explicitly clear mapping for next vmap call */
 }
 
 static int drm_gem_vram_bo_driver_move(struct drm_gem_vram_object *gbo,
-- 
2.25.1

