Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA175682D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjAaNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjAaNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:09:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689304F359
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:09:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mf7so22699407ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSLU5NXnF595gyXxeWDSi1UUOJiT0ePoBW3kFPldqJg=;
        b=TgjBsUPIIAq4tN9feRGWSXFsbMEDj58nrNmhPLcm8UYtMOHOp4/0TGiQxOfrEr5e1R
         IjpmRHyrmvjbBOn01c4NOZnltIE5kHzrr4/H5ipgdZvT1HfDziI25QxWLil3DqTlYXbc
         SUELTdzKzqxqmohf9wyt67/3HN3HQX2YnoJUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSLU5NXnF595gyXxeWDSi1UUOJiT0ePoBW3kFPldqJg=;
        b=QWbulO6NjJ+yxnSqo1ZU4IGJaUpvcyucGtPPrdEnwI5APUNkPge6CDHcx4VmxrPVaz
         QAhjRjRJgKhOuqhsx2bxmF2RsY1U7ihBMowI0bro6KNTwhud9loub/+KnCWN8aAa47J9
         sELFoG+SF43Rv3yhtEReeMcGk/Y2ycQ2djqKHmeltGiXx56HqDuZ8EAoLvATXHaTgxmt
         ZJMuw29YzDnY0YrVYBJiDgbly6jBqGIMd3zxulvoUSQ7Mvrkc+2jwOI8Fz0ofSEq+QyN
         EiU6cNVXVcLoMaRYMR62QOsrT1StsMj5wzSkpcVfmYK8UIXszd6MhLF+CpEc3yzHKx0U
         82MA==
X-Gm-Message-State: AFqh2kqFz6Ss9jwBTvPAn2dbTuL631UTSFWFN8ObVXAeZHIWqviRiEBt
        BJ5bDkkjt2exsguThvP6Eo0fcQ==
X-Google-Smtp-Source: AMrXdXuJ9cWrU1GrTo9lhXJQpnCgMCNtO38vDPa2itSyQ5DYq1ObFWX83kJ8A2Kg/awK6/VUMpmpYg==
X-Received: by 2002:a17:906:6846:b0:84d:2fdf:a41b with SMTP id a6-20020a170906684600b0084d2fdfa41bmr54522936ejs.50.1675170543813;
        Tue, 31 Jan 2023 05:09:03 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906391300b0088452ca0666sm4898956eje.196.2023.01.31.05.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:09:03 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Tue, 31 Jan 2023 13:08:49 +0000
Subject: [PATCH v2 5/5] HID: sony_remove: manually unregister leds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v2-5-689cc62fc878@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>
Cc:     linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675170540; l=1360;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=229FyOXnrqPun6wciRAitLA27itC/9x6aEmACwn1+hs=;
 b=8Ck9ho6y0MkvQj3h5QlnwTwQENcRw2KZSkxXIkbaRHd+HTbXacBdbpF7ABf3bbxtN28DrLjQFpZW
 TSYqKYoFCrzdxPZgCRpFzFuRuSjrIes+qSrrPtSh6ehgPH3grT0O
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

Unregister the LED controller before device removal, as
sony_led_set_brightness() may schedule sc->state_worker
after the structure has been freed, causing a use-after-free.

Fixes: 0a286ef27852 ("HID: sony: Add LED support for Sixaxis/Dualshock3 USB")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
Reviewed-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 13125997ab5e..146677c8319c 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -3083,6 +3083,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void sony_remove(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
+	int n;
 
 	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
 		del_timer_sync(&sc->ghl_poke_timer);
@@ -3100,6 +3101,13 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->hw_version_created)
 		device_remove_file(&sc->hdev->dev, &dev_attr_hardware_version);
 
+	if (sc->quirks & SONY_LED_SUPPORT) {
+		for (n = 0; n < sc->led_count; n++) {
+			if (sc->leds[n])
+				devm_led_classdev_unregister(&hdev->dev, sc->leds[n]);
+		}
+	}
+
 	sony_cancel_work_sync(sc);
 
 	sony_remove_dev_list(sc);

-- 
2.25.1
