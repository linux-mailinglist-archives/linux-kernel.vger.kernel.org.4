Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38DF7363CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFTGsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjFTGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:47:51 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EEEEE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=DWKAFEQyu98IZ9ZgJni/kueEjxYsF0HocTjSZNu5dc0=;
        b=cMGNWwX+FeprtsjEHvLYOSUZ211lLDMzQXxmXdfQhxXIqJbaWseCwlohRjzI8kWuzPVL
        O2VB9JXBKQsD/DbNxiMXMzrmLn03KrwtiWKFhwPTDUONzAcndz3OJxTXiIAK43QzW2FAgE
        ZBRJwv8azP6NtTHPv24FUCskm796yXLRLWHErC/HoPfWA8IK21mKgKU19TUubA+a121BpS
        Ly4qAioPvfhZiYD2EEmJz8Hamf+flxBeMdXw28hgWOzvmHMFcZWbHUgXLCnEGc4DjPpMSt
        uZHz+RNGL0QnNHtiF32vqkQMt/KjyLSk43zlGMXPfeWilVw59ShCanwl9SXr73IA==
Received: by filterdrecv-77869f68cc-wnrh7 with SMTP id filterdrecv-77869f68cc-wnrh7-1-64914B8B-15
        2023-06-20 06:47:39.640836851 +0000 UTC m=+3481899.293266760
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id HGVB4aOXSe-PK4Ce6TiCSw
        Tue, 20 Jun 2023 06:47:39.424 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/4] drm/rockchip: vop2: Add missing call to crtc reset helper
Date:   Tue, 20 Jun 2023 06:47:39 +0000 (UTC)
Message-ID: <20230620064732.1525594-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620064732.1525594-1-jonas@kwiboo.se>
References: <20230620064732.1525594-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h6Y7pOvDXJbRf1XNu?=
 =?us-ascii?Q?rdBi7Uj4gm=2FqSVvpHVBX1ECIzrzeDP264QZlPK8?=
 =?us-ascii?Q?XVyx2htZ01V+Bv6v+2TFKR+yi8Clec1TIcHYFqV?=
 =?us-ascii?Q?rHMgVC2Fuc9xcteSRcSANogG=2FdAYLvXbM03ivh8?=
 =?us-ascii?Q?3hFYYW8bmitC3yQZqXoXMZmUpvRzto6f4+Hlm0?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Mark Yao <markyao0591@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 28 ++++++++------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index f725487d02ef..1be84fe0208f 100644
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
@@ -2123,6 +2106,17 @@ static void vop2_crtc_destroy_state(struct drm_crtc *crtc,
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
+	__drm_atomic_helper_crtc_reset(crtc, &vcstate->base);
+}
+
 static const struct drm_crtc_funcs vop2_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-- 
2.41.0

