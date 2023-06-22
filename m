Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C297397EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFVHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjFVHMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:12:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF71BD5;
        Thu, 22 Jun 2023 00:12:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51bebdc4787so181995a12.2;
        Thu, 22 Jun 2023 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687417960; x=1690009960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEEz1N4+BSweLodIciDOwkHhZXsydRRIWfH217+phOg=;
        b=RMb88+VG5HlFSeBWTVoKI30o0HAB+bw6QQwtqzkurLJMDDjZiSIx07+fxw9SgT1lWt
         eiX2gZsB9vkFUX5/HcojhxveklMw5CxZeFv0csBkiMvZBKWbJUk1KYtu+KKCuE/LRYyG
         IudtXNcS+Zue0W4XW/X6NVq/6SXvsM0D4FrLeqDxGggP9HIDBuKQeDhd9YW6/uR4Cf/a
         cntdGz0n4k3UXDUUiXRTuvlDKaKzxefPp2DheEue/wE179wjRkMcg8ZXJg7R1nBknf4h
         LlVNDlaf/duqbhqU+uH6FwPWVPgxRi4sN7uUfsjxTEDOrxjMNPsivgsP9O/gx+11wtcW
         2mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417960; x=1690009960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEEz1N4+BSweLodIciDOwkHhZXsydRRIWfH217+phOg=;
        b=YOLmfcF2S7ZyRvCTPozwPyxeN2eTCC9mFd0CGXhBpaY8c3+HRNKP9MLXDtVa719u6w
         r143Zlop/wT3xCoI+yb/sX/ATQHXpU7f8I9gI+M3s2l8mcIc0elwVWSKqHqQoq+AbVWw
         zuiP2Kf2UUc6mxl6Gn8jJFv+sd6MYDUYNPWV9bM1tyaOEABVHP+q9eS8QZQ5ACNizNL8
         mWYCMseomdna6wX5bKL+0qfVwdOH5ZeozMdpMWsWl+mPGyLmgku9u4xAhaIuyU5uLOJ8
         jtUQhFUJIa5a3aIM0K+BGCqFzX3mH7bYXKCd8gZlf+PFqwLamMO7VEPeXO50C0BZUBbv
         F+5w==
X-Gm-Message-State: AC+VfDzZdMOY6l8PEIzUSeCvj3J8oU4J9CxbYHMnjdwZ0G5U83L/9rpd
        7Q8fPoiWVkPlN7ssnYcu0x3aWVzKIfGcIg==
X-Google-Smtp-Source: ACHHUZ4LXiFyN0aLTZQNzmXiWCPGxKEtQnscCTtPpOAOPM3KBDCNK84whNa8vmKPKLKVOhH84C2eww==
X-Received: by 2002:a17:907:98c:b0:982:8c28:c50d with SMTP id bf12-20020a170907098c00b009828c28c50dmr12957469ejc.58.1687417960570;
        Thu, 22 Jun 2023 00:12:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id bq26-20020a170906d0da00b0096f5b48fe43sm4134923ejb.47.2023.06.22.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:12:40 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 22 Jun 2023 09:12:24 +0200
Subject: [PATCH WIP RFC v2 2/2] media: i2c: imx290: Add support for
 V4L2_CID_VTOTAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-v4l2-vtotal-v2-2-cf29925f4517@skidata.com>
References: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
In-Reply-To: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
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

