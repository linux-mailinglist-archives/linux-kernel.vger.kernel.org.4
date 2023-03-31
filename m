Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F216D2324
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjCaOxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjCaOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:53:06 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86E20C20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:52:41 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id f2se2900l1C8whw062seLb; Fri, 31 Mar 2023 16:52:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1piG2N-00FUgb-4H;
        Fri, 31 Mar 2023 16:48:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1piG36-008fIS-Hl;
        Fri, 31 Mar 2023 16:48:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/5] drm: shmobile: Use %p4cc to print fourcc codes
Date:   Fri, 31 Mar 2023 16:48:07 +0200
Message-Id: <1912536b0972568efc3d4f96c89de96b2abd7510.1680273039.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680273039.git.geert+renesas@glider.be>
References: <cover.1680273039.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the printing of hexadecimal fourcc format codes by
pretty-printed format names, using the "%p4cc" format specifier.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c | 4 ++--
 drivers/gpu/drm/shmobile/shmob_drm_kms.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
index d354ab3077cecf94..713a7612244c647a 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
@@ -355,8 +355,8 @@ static int shmob_drm_crtc_mode_set(struct drm_crtc *crtc,
 
 	format = shmob_drm_format_info(crtc->primary->fb->format->format);
 	if (format == NULL) {
-		dev_dbg(sdev->dev, "mode_set: unsupported format %08x\n",
-			crtc->primary->fb->format->format);
+		dev_dbg(sdev->dev, "mode_set: unsupported format %p4cc\n",
+			&crtc->primary->fb->format->format);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
index 60a2c8d8a0d947d2..3c5fe3bc183c7c13 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_kms.c
@@ -96,8 +96,8 @@ shmob_drm_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 
 	format = shmob_drm_format_info(mode_cmd->pixel_format);
 	if (format == NULL) {
-		dev_dbg(dev->dev, "unsupported pixel format %08x\n",
-			mode_cmd->pixel_format);
+		dev_dbg(dev->dev, "unsupported pixel format %p4cc\n",
+			&mode_cmd->pixel_format);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.34.1

