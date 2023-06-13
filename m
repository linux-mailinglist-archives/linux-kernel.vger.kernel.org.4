Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8D72DC09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjFMIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjFMIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:07:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3910CE;
        Tue, 13 Jun 2023 01:07:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so3834494f8f.1;
        Tue, 13 Jun 2023 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686643664; x=1689235664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVCvnuikxuMkayvXMhnhJV1W770twmco4K8oIyl6qVk=;
        b=ITi8kRp3sMI/PkbbTaZ89AQ3XwCLefwMYZr709m/UEKHYyqhIRR+6qCSdbsfHwGZMA
         4pafBFCU5yMtOKM+SlmLu0OASrI+VO/29p00PEh3eA3xGPdJ2M5vsR4wZbV18YnoEte9
         z0+8G3cabGgg3W20nVXdEZn43CIiFXhTJ2OZ7j+proaC3CSudp8dSfA/0/PuNVss1LIr
         jxY5cOA2qAAE2IXLf8MKRUt0/xZHhoyFXCcxCEj2ARrDQjQiM1T+4YB0gEmPmR+JjkgK
         jx3Qu9AHcngfJ/sGQIPVd/dttyxyFZ+V/UKUZuoKAZrQzl0d/fjwX4uPvMvumljrGvD7
         j5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686643664; x=1689235664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVCvnuikxuMkayvXMhnhJV1W770twmco4K8oIyl6qVk=;
        b=eYTkHYOI9bJaCvODOKA81oqJ9qYngrGDqZGxi/iAGE1bL4PdpCf64DGvK875Keqqv9
         cdnSgL7lNlZJYz6lNV8TT5By/mtL6645+5Jy7PE9rypqFZN17EEk9/Og4cSu2oP3jYCb
         qMi0SfQEBwaJDrrIjaXMAJtBkNASI1aN45PrcVy2vJYWbWHQ5JB1P838fxfbe8L3/uyt
         hr2PumBAs2JFSr25dTV5tW7LMQV+VTZbPd2iHVbnr6cSr9jMGUUWgTnqaEt9W+iQK1bq
         vVIFRnNJsaggg372xROc5KkLpgO254Ce8Gt35AwM/nBp0Pb5iUPMFjjhXt1L+QWSW9fc
         e68w==
X-Gm-Message-State: AC+VfDyweZezmPqRrRSLq3zyzcrFpvL3uqJfLrOaTXBpnQJGTxCDDqom
        XLz+It259ozPeuMalLfpMZdyAuF1yRs=
X-Google-Smtp-Source: ACHHUZ6K2SbKLlM0iN07nmJITtTy2TyPN4FsjiCyN58Ad66eU5l2fQtW0TJNIp0oPxJ6YuV5QBfCAQ==
X-Received: by 2002:a5d:60c5:0:b0:307:7959:6461 with SMTP id x5-20020a5d60c5000000b0030779596461mr7170270wrt.31.1686643664224;
        Tue, 13 Jun 2023 01:07:44 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.. (mob-5-90-5-141.net.vodafone.it. [5.90.5.141])
        by smtp.gmail.com with ESMTPSA id t18-20020adfeb92000000b003093a412310sm14559754wrn.92.2023.06.13.01.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:07:43 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: imx290: drop format param from imx290_ctrl_update
Date:   Tue, 13 Jun 2023 10:07:34 +0200
Message-Id: <20230613080734.8151-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format param actually is not used in imx290_ctrl_update
function, let's drop this

Fixes: bc35f9a21a55 ("media: i2c: imx290: Fix the pixel rate at 148.5Mpix/s")
Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
Changes since v1:
 - Collected tag from DStevenson
 - Added Fixes as suggested by from DStevenson

 drivers/media/i2c/imx290.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 5ea25b7acc55..a84b581682a2 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -902,7 +902,6 @@ static const char * const imx290_test_pattern_menu[] = {
 };
 
 static void imx290_ctrl_update(struct imx290 *imx290,
-			       const struct v4l2_mbus_framefmt *format,
 			       const struct imx290_mode *mode)
 {
 	unsigned int hblank_min = mode->hmax_min - mode->width;
@@ -1195,7 +1194,7 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		imx290->current_mode = mode;
 
-		imx290_ctrl_update(imx290, &fmt->format, mode);
+		imx290_ctrl_update(imx290, mode);
 		imx290_exposure_update(imx290, mode);
 	}
 
@@ -1300,7 +1299,6 @@ static const struct media_entity_operations imx290_subdev_entity_ops = {
 static int imx290_subdev_init(struct imx290 *imx290)
 {
 	struct i2c_client *client = to_i2c_client(imx290->dev);
-	const struct v4l2_mbus_framefmt *format;
 	struct v4l2_subdev_state *state;
 	int ret;
 
@@ -1335,8 +1333,7 @@ static int imx290_subdev_init(struct imx290 *imx290)
 	}
 
 	state = v4l2_subdev_lock_and_get_active_state(&imx290->sd);
-	format = v4l2_subdev_get_pad_format(&imx290->sd, state, 0);
-	imx290_ctrl_update(imx290, format, imx290->current_mode);
+	imx290_ctrl_update(imx290, imx290->current_mode);
 	v4l2_subdev_unlock_state(state);
 
 	return 0;
-- 
2.34.1

