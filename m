Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1FC7363CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjFTGr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFTGru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:47:50 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567601707
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=WIftQBIpIy4TYM/w/l437zYjnaja+iEv9fSTQdcIaxc=;
        b=DD8iiQ3BAznRD1abNxYFKd9FHfceipbNMrV1hgdm7Tior8YDCBRjEgOXsTiSHl10CIFg
        c9EJnBeSFAU/kN1aAyQld2KFKR61y8VXWQExNua3TYlYNv4v7sbgDt3wWlCID2MvbIQE1H
        TKK/Qm0UXcDm3Wbp/tFsqOISysV8dMJjAdgjo0t4IooRVDydt9d1Sp7IVsCIGMQflMGMTJ
        QkvgEoQ9zQGRA4IeTiwzwWvVEv7GPpNdgtH6MrSUu1t6qaUsB4GRZfBWqXkHNnWPtd6gVS
        2kmfOP2nxBtMo+eVPQndktCzKStTkBNpLQgqSMCyGoIucG8Rk+d99MUwSt+NIiDA==
Received: by filterdrecv-84b96456cb-rsmc4 with SMTP id filterdrecv-84b96456cb-rsmc4-1-64914B89-1E
        2023-06-20 06:47:37.498149536 +0000 UTC m=+3481757.706840986
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-5 (SG)
        with ESMTP
        id ZMjEKrw4Qmu6N8KSTS7lHQ
        Tue, 20 Jun 2023 06:47:37.177 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] drm/rockchip: vop: Use cleanup helper directly as destroy
 funcs
Date:   Tue, 20 Jun 2023 06:47:37 +0000 (UTC)
Message-ID: <20230620064732.1525594-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620064732.1525594-1-jonas@kwiboo.se>
References: <20230620064732.1525594-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+3K61RI4BbEH1Wyo?=
 =?us-ascii?Q?vFH13WxQgrm+3EFl7eTAtcTWehbd5CjXWBfBMem?=
 =?us-ascii?Q?cOLPT8tHF4GvEfty=2FJ9+9b1lO9STEgBH0gTc6sC?=
 =?us-ascii?Q?l9wg6cZHLA=2FlzFWk+G=2FzgjDt6pt8CLJGBUvCAty?=
 =?us-ascii?Q?PSsd6nI8PiowPylzlmCebaE8wDUKtK=2F0ynPcNv?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Mark Yao <markyao0591@gmail.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
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

vop_plane_destroy and vop_crtc_destroy are plain wrappers around
drm_plane_cleanup and drm_crtc_cleanup. Use them directly as plane and
crtc funcs to closer match VOP2 driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 60b23636a3fe..25c873d4ff53 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -766,11 +766,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	}
 }
 
-static void vop_plane_destroy(struct drm_plane *plane)
-{
-	drm_plane_cleanup(plane);
-}
-
 static inline bool rockchip_afbc(u64 modifier)
 {
 	return modifier == ROCKCHIP_AFBC_MOD;
@@ -1131,7 +1126,7 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 static const struct drm_plane_funcs vop_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
-	.destroy = vop_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
@@ -1602,11 +1597,6 @@ static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
 	.atomic_disable = vop_crtc_atomic_disable,
 };
 
-static void vop_crtc_destroy(struct drm_crtc *crtc)
-{
-	drm_crtc_cleanup(crtc);
-}
-
 static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct rockchip_crtc_state *rockchip_state;
@@ -1711,7 +1701,7 @@ vop_crtc_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.destroy = vop_crtc_destroy,
+	.destroy = drm_crtc_cleanup,
 	.reset = vop_crtc_reset,
 	.atomic_duplicate_state = vop_crtc_duplicate_state,
 	.atomic_destroy_state = vop_crtc_destroy_state,
@@ -1962,7 +1952,7 @@ static void vop_destroy_crtc(struct vop *vop)
 	 */
 	list_for_each_entry_safe(plane, tmp, &drm_dev->mode_config.plane_list,
 				 head)
-		vop_plane_destroy(plane);
+		drm_plane_cleanup(plane);
 
 	/*
 	 * Destroy CRTC after vop_plane_destroy() since vop_disable_plane()
-- 
2.41.0

