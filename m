Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1306E70E08A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbjEWPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbjEWPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:31:48 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E16196
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:31:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by michel.telenet-ops.be with bizsmtp
        id 0FXf2A0030Jkz7G06FXfv6; Tue, 23 May 2023 17:31:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tyu-002t3m-Lw;
        Tue, 23 May 2023 17:31:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tz9-00Ckb5-3w;
        Tue, 23 May 2023 17:31:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 5/5] drm: shmobile: Make DRM_SHMOBILE visible on Renesas SoC platforms
Date:   Tue, 23 May 2023 17:31:37 +0200
Message-Id: <40ac67e0887d833ab4a3f1ec24828dedf0d8e108.1684854992.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684854992.git.geert+renesas@glider.be>
References: <cover.1684854992.git.geert+renesas@glider.be>
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

The LCD Controller supported by the drm-shmob driver is present
on SuperH SH-Mobile SoCs, and on Renesas ARM SH/R-Mobile SoCs.
Unfortunately its config option is not visible on either, so the user
can never enable the support.

Fix this by dropping the dependency on ARM (for SuperH), and by widening
the dependency range to ARCH_RENESAS (for ARM).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - No changes,

v2:
  - Add Reviewed-by,
  - Drop dependency on ARM, reword.

The driver was disabled on SuperH in commit c66de8cc2ea62941
("drm/shmobile: Add run-time dependencies") in v3.16 because of build
issues.  I couldn't find further details, but currently it builds fine
on (at least) arm, arm64, sh, riscv, and m68k.
---
 drivers/gpu/drm/shmobile/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
index 4ec5dc74a6b0b880..ad14112999ad8aba 100644
--- a/drivers/gpu/drm/shmobile/Kconfig
+++ b/drivers/gpu/drm/shmobile/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 config DRM_SHMOBILE
 	tristate "DRM Support for SH Mobile"
-	depends on DRM && ARM
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on DRM
+	depends on ARCH_RENESAS || ARCH_SHMOBILE || COMPILE_TEST
 	select BACKLIGHT_CLASS_DEVICE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
-- 
2.34.1

