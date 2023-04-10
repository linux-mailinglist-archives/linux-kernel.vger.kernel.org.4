Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E16DC79D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDJODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:03:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF8383D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:03:21 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54ee108142eso102786617b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681135401; x=1683727401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V95DP9oQOT/ru3FR+7sPw3hWtX5a9WM5WKMP5Z5HQgk=;
        b=QG8aoI3cxn2+rQ6lXz9f0ShKJC/LYDmeQrIBUdhPFcVAFav4oLddectwgWPghbyUvE
         I4OSq7kHStaTn90ZLdKN68impihQU/HcpDgFfqbWdWgxdm9wpi5P3QNqoEhThfcNpPEm
         yRIYOgaahLBmaMCrjLTUjQHVZ+0mL7aauu7uXD37rMQryWcSgaIvdzghugkIfLF8mOC6
         1wkhCyAaOh38GF8QwUd7XQfC2GMHk55kKR1wQZtM1hAbPDcZ/z2XE2i6k3VGRwN32ljZ
         A20TspbmK49Sp8IX5MDGOXQ07wcWoAvWzBxjouVnP/f0g8wu1ic/o09bvdeAsYldZEC7
         vrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135401; x=1683727401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V95DP9oQOT/ru3FR+7sPw3hWtX5a9WM5WKMP5Z5HQgk=;
        b=fs6KfyEp1RSQhOKTESaCcnU8MWSiVUikPnY+Ofua6KDWYGUC5vhnfwTBeIhLuO83E+
         q6xMqZG89Y/fsNX/gWMNAAr5Gsidr0J6VRimA7g/JqMNULfzJ2yJdcIbc0L9zTkKorrn
         bDq2a9UEUGJcRPaw3RTPttqccCeNP0+MllhaTEqt0cDVSUPL5+nCVGknI2mwqErUXGSq
         TgnE71v2cFasg78xFE4z5JFLAOpDAbqwOrmV7D15KiFgY8vryA1YlVfxT39/cO8HJfCw
         vVKZcp8x5x3mUPnTf/P1bcstFBpFRKfieCikIDFUhEWCopMXZMMtmbgZEDIOTcn7AkR1
         ApJg==
X-Gm-Message-State: AAQBX9cV3RDwsnAr3ZfGknkvLfzS2DH7qt/KlG7yR0eGiBc0RV9aep8t
        ifIyjPpGFdTY0xf9Ggsc/4U6tA==
X-Google-Smtp-Source: AKy350bax+jMZoYhLDfnnYovdtmVbqRR0TU96uuM5p4lVfV3oxq5WKUATdBKqNinvGP/kp//9anqbw==
X-Received: by 2002:a0d:e486:0:b0:549:27b8:8dee with SMTP id n128-20020a0de486000000b0054927b88deemr7783256ywe.50.1681135400646;
        Mon, 10 Apr 2023 07:03:20 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cm24-20020a05690c0c9800b00545a08184c8sm2821000ywb.88.2023.04.10.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:03:20 -0700 (PDT)
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
Subject: [PATCH v3 2/3] counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
Date:   Mon, 10 Apr 2023 10:03:12 -0400
Message-Id: <48071415aed43ecdd8595174191b0d906205a9e3.1681134558.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681134558.git.william.gray@linaro.org>
References: <cover.1681134558.git.william.gray@linaro.org>
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

The 104-quad-8 driver buffers the device configuration states
separately, however each device has only three control registers: CMR,
IOR, and IDR. Refactoring to buffer the states of these control
registers rather than each configuration separately results in succinct
code that more closely matches what is happening on the device.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3:
 - Add __always_inline attribute for quad8_control_register_update()
Changes in v2:
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()
 - Replace FIELD_MODIFY() with u8p_replace_bits()
 - Wrap up control register update in quad8_control_register_update()

 drivers/counter/104-quad-8.c | 288 +++++++++++++----------------------
 1 file changed, 105 insertions(+), 183 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index f07e4a9b946d..0188c9c4e4cb 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -68,32 +68,21 @@ struct quad8_reg {
 /**
  * struct quad8 - device private data structure
  * @lock:		lock to prevent clobbering device states during R/W ops
- * @counter:		instance of the counter_device
+ * @cmr:		array of Counter Mode Register states
+ * @ior:		array of Input / Output Control Register states
+ * @idr:		array of Index Control Register states
  * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
- * @count_mode:		array of count mode configurations
- * @quadrature_mode:	array of quadrature mode configurations
- * @quadrature_scale:	array of quadrature mode scale configurations
- * @ab_enable:		array of A and B inputs enable configurations
- * @preset_enable:	array of set_to_preset_on_index attribute configurations
- * @irq_trigger:	array of current IRQ trigger function configurations
- * @synchronous_mode:	array of index function synchronous mode configurations
- * @index_polarity:	array of index function polarity configurations
  * @cable_fault_enable:	differential encoder cable status enable configurations
  * @reg:		I/O address offset for the device registers
  */
 struct quad8 {
 	spinlock_t lock;
+	u8 cmr[QUAD8_NUM_COUNTERS];
+	u8 ior[QUAD8_NUM_COUNTERS];
+	u8 idr[QUAD8_NUM_COUNTERS];
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
-	unsigned int count_mode[QUAD8_NUM_COUNTERS];
-	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
-	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
-	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
-	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
-	unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
-	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
-	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
 	unsigned int cable_fault_enable;
 	struct quad8_reg __iomem *reg;
 };
@@ -102,6 +91,8 @@ struct quad8 {
 #define FLAG_E BIT(4)
 /* Up/Down flag */
 #define FLAG_UD BIT(5)
+/* Counting up */
+#define UP 0x1
 
 #define REGISTER_SELECTION GENMASK(6, 5)
 
@@ -183,8 +174,12 @@ struct quad8 {
 #define INDEX_POLARITY BIT(1)
 /* Disable Index mode */
 #define DISABLE_INDEX_MODE 0x0
+/* Enable Index mode */
+#define ENABLE_INDEX_MODE 0x1
 /* Negative Index Polarity */
 #define NEGATIVE_INDEX_POLARITY 0x0
+/* Positive Index Polarity */
+#define POSITIVE_INDEX_POLARITY 0x1
 
 /*
  * Channel Operation Register
@@ -205,6 +200,14 @@ struct quad8 {
 /* Each Counter is 24 bits wide */
 #define LS7267_CNTR_MAX GENMASK(23, 0)
 
+static __always_inline void quad8_control_register_update(struct quad8 *const priv, u8 *const buf,
+							  const size_t channel, const u8 val,
+							  const u8 field)
+{
+	u8p_replace_bits(&buf[channel], val, field);
+	iowrite8(buf[channel], &priv->reg->channel[channel].control);
+}
+
 static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
 			     enum counter_signal_level *level)
@@ -291,19 +294,17 @@ static const enum counter_function quad8_count_functions_list[] = {
 static int quad8_function_get(const struct quad8 *const priv, const size_t id,
 			      enum counter_function *const function)
 {
-	if (!priv->quadrature_mode[id]) {
+	switch (u8_get_bits(priv->cmr[id], QUADRATURE_MODE)) {
+	case NON_QUADRATURE:
 		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
 		return 0;
-	}
-
-	switch (priv->quadrature_scale[id]) {
-	case 0:
+	case QUADRATURE_X1:
 		*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
 		return 0;
-	case 1:
+	case QUADRATURE_X2:
 		*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
 		return 0;
-	case 2:
+	case QUADRATURE_X4:
 		*function = COUNTER_FUNCTION_QUADRATURE_X4;
 		return 0;
 	default:
@@ -335,59 +336,36 @@ static int quad8_function_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
-	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
-	unsigned int *const scale = priv->quadrature_scale + id;
-	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
-	u8 __iomem *const control = &priv->reg->channel[id].control;
 	unsigned long irqflags;
 	unsigned int mode_cfg;
-	unsigned int idr_cfg;
-
-	spin_lock_irqsave(&priv->lock, irqflags);
-
-	mode_cfg = u8_encode_bits(priv->count_mode[id], COUNT_MODE);
-	idr_cfg = u8_encode_bits(priv->index_polarity[id], INDEX_POLARITY);
+	bool synchronous_mode;
 
-	if (function == COUNTER_FUNCTION_PULSE_DIRECTION) {
-		*quadrature_mode = 0;
-
-		/* Quadrature scaling only available in quadrature mode */
-		*scale = 0;
-
-		mode_cfg |= u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
+	switch (function) {
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		mode_cfg = NON_QUADRATURE;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X1_A:
+		mode_cfg = QUADRATURE_X1;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_A:
+		mode_cfg = QUADRATURE_X2;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		mode_cfg = QUADRATURE_X4;
+		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
 
-		/* Synchronous function not supported in non-quadrature mode */
-		if (*synchronous_mode) {
-			*synchronous_mode = 0;
-			/* Disable synchronous function mode */
-			idr_cfg |= u8_encode_bits(*synchronous_mode, INDEX_MODE);
-			iowrite8(SELECT_IDR | idr_cfg, control);
-		}
-	} else {
-		*quadrature_mode = 1;
+	spin_lock_irqsave(&priv->lock, irqflags);
 
-		switch (function) {
-		case COUNTER_FUNCTION_QUADRATURE_X1_A:
-			*scale = 0;
-			mode_cfg |= u8_encode_bits(QUADRATURE_X1, QUADRATURE_MODE);
-			break;
-		case COUNTER_FUNCTION_QUADRATURE_X2_A:
-			*scale = 1;
-			mode_cfg |= u8_encode_bits(QUADRATURE_X2, QUADRATURE_MODE);
-			break;
-		case COUNTER_FUNCTION_QUADRATURE_X4:
-			*scale = 2;
-			mode_cfg |= u8_encode_bits(QUADRATURE_X4, QUADRATURE_MODE);
-			break;
-		default:
-			/* should never reach this path */
-			spin_unlock_irqrestore(&priv->lock, irqflags);
-			return -EINVAL;
-		}
-	}
+	/* Synchronous function not supported in non-quadrature mode */
+	synchronous_mode = u8_get_bits(priv->idr[id], INDEX_MODE) == ENABLE_INDEX_MODE;
+	if (synchronous_mode && mode_cfg == NON_QUADRATURE)
+		quad8_control_register_update(priv, priv->idr, id, DISABLE_INDEX_MODE, INDEX_MODE);
 
-	/* Load mode configuration to Counter Mode Register */
-	iowrite8(SELECT_CMR | mode_cfg, control);
+	quad8_control_register_update(priv, priv->cmr, id, mode_cfg, QUADRATURE_MODE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -399,15 +377,11 @@ static int quad8_direction_read(struct counter_device *counter,
 				enum counter_count_direction *direction)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	unsigned int ud_flag;
 	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
 	u8 flag;
 
 	flag = ioread8(flag_addr);
-	/* U/D flag: nonzero = up, zero = down */
-	ud_flag = u8_get_bits(flag, FLAG_UD);
-
-	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
+	*direction = (u8_get_bits(flag, FLAG_UD) == UP) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
 
 	return 0;
@@ -437,13 +411,13 @@ static int quad8_action_read(struct counter_device *counter,
 	const size_t signal_a_id = count->synapses[0].signal->id;
 	enum counter_count_direction direction;
 
+	/* Default action mode */
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
+
 	/* Handle Index signals */
 	if (synapse->signal->id >= 16) {
-		if (!priv->preset_enable[count->id])
+		if (u8_get_bits(priv->ior[count->id], LOAD_PIN) == LOAD_CNTR)
 			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
-		else
-			*action = COUNTER_SYNAPSE_ACTION_NONE;
-
 		return 0;
 	}
 
@@ -463,9 +437,6 @@ static int quad8_action_read(struct counter_device *counter,
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	/* Default action mode */
-	*action = COUNTER_SYNAPSE_ACTION_NONE;
-
 	/* Determine action mode based on current count function mode */
 	switch (function) {
 	case COUNTER_FUNCTION_PULSE_DIRECTION:
@@ -493,37 +464,29 @@ static int quad8_action_read(struct counter_device *counter,
 	}
 }
 
-enum {
-	QUAD8_EVENT_CARRY = FLG1_CARRY_FLG2_BORROW,
-	QUAD8_EVENT_COMPARE = FLG1_COMPARE_FLG2_BORROW,
-	QUAD8_EVENT_CARRY_BORROW = FLG1_CARRYBORROW_FLG2_UD,
-	QUAD8_EVENT_INDEX = FLG1_INDX_FLG2_E,
-};
-
 static int quad8_events_configure(struct counter_device *counter)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irq_enabled = 0;
 	unsigned long irqflags;
 	struct counter_event_node *event_node;
-	unsigned int next_irq_trigger;
-	unsigned long ior_cfg;
+	u8 flg_pins;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	list_for_each_entry(event_node, &counter->events_list, l) {
 		switch (event_node->event) {
 		case COUNTER_EVENT_OVERFLOW:
-			next_irq_trigger = QUAD8_EVENT_CARRY;
+			flg_pins = FLG1_CARRY_FLG2_BORROW;
 			break;
 		case COUNTER_EVENT_THRESHOLD:
-			next_irq_trigger = QUAD8_EVENT_COMPARE;
+			flg_pins = FLG1_COMPARE_FLG2_BORROW;
 			break;
 		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
-			next_irq_trigger = QUAD8_EVENT_CARRY_BORROW;
+			flg_pins = FLG1_CARRYBORROW_FLG2_UD;
 			break;
 		case COUNTER_EVENT_INDEX:
-			next_irq_trigger = QUAD8_EVENT_INDEX;
+			flg_pins = FLG1_INDX_FLG2_E;
 			break;
 		default:
 			/* should never reach this path */
@@ -535,18 +498,12 @@ static int quad8_events_configure(struct counter_device *counter)
 		irq_enabled |= BIT(event_node->channel);
 
 		/* Skip configuration if it is the same as previously set */
-		if (priv->irq_trigger[event_node->channel] == next_irq_trigger)
+		if (flg_pins == u8_get_bits(priv->ior[event_node->channel], FLG_PINS))
 			continue;
 
 		/* Save new IRQ function configuration */
-		priv->irq_trigger[event_node->channel] = next_irq_trigger;
-
-		/* Load configuration to I/O Control Register */
-		ior_cfg = u8_encode_bits(priv->ab_enable[event_node->channel], AB_GATE) |
-			  u8_encode_bits(priv->preset_enable[event_node->channel], LOAD_PIN) |
-			  u8_encode_bits(priv->irq_trigger[event_node->channel], FLG_PINS);
-		iowrite8(SELECT_IOR | ior_cfg,
-			 &priv->reg->channel[event_node->channel].control);
+		quad8_control_register_update(priv, priv->ior, event_node->channel, flg_pins,
+					      FLG_PINS);
 	}
 
 	iowrite8(irq_enabled, &priv->reg->index_interrupt);
@@ -602,7 +559,7 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
-	*index_polarity = priv->index_polarity[channel_id];
+	*index_polarity = u8_get_bits(priv->idr[channel_id], INDEX_POLARITY);
 
 	return 0;
 }
@@ -613,18 +570,11 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
-	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
 	unsigned long irqflags;
-	unsigned int idr_cfg = u8_encode_bits(index_polarity, INDEX_POLARITY);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= u8_encode_bits(priv->synchronous_mode[channel_id], INDEX_MODE);
-
-	priv->index_polarity[channel_id] = index_polarity;
-
-	/* Load Index Control configuration to Index Control Register */
-	iowrite8(SELECT_IDR | idr_cfg, control);
+	quad8_control_register_update(priv, priv->idr, channel_id, index_polarity, INDEX_POLARITY);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -642,7 +592,7 @@ static int quad8_polarity_read(struct counter_device *counter,
 	if (err)
 		return err;
 
-	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+	*polarity = (index_polarity == POSITIVE_INDEX_POLARITY) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
 		COUNTER_SIGNAL_POLARITY_NEGATIVE;
 
 	return 0;
@@ -652,7 +602,8 @@ static int quad8_polarity_write(struct counter_device *counter,
 				struct counter_signal *signal,
 				enum counter_signal_polarity polarity)
 {
-	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? POSITIVE_INDEX_POLARITY :
+									 NEGATIVE_INDEX_POLARITY;
 
 	return quad8_index_polarity_set(counter, signal, pol);
 }
@@ -669,7 +620,7 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
-	*synchronous_mode = priv->synchronous_mode[channel_id];
+	*synchronous_mode = u8_get_bits(priv->idr[channel_id], INDEX_MODE);
 
 	return 0;
 }
@@ -680,24 +631,19 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
-	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
+	u8 quadrature_mode;
 	unsigned long irqflags;
-	unsigned int idr_cfg = u8_encode_bits(synchronous_mode, INDEX_MODE);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= u8_encode_bits(priv->index_polarity[channel_id], INDEX_POLARITY);
-
 	/* Index function must be non-synchronous in non-quadrature mode */
-	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
+	quadrature_mode = u8_get_bits(priv->idr[channel_id], QUADRATURE_MODE);
+	if (synchronous_mode && quadrature_mode == NON_QUADRATURE) {
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
-	priv->synchronous_mode[channel_id] = synchronous_mode;
-
-	/* Load Index Control configuration to Index Control Register */
-	iowrite8(SELECT_IDR | idr_cfg, control);
+	quad8_control_register_update(priv, priv->idr, channel_id, synchronous_mode, INDEX_MODE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -719,7 +665,7 @@ static int quad8_count_mode_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	switch (priv->count_mode[count->id]) {
+	switch (u8_get_bits(priv->cmr[count->id], COUNT_MODE)) {
 	case NORMAL_COUNT:
 		*cnt_mode = COUNTER_COUNT_MODE_NORMAL;
 		break;
@@ -743,8 +689,6 @@ static int quad8_count_mode_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
-	unsigned int mode_cfg;
-	u8 __iomem *const control = &priv->reg->channel[count->id].control;
 	unsigned long irqflags;
 
 	switch (cnt_mode) {
@@ -767,19 +711,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	priv->count_mode[count->id] = count_mode;
-
-	/* Set count mode configuration value */
-	mode_cfg = u8_encode_bits(count_mode, COUNT_MODE);
-
-	/* Add quadrature mode configuration */
-	if (priv->quadrature_mode[count->id])
-		mode_cfg |= u8_encode_bits(priv->quadrature_scale[count->id] + 1, QUADRATURE_MODE);
-	else
-		mode_cfg |= u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
-
-	/* Load mode configuration to Counter Mode Register */
-	iowrite8(SELECT_CMR | mode_cfg, control);
+	quad8_control_register_update(priv, priv->cmr, count->id, count_mode, COUNT_MODE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -791,7 +723,7 @@ static int quad8_count_enable_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	*enable = priv->ab_enable[count->id];
+	*enable = u8_get_bits(priv->ior[count->id], AB_GATE);
 
 	return 0;
 }
@@ -800,20 +732,11 @@ static int quad8_count_enable_write(struct counter_device *counter,
 				    struct counter_count *count, u8 enable)
 {
 	struct quad8 *const priv = counter_priv(counter);
-	u8 __iomem *const control = &priv->reg->channel[count->id].control;
 	unsigned long irqflags;
-	unsigned int ior_cfg;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	priv->ab_enable[count->id] = enable;
-
-	ior_cfg = u8_encode_bits(enable, AB_GATE) |
-		  u8_encode_bits(priv->preset_enable[count->id], LOAD_PIN) |
-		  u8_encode_bits(priv->irq_trigger[count->id], FLG_PINS);
-
-	/* Load I/O control configuration */
-	iowrite8(SELECT_IOR | ior_cfg, control);
+	quad8_control_register_update(priv, priv->ior, count->id, enable, AB_GATE);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -890,7 +813,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
-	switch (priv->count_mode[count->id]) {
+	switch (u8_get_bits(priv->cmr[count->id], COUNT_MODE)) {
 	case RANGE_LIMIT:
 	case MODULO_N:
 		*ceiling = priv->preset[count->id];
@@ -917,7 +840,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
-	switch (priv->count_mode[count->id]) {
+	switch (u8_get_bits(priv->cmr[count->id], COUNT_MODE)) {
 	case RANGE_LIMIT:
 	case MODULO_N:
 		quad8_preset_register_set(priv, count->id, ceiling);
@@ -936,7 +859,8 @@ static int quad8_count_preset_enable_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	*preset_enable = !priv->preset_enable[count->id];
+	/* Preset enable is active low in Input/Output Control register */
+	*preset_enable = !u8_get_bits(priv->ior[count->id], LOAD_PIN);
 
 	return 0;
 }
@@ -946,23 +870,12 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 					   u8 preset_enable)
 {
 	struct quad8 *const priv = counter_priv(counter);
-	u8 __iomem *const control = &priv->reg->channel[count->id].control;
 	unsigned long irqflags;
-	unsigned int ior_cfg;
-
-	/* Preset enable is active low in Input/Output Control register */
-	preset_enable = !preset_enable;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	priv->preset_enable[count->id] = preset_enable;
-
-	ior_cfg = u8_encode_bits(priv->ab_enable[count->id], AB_GATE) |
-		  u8_encode_bits(preset_enable, LOAD_PIN) |
-		  u8_encode_bits(priv->irq_trigger[count->id], FLG_PINS);
-
-	/* Load I/O control configuration to Input / Output Control Register */
-	iowrite8(SELECT_IOR | ior_cfg, control);
+	/* Preset enable is active low in Input/Output Control register */
+	quad8_control_register_update(priv, priv->ior, count->id, !preset_enable, LOAD_PIN);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1224,6 +1137,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irq_status;
 	unsigned long channel;
+	unsigned int flg_pins;
 	u8 event;
 
 	irq_status = ioread8(&priv->reg->interrupt_status);
@@ -1231,23 +1145,24 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 		return IRQ_NONE;
 
 	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
-		switch (priv->irq_trigger[channel]) {
-		case QUAD8_EVENT_CARRY:
+		flg_pins = u8_get_bits(priv->ior[channel], FLG_PINS);
+		switch (flg_pins) {
+		case FLG1_CARRY_FLG2_BORROW:
 			event = COUNTER_EVENT_OVERFLOW;
 				break;
-		case QUAD8_EVENT_COMPARE:
+		case FLG1_COMPARE_FLG2_BORROW:
 			event = COUNTER_EVENT_THRESHOLD;
 				break;
-		case QUAD8_EVENT_CARRY_BORROW:
+		case FLG1_CARRYBORROW_FLG2_UD:
 			event = COUNTER_EVENT_OVERFLOW_UNDERFLOW;
 				break;
-		case QUAD8_EVENT_INDEX:
+		case FLG1_INDX_FLG2_E:
 			event = COUNTER_EVENT_INDEX;
 				break;
 		default:
 			/* should never reach this path */
 			WARN_ONCE(true, "invalid interrupt trigger function %u configured for channel %lu\n",
-				  priv->irq_trigger[channel], channel);
+				  flg_pins, channel);
 			continue;
 		}
 
@@ -1260,8 +1175,9 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static void quad8_init_counter(struct channel_reg __iomem *const chan)
+static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
+	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
 	unsigned long i;
 
 	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
@@ -1274,15 +1190,21 @@ static void quad8_init_counter(struct channel_reg __iomem *const chan)
 		iowrite8(0x00, &chan->data);
 	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
 	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+
 	/* Binary encoding; Normal count; non-quadrature mode */
-	iowrite8(SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
-		 u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE), &chan->control);
+	priv->cmr[channel] = SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
+			     u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
+	iowrite8(priv->cmr[channel], &chan->control);
+
 	/* Disable A and B inputs; preset on index; FLG1 as Carry */
-	iowrite8(SELECT_IOR | DISABLE_AB | u8_encode_bits(LOAD_CNTR, LOAD_PIN) |
-		 u8_encode_bits(FLG1_CARRY_FLG2_BORROW, FLG_PINS), &chan->control);
+	priv->ior[channel] = SELECT_IOR | DISABLE_AB | u8_encode_bits(LOAD_CNTR, LOAD_PIN) |
+			     u8_encode_bits(FLG1_CARRY_FLG2_BORROW, FLG_PINS);
+	iowrite8(priv->ior[channel], &chan->control);
+
 	/* Disable index function; negative index polarity */
-	iowrite8(SELECT_IDR | u8_encode_bits(DISABLE_INDEX_MODE, INDEX_MODE) |
-		 u8_encode_bits(NEGATIVE_INDEX_POLARITY, INDEX_POLARITY), &chan->control);
+	priv->idr[channel] = SELECT_IDR | u8_encode_bits(DISABLE_INDEX_MODE, INDEX_MODE) |
+			     u8_encode_bits(NEGATIVE_INDEX_POLARITY, INDEX_POLARITY);
+	iowrite8(priv->idr[channel], &chan->control);
 }
 
 static int quad8_probe(struct device *dev, unsigned int id)
@@ -1324,7 +1246,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	iowrite8(RESET_COUNTERS | DISABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
 	/* Set initial configuration for all counters */
 	for (i = 0; i < QUAD8_NUM_COUNTERS; i++)
-		quad8_init_counter(priv->reg->channel + i);
+		quad8_init_counter(priv, i);
 	/* Disable Differential Encoder Cable Status for all channels */
 	iowrite8(0xFF, &priv->reg->cable_status);
 	/* Enable all counters and enable interrupt function */
-- 
2.39.2

