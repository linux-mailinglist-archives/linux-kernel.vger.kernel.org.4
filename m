Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC746122B0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ2MEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJ2ME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7274B85;
        Sat, 29 Oct 2022 05:04:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so8033444wmr.2;
        Sat, 29 Oct 2022 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzOvAyGDXhsFFUVp58xr8wzl/ct2UtB9GMmORTrIQvw=;
        b=B1sbLOE0BM4c0GsdSFUmM6NZvGRW76oTkt7BxEPlqKUIwlBOoJJZ0HKla36bv/DnuF
         KbsTbtMI0VLBBUuvWl0k2pQoNp6RLY2S2GUmtGVewbO+vW7vc8P015KC72a5QH2bD8xB
         6Sq4H2DurFxuddYdKZ7WVZsBNTMqH5ZOkV4baF15MkBXbTA8CQtbZNApYzvLRASd9KVo
         FrO0bbsIlyWO6+yxtbtRLRyPLH/1l2Ma+GDwtJOh8Wng/KNQDnHzXE7nyE2sbbm5eU7Z
         HCjlugnC6Hjck61NtpKZfUGsXY2d08uOfXJSabWU+CTrlnqyNzUrnww6RTG++URhVyNe
         qNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzOvAyGDXhsFFUVp58xr8wzl/ct2UtB9GMmORTrIQvw=;
        b=eq9sNAebE8IrJjUoVNdYYibCGVNdMZnfYSxR2IR8oP2XKZWdvmqu6mr9t+ZctwyzUl
         czlE6vi/yQkzwERWQNSVaDG2LWqznSdGobGksS5yULNwACUlk1v3OJ0ia13PsS6g4U4q
         zy1gT9Q+IuIrXDQyDRsJcDojOSmbjwgvLk9UaaOLvKNSgoIdPW1zjTpE63Lb2NOjxnDH
         04u7tvqzZ0cYaUSKpKH1DNNENnEEOgDWTo4U9ObU2gDiJd5IPgQ3Rn03rcnhYiB2eKG1
         fxadHSn6Nlq5FCjp7OR9LleHUMBjA0YaZz6ZcfJaoiEI+okVRfrsfEYEYa7JMMMKwNOb
         gCKw==
X-Gm-Message-State: ACrzQf2MEdUFSqP0MQe+5OG1y35R9AgWQsDCnm8uHgxPWQkaoiBJxWn/
        N2Z/PIlFK0vD2N5X6aa4Q1XApiJ1fCxIMg==
X-Google-Smtp-Source: AMsMyM5bYm+MdK/Txv55Qg9/EN1UUSHcdL5I6XiFB6bJLPl0/m+pITGbuyO0rwI5Iz9+ozgHuHxcfA==
X-Received: by 2002:a1c:27c6:0:b0:3c2:e6df:c79b with SMTP id n189-20020a1c27c6000000b003c2e6dfc79bmr12025245wmn.14.1667045062904;
        Sat, 29 Oct 2022 05:04:22 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:22 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 1/7] Revert "platform/x86: ideapad-laptop: check for touchpad support in _CFG"
Date:   Sat, 29 Oct 2022 15:03:06 +0300
Message-Id: <20221029120311.11152-2-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029120311.11152-1-erayorcunus@gmail.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last 8 bit of _CFG started being used in later IdeaPads, thus 30th bit
doesn't always show whether device supports touchpad or touchpad switch.
Remove checking bit 30 of _CFG, so older IdeaPads like S10-3 can switch
touchpad again via touchpad attribute.

This reverts commit b3ed1b7fe3786c8fe795c16ca07cf3bda67b652f.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index e7a1299e3776..b67bac457a7a 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -46,11 +46,10 @@ static const char *const ideapad_wmi_fnesc_events[] = {
 #endif
 
 enum {
-	CFG_CAP_BT_BIT       = 16,
-	CFG_CAP_3G_BIT       = 17,
-	CFG_CAP_WIFI_BIT     = 18,
-	CFG_CAP_CAM_BIT      = 19,
-	CFG_CAP_TOUCHPAD_BIT = 30,
+	CFG_CAP_BT_BIT   = 16,
+	CFG_CAP_3G_BIT   = 17,
+	CFG_CAP_WIFI_BIT = 18,
+	CFG_CAP_CAM_BIT  = 19,
 };
 
 enum {
@@ -367,8 +366,6 @@ static int debugfs_cfg_show(struct seq_file *s, void *data)
 		seq_puts(s, " wifi");
 	if (test_bit(CFG_CAP_CAM_BIT, &priv->cfg))
 		seq_puts(s, " camera");
-	if (test_bit(CFG_CAP_TOUCHPAD_BIT, &priv->cfg))
-		seq_puts(s, " touchpad");
 	seq_puts(s, "\n");
 
 	seq_puts(s, "Graphics: ");
@@ -661,8 +658,7 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fn_lock.attr)
 		supported = priv->features.fn_lock;
 	else if (attr == &dev_attr_touchpad.attr)
-		supported = priv->features.touchpad_ctrl_via_ec &&
-			    test_bit(CFG_CAP_TOUCHPAD_BIT, &priv->cfg);
+		supported = priv->features.touchpad_ctrl_via_ec;
 	else if (attr == &dev_attr_usb_charging.attr)
 		supported = priv->features.usb_charging;
 
-- 
2.34.1

