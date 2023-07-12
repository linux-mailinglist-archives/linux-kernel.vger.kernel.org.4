Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350D275030F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGLJ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjGLJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:28:18 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 02:28:15 PDT
Received: from mail.aspeedtech.com (211-20-114-226.hinet-ip.hinet.net [211.20.114.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B590FB;
        Wed, 12 Jul 2023 02:28:15 -0700 (PDT)
Received: from JammyHuang-PC.aspeed.com (192.168.2.181) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jul
 2023 17:26:09 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: aspeed: Fix memory overwrite if timing is 1600x900
Date:   Wed, 12 Jul 2023 17:26:06 +0800
Message-ID: <20230712092606.2508-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.181]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When capturing 1600x900, system could crash when system memory usage is
tight.

The size of macro block captured is 8x8. Therefore, we should make sure
the height of src-buf is 8 aligned to fix this issue.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 374eb7781936..14594f55a77f 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1130,7 +1130,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 static void aspeed_video_set_resolution(struct aspeed_video *video)
 {
 	struct v4l2_bt_timings *act = &video->active_timings;
-	unsigned int size = act->width * act->height;
+	unsigned int size = act->width * ALIGN(act->height, 8);
 
 	/* Set capture/compression frame sizes */
 	aspeed_video_calc_compressed_size(video, size);
@@ -1147,7 +1147,7 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 		u32 width = ALIGN(act->width, 64);
 
 		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
-		size = width * act->height;
+		size = width * ALIGN(act->height, 8);
 	} else {
 		aspeed_video_write(video, VE_CAP_WINDOW,
 				   act->width << 16 | act->height);

base-commit: 2605e80d3438c77190f55b821c6575048c68268e
-- 
2.25.1

