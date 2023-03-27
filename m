Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790E6C9AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjC0Es2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC0EsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:48:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63063A92
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:48:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso10619920pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679892503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Pd7dqqy0hzxVLL2WGmjbhWP2DILZx6QykeCiryBUI=;
        b=K76RAZ1rXnvXwh51XE0jU9ANX5FNSrfzvv804NOC2TOvQFUWDwOdMO1tgOdcUCrLDj
         SPcv4LgYZBA1gszS1K8Y0YwU0xEBA88q35DS7Y3KL7Akm8dmND7Gkx6fO4OMh0Gj1gnU
         gPFaD7hzL8aslS/A0P5SeX5Bv/cwJQraQA58A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679892503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9Pd7dqqy0hzxVLL2WGmjbhWP2DILZx6QykeCiryBUI=;
        b=PYIAaS+s080W5MKdBmX10ZiSlVaRKZ2/X2Uu84JMJDCBdmVomi1X6VgGfku0j1xduK
         XLSDRbwb7DBGppA4Bw1gGBaPF++ramYTuzemHO70g0ONyj0JXof0C9zsTQ+/H6AoiUVN
         RhMOw6yjN1NOT3uu7Tuv4zMSTAq2HxfWxsVE6rhbRPMbpQmScShfBuepV681/nU+uabv
         biIv5aOdOGLGL8Ej9MYQ64uHgo/jpn1Rao1ngMOc/iwdH0mIC7GSxPyXwbLmDZPsN13w
         9IzwUOwSCYhYOPW4rNU8LpOut1P3BGx1im29iK3ST3zKGvnNRFLCaLMUIFdPEE96yUpx
         rHag==
X-Gm-Message-State: AO0yUKXSDBycT7wdeMjcKSXZmmeoyAV0dDGMmh4ZzSAYzxOpXHXUnDeN
        D8MOkzTt7yySLHmvDRMjN5ZQXEeU1YzmmnSHerg=
X-Google-Smtp-Source: AK7set9p4OT6xKcpkNGCwHVp4BJQ0FTKN5V2C7YZEhCatLt09GE1Wxy/Uo9rbm+ZpJ3Rkw5qWwmAwA==
X-Received: by 2002:a05:6a20:47e2:b0:da:adbf:7b96 with SMTP id ey34-20020a056a2047e200b000daadbf7b96mr8761684pzb.21.1679892503103;
        Sun, 26 Mar 2023 21:48:23 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5824:3912:1493:4862])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b0058837da69edsm17884391pfd.128.2023.03.26.21.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 21:48:22 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <rfoss@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kenneth.hung@ite.corp-partner.google.com,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/bridge: it6505: Add range and selector_reg
Date:   Mon, 27 Mar 2023 12:48:05 +0800
Message-Id: <20230327044804.3657551-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 banks on it6505, and when writing to different bank,
REG_BANK_SEL needs to be set to the targeted bank. The current code set
this additionally, which causes a race condition when a process is
writing bank 0 registers while another process set the bank to 1. Set
ranges in regmap config so the regmap API would handle the bank changes.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 34 +++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index bc451b2a77c28..abaf6e23775eb 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -258,12 +258,12 @@
 #define REG_AUD_INFOFRAM_SUM 0xFB
 
 /* the following six registers are in bank1 */
-#define REG_DRV_0_DB_800_MV 0x7E
-#define REG_PRE_0_DB_800_MV 0x7F
-#define REG_PRE_3P5_DB_800_MV 0x81
-#define REG_SSC_CTRL0 0x88
-#define REG_SSC_CTRL1 0x89
-#define REG_SSC_CTRL2 0x8A
+#define REG_DRV_0_DB_800_MV 0x17E
+#define REG_PRE_0_DB_800_MV 0x17F
+#define REG_PRE_3P5_DB_800_MV 0x181
+#define REG_SSC_CTRL0 0x188
+#define REG_SSC_CTRL1 0x189
+#define REG_SSC_CTRL2 0x18A
 
 #define RBR DP_LINK_BW_1_62
 #define HBR DP_LINK_BW_2_7
@@ -489,7 +489,7 @@ static const struct it6505_audio_sample_rate_map audio_sample_rate_map[] = {
 };
 
 static const struct regmap_range it6505_bridge_volatile_ranges[] = {
-	{ .range_min = 0, .range_max = 0xFF },
+	{ .range_min = 0, .range_max = 0x1FF },
 };
 
 static const struct regmap_access_table it6505_bridge_volatile_table = {
@@ -497,11 +497,27 @@ static const struct regmap_access_table it6505_bridge_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(it6505_bridge_volatile_ranges),
 };
 
+static const struct regmap_range_cfg it6505_regmap_banks[] = {
+	{
+		.name = "it6505",
+		.range_min = 0x00,
+		.range_max = 0x1FF,
+		.selector_reg = REG_BANK_SEL,
+		.selector_mask = 0x1,
+		.selector_shift = 0,
+		.window_start = 0x00,
+		.window_len = 0x100,
+	},
+};
+
 static const struct regmap_config it6505_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &it6505_bridge_volatile_table,
 	.cache_type = REGCACHE_NONE,
+	.ranges = it6505_regmap_banks,
+	.num_ranges = ARRAY_SIZE(it6505_regmap_banks),
+	.max_register = 0x1FF,
 };
 
 static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
@@ -1267,7 +1283,6 @@ static void it6505_init(struct it6505 *it6505)
 	it6505_write(it6505, REG_TIME_STMP_CTRL,
 		     EN_SSC_GAT | EN_ENHANCE_VID_STMP | EN_ENHANCE_AUD_STMP);
 	it6505_write(it6505, REG_INFOFRAME_CTRL, 0x00);
-	it6505_write(it6505, REG_BANK_SEL, 0x01);
 	it6505_write(it6505, REG_DRV_0_DB_800_MV,
 		     afe_setting_table[it6505->afe_setting][0]);
 	it6505_write(it6505, REG_PRE_0_DB_800_MV,
@@ -1277,7 +1292,6 @@ static void it6505_init(struct it6505 *it6505)
 	it6505_write(it6505, REG_SSC_CTRL0, 0x9E);
 	it6505_write(it6505, REG_SSC_CTRL1, 0x1C);
 	it6505_write(it6505, REG_SSC_CTRL2, 0x42);
-	it6505_write(it6505, REG_BANK_SEL, 0x00);
 }
 
 static void it6505_video_disable(struct it6505 *it6505)
@@ -1506,11 +1520,9 @@ static void it6505_setup_ssc(struct it6505 *it6505)
 	it6505_set_bits(it6505, REG_TRAIN_CTRL0, SPREAD_AMP_5,
 			it6505->enable_ssc ? SPREAD_AMP_5 : 0x00);
 	if (it6505->enable_ssc) {
-		it6505_write(it6505, REG_BANK_SEL, 0x01);
 		it6505_write(it6505, REG_SSC_CTRL0, 0x9E);
 		it6505_write(it6505, REG_SSC_CTRL1, 0x1C);
 		it6505_write(it6505, REG_SSC_CTRL2, 0x42);
-		it6505_write(it6505, REG_BANK_SEL, 0x00);
 		it6505_write(it6505, REG_SP_CTRL0, 0x07);
 		it6505_write(it6505, REG_IP_CTRL1, 0x29);
 		it6505_write(it6505, REG_IP_CTRL2, 0x03);
-- 
2.40.0.348.gf938b09366-goog

