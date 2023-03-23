Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26A56C724B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCWV0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCWVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:25:58 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CA2ED60
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:25:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5419d4c340aso417948877b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679606756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHJo3IsMXdk4ztq0+7zwFQ2RTFvoOSFwH6pGKvwxf4Q=;
        b=CKqG+Inxra7Djme9ZrXaBKiUVZGQUzblbZQTkm9w3uXq7zLYq7yWQJ0OGOD4Toz7GD
         z8qX2/M6yDzbceT9KiANQXMPdyzdjvnNBJPrdy+DtXbp2e3NHjVJpdjN8NEFK/24ELj/
         2kLc+kMjDS0uDPcuPR7YcWIpwrxl5wHLohpVu1id8/3T33w68nTPHsnfrZrC86Xd7f3l
         TQoGOyMTDVWi3hy6hWUyVwLqzpJqn2HQ4iFzgxA5WxKJdikaau6VXeZJUxRNDtpH/tEl
         7zus2JC+dW1HSVN7HgiYQ+REjir77OQoMw9Yud0Sxi82Df6wFWWqUpoDc1r2Fxp4+0Kv
         ovMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHJo3IsMXdk4ztq0+7zwFQ2RTFvoOSFwH6pGKvwxf4Q=;
        b=pvk343dilQmDtfYzCI4pAW3LiDJN5Z5lMFvQLD54t1FJPRDY7Taawjp9dQ0j2gHtyI
         zwTXstkqqLxgseanfqUjuO26oH1Cw8PEW8qFm78KCo8+C1Vp/OJV5HIp/HnOQOhfS4dI
         WQpF1y+NoTrMqtDenP/s5214+tgKVLjI/0a5uaTwKl/jY5bMrtlLHUgQ8ciQJt6H8MTR
         p9t5MCgETZG8D7bQL2+uw6uB5RRygOdZwxEXm40OZpwlldAwc168Na9jR1MlazQyGxH9
         xLcFV/iRpVsB/vO/b8jqD7UAinA6qGkPp+fL39S7xHxarM/DVhn35NdnlhgRhi+8Z+6U
         G7WQ==
X-Gm-Message-State: AAQBX9f0b/yuQLBQMNLH3rKXCPoeX5FCydoyj5ULyCHVYgbzh/J2xWwA
        OZudGoYmMk8VZpnB7gn64BOTIg==
X-Google-Smtp-Source: AKy350bDD23cYYE88UEqXViZu8UtRUj3RpbzV1of/StO8++4HKtRiZgqCu0J7iZ42KvRzbKHERU94Q==
X-Received: by 2002:a81:dd01:0:b0:543:6327:8d51 with SMTP id e1-20020a81dd01000000b0054363278d51mr5277358ywn.15.1679606755760;
        Thu, 23 Mar 2023 14:25:55 -0700 (PDT)
Received: from fedora.attlocal.net ([172.56.72.93])
        by smtp.gmail.com with ESMTPSA id 204-20020a8112d5000000b00545a0818495sm52281yws.37.2023.03.23.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:25:55 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 3/3] counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and PSC
Date:   Thu, 23 Mar 2023 17:25:29 -0400
Message-Id: <c0e914e2b2d5876265494df3ca102edcf259f02a.1679605919.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679605919.git.william.gray@linaro.org>
References: <cover.1679605919.git.william.gray@linaro.org>
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

The Preset Register (PR), Flag Register (FLAG), and Filter Clock
Prescaler (PSC) have common usage patterns. Wrap up such usage into
dedicated functions to improve code clarity.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v2:
 - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
   data

 drivers/counter/104-quad-8.c | 87 +++++++++++++++---------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index fe0887e6185d..02c5499378b6 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -231,52 +231,56 @@ static int quad8_count_read(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
-	int i;
 
 	*val = 0;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
-
-	for (i = 0; i < 3; i++)
-		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
+	ioread8_rep(&chan->data, val, 3);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
 
+static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
+				      const unsigned long preset)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	iowrite8_rep(&chan->data, &preset, 3);
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
 
@@ -770,21 +774,6 @@ static int quad8_count_preset_read(struct counter_device *counter,
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
@@ -796,6 +785,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
+	priv->preset[count->id] = preset;
 	quad8_preset_register_set(priv, count->id, preset);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
@@ -842,6 +832,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	switch (u8_get_bits(priv->cmr[count->id], COUNT_MODE)) {
 	case RANGE_LIMIT:
 	case MODULO_N:
+		priv->preset[count->id] = ceiling;
 		quad8_preset_register_set(priv, count->id, ceiling);
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
@@ -960,24 +951,28 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
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
 
@@ -1177,18 +1172,10 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
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

