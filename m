Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7324714550
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjE2HTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2HTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:19:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99660A4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:19:02 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3X9eqYgEzMDzt3X9eq4QMn; Mon, 29 May 2023 09:19:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685344740;
        bh=ToQuNxvWCS00We22b4WvFzbjWsFm90sAaGVlSiXzZ6A=;
        h=From:To:Cc:Subject:Date;
        b=N0OGot8XgN/sgaRBBPtv8sAmxBbjCRQT9O8f739VgP6/PefDcz4qn4+sQQ4buhqA8
         fAc/X2jePdXNNBWmTWvgbUp9Ryp8kHWEDgJmdzV8ZHE8c1YY413djR6ZWGI8tjM7GY
         fQLYY7JVDeWvBPzsWhh3RHmI0aLvzF0lmu23syr3EuHsiPzq+pwh17fxnJCmfsb7/j
         iuwSEeqSG/cl3+zCv29bZ+NSC0beKhU3a8viZBb92BUsu6ZKRr/ioSKfkXVgzCf4ft
         vipwGXayXPCFv1AUaJfDRHr8JmJ2AbFb3IS6GFQko1QKSbRwVykQrP2aT2+cJnfe+V
         vbfQ3xCVLrLbQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 09:19:00 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/display: Fix an erroneous sanity check in get_dmif_switch_time_us()
Date:   Mon, 29 May 2023 09:18:54 +0200
Message-Id: <e0a2240f863279b65a1fdc7f8c27ede9f8e37893.1685342739.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that there is a typo in the sanity check for 'v_total'.

If it is 0, then 'pixels_per_frame' will also be 0, and in this case,
we also return 'single_frame_time_multiplier * min_single_frame_time_us'.

So test for !v_total which looks much more logical.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 4cdd4dacb761..091f0d68a045 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -683,7 +683,7 @@ static uint32_t get_dmif_switch_time_us(
 	/*return double of frame time*/
 	const uint32_t single_frame_time_multiplier = 2;
 
-	if (!h_total || v_total || !pix_clk_khz)
+	if (!h_total || !v_total || !pix_clk_khz)
 		return single_frame_time_multiplier * min_single_frame_time_us;
 
 	/*TODO: should we use pixel format normalized pixel clock here?*/
-- 
2.34.1

