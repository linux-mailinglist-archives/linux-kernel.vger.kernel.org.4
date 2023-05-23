Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0870E092
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjEWPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbjEWPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:33:11 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B018F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:32:43 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4QQdc9028wz4wyWg
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:32:41 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b0ac:7afd:272:4cff])
        by xavier.telenet-ops.be with bizsmtp
        id 0FXf2A00d0Jkz7G01FXfar; Tue, 23 May 2023 17:31:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tyu-002t3U-Hz;
        Tue, 23 May 2023 17:31:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1Tz8-00Ckam-UT;
        Tue, 23 May 2023 17:31:38 +0200
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
Subject: [PATCH v3 0/5] drm: shmobile: Fixes and enhancements
Date:   Tue, 23 May 2023 17:31:32 +0200
Message-Id: <cover.1684854992.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

Currently, there are two drivers for the LCD controller on Renesas
SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
  1. sh_mobile_lcdcfb, using the fbdev framework,
  2. shmob_drm, using the DRM framework.
However, only the former driver can be used, as all platform support
integrates the former.  None of these drivers support DT-based systems.

This patch series is a first step to enable the SH-Mobile DRM driver for
Renesas ARM-based SH-Mobile and R-Mobile SoCs.  The next steps planned are
to (1) add DT support (works, but needs a hack due to lack of (2)), and (2)
convert the driver to atomic modesetting.

Changes compared to v2[1]:
  - Add Reviewed-by.

Changes compared to v1[2]:
  - Add Reviewed-by,
  - Drop dependency on ARM.

This has been tested on the R-Mobile A1-based Atmark Techno
Armadillo-800-EVA development board, using a temporary
platform-enablement patch[3].

Thanks for applying to drm-misc!

[1] https://lore.kernel.org/r/cover.1680273039.git.geert+renesas@glider.be/
[2] https://lore.kernel.org/r/cover.1681734821.git.geert+renesas@glider.be/
[3] https://lore.kernel.org/r/c03d4edbd650836bf6a96504df82338ec6d800ff.1680272980.git.geert+renesas@glider.be

Geert Uytterhoeven (5):
  drm: shmobile: Use %p4cc to print fourcc codes
  drm: shmobile: Add support for DRM_FORMAT_XRGB8888
  drm: shmobile: Switch to drm_crtc_init_with_planes()
  drm: shmobile: Add missing call to drm_fbdev_generic_setup()
  drm: shmobile: Make DRM_SHMOBILE visible on Renesas SoC platforms

 drivers/gpu/drm/shmobile/Kconfig           |  4 +--
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c  | 35 +++++++++++++++++++---
 drivers/gpu/drm/shmobile/shmob_drm_drv.c   |  3 ++
 drivers/gpu/drm/shmobile/shmob_drm_kms.c   |  9 ++++--
 drivers/gpu/drm/shmobile/shmob_drm_plane.c |  5 ++++
 5 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
