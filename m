Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270A06C78DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCXHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCXHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:30:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D8910C8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:30:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id dw14so702460pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679643011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMgA1WgXsxNTJqUlWzretZM89Xlk/GVEU2O+yGjujpY=;
        b=binJUkEl05LUmCMUbe7kXGlkZoSftl2cv9YcZGbZns+kmPYX4hvTk9CnrKw0pi+R+A
         RmLLK4Dzob3ZJ2tKTP6Np5RE0EQIG4u7m6tvk+sQ+lVVaKg7vkweCTofvi0desx2GcHx
         8E10G2zqN2pMTr9P6fba+zb2+W4GdThchoQbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMgA1WgXsxNTJqUlWzretZM89Xlk/GVEU2O+yGjujpY=;
        b=HD86kfFV8O7c0Q5oYxO1YN4XXB/61gaap4y/Nwhpd+ObdfTVTFbATc3xKhN+fiPtVn
         hxuGSOPGF9/QYE4HMFUe6yWI+j4YEv1mN67/fHtMqO8Qx6fQ2SseFkVFQOJCgoGiPk3X
         QWYQooj2IOhH9tY5yxaQ/kM5R+xCI0V6MHdnVBGhuCEAdmDuGmCi9QFvgodeTzQ/bvYS
         piYAQHoTq+Qm82SrRXi3R7uA8GIbEbHvsDuipsi1Pmajj6EQj0q28wzM66gD/kGJK7KO
         WV3qjbMS2p2NEbxkB0fiZjWmrntZM94hrZ4xqiyx10WemWjtDsdwyQh9JDkwCTJ+wgl8
         qLkA==
X-Gm-Message-State: AAQBX9deyf5vtOYlVxxPDbHfSvxbpE9OeIcMblwqysieqs0WbJkOVVGi
        9ydW07iN52AJlOPg0tC4ZHVZqA==
X-Google-Smtp-Source: AKy350Z36yOf9dE3RsxYT7XiI1KAlnktW0uoS9M2yL77xg9QP7CQBvJLcmLxCDASlLVdbzxlA8n1eg==
X-Received: by 2002:aa7:958f:0:b0:625:fe95:f120 with SMTP id z15-20020aa7958f000000b00625fe95f120mr2211012pfj.8.1679643010945;
        Fri, 24 Mar 2023 00:30:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:8d44:5dce:a971:c683])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b005a87d636c70sm13116635pfh.130.2023.03.24.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:30:10 -0700 (PDT)
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
Subject: [PATCH] drm/bridge: it6505: Add lock for it6505 i2c bank
Date:   Fri, 24 Mar 2023 15:29:58 +0800
Message-Id: <20230324072958.2993946-1-hsinyi@chromium.org>
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

From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

When the i2c bank register (REG_BANK_SEL) is set to 1,
only the registers belong to bank 1 can be written.
There will be a race condition when a process is writing
bank 0 registers while another process set the bank to 1.
Add a mutex to handle regmap read/write locking for
registers in multiple i2c bank. Since the driver now
owns the lock, there's no need to use regmap API's lock.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 72 ++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index bc451b2a77c28..1a8dcc49fc1ee 100644
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
@@ -414,12 +414,14 @@ struct it6505 {
 	struct mutex extcon_lock;
 	struct mutex mode_lock; /* used to bridge_detect */
 	struct mutex aux_lock; /* used to aux data transfers */
+	struct mutex bank_lock; /* used to protect i2c bank access */
 	struct regmap *regmap;
 	struct drm_display_mode source_output_mode;
 	struct drm_display_mode video_info;
 	struct notifier_block event_nb;
 	struct extcon_dev *extcon;
 	struct work_struct extcon_wq;
+	int bank_state;   /* 1 indicates bank 1, 0 indicates bank 0 */
 	int extcon_state;
 	enum drm_connector_status connector_status;
 	enum link_train_status link_state;
@@ -502,8 +504,22 @@ static const struct regmap_config it6505_regmap_config = {
 	.val_bits = 8,
 	.volatile_table = &it6505_bridge_volatile_table,
 	.cache_type = REGCACHE_NONE,
+	.disable_locking = true,
+	.can_sleep = true,
 };
 
+static int it6505_config_bank(struct it6505 *it6505, unsigned int reg_addr)
+{
+	int err = 0, target = !!(reg_addr > 0xff);
+
+	if (target != it6505->bank_state) {
+		err = regmap_write(it6505->regmap, REG_BANK_SEL, target);
+		if (!err)
+			it6505->bank_state = target;
+	}
+	return err;
+}
+
 static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
 {
 	unsigned int value;
@@ -513,7 +529,10 @@ static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
 	if (!it6505->powered)
 		return -ENODEV;
 
-	err = regmap_read(it6505->regmap, reg_addr, &value);
+	mutex_lock(&it6505->bank_lock);
+	err = it6505_config_bank(it6505, reg_addr);
+	err |= regmap_read(it6505->regmap, reg_addr & 0xff, &value);
+	mutex_unlock(&it6505->bank_lock);
 	if (err < 0) {
 		dev_err(dev, "read failed reg[0x%x] err: %d", reg_addr, err);
 		return err;
@@ -531,8 +550,10 @@ static int it6505_write(struct it6505 *it6505, unsigned int reg_addr,
 	if (!it6505->powered)
 		return -ENODEV;
 
-	err = regmap_write(it6505->regmap, reg_addr, reg_val);
-
+	mutex_lock(&it6505->bank_lock);
+	err = it6505_config_bank(it6505, reg_addr);
+	err |= regmap_write(it6505->regmap, reg_addr & 0xff, reg_val);
+	mutex_unlock(&it6505->bank_lock);
 	if (err < 0) {
 		dev_err(dev, "write failed reg[0x%x] = 0x%x err = %d",
 			reg_addr, reg_val, err);
@@ -551,7 +572,10 @@ static int it6505_set_bits(struct it6505 *it6505, unsigned int reg,
 	if (!it6505->powered)
 		return -ENODEV;
 
-	err = regmap_update_bits(it6505->regmap, reg, mask, value);
+	mutex_lock(&it6505->bank_lock);
+	err = it6505_config_bank(it6505, reg);
+	err |= regmap_update_bits(it6505->regmap, reg & 0xff, mask, value);
+	mutex_unlock(&it6505->bank_lock);
 	if (err < 0) {
 		dev_err(dev, "write reg[0x%x] = 0x%x mask = 0x%x failed err %d",
 			reg, value, mask, err);
@@ -892,7 +916,10 @@ static void it6505_aux_reset(struct it6505 *it6505)
 
 static void it6505_reset_logic(struct it6505 *it6505)
 {
+	mutex_lock(&it6505->bank_lock);
+	it6505_config_bank(it6505, REG_RESET_CTRL);
 	regmap_write(it6505->regmap, REG_RESET_CTRL, ALL_LOGIC_RESET);
+	mutex_unlock(&it6505->bank_lock);
 	usleep_range(1000, 1500);
 }
 
@@ -972,9 +999,14 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	it6505_write(it6505, REG_AUX_ADR_16_19,
 		     ((address >> 16) & 0x0F) | ((size - 1) << 4));
 
-	if (cmd == CMD_AUX_NATIVE_WRITE)
+	if (cmd == CMD_AUX_NATIVE_WRITE) {
+		mutex_lock(&it6505->bank_lock);
+		it6505_config_bank(it6505, REG_AUX_OUT_DATA0);
 		regmap_bulk_write(it6505->regmap, REG_AUX_OUT_DATA0, buffer,
 				  size);
+		mutex_unlock(&it6505->bank_lock);
+	}
+
 
 	/* Aux Fire */
 	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
@@ -1197,9 +1229,12 @@ static int it6505_send_video_infoframe(struct it6505 *it6505,
 	if (err)
 		return err;
 
-	err = regmap_bulk_write(it6505->regmap, REG_AVI_INFO_DB1,
+	mutex_lock(&it6505->bank_lock);
+	err = it6505_config_bank(it6505, REG_AVI_INFO_DB1);
+	err |= regmap_bulk_write(it6505->regmap, REG_AVI_INFO_DB1,
 				buffer + HDMI_INFOFRAME_HEADER_SIZE,
 				frame->length);
+	mutex_unlock(&it6505->bank_lock);
 	if (err)
 		return err;
 
@@ -1267,7 +1302,6 @@ static void it6505_init(struct it6505 *it6505)
 	it6505_write(it6505, REG_TIME_STMP_CTRL,
 		     EN_SSC_GAT | EN_ENHANCE_VID_STMP | EN_ENHANCE_AUD_STMP);
 	it6505_write(it6505, REG_INFOFRAME_CTRL, 0x00);
-	it6505_write(it6505, REG_BANK_SEL, 0x01);
 	it6505_write(it6505, REG_DRV_0_DB_800_MV,
 		     afe_setting_table[it6505->afe_setting][0]);
 	it6505_write(it6505, REG_PRE_0_DB_800_MV,
@@ -1277,7 +1311,6 @@ static void it6505_init(struct it6505 *it6505)
 	it6505_write(it6505, REG_SSC_CTRL0, 0x9E);
 	it6505_write(it6505, REG_SSC_CTRL1, 0x1C);
 	it6505_write(it6505, REG_SSC_CTRL2, 0x42);
-	it6505_write(it6505, REG_BANK_SEL, 0x00);
 }
 
 static void it6505_video_disable(struct it6505 *it6505)
@@ -1506,11 +1539,9 @@ static void it6505_setup_ssc(struct it6505 *it6505)
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
@@ -1983,8 +2014,11 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
 	it6505_set_bits(it6505, REG_HDCP_CTRL2, HDCP_EN_M0_READ,
 			HDCP_EN_M0_READ);
 
-	err = regmap_bulk_read(it6505->regmap, REG_M0_0_7,
+	mutex_lock(&it6505->bank_lock);
+	err = it6505_config_bank(it6505, REG_M0_0_7);
+	err |= regmap_bulk_read(it6505->regmap, REG_M0_0_7,
 			       sha1_input + msg_count, 8);
+	mutex_unlock(&it6505->bank_lock);
 
 	it6505_set_bits(it6505, REG_HDCP_CTRL2, HDCP_EN_M0_READ, 0x00);
 
@@ -2577,6 +2611,9 @@ static int it6505_poweron(struct it6505 *it6505)
 	}
 
 	it6505->powered = true;
+	mutex_lock(&it6505->bank_lock);
+	it6505->bank_state = 0;
+	mutex_unlock(&it6505->bank_lock);
 	it6505_reset_logic(it6505);
 	it6505_int_mask_enable(it6505);
 	it6505_init(it6505);
@@ -3359,6 +3396,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	mutex_init(&it6505->extcon_lock);
 	mutex_init(&it6505->mode_lock);
 	mutex_init(&it6505->aux_lock);
+	mutex_init(&it6505->bank_lock);
 
 	it6505->bridge.of_node = client->dev.of_node;
 	it6505->connector_status = connector_status_disconnected;
-- 
2.40.0.348.gf938b09366-goog

