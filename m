Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE5B6DC7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDJONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDJONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:13:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19E54C3E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:13:01 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54c12009c30so208235157b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681135981; x=1683727981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPhvUqIDFexLZWuM4h1MkmFYx3sEyt9Da5Z7A3k+GF8=;
        b=Y44KjVllcbmUeYLdtN/3HZFxktnaDWYEZfzyxYgu/XnO/yJq0FCdszjTgaKjK2LFwd
         kv3BoDeK20e3xt1vSDy2CyR61DdT7aaIeJxCCh0q69bT1ljzZsrL/GixvDq9QWxEDM2W
         /oChwlHQajF3SSBrc5pW+bSXW7lGXu3QO8wweftgiy23Y0yZr8/7ZyLaGN3oyysbgxIV
         bDdgpZayX1hIsMSSiYyzx3ZIdh1FSKgFfhA7Rt9rs65O7ds4ymbDvtdhG46sPnIUm/0J
         3fKw04qkqeNXvb7La+PjYYosneUREd2NLgTlItTwzwr9R8GMQMob/p0rprtwKDfbsfF4
         4xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135981; x=1683727981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPhvUqIDFexLZWuM4h1MkmFYx3sEyt9Da5Z7A3k+GF8=;
        b=gJujPkeDyKFqZTfk8/Qqtle3ASAuiSpgQ9to22W6QczU7a4r8OEPZ/2gmJg0Crknsi
         TnIZ1eUwRXqCWJmrHUOzEhewGUbb+vfop2qiHFEF4jQE14fXsuRFm2JUJRHvF2B43yiy
         j6/URUe/fM3ZrSvqi7NAgm6fBktsxtw64bVGGbk7wseJMoDMDII2Xsl7KY2tLyOJYjZs
         vnTksA0hpVhJgYxr6GzUeqgXRx+tnwi+YrMp9otcVod5hZjfgorowl4VlPYRtZ5geJYR
         mvsbZepBeoq1PXhPvCfuUVwuMlpSjPlqckBQkqrOtzyEREfoNXYia5ADGkaRGxQT25m2
         lJGw==
X-Gm-Message-State: AAQBX9fyxCfEWXJtnQjWQ1RXwYqqJdzUj6IS5Z9n7pHLKe5kokdIUmJa
        hSutTRlfuIcjDPWslObaw8G22A==
X-Google-Smtp-Source: AKy350YCXlP2CpJrOME2wgK3jzAsF4Zn6cGG85G1g+teEIOqCjY6xqjuw0rz+/K+7/20AKLIEnzlkA==
X-Received: by 2002:a81:6354:0:b0:541:90fc:6ee2 with SMTP id x81-20020a816354000000b0054190fc6ee2mr4863698ywb.25.1681135980953;
        Mon, 10 Apr 2023 07:13:00 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k19-20020a81ac13000000b00545b02d4af5sm2824580ywh.48.2023.04.10.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:13:00 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] counter: 104-quad-8: Migrate to the regmap API
Date:   Mon, 10 Apr 2023 10:12:52 -0400
Message-Id: <20230410141252.143998-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
This patch depends on the 104-quad-8 refactor series [0].

[0] https://lore.kernel.org/all/cover.1681134558.git.william.gray@linaro.org/

 drivers/counter/104-quad-8.c | 345 ++++++++++++++++++++++-------------
 drivers/counter/Kconfig      |   1 +
 2 files changed, 219 insertions(+), 127 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index c171d0a80ef9..3e9e70d8d5ca 100644
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
 
 #define QUAD8_EXTENT 32
 
@@ -35,56 +36,57 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
 
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
  * @lock:		lock to prevent clobbering device states during R/W ops
+ * @map:		regmap for the device
  * @cmr:		array of Counter Mode Register states
  * @ior:		array of Input / Output Control Register states
  * @idr:		array of Index Control Register states
  * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
  * @cable_fault_enable:	differential encoder cable status enable configurations
- * @reg:		I/O address offset for the device registers
  */
 struct quad8 {
 	spinlock_t lock;
+	struct regmap *map;
 	u8 cmr[QUAD8_NUM_COUNTERS];
 	u8 ior[QUAD8_NUM_COUNTERS];
 	u8 idr[QUAD8_NUM_COUNTERS];
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int cable_fault_enable;
-	struct quad8_reg __iomem *reg;
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
@@ -200,12 +202,12 @@ struct quad8 {
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
@@ -213,13 +215,15 @@ static int quad8_signal_read(struct counter_device *counter,
 			     enum counter_signal_level *level)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	unsigned int state;
+	int state;
 
 	/* Only Index signal levels can be read */
 	if (signal->id < 16)
 		return -EINVAL;
 
-	state = ioread8(&priv->reg->index_input_levels) & BIT(signal->id - 16);
+	state = regmap_test_bits(priv->map, QUAD8_INDEX_INPUT_LEVELS, BIT(signal->id - 16));
+	if (state < 0)
+		return state;
 
 	*level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
 
@@ -230,44 +234,52 @@ static int quad8_count_read(struct counter_device *counter,
 			    struct counter_count *count, u64 *val)
 {
 	struct quad8 *const priv = counter_priv(counter);
-	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
+	int ret;
 
 	*val = 0;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
-	ioread8_rep(&chan->data, val, 3);
+	ret = regmap_write(priv->map, QUAD8_CONTROL(count->id),
+			   SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL);
+	if (ret)
+		goto exit_unlock;
+	ret = regmap_noinc_read(priv->map, QUAD8_DATA(count->id), val, 3);
 
+exit_unlock:
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
-static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
-				      const unsigned long preset)
+static int quad8_preset_register_set(struct quad8 *const priv, const size_t id,
+				     const unsigned long preset)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+	int err;
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	iowrite8_rep(&chan->data, &preset, 3);
+	err = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BP);
+	if (err)
+		return err;
+	return regmap_noinc_write(priv->map, QUAD8_DATA(id), &preset, 3);
 }
 
-static void quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
+static int quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+	int err;
 
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	err = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BT_CT_CPT_S_IDX);
+	if (err)
+		return err;
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
@@ -275,17 +287,24 @@ static int quad8_count_write(struct counter_device *counter,
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
@@ -343,6 +362,7 @@ static int quad8_function_write(struct counter_device *counter,
 	unsigned long irqflags;
 	unsigned int mode_cfg;
 	bool synchronous_mode;
+	int ret;
 
 	switch (function) {
 	case COUNTER_FUNCTION_PULSE_DIRECTION:
@@ -366,14 +386,19 @@ static int quad8_function_write(struct counter_device *counter,
 
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
@@ -381,10 +406,12 @@ static int quad8_direction_read(struct counter_device *counter,
 				enum counter_count_direction *direction)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
-	u8 flag;
+	int err;
+	unsigned int flag;
 
-	flag = ioread8(flag_addr);
+	err = regmap_read(priv->map, QUAD8_CONTROL(count->id), &flag);
+	if (err)
+		return err;
 	*direction = (u8_get_bits(flag, FLAG_UD) == UP) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
 
@@ -475,6 +502,7 @@ static int quad8_events_configure(struct counter_device *counter)
 	unsigned long irqflags;
 	struct counter_event_node *event_node;
 	u8 flg_pins;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
@@ -494,8 +522,8 @@ static int quad8_events_configure(struct counter_device *counter)
 			break;
 		default:
 			/* should never reach this path */
-			spin_unlock_irqrestore(&priv->lock, irqflags);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto exit_unlock;
 		}
 
 		/* Enable IRQ line */
@@ -506,15 +534,18 @@ static int quad8_events_configure(struct counter_device *counter)
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
@@ -575,14 +606,16 @@ static int quad8_index_polarity_set(struct counter_device *counter,
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
@@ -637,21 +670,24 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
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
@@ -694,6 +730,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
 	unsigned long irqflags;
+	int ret;
 
 	switch (cnt_mode) {
 	case COUNTER_COUNT_MODE_NORMAL:
@@ -715,11 +752,12 @@ static int quad8_count_mode_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	quad8_control_register_update(priv, priv->cmr, count->id, count_mode, COUNT_MODE);
+	ret = quad8_control_register_update(priv->map, priv->cmr, count->id, count_mode,
+					    COUNT_MODE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_count_enable_read(struct counter_device *counter,
@@ -737,14 +775,15 @@ static int quad8_count_enable_write(struct counter_device *counter,
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
@@ -756,10 +795,12 @@ static int quad8_error_noise_get(struct counter_device *counter,
 				 struct counter_count *count, u32 *noise_error)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
-	u8 flag;
+	int err;
+	unsigned int flag;
 
-	flag = ioread8(flag_addr);
+	err = regmap_read(priv->map, QUAD8_CONTROL(count->id), &flag);
+	if (err)
+		return err;
 	*noise_error = u8_get_bits(flag, FLAG_E);
 
 	return 0;
@@ -780,6 +821,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
+	int ret;
 
 	if (preset > LS7267_CNTR_MAX)
 		return -ERANGE;
@@ -787,11 +829,11 @@ static int quad8_count_preset_write(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->preset[count->id] = preset;
-	quad8_preset_register_set(priv, count->id, preset);
+	ret = quad8_preset_register_set(priv, count->id, preset);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_count_ceiling_read(struct counter_device *counter,
@@ -823,6 +865,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
+	int ret;
 
 	if (ceiling > LS7267_CNTR_MAX)
 		return -ERANGE;
@@ -834,14 +877,16 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
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
@@ -862,15 +907,17 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
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
@@ -881,7 +928,7 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	bool disabled;
-	unsigned int status;
+	int status;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
@@ -892,13 +939,16 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	/* Logic 0 = cable fault */
-	status = ioread8(&priv->reg->cable_status);
+	status = regmap_test_bits(priv->map, QUAD8_CABLE_STATUS, BIT(channel_id));
+	if (status < 0) {
+		spin_unlock_irqrestore(&priv->lock, irqflags);
+		return status;
+	}
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	/* Mask respective channel and invert logic */
-	*cable_fault = !(status & BIT(channel_id));
+	/* Logic 0 = cable fault */
+	*cable_fault = !status;
 
 	return 0;
 }
@@ -923,6 +973,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 	const size_t channel_id = signal->id / 2;
 	unsigned long irqflags;
 	unsigned int cable_fault_enable;
+	int ret;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
@@ -934,11 +985,11 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 	/* Enable is active low in Differential Encoder Cable Status register */
 	cable_fault_enable = ~priv->cable_fault_enable;
 
-	iowrite8(cable_fault_enable, &priv->reg->cable_status);
+	ret = regmap_write(priv->map, QUAD8_CABLE_STATUS, cable_fault_enable);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return ret;
 }
 
 static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
@@ -952,14 +1003,18 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	return 0;
 }
 
-static void quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
-					     const u8 prescaler)
+static int quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
+					    const u8 prescaler)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+	int err;
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	iowrite8(prescaler, &chan->data);
-	iowrite8(SELECT_RLD | TRANSFER_PR0_TO_PSC, &chan->control);
+	err = regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | RESET_BP);
+	if (err)
+		return err;
+	err = regmap_write(priv->map, QUAD8_DATA(id), prescaler);
+	if (err)
+		return err;
+	return regmap_write(priv->map, QUAD8_CONTROL(id), SELECT_RLD | TRANSFER_PR0_TO_PSC);
 }
 
 static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
@@ -969,15 +1024,16 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
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
@@ -1130,15 +1186,20 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 {
 	struct counter_device *counter = private;
 	struct quad8 *const priv = counter_priv(counter);
+	int err;
+	unsigned int status;
 	unsigned long irq_status;
 	unsigned long channel;
 	unsigned int flg_pins;
 	u8 event;
 
-	irq_status = ioread8(&priv->reg->interrupt_status);
-	if (!irq_status)
+	err = regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
+	if (err)
+		return err;
+	if (!status)
 		return IRQ_NONE;
 
+	irq_status = status;
 	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
 		flg_pins = u8_get_bits(priv->ior[channel], FLG_PINS);
 		switch (flg_pins) {
@@ -1164,40 +1225,52 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 		counter_push_event(counter, event, channel);
 	}
 
-	/* Clear pending interrupts on device */
-	iowrite8(CLEAR_PENDING_INTERRUPTS, &priv->reg->channel_oper);
+	err = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_INTERRUPTS);
+	if (err)
+		return err;
 
 	return IRQ_HANDLED;
 }
 
-static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
+static int quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
-	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
+	int err;
 
-	quad8_filter_clock_prescaler_set(priv, channel, 0);
-	quad8_preset_register_set(priv, channel, 0);
-	quad8_flag_register_reset(priv, channel);
+	err = quad8_filter_clock_prescaler_set(priv, channel, 0);
+	if (err)
+		return err;
+	err = quad8_preset_register_set(priv, channel, 0);
+	if (err)
+		return err;
+	err = quad8_flag_register_reset(priv, channel);
+	if (err)
+		return err;
 
 	/* Binary encoding; Normal count; non-quadrature mode */
 	priv->cmr[channel] = SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
 			     u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
-	iowrite8(priv->cmr[channel], &chan->control);
+	err = regmap_write(priv->map, QUAD8_CONTROL(channel), priv->cmr[channel]);
+	if (err)
+		return err;
 
 	/* Disable A and B inputs; preset on index; FLG1 as Carry */
 	priv->ior[channel] = SELECT_IOR | DISABLE_AB | u8_encode_bits(LOAD_CNTR, LOAD_PIN) |
 			     u8_encode_bits(FLG1_CARRY_FLG2_BORROW, FLG_PINS);
-	iowrite8(priv->ior[channel], &chan->control);
+	err = regmap_write(priv->map, QUAD8_CONTROL(channel), priv->ior[channel]);
+	if (err)
+		return err;
 
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
 	int err;
 
@@ -1212,10 +1285,15 @@ static int quad8_probe(struct device *dev, unsigned int id)
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
@@ -1228,16 +1306,29 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	spin_lock_init(&priv->lock);
 
 	/* Reset Index/Interrupt Register */
-	iowrite8(0x00, &priv->reg->index_interrupt);
+	err = regmap_write(priv->map, QUAD8_INDEX_INTERRUPT, 0x00);
+	if (err)
+		return err;
 	/* Reset all counters and disable interrupt function */
-	iowrite8(RESET_COUNTERS | DISABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
+	err = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION,
+			   RESET_COUNTERS | DISABLE_INTERRUPT_FUNCTION);
+	if (err)
+		return err;
 	/* Set initial configuration for all counters */
-	for (i = 0; i < QUAD8_NUM_COUNTERS; i++)
-		quad8_init_counter(priv, i);
+	for (i = 0; i < QUAD8_NUM_COUNTERS; i++) {
+		err = quad8_init_counter(priv, i);
+		if (err)
+			return err;
+	}
 	/* Disable Differential Encoder Cable Status for all channels */
-	iowrite8(0xFF, &priv->reg->cable_status);
+	err = regmap_write(priv->map, QUAD8_CABLE_STATUS, GENMASK(7, 0));
+	if (err)
+		return err;
 	/* Enable all counters and enable interrupt function */
-	iowrite8(ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
+	err = regmap_write(priv->map, QUAD8_CHANNEL_OPERATION,
+			   ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION);
+	if (err)
+		return err;
 
 	err = devm_request_irq(&counter->dev, irq[id], quad8_irq_handler,
 			       IRQF_SHARED, counter->name, counter);
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

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
prerequisite-patch-id: 5e21ab4071e143908bcc7d55872964f822fc7176
prerequisite-patch-id: e1f91a1c2f9863f2ffbe31dbfceece48b8a6898c
prerequisite-patch-id: 9151845864e86341b1206e8c6bb98c9ed3c2694d
-- 
2.39.2

