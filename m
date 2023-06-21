Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDF73928D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFUWd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjFUWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:33:22 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB9173F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=N3/rzRG3o23sD+ICspFZR3Hn+pKFLqALOJeNlqnKgj4=;
        b=odo6I7Jt7vJMGUnTiX003h/h8HEQt1HFOUB00tQROehfkL77cpEvY37AZmQGVQkAjjO1
        +vExX5bMazjGKH1Kak0ROyBhP7gG4VQ4mKNf2kOPWts/wX01JJiYLvcURr4p8QRHMzLVYw
        enwvkMPNRdMtVo4za6tO8B/xk8FvH+GsScKALqG3YwK6BTRHLkek1QpTfgR+pADi1KPTW7
        OtcUXI9ClAufLMKUWkoD1BYAoFBYNZogpZL4+Snt4P+unpFxwqsEqTxsbH+ieJc5kc8O09
        H4x4ZykiaZS9cfKtysqt4m0I+DQuF6WWklCLiG9IMOeCUl+TZ4KK4iU2RBcOeFQA==
Received: by filterdrecv-84b96456cb-hq7z7 with SMTP id filterdrecv-84b96456cb-hq7z7-1-64937AAF-22
        2023-06-21 22:33:19.939834959 +0000 UTC m=+3624888.194376328
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-0 (SG)
        with ESMTP
        id ZVQYkneORxuup128izvcVw
        Wed, 21 Jun 2023 22:33:19.491 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/5] drm/rockchip: vop: Fix call to crtc reset helper
Date:   Wed, 21 Jun 2023 22:33:20 +0000 (UTC)
Message-ID: <20230621223311.2239547-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621223311.2239547-1-jonas@kwiboo.se>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h8LrEgJzY5ktvBu14?=
 =?us-ascii?Q?zmHPK0tdeaF=2FrED9ytrdgA=2FZcc=2FZBkGuBtyyJes?=
 =?us-ascii?Q?jdWC3QvDOV0X9yW1R=2FVKEfNKLQZiqi0IWN9hJEM?=
 =?us-ascii?Q?u3kp5LyzgCP2h1kCUAeCgKtnBCtaticfzPYPvUW?=
 =?us-ascii?Q?5yA+VOnmOG4HMqlpZ0uNi0PZ1wRrzcrOf+B2f4?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of crtc_state may fail in vop_crtc_reset, causing an invalid
pointer to be passed to __drm_atomic_helper_crtc_reset.

Fix this by adding a NULL check of crtc_state, similar to other drivers.

Fixes: 01e2eaf40c9d ("drm/rockchip: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 25c873d4ff53..23bc79064e78 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1630,7 +1630,10 @@ static void vop_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		vop_crtc_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	if (crtc_state)
+		__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 #ifdef CONFIG_DRM_ANALOGIX_DP
-- 
2.41.0

