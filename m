Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387D610A73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJ1Gm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJ1Glz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:41:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C528315B315
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:41:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so2861380wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOXFaSkWoyrw6Tt6vNYB3VyEMNdaD+r0RNnUIhwjbV4=;
        b=hlBRFUsLCdqMdTgZgiy8f2LWBebmnYV7rKsjNbrWKuXIv3R/p2b/1i0zrEemBe9RRv
         vhm3hqD2tFpHWJpEm8wIamSktSw+2g5kNddNqfDChYHHpCARKBph32HwQtXNagQFvluO
         xrBByMrNN22DC0KBBEqi3dQdmUiNdVc+KQERxKlRaVk3kn53yWxZfVoJauaop7wrNAT2
         mQmdWYK1sYzH5XMdzFDjSb3Hpu6vFE2s6VcyqBsQmL1OMeZhPhDyybjnlpTa0Ici/ywf
         hDORZPPU9KlMhOMNmpF4GNT3W/SUvspujJXxwpwWHUTSXKGPaIXjVP3XUjd+Lcny6lLW
         G9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOXFaSkWoyrw6Tt6vNYB3VyEMNdaD+r0RNnUIhwjbV4=;
        b=c1gV1JjbXFBMEXRDksuj0MtbsywfC33pVBNKfcwaoEpHMcYfVXQZPH2Cr4T+VlSYxS
         dc4MXOrA9zPpP7HEkdSMmEoiuE27of6EOKX/YZ/H5wUDF6Ig/mY1qA0voQbg9Z7uqhco
         URZ2AoFB12JTDsHxcjvw9M1AbbIDtpe40ExA5i3U2wkLu2q6WH2zjBVCKZQq/Asiq6An
         P0n4ROfRfg5Gsie9UzXbuQE3csk66tTWt1pNmeqYelAcHOk9i4cgbWyEnSAmKfV/fDS1
         Q4kLHGURIEFuDYvL3xhMu/xf6R6rRA4cnrMp+jzKB2+0HNaE/32TyLso4pkxDliTT2j7
         umNw==
X-Gm-Message-State: ACrzQf3/w9NYdhbWbdbJwdL0F+cMyKVhIwFNYe2rRKo801j6P32P3q3Y
        Pfce4TB6yjVOiveWMKN8bJUTlg==
X-Google-Smtp-Source: AMsMyM41qCS4mNKA58mLIKzckELZo4v8n6J3P17M7Hj6TEhQ7UqBUcXQ6bOItzwdX2dLYY794GCf4w==
X-Received: by 2002:a05:600c:4f84:b0:3c8:3424:8b1 with SMTP id n4-20020a05600c4f8400b003c8342408b1mr8189083wmq.53.1666939308338;
        Thu, 27 Oct 2022 23:41:48 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h17-20020a05600c351100b003c7087f6c9asm7253979wmq.32.2022.10.27.23.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 23:41:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] leds: remove ide-disk trigger
Date:   Fri, 28 Oct 2022 06:41:41 +0000
Message-Id: <20221028064141.2171405-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028064141.2171405-1-clabbe@baylibre.com>
References: <20221028064141.2171405-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No user of ide-disk remains, so remove this deprecated trigger.
Only a few platforms used this and were fixed in 2016.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- remove also DEFINE_LED_TRIGGER(ledtrig_ide)
Changes since v2:
- Added the fact that few platforms used this and it was fixed old ago.
- Added Rob's ack
V3 can be seen at https://lore.kernel.org/lkml/20220208104601.3751852-1-clabbe@baylibre.com/T/
Changes since v3:
- rebased on recent tree

 Documentation/devicetree/bindings/leds/common.yaml | 3 ---
 drivers/leds/trigger/ledtrig-disk.c                | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 8ebe602419b5..7081c7b64b94 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -92,9 +92,6 @@ properties:
           - disk-activity
           - disk-read
           - disk-write
-            # LED indicates IDE disk activity (deprecated), in new implementations
-            # use "disk-activity"
-          - ide-disk
             # LED flashes at a fixed, configurable rate
           - timer
             # LED alters the brightness for the specified duration with one software
diff --git a/drivers/leds/trigger/ledtrig-disk.c b/drivers/leds/trigger/ledtrig-disk.c
index 0741910785bb..0b7dfbd04273 100644
--- a/drivers/leds/trigger/ledtrig-disk.c
+++ b/drivers/leds/trigger/ledtrig-disk.c
@@ -16,7 +16,6 @@
 DEFINE_LED_TRIGGER(ledtrig_disk);
 DEFINE_LED_TRIGGER(ledtrig_disk_read);
 DEFINE_LED_TRIGGER(ledtrig_disk_write);
-DEFINE_LED_TRIGGER(ledtrig_ide);
 
 void ledtrig_disk_activity(bool write)
 {
@@ -24,8 +23,6 @@ void ledtrig_disk_activity(bool write)
 
 	led_trigger_blink_oneshot(ledtrig_disk,
 				  &blink_delay, &blink_delay, 0);
-	led_trigger_blink_oneshot(ledtrig_ide,
-				  &blink_delay, &blink_delay, 0);
 	if (write)
 		led_trigger_blink_oneshot(ledtrig_disk_write,
 					  &blink_delay, &blink_delay, 0);
@@ -40,7 +37,6 @@ static int __init ledtrig_disk_init(void)
 	led_trigger_register_simple("disk-activity", &ledtrig_disk);
 	led_trigger_register_simple("disk-read", &ledtrig_disk_read);
 	led_trigger_register_simple("disk-write", &ledtrig_disk_write);
-	led_trigger_register_simple("ide-disk", &ledtrig_ide);
 
 	return 0;
 }
-- 
2.37.4

