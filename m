Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6121693988
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBLTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBLTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:01:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA511154
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:01:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n10so84967ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFcY+bgKoDrC/H0bVLU6it2ZHgkh/f7Ekd9zsWQOEVc=;
        b=dNK2qmmHCtAzB4KpGYlLCtqr9R7St2AoRSxXm4HFC4HAui/u3fd0DgrzSQvGx4gMTY
         f2MST7yFwHDr5Nzv3Pjp0aNT81xgWJYOVAG6dr9FwMzEEgQzvhSw/lQdTuXhTkULZ0ej
         ibUOViY0qUP0lflvXT8J01bXIV/HiRehhQz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFcY+bgKoDrC/H0bVLU6it2ZHgkh/f7Ekd9zsWQOEVc=;
        b=m2Oz26bnUTOXmM95N+8s7zv7RtT9WH5GjYiO2W4qfJGDifyAcP6sAcycW3JhALhp5j
         mGPRZO/iFXeP315A86toK11z6MKwDbE/qSSMWSmN1ZSiab64rl2BkE3olGQdawnCyYIn
         Uapy+QrwBXYZP9dt+Ls6s7NJqLoP5pZpGFzxRnb03HmUI6mleA824RhhtmqNjzXryeVS
         GEn8bxi3HL9ixPuaDA0usGyH5ilaEWiol3RDyjvAJSPEmz4RhDaiZ5ohEnfIZu3EGo+H
         NfPbIf2sVy7cPBbiBhTW34e3RxF0EboVDU12LkNDnlwDEtTzL9MV5Gu1ZyxHNV50blcX
         eY2A==
X-Gm-Message-State: AO0yUKUm7iWzWTDvft8h9i72J2Rpk4u3MP1vVdrFPNPwnj4EWKZK9t58
        YjzOTh35106UlK5rP/gGtCy7/AGeQe/G0IzDDNDxjw==
X-Google-Smtp-Source: AK7set8TUPodI0WDiQv04uyLfevxRr6Y899ajMBpnUoSIHzm/tFITh4mMDLIHgAnzXnyxZ4Ho7MO7Q==
X-Received: by 2002:a17:906:4483:b0:84d:4e4f:1f85 with SMTP id y3-20020a170906448300b0084d4e4f1f85mr22610930ejo.59.1676228481102;
        Sun, 12 Feb 2023 11:01:21 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906079a00b008966488a5f1sm5714368ejc.144.2023.02.12.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 11:01:20 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sun, 12 Feb 2023 19:00:02 +0000
Subject: [PATCH v4 4/5] HID: asus: use spinlock to protect concurrent
 accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v4-4-7860c5763c38@diag.uniroma1.it>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676228478; l=3021;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=ONfjFFZvRr7z1Z/TfoWEdeddjrbTUcDqYbO9jYkZVbc=;
 b=Dx2+LKtx4jUiOR1CtfLcBqeYzDp7LxXsNtwhbZ5nk0ZMEVNfgjgzvSnTvqrur3DasjLfkd+Gh6yo
 oMFS4LnSAlEdntvAlTcYXH/YfYHU//dJuxg60fk9exdjq/UOI7MI
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asus driver has a worker that may access data concurrently.
Proct the accesses using a spinlock.

Fixes: af22a610bc38 ("HID: asus: support backlight on USB keyboards")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-asus.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f99752b998f3..9f767baf39fb 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -98,6 +98,7 @@ struct asus_kbd_leds {
 	struct hid_device *hdev;
 	struct work_struct work;
 	unsigned int brightness;
+	spinlock_t lock;
 	bool removed;
 };
 
@@ -495,7 +496,12 @@ static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
 {
 	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
 						 cdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&led->lock, flags);
 	led->brightness = brightness;
+	spin_unlock_irqrestore(&led->lock, flags);
+
 	schedule_work(&led->work);
 }
 
@@ -503,8 +509,14 @@ static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
 {
 	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
 						 cdev);
+	enum led_brightness brightness;
+	unsigned long flags;
 
-	return led->brightness;
+	spin_lock_irqsave(&led->lock, flags);
+	brightness = led->brightness;
+	spin_unlock_irqrestore(&led->lock, flags);
+
+	return brightness;
 }
 
 static void asus_kbd_backlight_work(struct work_struct *work)
@@ -512,11 +524,14 @@ static void asus_kbd_backlight_work(struct work_struct *work)
 	struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
 	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
 	int ret;
+	unsigned long flags;
 
 	if (led->removed)
 		return;
 
+	spin_lock_irqsave(&led->lock, flags);
 	buf[4] = led->brightness;
+	spin_unlock_irqrestore(&led->lock, flags);
 
 	ret = asus_kbd_set_report(led->hdev, buf, sizeof(buf));
 	if (ret < 0)
@@ -584,6 +599,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	drvdata->kbd_backlight->cdev.brightness_set = asus_kbd_backlight_set;
 	drvdata->kbd_backlight->cdev.brightness_get = asus_kbd_backlight_get;
 	INIT_WORK(&drvdata->kbd_backlight->work, asus_kbd_backlight_work);
+	spin_lock_init(&drvdata->kbd_backlight->lock);
 
 	ret = devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
 	if (ret < 0) {
@@ -1119,9 +1135,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void asus_remove(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (drvdata->kbd_backlight) {
+		spin_lock_irqsave(&drvdata->kbd_backlight->lock, flags);
 		drvdata->kbd_backlight->removed = true;
+		spin_unlock_irqrestore(&drvdata->kbd_backlight->lock, flags);
+
 		cancel_work_sync(&drvdata->kbd_backlight->work);
 	}
 

-- 
2.25.1

