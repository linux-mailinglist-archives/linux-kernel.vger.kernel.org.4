Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA36E5134
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjDQTvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDQTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:51:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609EA44B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fbb713301so188154837b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681761068; x=1684353068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEvLVA96vWTMuP3gha+tW69fpKPtcA8BHU4XRw3gyvE=;
        b=gY/HmAZI+eCQafIsmsArKdDzHEwAlRv/V9b47LZrdT4HPZ/iuK+S8qdrwON3RdvpM+
         wwv0FioHSWaZKKKtIkX9GjikeyxLAPhTpfDDQOWb26L/037ptN2FzuVhvidBiiDl+HPj
         1wdpg1c5vMycM1ccstrNq8WJYQUpx/wnlrJMn7wsVb5XEDr5rBD4+rThO0Qq+92UGCyv
         foMtw/wO1bcaHfiDzc2gHP9F3P5oXBsOHagBw9iIfyLrwKKlJC7n+QotEltpik6PncUA
         ftgVIoBOAMhqRNPfg9NOrnIsbL2wo0Nqr7BX9FkW7T/MzK3dZ4ExVtVzR3dxqo+gQzOl
         cC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761068; x=1684353068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEvLVA96vWTMuP3gha+tW69fpKPtcA8BHU4XRw3gyvE=;
        b=bPCPtVzVrZOFRSV9kD8JSLnLKpvsTTa0iRRa5O4HNP5Mk4Cjnv6gqldYITmJ9zVnpM
         kxjgfQmDW0Heh+c08ngOupXGuwj99s3fPRVrBcBAvt4yKO8FyVjtafw1UAc12kYSy+4R
         jL/De5xkit44FUEk+kNCQ1PqFyrwHcj2E3cOkNYzt7YnaIpI49LG3bs4QS0BJfKS5znS
         vWuyExZ6VYIB5d/zz3P1dzBnsTG9IbcC2CRy9wguiufrLcSCyiJnEhNKEiGi8M/Z3R/d
         s7CauTrhXPljQ83rOL8tdm39XUhdQbiwcs3PGoVbAGbCFesqBeBc6WrqI8TkhNIy4LnH
         mZxg==
X-Gm-Message-State: AAQBX9fVL89nK5xTn24WY/kcHkKWhh2q6hT/q9wNmFvP19w2pTedTIfl
        XHcBlKeVGAo7uXZWSY5Yc3TIlA==
X-Google-Smtp-Source: AKy350YU2veZX1zAVpWs12pPX+VIecaIET46gb3dRlcSqjc83Ze+iQgnULU5k/4vtwkn8wRsUjyOUg==
X-Received: by 2002:a81:7202:0:b0:549:27a8:90b with SMTP id n2-20020a817202000000b0054927a8090bmr15483361ywc.40.1681761068357;
        Mon, 17 Apr 2023 12:51:08 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u125-20020a817983000000b005463f6ae720sm3293158ywc.68.2023.04.17.12.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:51:07 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 4/4] counter: 104-quad-8: Migrate to the regmap API
Date:   Mon, 17 Apr 2023 15:50:50 -0400
Message-Id: <1f1f7920d2be94aedb6fdf49f429fe6137c8cb24.1681753140.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681753140.git.william.gray@linaro.org>
References: <cover.1681753140.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. With regmap we get boundary checks, read-write
permissions, operation synchronization locks, and more for free. Most
important of all, rather than rolling our own we utilize implementations
that are known to work and gain from any future improvements and fixes
that come.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4:
 - Mention benefits of using regmap in the commit description
 - Use "int ret" for regmap_* return values throughout for consistency
 - Reorganize declaration lists to prioritize longer lines first

 drivers/counter/104-quad-8.c | 365 ++++++++++++++++++++++-------------
 drivers/counter/Kconfig      |   1 +
 2 files changed, 229 insertions(+), 137 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index d6ede651cc5e..ed1f57511955 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -9,7 +9,7 @@
 #include <linux/bits.h>
 #include <linux/counter.h>
 #include <linux/device.h>
-#include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
@@ -18,8 +18,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/types.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #include <asm/unaligned.h>
 
@@ -37,35 +38,13 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
 
 #define QUAD8_NUM_COUNTERS 8
 
-/**
- * struct channel_reg - channel register structure
- * @data:	Count data
- * @control:	Channel flags and control
- */
-struct channel_reg {
-	u8 data;
-	u8 control;
-};
-
-/**
- * struct quad8_reg - device register structure
- * @channel:		quadrature counter data and control
- * @interrupt_status:	channel interrupt status
- * @channel_oper:	enable/reset counters and interrupt functions
- * @index_interrupt:	enable channel interrupts
- * @reserved:		reserved for Factory Use
- * @index_input_levels:	index signal logical input level
- * @cable_status:	differential encoder cable status
- */
-struct quad8_reg {
-	struct channel_reg channel[QUAD8_NUM_COUNTERS];
-	u8 interrupt_status;
-	u8 channel_oper;
-	u8 index_interrupt;
-	u8 reserved[3];
-	u8 index_input_levels;
-	u8 cable_status;
-};
+#define QUAD8_DATA(_channel) ((_channel) * 2)
+#define QUAD8_CONTROL(_channel) (QUAD8_DATA(_channel) + 1)
+#define QUAD8_INTERRUPT_STATUS 0x10
+#define QUAD8_CHANNEL_OPERATION 0x11
+#define QUAD8_INDEX_INTERRUPT 0x12
+#define QUAD8_INDEX_INPUT_LEVELS 0x16
+#define QUAD8_CABLE_STATUS 0x17
 
 /**
  * struct quad8 - device private data structure
@@ -76,7 +55,7 @@ struct quad8_reg {
  * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
  * @cable_fault_enable:	differential encoder cable status enable configurations
- * @reg:		I/O address offset for the device registers
+ * @map:		regmap for the device
  */
 struct quad8 {
 	spinlock_t lock;
@@ -86,7 +65,30 @@ struct quad8 {
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int cable_fault_enable;
-	struct quad8_reg __iomem *reg;
+	struct regmap *map;
+};
+
+static const struct regmap_range quad8_wr_ranges[] = {
+	regmap_reg_range(0x0, 0xF), regmap_reg_range(0x11, 0x12), regmap_reg_range(0x17, 0x17),
+};
+static const struct regmap_range quad8_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x12), regmap_reg_range(0x16, 0x18),
+};
+static const struct regmap_access_table quad8_wr_table = {
+	.yes_ranges = quad8_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(quad8_wr_ranges),
+};
+static const struct regmap_access_table quad8_rd_table = {
+	.yes_ranges = quad8_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(quad8_rd_ranges),
+};
+static const struct regmap_config quad8_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.wr_table = &quad8_wr_table,
+	.rd_table = &quad8_rd_table,
 };
 
 /* Error flag */
@@ -202,12 +204,12 @@ struct quad8 {
 /* Each Counter is 24 bits wide */
 #define LS7267_CNTR_MAX GENMASK(23, 0)
 
-static __always_inline void quad8_control_register_update(struct quad8 *const priv, u8 *const buf,
-							  const size_t channel, const u8 val,
-							  const u8 field)
+static __always_inline int quad8_control_register_update(struct regmap *const map, u8 *const buf,
+							 const size_t channel, const u8 val,
+							 const u8 field)
 {
 	u8p_replace_bits(&buf[channel], val, field);
-	iowrite8(buf[channel], &priv->reg->channel[channel].control);
+	return regmap_write(map, QUAD8_CONTROL(channel), buf[channel]);
 }
 
 static int quad8_signal_read(struct counter_device *counter,
@@ -215,15 +217,17 @@ static int quad8_signal_read(struct counter_device *counter,
 			     enum counter_signal_level *level)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	unsigned int state;
+	int ret;
 
 	/* Only Index signal levels can be read */
 	if (signal->id < 16)
 		return -EINVAL;
 
-	state = ioread8(&priv->reg->index_input_levels) & BIT(signal->id - 16);
+	ret = regmap_test_bits(priv->map, QUAD8_INDEX_INPUT_LEVELS, BIT(signal->id - 16));
+	if (ret < 0)
+		return ret;
 
-	*level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
+	*level = (ret) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
 
 	return 0;
 }
@@ -232,48 +236,56 @@ static int quad8_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
 	struct quad8 *const priv = counter_priv(counter);
-	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
 	u8 value[3];
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
-	ioread8_rep(&chan->data, value, sizeof(value));
+	ret = regmap_write(priv->map, QUAD8_CONTROL(count->id),
+			   SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL);
+	if (ret)
+		goto exit_unlock;
+	ret = regmap_noinc_read(priv->map, QUAD8_DATA(count->id), value, sizeof(value));
 
+exit_unlock:
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	*val = get_unaligned_le24(value);
 
-	return 0;
+	return ret;
 }
 
-static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
-				      const unsigned long preset)
+static int quad8_preset_register_set(struct quad8 *const priv, const size_t id,
+				     const unsigned long preset)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
 	u8 value[3];
+	int ret;
 
 	put_unaligned_le24(preset, value);
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	iowrite8_rep(&chan->data, value, sizeof(value));
+	ret = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BP);
+	if (ret)
+		return ret;
+	return regmap_noinc_write(priv->map, QUAD8_DATA(id), value, sizeof(value));
 }
 
-static void quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
+static int quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+	int ret;
 
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	ret = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BT_CT_CPT_S_IDX);
+	if (ret)
+		return ret;
+	return regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_E);
 }
 
 static int quad8_count_write(struct counter_device *counter,
 			     struct counter_count *count, u64 val)
 {
 	struct quad8 *const priv = counter_priv(counter);
-	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
+	int ret;
 
 	if (val > LS7267_CNTR_MAX)
 		return -ERANGE;
@@ -281,17 +293,24 @@ static int quad8_count_write(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Counter can only be set via Preset Register */
-	quad8_preset_register_set(priv, count->id, val);
-	iowrite8(SELECT_RLD | TRANSFER_PR_TO_CNTR, &chan->control);
+	ret = quad8_preset_register_set(priv, count->id, val);
+	if (ret)
+		goto exit_unlock;
+	ret = regmap_write(priv->map, QUAD8_CONTROL(count->id), SELECT_RLD | TRANSFER_PR_TO_CNTR);
+	if (ret)
+		goto exit_unlock;
 
-	quad8_flag_register_reset(priv, count->id);
+	ret = quad8_flag_register_reset(priv, count->id);
+	if (ret)
+		goto exit_unlock;
 
 	/* Set Preset Register back to original value */
-	quad8_preset_register_set(priv, count->id, priv->preset[count->id]);
+	ret = quad8_preset_register_set(priv, count->id, priv->preset[count->id]);
 
+exit_unlock:
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static const enum counter_function quad8_count_functions_list[] = {
@@ -349,6 +368,7 @@ static int quad8_function_write(struct counter_device *counter,
 	unsigned long irqflags;
 	unsigned int mode_cfg;
 	bool synchronous_mode;
+	int ret;
 
 	switch (function) {
 	case COUNTER_FUNCTION_PULSE_DIRECTION:
@@ -372,14 +392,19 @@ static int quad8_function_write(struct counter_device *counter,
 
 	/* Synchronous function not supported in non-quadrature mode */
 	synchronous_mode = u8_get_bits(priv->idr[id], INDEX_MODE) == ENABLE_INDEX_MODE;
-	if (synchronous_mode && mode_cfg == NON_QUADRATURE)
-		quad8_control_register_update(priv, priv->idr, id, DISABLE_INDEX_MODE, INDEX_MODE);
+	if (synchronous_mode && mode_cfg == NON_QUADRATURE) {
+		ret = quad8_control_register_update(priv->map, priv->idr, id, DISABLE_INDEX_MODE,
+						    INDEX_MODE);
+		if (ret)
+			goto exit_unlock;
+	}
 
-	quad8_control_register_update(priv, priv->cmr, id, mode_cfg, QUADRATURE_MODE);
+	ret = quad8_control_register_update(priv->map, priv->cmr, id, mode_cfg, QUADRATURE_MODE);
 
+exit_unlock:
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_direction_read(struct counter_device *counter,
@@ -387,10 +412,12 @@ static int quad8_direction_read(struct counter_device *counter,
 				enum counter_count_direction *direction)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
-	u8 flag;
+	unsigned int flag;
+	int ret;
 
-	flag = ioread8(flag_addr);
+	ret = regmap_read(priv->map, QUAD8_CONTROL(count->id), &flag);
+	if (ret)
+		return ret;
 	*direction = (u8_get_bits(flag, FLAG_UD) == UP) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
 
@@ -481,6 +508,7 @@ static int quad8_events_configure(struct counter_device *counter)
 	unsigned long irqflags;
 	struct counter_event_node *event_node;
 	u8 flg_pins;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
@@ -500,8 +528,8 @@ static int quad8_events_configure(struct counter_device *counter)
 			break;
 		default:
 			/* should never reach this path */
-			spin_unlock_irqrestore(&priv->lock, irqflags);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto exit_unlock;
 		}
 
 		/* Enable IRQ line */
@@ -512,15 +540,18 @@ static int quad8_events_configure(struct counter_device *counter)
 			continue;
 
 		/* Save new IRQ function configuration */
-		quad8_control_register_update(priv, priv->ior, event_node->channel, flg_pins,
-					      FLG_PINS);
+		ret = quad8_control_register_update(priv->map, priv->ior, event_node->channel,
+						    flg_pins, FLG_PINS);
+		if (ret)
+			goto exit_unlock;
 	}
 
-	iowrite8(irq_enabled, &priv->reg->index_interrupt);
+	ret = regmap_write(priv->map, QUAD8_INDEX_INTERRUPT, irq_enabled);
 
+exit_unlock:
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_watch_validate(struct counter_device *counter,
@@ -581,14 +612,16 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	unsigned long irqflags;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	quad8_control_register_update(priv, priv->idr, channel_id, index_polarity, INDEX_POLARITY);
+	ret = quad8_control_register_update(priv->map, priv->idr, channel_id, index_polarity,
+					    INDEX_POLARITY);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_polarity_read(struct counter_device *counter,
@@ -643,21 +676,24 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	const size_t channel_id = signal->id - 16;
 	u8 quadrature_mode;
 	unsigned long irqflags;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	quadrature_mode = u8_get_bits(priv->idr[channel_id], QUADRATURE_MODE);
 	if (synchronous_mode && quadrature_mode == NON_QUADRATURE) {
-		spin_unlock_irqrestore(&priv->lock, irqflags);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit_unlock;
 	}
 
-	quad8_control_register_update(priv, priv->idr, channel_id, synchronous_mode, INDEX_MODE);
+	ret = quad8_control_register_update(priv->map, priv->idr, channel_id, synchronous_mode,
+					    INDEX_MODE);
 
+exit_unlock:
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_count_floor_read(struct counter_device *counter,
@@ -700,6 +736,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
 	unsigned long irqflags;
+	int ret;
 
 	switch (cnt_mode) {
 	case COUNTER_COUNT_MODE_NORMAL:
@@ -721,11 +758,12 @@ static int quad8_count_mode_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	quad8_control_register_update(priv, priv->cmr, count->id, count_mode, COUNT_MODE);
+	ret = quad8_control_register_update(priv->map, priv->cmr, count->id, count_mode,
+					    COUNT_MODE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_count_enable_read(struct counter_device *counter,
@@ -743,14 +781,15 @@ static int quad8_count_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	quad8_control_register_update(priv, priv->ior, count->id, enable, AB_GATE);
+	ret = quad8_control_register_update(priv->map, priv->ior, count->id, enable, AB_GATE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static const char *const quad8_noise_error_states[] = {
@@ -762,10 +801,12 @@ static int quad8_error_noise_get(struct counter_device *counter,
 				 struct counter_count *count, u32 *noise_error)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
-	u8 flag;
+	unsigned int flag;
+	int ret;
 
-	flag = ioread8(flag_addr);
+	ret = regmap_read(priv->map, QUAD8_CONTROL(count->id), &flag);
+	if (ret)
+		return ret;
 	*noise_error = u8_get_bits(flag, FLAG_E);
 
 	return 0;
@@ -786,6 +827,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
+	int ret;
 
 	if (preset > LS7267_CNTR_MAX)
 		return -ERANGE;
@@ -793,11 +835,11 @@ static int quad8_count_preset_write(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->preset[count->id] = preset;
-	quad8_preset_register_set(priv, count->id, preset);
+	ret = quad8_preset_register_set(priv, count->id, preset);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_count_ceiling_read(struct counter_device *counter,
@@ -829,6 +871,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
+	int ret;
 
 	if (ceiling > LS7267_CNTR_MAX)
 		return -ERANGE;
@@ -840,14 +883,16 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	case RANGE_LIMIT:
 	case MODULO_N:
 		priv->preset[count->id] = ceiling;
-		quad8_preset_register_set(priv, count->id, ceiling);
-		spin_unlock_irqrestore(&priv->lock, irqflags);
-		return 0;
+		ret = quad8_preset_register_set(priv, count->id, ceiling);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return -EINVAL;
+	return ret;
 }
 
 static int quad8_count_preset_enable_read(struct counter_device *counter,
@@ -868,15 +913,17 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Preset enable is active low in Input/Output Control register */
-	quad8_control_register_update(priv, priv->ior, count->id, !preset_enable, LOAD_PIN);
+	ret = quad8_control_register_update(priv->map, priv->ior, count->id, !preset_enable,
+					    LOAD_PIN);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_signal_cable_fault_read(struct counter_device *counter,
@@ -887,7 +934,7 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	bool disabled;
-	unsigned int status;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
@@ -898,13 +945,16 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	/* Logic 0 = cable fault */
-	status = ioread8(&priv->reg->cable_status);
+	ret = regmap_test_bits(priv->map, QUAD8_CABLE_STATUS, BIT(channel_id));
+	if (ret < 0) {
+		spin_unlock_irqrestore(&priv->lock, irqflags);
+		return ret;
+	}
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	/* Mask respective channel and invert logic */
-	*cable_fault = !(status & BIT(channel_id));
+	/* Logic 0 = cable fault */
+	*cable_fault = !ret;
 
 	return 0;
 }
@@ -929,6 +979,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	unsigned int cable_fault_enable;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
@@ -940,11 +991,11 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 	/* Enable is active low in Differential Encoder Cable Status register */
 	cable_fault_enable = ~priv->cable_fault_enable;
 
-	iowrite8(cable_fault_enable, &priv->reg->cable_status);
+	ret = regmap_write(priv->map, QUAD8_CABLE_STATUS, cable_fault_enable);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
@@ -958,14 +1009,18 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	return 0;
 }
 
-static void quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
-					     const u8 prescaler)
+static int quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
+					    const u8 prescaler)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
-
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	iowrite8(prescaler, &chan->data);
-	iowrite8(SELECT_RLD | TRANSFER_PR0_TO_PSC, &chan->control);
+	int ret;
+
+	ret = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BP);
+	if (ret)
+		return ret;
+	ret = regmap_write(priv->map, QUAD8_DATA(id), prescaler);
+	if (ret)
+		return ret;
+	return regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | TRANSFER_PR0_TO_PSC);
 }
 
 static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
@@ -975,15 +1030,16 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->fck_prescaler[channel_id] = prescaler;
-	quad8_filter_clock_prescaler_set(priv, channel_id, prescaler);
+	ret = quad8_filter_clock_prescaler_set(priv, channel_id, prescaler);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static struct counter_comp quad8_signal_ext[] = {
@@ -1136,15 +1192,20 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
 	struct counter_device *counter = private;
 	struct quad8 *const priv = counter_priv(counter);
+	unsigned int status;
 	unsigned long irq_status;
 	unsigned long channel;
 	unsigned int flg_pins;
 	u8 event;
+	int ret;
 
-	irq_status = ioread8(&priv->reg->interrupt_status);
-	if (!irq_status)
+	ret = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
+	if (ret)
+		return ret;
+	if (!status)
 		return IRQ_NONE;
 
+	irq_status = status;
 	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
 		flg_pins = u8_get_bits(priv->ior[channel], FLG_PINS);
 		switch (flg_pins) {
@@ -1170,42 +1231,54 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 		counter_push_event(counter, event, channel);
 	}
 
-	/* Clear pending interrupts on device */
-	iowrite8(CLEAR_PENDING_INTERRUPTS, &priv->reg->channel_oper);
+	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
+	if (ret)
+		return ret;
 
 	return IRQ_HANDLED;
 }
 
-static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
+static int quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
-
-	quad8_filter_clock_prescaler_set(priv, channel, 0);
-	quad8_preset_register_set(priv, channel, 0);
-	quad8_flag_register_reset(priv, channel);
+	int ret;
+
+	ret = quad8_filter_clock_prescaler_set(priv, channel, 0);
+	if (ret)
+		return ret;
+	ret = quad8_preset_register_set(priv, channel, 0);
+	if (ret)
+		return ret;
+	ret = quad8_flag_register_reset(priv, channel);
+	if (ret)
+		return ret;
 
 	/* Binary encoding; Normal count; non-quadrature mode */
 	priv->cmr[channel] = SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
 			     u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
-	iowrite8(priv->cmr[channel], &chan->control);
+	ret = regmap_write(priv->map, QUAD8_CONTROL(channel), priv->cmr[channel]);
+	if (ret)
+		return ret;
 
 	/* Disable A and B inputs; preset on index; FLG1 as Carry */
 	priv->ior[channel] = SELECT_IOR | DISABLE_AB | u8_encode_bits(LOAD_CNTR, LOAD_PIN) |
 			     u8_encode_bits(FLG1_CARRY_FLG2_BORROW, FLG_PINS);
-	iowrite8(priv->ior[channel], &chan->control);
+	ret = regmap_write(priv->map, QUAD8_CONTROL(channel), priv->ior[channel]);
+	if (ret)
+		return ret;
 
 	/* Disable index function; negative index polarity */
 	priv->idr[channel] = SELECT_IDR | u8_encode_bits(DISABLE_INDEX_MODE, INDEX_MODE) |
 			     u8_encode_bits(NEGATIVE_INDEX_POLARITY, INDEX_POLARITY);
-	iowrite8(priv->idr[channel], &chan->control);
+	return regmap_write(priv->map, QUAD8_CONTROL(channel), priv->idr[channel]);
 }
 
 static int quad8_probe(struct device *dev, unsigned int id)
 {
 	struct counter_device *counter;
 	struct quad8 *priv;
+	void __iomem *regs;
 	unsigned long i;
-	int err;
+	int ret;
 
 	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -1218,10 +1291,15 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		return -ENOMEM;
 	priv = counter_priv(counter);
 
-	priv->reg = devm_ioport_map(dev, base[id], QUAD8_EXTENT);
-	if (!priv->reg)
+	regs = devm_ioport_map(dev, base[id], QUAD8_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
+	priv->map = devm_regmap_init_mmio(dev, regs, &quad8_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, PTR_ERR(priv->map),
+				     "Unable to initialize register map\n");
+
 	/* Initialize Counter device and driver data */
 	counter->name = dev_name(dev);
 	counter->parent = dev;
@@ -1234,25 +1312,38 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	spin_lock_init(&priv->lock);
 
 	/* Reset Index/Interrupt Register */
-	iowrite8(0x00, &priv->reg->index_interrupt);
+	ret = regmap_write(priv->map, QUAD8_INDEX_INTERRUPT, 0x00);
+	if (ret)
+		return ret;
 	/* Reset all counters and disable interrupt function */
-	iowrite8(RESET_COUNTERS | DISABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
+	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION,
+			   RESET_COUNTERS | DISABLE_INTERRUPT_FUNCTION);
+	if (ret)
+		return ret;
 	/* Set initial configuration for all counters */
-	for (i = 0; i < QUAD8_NUM_COUNTERS; i++)
-		quad8_init_counter(priv, i);
+	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
+		ret = quad8_init_counter(priv, i);
+		if (ret)
+			return ret;
+	}
 	/* Disable Differential Encoder Cable Status for all channels */
-	iowrite8(0xFF, &priv->reg->cable_status);
+	ret = regmap_write(priv->map, QUAD8_CABLE_STATUS, GENMASK(7, 0));
+	if (ret)
+		return ret;
 	/* Enable all counters and enable interrupt function */
-	iowrite8(ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
+	ret = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION,
+			   ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION);
+	if (ret)
+		return ret;
 
-	err = devm_request_irq(&counter->dev, irq[id], quad8_irq_handler,
+	ret = devm_request_irq(&counter->dev, irq[id], quad8_irq_handler,
 			       IRQF_SHARED, counter->name, counter);
-	if (err)
-		return err;
+	if (ret)
+		return ret;
 
-	err = devm_counter_add(dev, counter);
-	if (err < 0)
-		return dev_err_probe(dev, err, "Failed to add counter\n");
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add counter\n");
 
 	return 0;
 }
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index b5ba8fb02cf7..52e80c0b6168 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -16,6 +16,7 @@ config 104_QUAD_8
 	tristate "ACCES 104-QUAD-8 driver"
 	depends on (PC104 && X86) || COMPILE_TEST
 	select ISA_BUS_API
+	select REGMAP_MMIO
 	help
 	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
 	  encoder counter/interface device family (104-QUAD-8, 104-QUAD-4).
-- 
2.39.2

