Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCB691500
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBIX7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBIX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:59:02 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C1D56EFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:58:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qb15so9486684ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdbMGzrRc8LDNDumfc9xBhICdUvlCcLYTrnDicQI/uI=;
        b=iZEvxitkI76QJtUhzk3xKX/4EPowsvl34KB9wqntEq4yuICsE2lG0hZDRWnrdY8kiu
         9+FII9iaTX1nqznQnMDq9H2ZblSYgJs8M2hJDhr5oAx5b4xwpnlbp3159acgb3uZaLHz
         9gMGregBPode/jZNDNY61M2JaxNfq0zQ0/cL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdbMGzrRc8LDNDumfc9xBhICdUvlCcLYTrnDicQI/uI=;
        b=mgBoxSy5v9SPQk3u/RVCQbjpvTSksW3PSo04gEsl0eGPwBU20NL00SvMedGwDKOCXs
         pfuTPjc8ueX4zzIkQ+htdQLc6vRs3yR+u5qGSIF7/oRwPYr/rXA1fwW/UqaTFK9PTh9H
         CXmyKXO8Qw6E8/mK8m7ES5G1TTMvmq5bgWZKVFmv6aGboU6mhKDsELn4qlKM9MXGtFzr
         O4YuI9ikHcdzjmGemo7QjVUOpFHRqbuLIQbwMuxtb+wkYfUTcdLkjfukOPhiWneKn/6H
         RBncDWR2mXXZe3AkI36kOB/WBn0SBK+WfKmb8MP6Rj/aPtelKJjw6ucW4eUo8cS99jG/
         3xAQ==
X-Gm-Message-State: AO0yUKVHAsyNQuOAo2udMer36qc8M/TIP8qJqKey63BdjB76AriWHBlu
        gvpdOpCrj8F5hT2tyBY2Xc04vQ==
X-Google-Smtp-Source: AK7set+GrLbFJZDTcwJI/wZkTwNLZg7fQ7UY4vfNSAVWU+vnDfawBhQ26ctzBcy3UkjAkshi059wzA==
X-Received: by 2002:a17:906:d92:b0:88a:a09d:e673 with SMTP id m18-20020a1709060d9200b0088aa09de673mr12958032eji.31.1675987136696;
        Thu, 09 Feb 2023 15:58:56 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b0084c6ec69a9dsm1528177ejb.124.2023.02.09.15.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:58:56 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Thu, 09 Feb 2023 23:58:55 +0000
Subject: [PATCH v3 1/2] HID: bigben: use spinlock to safely schedule
 workers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v3-1-0a52ac225e00@diag.uniroma1.it>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675987135; l=4759;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=q65DuWimKWU3Wcj6tgEaabi1e6T/ANMNxvlhUu1UoEE=;
 b=RyPUT+ZOAScekoh6qrPJ9YICAO7xxeCffbjKBmnLlGmLHTuP9bs5Ddv4qLA3VvcpDiSev3TMxYGW
 bxy8fUcIBl3AEEsI0sPnpEOY3i/76etzKjW28OM6YEZQGCT+O28a
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
 drivers/hid/hid-bigbenff.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index e8b16665860d..28769aa7fed6 100644
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
@@ -184,15 +185,24 @@ struct bigben_device {
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
 	struct bigben_device *bigben = container_of(work,
 		struct bigben_device, worker);
 	struct hid_field *report_field = bigben->report->field[0];
+	unsigned long flags;
 
-	if (bigben->removed || !report_field)
-		return;
+	spin_lock_irqsave(&bigben->lock, flags);
 
 	if (bigben->work_led) {
 		bigben->work_led = false;
@@ -219,6 +229,8 @@ static void bigben_worker(struct work_struct *work)
 		report_field->value[7] = 0x00; /* padding */
 		hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
 	}
+
+	spin_unlock_irqrestore(&bigben->lock, flags);
 }
 
 static int hid_bigben_play_effect(struct input_dev *dev, void *data,
@@ -228,6 +240,7 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
 	struct bigben_device *bigben = hid_get_drvdata(hid);
 	u8 right_motor_on;
 	u8 left_motor_force;
+	unsigned long flags;
 
 	if (!bigben) {
 		hid_err(hid, "no device data\n");
@@ -242,10 +255,13 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
 
 	if (right_motor_on != bigben->right_motor_on ||
 			left_motor_force != bigben->left_motor_force) {
+		spin_lock_irqsave(&bigben->lock, flags);
 		bigben->right_motor_on   = right_motor_on;
 		bigben->left_motor_force = left_motor_force;
 		bigben->work_ff = true;
-		schedule_work(&bigben->worker);
+		spin_unlock_irqrestore(&bigben->lock, flags);
+
+		bigben_schedule_work(bigben);
 	}
 
 	return 0;
@@ -259,6 +275,7 @@ static void bigben_set_led(struct led_classdev *led,
 	struct bigben_device *bigben = hid_get_drvdata(hid);
 	int n;
 	bool work;
+	unsigned long flags;
 
 	if (!bigben) {
 		hid_err(hid, "no device data\n");
@@ -267,6 +284,7 @@ static void bigben_set_led(struct led_classdev *led,
 
 	for (n = 0; n < NUM_LEDS; n++) {
 		if (led == bigben->leds[n]) {
+			spin_lock_irqsave(&bigben->lock, flags);
 			if (value == LED_OFF) {
 				work = (bigben->led_state & BIT(n));
 				bigben->led_state &= ~BIT(n);
@@ -274,10 +292,11 @@ static void bigben_set_led(struct led_classdev *led,
 				work = !(bigben->led_state & BIT(n));
 				bigben->led_state |= BIT(n);
 			}
+			spin_unlock_irqrestore(&bigben->lock, flags);
 
 			if (work) {
 				bigben->work_led = true;
-				schedule_work(&bigben->worker);
+				bigben_schedule_work(bigben);
 			}
 			return;
 		}
@@ -307,8 +326,12 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
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
@@ -362,6 +385,7 @@ static int bigben_probe(struct hid_device *hid,
 	set_bit(FF_RUMBLE, hidinput->input->ffbit);
 
 	INIT_WORK(&bigben->worker, bigben_worker);
+	spin_lock_init(&bigben->lock);
 
 	error = input_ff_create_memless(hidinput->input, NULL,
 		hid_bigben_play_effect);
@@ -402,7 +426,7 @@ static int bigben_probe(struct hid_device *hid,
 	bigben->left_motor_force = 0;
 	bigben->work_led = true;
 	bigben->work_ff = true;
-	schedule_work(&bigben->worker);
+	bigben_schedule_work(bigben);
 
 	hid_info(hid, "LED and force feedback support for BigBen gamepad\n");
 

-- 
2.25.1

