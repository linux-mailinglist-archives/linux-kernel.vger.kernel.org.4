Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5B69F044
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBVIdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjBVIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:33:12 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5501234F2;
        Wed, 22 Feb 2023 00:33:10 -0800 (PST)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D91C81BF20B;
        Wed, 22 Feb 2023 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677054789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qvG7uT+bYylpQqr8tYFzGZu06/xIT+ZSuYxbWKYKlc=;
        b=odrhX/rwYXXfvgN6lbMS3e3MhmDwAzB8WOQBjOvIRTYXM3WpLjWZfojMzDV/0td5BHtcJi
        zA+/2BG7s6teXPd5rPaBNouV3wlWwB/cREjT3VLNVB4huyuysI04hZo56DFll/XiFADQ9M
        wGRPESHvl81EvqZMktwlQVTwSvUMf7b8ppfYzbvqL+4rtE3evM2EHz+xZShTG/MVGCq6T/
        xLlm1DGrcgfZctM2pyD5WU3xRoUHDX+kQwX5tEj7UQvwbAGYqKAkkV4tnyqH5JyW1J9CcK
        h0KVi++8g4FSOPsXY5ywk3tUSP+hLOFi+8uoPLcc92/6Udbq/Hw4AnSH6EGsDA==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Crt Mori <cmo@melexis.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 2/2] ASoC: tas571x: add support for TAS5733
Date:   Wed, 22 Feb 2023 09:33:00 +0100
Message-Id: <20230222083300.218523-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
References: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for TAS5733.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 sound/soc/codecs/tas571x.c | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 84ec1b527646..f39c3273b2fd 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -718,6 +718,63 @@ static const struct regmap_config tas5721_regmap_config = {
 	.volatile_table			= &tas571x_volatile_regs,
 };
 
+static const char *const tas5733_supply_names[] = {
+	"AVDD",
+	"DVDD",
+	"PVDD",
+};
+
+static const struct reg_default tas5733_reg_defaults[] = {
+	{TAS571X_CLK_CTRL_REG,          0x6c},
+	{TAS571X_DEV_ID_REG,            0x00},
+	{TAS571X_ERR_STATUS_REG,        0x00},
+	{TAS571X_SYS_CTRL_1_REG,        0xa0},
+	{TAS571X_SDI_REG,               0x05},
+	{TAS571X_SYS_CTRL_2_REG,        0x40},
+	{TAS571X_SOFT_MUTE_REG,         0x07},
+	{TAS571X_MVOL_REG,              0x03ff},
+	{TAS571X_CH1_VOL_REG,           0x00c0},
+	{TAS571X_CH2_VOL_REG,           0x00c0},
+	{TAS571X_CH3_VOL_REG,           0x00c0},
+	{TAS571X_VOL_CFG_REG,           0xf0},
+	{TAS571X_MODULATION_LIMIT_REG,  0x07},
+	{TAS571X_IC_DELAY_CH1_REG,      0xb8},
+	{TAS571X_IC_DELAY_CH2_REG,      0x60},
+	{TAS571X_IC_DELAY_CH3_REG,      0xa0},
+	{TAS571X_IC_DELAY_CH4_REG,      0x48},
+	{TAS571X_PWM_CH_SDN_GROUP_REG,  0x30},
+	{TAS571X_START_STOP_PERIOD_REG, 0x68},
+	{TAS571X_OSC_TRIM_REG,          0x82},
+	{TAS571X_BKND_ERR_REG,          0x02},
+	{TAS571X_INPUT_MUX_REG,         0x00897772},
+	{TAS571X_PWM_MUX_REG,           0x01021345},
+	{TAS5717_CH1_RIGHT_CH_MIX_REG,  0x00},
+	{TAS5717_CH1_LEFT_CH_MIX_REG,   0x800000},
+	{TAS5717_CH2_LEFT_CH_MIX_REG,   0x00},
+	{TAS5717_CH2_RIGHT_CH_MIX_REG,  0x800000},
+};
+
+static const struct regmap_config tas5733_regmap_config = {
+	.reg_bits                       = 8,
+	.val_bits                       = 32,
+	.max_register                   = 0xff,
+	.reg_read                       = tas571x_reg_read,
+	.reg_write                      = tas571x_reg_write,
+	.reg_defaults                   = tas5733_reg_defaults,
+	.num_reg_defaults               = ARRAY_SIZE(tas5733_reg_defaults),
+	.cache_type                     = REGCACHE_RBTREE,
+	.wr_table                       = &tas571x_write_regs,
+	.volatile_table                 = &tas571x_volatile_regs,
+};
+
+static const struct tas571x_chip tas5733_chip = {
+	.supply_names                   = tas5733_supply_names,
+	.num_supply_names               = ARRAY_SIZE(tas5733_supply_names),
+	.controls                       = tas5717_controls,
+	.num_controls                   = ARRAY_SIZE(tas5717_controls),
+	.regmap_config                  = &tas5733_regmap_config,
+	.vol_reg_size                   = 2,
+};
 
 static const struct tas571x_chip tas5721_chip = {
 	.supply_names			= tas5721_supply_names,
@@ -897,6 +954,7 @@ static const struct of_device_id tas571x_of_match[] __maybe_unused = {
 	{ .compatible = "ti,tas5717", .data = &tas5717_chip, },
 	{ .compatible = "ti,tas5719", .data = &tas5717_chip, },
 	{ .compatible = "ti,tas5721", .data = &tas5721_chip, },
+	{ .compatible = "ti,tas5733", .data = &tas5733_chip, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tas571x_of_match);
@@ -907,6 +965,7 @@ static const struct i2c_device_id tas571x_i2c_id[] = {
 	{ "tas5717", (kernel_ulong_t) &tas5717_chip },
 	{ "tas5719", (kernel_ulong_t) &tas5717_chip },
 	{ "tas5721", (kernel_ulong_t) &tas5721_chip },
+	{ "tas5733", (kernel_ulong_t) &tas5733_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas571x_i2c_id);
-- 
2.35.1

