Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CE73928F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFUWd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjFUWdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:33:24 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4B173F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=v14Q72PruEDwmH4o+T8D3FApv9VBvr48LzkZegCo/u4=;
        b=rBdphp+s6nKgaYVQW7kNM0FgEY82p1wXQvzHlIC5PkiJlWolj396r9VbEcECshqqISme
        K1/Rm9vjIM5834etPzzojd16lF/NBRZp2BaCqg7Ib29s3myOI4lx50490qsayrRlZLWXvP
        dsaZzA04HgTxD3CFwzFXHIAvcVLhImJWFygnSp5/HxQhih5r7U04aCO7JZOIEBZJHfOd4j
        7NfTIYvPAfycoU0VMdh6VtgzIok7APy8agt8yV2/9iWI00Rw9J5qLpRZgTlId6sS74OXJd
        2TWR+V3/4RkVOIhQ2gW42NRU0Vqr4D7+zJyoFw/SUKhcKTmCa2UmxfYZOROn1Zhg==
Received: by filterdrecv-84b96456cb-hq7z7 with SMTP id filterdrecv-84b96456cb-hq7z7-1-64937AB1-C
        2023-06-21 22:33:21.44628361 +0000 UTC m=+3624889.700825056
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-0 (SG)
        with ESMTP
        id vZirRyg8Rfmll8Z_NYscQw
        Wed, 21 Jun 2023 22:33:21.131 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/5] drm/rockchip: vop2: Don't crash for invalid
 duplicate_state
Date:   Wed, 21 Jun 2023 22:33:21 +0000 (UTC)
Message-ID: <20230621223311.2239547-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621223311.2239547-1-jonas@kwiboo.se>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h32UvfMM=2F7Im2hDMc?=
 =?us-ascii?Q?k0YtrNlBiYhIMIchAeUrU5n0sre8GH0aHkc25Kj?=
 =?us-ascii?Q?c5HCoIUZZ7FARoKQ=2FsE9PLBlsEjGZQvKL7ih69v?=
 =?us-ascii?Q?7lbS2KwIG2tZgBHOrdTIIJ9EQxFG=2FdHDwG=2FYZa=2F?=
 =?us-ascii?Q?GhxK=2FKMv6yMvLroFYJpUTZ7sqFN5jm6JxZOkZw?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Yan <andy.yan@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
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

It's possible for users to try to duplicate the CRTC state even when the
state doesn't exist. drm_atomic_helper_crtc_duplicate_state() (and other
users of __drm_atomic_helper_crtc_duplicate_state()) already guard this
with a WARN_ON() instead of crashing, so let's do that here too.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v2:
- Collect r-b tag

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index ca73b8ccc29f..f725487d02ef 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2099,11 +2099,13 @@ static void vop2_crtc_reset(struct drm_crtc *crtc)
 
 static struct drm_crtc_state *vop2_crtc_duplicate_state(struct drm_crtc *crtc)
 {
-	struct rockchip_crtc_state *vcstate, *old_vcstate;
+	struct rockchip_crtc_state *vcstate;
 
-	old_vcstate = to_rockchip_crtc_state(crtc->state);
+	if (WARN_ON(!crtc->state))
+		return NULL;
 
-	vcstate = kmemdup(old_vcstate, sizeof(*old_vcstate), GFP_KERNEL);
+	vcstate = kmemdup(to_rockchip_crtc_state(crtc->state),
+			  sizeof(*vcstate), GFP_KERNEL);
 	if (!vcstate)
 		return NULL;
 
-- 
2.41.0

