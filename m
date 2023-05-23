Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5123870D0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjEWCPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjEWCPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:15:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE6172B;
        Mon, 22 May 2023 19:14:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77019719423so283952439f.2;
        Mon, 22 May 2023 19:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684808095; x=1687400095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFnzX1YeRTORJ2mp1cDV7I61mJxb5oiNjy6UFmq8zYE=;
        b=nQaW1Rkp9W1d4h+h2FO8I2STIbpNl70lBJE2f/qvQgjtMWl01dZZ3fOf2Qo3WLgXKW
         94YtelFAtd0NVkBGAw2qbWfxJjqbcTZgURTtd7wleVeeVYhEkm/XQDkXPp0p+o0GJESd
         QfvgtdosYhkiCa2kg3BL/uSBxwGCONkPMs6tTN0zjzFC+7STM+jbt/5huTiEZJb8RMGW
         bvmnV459HUBMyYQk4OqIpQ1E5eWPb2zyrczOjFUFlflNC+AG27dLNJj3PxHB5bC5SQjD
         3ItVIcMB8IK/CbbPrmSvu2JhfHia66mChtEuRsELb1nop0RA8trXe8bc640eH8gXqZ/D
         i/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808095; x=1687400095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFnzX1YeRTORJ2mp1cDV7I61mJxb5oiNjy6UFmq8zYE=;
        b=dZa3sjK+thl3gSyRrkOh/ZD9t2PtRTeFu//GUwOS9dkOPQ5lra1afOwC5qBs0Le5qQ
         qQFsMw37CUWlhMClrnUaO0AD7FGPFTE6gM9JryvjgELVW9TZ3azn25HBnO5j06VoM5h7
         RgzLJb+Ac2JnSRBLVmC3YRPtjw23CvLdkgSCUSGfrk2PCC6OoYKHD2y1DFUbRlpHth4Q
         S6UTYxOfUTLdqLHo+lHyASxHDmfMUKu8SIP9PC6E9VINOJbA4cBSgeM7jEIlc3DyXAYS
         oTGQxsMi7KFbecnpIncMgt3q0QEsFcff3D2AVo0OyI+lMQ2MWj1OLwKACgt7jXazdmuU
         uHQA==
X-Gm-Message-State: AC+VfDzT2CUkoMc3tP9ZNMNUFsDgw8TkguLXUvUX4g+8ywLz3ncXxubG
        s/TkALAQKOI9fJ26hLrBpX4=
X-Google-Smtp-Source: ACHHUZ6AwniIp+HrDfguDY/5LqySPXpzDIVpGAuJ42gTefCub0YKiNO5Pwt5JNOELLpebUGFL3CL7w==
X-Received: by 2002:a6b:dd12:0:b0:76c:7365:42d8 with SMTP id f18-20020a6bdd12000000b0076c736542d8mr8079568ioc.5.1684808094813;
        Mon, 22 May 2023 19:14:54 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id d59-20020a0285c1000000b004143ffd4399sm2104035jai.39.2023.05.22.19.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:14:54 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:14:51 +0000
Message-ID: <20230523021451.2406362-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/leds/flash/leds-aat1290.c |    2 +-
 drivers/leds/led-class.c          |    2 +-
 drivers/leds/leds-spi-byte.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/flash/leds-aat1290.c b/drivers/leds/flash/leds-aat1290.c
index 589484b22c79..f12ecb2c6580 100644
--- a/drivers/leds/flash/leds-aat1290.c
+++ b/drivers/leds/flash/leds-aat1290.c
@@ -425,7 +425,7 @@ static void aat1290_init_v4l2_flash_config(struct aat1290_led *led,
 	struct led_classdev *led_cdev = &led->fled_cdev.led_cdev;
 	struct led_flash_setting *s;
 
-	strlcpy(v4l2_sd_cfg->dev_name, led_cdev->dev->kobj.name,
+	strscpy(v4l2_sd_cfg->dev_name, led_cdev->dev->kobj.name,
 		sizeof(v4l2_sd_cfg->dev_name));
 
 	s = &v4l2_sd_cfg->intensity;
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 9255bc11f99d..6dae56b914fe 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -409,7 +409,7 @@ static int led_classdev_next_name(const char *init_name, char *name,
 	int ret = 0;
 	struct device *dev;
 
-	strlcpy(name, init_name, len);
+	strscpy(name, init_name, len);
 
 	while ((ret < len) &&
 	       (dev = class_find_device_by_name(leds_class, name))) {
diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index 2bc5c99daf51..2c7ffc3c78e6 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -98,7 +98,7 @@ static int spi_byte_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	of_property_read_string(child, "label", &name);
-	strlcpy(led->name, name, sizeof(led->name));
+	strscpy(led->name, name, sizeof(led->name));
 	led->spi = spi;
 	mutex_init(&led->mutex);
 	led->cdef = device_get_match_data(dev);

