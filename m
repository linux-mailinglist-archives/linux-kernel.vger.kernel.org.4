Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBF60E835
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiJZTDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiJZTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:03:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03CD11D9B0;
        Wed, 26 Oct 2022 12:01:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so18452890ejc.7;
        Wed, 26 Oct 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJQTmtw1LKn8R21PdJOf+BsVQdKZOWcICNuuo0tryIQ=;
        b=neNEagusHI0mIvWPl23F6JovwYqCjOeOuCasrNdeOtHN4ZGulvchTm8Q3apJhsdwh8
         05EHQm+NaJkcduy2FMktQyF7Cv9o6xXWo/qYfEkgTVB+d6UaIKN0VPUIG0FjPEwBsF7Y
         R7fJowG4xcyw5/3dLP/HdSLIJyTlZvRfP2bUwj+vlhCLStfByvH44sy7duWumjOzcD+l
         UZRpeEdE1tlDPDKxorkzhvbdpb7dw7Z2MjSR8E/FsCuI0lG0rR9KRunoQQftcl2p9UyI
         vGYQWEXLYAUyGqc1eXjsoxb9DUpQVTodT33ArN4g6ycrYBvlKlQpVyF2hMI45IpAqzYv
         Hv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJQTmtw1LKn8R21PdJOf+BsVQdKZOWcICNuuo0tryIQ=;
        b=vvzNjlYPaPqHKAUmUvXF+tAEGMF2wepaVc/1fwh+vj5JeIac408TkIz04289pIF8PK
         awr/diptKV0LqHD2B1ySCyJp+XWGPSA7aeEXFaoGYIYRhwQaYb91jt/YLqDWicy8nSm6
         Bu0Rjj3a4gPDQI/z7sX7KlG67f8V4imPyt3XjKpquqBYka8esf3G8Xfle8NhtX8Ar/rN
         x6LSyRA/0RgIOk31ULHvoTnBEPl/KNLDJGNrmHV6+xQ/SmRMy3TCQSptp0f8DcA11+xP
         iRjhP7Lsxt+WtMQkbmeqGoDxAGtnr3pYPLjg54eDxvWyJM0K+u8gbVlvhEWlXFx5cRmN
         atnQ==
X-Gm-Message-State: ACrzQf3UPvJNO0kfQbtbFs15peKA0wf42Cd0N50Jq0wtZV0aEpCY30Ww
        yX62kcdZbV3SERnii6SL9wtpVmLG6aJTwA==
X-Google-Smtp-Source: AMsMyM6a0rgxoD5dlQ7pzTfqS96oPeyAQOaZHDOiOoFLuVsbLpinWXbIsmDGxCiUiT36L72bfoa/Eg==
X-Received: by 2002:a17:907:2bda:b0:78d:9144:fb6d with SMTP id gv26-20020a1709072bda00b0078d9144fb6dmr38898252ejc.238.1666810874018;
        Wed, 26 Oct 2022 12:01:14 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:13 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 4/6] platform/x86: ideapad-laptop: Add new _CFG bit numbers for future use
Date:   Wed, 26 Oct 2022 22:01:04 +0300
Message-Id: <20221026190106.28441-5-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026190106.28441-1-erayorcunus@gmail.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com>
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

Later IdeaPads report various things in last 8 bits of _CFG, at least
5 of them represent supported on-screen-displays. Add those bit numbers
to the enum, and use CFG_OSD_ as prefix of their names. Also expose
the values of these bits to debugfs, since they can be useful.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 33 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 0ef40b88b240..f3d4f2beda07 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -46,10 +46,22 @@ static const char *const ideapad_wmi_fnesc_events[] = {
 #endif
 
 enum {
-	CFG_CAP_BT_BIT   = 16,
-	CFG_CAP_3G_BIT   = 17,
-	CFG_CAP_WIFI_BIT = 18,
-	CFG_CAP_CAM_BIT  = 19,
+	CFG_CAP_BT_BIT       = 16,
+	CFG_CAP_3G_BIT       = 17,
+	CFG_CAP_WIFI_BIT     = 18,
+	CFG_CAP_CAM_BIT      = 19,
+
+	/*
+	 * These are OnScreenDisplay support bits that can be useful to determine
+	 * whether a hotkey exists/should show OSD. But they aren't particularly
+	 * meaningful since they were introduced later, i.e. 2010 IdeaPads
+	 * don't have these, but they still have had OSD for hotkeys.
+	 */
+	CFG_OSD_NUMLK_BIT    = 27,
+	CFG_OSD_CAPSLK_BIT   = 28,
+	CFG_OSD_MICMUTE_BIT  = 29,
+	CFG_OSD_TOUCHPAD_BIT = 30,
+	CFG_OSD_CAM_BIT      = 31,
 };
 
 enum {
@@ -368,6 +380,19 @@ static int debugfs_cfg_show(struct seq_file *s, void *data)
 		seq_puts(s, " camera");
 	seq_puts(s, "\n");
 
+	seq_puts(s, "OSD support:");
+	if (test_bit(CFG_OSD_NUMLK_BIT, &priv->cfg))
+		seq_puts(s, " num-lock");
+	if (test_bit(CFG_OSD_CAPSLK_BIT, &priv->cfg))
+		seq_puts(s, " caps-lock");
+	if (test_bit(CFG_OSD_MICMUTE_BIT, &priv->cfg))
+		seq_puts(s, " mic-mute");
+	if (test_bit(CFG_OSD_TOUCHPAD_BIT, &priv->cfg))
+		seq_puts(s, " touchpad");
+	if (test_bit(CFG_OSD_CAM_BIT, &priv->cfg))
+		seq_puts(s, " camera");
+	seq_puts(s, "\n");
+
 	seq_puts(s, "Graphics: ");
 	switch (priv->cfg & 0x700) {
 	case 0x100:
-- 
2.34.1

