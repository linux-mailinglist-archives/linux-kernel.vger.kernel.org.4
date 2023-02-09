Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757D06914FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBIX7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBIX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:59:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817257745
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:58:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lu11so11576002ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHeWZ65g4BMWv1wpl53BAYKvu7rKoumv2nA2YEeP6jg=;
        b=UzQWu9+vMmJKCczmOAEbeSrdKvhAmFa6KOuiECJoBeZQpc29/PL26NBo6Hd+DKZ2lC
         KuTqWz6XIaV5MzitHcn7zc9SumXQkWbyF9TBcSsX1Q0DAVTRJTFOpNy9Y7srdbuWj4vZ
         v2CarUm7tvVa0Flgt5frBD/OaF7LNkr8NDhww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHeWZ65g4BMWv1wpl53BAYKvu7rKoumv2nA2YEeP6jg=;
        b=lJCgb8bn7GPNf9Cm/mqTa1hGDOw2iGPUBcMGtGO6MbmBskzHUMl2yuzJIDZN4O5COx
         CBaLKR7Ni2AOxC2NfkBPh6rtzf5z9scG8C/zzfqA/rXhEhhhludq8+TnDyb+eS2PECY8
         BtiffMr+WVH27t/Sih35GAs/YnC2wvud+cGh3DnweL8FlY4ePCGz3PGozutxfV88RYpJ
         R/JY9224uXAc3P29Q7EdXlqdCPQpuyRkjwSaf5r2XfGwpkPG9eiC2qHkv0vSIHqJtYVH
         GEKv9YCcOiVw8tFpAV7khilTEsOqYGr4I+T0gL9aKxPDFfpQTl7LTf4hdvu9hKjgOZgo
         L/1A==
X-Gm-Message-State: AO0yUKW5jahts4xZGD74R4XFCrBfF+VL1u+SoMWJuuSPPQ1Uki5WBMNw
        YUsxXD4QDZUlHW99s29xokIfRQ==
X-Google-Smtp-Source: AK7set8CpmMMo4bA7feRvqMUcm6S94eLmyUaBP/asuzG+0iTf9JFrrf8rh+xN7FpD2S+VXRzGbeSDA==
X-Received: by 2002:a17:907:c23:b0:8aa:b526:36b3 with SMTP id ga35-20020a1709070c2300b008aab52636b3mr16925820ejc.14.1675987137291;
        Thu, 09 Feb 2023 15:58:57 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b0084c6ec69a9dsm1528177ejb.124.2023.02.09.15.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:58:56 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Thu, 09 Feb 2023 23:58:56 +0000
Subject: [PATCH v3 2/2] HID: asus: use spinlock to safely schedule workers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v3-2-0a52ac225e00@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v3-0-0a52ac225e00@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v3-0-0a52ac225e00@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675987135; l=3166;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=IdfH/zx2eMB+IWRHkM7AohAvJEH/GhNAfk3hb0BMJ34=;
 b=yFzHFWPuS+supnmEZxKFZUrkALQEH4Ttl6+azLTN4F5JD2ZaTP/Ejm0jUKxR4NlKTeUXfe0ptmMU
 LyCKr1D6C5KIYPOdiTxjG+Xg4wtVm5hbQ34Y5mxE4kpLvNoJUDKS
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

Use spinlocks to deal with workers introducing a wrapper
asus_schedule_work(), and several spinlock checks.
Otherwise, asus_kbd_backlight_set() may schedule led->work after the
structure has been freed, causing a use-after-free.

Fixes: af22a610bc38 ("HID: asus: support backlight on USB keyboards")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-asus.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f99752b998f3..30e194803bd7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -98,6 +98,7 @@ struct asus_kbd_leds {
 	struct hid_device *hdev;
 	struct work_struct work;
 	unsigned int brightness;
+	spinlock_t lock;
 	bool removed;
 };
 
@@ -490,13 +491,23 @@ static int rog_nkey_led_init(struct hid_device *hdev)
 	return ret;
 }
 
+static void asus_schedule_work(struct asus_kbd_leds *led)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&led->lock, flags);
+	if (!led->removed)
+		schedule_work(&led->work);
+	spin_unlock_irqrestore(&led->lock, flags);
+}
+
 static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
 				   enum led_brightness brightness)
 {
 	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
 						 cdev);
 	led->brightness = brightness;
-	schedule_work(&led->work);
+	asus_schedule_work(led);
 }
 
 static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
@@ -512,15 +523,17 @@ static void asus_kbd_backlight_work(struct work_struct *work)
 	struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
 	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
 	int ret;
+	unsigned long flags;
 
-	if (led->removed)
-		return;
+	spin_lock_irqsave(&led->lock, flags);
 
 	buf[4] = led->brightness;
 
 	ret = asus_kbd_set_report(led->hdev, buf, sizeof(buf));
 	if (ret < 0)
 		hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
+
+	spin_unlock_irqrestore(&led->lock, flags);
 }
 
 /* WMI-based keyboard backlight LED control (via asus-wmi driver) takes
@@ -584,6 +597,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	drvdata->kbd_backlight->cdev.brightness_set = asus_kbd_backlight_set;
 	drvdata->kbd_backlight->cdev.brightness_get = asus_kbd_backlight_get;
 	INIT_WORK(&drvdata->kbd_backlight->work, asus_kbd_backlight_work);
+	spin_lock_init(&drvdata->kbd_backlight->lock);
 
 	ret = devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
 	if (ret < 0) {
@@ -1119,9 +1133,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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

