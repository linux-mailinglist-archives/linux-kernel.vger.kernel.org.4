Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F66122B6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJ2MEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJ2MEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B401005C;
        Sat, 29 Oct 2022 05:04:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so9730492wrq.3;
        Sat, 29 Oct 2022 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJQTmtw1LKn8R21PdJOf+BsVQdKZOWcICNuuo0tryIQ=;
        b=hj63AntOayLxGuhmd58BTJfnSBtEsisiCc4yTtPlicPA/vqQRHwocJeXFMOZBBAUis
         OrGl0YhFMzlRDqEYYqWWMd2ipJb7mf8yB+DnMlbO5Mz5/j3woffowngqthtWzVDjbwX7
         +M6l8hd/tf1kXrCsiBs0H8eJ5pOrkuyNAjGi/5ANOs+c/gMEbl/tUARRR/YOI0JnjXFt
         Ospy3Gl6sb59dTzyVYlp/YwJMsITljO61XAArV2qXP9yrqi277G3AGaaJsnXyK1ocJtB
         DegxftzOYqKeE1R2KpAGWhB3tbXOW/lC/Hjr87zDkRU1U1AsLyg+rhoW3aX6HCUGtkiL
         y98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJQTmtw1LKn8R21PdJOf+BsVQdKZOWcICNuuo0tryIQ=;
        b=1DJHjjefWCuhCke6r7ZIBjGE9X0lxUquEO5a3tvb5Q2tcJcqljYa+wi6s09imD90X7
         H3haiRmvXxaUIjDL8RffC+BQfcXVbeARiuVtr+P3pF7ezE0Hb/mNRhngDuXxaLY/LxE+
         bnGMSv+m9sVUExu8ewHy+nvsgTiVW+ZEK5lZAiXDNoLI+CE1Db+HVdBhmJNOFr/pQ6fr
         iIb1koG1Z8Gz3lmjCyj/QfdmPBFqrzq8OAKPabVMjGK0pQ6vC4jiE858DDaqpI/qK/C8
         q7uHezxcDzurIGO1mYhas1fT2hm88IfD910djY+edcwz75NE7GSkjcb+QWu8EhrOVpvY
         1PSg==
X-Gm-Message-State: ACrzQf2TQ9TcOm/fL3t4rQ65pRSUH5kOD3ZPtrBacs5zmokZHEasnROt
        /evkSgKzJBJKYH56S02Qk6HyCCeLKZ4aWw==
X-Google-Smtp-Source: AMsMyM7OfCgLILJ83WkCh8TrI7OLLHhrYyEMgaMdNxM6SuI9o6UysEZ0xPGxUNPgHnEBOXq5Jmxdew==
X-Received: by 2002:adf:dd4d:0:b0:236:6e72:be17 with SMTP id u13-20020adfdd4d000000b002366e72be17mr2138838wrm.460.1667045070606;
        Sat, 29 Oct 2022 05:04:30 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:30 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 4/7] platform/x86: ideapad-laptop: Add new _CFG bit numbers for future use
Date:   Sat, 29 Oct 2022 15:03:09 +0300
Message-Id: <20221029120311.11152-5-erayorcunus@gmail.com>
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

