Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4FF6E512E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDQTvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDQTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:51:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04346A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:06 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o11so8296315ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681761065; x=1684353065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlSrap1bzXBmwnplUgP8mtHdzj46PthZOVye53HSV2c=;
        b=AGKunyIPlr3hYKgg6D1FDqrpfk4MC2Ud7ir6bvEJGrMOtrDvDI9+YCDquhVglyU8kv
         yVEs/X6/r8ELCvb5+TqRrfrtBEqhZGVp5mDXarpDLn4cO1wJzU4bHe/N3DYTfC3T+yiJ
         o/VT331GSKj7DU2PAM838NXPexmtK7D73DqLHQvW4E4haHveaZ34eyVH07ukRHP1T7wL
         +s5ABL+6DjqEMR4HDXHJHCUB7JWYOivPdQIpfZz74IE/Vy5dn41c4j28hpJY7HqHizs4
         PokymNnAe7d+XtqkmlGreGMhMLr2FyEKwu/cO57x2ON2e3Dk5gWEiSv/ssKsMuhmQHAz
         zDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761065; x=1684353065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlSrap1bzXBmwnplUgP8mtHdzj46PthZOVye53HSV2c=;
        b=ZDR1ggVNS7xblSwtjy+YfwVQKsqqnpmv0IJg3ODm9Knxf8yZodIjk3J8e9OI25ZcVa
         CWBjZhxpRTLneDJzLqK53y83r/DYZNiBhatp04TPQGdDxGUq/1TFG3uByswV/pzV7rIP
         e5Wryl/7xddsBd3dBaFE4WENvgTgwEkdlS7/z+cQMe5kT9C3fwj6QZyF8xX4Dq/Ke4T+
         qqs+ZvkFHPlfdFUO37beicJj30TLzmIn4gyafMY6D1x7aTpDutkY7x+Jdj4fl2kIS0Dw
         VUeapXuFDjs3sKjz7CEvuGZYePxWnKcusfYbVeynAZv4m6wRROWvXk+lysLjMNuRnC2K
         9Jew==
X-Gm-Message-State: AAQBX9dQgkCzzvMfkaJwRsO6OlX6rH1tZbokIAfxTKTTf3vRS//xTpVG
        YAllLTg8O2lJOuCqIsuD8NBhfw==
X-Google-Smtp-Source: AKy350bBAQVoIc4Xg9dbSJy8cO2o3CkeRJYQGBttWGg262oWNzW4mOgdOeNjq+iiXzyyZx+wYXChqQ==
X-Received: by 2002:a25:680c:0:b0:b7e:518e:bdad with SMTP id d12-20020a25680c000000b00b7e518ebdadmr15167420ybc.6.1681761065145;
        Mon, 17 Apr 2023 12:51:05 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u125-20020a817983000000b005463f6ae720sm3293158ywc.68.2023.04.17.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:51:04 -0700 (PDT)
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
Subject: [PATCH v4 1/4] counter: 104-quad-8: Utilize bitfield access macros
Date:   Mon, 17 Apr 2023 15:50:47 -0400
Message-Id: <7cea5ad049c75d8d1c6f25e288aa743a8d2a25d8.1681753140.git.william.gray@linaro.org>
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

The 104-QUAD-8 features several registers with various bitfields.
Utilize bitfield access macros such as u8_get_bits() and
u8_encode_bits() to make the code easier to read and the intent clearer.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4: none
Changes in v3: none
Changes in v2:
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()

 drivers/counter/104-quad-8.c | 274 ++++++++++++++++++++++-------------
 1 file changed, 172 insertions(+), 102 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index d9cb937665cf..f07e4a9b946d 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -5,7 +5,8 @@
  *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
-#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/counter.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -98,36 +99,108 @@ struct quad8 {
 };
 
 /* Error flag */
-#define QUAD8_FLAG_E BIT(4)
+#define FLAG_E BIT(4)
 /* Up/Down flag */
-#define QUAD8_FLAG_UD BIT(5)
+#define FLAG_UD BIT(5)
+
+#define REGISTER_SELECTION GENMASK(6, 5)
+
 /* Reset and Load Signal Decoders */
-#define QUAD8_CTR_RLD 0x00
+#define SELECT_RLD u8_encode_bits(0x0, REGISTER_SELECTION)
 /* Counter Mode Register */
-#define QUAD8_CTR_CMR 0x20
+#define SELECT_CMR u8_encode_bits(0x1, REGISTER_SELECTION)
 /* Input / Output Control Register */
-#define QUAD8_CTR_IOR 0x40
+#define SELECT_IOR u8_encode_bits(0x2, REGISTER_SELECTION)
 /* Index Control Register */
-#define QUAD8_CTR_IDR 0x60
+#define SELECT_IDR u8_encode_bits(0x3, REGISTER_SELECTION)
+
+/*
+ * Reset and Load Signal Decoders
+ */
+#define RESETS GENMASK(2, 1)
+#define LOADS GENMASK(4, 3)
 /* Reset Byte Pointer (three byte data pointer) */
-#define QUAD8_RLD_RESET_BP 0x01
-/* Reset Counter */
-#define QUAD8_RLD_RESET_CNTR 0x02
-/* Reset Borrow Toggle, Carry Toggle, Compare Toggle, and Sign flags */
-#define QUAD8_RLD_RESET_FLAGS 0x04
+#define RESET_BP BIT(0)
+/* Reset Borrow Toggle, Carry toggle, Compare toggle, Sign, and Index flags */
+#define RESET_BT_CT_CPT_S_IDX u8_encode_bits(0x2, RESETS)
 /* Reset Error flag */
-#define QUAD8_RLD_RESET_E 0x06
+#define RESET_E u8_encode_bits(0x3, RESETS)
 /* Preset Register to Counter */
-#define QUAD8_RLD_PRESET_CNTR 0x08
+#define TRANSFER_PR_TO_CNTR u8_encode_bits(0x1, LOADS)
 /* Transfer Counter to Output Latch */
-#define QUAD8_RLD_CNTR_OUT 0x10
+#define TRANSFER_CNTR_TO_OL u8_encode_bits(0x2, LOADS)
 /* Transfer Preset Register LSB to FCK Prescaler */
-#define QUAD8_RLD_PRESET_PSC 0x18
-#define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
-#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
-#define QUAD8_CMR_QUADRATURE_X1 0x08
-#define QUAD8_CMR_QUADRATURE_X2 0x10
-#define QUAD8_CMR_QUADRATURE_X4 0x18
+#define TRANSFER_PR0_TO_PSC u8_encode_bits(0x3, LOADS)
+
+/*
+ * Counter Mode Registers
+ */
+#define COUNT_ENCODING BIT(0)
+#define COUNT_MODE GENMASK(2, 1)
+#define QUADRATURE_MODE GENMASK(4, 3)
+/* Binary count */
+#define BINARY u8_encode_bits(0x0, COUNT_ENCODING)
+/* Normal count */
+#define NORMAL_COUNT 0x0
+/* Range Limit */
+#define RANGE_LIMIT 0x1
+/* Non-recycle count */
+#define NON_RECYCLE_COUNT 0x2
+/* Modulo-N */
+#define MODULO_N 0x3
+/* Non-quadrature */
+#define NON_QUADRATURE 0x0
+/* Quadrature X1 */
+#define QUADRATURE_X1 0x1
+/* Quadrature X2 */
+#define QUADRATURE_X2 0x2
+/* Quadrature X4 */
+#define QUADRATURE_X4 0x3
+
+/*
+ * Input/Output Control Register
+ */
+#define AB_GATE BIT(0)
+#define LOAD_PIN BIT(1)
+#define FLG_PINS GENMASK(4, 3)
+/* Disable inputs A and B */
+#define DISABLE_AB u8_encode_bits(0x0, AB_GATE)
+/* Load Counter input */
+#define LOAD_CNTR 0x0
+/* FLG1 = CARRY(active low); FLG2 = BORROW(active low) */
+#define FLG1_CARRY_FLG2_BORROW 0x0
+/* FLG1 = COMPARE(active low); FLG2 = BORROW(active low) */
+#define FLG1_COMPARE_FLG2_BORROW 0x1
+/* FLG1 = Carry(active low)/Borrow(active low); FLG2 = U/D(active low) flag */
+#define FLG1_CARRYBORROW_FLG2_UD 0x2
+/* FLG1 = INDX (low pulse at INDEX pin active level); FLG2 = E flag */
+#define FLG1_INDX_FLG2_E 0x3
+
+/*
+ * INDEX CONTROL REGISTERS
+ */
+#define INDEX_MODE BIT(0)
+#define INDEX_POLARITY BIT(1)
+/* Disable Index mode */
+#define DISABLE_INDEX_MODE 0x0
+/* Negative Index Polarity */
+#define NEGATIVE_INDEX_POLARITY 0x0
+
+/*
+ * Channel Operation Register
+ */
+#define COUNTERS_OPERATION BIT(0)
+#define INTERRUPT_FUNCTION BIT(2)
+/* Enable all Counters */
+#define ENABLE_COUNTERS u8_encode_bits(0x0, COUNTERS_OPERATION)
+/* Reset all Counters */
+#define RESET_COUNTERS u8_encode_bits(0x1, COUNTERS_OPERATION)
+/* Disable the interrupt function */
+#define DISABLE_INTERRUPT_FUNCTION u8_encode_bits(0x0, INTERRUPT_FUNCTION)
+/* Enable the interrupt function */
+#define ENABLE_INTERRUPT_FUNCTION u8_encode_bits(0x1, INTERRUPT_FUNCTION)
+/* Any write to the Channel Operation register clears any pending interrupts */
+#define CLEAR_PENDING_INTERRUPTS (ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION)
 
 /* Each Counter is 24 bits wide */
 #define LS7267_CNTR_MAX GENMASK(23, 0)
@@ -162,9 +235,7 @@ static int quad8_count_read(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	/* Reset Byte Pointer; transfer Counter to Output Latch */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
-		 &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
 
 	for (i = 0; i < 3; i++)
 		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
@@ -187,28 +258,23 @@ static int quad8_count_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Counter can only be set via Preset Register */
 	for (i = 0; i < 3; i++)
 		iowrite8(val >> (8 * i), &chan->data);
 
-	/* Transfer Preset Register to Counter */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_PRESET_CNTR, &chan->control);
+	iowrite8(SELECT_RLD | TRANSFER_PR_TO_CNTR, &chan->control);
 
-	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Set Preset Register back to original value */
 	val = priv->preset[count->id];
 	for (i = 0; i < 3; i++)
 		iowrite8(val >> (8 * i), &chan->data);
 
-	/* Reset Borrow, Carry, Compare, and Sign flags */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, &chan->control);
-	/* Reset Error flag */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
+	iowrite8(SELECT_RLD | RESET_E, &chan->control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -279,8 +345,8 @@ static int quad8_function_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	mode_cfg = priv->count_mode[id] << 1;
-	idr_cfg = priv->index_polarity[id] << 1;
+	mode_cfg = u8_encode_bits(priv->count_mode[id], COUNT_MODE);
+	idr_cfg = u8_encode_bits(priv->index_polarity[id], INDEX_POLARITY);
 
 	if (function == COUNTER_FUNCTION_PULSE_DIRECTION) {
 		*quadrature_mode = 0;
@@ -288,11 +354,14 @@ static int quad8_function_write(struct counter_device *counter,
 		/* Quadrature scaling only available in quadrature mode */
 		*scale = 0;
 
+		mode_cfg |= u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
+
 		/* Synchronous function not supported in non-quadrature mode */
 		if (*synchronous_mode) {
 			*synchronous_mode = 0;
 			/* Disable synchronous function mode */
-			iowrite8(QUAD8_CTR_IDR | idr_cfg, control);
+			idr_cfg |= u8_encode_bits(*synchronous_mode, INDEX_MODE);
+			iowrite8(SELECT_IDR | idr_cfg, control);
 		}
 	} else {
 		*quadrature_mode = 1;
@@ -300,15 +369,15 @@ static int quad8_function_write(struct counter_device *counter,
 		switch (function) {
 		case COUNTER_FUNCTION_QUADRATURE_X1_A:
 			*scale = 0;
-			mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
+			mode_cfg |= u8_encode_bits(QUADRATURE_X1, QUADRATURE_MODE);
 			break;
 		case COUNTER_FUNCTION_QUADRATURE_X2_A:
 			*scale = 1;
-			mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
+			mode_cfg |= u8_encode_bits(QUADRATURE_X2, QUADRATURE_MODE);
 			break;
 		case COUNTER_FUNCTION_QUADRATURE_X4:
 			*scale = 2;
-			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
+			mode_cfg |= u8_encode_bits(QUADRATURE_X4, QUADRATURE_MODE);
 			break;
 		default:
 			/* should never reach this path */
@@ -318,7 +387,7 @@ static int quad8_function_write(struct counter_device *counter,
 	}
 
 	/* Load mode configuration to Counter Mode Register */
-	iowrite8(QUAD8_CTR_CMR | mode_cfg, control);
+	iowrite8(SELECT_CMR | mode_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -332,9 +401,11 @@ static int quad8_direction_read(struct counter_device *counter,
 	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int ud_flag;
 	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
+	u8 flag;
 
+	flag = ioread8(flag_addr);
 	/* U/D flag: nonzero = up, zero = down */
-	ud_flag = ioread8(flag_addr) & QUAD8_FLAG_UD;
+	ud_flag = u8_get_bits(flag, FLAG_UD);
 
 	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
@@ -423,10 +494,10 @@ static int quad8_action_read(struct counter_device *counter,
 }
 
 enum {
-	QUAD8_EVENT_CARRY = 0,
-	QUAD8_EVENT_COMPARE = 1,
-	QUAD8_EVENT_CARRY_BORROW = 2,
-	QUAD8_EVENT_INDEX = 3,
+	QUAD8_EVENT_CARRY = FLG1_CARRY_FLG2_BORROW,
+	QUAD8_EVENT_COMPARE = FLG1_COMPARE_FLG2_BORROW,
+	QUAD8_EVENT_CARRY_BORROW = FLG1_CARRYBORROW_FLG2_UD,
+	QUAD8_EVENT_INDEX = FLG1_INDX_FLG2_E,
 };
 
 static int quad8_events_configure(struct counter_device *counter)
@@ -471,10 +542,10 @@ static int quad8_events_configure(struct counter_device *counter)
 		priv->irq_trigger[event_node->channel] = next_irq_trigger;
 
 		/* Load configuration to I/O Control Register */
-		ior_cfg = priv->ab_enable[event_node->channel] |
-			  priv->preset_enable[event_node->channel] << 1 |
-			  priv->irq_trigger[event_node->channel] << 3;
-		iowrite8(QUAD8_CTR_IOR | ior_cfg,
+		ior_cfg = u8_encode_bits(priv->ab_enable[event_node->channel], AB_GATE) |
+			  u8_encode_bits(priv->preset_enable[event_node->channel], LOAD_PIN) |
+			  u8_encode_bits(priv->irq_trigger[event_node->channel], FLG_PINS);
+		iowrite8(SELECT_IOR | ior_cfg,
 			 &priv->reg->channel[event_node->channel].control);
 	}
 
@@ -544,16 +615,16 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	const size_t channel_id = signal->id - 16;
 	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
 	unsigned long irqflags;
-	unsigned int idr_cfg = index_polarity << 1;
+	unsigned int idr_cfg = u8_encode_bits(index_polarity, INDEX_POLARITY);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= priv->synchronous_mode[channel_id];
+	idr_cfg |= u8_encode_bits(priv->synchronous_mode[channel_id], INDEX_MODE);
 
 	priv->index_polarity[channel_id] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
-	iowrite8(QUAD8_CTR_IDR | idr_cfg, control);
+	iowrite8(SELECT_IDR | idr_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -611,11 +682,11 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	const size_t channel_id = signal->id - 16;
 	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
 	unsigned long irqflags;
-	unsigned int idr_cfg = synchronous_mode;
+	unsigned int idr_cfg = u8_encode_bits(synchronous_mode, INDEX_MODE);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= priv->index_polarity[channel_id] << 1;
+	idr_cfg |= u8_encode_bits(priv->index_polarity[channel_id], INDEX_POLARITY);
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
@@ -626,7 +697,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	priv->synchronous_mode[channel_id] = synchronous_mode;
 
 	/* Load Index Control configuration to Index Control Register */
-	iowrite8(QUAD8_CTR_IDR | idr_cfg, control);
+	iowrite8(SELECT_IDR | idr_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -648,18 +719,17 @@ static int quad8_count_mode_read(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 
-	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
 	switch (priv->count_mode[count->id]) {
-	case 0:
+	case NORMAL_COUNT:
 		*cnt_mode = COUNTER_COUNT_MODE_NORMAL;
 		break;
-	case 1:
+	case RANGE_LIMIT:
 		*cnt_mode = COUNTER_COUNT_MODE_RANGE_LIMIT;
 		break;
-	case 2:
+	case NON_RECYCLE_COUNT:
 		*cnt_mode = COUNTER_COUNT_MODE_NON_RECYCLE;
 		break;
-	case 3:
+	case MODULO_N:
 		*cnt_mode = COUNTER_COUNT_MODE_MODULO_N;
 		break;
 	}
@@ -677,19 +747,18 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	u8 __iomem *const control = &priv->reg->channel[count->id].control;
 	unsigned long irqflags;
 
-	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
 	switch (cnt_mode) {
 	case COUNTER_COUNT_MODE_NORMAL:
-		count_mode = 0;
+		count_mode = NORMAL_COUNT;
 		break;
 	case COUNTER_COUNT_MODE_RANGE_LIMIT:
-		count_mode = 1;
+		count_mode = RANGE_LIMIT;
 		break;
 	case COUNTER_COUNT_MODE_NON_RECYCLE:
-		count_mode = 2;
+		count_mode = NON_RECYCLE_COUNT;
 		break;
 	case COUNTER_COUNT_MODE_MODULO_N:
-		count_mode = 3;
+		count_mode = MODULO_N;
 		break;
 	default:
 		/* should never reach this path */
@@ -701,14 +770,16 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	priv->count_mode[count->id] = count_mode;
 
 	/* Set count mode configuration value */
-	mode_cfg = count_mode << 1;
+	mode_cfg = u8_encode_bits(count_mode, COUNT_MODE);
 
 	/* Add quadrature mode configuration */
 	if (priv->quadrature_mode[count->id])
-		mode_cfg |= (priv->quadrature_scale[count->id] + 1) << 3;
+		mode_cfg |= u8_encode_bits(priv->quadrature_scale[count->id] + 1, QUADRATURE_MODE);
+	else
+		mode_cfg |= u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE);
 
 	/* Load mode configuration to Counter Mode Register */
-	iowrite8(QUAD8_CTR_CMR | mode_cfg, control);
+	iowrite8(SELECT_CMR | mode_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -737,11 +808,12 @@ static int quad8_count_enable_write(struct counter_device *counter,
 
 	priv->ab_enable[count->id] = enable;
 
-	ior_cfg = enable | priv->preset_enable[count->id] << 1 |
-		  priv->irq_trigger[count->id] << 3;
+	ior_cfg = u8_encode_bits(enable, AB_GATE) |
+		  u8_encode_bits(priv->preset_enable[count->id], LOAD_PIN) |
+		  u8_encode_bits(priv->irq_trigger[count->id], FLG_PINS);
 
 	/* Load I/O control configuration */
-	iowrite8(QUAD8_CTR_IOR | ior_cfg, control);
+	iowrite8(SELECT_IOR | ior_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -758,8 +830,10 @@ static int quad8_error_noise_get(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
+	u8 flag;
 
-	*noise_error = !!(ioread8(flag_addr) & QUAD8_FLAG_E);
+	flag = ioread8(flag_addr);
+	*noise_error = u8_get_bits(flag, FLAG_E);
 
 	return 0;
 }
@@ -782,8 +856,7 @@ static void quad8_preset_register_set(struct quad8 *const priv, const int id,
 
 	priv->preset[id] = preset;
 
-	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Set Preset Register */
 	for (i = 0; i < 3; i++)
@@ -818,8 +891,8 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
-	case 1:
-	case 3:
+	case RANGE_LIMIT:
+	case MODULO_N:
 		*ceiling = priv->preset[count->id];
 		break;
 	default:
@@ -845,8 +918,8 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
-	case 1:
-	case 3:
+	case RANGE_LIMIT:
+	case MODULO_N:
 		quad8_preset_register_set(priv, count->id, ceiling);
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
@@ -884,11 +957,12 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 
 	priv->preset_enable[count->id] = preset_enable;
 
-	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1 |
-		  priv->irq_trigger[count->id] << 3;
+	ior_cfg = u8_encode_bits(priv->ab_enable[count->id], AB_GATE) |
+		  u8_encode_bits(preset_enable, LOAD_PIN) |
+		  u8_encode_bits(priv->irq_trigger[count->id], FLG_PINS);
 
 	/* Load I/O control configuration to Input / Output Control Register */
-	iowrite8(QUAD8_CTR_IOR | ior_cfg, control);
+	iowrite8(SELECT_IOR | ior_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -987,13 +1061,11 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 
 	priv->fck_prescaler[channel_id] = prescaler;
 
-	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Set filter clock factor */
 	iowrite8(prescaler, &chan->data);
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
-		 &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1183,7 +1255,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	}
 
 	/* Clear pending interrupts on device */
-	iowrite8(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, &priv->reg->channel_oper);
+	iowrite8(CLEAR_PENDING_INTERRUPTS, &priv->reg->channel_oper);
 
 	return IRQ_HANDLED;
 }
@@ -1192,27 +1264,25 @@ static void quad8_init_counter(struct channel_reg __iomem *const chan)
 {
 	unsigned long i;
 
-	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 	/* Reset filter clock factor */
 	iowrite8(0, &chan->data);
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
-		 &chan->control);
-	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 	/* Reset Preset Register */
 	for (i = 0; i < 3; i++)
 		iowrite8(0x00, &chan->data);
-	/* Reset Borrow, Carry, Compare, and Sign flags */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, &chan->control);
-	/* Reset Error flag */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
+	iowrite8(SELECT_RLD | RESET_E, &chan->control);
 	/* Binary encoding; Normal count; non-quadrature mode */
-	iowrite8(QUAD8_CTR_CMR, &chan->control);
+	iowrite8(SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
+		 u8_encode_bits(NON_QUADRATURE, QUADRATURE_MODE), &chan->control);
 	/* Disable A and B inputs; preset on index; FLG1 as Carry */
-	iowrite8(QUAD8_CTR_IOR, &chan->control);
+	iowrite8(SELECT_IOR | DISABLE_AB | u8_encode_bits(LOAD_CNTR, LOAD_PIN) |
+		 u8_encode_bits(FLG1_CARRY_FLG2_BORROW, FLG_PINS), &chan->control);
 	/* Disable index function; negative index polarity */
-	iowrite8(QUAD8_CTR_IDR, &chan->control);
+	iowrite8(SELECT_IDR | u8_encode_bits(DISABLE_INDEX_MODE, INDEX_MODE) |
+		 u8_encode_bits(NEGATIVE_INDEX_POLARITY, INDEX_POLARITY), &chan->control);
 }
 
 static int quad8_probe(struct device *dev, unsigned int id)
@@ -1251,14 +1321,14 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Reset Index/Interrupt Register */
 	iowrite8(0x00, &priv->reg->index_interrupt);
 	/* Reset all counters and disable interrupt function */
-	iowrite8(QUAD8_CHAN_OP_RESET_COUNTERS, &priv->reg->channel_oper);
+	iowrite8(RESET_COUNTERS | DISABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
 	/* Set initial configuration for all counters */
 	for (i = 0; i < QUAD8_NUM_COUNTERS; i++)
 		quad8_init_counter(priv->reg->channel + i);
 	/* Disable Differential Encoder Cable Status for all channels */
 	iowrite8(0xFF, &priv->reg->cable_status);
 	/* Enable all counters and enable interrupt function */
-	iowrite8(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, &priv->reg->channel_oper);
+	iowrite8(ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION, &priv->reg->channel_oper);
 
 	err = devm_request_irq(&counter->dev, irq[id], quad8_irq_handler,
 			       IRQF_SHARED, counter->name, counter);
-- 
2.39.2

