Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944060628D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJTOLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJTOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:11:41 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AD1C25D1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:11:37 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so13569949qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdrdivp0kUlb9/g88sUFsnQ6F39lATr3/MrtKIKyGXw=;
        b=nm8QuSFJX4RCs7KNIS/xmx1ZXGCrI6/hVWx4sLOBhOOBGk89rUETnVz4ZmwxtzPwCG
         ecEowzSYPc8yH/hEDrxLA/twLep2a2uvOfm9HkYwNvhXeM+KO0X/kripnX7KUZGvmj2O
         JxvJuL7LX66u4aLmOQI629VblBLlKWQSy6//n52qopf4iCpulHlBdwLSRnvf/rj2rVvp
         cJ7r++rWorx9oB0trXZJmJsDCS5l/qheaSipSGT4PUtoic6Ij+8oEKmJvEndUytQAKIL
         Ri1LKmRoSgdbr22/HPmrkExK2BdXXrTOZFvZPZQrQ3ZINL/BoaHQx6nNXp/llr+E+bAm
         wC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bdrdivp0kUlb9/g88sUFsnQ6F39lATr3/MrtKIKyGXw=;
        b=E3u7BQONbR/BmeMbCi9FG7x/WxhyQSE4xRko+2C2wdh79EJgOWuCCOIRp7If8PFOIP
         f8D+nl9QVZNaY0wogKKtIhbobDX4ISJpVwV1kc8I4iaqgu2zeBjDYWO9/1wcBViIRPiX
         0smCK1WgDNZ0yuJ1x7lVmJWfR1Pobgt/8X0xd5fI/GPskj9umKNuxZ0KrxTVm5VrLUkD
         2JUm2SILnK5SUhuRd7Mimx6QEoRnA+BNmDv9tnU49CEVC8o4g4y6duRDzZtzVPvSLi9C
         x0j7+DChzP/sSgVHT7SOihBOT7tzqexLtdimwWv6sImHczbqJpfsEZexKznO+JiqQDre
         Td9g==
X-Gm-Message-State: ACrzQf21d+dHK8V22cKwGc7wuoiZuGXjga5icd6uIvmYG5iEJ4SAxyRG
        SsJmW1n+vSAVJbTXXyosNznISA==
X-Google-Smtp-Source: AMsMyM6BntJH6TKnEXiH0Sz9ePJukbyKwspoR2oupxlImKYI6I/8q4NZ2BX8ifbVq0TybA2MQt5abw==
X-Received: by 2002:a05:6214:ca8:b0:4b1:87f8:c4ef with SMTP id s8-20020a0562140ca800b004b187f8c4efmr11181151qvs.50.1666275096213;
        Thu, 20 Oct 2022 07:11:36 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a441500b006cbe3be300esm7585109qkp.12.2022.10.20.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 07:11:33 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] counter: 104-quad-8: Fix race getting function mode and direction
Date:   Thu, 20 Oct 2022 10:11:21 -0400
Message-Id: <20221020141121.15434-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
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

The quad8_action_read() function checks the Count function mode and
Count direction without first acquiring a lock. This is a race condition
because the function mode could change by the time the direction is
checked.

Because the quad8_function_read() already acquires a lock internally,
the quad8_function_read() is refactored to spin out the no-lock code to
a new quad8_function_get() function.

To resolve the race condition in quad8_action_read(), a lock is acquired
before calling quad8_function_get() and quad8_direction_read() in order
to get both function mode and direction atomically.

Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
Cc: stable@vger.kernel.org
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 64 +++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 77a863b7eefe..deed4afadb29 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -232,34 +232,45 @@ static const enum counter_function quad8_count_functions_list[] = {
 	COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
+static int quad8_function_get(const struct quad8 *const priv, const size_t id,
+			      enum counter_function *const function)
+{
+	if (!priv->quadrature_mode[id]) {
+		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
+		return 0;
+	}
+
+	switch (priv->quadrature_scale[id]) {
+	case 0:
+		*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
+		return 0;
+	case 1:
+		*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
+		return 0;
+	case 2:
+		*function = COUNTER_FUNCTION_QUADRATURE_X4;
+		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
+}
+
 static int quad8_function_read(struct counter_device *counter,
 			       struct counter_count *count,
 			       enum counter_function *function)
 {
 	struct quad8 *const priv = counter_priv(counter);
-	const int id = count->id;
 	unsigned long irqflags;
+	int retval;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	if (priv->quadrature_mode[id])
-		switch (priv->quadrature_scale[id]) {
-		case 0:
-			*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
-			break;
-		case 1:
-			*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
-			break;
-		case 2:
-			*function = COUNTER_FUNCTION_QUADRATURE_X4;
-			break;
-		}
-	else
-		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
+	retval = quad8_function_get(priv, count->id, function);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
-	return 0;
+	return retval;
 }
 
 static int quad8_function_write(struct counter_device *counter,
@@ -359,6 +370,7 @@ static int quad8_action_read(struct counter_device *counter,
 			     enum counter_synapse_action *action)
 {
 	struct quad8 *const priv = counter_priv(counter);
+	unsigned long irqflags;
 	int err;
 	enum counter_function function;
 	const size_t signal_a_id = count->synapses[0].signal->id;
@@ -374,9 +386,21 @@ static int quad8_action_read(struct counter_device *counter,
 		return 0;
 	}
 
-	err = quad8_function_read(counter, count, &function);
-	if (err)
+	spin_lock_irqsave(&priv->lock, irqflags);
+
+	/* Get Count function and direction atomically */
+	err = quad8_function_get(priv, count->id, &function);
+	if (err) {
+		spin_unlock_irqrestore(&priv->lock, irqflags);
+		return err;
+	}
+	err = quad8_direction_read(counter, count, &direction);
+	if (err) {
+		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return err;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	/* Default action mode */
 	*action = COUNTER_SYNAPSE_ACTION_NONE;
@@ -389,10 +413,6 @@ static int quad8_action_read(struct counter_device *counter,
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X1_A:
 		if (synapse->signal->id == signal_a_id) {
-			err = quad8_direction_read(counter, count, &direction);
-			if (err)
-				return err;
-
 			if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
 				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 			else
-- 
2.37.3

