Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8318D5F52C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJEKn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJEKnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:43:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9718858DD7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:43:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so13060019wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c2/v4Shs/DVpwaIJxuNkN3bIUQOS2jaS0UYUZOSZxKg=;
        b=Ui8cPpQJJY5mh4B9Ut/TDodgIQ5ugUeRveZLw0X2jS7EP5pCpMFyFkfTUBJISeY4q3
         fuVWcnaezvmk95fVAFphL/U75siRe7b7uWnMhxGJBFESyMQdhlolV/BqQ/R5HSsrbVzT
         loQNkdpthIGcYnSiPgmliFAA1nrT/HQoAtJHAVVUuuin0xGdpvtDmjpFbvQkGxojlnhy
         uq53sXW0jG8JR6Y3R5iE3D2eaOuccGnucUxJefvCbsgIINkLAA8OCAWmZl0Zz4NqqNp9
         v4vKArziRuSjYlgGxfpfX4MAVfQZgXZRKgbs9cZuv6BEfD+2kidAxrLUGVIqnPiN6wrc
         EwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c2/v4Shs/DVpwaIJxuNkN3bIUQOS2jaS0UYUZOSZxKg=;
        b=tSb2D+Xuyen5QTmfe8fOgS3y662UPDa6vcUPIecOJDfVZ8q1eWjkD9Z9MbCWEdqmaC
         joDB+9z5+n33hSlehBldxS9aOVPvDJ/gvUgLVDIdNWYMsPKviUwNy65o1LYySeau2U81
         0V81KbjwdjNC3YmLsQGpkMmsosF2Pfe0zQGVHqC6oy12QPrp+e2DNzeirtXbDm8dPtdQ
         kOw7vQ5ZCyUwL91VgfafmOQaWD6nyaA/M11cDmy80eqRRzHKmOeV7KeN0mhNpXoTp82Q
         pGYFoYjSrXYpRy3K8E7QtsOQq1wgIGvqZwVJO1giaKbIeNpCxFYtXu98mr4Inaw2UKpL
         oD+g==
X-Gm-Message-State: ACrzQf1J8ByKjn85VNLpV387kYLqm38qQlVxeDNABbUik15E+f7K5JXl
        qg7P3xANEu1A64ypnDEj/nqiw4ogO4PL3w==
X-Google-Smtp-Source: AMsMyM4dIjOLe3K0R6Mu50htxGGwJ5r9iR5UHidn9Kh8pdAYjGdaA0xj5i3MXi3xnZ7aeRZSLvRvDA==
X-Received: by 2002:adf:fd50:0:b0:22e:5503:9c4c with SMTP id h16-20020adffd50000000b0022e55039c4cmr4394060wrs.375.1664966630211;
        Wed, 05 Oct 2022 03:43:50 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056000137200b0022cc7c32309sm15004694wrz.115.2022.10.05.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:43:49 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     pavel@ucw.cz, robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] leds: remove ide-disk trigger
Date:   Wed,  5 Oct 2022 10:43:41 +0000
Message-Id: <20221005104341.3505550-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005104341.3505550-1-clabbe@baylibre.com>
References: <20221005104341.3505550-1-clabbe@baylibre.com>
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
index 25f3b7cc0cdb..4ba0423b43c1 100644
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
2.35.1

