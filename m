Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6171FD55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjFBJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjFBJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:12:47 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1885170F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:11:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:158c:2ccf:1f70:e136])
        by baptiste.telenet-ops.be with bizsmtp
        id 49Bg2A00L1tRZS8019BgSY; Fri, 02 Jun 2023 11:11:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50ob-00BvaU-4t;
        Fri, 02 Jun 2023 11:11:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q50ou-00ASIR-8C;
        Fri, 02 Jun 2023 11:11:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] drm: Fix references to drm_plane_helper_check_state()
Date:   Fri,  2 Jun 2023 11:11:36 +0200
Message-Id: <2408d7841c91e98e9a2b24b1b4df9b2b865519a6.1685696114.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1685696114.git.geert+renesas@glider.be>
References: <cover.1685696114.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit a01cb8ba3f628293 ("drm: Move drm_plane_helper_check_state()
into drm_atomic_helper.c"), drm_plane_helper_check_state() no longer
exists, but is part of drm_atomic_helper_check_plane_state().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Interestingly, all these comments appeared only after the commit that
removed the function...

This is against next-20230602, which does not have the
drivers/gpu/drm/{ => renesas}/rcar-du move yet.

Biju: you're adding a new copy in
drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 3 ++-
 drivers/gpu/drm/tidss/tidss_plane.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index d759e019218181ce..e445fac8e0b46c21 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -600,7 +600,8 @@ int __rcar_du_plane_atomic_check(struct drm_plane *plane,
 	if (!state->crtc) {
 		/*
 		 * The visible field is not reset by the DRM core but only
-		 * updated by drm_plane_helper_check_state(), set it manually.
+		 * updated by drm_atomic_helper_check_plane_state(), set it
+		 * manually.
 		 */
 		state->visible = false;
 		*format = NULL;
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 6bdd6e4a955ab3cc..e1c0ef0c3894c855 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -38,7 +38,8 @@ static int tidss_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->crtc) {
 		/*
 		 * The visible field is not reset by the DRM core but only
-		 * updated by drm_plane_helper_check_state(), set it manually.
+		 * updated by drm_atomic_helper_check_plane_state(), set it
+		 * manually.
 		 */
 		new_plane_state->visible = false;
 		return 0;
-- 
2.34.1

