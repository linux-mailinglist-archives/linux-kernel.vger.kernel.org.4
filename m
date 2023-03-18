Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1B6BFB17
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCRPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCRPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:00:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405EAC650
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id fy17so6069293qtb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679151606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WNK2qr4NtSUrjAdDswMM5zimvyS9Q/fEHBITpCtqFQ=;
        b=TmmnWKsPYGN656svxqg3mQUzWxR0l6o8RWv+n8X3IqOyonYd/1Y4DOPFqItpVrfjPC
         7Tpxjq8IbRbzdCNUr9Ek//R4irARou5ElELjOI2n9cxjZc7y976Fs+7AZD4SCfHXvqQ3
         ZGpZ/ulddBmdEhIoUq8j+K/5ahezz8VkixfX06ODRhBuCn2qfUA6kGhyTVOXmDWXmbY7
         BIOjUQO0kt5JFOHJhRsX4g/6gsL1exStQEN1Ktf7b00GzUoAD0cWY4oUkrlsI3Yvy+RB
         73fKq35whydhJyXOd0IIddYw+fE4uV1FXROV5UOxu1WrDLxDsddqxyfK6ds1nbh0diBo
         X53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WNK2qr4NtSUrjAdDswMM5zimvyS9Q/fEHBITpCtqFQ=;
        b=GwO65PFtsHOv7XE0pDUOD1/0T/Y1TKtwvFhj0dyeKXx1VXFGbYIdONXD2sVC5ts8yl
         TSaAIsn6emZxUf39dxQ4U6iOcHEotxDLLfAkAuOfy9KOdT861ZF+b6P0tLZz6tGvHasX
         lEwhTSqdX/frsLZE1I6qy9i2APipK20F0ppqyse4fjy6CrEz60AuaGweRVQoZPPW+FRc
         dP25L8kQ8Ko4dFWbWPYklbeLeSw0TerFvT7DmIjPGKjsVxDsVl39RJZOEsZUF6nBunhp
         4P13kZGrY8ZPu2vX+9/lvfMwK7Mv9Ho7KFvuloxoy1UwKtAzT1yzT3x2xHdjXbExoti+
         YhSA==
X-Gm-Message-State: AO0yUKXGfM34+4b5o3ACLihEM8nww3nVEsEiPU7w4vCBs1X/fg6vzpCk
        YSSpAFu3br99YJCCcHTz6SVpEA==
X-Google-Smtp-Source: AK7set9FbYD24wW5vz7ACHUGQukbFdImreyrtwLVt9DqelfGeYKlSqNOT/fp6T/JIX2QSRbiE/VRyA==
X-Received: by 2002:ac8:5bc3:0:b0:3d6:9528:a0e7 with SMTP id b3-20020ac85bc3000000b003d69528a0e7mr17729940qtb.66.1679151605742;
        Sat, 18 Mar 2023 08:00:05 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f67-20020a37d246000000b00745daadd210sm3709162qkj.71.2023.03.18.08.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:00:05 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 3/4] counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
Date:   Sat, 18 Mar 2023 10:59:50 -0400
Message-Id: <27359bb20eed0e54f1470cd32be0fd10b06c40fe.1679149543.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679149542.git.william.gray@linaro.org>
References: <cover.1679149542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-quad-8 driver buffers the device configuration states
separately, however each device has only three control registers: CMR,
IOR, and IDR. Refactoring to buffer the states of these control
registers rather than each configuration separately results in more
succinct code that more closely matches what is happening on the device.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 290 ++++++++++++++---------------------
 1 file changed, 113 insertions(+), 177 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index be7b04b52d85..796f02fc53b8 100644
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
+	unsigned long cmr[QUAD8_NUM_COUNTERS];
+	unsigned long ior[QUAD8_NUM_COUNTERS];
+	unsigned long idr[QUAD8_NUM_COUNTERS];
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
 
@@ -142,7 +133,6 @@ struct quad8 {
 #define BINARY FIELD_PREP(COUNT_ENCODING, 0x0)
 /* Normal count */
 #define NORMAL_COUNT 0x0
-#define CMR_NORMAL_COUNT FIELD_PREP(COUNT_MODE, NORMAL_COUNT)
 /* Range Limit */
 #define RANGE_LIMIT 0x1
 /* Non-recycle count */
@@ -150,13 +140,13 @@ struct quad8 {
 /* Modulo-N */
 #define MODULO_N 0x3
 /* Non-quadrature */
-#define NON_QUADRATURE FIELD_PREP(QUADRATURE_MODE, 0x0)
+#define NON_QUADRATURE 0x0
 /* Quadrature X1 */
-#define QUADRATURE_X1 FIELD_PREP(QUADRATURE_MODE, 0x1)
+#define QUADRATURE_X1 0x1
 /* Quadrature X2 */
-#define QUADRATURE_X2 FIELD_PREP(QUADRATURE_MODE, 0x2)
+#define QUADRATURE_X2 0x2
 /* Quadrature X4 */
-#define QUADRATURE_X4 FIELD_PREP(QUADRATURE_MODE, 0x3)
+#define QUADRATURE_X4 0x3
 
 /*
  * Input/Output Control Register
@@ -167,10 +157,9 @@ struct quad8 {
 /* Disable inputs A and B */
 #define DISABLE_AB FIELD_PREP(AB_GATE, 0x0)
 /* Load Counter input */
-#define LOAD_CNTR FIELD_PREP(LOAD_PIN, 0x0)
+#define LOAD_CNTR 0x0
 /* FLG1 = CARRY(active low); FLG2 = BORROW(active low) */
 #define FLG1_CARRY_FLG2_BORROW 0x0
-#define IOR_FLG1_CARRY_FLG2_BORROW FIELD_PREP(FLG_PINS, FLG1_CARRY_FLG2_BORROW)
 /* FLG1 = COMPARE(active low); FLG2 = BORROW(active low) */
 #define FLG1_COMPARE_FLG2_BORROW 0x1
 /* FLG1 = Carry(active low)/Borrow(active low); FLG2 = U/D(active low) flag */
@@ -184,9 +173,13 @@ struct quad8 {
 #define INDEX_MODE BIT(0)
 #define INDEX_POLARITY BIT(1)
 /* Disable Index mode */
-#define DISABLE_INDEX_MODE FIELD_PREP(INDEX_MODE, 0x0)
+#define DISABLE_INDEX_MODE 0x0
+/* Enable Index mode */
+#define ENABLE_INDEX_MODE 0x1
 /* Negative Index Polarity */
-#define NEGATIVE_INDEX_POLARITY FIELD_PREP(INDEX_POLARITY, 0x0)
+#define NEGATIVE_INDEX_POLARITY 0x0
+/* Positive Index Polarity */
+#define POSITIVE_INDEX_POLARITY 0x1
 
 /*
  * Channel Operation Register
@@ -299,19 +292,17 @@ static const enum counter_function quad8_count_functions_list[] = {
 static int quad8_function_get(const struct quad8 *const priv, const size_t id,
 			      enum counter_function *const function)
 {
-	if (!priv->quadrature_mode[id]) {
+	switch (FIELD_GET(QUADRATURE_MODE, priv->cmr[id])) {
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
@@ -343,59 +334,42 @@ static int quad8_function_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const int id = count->id;
-	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
-	unsigned int *const scale = priv->quadrature_scale + id;
-	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
 	u8 __iomem *const control = &priv->reg->channel[id].control;
+	unsigned long *const idr = &priv->idr[id];
+	unsigned long *const cmr = &priv->cmr[id];
 	unsigned long irqflags;
 	unsigned int mode_cfg;
-	unsigned int idr_cfg;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	mode_cfg = FIELD_PREP(COUNT_MODE, priv->count_mode[id]);
-	idr_cfg = FIELD_PREP(INDEX_POLARITY, priv->index_polarity[id]);
-
-	if (function == COUNTER_FUNCTION_PULSE_DIRECTION) {
-		*quadrature_mode = 0;
-
-		/* Quadrature scaling only available in quadrature mode */
-		*scale = 0;
-
-		mode_cfg |= NON_QUADRATURE;
+	switch (function) {
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		mode_cfg = NON_QUADRATURE;
 
 		/* Synchronous function not supported in non-quadrature mode */
-		if (*synchronous_mode) {
+		if (FIELD_GET(INDEX_MODE, *idr) == ENABLE_INDEX_MODE) {
 			/* Disable synchronous function mode */
-			*synchronous_mode = 0;
-			idr_cfg |= FIELD_PREP(INDEX_MODE, *synchronous_mode);
-			iowrite8(SELECT_IDR | idr_cfg, control);
-		}
-	} else {
-		*quadrature_mode = 1;
-
-		switch (function) {
-		case COUNTER_FUNCTION_QUADRATURE_X1_A:
-			*scale = 0;
-			mode_cfg |= QUADRATURE_X1;
-			break;
-		case COUNTER_FUNCTION_QUADRATURE_X2_A:
-			*scale = 1;
-			mode_cfg |= QUADRATURE_X2;
-			break;
-		case COUNTER_FUNCTION_QUADRATURE_X4:
-			*scale = 2;
-			mode_cfg |= QUADRATURE_X4;
-			break;
-		default:
-			/* should never reach this path */
-			spin_unlock_irqrestore(&priv->lock, irqflags);
-			return -EINVAL;
+			*idr = FIELD_MODIFY(INDEX_MODE, *idr, DISABLE_INDEX_MODE);
+			iowrite8(*idr, control);
 		}
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
+		spin_unlock_irqrestore(&priv->lock, irqflags);
+		return -EINVAL;
 	}
 
-	/* Load mode configuration to Counter Mode Register */
-	iowrite8(SELECT_CMR | mode_cfg, control);
+	*cmr = FIELD_MODIFY(QUADRATURE_MODE, *cmr, mode_cfg);
+	iowrite8(*cmr, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -407,15 +381,11 @@ static int quad8_direction_read(struct counter_device *counter,
 				enum counter_count_direction *direction)
 {
 	const struct quad8 *const priv = counter_priv(counter);
-	unsigned int ud_flag;
 	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
 	unsigned long flag;
 
 	flag = ioread8(flag_addr);
-	/* U/D flag: nonzero = up, zero = down */
-	ud_flag = FIELD_GET(FLAG_UD, flag);
-
-	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
+	*direction = (FIELD_GET(FLAG_UD, flag) == UP) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
 
 	return 0;
@@ -447,7 +417,7 @@ static int quad8_action_read(struct counter_device *counter,
 
 	/* Handle Index signals */
 	if (synapse->signal->id >= 16) {
-		if (!priv->preset_enable[count->id])
+		if (FIELD_GET(LOAD_PIN, priv->ior[count->id]) == LOAD_CNTR)
 			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 		else
 			*action = COUNTER_SYNAPSE_ACTION_NONE;
@@ -501,37 +471,30 @@ static int quad8_action_read(struct counter_device *counter,
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
+	unsigned long flg_pins;
+	unsigned long *ior;
 
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
@@ -542,22 +505,15 @@ static int quad8_events_configure(struct counter_device *counter)
 		/* Enable IRQ line */
 		irq_enabled |= BIT(event_node->channel);
 
+		ior = &priv->ior[event_node->channel];
+
 		/* Skip configuration if it is the same as previously set */
-		if (priv->irq_trigger[event_node->channel] == next_irq_trigger)
+		if (flg_pins == FIELD_GET(FLG_PINS, *ior))
 			continue;
 
 		/* Save new IRQ function configuration */
-		priv->irq_trigger[event_node->channel] = next_irq_trigger;
-
-		/* Load configuration to I/O Control Register */
-		ior_cfg = FIELD_PREP(AB_GATE,
-				     priv->ab_enable[event_node->channel]) |
-			  FIELD_PREP(LOAD_PIN,
-				     priv->preset_enable[event_node->channel]) |
-			  FIELD_PREP(FLG_PINS,
-				     priv->irq_trigger[event_node->channel]);
-		iowrite8(SELECT_IOR | ior_cfg,
-			 &priv->reg->channel[event_node->channel].control);
+		*ior = FIELD_MODIFY(FLG_PINS, *ior, flg_pins);
+		iowrite8(*ior, &priv->reg->channel[event_node->channel].control);
 	}
 
 	iowrite8(irq_enabled, &priv->reg->index_interrupt);
@@ -613,7 +569,7 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
-	*index_polarity = priv->index_polarity[channel_id];
+	*index_polarity = FIELD_GET(INDEX_POLARITY, priv->idr[channel_id]);
 
 	return 0;
 }
@@ -625,17 +581,13 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
+	unsigned long *const idr = &priv->idr[channel_id];
 	unsigned long irqflags;
-	unsigned int idr_cfg = FIELD_PREP(INDEX_POLARITY, index_polarity);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= FIELD_PREP(INDEX_MODE, priv->synchronous_mode[channel_id]);
-
-	priv->index_polarity[channel_id] = index_polarity;
-
-	/* Load Index Control configuration to Index Control Register */
-	iowrite8(SELECT_IDR | idr_cfg, control);
+	*idr = FIELD_MODIFY(INDEX_POLARITY, *idr, index_polarity);
+	iowrite8(*idr, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -653,8 +605,8 @@ static int quad8_polarity_read(struct counter_device *counter,
 	if (err)
 		return err;
 
-	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
-		COUNTER_SIGNAL_POLARITY_NEGATIVE;
+	*polarity = (index_polarity == POSITIVE_INDEX_POLARITY) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+								  COUNTER_SIGNAL_POLARITY_NEGATIVE;
 
 	return 0;
 }
@@ -663,7 +615,8 @@ static int quad8_polarity_write(struct counter_device *counter,
 				struct counter_signal *signal,
 				enum counter_signal_polarity polarity)
 {
-	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ?
+			POSITIVE_INDEX_POLARITY : NEGATIVE_INDEX_POLARITY;
 
 	return quad8_index_polarity_set(counter, signal, pol);
 }
@@ -680,7 +633,7 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 	const struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 
-	*synchronous_mode = priv->synchronous_mode[channel_id];
+	*synchronous_mode = FIELD_GET(INDEX_MODE, priv->idr[channel_id]);
 
 	return 0;
 }
@@ -692,23 +645,19 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id - 16;
 	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
+	unsigned long *const idr = &priv->idr[channel_id];
 	unsigned long irqflags;
-	unsigned int idr_cfg = FIELD_PREP(INDEX_MODE, synchronous_mode);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= FIELD_PREP(INDEX_POLARITY, priv->index_polarity[channel_id]);
-
 	/* Index function must be non-synchronous in non-quadrature mode */
-	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
+	if (synchronous_mode && FIELD_GET(QUADRATURE_MODE, *idr) == NON_QUADRATURE) {
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
-	priv->synchronous_mode[channel_id] = synchronous_mode;
-
-	/* Load Index Control configuration to Index Control Register */
-	iowrite8(SELECT_IDR | idr_cfg, control);
+	*idr = FIELD_MODIFY(INDEX_MODE, *idr, synchronous_mode);
+	iowrite8(*idr, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -730,7 +679,7 @@ static int quad8_count_mode_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	switch (priv->count_mode[count->id]) {
+	switch (FIELD_GET(COUNT_MODE, priv->cmr[count->id])) {
 	case NORMAL_COUNT:
 		*cnt_mode = COUNTER_COUNT_MODE_NORMAL;
 		break;
@@ -754,8 +703,8 @@ static int quad8_count_mode_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned int count_mode;
-	unsigned int mode_cfg;
 	u8 __iomem *const control = &priv->reg->channel[count->id].control;
+	unsigned long *const cmr = &priv->cmr[count->id];
 	unsigned long irqflags;
 
 	switch (cnt_mode) {
@@ -778,20 +727,8 @@ static int quad8_count_mode_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	priv->count_mode[count->id] = count_mode;
-
-	/* Set count mode configuration value */
-	mode_cfg = FIELD_PREP(COUNT_MODE, count_mode);
-
-	/* Add quadrature mode configuration */
-	if (priv->quadrature_mode[count->id])
-		mode_cfg |= FIELD_PREP(QUADRATURE_MODE,
-				       priv->quadrature_scale[count->id] + 1);
-	else
-		mode_cfg |= NON_QUADRATURE;
-
-	/* Load mode configuration to Counter Mode Register */
-	iowrite8(SELECT_CMR | mode_cfg, control);
+	*cmr = FIELD_MODIFY(COUNT_MODE, *cmr, count_mode);
+	iowrite8(*cmr, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -803,7 +740,7 @@ static int quad8_count_enable_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	*enable = priv->ab_enable[count->id];
+	*enable = FIELD_GET(AB_GATE, priv->ior[count->id]);
 
 	return 0;
 }
@@ -813,19 +750,13 @@ static int quad8_count_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	u8 __iomem *const control = &priv->reg->channel[count->id].control;
+	unsigned long *const ior = &priv->ior[count->id];
 	unsigned long irqflags;
-	unsigned int ior_cfg;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	priv->ab_enable[count->id] = enable;
-
-	ior_cfg = FIELD_PREP(AB_GATE, enable) |
-		  FIELD_PREP(LOAD_PIN, priv->preset_enable[count->id]) |
-		  FIELD_PREP(FLG_PINS, priv->irq_trigger[count->id]);
-
-	/* Load I/O control configuration */
-	iowrite8(SELECT_IOR | ior_cfg, control);
+	*ior = FIELD_MODIFY(AB_GATE, *ior, enable);
+	iowrite8(*ior, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -903,7 +834,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
-	switch (priv->count_mode[count->id]) {
+	switch (FIELD_GET(COUNT_MODE, priv->cmr[count->id])) {
 	case RANGE_LIMIT:
 	case MODULO_N:
 		*ceiling = priv->preset[count->id];
@@ -930,7 +861,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
-	switch (priv->count_mode[count->id]) {
+	switch (FIELD_GET(COUNT_MODE, priv->cmr[count->id])) {
 	case RANGE_LIMIT:
 	case MODULO_N:
 		quad8_preset_register_set(priv, count->id, ceiling);
@@ -949,7 +880,8 @@ static int quad8_count_preset_enable_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	*preset_enable = !priv->preset_enable[count->id];
+	/* Preset enable is active low in Input/Output Control register */
+	*preset_enable = !FIELD_GET(LOAD_PIN, priv->ior[count->id]);
 
 	return 0;
 }
@@ -960,22 +892,14 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	u8 __iomem *const control = &priv->reg->channel[count->id].control;
+	unsigned long *const ior = &priv->ior[count->id];
 	unsigned long irqflags;
-	unsigned int ior_cfg;
-
-	/* Preset enable is active low in Input/Output Control register */
-	preset_enable = !preset_enable;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	priv->preset_enable[count->id] = preset_enable;
-
-	ior_cfg = FIELD_PREP(AB_GATE, priv->ab_enable[count->id]) |
-		  FIELD_PREP(LOAD_PIN, preset_enable) |
-		  FIELD_PREP(FLG_PINS, priv->irq_trigger[count->id]);
-
-	/* Load I/O control configuration to Input / Output Control Register */
-	iowrite8(SELECT_IOR | ior_cfg, control);
+	/* Preset enable is active low in Input/Output Control register */
+	*ior = FIELD_MODIFY(LOAD_PIN, *ior, !preset_enable);
+	iowrite8(*ior, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1238,6 +1162,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irq_status;
 	unsigned long channel;
+	unsigned int flg_pins;
 	u8 event;
 
 	irq_status = ioread8(&priv->reg->interrupt_status);
@@ -1245,23 +1170,24 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 		return IRQ_NONE;
 
 	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
-		switch (priv->irq_trigger[channel]) {
-		case QUAD8_EVENT_CARRY:
+		flg_pins = FIELD_GET(FLG_PINS, priv->ior[channel]);
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
 
@@ -1274,8 +1200,9 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static void quad8_init_counter(struct channel_reg __iomem *const chan)
+static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
+	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
 	unsigned long i;
 
 	/* Reset Byte Pointer */
@@ -1292,12 +1219,21 @@ static void quad8_init_counter(struct channel_reg __iomem *const chan)
 	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
 	/* Reset Error flag */
 	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+
 	/* Binary encoding; Normal count; non-quadrature mode */
-	iowrite8(SELECT_CMR | BINARY | CMR_NORMAL_COUNT | NON_QUADRATURE, &chan->control);
+	priv->cmr[channel] = SELECT_CMR | BINARY | FIELD_PREP(COUNT_MODE, NORMAL_COUNT) |
+			     FIELD_PREP(QUADRATURE_MODE, NON_QUADRATURE);
+	iowrite8(priv->cmr[channel], &chan->control);
+
 	/* Disable A and B inputs; preset on index; FLG1 as Carry */
-	iowrite8(SELECT_IOR | DISABLE_AB | LOAD_CNTR | IOR_FLG1_CARRY_FLG2_BORROW, &chan->control);
+	priv->ior[channel] = SELECT_IOR | DISABLE_AB | FIELD_PREP(LOAD_PIN, LOAD_CNTR) |
+			     FIELD_PREP(FLG_PINS, FLG1_CARRY_FLG2_BORROW);
+	iowrite8(priv->ior[channel], &chan->control);
+
 	/* Disable index function; negative index polarity */
-	iowrite8(SELECT_IDR | DISABLE_INDEX_MODE | NEGATIVE_INDEX_POLARITY, &chan->control);
+	priv->idr[channel] = SELECT_IDR | FIELD_PREP(INDEX_MODE, DISABLE_INDEX_MODE) |
+			     FIELD_PREP(INDEX_POLARITY, NEGATIVE_INDEX_POLARITY);
+	iowrite8(priv->idr[channel], &chan->control);
 }
 
 static int quad8_probe(struct device *dev, unsigned int id)
@@ -1339,7 +1275,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
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

