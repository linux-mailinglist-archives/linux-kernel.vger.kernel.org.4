Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8443073928A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjFUWdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjFUWdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:33:20 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECE198E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=EBeEmyxPHZsV8uwK86Vd5rWpL+TZ9Rlo5l7W7Yh2uhw=;
        b=aMHyRWqwoobd2f1d7rESpCk+lcJj5Z9C/apkwSupwwykIXNOJP/NLA+9jeCE1UEXhTcC
        qnOqSRtq7pT6VYAlN7+GV+nQmVthZwMzFxpuWcGUh7fHsaROlYE21qNesmJYShwqF6J1P8
        y8eoe9MvDB8jfrZsWvy1QOPxjzLErndwQHhP8UXcbWLXdcDiaN1osR0cFiOfKB+ZtWKDp1
        8nsc0PVm8QsGmfsf7fIdeyoyDdmVfOsbbm4EAxAnLkZSM16po4xEc6BAVg8nBz7qlk323j
        AacmXij6fSU1hOKpMp5Nd73t5H3RvphjtczNKwKYrqnKzT3mDwyxmQhIJsMhYv8w==
Received: by filterdrecv-65f68489c8-k2rl8 with SMTP id filterdrecv-65f68489c8-k2rl8-1-64937AAE-5
        2023-06-21 22:33:18.193802383 +0000 UTC m=+1463593.463557322
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-0 (SG)
        with ESMTP
        id -sFQmpmXTsaEvCoAmpELPQ
        Wed, 21 Jun 2023 22:33:17.910 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/5] drm/rockchip: vop: Use cleanup helper directly as
 destroy funcs
Date:   Wed, 21 Jun 2023 22:33:18 +0000 (UTC)
Message-ID: <20230621223311.2239547-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621223311.2239547-1-jonas@kwiboo.se>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hx33UZE3akeZPDZ+m?=
 =?us-ascii?Q?Bfd1ZvpDkt9enAwukw495j=2FN8pAF5a9hBPnC8XN?=
 =?us-ascii?Q?JBaYIDCfuUuuWEK4B0qxGqt4f05EEKdOuPGPL3=2F?=
 =?us-ascii?Q?TrPHf100KIydab1+TLmvENkrCcLhmYaS5=2F=2Fuzeh?=
 =?us-ascii?Q?Jsebd9LJqi2jJbsxX1+jA0IpIO84WdFwwLAsea?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Mark Yao <markyao0591@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v2:
- Collect r-b tag

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

