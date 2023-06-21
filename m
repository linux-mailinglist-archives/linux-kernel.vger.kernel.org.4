Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDED373928B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFUWdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFUWdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:33:19 -0400
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF1173F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=s1; bh=W99jR6zQr9o9HH0LFWjkqVeyLEmhww0LQ1TODMrD+JU=;
        b=lgYVrVqzL5xtT/wvZAyliCCJFvkwGuTcAcJfKQdzdxZC6nLMwUo9oDusU22C1uWycY8I
        p34S3bqatApfjKJTD6B4eqk7llOn5/Xibjn/59rFvUNYJpcXcORsPCo/1q8lBzu49gqfjB
        5PDLZaTyULgvju+D0MFe6J6rsx8c/hdQbcyDzjbI6MDJnr3FbvWFMIIF/X0/Gt/wgODH29
        AMiYWHdlvJEungau2LBFg6UBFDagsmxX5TqNHt+ZoboL6wu8V4cakUrMw9jhJCfkqgkEj3
        F40YikYplgk68+/3que0WX9V4L4kVAXHsY7Sm/jyaWEFZ3bd0BYwBi10ZNkv5yNA==
Received: by filterdrecv-84b96456cb-hrvlt with SMTP id filterdrecv-84b96456cb-hrvlt-1-64937AAC-29
        2023-06-21 22:33:16.784398642 +0000 UTC m=+3624881.780498603
Received: from bionic.localdomain (unknown)
        by geopod-ismtpd-0 (SG)
        with ESMTP
        id q2JBcGBES7ak8zO87bOzoQ
        Wed, 21 Jun 2023 22:33:16.341 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/5] drm/rockchip: vop: Fix reset of state in duplicate
 state crtc funcs
Date:   Wed, 21 Jun 2023 22:33:17 +0000 (UTC)
Message-ID: <20230621223311.2239547-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621223311.2239547-1-jonas@kwiboo.se>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4IxyhjudaBMscryW?=
 =?us-ascii?Q?yil2MxaaDxax+ugZQXodSqRHYB6mo1lanwr1jqt?=
 =?us-ascii?Q?Ei9avORGicVCxu+gicqUMciYzh1qKi3mMrSCg1d?=
 =?us-ascii?Q?PUSBMXm9wLuXzM76H6Sr+4cVwqlUT3w933cPfI=2F?=
 =?us-ascii?Q?Va59vtrjACEYW2+1Zc1Kd3y6fVmW+iocbJHw78?=
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <markyao0591@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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

struct rockchip_crtc_state members such as output_type, output_bpc and
enable_afbc is always reset to zero in the atomic_duplicate_state crtc
funcs.

Fix this by using kmemdup on the subclass rockchip_crtc_state struct.

Fixes: 4e257d9eee23 ("drm/rockchip: get rid of rockchip_drm_crtc_mode_config")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v2:
- Collect r-b tag

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a530ecc4d207..60b23636a3fe 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1614,7 +1614,8 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 	if (WARN_ON(!crtc->state))
 		return NULL;
 
-	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	rockchip_state = kmemdup(to_rockchip_crtc_state(crtc->state),
+				 sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
 
-- 
2.41.0

