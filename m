Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B06CFEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjC3Itg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjC3It1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:49:27 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72DC36EBD;
        Thu, 30 Mar 2023 01:49:23 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:44746.1405145320
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id B21471002EE;
        Thu, 30 Mar 2023 16:49:21 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-ljp89 with ESMTP id 14a233d3256440669eb13540df3b3627 for maarten.lankhorst@linux.intel.com;
        Thu, 30 Mar 2023 16:49:22 CST
X-Transaction-ID: 14a233d3256440669eb13540df3b3627
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
Subject: [PATCH 2/3] drm/drm_gem.c: remove surplus else after return clause
Date:   Thu, 30 Mar 2023 16:49:10 +0800
Message-Id: <20230330084911.1565071-2-15330273260@189.cn>
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

 else is not generally useful after return

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/drm_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a6208e2c089b..364e3733af98 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1150,8 +1150,8 @@ int drm_gem_pin(struct drm_gem_object *obj)
 {
 	if (obj->funcs->pin)
 		return obj->funcs->pin(obj);
-	else
-		return 0;
+
+	return 0;
 }
 
 void drm_gem_unpin(struct drm_gem_object *obj)
@@ -1172,7 +1172,8 @@ int drm_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	ret = obj->funcs->vmap(obj, map);
 	if (ret)
 		return ret;
-	else if (iosys_map_is_null(map))
+
+	if (iosys_map_is_null(map))
 		return -ENOMEM;
 
 	return 0;
-- 
2.25.1

