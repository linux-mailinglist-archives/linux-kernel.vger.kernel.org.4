Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F360A693987
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBLTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBLTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:01:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82D1114F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:01:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rp23so26992915ejb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyokCJZIa2ZQoXHftGYbkR/Hf/+3N97gcyYGtTAHCbw=;
        b=bB8tp9fI2j5AWnUdXrllQeMkiT82AF+v/J63cnFKPFKA8Wrga377dFzJEvuhtjeeY+
         wO+ZVRco/qYOu8i0lzEhVl7LH8worGePd3VAOewZauJJZiCfYqySIp6CJJD4TujKSBeU
         aTiH+GU2OZERYYF8VI9S86XB1IzxU0GwzwN14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyokCJZIa2ZQoXHftGYbkR/Hf/+3N97gcyYGtTAHCbw=;
        b=w5SAxBZhne9nRiWcPFVicSfdGY0cF5qHO6VFz1KeJ3GPnr9Hjp4eFwaEgp3eIF2VOB
         V7aUSLyKTtMo5tVRKkPNbvjqhDioSQWhun5+V5C2BQj1u8EafqVtPyHese8oawdrLX6v
         a7U9p4GXj0v5lxCJPrzny5gEewAH6/+6TBrPcgyvI4q/tylwg/MK60Bjc2q/VaPd86ls
         RocSjoP7wItIXJXs9BlpeOo7wrW7PDR9oZ5QMZq4dNDdLqMnXBDZAWo8CeBo0W7TnDfX
         C3K48Xe/Jy5BsGSoekkZe2TsL4NYh4qxsfzO1gxQClTNkQVO2HbQ5QTjdQI+2xSCMCdq
         W5bQ==
X-Gm-Message-State: AO0yUKVbuEnyGk/ZZty14oQN/8SQLTS/kWLn5uMHwSRQBQpQJlFMg0jG
        typYNR5ESx3kdKrPa2/OJ1szLw==
X-Google-Smtp-Source: AK7set+VpPkn6J5FxG7nhuPjSQssPVHwo5+ewL9BCF15ESp2RGTGW04BS6l5dfVbmbA/pc4Y7drfMw==
X-Received: by 2002:a17:906:cb92:b0:889:5ca0:146e with SMTP id mf18-20020a170906cb9200b008895ca0146emr21753666ejb.16.1676228480557;
        Sun, 12 Feb 2023 11:01:20 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906079a00b008966488a5f1sm5714368ejc.144.2023.02.12.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 11:01:20 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sun, 12 Feb 2023 19:00:01 +0000
Subject: [PATCH v4 3/5] HID: bigben: use spinlock to safely schedule
 workers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v4-3-7860c5763c38@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v4-0-7860c5763c38@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v4-0-7860c5763c38@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>, Hanno Zulla <abos@hanno.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676228478; l=2127;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=MYGmtcK5MTdP0vFzx8JLN9Po931xJSB7z7FwhIXyl+U=;
 b=iFVDjOCX3HA+8r29BmEEv0xZGr/hxue/0Bmh0Az/QiCIXbTODweCqO5W7zIHo2HFfkW8neC2m/KO
 EOYkpQwODoIif/BHyDetJ19fzHumaoxcUUuLooAdXWrUN688K35Y
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use spinlocks to deal with workers introducing a wrapper
bigben_schedule_work(), and several spinlock checks.
Otherwise, bigben_set_led() may schedule bigben->worker after the
structure has been freed, causing a use-after-free.

Fixes: 4eb1b01de5b9 ("HID: hid-bigbenff: fix race condition for scheduled work during removal")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-bigbenff.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index b98c5f31c184..9d6560db762b 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -185,6 +185,15 @@ struct bigben_device {
 	struct work_struct worker;
 };
 
+static inline void bigben_schedule_work(struct bigben_device *bigben)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bigben->lock, flags);
+	if (!bigben->removed)
+		schedule_work(&bigben->worker);
+	spin_unlock_irqrestore(&bigben->lock, flags);
+}
 
 static void bigben_worker(struct work_struct *work)
 {
@@ -197,9 +206,6 @@ static void bigben_worker(struct work_struct *work)
 	u32 len;
 	unsigned long flags;
 
-	if (bigben->removed)
-		return;
-
 	buf = hid_alloc_report_buf(bigben->report, GFP_KERNEL);
 	if (!buf)
 		return;
@@ -285,7 +291,7 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
 		bigben->work_ff = true;
 		spin_unlock_irqrestore(&bigben->lock, flags);
 
-		schedule_work(&bigben->worker);
+		bigben_schedule_work(bigben);
 	}
 
 	return 0;
@@ -320,7 +326,7 @@ static void bigben_set_led(struct led_classdev *led,
 
 			if (work) {
 				bigben->work_led = true;
-				schedule_work(&bigben->worker);
+				bigben_schedule_work(bigben);
 			}
 			return;
 		}
@@ -450,7 +456,7 @@ static int bigben_probe(struct hid_device *hid,
 	bigben->left_motor_force = 0;
 	bigben->work_led = true;
 	bigben->work_ff = true;
-	schedule_work(&bigben->worker);
+	bigben_schedule_work(bigben);
 
 	hid_info(hid, "LED and force feedback support for BigBen gamepad\n");
 

-- 
2.25.1

