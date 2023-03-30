Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6676D04ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjC3MiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjC3MiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:38:14 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B404772BA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:38:11 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:54074.551065922
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 5FC191001C8;
        Thu, 30 Mar 2023 20:38:08 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id ca8e25cfaddb47b390d8dd18937cd7e5 for airlied@gmail.com;
        Thu, 30 Mar 2023 20:38:09 CST
X-Transaction-ID: ca8e25cfaddb47b390d8dd18937cd7e5
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/armada: fix compile warnings on 64-bit platform
Date:   Thu, 30 Mar 2023 20:38:08 +0800
Message-Id: <20230330123808.1590848-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 drivers/gpu/drm/armada/armada_debugfs.c | 2 +-
 drivers/gpu/drm/armada/armada_gem.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index 29f4b52e3c8d..338f0f6ca441 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -48,7 +48,7 @@ static int armada_debugfs_crtc_reg_open(struct inode *inode, struct file *file)
 			   inode->i_private);
 }
 
-static int armada_debugfs_crtc_reg_write(struct file *file,
+static ssize_t armada_debugfs_crtc_reg_write(struct file *file,
 	const char __user *ptr, size_t len, loff_t *off)
 {
 	struct armada_crtc *dcrtc;
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 26d10065d534..e9575ef5aaef 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -364,7 +364,7 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 
 	if (args->offset > dobj->obj.size ||
 	    args->size > dobj->obj.size - args->offset) {
-		DRM_ERROR("invalid size: object size %u\n", dobj->obj.size);
+		DRM_ERROR("invalid size: object size %zu\n", dobj->obj.size);
 		ret = -EINVAL;
 		goto unref;
 	}
-- 
2.25.1

