Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700970F799
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjEXN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjEXN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:29:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227AB0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:29:32 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q1oYU-0007Bo-HD; Wed, 24 May 2023 15:29:30 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed, 24 May 2023 15:29:24 +0200
Subject: [PATCH 1/2] media: video-mux: fix error paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230524-video-mux-active-state-v1-1-325c69937ac3@pengutronix.de>
References: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
In-Reply-To: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.12-dev-aab37
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move notifier cleanup into video_mux_async_register() to avoid calling
v4l2_async_nf_unregister() when v4l2_async_subdev_nf_register() failed.
In case video_mux_async_register() fails, call media_entity_cleanup().

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/video-mux.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 1d9f32e5a917..4fe31386afc7 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -389,7 +389,7 @@ static int video_mux_async_register(struct video_mux *vmux,
 			ret = PTR_ERR(asd);
 			/* OK if asd already exists */
 			if (ret != -EEXIST)
-				return ret;
+				goto err_nf_cleanup;
 		}
 	}
 
@@ -397,9 +397,19 @@ static int video_mux_async_register(struct video_mux *vmux,
 
 	ret = v4l2_async_subdev_nf_register(&vmux->subdev, &vmux->notifier);
 	if (ret)
-		return ret;
+		goto err_nf_cleanup;
 
-	return v4l2_async_register_subdev(&vmux->subdev);
+	ret = v4l2_async_register_subdev(&vmux->subdev);
+	if (ret)
+		goto err_nf_unregister;
+
+	return 0;
+
+err_nf_unregister:
+	v4l2_async_nf_unregister(&vmux->notifier);
+err_nf_cleanup:
+	v4l2_async_nf_cleanup(&vmux->notifier);
+	return ret;
 }
 
 static int video_mux_probe(struct platform_device *pdev)
@@ -473,11 +483,13 @@ static int video_mux_probe(struct platform_device *pdev)
 	vmux->subdev.entity.ops = &video_mux_ops;
 
 	ret = video_mux_async_register(vmux, num_pads - 1);
-	if (ret) {
-		v4l2_async_nf_unregister(&vmux->notifier);
-		v4l2_async_nf_cleanup(&vmux->notifier);
-	}
+	if (ret)
+		goto err_entity_cleanup;
 
+	return 0;
+
+err_entity_cleanup:
+	media_entity_cleanup(&vmux->subdev.entity);
 	return ret;
 }
 

-- 
2.39.2
