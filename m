Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276F96EC322
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjDWXVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 19:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDWXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 19:21:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4381733
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 16:21:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b8f557b241fso2441008276.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682292059; x=1684884059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUMSPEP1V3AMPMfycyCyPWow7154NmJhwDd6EB+MKNQ=;
        b=Z8y6B1JfGkmvceYC7a0xDwfOvKwhNmXRbWSUWNRkcYpwR+Al/8842fXxkZGelkzbR6
         TmmlljPUcEmVv3F0VG2IbWqNxAxeqIxxmBHhqUg7eQ3SpK8ebYd02BjK5pnqReE0QkDD
         Av6cA9KZeSq8B3wK0H31MTcQ9z5Y7g9LLaXdGn1I00QpA065Qqncc1VzGwQojpQZsIWa
         F6yOqXFa2ovHaStEVnKjzOO0kbKOkwjLjm+5Xw5Oj4PinPM/fZkZiGaXwyxM+euJ6nte
         LgLo2J+b5QtI/JdX08L3IRscNQT16jjaOL1hylIvWDzStyZmwYr7Wel14gyHEJ5e0mQS
         V9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682292059; x=1684884059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUMSPEP1V3AMPMfycyCyPWow7154NmJhwDd6EB+MKNQ=;
        b=kazG0UOa5t/HxMvvWfd9q+jDHD5iQQIf9kLU/AwHHkYjQ0rcduo78tD7zJzb9cm7A7
         /yR4x9V/4w9s51HNn3NAJxfLYNZsPqp1izkYE016qTQ3CKXcBmHu6M9UDqX0v0yV7Iy6
         1nALyioiaMMzUggvDHppHyVoUn8wSkh5EPpQmtaGKUl0dHlxswftY7a4imvfevX66adg
         Wn3kS2aO2igaaIsipcJl8u/8Zgbgob1RaVkr6lEj9ZmFyGAPF9RNMaJOWu5Nf42VDgwT
         d98YBrzBPaS6VzLw9ou/fwPe7TEk+P22FbGkRZXSVpPwMYD1o+zvFAXl0eRIZEkuYTob
         JdcQ==
X-Gm-Message-State: AAQBX9c74JhEirQmAHeHTdrW7NWJs4LgvFYGmY2+nMsHzkKUPVgkjzzP
        mfB7jH5gUEJtt9g3kfHemFHXNQ==
X-Google-Smtp-Source: AKy350YxOvXAAQvroRp0u+02NfJgfQuykjpvRsULkTAPwPKJpwCpSBfOaDyXyIh5iiCaxapepy/aEQ==
X-Received: by 2002:a81:6606:0:b0:541:7e07:ed65 with SMTP id a6-20020a816606000000b005417e07ed65mr6790710ywc.5.1682292059112;
        Sun, 23 Apr 2023 16:20:59 -0700 (PDT)
Received: from fedora.. ([198.136.190.5])
        by smtp.gmail.com with ESMTPSA id z205-20020a0dd7d6000000b0054f856bdc4dsm2607352ywd.38.2023.04.23.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 16:20:58 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.15 v4 5/5] counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
Date:   Sun, 23 Apr 2023 19:20:47 -0400
Message-Id: <20230423232047.12589-5-william.gray@linaro.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423232047.12589-1-william.gray@linaro.org>
References: <20230423232047.12589-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4aa3b75c74603c3374877d5fd18ad9cc3a9a62ed upstream.

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

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index e00cf156c6..ab2c49579b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -61,10 +61,6 @@ struct quad8 {
 #define QUAD8_REG_CHAN_OP 0x11
 #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
 #define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
-/* Borrow Toggle flip-flop */
-#define QUAD8_FLAG_BT BIT(0)
-/* Carry Toggle flip-flop */
-#define QUAD8_FLAG_CT BIT(1)
 /* Error flag */
 #define QUAD8_FLAG_E BIT(4)
 /* Up/Down flag */
@@ -97,6 +93,9 @@ struct quad8 {
 #define QUAD8_CMR_QUADRATURE_X2 0x10
 #define QUAD8_CMR_QUADRATURE_X4 0x18
 
+/* Each Counter is 24 bits wide */
+#define LS7267_CNTR_MAX GENMASK(23, 0)
+
 static int quad8_signal_read(struct counter_device *counter,
 			     struct counter_signal *signal,
 			     enum counter_signal_level *level)
@@ -121,17 +120,9 @@ static int quad8_count_read(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
 	int i;
 
-	flags = inb(base_offset + 1);
-	borrow = flags & QUAD8_FLAG_BT;
-	carry = !!(flags & QUAD8_FLAG_CT);
-
-	/* Borrow XOR Carry effectively doubles count range */
-	*val = (unsigned long)(borrow ^ carry) << 24;
+	*val = 0;
 
 	mutex_lock(&priv->lock);
 
@@ -154,8 +145,7 @@ static int quad8_count_write(struct counter_device *counter,
 	const int base_offset = priv->base + 2 * count->id;
 	int i;
 
-	/* Only 24-bit values are supported */
-	if (val > 0xFFFFFF)
+	if (val > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	mutex_lock(&priv->lock);
@@ -627,8 +617,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 
-	/* Only 24-bit values are supported */
-	if (preset > 0xFFFFFF)
+	if (preset > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	mutex_lock(&priv->lock);
@@ -654,8 +643,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 		*ceiling = priv->preset[count->id];
 		break;
 	default:
-		/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
-		*ceiling = 0x1FFFFFF;
+		*ceiling = LS7267_CNTR_MAX;
 		break;
 	}
 
@@ -669,8 +657,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 
-	/* Only 24-bit values are supported */
-	if (ceiling > 0xFFFFFF)
+	if (ceiling > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	mutex_lock(&priv->lock);

base-commit: 3299fb36854fdc288bddc2c4d265f8a2e5105944
-- 
2.40.0

