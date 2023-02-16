Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89178698EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBPIsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjBPIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:48:41 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BEC3A0A2;
        Thu, 16 Feb 2023 00:48:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z6so845963pgk.0;
        Thu, 16 Feb 2023 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxPI//pS1yfJEnvmaYxMoqiiVdQbpuUKbfNVph9SA+k=;
        b=du+9qzsFVQ+Yu8KHkXaQ2U7M5X8yE5rDiThJR97GGjW6mZBSSdrGf0JQtIrQthK69L
         ydfWbe/dxUWVlED3eBoAoAlOtld3dVovi1qCrN5P8f7mfQQ/tVZVNqOi1Na5b1cC+RJj
         O/FHWM123A0KjPn3HCVu3bBZNEJXXXyyOcJux+XToZnXK1iXOVmFU0ww2oj1wnWSqD/v
         /zFcJukTXRSEUJmc7rxlhbiB7oZcoz9Fe0sKAOOqrYa60Oa7e+ZF9Y9qsECpOUn+sH8O
         SE5nlpYBpMg4evqc167BG0+VulKghRULprKLsQpSLiWKAWxgY9wPT2IMvKa7FZ5R+pqT
         VaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxPI//pS1yfJEnvmaYxMoqiiVdQbpuUKbfNVph9SA+k=;
        b=1m+Fb5vFsdkZjKfZIfytBwFEEpWBNuhb+Qp/jhanJxP9fP1nwFXCAwL4qKWB9qshn2
         uvooW7YgQ+T+beL/LHWh2Eh6f5KQ9cgWvJQGJfo8XiOOJi1DwDTEAH3Ih60CnWWDRZXF
         qDp6iJndwqKaXqw/kN0xizKxFGhBwzsv8r1cVgTPwMFUZQvzZYosNIcdReQgqZ2tQETx
         M2tfAIShkLXWLwIm4yJYk9BBGFcX6fcRzhnaLESLhnjnq+pBe68FcZbUHtQsVnWwg7Wr
         a8qHtIpgFqdJdSNVmVRx3wGyBo477fNPljpEQ0LQs2bAVMAVejKmBoUvRSZ6jw/kvX2C
         N7+g==
X-Gm-Message-State: AO0yUKW4ZRAAiZihdpuZC1KAAxrb9tM2jf9Tt/sKzdopaANpOYc7aX5P
        80mMcmVIkqVaMP14swVcLzEzTLH+/7M=
X-Google-Smtp-Source: AK7set8QNkWalRHdz7MM0GMLaLGOW4GOq5sMxuRqjmjulsPm+dV8D9oaFGyiXkRe4MvU0c05C+iZnA==
X-Received: by 2002:aa7:9489:0:b0:590:7659:9c33 with SMTP id z9-20020aa79489000000b0059076599c33mr3912994pfk.22.1676537316643;
        Thu, 16 Feb 2023 00:48:36 -0800 (PST)
Received: from mi-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2c:5c4])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78dc3000000b0058ba2ebee1bsm722131pfr.213.2023.02.16.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:48:36 -0800 (PST)
From:   Qi Feng <fengqi706@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengqi <fengqi@xiaomi.com>
Subject: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
Date:   Thu, 16 Feb 2023 16:48:30 +0800
Message-Id: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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

From: fengqi <fengqi@xiaomi.com>

Our HID device need KEY_CAMERA_FOCUS event to control camera,
but this event is non-existent in current HID driver.
So we add this event in hid-input.c.

Signed-off-by: fengqi <fengqi@xiaomi.com>

---
changes in v4:

-add HID_UP_CAMERA in HID usage tables , Then add the mapping under HID_UP_CAMERA
-modify the commit log of patch
-Link to v3:https://lore.kernel.org/linux-input/9a85b268c7636ef2e4e3bbbe318561ba2842a591.1676536357.git.fengqi@xiaomi.com/T/#u
-Link to v2:https://lore.kernel.org/linux-input/CACOZ=ZU0zgRmoRu8X5bMUzUrXA9x-qoDJqrQroUs=+qKR58MQA@mail.gmail.com/T/#t
-Link to v1:https://lore.kernel.org/linux-input/CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com/T/#t
---
 drivers/hid/hid-input.c | 10 ++++++++++
 include/linux/hid.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 77c8c49852b5..c6098ae2fac7 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1225,6 +1225,16 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			return;
 		}
 		goto unknown;
+	case HID_UP_CAMERA:
+		switch (usage->hid & HID_USAGE) {
+		case 0x020:
+			map_key_clear(KEY_CAMERA_FOCUS);	break;
+		case 0x021:
+			map_key_clear(KEY_CAMERA);		break;
+		default:
+			goto ignore;
+		}
+		break;
 
 	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
 		set_bit(EV_REP, input->evbit);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8677ae38599e..88793b77bd63 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -155,6 +155,7 @@ struct hid_item {
 #define HID_UP_DIGITIZER	0x000d0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_BATTERY		0x00850000
+#define HID_UP_CAMERA		0x00900000
 #define HID_UP_HPVENDOR         0xff7f0000
 #define HID_UP_HPVENDOR2        0xff010000
 #define HID_UP_MSVENDOR		0xff000000
-- 
2.39.0

