Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F2693986
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBLTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBLTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:01:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E2111143
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:01:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p26so26954075ejx.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B88ResL5MKyi+eeaFgmYo0rRmsmI1uZYG2og4OKsozA=;
        b=WAS4+1vax/pjuTBuGl3DbIy3p6dvxT7L99NbfEeWm1CBRL12bh8TVDsO68DB+d1nZn
         F8GeVyJKtte/6vyFoF8BwDLFsQ7hhmy5zTX9GdriGouBSxNZ12PUMPPwen9ycWXUIV6a
         U05xBD7Sh+Uue52xEsuemKC+z6BSoz0YpkPEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B88ResL5MKyi+eeaFgmYo0rRmsmI1uZYG2og4OKsozA=;
        b=J9N8QFALujImjZ85ThlCUGJwpFTKHH6+91Bh2pIQE5ZATyxJjnADaQ0DysoNLPrhwJ
         +B8zh3cy5XRqaVOTMRGnhunAtCIqciG791t/FUpJyfqiAEfXYdRKslPZvtZqLUbq5pVW
         JFXfcdCHXuYZ0vrIrhxu3L1IcGIF+jNvO3y7Nhw+9xp50k2H5Bjz16VpzFNdEMf8j2Yw
         krjR3QH7R5DRoSN/XB+2ow2xELLt4S/X/6QhUWeCcCPhXNrZIYG9U/vGAnGl14F8YPZu
         NsIsahFSCpX4OfsGP5fPrq0q7anXu5IUi81XAxvr3tNl1/gPsWLTJn4c9Jkum6gn4ZBb
         hFuA==
X-Gm-Message-State: AO0yUKW6zJ1dxCKlgJXzHxvjaektgttRgj5i26cthwLrXX1qzIEenyyo
        qxdg9tdKFMk/xA2p17+Hg4ncBg==
X-Google-Smtp-Source: AK7set9i8cFESlwh12jM8HFp2TGIicjd7Mu0Kma6JgyT/L8YrweE8xeYb9h9I7iYUGuJRN7kVBGjYQ==
X-Received: by 2002:a17:906:2cc4:b0:878:5372:a34b with SMTP id r4-20020a1709062cc400b008785372a34bmr22015554ejr.45.1676228479445;
        Sun, 12 Feb 2023 11:01:19 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906079a00b008966488a5f1sm5714368ejc.144.2023.02.12.11.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 11:01:19 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sun, 12 Feb 2023 18:59:59 +0000
Subject: [PATCH v4 1/5] HID: bigben: use spinlock to protect concurrent
 accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v4-1-7860c5763c38@diag.uniroma1.it>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676228478; l=5460;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=3NArKOjH3xImJ9Rwlp+QDLBUcHoiaaOhmhkn3ROIjHE=;
 b=5px4vRLV1eHL9HPgHtUpqWdWAIbITrvZlNReB8lV8M7fRjdYnermUhmYbbfbMdNKGeqd8AIo0TJ4
 4fV5N/U4ArgruGb2zOKlTr/MGyYxX0jX8DQH1EOcN8et+elaRkjN
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

bigben driver has a worker that may access data concurrently.
Proct the accesses using a spinlock.

Fixes: 256a90ed9e46 ("HID: hid-bigbenff: driver for BigBen Interactive PS3OFMINIPAD gamepad")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-bigbenff.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index e8b16665860d..ed3d2d7bc1dd 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -174,6 +174,7 @@ static __u8 pid0902_rdesc_fixed[] = {
 struct bigben_device {
 	struct hid_device *hid;
 	struct hid_report *report;
+	spinlock_t lock;
 	bool removed;
 	u8 led_state;         /* LED1 = 1 .. LED4 = 8 */
 	u8 right_motor_on;    /* right motor off/on 0/1 */
@@ -190,12 +191,27 @@ static void bigben_worker(struct work_struct *work)
 	struct bigben_device *bigben = container_of(work,
 		struct bigben_device, worker);
 	struct hid_field *report_field = bigben->report->field[0];
+	bool do_work_led = false;
+	bool do_work_ff = false;
+	u8 *buf;
+	u32 len;
+	unsigned long flags;
 
 	if (bigben->removed || !report_field)
 		return;
 
+	buf = hid_alloc_report_buf(bigben->report, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	len = hid_report_len(bigben->report);
+
+	/* LED work */
+	spin_lock_irqsave(&bigben->lock, flags);
+
 	if (bigben->work_led) {
 		bigben->work_led = false;
+		do_work_led = true;
 		report_field->value[0] = 0x01; /* 1 = led message */
 		report_field->value[1] = 0x08; /* reserved value, always 8 */
 		report_field->value[2] = bigben->led_state;
@@ -204,11 +220,22 @@ static void bigben_worker(struct work_struct *work)
 		report_field->value[5] = 0x00; /* padding */
 		report_field->value[6] = 0x00; /* padding */
 		report_field->value[7] = 0x00; /* padding */
-		hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
+		hid_output_report(bigben->report, buf);
+	}
+
+	spin_unlock_irqrestore(&bigben->lock, flags);
+
+	if (do_work_led) {
+		hid_hw_raw_request(bigben->hid, bigben->report->id, buf, len,
+				   bigben->report->type, HID_REQ_SET_REPORT);
 	}
 
+	/* FF work */
+	spin_lock_irqsave(&bigben->lock, flags);
+
 	if (bigben->work_ff) {
 		bigben->work_ff = false;
+		do_work_ff = true;
 		report_field->value[0] = 0x02; /* 2 = rumble effect message */
 		report_field->value[1] = 0x08; /* reserved value, always 8 */
 		report_field->value[2] = bigben->right_motor_on;
@@ -217,8 +244,17 @@ static void bigben_worker(struct work_struct *work)
 		report_field->value[5] = 0x00; /* padding */
 		report_field->value[6] = 0x00; /* padding */
 		report_field->value[7] = 0x00; /* padding */
-		hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
+		hid_output_report(bigben->report, buf);
+	}
+
+	spin_unlock_irqrestore(&bigben->lock, flags);
+
+	if (do_work_ff) {
+		hid_hw_raw_request(bigben->hid, bigben->report->id, buf, len,
+				   bigben->report->type, HID_REQ_SET_REPORT);
 	}
+
+	kfree(buf);
 }
 
 static int hid_bigben_play_effect(struct input_dev *dev, void *data,
@@ -228,6 +264,7 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
 	struct bigben_device *bigben = hid_get_drvdata(hid);
 	u8 right_motor_on;
 	u8 left_motor_force;
+	unsigned long flags;
 
 	if (!bigben) {
 		hid_err(hid, "no device data\n");
@@ -242,9 +279,12 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
 
 	if (right_motor_on != bigben->right_motor_on ||
 			left_motor_force != bigben->left_motor_force) {
+		spin_lock_irqsave(&bigben->lock, flags);
 		bigben->right_motor_on   = right_motor_on;
 		bigben->left_motor_force = left_motor_force;
 		bigben->work_ff = true;
+		spin_unlock_irqrestore(&bigben->lock, flags);
+
 		schedule_work(&bigben->worker);
 	}
 
@@ -259,6 +299,7 @@ static void bigben_set_led(struct led_classdev *led,
 	struct bigben_device *bigben = hid_get_drvdata(hid);
 	int n;
 	bool work;
+	unsigned long flags;
 
 	if (!bigben) {
 		hid_err(hid, "no device data\n");
@@ -267,6 +308,7 @@ static void bigben_set_led(struct led_classdev *led,
 
 	for (n = 0; n < NUM_LEDS; n++) {
 		if (led == bigben->leds[n]) {
+			spin_lock_irqsave(&bigben->lock, flags);
 			if (value == LED_OFF) {
 				work = (bigben->led_state & BIT(n));
 				bigben->led_state &= ~BIT(n);
@@ -274,6 +316,7 @@ static void bigben_set_led(struct led_classdev *led,
 				work = !(bigben->led_state & BIT(n));
 				bigben->led_state |= BIT(n);
 			}
+			spin_unlock_irqrestore(&bigben->lock, flags);
 
 			if (work) {
 				bigben->work_led = true;
@@ -307,8 +350,12 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
 static void bigben_remove(struct hid_device *hid)
 {
 	struct bigben_device *bigben = hid_get_drvdata(hid);
+	unsigned long flags;
 
+	spin_lock_irqsave(&bigben->lock, flags);
 	bigben->removed = true;
+	spin_unlock_irqrestore(&bigben->lock, flags);
+
 	cancel_work_sync(&bigben->worker);
 	hid_hw_stop(hid);
 }
@@ -362,6 +409,7 @@ static int bigben_probe(struct hid_device *hid,
 	set_bit(FF_RUMBLE, hidinput->input->ffbit);
 
 	INIT_WORK(&bigben->worker, bigben_worker);
+	spin_lock_init(&bigben->lock);
 
 	error = input_ff_create_memless(hidinput->input, NULL,
 		hid_bigben_play_effect);

-- 
2.25.1

