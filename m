Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010067FDF0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjA2JnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjA2Jm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:42:59 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7FA250;
        Sun, 29 Jan 2023 01:42:53 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 52C50CDE2B;
        Sun, 29 Jan 2023 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674985372; bh=R963XiWG8I087EIGFoGr/eGgPVKChoDVSb6l1Zl4J0Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=DstNmFfp95SRGDa92uNqmd5yQrsVFsuidzdBloW+r035OXLeNNME4CP1bFq3Aluk/
         VtwJ+2o7ePhRyctRSK/pmXjRwheISmhPlT4zBtxkp0OBQHP/LRp00i7SqBzj8BdNHn
         9+RHvFeXH6kOa1gN0ucF0Wz53d7gQoIpJe+Os1H4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 29 Jan 2023 10:42:38 +0100
Subject: [PATCH 4/4] media: i2c: ov2685: Add .get_selection() support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230129-ov2685-improvements-v1-4-f281bd49399c@z3ntu.xyz>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=R963XiWG8I087EIGFoGr/eGgPVKChoDVSb6l1Zl4J0Q=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj1j+aqBXyjFkPdby91LLjF/yrKIZSCZpCNPcCKsav
 /6FCtoyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9Y/mgAKCRBy2EO4nU3XVvgkD/
 9NpFgf8l4TLxIgs+R9/TAQlDzNPv5QDgG+gXK2m+S1tgZ4MufPtjAbO7LlF1SFJROrgEr6povkje5o
 AgYamk0Jn5Ct6+7+HB6AL+Oqk24T9z1VzFuI/3XIGrIEPHUgabMpCvCcPe5EU4iWdo43/tK4vsRS4u
 lsgRVMflNbUwwFpff1TWT055ruX8I17wVh/M90spfuY9Cyu23QibeldcBXolToLeiY346k6Z3zJ8i0
 pwfHxock/kn51jo4u6xhONLjDW3a0JMMtWg98okaxhSgZZYwqnFE8wGXyNIvgHDoeHxxVA7SHrJt6l
 6T5kHnELqHeAN/YJaaE58Sbp7MtveS2o9ByjFwFmwbuYnmKf/WzxQIHswLRWBa44zp/B7c/YkoHIHg
 TXPdoUZ2+OWkwtBXDvInALMzDNIlJxwtc8txA60FiFbFGg9MQteIKoSjOm2qvyoVa5rm8/pgWCsuki
 FntIJMh9QOdw9SSDDc9O8y1pPVmHgxHuTXRUDjKFaBfH3wF4XPSoPBY6cfy4jgjZHwfiGXlSuK/Pld
 usPXHEoR5kdGLrghO4NHxueDiICr/tBLKBC40hEri9E91nK0xsRw9q0Dsdj28ge/K5IhHYqhVWOB2K
 MSckuuN+zbsY8QqPYfeMx6NtyA+Myqp3yUAgjZJaXASt4+dfsv5J5QaBz+AA==
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

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/media/i2c/ov2685.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
index bfced11b178b..7ebf36d1a8cc 100644
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

