Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48F2729B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbjFINQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbjFINQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:16:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F291430F8;
        Fri,  9 Jun 2023 06:16:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977c8423dccso611441166b.1;
        Fri, 09 Jun 2023 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686316563; x=1688908563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEEz1N4+BSweLodIciDOwkHhZXsydRRIWfH217+phOg=;
        b=Y+8yjStobpiT5Z2jSvMwjadpOICkBkMexu7MysxWHVLq7J6UGXnApW2d32ftjctUNf
         0WTZGS0rMVMM1dVeZjwaXvUyufn6JTjlgnyr9SomalsqUYHqg1ynsPT5i+NSAWXD9ucr
         j7DWpbZS9UikuTU9h8VxVkvw8Q5/8TYUWo6tKa+bx9k81VFBIQFart2HGRWeLs+yec0S
         DRPQytQy38Y8ooRvGaSrb+c/6teYhg8jQO7JcjtHNG/0qQmvxVnGTY7hvgBgZj0jEKwE
         uxPQ6Pe1/DNfNjcaYOOgrRr8rPx6royHNwisLfVg6w/NuhXby6wInjTz0VD4g1gOQAns
         RW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316563; x=1688908563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEEz1N4+BSweLodIciDOwkHhZXsydRRIWfH217+phOg=;
        b=Cy44fltPxLjtRGjbIqdEAEMUALGcZKv190rRHYlzWBdUexnox8MmBfrIfrM7mraWYs
         bHarU8EMUJs+gw5QtxrvUcZ18YlrGu9679/5ER9ef4LjA6aLNzqs85t4ksQjizOI1wDV
         zrviLsm8n0LJXw3UP9bzx5l8LAwKESekIut2+VcdyU6hHCBMB8fYioOj4ztCVc0MiPvm
         LCyLMn2v7TOt3FtIMzVeKz3WuaJc0VY7pJ4U0ZeAEbQL3Rw09IL2/1SDExsQlL8KXp6r
         jXzf/HfjjU8LNUIQBxkdYazhd2RNYDLTagQLl2UdgueS+wKhBXO0I2hqGUPzPLwnsW13
         sfew==
X-Gm-Message-State: AC+VfDzLu5JaifCpu69YWwuNe+WLCXtlwm+NZlRjhQWQ6ShnnUqpiwg/
        cEHHdEGouCQxrQ9KG9wmpyWh4knjGDnO0g==
X-Google-Smtp-Source: ACHHUZ7k/Qsh54hS3q0RQjAIJgFiZ9mXtHnCXoV+FfRu/o5RoXFmaN0fdbkr50umbH0fbdati/LyZA==
X-Received: by 2002:a17:907:a414:b0:969:2df9:a0dd with SMTP id sg20-20020a170907a41400b009692df9a0ddmr1762387ejc.25.1686316563193;
        Fri, 09 Jun 2023 06:16:03 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id jt5-20020a170906dfc500b0097462d8dc04sm1284596ejc.100.2023.06.09.06.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:16:03 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 09 Jun 2023 15:15:56 +0200
Subject: [PATCH 2/2] media: i2c: imx290: Add support for V4L2_CID_VTOTAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-v4l2-vtotal-v1-2-4b7dee7e073e@skidata.com>
References: <20230609-v4l2-vtotal-v1-0-4b7dee7e073e@skidata.com>
In-Reply-To: <20230609-v4l2-vtotal-v1-0-4b7dee7e073e@skidata.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The new V4L2_CID_VTOTAL control represents the VMAX register.
Implementing it simplifies calculations in user space, as it is
independent of the current mode (format height), meaning its value does
not change with format changes.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/media/i2c/imx290.c | 47 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 5ea25b7acc55..42938400efb0 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -255,6 +255,7 @@ struct imx290 {
 	struct v4l2_ctrl *link_freq;
 	struct v4l2_ctrl *hblank;
 	struct v4l2_ctrl *vblank;
+	struct v4l2_ctrl *vtotal;
 	struct v4l2_ctrl *exposure;
 	struct {
 		struct v4l2_ctrl *hflip;
@@ -782,8 +783,7 @@ static void imx290_exposure_update(struct imx290 *imx290,
 {
 	unsigned int exposure_max;
 
-	exposure_max = imx290->vblank->val + mode->height -
-		       IMX290_EXPOSURE_OFFSET;
+	exposure_max = imx290->vtotal->val - IMX290_EXPOSURE_OFFSET;
 	__v4l2_ctrl_modify_range(imx290->exposure, 1, exposure_max, 1,
 				 exposure_max);
 }
@@ -794,7 +794,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 					     struct imx290, ctrls);
 	const struct v4l2_mbus_framefmt *format;
 	struct v4l2_subdev_state *state;
-	int ret = 0, vmax;
+	int ret = 0;
 
 	/*
 	 * Return immediately for controls that don't need to be applied to the
@@ -803,10 +803,22 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 	if (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY)
 		return 0;
 
-	if (ctrl->id == V4L2_CID_VBLANK) {
-		/* Changing vblank changes the allowed range for exposure. */
+	/* Changing vtotal changes the allowed range for exposure. */
+	if (ctrl->id == V4L2_CID_VTOTAL)
 		imx290_exposure_update(imx290, imx290->current_mode);
-	}
+
+	/*
+	 * vblank and vtotal depend on each other, therefore also update the
+	 * other one.
+	 */
+	if (ctrl->id == V4L2_CID_VBLANK &&
+	    imx290->vtotal->val != ctrl->val + imx290->current_mode->height)
+		__v4l2_ctrl_s_ctrl(imx290->vtotal,
+				   ctrl->val + imx290->current_mode->height);
+	if (ctrl->id == V4L2_CID_VTOTAL &&
+	    imx290->vblank->val != ctrl->val - imx290->current_mode->height)
+		__v4l2_ctrl_s_ctrl(imx290->vblank,
+				   ctrl->val - imx290->current_mode->height);
 
 	/* V4L2 controls values will be applied only when power is already up */
 	if (!pm_runtime_get_if_in_use(imx290->dev))
@@ -821,9 +833,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_VBLANK:
-		ret = imx290_write(imx290, IMX290_VMAX,
-				   ctrl->val + imx290->current_mode->height,
-				   NULL);
+		/* vblank is updated by vtotal. */
+		break;
+
+	case V4L2_CID_VTOTAL:
+		ret = imx290_write(imx290, IMX290_VMAX, ctrl->val, NULL);
+		if (ret)
+			goto err;
+
 		/*
 		 * Due to the way that exposure is programmed in this sensor in
 		 * relation to VMAX, we have to reprogramme it whenever VMAX is
@@ -834,9 +851,8 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 		ctrl = imx290->exposure;
 		fallthrough;
 	case V4L2_CID_EXPOSURE:
-		vmax = imx290->vblank->val + imx290->current_mode->height;
 		ret = imx290_write(imx290, IMX290_SHS1,
-				   vmax - ctrl->val - 1, NULL);
+				   imx290->vtotal->val - ctrl->val - 1, NULL);
 		break;
 
 	case V4L2_CID_TEST_PATTERN:
@@ -880,6 +896,7 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+err:
 	pm_runtime_mark_last_busy(imx290->dev);
 	pm_runtime_put_autosuspend(imx290->dev);
 
@@ -911,11 +928,14 @@ static void imx290_ctrl_update(struct imx290 *imx290,
 	unsigned int vblank_max = IMX290_VMAX_MAX - mode->height;
 
 	__v4l2_ctrl_s_ctrl(imx290->link_freq, mode->link_freq_index);
+	__v4l2_ctrl_s_ctrl(imx290->vblank, imx290->vtotal->val - mode->height);
 
 	__v4l2_ctrl_modify_range(imx290->hblank, hblank_min, hblank_max, 1,
 				 hblank_min);
 	__v4l2_ctrl_modify_range(imx290->vblank, vblank_min, vblank_max, 1,
 				 vblank_min);
+	__v4l2_ctrl_modify_range(imx290->vtotal, mode->vmax_min,
+				 IMX290_VMAX_MAX, 1, mode->vmax_min);
 }
 
 static int imx290_ctrl_init(struct imx290 *imx290)
@@ -947,7 +967,7 @@ static int imx290_ctrl_init(struct imx290 *imx290)
 
 	/*
 	 * Correct range will be determined through imx290_ctrl_update setting
-	 * V4L2_CID_VBLANK.
+	 * V4L2_CID_VTOTAL.
 	 */
 	imx290->exposure = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
 					     V4L2_CID_EXPOSURE, 1, 65535, 1,
@@ -983,6 +1003,9 @@ static int imx290_ctrl_init(struct imx290 *imx290)
 
 	imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
 					   V4L2_CID_VBLANK, 1, 1, 1, 1);
+	imx290->vtotal = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
+					   V4L2_CID_VTOTAL, 1, IMX290_VMAX_MAX,
+					   1, 1);
 
 	imx290->hflip = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
 					  V4L2_CID_HFLIP, 0, 1, 1, 0);

-- 
2.34.1

