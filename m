Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88167C174
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjAZAZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:25:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0610F64685
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:25:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ss4so1045782ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOYadJvP8u49K2x2oSYl+EYqiXssZ4idBGq/e4Tz9NY=;
        b=O4V0DOQaxPn+3nnvaVO3+OedTg4H8gEUR2e+X840qxeB1rz3lPMUCUHPlScsQb9ImT
         yOEROGe1pUIaxqUwsrMKjOB9Mqj5b6UOwVGFASYzb0AVOwqDbZnExHiTorFoOWeZPaWV
         5K0fcSdfaRny3eW0RpfddFm2xA7FOcBDNEvRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOYadJvP8u49K2x2oSYl+EYqiXssZ4idBGq/e4Tz9NY=;
        b=C6MlGVazLmhCdbmOEc5NYvjQvK6jYmpWvnEPT5FrT26sMRnZS9dpRxBVc/HR07UFP0
         cyeuMlGMXMdALwRkGCcYQ6GByZSsyMnUaJ/lWLlmFY8diwfilNBkZ4P15RlIS4C2yczZ
         mKE4Yv/9yUOOxT8x+kwLLPMM3f+Z9bKGiq9VGGkNeMlttoSGbmnasO88ByEByjxse0uc
         gA3JpkvO4717ATP26qzCQUGjfuagIvggRA0ywYmDIxHMCAHikYtiDzRhXH42yJtH+CG/
         zOofTloq2i8nRLoCxIyeqCylqYzeMB9me5CSUemo+GSYmWNE7QvNn69lkeBz1o/fPFRQ
         XBdg==
X-Gm-Message-State: AFqh2kqFC5U7t8dPizr422kgBW8/rfdO4ZaP09MGxtEaWCUZsvGoX6MG
        MobU8wgY1e86GUFfJUKdkc655w==
X-Google-Smtp-Source: AMrXdXuntbpvN+806ZegH5ixi1SfuWScLJxEwEMFaUWL58CNZT81ZcYZ2PCbsG6v0BxwZvZ7PsRBtQ==
X-Received: by 2002:a17:907:76b0:b0:7c1:7045:1a53 with SMTP id jw16-20020a17090776b000b007c170451a53mr32550663ejc.15.1674692716489;
        Wed, 25 Jan 2023 16:25:16 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id jy12-20020a170907762c00b008784e808553sm555707ejc.6.2023.01.25.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 16:25:16 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Thu, 26 Jan 2023 00:24:53 +0000
Subject: [PATCH 1/5] HID: bigben_remove: manually unregister leds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-hid-unregister-leds-v1-1-9a5192dcef16@diag.uniroma1.it>
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
In-Reply-To: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Pavel Machek <pavel@ucw.cz>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674692715; l=1037;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=wlU1zbXd7qFTSbVqYvqS9BOVrqglVS3eHD1ePCtISHc=;
 b=GeizybQArtv4+HBTakrKxETsSVRvGKMNeRue1tkG2U0KcYshHgneXwski3bWn3Wnk7Dda4OEQvQ1
 jAU9iMk1B2kBNODa9HOqbXggvFc3nR73/XdctsvKQ04xtFJglhqI
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

Unregister the LED controllers before device removal, as
bigben_set_led() may schedule bigben->worker after the structure has
been freed, causing a use-after-free.

Fixes: 4eb1b01de5b9 ("HID: hid-bigbenff: fix race condition for scheduled work during removal")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-bigbenff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index e8b16665860d..d3201b755595 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -306,9 +306,14 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
 
 static void bigben_remove(struct hid_device *hid)
 {
+	int n;
 	struct bigben_device *bigben = hid_get_drvdata(hid);
 
 	bigben->removed = true;
+	for (n = 0; n < NUM_LEDS; n++) {
+		if (bigben->leds[n])
+			devm_led_classdev_unregister(&hid->dev, bigben->leds[n]);
+	}
 	cancel_work_sync(&bigben->worker);
 	hid_hw_stop(hid);
 }

-- 
2.25.1
