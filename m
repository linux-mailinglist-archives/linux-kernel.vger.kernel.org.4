Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF0637E92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKXRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKXRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:50:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492914FEEC;
        Thu, 24 Nov 2022 09:50:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i12so3525012wrb.0;
        Thu, 24 Nov 2022 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgu1S+TzWjxezuwZWvW8G0xaAwqhwcK2Xvhbfkdzhnw=;
        b=TPz63x7AorUW6wbH1Kvue2WrHoN/ALDD3ZtKdx89/Z7iLzg39IR2+BpAGtA88VLr9I
         WoS/MPiEBruqKqjbKJgXNtsaZakNbylBc5M/dti/nS4M1pKFmVghHVwiNdMdaBm49ag3
         /EpRytkPwgJTiBYXcKsN5T8Fog7B86duO4OA5y1zWWGyHWzc+TcAX8cl582bTXv78KSc
         ZaZaKpvt6z1C+qI2DFp9wwfwJrn9IKwB3rlpDLY6I3pPZjJWJstzQwdlDDIwmEK9HnhZ
         x707pEio0DZENNY7vuQEPzVTK3/0q4HLdjoN1QjsRQJXfTczH9Rb5RNP1Xs3ulrdfM9W
         eEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgu1S+TzWjxezuwZWvW8G0xaAwqhwcK2Xvhbfkdzhnw=;
        b=0IrBnQYtnu/WnneQJroSrAMPf5m2zx24byLkEHr64b9mZxMQCO1OUrgeEJOukxhVae
         B22qoDWAy7YOMD2xOpQIGThq2KT93TbjslfRBtYv/SFpFBexOPnRK3pLAw23+yrZVBiu
         kO15rg5i7AjTQ8cx/+a2gBDFgL97pXdSJIszL/QaMZ2ZrsmeBaK8lB4ey/dxWkW3z4Mb
         q4vO9Nr/aVTFc56uT/3VqOTXIKbj6PoSHXqQTc+DDUYbfCRBiqu8KqyLDmh2n1b7AILT
         sFjxCVGYZYaU2QMX8yrwHs4/9vWyPEbJ15ejULPKnM6t2jrz6AB58wPym+xUm1pIj9Os
         OYaw==
X-Gm-Message-State: ANoB5pmuw6GqLszHZM2xZwOdO6uEsoaSOMAOW0g1r9Kb5sAlnAaEGAW2
        EdA8GqWLf+whfgFpsEmUAIU=
X-Google-Smtp-Source: AA0mqf7MKdg1stNETI4jVnUqm17O2uLzWe8qzl3w/DHLd50mP4BguLxu8bxVoaptqX63/TkgHhx1EQ==
X-Received: by 2002:adf:e7c3:0:b0:241:dfce:9bfc with SMTP id e3-20020adfe7c3000000b00241dfce9bfcmr9613111wrn.697.1669312203442;
        Thu, 24 Nov 2022 09:50:03 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.229])
        by smtp.gmail.com with ESMTPSA id z14-20020a7bc7ce000000b003cf78aafdd7sm2351142wmk.39.2022.11.24.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:50:03 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Ioannis Iliopoulos <jxftw2424@gmail.com>
Subject: [PATCH] HID: Ignore HP Envy x360 eu0009nv stylus battery
Date:   Thu, 24 Nov 2022 18:49:32 +0100
Message-Id: <20221124174932.6105-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Battery status is reported for the HP Envy x360 eu0009nv stylus even
though it does not have battery.

Prevent it from always reporting the battery as low (1%).

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/823
Reported-by: Ioannis Iliopoulos <jxftw2424@gmail.com>
Tested-by: Ioannis Iliopoulos <jxftw2424@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index dad953f66996..1423441be6dc 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -411,6 +411,7 @@
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
 #define I2C_DEVICE_ID_HP_ENVY_X360_15	0x2d05
 #define I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100	0x29CF
+#define I2C_DEVICE_ID_HP_ENVY_X360_EU0009NV	0x2CF9
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_15	0x2817
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 859aeb07542e..a4841fee092b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -377,6 +377,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_EU0009NV),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_15),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN),
-- 
2.38.1

