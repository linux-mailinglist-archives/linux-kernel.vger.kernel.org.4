Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F81739291
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjFUWdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFUWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:33:25 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5F19AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=gpt4shW9Az8HQBaGBESfhw3ZJgloP+jLONDW/keDorI=;
        b=A8qHE49+Rg910ao7nsxF5wejLhadp5zf4H3oduW0IvhB6JgcqzK642zeQKPYN3xd6Kz+
        bZnriW/wigqdWrwPerUr09sTPqBJt1oeH+WKLmj6f4fuLH+uXvBViFsnAkB5KmwqIV7FXf
        DOJdKVGEcwKWyiwnz5XFki6bDwuRZxiFpFMO2mdKfZ8kK5OZkZaaqS7RiotSwKZ7ZHQP5W
        QiOanLgQtVB5gyhNfl4RX6hS3/sHP8wvXV1jWLkCu4lJ3rLePPLxPizm/1ir69yz97MbZC
        umfuwRmM0t1fB2ftWFwruJmeMlIXXqNMVbpPcCJ3qaB0IA3OcRvKyEfhubPU/Mcw==
Received: by filterdrecv-65f68489c8-k2rl8 with SMTP id filterdrecv-65f68489c8-k2rl8-1-64937AB2-32
        2023-06-21 22:33:23.019043275 +0000 UTC m=+1463598.288798320
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-0 (SG)
        with ESMTP
        id W7fz8D3QRnife75m7ND9CA
        Wed, 21 Jun 2023 22:33:22.815 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 5/5] drm/rockchip: vop2: Add missing call to crtc reset
 helper
Date:   Wed, 21 Jun 2023 22:33:23 +0000 (UTC)
Message-ID: <20230621223311.2239547-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621223311.2239547-1-jonas@kwiboo.se>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hz78e=2FvfUnHx3mUyD?=
 =?us-ascii?Q?KgumjHDaRQIPiL31NJ2du6oz01DwPK8KoRoBpmL?=
 =?us-ascii?Q?Yyy0WPk79Cbsu101l84dCjvPY43LcPBAFqi1CLj?=
 =?us-ascii?Q?jherqCVDXJic79y61QHuggFxh3KOmBgUYnXLJ66?=
 =?us-ascii?Q?WFlOD+0vc2k2vUnxf6LJTMHkGpcEaC1sTKecjl?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Yao <markyao0591@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing call to crtc reset helper to properly vblank reset.

Also move vop2_crtc_reset and call vop2_crtc_destroy_state to simplify
and remove duplicated code.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Add check for allocation failure (Sascha)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 31 +++++++++-----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index f725487d02ef..5ba83121a1b9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2080,23 +2080,6 @@ static const struct drm_crtc_helper_funcs vop2_crtc_helper_funcs = {
 	.atomic_disable = vop2_crtc_atomic_disable,
 };
 
-static void vop2_crtc_reset(struct drm_crtc *crtc)
-{
-	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc->state);
-
-	if (crtc->state) {
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-		kfree(vcstate);
-	}
-
-	vcstate = kzalloc(sizeof(*vcstate), GFP_KERNEL);
-	if (!vcstate)
-		return;
-
-	crtc->state = &vcstate->base;
-	crtc->state->crtc = crtc;
-}
-
 static struct drm_crtc_state *vop2_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct rockchip_crtc_state *vcstate;
@@ -2123,6 +2106,20 @@ static void vop2_crtc_destroy_state(struct drm_crtc *crtc,
 	kfree(vcstate);
 }
 
+static void vop2_crtc_reset(struct drm_crtc *crtc)
+{
+	struct rockchip_crtc_state *vcstate =
+		kzalloc(sizeof(*vcstate), GFP_KERNEL);
+
+	if (crtc->state)
+		vop2_crtc_destroy_state(crtc, crtc->state);
+
+	if (vcstate)
+		__drm_atomic_helper_crtc_reset(crtc, &vcstate->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
+}
+
 static const struct drm_crtc_funcs vop2_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-- 
2.41.0

