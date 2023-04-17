Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076AE6E5130
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjDQTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDQTvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:51:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA3C4232
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54fa9da5e5bso230015527b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681761067; x=1684353067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyO0V+aAYGjTDJDpsci/EuW4KjxAcnDomhsrheQk3CM=;
        b=cZL7T73rLY7IabF7z+jkSTqbEQam25ymaIf2EuiL6ejE2qv20q77MvV6voXHr2+Wms
         perv0gqhhyNwyCqaLhLCtKL6pqdQlfbfA8rhe/JGahISpghh/ETYGwd8UMgn1Wj2GT9G
         9o06bqpa+J1fh8UK5QvhgKrbcbGbR/jX+snWotFPdxfe5/DaHoeSS1wLGFnH94eAQNeK
         zS7X1a+p6tMupxgMRmPknAGPNACzjUT8o1jqML0EMLLBNFM0fZvDBj6zP5h401qICA4M
         L2noLYGghHy33hm7F4m1IRUTkBf+KxxMQkWaauM40djkIpUzvyZrz4urNvKOOtrTxaUA
         s0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761067; x=1684353067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyO0V+aAYGjTDJDpsci/EuW4KjxAcnDomhsrheQk3CM=;
        b=hy1oAOGJl3txaIaxysK/pHw8GOXcOlr+aalvn2CLWybqluB3aPCAI5DQY7zu/ZmKoZ
         wct7DkTsa1vQwLQb466patbijF4GVij3XNxIZOZH8pH+34glxKXLUEvGc6riP20y22If
         ZswbShqxhLAuWweemGCOJjLhero/5JSHEHc6G92vmFshV62XlbAT6y/XUROWjKg1AnQS
         ZECX83ga3X+a0ELAWbwJIHxV4bT4KTYn6THDi75QoXhhIPQnKPxXcF3pQbyTMFyVJNyK
         BtoFsH4poXEYhAiQ+/wAuuk9smXIG+2MhmhsyT/yx2K809JY4QRLoHXMzLXhsi2WHSvE
         mFBQ==
X-Gm-Message-State: AAQBX9ceAUSwnZhyEsRkYOjntll57+Cti05WTtGSiHA/Sy45fdSLmROV
        yBep+hGu1SoYQ+ypeVWO3ecegg==
X-Google-Smtp-Source: AKy350Zatm5TsJnMUEvxN1Ba/9wxBYmE0op5LwyEehTLKCE5V2hLIZABmH7KqxuOxu9A+tVE/bDpOw==
X-Received: by 2002:a81:4a86:0:b0:552:cad8:dc2a with SMTP id x128-20020a814a86000000b00552cad8dc2amr5439310ywa.52.1681761067351;
        Mon, 17 Apr 2023 12:51:07 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u125-20020a817983000000b005463f6ae720sm3293158ywc.68.2023.04.17.12.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:51:06 -0700 (PDT)
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
Subject: [PATCH v4 3/4] counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and PSC
Date:   Mon, 17 Apr 2023 15:50:49 -0400
Message-Id: <a2d663337bf2907e0283023c06b1ddcbb32f7f6d.1681753140.git.william.gray@linaro.org>
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

The Preset Register (PR), Flag Register (FLAG), and Filter Clock
Prescaler (PSC) have common usage patterns. Wrap up such usage into
dedicated functions to improve code clarity.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4:
 - Fix endianness errors by utilizing get_unaligned_le24() and
   put_unaligned_le24()
Changes in v3: none
Changes in v2:
 - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
   data

 drivers/counter/104-quad-8.c | 97 +++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0188c9c4e4cb..d6ede651cc5e 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -21,6 +21,8 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
+#include <asm/unaligned.h>
+
 #define QUAD8_EXTENT 32
 
 static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
@@ -232,52 +234,60 @@ static int quad8_count_read(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
-	int i;
-
-	*val = 0;
+	u8 value[3];
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
-
-	for (i = 0; i < 3; i++)
-		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
+	ioread8_rep(&chan->data, value, sizeof(value));
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
+	*val = get_unaligned_le24(value);
+
 	return 0;
 }
 
+static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
+				      const unsigned long preset)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+	u8 value[3];
+
+	put_unaligned_le24(preset, value);
+
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	iowrite8_rep(&chan->data, value, sizeof(value));
+}
+
+static void quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
+	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+}
+
 static int quad8_count_write(struct counter_device *counter,
 			     struct counter_count *count, u64 val)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
-	int i;
 
 	if (val > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
 	/* Counter can only be set via Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(val >> (8 * i), &chan->data);
-
+	quad8_preset_register_set(priv, count->id, val);
 	iowrite8(SELECT_RLD | TRANSFER_PR_TO_CNTR, &chan->control);
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	quad8_flag_register_reset(priv, count->id);
 
 	/* Set Preset Register back to original value */
-	val = priv->preset[count->id];
-	for (i = 0; i < 3; i++)
-		iowrite8(val >> (8 * i), &chan->data);
-
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	quad8_preset_register_set(priv, count->id, priv->preset[count->id]);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -771,21 +781,6 @@ static int quad8_count_preset_read(struct counter_device *counter,
 	return 0;
 }
 
-static void quad8_preset_register_set(struct quad8 *const priv, const int id,
-				      const unsigned int preset)
-{
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
-	int i;
-
-	priv->preset[id] = preset;
-
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
-	/* Set Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(preset >> (8 * i), &chan->data);
-}
-
 static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
@@ -797,6 +792,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
+	priv->preset[count->id] = preset;
 	quad8_preset_register_set(priv, count->id, preset);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
@@ -843,6 +839,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	switch (u8_get_bits(priv->cmr[count->id], COUNT_MODE)) {
 	case RANGE_LIMIT:
 	case MODULO_N:
+		priv->preset[count->id] = ceiling;
 		quad8_preset_register_set(priv, count->id, ceiling);
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
@@ -961,24 +958,28 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	return 0;
 }
 
+static void quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
+					     const u8 prescaler)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	iowrite8(prescaler, &chan->data);
+	iowrite8(SELECT_RLD | TRANSFER_PR0_TO_PSC, &chan->control);
+}
+
 static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 					    struct counter_signal *signal,
 					    u8 prescaler)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
-	struct channel_reg __iomem *const chan = priv->reg->channel + channel_id;
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->fck_prescaler[channel_id] = prescaler;
-
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
-	/* Set filter clock factor */
-	iowrite8(prescaler, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
+	quad8_filter_clock_prescaler_set(priv, channel_id, prescaler);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1178,18 +1179,10 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
 	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
-	unsigned long i;
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	/* Reset filter clock factor */
-	iowrite8(0, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	/* Reset Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(0x00, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	quad8_filter_clock_prescaler_set(priv, channel, 0);
+	quad8_preset_register_set(priv, channel, 0);
+	quad8_flag_register_reset(priv, channel);
 
 	/* Binary encoding; Normal count; non-quadrature mode */
 	priv->cmr[channel] = SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
-- 
2.39.2

