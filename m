Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B23729B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbjFINQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbjFINQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:16:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6230D7;
        Fri,  9 Jun 2023 06:16:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977ed383b8aso302100466b.3;
        Fri, 09 Jun 2023 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686316562; x=1688908562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipLrYMo3Fw+iABj9PBlb7h+fexYTzScm11NgqaEicAA=;
        b=PerLxWhFXFBlk75xOFhUmQdoaKM56g8lPJoDXLQpMxKljCIGH3eL0/8JHFSzLe6ipZ
         jeH181fo8jr+hK244uOvvjWzKtlnj9fN/uW9x3lQhSbwGsax6wP6wkZr1hTg+t/WYeIc
         y5u9kkpJOT4Ku5O1ge5m9cDYu426Hhsa2k+qY+6e9o1kryOkjPL0ULDpsqAb0GOAvzwR
         IjK2csmNQ1PXEfhffJPsYBawGegkye/lcdMPIqJdNOxpwg50RiBs4mfg3+7tpz8KyoY0
         ejGp09em6oQjqjWS7DqxV8DcvimFOdCvWc1b61DZWTbpBb4H239Xp5ia9mfiSoRVuxXJ
         KtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316562; x=1688908562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipLrYMo3Fw+iABj9PBlb7h+fexYTzScm11NgqaEicAA=;
        b=g4y05LGf72kJbP3zmcduXdTjJGG0MxMoWvI0DNKV8zJfTm7PpxhMhD/mpNrlnn7KAA
         pWlxfaHF5sZcL4UwQnSyvYxGNwDj57NOLL2sn0CnuFgtn8Mfg4A0zKZ5XnI7KchenAhH
         KOldCyjgkw7fg52o9Y2/UmJuWSPhd0MdJ7J7GSbnkiIQb19MC5Bli8Y341HDVKyk1wjF
         sdtGif1fRtKgDgpTVza/JtpZil2jVx4DwePr2l1t2o5iKSMj3/MvE+cgurTK2wDzUfHi
         42MqAiQBwiYqX1dNBFlFuJ5/RTzggtEExcRGJBMNy8QY0GTVlhHcwVGazB+3KxJM1SMX
         ZUGg==
X-Gm-Message-State: AC+VfDznYOUV72e39rXo1OkysSDxRUBlNsvCc7rfY52m5Xyqm04dGvlt
        0sBh8zEYKMMHhNNwbc9Y0br8PN0U4SwE/A==
X-Google-Smtp-Source: ACHHUZ5LWm053Z7isGKQA9AJAfTj7Tl/xRQoSZGmNv31iyFXAHX7W86g24WZInkWTSr6kgboj5pPzg==
X-Received: by 2002:a17:906:7952:b0:966:1984:9d21 with SMTP id l18-20020a170906795200b0096619849d21mr2313512ejo.9.1686316562312;
        Fri, 09 Jun 2023 06:16:02 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id jt5-20020a170906dfc500b0097462d8dc04sm1284596ejc.100.2023.06.09.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:16:02 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Fri, 09 Jun 2023 15:15:55 +0200
Subject: [PATCH 1/2] media: uapi: Add V4L2_CID_VTOTAL control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-v4l2-vtotal-v1-1-4b7dee7e073e@skidata.com>
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

Currently, V4L2_CID_VBLANK can be used to control the frame duration of
a stream. However, camera sensors usually have a register for the
vertical total size (image data + blanking), e.g. VMAX on the imx290.
The dependency between format height and vertical blanking results to a
change of the vertical blanking value and limits whenever the format of
the frame is changed and therefore makes it harder for user space to do
calculations, e.g. the frame duration.

V4L2_CID_VTOTAL does not depend on the format and therefore simplifies
calculations. Additionally, it represents the hardware "better" and
therefore also simplifies calculations on the driver side.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst | 6 ++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                        | 1 +
 include/uapi/linux/v4l2-controls.h                               | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
index 71f23f131f97..e72d1363ad85 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
@@ -59,6 +59,12 @@ Image Source Control IDs
     non-sensitive.
     This control is required for automatic calibration of sensors/cameras.
 
+``V4L2_CID_VTOTAL (integer)``
+    Number of total lines per frame, including data and idle lines (blanking).
+    The unit of the vertical total size is a line. Every line has length of the
+    image width plus horizontal blanking at the pixel rate defined by
+    ``V4L2_CID_PIXEL_RATE`` control in the same sub-device.
+
 .. c:type:: v4l2_area
 
 .. flat-table:: struct v4l2_area
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 564fedee2c88..6a0d310d5f42 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1112,6 +1112,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_TEST_PATTERN_BLUE:	return "Blue Pixel Value";
 	case V4L2_CID_TEST_PATTERN_GREENB:	return "Green (Blue) Pixel Value";
 	case V4L2_CID_NOTIFY_GAINS:		return "Notify Gains";
+	case V4L2_CID_VTOTAL:			return "Vertical Total Size";
 
 	/* Image processing controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..99120005634e 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1117,6 +1117,7 @@ enum v4l2_jpeg_chroma_subsampling {
 #define V4L2_CID_TEST_PATTERN_GREENB		(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 7)
 #define V4L2_CID_UNIT_CELL_SIZE			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 8)
 #define V4L2_CID_NOTIFY_GAINS			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 9)
+#define V4L2_CID_VTOTAL				(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 10)
 
 
 /* Image processing controls */

-- 
2.34.1

