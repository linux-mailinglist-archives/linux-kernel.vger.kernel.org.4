Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAD6184A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiKCQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiKCQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:31:48 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C71C11E;
        Thu,  3 Nov 2022 09:31:45 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6931F24000C;
        Thu,  3 Nov 2022 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667493104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jF7cLa476FZmSVcSFQS9+IIBGhLvzC2+YaJiw4ZfLas=;
        b=DNGK3HBZvUCcF4kIZPRHdNBhLzu2B6tAQeBZefF5499qz6lj9G/7eu0tGIp/Ni0YGbmJOW
        3DO60M76luHTn4/+WWY/XnQgs7bSRSZFuC5u3TO5nTgje6cJ9p3zWIIMWOsu+1/Ta8lPNv
        gtDMZhiy5Vzh8nNWWRoRhrPWcvzYDs/tRTZLgALGy1C9tRp2Mfsgu4b6VowZyUnVOnznjg
        7ZPZXIW9STyBqBzU4u1JaUIzs4oH6SEEKlrVS3rLHZge/WD4vecJ8TMYacMwbzfJuFemUo
        LKZcoP/wBFHtoHFE9XlDvTSDLkrZXjQ4kct4eQD78NwItCoT4eyM/yTt5xKvlw==
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
Subject: [PATCH v7 08/28] media: sun6i-csi: Move power management to runtime pm in capture
Date:   Thu,  3 Nov 2022 17:30:53 +0100
Message-Id: <20221103163113.245462-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
References: <20221103163113.245462-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's just enable the module when we start using it (at stream on)
and benefit from runtime pm instead of enabling it at first open.

Also reorder the call to v4l2_pipeline_pm_get.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 24 -----------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  9 ----
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 41 ++++++++++---------
 3 files changed, 22 insertions(+), 52 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index d5318e2b04df..9a12077ea03a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -148,30 +148,6 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 	return false;
 }
 
-int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
-{
-	struct device *dev = csi_dev->dev;
-	struct regmap *regmap = csi_dev->regmap;
-	int ret;
-
-	if (!enable) {
-		regmap_update_bits(regmap, SUN6I_CSI_EN_REG,
-				   SUN6I_CSI_EN_CSI_EN, 0);
-		pm_runtime_put(dev);
-
-		return 0;
-	}
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		return ret;
-
-	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
-			   SUN6I_CSI_EN_CSI_EN);
-
-	return 0;
-}
-
 static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
 					       u32 mbus_code, u32 pixformat)
 {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 6fe40a56d6df..83180475e55b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -77,15 +77,6 @@ struct sun6i_csi_variant {
 bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code);
 
-/**
- * sun6i_csi_set_power() - power on/off the csi
- * @csi_dev:	pointer to the csi device
- * @enable:	on/off
- *
- * Return: 0 if successful, error code otherwise.
- */
-int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable);
-
 /**
  * sun6i_csi_update_config() - update the csi register settings
  * @csi_dev:	pointer to the csi device
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index e611f8c94d9d..4c8b18a256e8 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <media/v4l2-device.h>
@@ -141,6 +142,9 @@ static void sun6i_csi_capture_enable(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
 
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
+			   SUN6I_CSI_EN_CSI_EN);
+
 	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
 			   SUN6I_CSI_CAP_VCAP_ON);
 }
@@ -150,6 +154,7 @@ static void sun6i_csi_capture_disable(struct sun6i_csi_device *csi_dev)
 	struct regmap *regmap = csi_dev->regmap;
 
 	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON, 0);
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN, 0);
 }
 
 static void
@@ -382,6 +387,7 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct sun6i_csi_capture_state *state = &capture->state;
 	struct video_device *video_dev = &capture->video_dev;
+	struct device *dev = csi_dev->dev;
 	struct v4l2_subdev *subdev;
 	int ret;
 
@@ -402,6 +408,12 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 		goto error_media_pipeline;
 	}
 
+	/* PM */
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto error_media_pipeline;
+
 	/* Clear */
 
 	sun6i_csi_capture_irq_clear(csi_dev);
@@ -429,6 +441,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	sun6i_csi_capture_disable(csi_dev);
 	sun6i_csi_capture_irq_disable(csi_dev);
 
+	pm_runtime_put(dev);
+
 error_media_pipeline:
 	video_device_pipeline_stop(video_dev);
 
@@ -442,6 +456,7 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct device *dev = csi_dev->dev;
 	struct v4l2_subdev *subdev;
 
 	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
@@ -451,6 +466,8 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 	sun6i_csi_capture_disable(csi_dev);
 	sun6i_csi_capture_irq_disable(csi_dev);
 
+	pm_runtime_put(dev);
+
 	video_device_pipeline_stop(&capture->video_dev);
 
 	sun6i_csi_capture_state_cleanup(csi_dev, true);
@@ -635,27 +652,20 @@ static int sun6i_csi_capture_open(struct file *file)
 	if (mutex_lock_interruptible(&capture->lock))
 		return -ERESTARTSYS;
 
-	ret = v4l2_fh_open(file);
+	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
 	if (ret < 0)
 		goto error_lock;
 
-	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
+	ret = v4l2_fh_open(file);
 	if (ret < 0)
-		goto error_v4l2_fh;
-
-	/* Power on at first open. */
-	if (v4l2_fh_is_singular_file(file)) {
-		ret = sun6i_csi_set_power(csi_dev, true);
-		if (ret < 0)
-			goto error_v4l2_fh;
-	}
+		goto error_pipeline;
 
 	mutex_unlock(&capture->lock);
 
 	return 0;
 
-error_v4l2_fh:
-	v4l2_fh_release(file);
+error_pipeline:
+	v4l2_pipeline_pm_put(&capture->video_dev.entity);
 
 error_lock:
 	mutex_unlock(&capture->lock);
@@ -667,19 +677,12 @@ static int sun6i_csi_capture_close(struct file *file)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	bool last_close;
 
 	mutex_lock(&capture->lock);
 
-	last_close = v4l2_fh_is_singular_file(file);
-
 	_vb2_fop_release(file, NULL);
 	v4l2_pipeline_pm_put(&capture->video_dev.entity);
 
-	/* Power off at last close. */
-	if (last_close)
-		sun6i_csi_set_power(csi_dev, false);
-
 	mutex_unlock(&capture->lock);
 
 	return 0;
-- 
2.38.1

