Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256AE6D3607
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDBIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDBIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:00:27 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B281880E;
        Sun,  2 Apr 2023 01:00:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cr18so21794254qtb.0;
        Sun, 02 Apr 2023 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680422422;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dy8HvHE4RoQ5W5VgZ8NL1BewhxcyNYFvoeSUDwy6qcA=;
        b=ZvrvE6OM1NL8+eXIJ2nBDO4ZOTulO92sfA7H2VLEZFIEwMFXvRiyCi7d+L+ZCxi6kZ
         0H4gsJk1xu0SmU2LU2+8fCGGbscRu9URk8lKGjZqdQ5Qesrzb5kgD6DySJpYS0cJLARq
         Phhk3oaauLnt2DHtjQv96e6klJM2gvT8thoxiV61FBstyRw2o8lZUUQ6zhdEewR6Ib7L
         25Bc/+IZ/0VgOy2gfda6Q6EBk/t5G1b0DG2pmyUsQrUB/7PoORDgUJz/tKg0Qy0d3dlT
         XdjM0emeQxtyr4pMGN5Hqoe561+uQYLYmtzqdFICUbpI9tO1V5H287kpHdv+Re0HrJQW
         5J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680422422;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dy8HvHE4RoQ5W5VgZ8NL1BewhxcyNYFvoeSUDwy6qcA=;
        b=EEIH3P5WHmAmktCgJgHkMd5W1aD17I/X+Yp3wK7f4qt68OZdslhzhHUx6jBUffwfd7
         Fj4PFD1j+91lfNBIQgkfACM/4a3ygLP7C5Hy7OzIkRw6BEtgncqhzRHWXSIrQTYUjnWT
         I5YD4HSk2jUoZoeXveztrDwKdKFwllWg52BIhybFpFSNogpj5tiToG8T7NGIAUCxiPPC
         PXeQcBeLZsaE3WQp2ZZLCRrYPjFCmJvl1q9SmkcDqg7LgeL3NpUwvSz6T51BLO3UtxPg
         LNj6AAIz7M0WE3xnOE+863YGMQejy5VEWW+wGVv451NSKvvxzHPrfx0tG+eeJxdWQI5f
         af+A==
X-Gm-Message-State: AO0yUKUIISjk6PxiL3NB0NFaXwcG/aV2D3hESudLRZEgcs9uOm+pMCjG
        3wQW4blb8lNbkiCaBtDD5Ak=
X-Google-Smtp-Source: AK7set+xrQls7YYWxLnyxdVMqtiUNF6RqXu5kepS4+1WNb78e6X7L5+U2HK9//cCSlruZX7SCv9oBw==
X-Received: by 2002:a05:622a:454:b0:3b8:6a92:c8d6 with SMTP id o20-20020a05622a045400b003b86a92c8d6mr51579440qtx.60.1680422422034;
        Sun, 02 Apr 2023 01:00:22 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a0b5500b0074236d3a149sm1921849qkg.92.2023.04.02.01.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 01:00:21 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Sun, 02 Apr 2023 10:00:14 +0200
Subject: [PATCH v5] Input: tsc2007 - enable cansleep pendown GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-tsc2007-sleep-v5-1-fc55e76d0ced@skidata.com>
X-B4-Tracking: v=1; b=H4sIAA02KWQC/32OzYrDIBRGX6W4rsXfGGfV9xi6uOpNI22SohI6l
 Lz7aGA2A+3ycDnnfi+SMUXM5OvwIgnXmOMyV9DHA/EjzFekMVQmggnJpOhpyV4wZmi+Iz7o0Gm
 rJaAUgZHqOMhIXYLZj82aIBdM7fBIOMTn/uj7UnlIy0TLmBD+8oIZrplRWqqT5LzrTE85dQ4SW
 Hm+ThDvJ79MLTbGXJb0s49eZUu+27fK2tBWceyDZ4rzc77FAAX2VBuyqo++qr7AgFagt87887d
 t+wX+/oimQgEAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     hns@goldelico.com, richard.leitner@linux.dev,
        christophe.jaillet@wanadoo.fr, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@linux.dev>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

When a hard IRQ is triggered, the soft IRQ, which decides if an actual
pen down happened, should always be triggered. This enables the usage of
"can_sleep" GPIO chips as "pen down" GPIO, as the value is not read
during the hard IRQ anymore. This might be the case if the GPIO chip is
an expander behind i2c.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Hi!

Thanks for the feedback! The change unfortunately somehow got lost
during patch preparations - sorry for that. Here is the corrected
version with the missing part.

v4: https://lore.kernel.org/all/20230328-tsc2007-sleep-v4-1-2ede92ec9b71@skidata.com/

----
v5:
- actually use the can_sleep getter

v4:
- don't read value in hard IRQ

v3:
- extend commit message

v2:
- fix style mentioned by Christophe
---
 drivers/input/touchscreen/tsc2007_core.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 3c793fb70a0e..21916a30fb76 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -172,19 +172,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
-{
-	struct tsc2007 *ts = handle;
-
-	if (tsc2007_is_pen_down(ts))
-		return IRQ_WAKE_THREAD;
-
-	if (ts->clear_penirq)
-		ts->clear_penirq();
-
-	return IRQ_HANDLED;
-}
-
 static void tsc2007_stop(struct tsc2007 *ts)
 {
 	ts->stopped = true;
@@ -226,7 +213,7 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tsc2007 *ts = i2c_get_clientdata(client);
 
-	return gpiod_get_value(ts->gpiod);
+	return gpiod_get_value_cansleep(ts->gpiod);
 }
 
 static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
@@ -376,7 +363,7 @@ static int tsc2007_probe(struct i2c_client *client)
 	}
 
 	err = devm_request_threaded_irq(&client->dev, ts->irq,
-					tsc2007_hard_irq, tsc2007_soft_irq,
+					NULL, tsc2007_soft_irq,
 					IRQF_ONESHOT,
 					client->dev.driver->name, ts);
 	if (err) {

---
base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
change-id: 20230328-tsc2007-sleep-f65953ae32d0

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

