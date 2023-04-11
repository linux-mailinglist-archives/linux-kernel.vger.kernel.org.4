Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FEF6DD9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjDKLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjDKLoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:44:32 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA35749FA;
        Tue, 11 Apr 2023 04:44:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; 
   d="scan'208";a="159045229"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2023 20:43:37 +0900
Received: from localhost.localdomain (unknown [10.226.93.123])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7D697400195D;
        Tue, 11 Apr 2023 20:43:33 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 11/17] drm: rcar-du: Move rcar_du_vsp_plane_cleanup_fb()
Date:   Tue, 11 Apr 2023 12:42:29 +0100
Message-Id: <20230411114235.366042-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
References: <20230411114235.366042-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rcar_du_vsp_plane_cleanup_fb() to RCar DU vsp lib so that
it can be shared by both RCar and RZ/G2L DU vsp drivers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Rebased to drm-tip.
v1->v6:
 * Rebased on drm-misc-next and DU-next.
v1:
 * Created the lib suggested by Laurent.
Ref:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220316131100.30685-6-biju.das.jz@bp.renesas.com/
---
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c     | 12 ------------
 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c | 12 ++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h |  7 +++++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 3abc5031112e..d785654e4aa3 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -139,18 +139,6 @@ static void rcar_du_vsp_plane_setup(struct rcar_du_vsp_plane *plane)
 			      plane->index, &cfg);
 }
 
-static void rcar_du_vsp_plane_cleanup_fb(struct drm_plane *plane,
-					 struct drm_plane_state *state)
-{
-	struct rcar_du_vsp_plane_state *rstate = to_rcar_vsp_plane_state(state);
-	struct rcar_du_vsp *vsp = to_rcar_vsp_plane(plane)->vsp;
-
-	if (!state->visible)
-		return;
-
-	rcar_du_vsp_unmap_fb(vsp, state->fb, rstate->sg_tables);
-}
-
 static int rcar_du_vsp_plane_atomic_check(struct drm_plane *plane,
 					  struct drm_atomic_state *state)
 {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c
index 91259d44efe9..9240c56ec40f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.c
@@ -211,6 +211,18 @@ void rcar_du_vsp_unmap_fb(struct rcar_du_vsp *vsp, struct drm_framebuffer *fb,
 	}
 }
 
+void rcar_du_vsp_plane_cleanup_fb(struct drm_plane *plane,
+				  struct drm_plane_state *state)
+{
+	struct rcar_du_vsp_plane_state *rstate = to_rcar_vsp_plane_state(state);
+	struct rcar_du_vsp *vsp = to_rcar_vsp_plane(plane)->vsp;
+
+	if (!state->visible)
+		return;
+
+	rcar_du_vsp_unmap_fb(vsp, state->fb, rstate->sg_tables);
+}
+
 static struct drm_plane_state *
 rcar_du_vsp_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h b/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h
index 3d3a7735facd..efd2bb36c88b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp_lib.h
@@ -27,6 +27,8 @@ int rcar_du_lib_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
 			 const struct drm_plane_helper_funcs *rcar_du_vsp_plane_helper_funcs);
 int rcar_du_vsp_plane_prepare_fb(struct drm_plane *plane,
 				 struct drm_plane_state *state);
+void rcar_du_vsp_plane_cleanup_fb(struct drm_plane *plane,
+				  struct drm_plane_state *state);
 #else
 static inline void rcar_du_vsp_disable(struct rcar_du_crtc *crtc) { };
 static inline void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc) { };
@@ -57,6 +59,11 @@ static inline int rcar_du_vsp_plane_prepare_fb(struct drm_plane *plane,
 {
 	return -ENXIO;
 }
+
+static inline void rcar_du_vsp_plane_cleanup_fb(struct drm_plane *plane,
+						struct drm_plane_state *state)
+{
+}
 #endif
 
 #endif /* __RCAR_DU_VSP_LIB_H__ */
-- 
2.25.1

