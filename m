Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28B686C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjBARH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBARHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:07:50 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104676417;
        Wed,  1 Feb 2023 09:07:46 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 53DA8CDFFE;
        Wed,  1 Feb 2023 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675271235; bh=UQT65ChprtN3gV14x3uUiuk8ir1KP67ljLyDOelPHJI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=IVWwbXGlTc3RyXWi1RTKNy877hXfKoupkBBxqYNnJtXhOEmmU2Wv9lPYcynUqAIHr
         V9IGqNIo8+ocrQB6pihtXsqKFr01y4r9hfdkKGeZ5Yhgiujvq0IfSJyD1Z0hi5aN42
         7AtIH5geQj23cTA8EyCuDiXrnL98J1QJukqeo+Oc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 01 Feb 2023 18:07:01 +0100
Subject: [PATCH v2 4/4] media: i2c: ov2685: Add .get_selection() support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v2-4-210400f2b63e@z3ntu.xyz>
References: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v2-0-210400f2b63e@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3378; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UQT65ChprtN3gV14x3uUiuk8ir1KP67ljLyDOelPHJI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj2pxBJ4iicO0LkfxV1yugSDBcmc6zjaWTd1jPdLQG
 0cnQbqyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9qcQQAKCRBy2EO4nU3XVnHBD/
 9XcfG2wVAZuEO3H7+OSzyE00DbeQM54+siYcsvhCjsxdu+0U8APxYKvE6gL1Z79EjZwxNgCt+MUZk+
 4Y/3pe9Ann6jeeuD0Km3chLBHLYBJqjqnz8tfzPBgsIYwKftUsfvc3pNs1kfI1oWc3O6T17iw78+5T
 ly12MIxwfbqJBYYQ0ZKtPy9fahKish8AGAFVoqsQ2T/xTay97kSNiy4djpM+dhTxSffGEZCSSmt/0s
 yXqxW9DxNTY2fyiUfim03bwbvVU1kARXe7KNSyMtYXse6dn68ShJ0O55Pq0AOub6lpNG81r6yTtxmK
 DZvNepkeI75hawCnnyknKlFKC2c4PidmTjA1Hg0KayeElmRwj9hxZmzu1r1pABczWBtp2YL5LWS2BD
 gKDArWv8DPSgz2giEeCWZeoLEB4M9FmEJUiFSjb/bPc9kXSwNT5LRVZqciFYSWvFpy3bTxw21ax2F9
 j3du5sAy8CJtxvsTftX0/1ulj9hJeAE6CwlQ/yEVcesT4LDAyWlaAqE8wHRnRzLnlVtWbbVV93ziQu
 HOdmO0Vk4Bv3wjXjKJEtQST/WdOszKubgnj96dgbl9c+9BsoNMtstGk6kv+o4smMGirYjqjIPgnlTw
 M/4h8T6bp7g7MuGVUjoALH9VgoMd0U+2X/PpybZI/98CuWXfpSlelUpDVPuw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the .get_selection() pad operation to the ov2685 sensor
driver.

Report the native sensor size (pixel array), the crop bounds (readable
pixel array area) and the current and default analog crop rectangles.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index e9e59a3ed7d5..52f66e7813be 100644
--- a/drivers/media/i2c/ov2685.c
+++ b/drivers/media/i2c/ov2685.c
@@ -56,6 +56,9 @@
 #define OV2685_REG_VALUE_16BIT		2
 #define OV2685_REG_VALUE_24BIT		3
 
+#define OV2685_NATIVE_WIDTH		1616
+#define OV2685_NATIVE_HEIGHT		1216
+
 #define OV2685_LANES			1
 #define OV2685_BITS_PER_SAMPLE		10
 
@@ -78,6 +81,7 @@ struct ov2685_mode {
 	u32 exp_def;
 	u32 hts_def;
 	u32 vts_def;
+	const struct v4l2_rect *analog_crop;
 	const struct regval *reg_list;
 };
 
@@ -231,6 +235,13 @@ static const int ov2685_test_pattern_val[] = {
 	OV2685_TEST_PATTERN_COLOR_SQUARE,
 };
 
+static const struct v4l2_rect ov2685_analog_crop = {
+	.left	= 8,
+	.top	= 8,
+	.width	= 1600,
+	.height	= 1200,
+};
+
 static const struct ov2685_mode supported_modes[] = {
 	{
 		.width = 1600,
@@ -238,6 +249,7 @@ static const struct ov2685_mode supported_modes[] = {
 		.exp_def = 0x04ee,
 		.hts_def = 0x06a4,
 		.vts_def = 0x050e,
+		.analog_crop = &ov2685_analog_crop,
 		.reg_list = ov2685_1600x1200_regs,
 	},
 };
@@ -384,6 +396,53 @@ static int ov2685_enum_frame_sizes(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static const struct v4l2_rect *
+__ov2685_get_pad_crop(struct ov2685 *ov2685,
+		      struct v4l2_subdev_state *state, unsigned int pad,
+		      enum v4l2_subdev_format_whence which)
+{
+	const struct ov2685_mode *mode = ov2685->cur_mode;
+
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_crop(&ov2685->subdev, state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return mode->analog_crop;
+	}
+
+	return NULL;
+}
+
+static int ov2685_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	struct ov2685 *ov2685 = to_ov2685(sd);
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+		mutex_lock(&ov2685->mutex);
+		sel->r = *__ov2685_get_pad_crop(ov2685, sd_state, sel->pad,
+				sel->which);
+		mutex_unlock(&ov2685->mutex);
+		break;
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = OV2685_NATIVE_WIDTH;
+		sel->r.height = OV2685_NATIVE_HEIGHT;
+		break;
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		sel->r = ov2685_analog_crop;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Calculate the delay in us by clock rate and clock cycles */
 static inline u32 ov2685_cal_delay(u32 cycles)
 {
@@ -592,6 +651,8 @@ static const struct v4l2_subdev_pad_ops ov2685_pad_ops = {
 	.enum_frame_size = ov2685_enum_frame_sizes,
 	.get_fmt = ov2685_get_fmt,
 	.set_fmt = ov2685_set_fmt,
+	.get_selection = ov2685_get_selection,
+	.set_selection = ov2685_get_selection,
 };
 
 static const struct v4l2_subdev_ops ov2685_subdev_ops = {

-- 
2.39.1

