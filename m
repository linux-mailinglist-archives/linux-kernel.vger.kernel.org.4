Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1A714554
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjE2HTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjE2HTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:19:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8DA6
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:19:09 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3X9eqYgEzMDzt3X9oq4QNQ; Mon, 29 May 2023 09:19:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685344748;
        bh=E29VI58F9t8lbiMbudotJ9ysUUBZknzo+5bxInVW578=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qN2RdXC/1SfqjAN9PDebvToRpP+JJUk8Q6FA4M43mFXtgHgv0S+f9x8BrEfyJZ44v
         mtS4PdX+9TjiYH+BNk64ndNK/Ckh2i5e6HYPe7JvC5eyR7vhJiDCWSCrkLW6IRGsti
         4SbpZPIOkkBBr7xntU7liZnyPVJiF7mWgIksIwA3ms5JM7fsRK4Z5j0IJuIuFPi4rB
         rfVPxOjaTrYe/94URzYk1vwNsONPBvEQ7qOSB8Ik7Tz2YlnOHjqwVnq437SS7RmZeL
         xBlZ05K7U4aOtAjKzaQnJdRGcfQaCyE1b6xVOIiTFfCpG6wSLH9XXT4nbw/XPv1Y+L
         PT7MiJgsJiDfQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 09:19:08 +0200
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
Subject: [PATCH 2/3] drm/amd/display: Simplify get_dmif_switch_time_us()
Date:   Mon, 29 May 2023 09:18:55 +0200
Message-Id: <1ab1210048a4b485247cccba6721f1885c986331.1685342739.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e0a2240f863279b65a1fdc7f8c27ede9f8e37893.1685342739.git.christophe.jaillet@wanadoo.fr>
References: <e0a2240f863279b65a1fdc7f8c27ede9f8e37893.1685342739.git.christophe.jaillet@wanadoo.fr>
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

Thanks to the sanity check a few lines above:
    if (!h_total || !v_total || !pix_clk_khz)

and the computation done afterwards on these non 0 values, we know that
'pixels_per_second', 'pixels_per_frame' and 'refresh_rate' are not 0

The code can be simplified accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
NOT compile tested. Because of some BROKEN in KConfig files.
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 091f0d68a045..eafe8561e55e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -690,21 +690,8 @@ static uint32_t get_dmif_switch_time_us(
 	pixels_per_second = pix_clk_khz * 1000;
 	pixels_per_frame = h_total * v_total;
 
-	if (!pixels_per_second || !pixels_per_frame) {
-		/* avoid division by zero */
-		ASSERT(pixels_per_frame);
-		ASSERT(pixels_per_second);
-		return single_frame_time_multiplier * min_single_frame_time_us;
-	}
-
 	refresh_rate = pixels_per_second / pixels_per_frame;
 
-	if (!refresh_rate) {
-		/* avoid division by zero*/
-		ASSERT(refresh_rate);
-		return single_frame_time_multiplier * min_single_frame_time_us;
-	}
-
 	frame_time = us_in_sec / refresh_rate;
 
 	if (frame_time < min_single_frame_time_us)
-- 
2.34.1

