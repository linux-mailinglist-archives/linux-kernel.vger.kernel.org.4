Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF69D74A107
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjGFPao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjGFPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:30:40 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA5F1BEB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:30:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
        by michel.telenet-ops.be with bizsmtp
        id HrWZ2A00W45Xpxs06rWZ2S; Thu, 06 Jul 2023 17:30:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHQw9-000g6y-2O;
        Thu, 06 Jul 2023 17:30:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHQwD-000qrS-DI;
        Thu, 06 Jul 2023 17:30:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/fbdev-dma: Fix documented default preferred_bpp value
Date:   Thu,  6 Jul 2023 17:30:31 +0200
Message-Id: <91f093ffe436a9f94d58fb2bfbc1407f1ebe8bb0.1688656591.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 6c80a93be62d398e ("drm/fb-helper: Initialize fb-helper's
preferred BPP in prepare function"), the preferred_bpp parameter of
drm_fb_helper_prepare() defaults to 32 instead of
drm_mode_config.preferred_depth.  Hence this also applies to
drm_fbdev_dma_setup(), which just passes its own preferred_bpp
parameter.

Fixes: b79fe9abd58bab73 ("drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/drm_fbdev_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index d86773fa8ab00f49..76aa52b38a13ed63 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -217,7 +217,7 @@ static const struct drm_client_funcs drm_fbdev_dma_client_funcs = {
  * drm_fbdev_dma_setup() - Setup fbdev emulation for GEM DMA helpers
  * @dev: DRM device
  * @preferred_bpp: Preferred bits per pixel for the device.
- *                 @dev->mode_config.preferred_depth is used if this is zero.
+ *                 32 is used if this is zero.
  *
  * This function sets up fbdev emulation for GEM DMA drivers that support
  * dumb buffers with a virtual address and that can be mmap'ed.
-- 
2.34.1

