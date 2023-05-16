Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012497058D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEPU2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPU2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C21720;
        Tue, 16 May 2023 13:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 012F46323D;
        Tue, 16 May 2023 20:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0F1C433D2;
        Tue, 16 May 2023 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268899;
        bh=NY3pXFEnN0WJe0yBQU+o0uO1sA0r+4fxb6XsPtlNtYk=;
        h=From:To:Cc:Subject:Date:From;
        b=Qm+bILKu/42MWX6Rgro5G2hcqvVaVeIw9nyiFm9tO1KaDXBbDvnjOaN/CO4KPIbt4
         L01u/BgdYMuqo3Ksqyk2uQ2nhDfubznD78gf+NgZCPhgMbexgXVOYXg68tBy8vNEUG
         hnow4jUmrdvJ+htOJbOh2GfReHHT3vx8qVCvX08MM5A4uYzTM77f4hnU1iOXWbsGiI
         Rkexv8XuPs7SHi/Q5aMUi++XCrs9HE9KStM5F18mQLyGchjtix6Nvk9vrzYNNhnubZ
         VQCI9ZyDRrj2ulzjpIqBhsxM6CRxfFeJD93WVHwqVRlOm0GZYX96QBQ9Zf7WGTNVgP
         DuWKOWrX9Rn2g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: i810: include i810_main.h in i810_dvt.c
Date:   Tue, 16 May 2023 22:28:09 +0200
Message-Id: <20230516202814.561262-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows that a header needs to be included to
make the prototypes visible:

drivers/video/fbdev/i810/i810_dvt.c:194:6: error: no previous prototype for 'round_off_xres' [-Werror=missing-prototypes]
drivers/video/fbdev/i810/i810_dvt.c:233:6: error: no previous prototype for 'i810fb_encode_registers' [-Werror=missing-prototypes]
drivers/video/fbdev/i810/i810_dvt.c:245:6: error: no previous prototype for 'i810fb_fill_var_timings' [-Werror=missing-prototypes]
drivers/video/fbdev/i810/i810_dvt.c:279:5: error: no previous prototype for 'i810_get_watermark' [-Werror=missing-prototypes]

Adding the header leads to another warning from a mismatched
prototype, so fix this as well:

drivers/video/fbdev/i810/i810_dvt.c:280:5: error: conflicting types for 'i810_get_watermark'; have 'u32(struct fb_var_screeninfo *,

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/i810/i810_dvt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_dvt.c b/drivers/video/fbdev/i810/i810_dvt.c
index b4b3670667ab..2082b5c92e8f 100644
--- a/drivers/video/fbdev/i810/i810_dvt.c
+++ b/drivers/video/fbdev/i810/i810_dvt.c
@@ -14,6 +14,7 @@
 
 #include "i810_regs.h"
 #include "i810.h"
+#include "i810_main.h"
 
 struct mode_registers std_modes[] = {
 	/* 640x480 @ 60Hz */
@@ -276,7 +277,7 @@ void i810fb_fill_var_timings(struct fb_var_screeninfo *var)
 	var->upper_margin = total - (yres + var->lower_margin + var->vsync_len);
 }
 
-u32 i810_get_watermark(struct fb_var_screeninfo *var,
+u32 i810_get_watermark(const struct fb_var_screeninfo *var,
 		       struct i810fb_par *par)
 {
 	struct mode_registers *params = &par->regs;
-- 
2.39.2

