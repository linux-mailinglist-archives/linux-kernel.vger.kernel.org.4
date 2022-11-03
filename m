Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF96184BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiKCQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiKCQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:32:19 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D527C65D9;
        Thu,  3 Nov 2022 09:32:13 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0956524000B;
        Thu,  3 Nov 2022 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMFnks6Lu4FCxDlZAZxi2Is0Upoea35FrSEj6lLHdlk=;
        b=mBCUBOB8cc0YfaNz7cYZcOWfJbYdt/5PcIcgL4/HBRoSUkvhMawZl55VJPCJbPn6vETPMQ
        xaCNS3UwpEEgJ+v34IQoeHa4vooY1ZMk9zliOnI/z+Z1r3lYviYrZCl+XtzBWY79k2vGGl
        W9BxWaNAAVb32bmGbOmNza9e1UpC2GXq2Ohp5ZuM9okA9OLoOOyyX2mys6FubnRw26g6dh
        eDLBSX9sgKvGUEXAeItXm/78TAnTo2wvM52K8UQdFkPsSAk3U+Xe2jNxiPZkXjKqlztsWp
        rYULHmi3Ybh7islqMLW2om4TMslQEzwG4xUiLJ/ZG1KL0ySRqDqslfEKeM257w==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 22/28] media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
Date:   Thu,  3 Nov 2022 17:31:07 +0100
Message-Id: <20221103163113.245462-23-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver is properly split between bridge and capture,
rename the video device to highlight its role and be in line with
the bridge entity naming.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 3 ++-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 96a8e11fd55e..ec62442f778d 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1023,7 +1023,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
 	/* Video Device */
 
-	strscpy(video_dev->name, SUN6I_CSI_NAME, sizeof(video_dev->name));
+	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
+		sizeof(video_dev->name));
 	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
 	video_dev->vfl_dir = VFL_DIR_RX;
 	video_dev->release = video_device_release_empty;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index a61db3bc72e5..59c57bcefeec 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -11,6 +11,8 @@
 #include <media/v4l2-dev.h>
 #include <media/videobuf2-core.h>
 
+#define SUN6I_CSI_CAPTURE_NAME	"sun6i-csi-capture"
+
 #define SUN6I_CSI_CAPTURE_WIDTH_MIN	32
 #define SUN6I_CSI_CAPTURE_WIDTH_MAX	4800
 #define SUN6I_CSI_CAPTURE_HEIGHT_MIN	32
-- 
2.38.1

