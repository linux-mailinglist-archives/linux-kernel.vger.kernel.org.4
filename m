Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54716B6706
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCLN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCLN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:56:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AD3B3C9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:56:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c18so10730971qte.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678629396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdv/nKoVodfRSCXXPZls965lkF2DuhBP1O95BqsvqfQ=;
        b=wMAa8mqg48tbhpWIknbfZQtmokxdWupbNy4mSs3/HC2T9bJ2HG4GFMa9ZiJuKV38Hg
         0e7/KfpYwV65oCoHNDY0ktRkWOe57esT5E015BgMNNxJFuDnjL1bPM7F1D6U+jlR50L5
         83OFXBIXkgI8BwD7M+ahph+LWyYsZrwTyqpLAECDoh/Z1makdxuJToInayJ/ZUgLCRBH
         oIDASbOy93HOlunXywycoIWN8Raff17OM8BKxz/4OkAtBmXvs38sPyTdxPSYauvDjNjq
         rz4uMye23SZpnB2MOeV4ifz7Da+6PmYgE0BfkoTRCMxXqmF18RJRdNVsxjHkMIZHXgb4
         h/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678629396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdv/nKoVodfRSCXXPZls965lkF2DuhBP1O95BqsvqfQ=;
        b=CikcF4dlNPZe90yfQGsdVZfpzeofsznzW4RtKP1uzBkck32YmMC68w58TtDu24lDXB
         8PW1BaShpULOLKLkamSbM/PJ/I9pEi6O8ndXW+YHGbmaf8yF3pDj6kV4RrDetrHG6lyh
         WGillF1mLvgbw8NXMXF7T7IKgN5K04rE4/MI6w3Ehq+KWjTkB5A8wcLq2wypKxJdtIra
         0qYBz0f8l19TSte0+4ACBQNmKTfuntMbsplGxHJZwlpTG0VarMaM92WqQrRajJhycy4O
         e9aTKe8wqvy5StNR2C3vxW2uVqmf3MFRma75Vc+NdT0UCX+h7tq/P0CnunkgVPUqt31v
         3Mtg==
X-Gm-Message-State: AO0yUKWUyFWdt90JIqSRNZuQarXl2hwSDmWLzusJ2hDAo+ZN2lI/Zupr
        YYvBQRtCElPS1hE1Aexo6I8N8Q==
X-Google-Smtp-Source: AK7set+tIj4FYOx3Db03rrSQ2035wDIOWDIvXfhE4rme5kZCPwBNv0ed+qE14Wx2pzlw21we6H9Grg==
X-Received: by 2002:ac8:5f09:0:b0:3ba:1167:72d7 with SMTP id x9-20020ac85f09000000b003ba116772d7mr19692788qta.61.1678629395989;
        Sun, 12 Mar 2023 06:56:35 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u28-20020a37ab1c000000b007449a3ee9a4sm2717930qke.35.2023.03.12.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:56:35 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
Date:   Sun, 12 Mar 2023 09:56:25 -0400
Message-Id: <20230312135625.125312-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Counter (CNTR) register is 24 bits wide, but we can have an
effective 25-bit count value by setting bit 24 to the XOR of the Borrow
flag and Carry flag. The flags can be read from the FLAG register, but a
race condition exists: the Borrow flag and Carry flag are instantaneous
and could change by the time the count value is read from the CNTR
register.

Since the race condition could result in an incorrect 25-bit count
value, remove support for 25-bit count values from this driver;
hard-coded maximum count values are replaced by a LS7267_CNTR_MAX define
for consistency and clarity.

Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index deed4afadb29..dba04b5e80b7 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -97,10 +97,6 @@ struct quad8 {
 	struct quad8_reg __iomem *reg;
 };
 
-/* Borrow Toggle flip-flop */
-#define QUAD8_FLAG_BT BIT(0)
-/* Carry Toggle flip-flop */
-#define QUAD8_FLAG_CT BIT(1)
 /* Error flag */
 #define QUAD8_FLAG_E BIT(4)
 /* Up/Down flag */
@@ -133,6 +129,9 @@ struct quad8 {
 #define QUAD8_CMR_QUADRATURE_X2 0x10
 #define QUAD8_CMR_QUADRATURE_X4 0x18
 
+/* Each Counter is 24 bits wide */
+#define LS7267_CNTR_MAX GENMASK(23, 0)
+
 static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
 			     enum counter_signal_level *level)
@@ -156,19 +155,9 @@ static int quad8_count_read(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter_priv(counter);
 	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
 	unsigned long irqflags;
 	int i;
 
-	flags = ioread8(&chan->control);
-	borrow = flags & QUAD8_FLAG_BT;
-	carry = !!(flags & QUAD8_FLAG_CT);
-
-	/* Borrow XOR Carry effectively doubles count range */
-	*val = (unsigned long)(borrow ^ carry) << 24;
-
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
@@ -191,8 +180,7 @@ static int quad8_count_write(struct counter_device *counter,
 	unsigned long irqflags;
 	int i;
 
-	/* Only 24-bit values are supported */
-	if (val > 0xFFFFFF)
+	if (val > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
@@ -806,8 +794,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
-	/* Only 24-bit values are supported */
-	if (preset > 0xFFFFFF)
+	if (preset > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
@@ -834,8 +821,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 		*ceiling = priv->preset[count->id];
 		break;
 	default:
-		/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
-		*ceiling = 0x1FFFFFF;
+		*ceiling = LS7267_CNTR_MAX;
 		break;
 	}
 
@@ -850,8 +836,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	unsigned long irqflags;
 
-	/* Only 24-bit values are supported */
-	if (ceiling > 0xFFFFFF)
+	if (ceiling > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	spin_lock_irqsave(&priv->lock, irqflags);

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

