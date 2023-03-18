Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD56BFB15
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCRPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCRPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:00:10 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E7F952
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:04 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id m6so5267085qvq.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679151604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W/q24rDE6ccNgXOPJBq6S6vpIqoaWs1EoBFwd65Wiw=;
        b=pVu7BcUgG5o6Tjxtw1+3kagnnRg2M959vOnAme1e7R8KxBiG8eO83xDXwjsyvRwkzM
         jxH3l9UThbdTtDDeZy5D25datGEkLmkCUHtYx1r8g6gL81l2KxuMj4j5cj/ZiQPmgaHn
         Qc2UdIHe7N4+LVf0m39qHcgfmrSE/B+GQ/Gxwl2lHjF1vuGx3yOa5bwBiTwJ8CvdWSVE
         TNAMYcdC4JxyenXE1LWp5tQWtXNasdO0KcxPJSR9UCdFpdO0PCbRZm5jqq8jHElvzq70
         jQzVbbrfqJxZRtR4aRnryjy7fzA4n9bXviXNUPsOKmStcEFc5Yqv5nQZjqHRfFavsAlw
         +Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W/q24rDE6ccNgXOPJBq6S6vpIqoaWs1EoBFwd65Wiw=;
        b=f2B66NikbLboCA7lnR48n9nMxYS40xGU3DpwQVVtqmmuf8+FiYHp5uJzyev+7k9piV
         l1IJOROdLhkhfE782DOoa3CsWGSaBX4Gf54pt7pBxLDYkII9vjWpjehTiX9FbKWJ3iaI
         xntE1rHwxxSuLp19lkFziIBjzMvDpOJiVA9BhtxAZAGh43/n3nDQFAB7dX93o0rppms+
         7BJm+MVNdYO7OT1y9OS1midvGlcIwrTbtLQYDa4MN6Dlq67u5htbMEjVKH6ieE9VWce1
         RxhyfDDbKmA+Y3bDqIWV2VQVPPRuQxhEfeYFq7gENqqPsAVjDGeXHZaHZ6l58clysoEb
         R8xQ==
X-Gm-Message-State: AO0yUKUln34RMmDwJnqjPam4aslZcA76hhtg18hr73lYkJ+mBllAlqKi
        bC6zV63tDchRVMLmsh06mwfvUxWQM1Ovg0PU268=
X-Google-Smtp-Source: AK7set+YKY4XM9WkFSODNkoVe3TV/Q+fLuwzuexPIqs78WK7+LW7DxBH9xhMCYMCNS/QHOY/rrYzAA==
X-Received: by 2002:a05:6214:1bcf:b0:5c2:d241:9c1d with SMTP id m15-20020a0562141bcf00b005c2d2419c1dmr4190213qvc.27.1679151603684;
        Sat, 18 Mar 2023 08:00:03 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f67-20020a37d246000000b00745daadd210sm3709162qkj.71.2023.03.18.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:00:03 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/4] counter: 104-quad-8: Utilize bitfield access macros
Date:   Sat, 18 Mar 2023 10:59:48 -0400
Message-Id: <15356da19de83d92b532515ee12b5caa32b35711.1679149542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679149542.git.william.gray@linaro.org>
References: <cover.1679149542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-QUAD-8 features several registers with various bitfields.
Utilize bitfield access macros such as FIELD_PREP to make the code
easier to read and the intent clearer.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 267 +++++++++++++++++++++++------------
 1 file changed, 176 insertions(+), 91 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index d9cb937665cf..be7b04b52d85 100644
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
@@ -98,36 +99,110 @@ struct quad8 {
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
+#define SELECT_RLD FIELD_PREP(REGISTER_SELECTION, 0x0)
 /* Counter Mode Register */
-#define QUAD8_CTR_CMR 0x20
+#define SELECT_CMR FIELD_PREP(REGISTER_SELECTION, 0x1)
 /* Input / Output Control Register */
-#define QUAD8_CTR_IOR 0x40
+#define SELECT_IOR FIELD_PREP(REGISTER_SELECTION, 0x2)
 /* Index Control Register */
-#define QUAD8_CTR_IDR 0x60
+#define SELECT_IDR FIELD_PREP(REGISTER_SELECTION, 0x3)
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
+#define RESET_BT_CT_CPT_S_IDX FIELD_PREP(RESETS, 0x2)
 /* Reset Error flag */
-#define QUAD8_RLD_RESET_E 0x06
+#define RESET_E FIELD_PREP(RESETS, 0x3)
 /* Preset Register to Counter */
-#define QUAD8_RLD_PRESET_CNTR 0x08
+#define TRANSFER_PR_TO_CNTR FIELD_PREP(LOADS, 0x1)
 /* Transfer Counter to Output Latch */
-#define QUAD8_RLD_CNTR_OUT 0x10
+#define TRANSFER_CNTR_TO_OL FIELD_PREP(LOADS, 0x2)
 /* Transfer Preset Register LSB to FCK Prescaler */
-#define QUAD8_RLD_PRESET_PSC 0x18
-#define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
-#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
-#define QUAD8_CMR_QUADRATURE_X1 0x08
-#define QUAD8_CMR_QUADRATURE_X2 0x10
-#define QUAD8_CMR_QUADRATURE_X4 0x18
+#define TRANSFER_PR0_TO_PSC FIELD_PREP(LOADS, 0x3)
+
+/*
+ * Counter Mode Registers
+ */
+#define COUNT_ENCODING BIT(0)
+#define COUNT_MODE GENMASK(2, 1)
+#define QUADRATURE_MODE GENMASK(4, 3)
+/* Binary count */
+#define BINARY FIELD_PREP(COUNT_ENCODING, 0x0)
+/* Normal count */
+#define NORMAL_COUNT 0x0
+#define CMR_NORMAL_COUNT FIELD_PREP(COUNT_MODE, NORMAL_COUNT)
+/* Range Limit */
+#define RANGE_LIMIT 0x1
+/* Non-recycle count */
+#define NON_RECYCLE_COUNT 0x2
+/* Modulo-N */
+#define MODULO_N 0x3
+/* Non-quadrature */
+#define NON_QUADRATURE FIELD_PREP(QUADRATURE_MODE, 0x0)
+/* Quadrature X1 */
+#define QUADRATURE_X1 FIELD_PREP(QUADRATURE_MODE, 0x1)
+/* Quadrature X2 */
+#define QUADRATURE_X2 FIELD_PREP(QUADRATURE_MODE, 0x2)
+/* Quadrature X4 */
+#define QUADRATURE_X4 FIELD_PREP(QUADRATURE_MODE, 0x3)
+
+/*
+ * Input/Output Control Register
+ */
+#define AB_GATE BIT(0)
+#define LOAD_PIN BIT(1)
+#define FLG_PINS GENMASK(4, 3)
+/* Disable inputs A and B */
+#define DISABLE_AB FIELD_PREP(AB_GATE, 0x0)
+/* Load Counter input */
+#define LOAD_CNTR FIELD_PREP(LOAD_PIN, 0x0)
+/* FLG1 = CARRY(active low); FLG2 = BORROW(active low) */
+#define FLG1_CARRY_FLG2_BORROW 0x0
+#define IOR_FLG1_CARRY_FLG2_BORROW FIELD_PREP(FLG_PINS, FLG1_CARRY_FLG2_BORROW)
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
+#define DISABLE_INDEX_MODE FIELD_PREP(INDEX_MODE, 0x0)
+/* Negative Index Polarity */
+#define NEGATIVE_INDEX_POLARITY FIELD_PREP(INDEX_POLARITY, 0x0)
+
+/*
+ * Channel Operation Register
+ */
+#define COUNTERS_OPERATION BIT(0)
+#define INTERRUPT_FUNCTION BIT(2)
+/* Enable all Counters */
+#define ENABLE_COUNTERS FIELD_PREP(COUNTERS_OPERATION, 0x0)
+/* Reset all Counters */
+#define RESET_COUNTERS FIELD_PREP(COUNTERS_OPERATION, 0x1)
+/* Disable the interrupt function */
+#define DISABLE_INTERRUPT_FUNCTION FIELD_PREP(INTERRUPT_FUNCTION, 0x0)
+/* Enable the interrupt function */
+#define ENABLE_INTERRUPT_FUNCTION FIELD_PREP(INTERRUPT_FUNCTION, 0x1)
+/* Any write to the Channel Operation register clears any pending interrupts */
+#define CLEAR_PENDING_INTERRUPTS (ENABLE_COUNTERS | ENABLE_INTERRUPT_FUNCTION)
 
 /* Each Counter is 24 bits wide */
 #define LS7267_CNTR_MAX GENMASK(23, 0)
@@ -163,8 +238,7 @@ static int quad8_count_read(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
-		 &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
 
 	for (i = 0; i < 3; i++)
 		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
@@ -188,17 +262,17 @@ static int quad8_count_write(struct counter_device *counter,
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Counter can only be set via Preset Register */
 	for (i = 0; i < 3; i++)
 		iowrite8(val >> (8 * i), &chan->data);
 
 	/* Transfer Preset Register to Counter */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_PRESET_CNTR, &chan->control);
+	iowrite8(SELECT_RLD | TRANSFER_PR_TO_CNTR, &chan->control);
 
 	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Set Preset Register back to original value */
 	val = priv->preset[count->id];
@@ -206,9 +280,9 @@ static int quad8_count_write(struct counter_device *counter,
 		iowrite8(val >> (8 * i), &chan->data);
 
 	/* Reset Borrow, Carry, Compare, and Sign flags */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
 	/* Reset Error flag */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, &chan->control);
+	iowrite8(SELECT_RLD | RESET_E, &chan->control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -279,8 +353,8 @@ static int quad8_function_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	mode_cfg = priv->count_mode[id] << 1;
-	idr_cfg = priv->index_polarity[id] << 1;
+	mode_cfg = FIELD_PREP(COUNT_MODE, priv->count_mode[id]);
+	idr_cfg = FIELD_PREP(INDEX_POLARITY, priv->index_polarity[id]);
 
 	if (function == COUNTER_FUNCTION_PULSE_DIRECTION) {
 		*quadrature_mode = 0;
@@ -288,11 +362,14 @@ static int quad8_function_write(struct counter_device *counter,
 		/* Quadrature scaling only available in quadrature mode */
 		*scale = 0;
 
+		mode_cfg |= NON_QUADRATURE;
+
 		/* Synchronous function not supported in non-quadrature mode */
 		if (*synchronous_mode) {
-			*synchronous_mode = 0;
 			/* Disable synchronous function mode */
-			iowrite8(QUAD8_CTR_IDR | idr_cfg, control);
+			*synchronous_mode = 0;
+			idr_cfg |= FIELD_PREP(INDEX_MODE, *synchronous_mode);
+			iowrite8(SELECT_IDR | idr_cfg, control);
 		}
 	} else {
 		*quadrature_mode = 1;
@@ -300,15 +377,15 @@ static int quad8_function_write(struct counter_device *counter,
 		switch (function) {
 		case COUNTER_FUNCTION_QUADRATURE_X1_A:
 			*scale = 0;
-			mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
+			mode_cfg |= QUADRATURE_X1;
 			break;
 		case COUNTER_FUNCTION_QUADRATURE_X2_A:
 			*scale = 1;
-			mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
+			mode_cfg |= QUADRATURE_X2;
 			break;
 		case COUNTER_FUNCTION_QUADRATURE_X4:
 			*scale = 2;
-			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
+			mode_cfg |= QUADRATURE_X4;
 			break;
 		default:
 			/* should never reach this path */
@@ -318,7 +395,7 @@ static int quad8_function_write(struct counter_device *counter,
 	}
 
 	/* Load mode configuration to Counter Mode Register */
-	iowrite8(QUAD8_CTR_CMR | mode_cfg, control);
+	iowrite8(SELECT_CMR | mode_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -332,9 +409,11 @@ static int quad8_direction_read(struct counter_device *counter,
 	const struct quad8 *const priv = counter_priv(counter);
 	unsigned int ud_flag;
 	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
+	unsigned long flag;
 
+	flag = ioread8(flag_addr);
 	/* U/D flag: nonzero = up, zero = down */
-	ud_flag = ioread8(flag_addr) & QUAD8_FLAG_UD;
+	ud_flag = FIELD_GET(FLAG_UD, flag);
 
 	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
@@ -423,10 +502,10 @@ static int quad8_action_read(struct counter_device *counter,
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
@@ -471,10 +550,13 @@ static int quad8_events_configure(struct counter_device *counter)
 		priv->irq_trigger[event_node->channel] = next_irq_trigger;
 
 		/* Load configuration to I/O Control Register */
-		ior_cfg = priv->ab_enable[event_node->channel] |
-			  priv->preset_enable[event_node->channel] << 1 |
-			  priv->irq_trigger[event_node->channel] << 3;
-		iowrite8(QUAD8_CTR_IOR | ior_cfg,
+		ior_cfg = FIELD_PREP(AB_GATE,
+				     priv->ab_enable[event_node->channel]) |
+			  FIELD_PREP(LOAD_PIN,
+				     priv->preset_enable[event_node->channel]) |
+			  FIELD_PREP(FLG_PINS,
+				     priv->irq_trigger[event_node->channel]);
+		iowrite8(SELECT_IOR | ior_cfg,
 			 &priv->reg->channel[event_node->channel].control);
 	}
 
@@ -544,16 +626,16 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	const size_t channel_id = signal->id - 16;
 	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
 	unsigned long irqflags;
-	unsigned int idr_cfg = index_polarity << 1;
+	unsigned int idr_cfg = FIELD_PREP(INDEX_POLARITY, index_polarity);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= priv->synchronous_mode[channel_id];
+	idr_cfg |= FIELD_PREP(INDEX_MODE, priv->synchronous_mode[channel_id]);
 
 	priv->index_polarity[channel_id] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
-	iowrite8(QUAD8_CTR_IDR | idr_cfg, control);
+	iowrite8(SELECT_IDR | idr_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -611,11 +693,11 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	const size_t channel_id = signal->id - 16;
 	u8 __iomem *const control = &priv->reg->channel[channel_id].control;
 	unsigned long irqflags;
-	unsigned int idr_cfg = synchronous_mode;
+	unsigned int idr_cfg = FIELD_PREP(INDEX_MODE, synchronous_mode);
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	idr_cfg |= priv->index_polarity[channel_id] << 1;
+	idr_cfg |= FIELD_PREP(INDEX_POLARITY, priv->index_polarity[channel_id]);
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
@@ -626,7 +708,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	priv->synchronous_mode[channel_id] = synchronous_mode;
 
 	/* Load Index Control configuration to Index Control Register */
-	iowrite8(QUAD8_CTR_IDR | idr_cfg, control);
+	iowrite8(SELECT_IDR | idr_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -648,18 +730,17 @@ static int quad8_count_mode_read(struct counter_device *counter,
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
@@ -677,19 +758,18 @@ static int quad8_count_mode_write(struct counter_device *counter,
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
@@ -701,14 +781,17 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	priv->count_mode[count->id] = count_mode;
 
 	/* Set count mode configuration value */
-	mode_cfg = count_mode << 1;
+	mode_cfg = FIELD_PREP(COUNT_MODE, count_mode);
 
 	/* Add quadrature mode configuration */
 	if (priv->quadrature_mode[count->id])
-		mode_cfg |= (priv->quadrature_scale[count->id] + 1) << 3;
+		mode_cfg |= FIELD_PREP(QUADRATURE_MODE,
+				       priv->quadrature_scale[count->id] + 1);
+	else
+		mode_cfg |= NON_QUADRATURE;
 
 	/* Load mode configuration to Counter Mode Register */
-	iowrite8(QUAD8_CTR_CMR | mode_cfg, control);
+	iowrite8(SELECT_CMR | mode_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -737,11 +820,12 @@ static int quad8_count_enable_write(struct counter_device *counter,
 
 	priv->ab_enable[count->id] = enable;
 
-	ior_cfg = enable | priv->preset_enable[count->id] << 1 |
-		  priv->irq_trigger[count->id] << 3;
+	ior_cfg = FIELD_PREP(AB_GATE, enable) |
+		  FIELD_PREP(LOAD_PIN, priv->preset_enable[count->id]) |
+		  FIELD_PREP(FLG_PINS, priv->irq_trigger[count->id]);
 
 	/* Load I/O control configuration */
-	iowrite8(QUAD8_CTR_IOR | ior_cfg, control);
+	iowrite8(SELECT_IOR | ior_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -758,8 +842,10 @@ static int quad8_error_noise_get(struct counter_device *counter,
 {
 	const struct quad8 *const priv = counter_priv(counter);
 	u8 __iomem *const flag_addr = &priv->reg->channel[count->id].control;
+	unsigned long flag;
 
-	*noise_error = !!(ioread8(flag_addr) & QUAD8_FLAG_E);
+	flag = ioread8(flag_addr);
+	*noise_error = FIELD_GET(FLAG_E, flag);
 
 	return 0;
 }
@@ -783,7 +869,7 @@ static void quad8_preset_register_set(struct quad8 *const priv, const int id,
 	priv->preset[id] = preset;
 
 	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Set Preset Register */
 	for (i = 0; i < 3; i++)
@@ -818,8 +904,8 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
-	case 1:
-	case 3:
+	case RANGE_LIMIT:
+	case MODULO_N:
 		*ceiling = priv->preset[count->id];
 		break;
 	default:
@@ -845,8 +931,8 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
-	case 1:
-	case 3:
+	case RANGE_LIMIT:
+	case MODULO_N:
 		quad8_preset_register_set(priv, count->id, ceiling);
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
@@ -884,11 +970,12 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 
 	priv->preset_enable[count->id] = preset_enable;
 
-	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1 |
-		  priv->irq_trigger[count->id] << 3;
+	ior_cfg = FIELD_PREP(AB_GATE, priv->ab_enable[count->id]) |
+		  FIELD_PREP(LOAD_PIN, preset_enable) |
+		  FIELD_PREP(FLG_PINS, priv->irq_trigger[count->id]);
 
 	/* Load I/O control configuration to Input / Output Control Register */
-	iowrite8(QUAD8_CTR_IOR | ior_cfg, control);
+	iowrite8(SELECT_IOR | ior_cfg, control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -988,12 +1075,11 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	priv->fck_prescaler[channel_id] = prescaler;
 
 	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 
 	/* Set filter clock factor */
 	iowrite8(prescaler, &chan->data);
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
-		 &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1183,7 +1269,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 	}
 
 	/* Clear pending interrupts on device */
-	iowrite8(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, &priv->reg->channel_oper);
+	iowrite8(CLEAR_PENDING_INTERRUPTS, &priv->reg->channel_oper);
 
 	return IRQ_HANDLED;
 }
@@ -1193,26 +1279,25 @@ static void quad8_init_counter(struct channel_reg __iomem *const chan)
 	unsigned long i;
 
 	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 	/* Reset filter clock factor */
 	iowrite8(0, &chan->data);
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
-		 &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
 	/* Reset Byte Pointer */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
 	/* Reset Preset Register */
 	for (i = 0; i < 3; i++)
 		iowrite8(0x00, &chan->data);
 	/* Reset Borrow, Carry, Compare, and Sign flags */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, &chan->control);
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
 	/* Reset Error flag */
-	iowrite8(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, &chan->control);
+	iowrite8(SELECT_RLD | RESET_E, &chan->control);
 	/* Binary encoding; Normal count; non-quadrature mode */
-	iowrite8(QUAD8_CTR_CMR, &chan->control);
+	iowrite8(SELECT_CMR | BINARY | CMR_NORMAL_COUNT | NON_QUADRATURE, &chan->control);
 	/* Disable A and B inputs; preset on index; FLG1 as Carry */
-	iowrite8(QUAD8_CTR_IOR, &chan->control);
+	iowrite8(SELECT_IOR | DISABLE_AB | LOAD_CNTR | IOR_FLG1_CARRY_FLG2_BORROW, &chan->control);
 	/* Disable index function; negative index polarity */
-	iowrite8(QUAD8_CTR_IDR, &chan->control);
+	iowrite8(SELECT_IDR | DISABLE_INDEX_MODE | NEGATIVE_INDEX_POLARITY, &chan->control);
 }
 
 static int quad8_probe(struct device *dev, unsigned int id)
@@ -1251,14 +1336,14 @@ static int quad8_probe(struct device *dev, unsigned int id)
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

