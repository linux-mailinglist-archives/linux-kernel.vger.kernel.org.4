Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0289680520
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjA3En2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbjA3EnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:43:25 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A428222F8;
        Sun, 29 Jan 2023 20:43:24 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 144so6842111pfv.11;
        Sun, 29 Jan 2023 20:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiNNPqaXQM9yS0J3io8bIAgUtUxZYRaSMrpFctF6XsM=;
        b=Fr/9psA8hpDY8+DJ12nrG4pU05Kt2ZHI9rrvODh/GF7dNbM7TPubpN64DtQiDgeG4r
         T6ece7USNCKJ16Op/dA0dn90RDa/vC4uj181E1KqXMHTx6TdWX0UC1e9qRQo90EZKOnT
         WjVCNqvQn4TrfxTd1Vq3IVyeyC/jfmKzkNjOWWyQ4egozDgHr938p8kV8zzxcERmcbnE
         V5to2G5douPTRHg7O+pskFlEpZkCYrMyjsjnJ5p7Y5r9+bq2vuNFBejxcMkbyhs56yoW
         4VoT8gI/4mVcepjyIci1OV3xlO+zOnBubaduP6IhNcZCvlyV3J7D4SfddE1nrICp2B8L
         1gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiNNPqaXQM9yS0J3io8bIAgUtUxZYRaSMrpFctF6XsM=;
        b=BJZUMT9Z4J/dVZTH2Yz/9wySOiVSwCVg/urCuTfYuj7AffKwQ09i4l3IUJEXYzXPlU
         HGUnJ+6QmFdHFDWIArKOzMiUrFbFLGimhAQOrepgJeIUjjISo+S94nHGkNfXzGzoQcq6
         IQAwevoDy8fkeyey/aJdC8Mbq9tFBL0IgHCVIHswECVjrg0Edtn43kREqIz/Rouk/k0a
         cYfmhaIb2/H6i8GV143fuzvqSOuIDFAK2hH/iy6F7phAekGhP79V++eMgxYLTEujJ6oL
         QapdzgCmKDwSw7uBkpVhicQtkPaYT54AjvgY2t/7Z6oURxfStaMXYirRgyppojKh/scT
         B+FA==
X-Gm-Message-State: AO0yUKW/ftESScLmDpqlfv9qU7N0de7jTxbwcqb0yQ61RBwaFZyZw3NP
        mk8EscZ3MuXCq8VXhhQypvsOTuq8IZU=
X-Google-Smtp-Source: AK7set89HDDa8uOroTLrTWtikayMyCpbHkivU3bAy3DggSf7PcnUg9T5/4dWNF/TvZTTtmKo3XgCNg==
X-Received: by 2002:aa7:8114:0:b0:590:7636:d435 with SMTP id b20-20020aa78114000000b005907636d435mr5583073pfi.13.1675053803472;
        Sun, 29 Jan 2023 20:43:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id 74-20020a62164d000000b0058b59c81a29sm6217336pfw.220.2023.01.29.20.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:43:22 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:43:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Stahl, Michael" <mstahl@moba.de>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Input: exc3000 - properly stop timer on shutdown
Message-ID: <Y9dK57BFqtlf8NmN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to stop the timer on driver unbind or probe failures, otherwise
we get UAF/Oops.

Fixes: 7e577a17f2ee ("Input: add I2C attached EETI EXC3000 multi touch driver")
Reported-by: "Stahl, Michael" <mstahl@moba.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/exc3000.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 4b7eee01c6aa..69eae79e2087 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -109,6 +109,11 @@ static inline void exc3000_schedule_timer(struct exc3000_data *data)
 	mod_timer(&data->timer, jiffies + msecs_to_jiffies(EXC3000_TIMEOUT_MS));
 }
 
+static void exc3000_shutdown_timer(void *timer)
+{
+	timer_shutdown_sync(timer);
+}
+
 static int exc3000_read_frame(struct exc3000_data *data, u8 *buf)
 {
 	struct i2c_client *client = data->client;
@@ -386,6 +391,11 @@ static int exc3000_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
+	error = devm_add_action_or_reset(&client->dev, exc3000_shutdown_timer,
+					 &data->timer);
+	if (error)
+		return error;
+
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, exc3000_interrupt, IRQF_ONESHOT,
 					  client->name, data);
-- 
2.39.1.456.gfc5497dd1b-goog


-- 
Dmitry
