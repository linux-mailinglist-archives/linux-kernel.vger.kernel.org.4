Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7B6D0414
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjC3L5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjC3L5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:57:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056296EB1;
        Thu, 30 Mar 2023 04:57:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so19297424pjl.4;
        Thu, 30 Mar 2023 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680177419; x=1682769419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3PK3on0fCFYWXA/ESKX5+PbTNOkv8FKJ4MgRnOsh2OQ=;
        b=pr73VQrZkpH4d90dQ/8rv4xv+T/1mVLyaMgqCvmcaWIXqw5R52f9wIZLyMLn7YaIR+
         a64nJiPEcODC18DS4mZP9JPKWr2Ovp3Hq17aln0hA2r6haIxMWTnuepirl0Tt4De+iSS
         zyMADPM+n+BscXitabtQ9OLOPSLaVBGubg8LK1XpLreJPx1D6v/f6tlBgux6U1q+jbFM
         hHbeRBTiXtsYEERmRTLOYx0evcDJmT+KaZ2eWmG2qLhtVSswbSTf+b6Pgldznle+2Yyc
         MbXeuG3Uc9oycz+Cc1D9u6LX+NCce/wo1uQfFM1N9nHjGnOsjp565gU5xwD0WE8QY+7+
         f4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680177419; x=1682769419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PK3on0fCFYWXA/ESKX5+PbTNOkv8FKJ4MgRnOsh2OQ=;
        b=Ioo9q4He51eoYFeT7ec7PcUgrS7Zi8D9xHZqC+LeIz825FhBPvRhB4lykI5QtaypLF
         SZEMXFGdGrIF4cRSdMYS3qTRDbZa+OocV6JMXqTBKwOcTPyxyYUTxlflgI8m7kDmW/Ka
         WBidOewk9ulSe+wH4t0QNiSCLf2cI5qJ2jNtVszHT4YRr9LQxsJQYrX/6XQLMY8hGSpr
         zqDiSmxxUh9gAIz+VuQdCmOQcuPwrbwBfeOSGM5FZGm871lqwULYHRb0ShWN0DEsBsP3
         cSGQQeB4tDaLaKMd2w4Uu2uOhmKnGIKDY0NizkwrIUc/pKMWs1Me90B43B2B5M8XTyZX
         8/Hw==
X-Gm-Message-State: AAQBX9exMgtyBO/gA0fDxC63U3u/ppI78RvnKBtLP9Kbrq/NKVjz7Ai2
        /K73K3Ax49lnsNRjI6bN2zo=
X-Google-Smtp-Source: AKy350b0Mag2lY61G1NN+opnfFIgWnRWkneP/OtclK+F3ge1n7CWKxDr/YzgjMm9jeBNnDeIfDOOLA==
X-Received: by 2002:a17:902:e801:b0:1a0:53b8:907f with SMTP id u1-20020a170902e80100b001a053b8907fmr27825915plg.17.1680177419448;
        Thu, 30 Mar 2023 04:56:59 -0700 (PDT)
Received: from Erekir.lan ([103.147.22.100])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b0019a95baaaa6sm24572459pls.222.2023.03.30.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:56:59 -0700 (PDT)
From:   weiliang1503 <weiliang1503@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        weiliang1503 <weiliang1503@gmail.com>
Subject: [PATCH v1] HID: Ignore battery for ELAN touchscreen on ROG Flow X13 GV301RA
Date:   Thu, 30 Mar 2023 19:56:38 +0800
Message-Id: <20230330115638.16146-1-weiliang1503@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the reported battery level of the built-in touchscreen to suppress
battery warnings when a stylus is used. The device ID was added and the
battery ignore quirk was enabled.

Signed-off-by: weiliang1503 <weiliang1503@gmail.com>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 63545cd30..6e111cb19 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -415,6 +415,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_15	0x2817
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG  0x29DF
 #define I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN 0x2BC8
+#define I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN 0x2C82
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7fc967964..4ff422f28 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -372,6 +372,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
-- 
2.40.0

