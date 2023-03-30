Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A016D0E62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjC3TLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjC3TLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:11:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39301EC58;
        Thu, 30 Mar 2023 12:11:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cj15so12038328qtb.5;
        Thu, 30 Mar 2023 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680203463;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/La1NUClP9IMQiiLt2X44fMAY95yDMjmZuDa4nNgHL0=;
        b=qrYDDnpIkI8YoAv4P7urp8V9gsKqxgEruszvIyPong9+IeYqHY92YkCunZXe+kg9FX
         OReDSgMb+RiEYyRBfj7vL0Osep1aXlMQYUPbbyhbWYxw7rs7Uj1zfFH1qsOYotRFGfE+
         GGmA538TFpFZP998OIFvah4Zb0+SSL/Sb25j/TeOD8FTjkAB7E5554s/zr/KnCYa89mj
         w+wA4+tf+eRy3Ix29dW/fSibqPoqpeaWjT9Oq2yuNpJIqwPyBX4/AXZlbzW0FG7Mpa5r
         A46qAuXuVGbc0Vrg/dNXOpxAEdu1cNL2Y1ET7hrnFdsVltxZjPeVbMAym5SCTB5WtdDo
         6ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203463;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/La1NUClP9IMQiiLt2X44fMAY95yDMjmZuDa4nNgHL0=;
        b=zrcSs+YAzzbVRqHUCTHRqonM1aqeFHD8sh+LTH70CrxQL1v3MW2zuLYgr+r7g6W2is
         2d+bJzbahzjrnbecg/4W+8/nN60rCh8Hv4j8GE5Oud3EVAIunfH6ZmKE6oiHDwRJzzp2
         oH1gCmnmcXAI1AzHiAUNTmwynEzZBmZwqVObmEV2+1tKjhgQ9PwiG/y1d/2h8Qg5ET7h
         dA7Mnw5pJBuwSp1FxnqUBl1NACBKZy44cXsaxX3trYhpD4APrwoCy/c+4IaksfzVD+Uk
         HZpqPfMfelQpqzUvaG0xQxM13ECOkZGXUXqrYRjL4bG/dM98f0NzLQFU+6LbKDOXvaD4
         de9g==
X-Gm-Message-State: AO0yUKVviQbYg5+59VH+uT2YPjAdFZ7pXUlpsRKmVKvC1/DkcGO4oobT
        wSZVxvKo8Uu2cxhtBAqCJBrZ6ftnzQkEiw==
X-Google-Smtp-Source: AK7set9edRopzZ9YfOtxBokYW9pjyewn5J0/eaf79P/YBKQ8RLqpbrPZnNrMcc287BIqlT6wwL9fXQ==
X-Received: by 2002:ac8:7c45:0:b0:3b8:6763:c25f with SMTP id o5-20020ac87c45000000b003b86763c25fmr41723668qtv.13.1680203463283;
        Thu, 30 Mar 2023 12:11:03 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a2a5500b007426ec97253sm70223qkp.111.2023.03.30.12.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:11:02 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 30 Mar 2023 21:10:37 +0200
Subject: [PATCH v4] Input: tsc2007 - enable cansleep pendown GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-tsc2007-sleep-v4-1-2ede92ec9b71@skidata.com>
X-B4-Tracking: v=1; b=H4sIAKzeJWQC/3WOS4rDMBBErxK0HgVJLfmTVe4xZNGW27GY2A7dw
 kwIvntkwyxn+SjqVb2VECcSdTm9FdOaJC1zAf91UnHE+U469YWVMw4MuEZnic6YWsuD6KmHKrQ
 BkMD1RpVOh0K6Y5zjuLcmlEy8B0+mIf0eQ9+3wgMvk84jE/7pnaltMLUP4M9gbVXVjba665Cxh
 et9wvQ4x2XaZWOSvPDrOL3Crvzv3wrFEVpvqemj8dZe5Sf1mPFQ3bZt+wAGetbDAgEAAA==
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

I found a different approach to my problem:
If the primary IRQ handler is set to NULL, the default primary IRQ
handler simply triggers a soft IRQ handler wake up. As the hard IRQ is
only triggered when a pen down is detected, the gpiod_get_value() inside
tsc2007_is_pen_down() always returns true and therefore can be
neglected.

v3: https://lore.kernel.org/lkml/20230328-tsc2007-sleep-v3-1-5941e8dc0411@skidata.com/

----
v4:
- don't read value in hard IRQ

v3:
- extend commit message

v2:
- fix style mentioned by Christophe
---
 drivers/input/touchscreen/tsc2007_core.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 3c793fb70a0e..fa4a71e3ad52 100644
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

