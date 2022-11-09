Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA062361F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiKIVw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKIVwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:52:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4942FFD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:52:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2183765wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6n5QI0irHH6c5ra/Q3E/wLcrhle3muAJPs17KSoX0U=;
        b=R6eU8iQwKU/LMhS2VW9nOl/u0GXzVuzcfis0xMxZc3gZbZRL08p+E0QHK+gGhhOGVe
         hPm5kaZCPZA3nIJu8QmY5AJmgoDnSs6CtBXzONyyQhqXWvQzviIuUF4cnlbQThgLirBs
         qqJu8jxEgsV7yAeDQFMmO4s0LArxXkJM1VOBWyZxYZszCcm1pgZHw61kqJOphxouNONa
         0dgiKep+i8ea5RTdWGd3I6LLA2u1rgemxvoOUzyAkOjdBvKffDorHRPId7UWnJgeIFPC
         0SztPoX0WuaUq4q9V94X93L4Cwr/m0NcK5wXP3bJUioFXOuv4bOP7sw2uHmKC0FT8zag
         Wn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6n5QI0irHH6c5ra/Q3E/wLcrhle3muAJPs17KSoX0U=;
        b=pGUCUmX7h2lBGfQvgAeOV1daPkOy+q2lOX8fLI2YOvpHjUN48kDt4HJPy0jK8JDTcP
         KTi3J9d7y9ON93ZNJe8Hwta4kaSTrPGnhwfSnTAkEYIfvg/X72upxVUpVjHEad19RKSt
         JOiIQLdI+TcN1WQ1bFIYyyWG5qO6fouGIdW0NwFy8xBB3FD5c0OHJx8BzK6FwEgFJrvz
         7Pxs1s0+wXFHClgXEJYBb5OpRZC45+iAbJFkDOMDWN6xLY1NxONtjQZxdmhZQePFrs1o
         H3dYmsRJyF7Tm5CxtXt03CXYHxdJLndQPxbv1R8KAYCfkGegFPi56VEhWMgS4hMRP2LP
         nQEg==
X-Gm-Message-State: ACrzQf02dOLYKIEEYkp5aN15jrMf/yjIF7pv6zKXQRLYq89vw7k8p8KO
        uWAfnlrwtEPOVyWA6uxyEKo=
X-Google-Smtp-Source: AMsMyM4NTT1Qtae5KbjauVYeTockJlZdoK9SbzT7Tzy4rPJyqEZ8/tkUJO8bOa/VM2PeGSCdA/xCMw==
X-Received: by 2002:a1c:f009:0:b0:3b4:9398:49c9 with SMTP id a9-20020a1cf009000000b003b4939849c9mr51489219wmb.174.1668030722922;
        Wed, 09 Nov 2022 13:52:02 -0800 (PST)
Received: from localhost.localdomain ([111.88.203.172])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003cf7292c553sm3022305wmq.13.2022.11.09.13.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:52:02 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 08/15] Accessiblity: speakup_dtlk: specifying the default driver parameters among the module params
Date:   Thu, 10 Nov 2022 02:51:01 +0500
Message-Id: <20221109215108.7933-9-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109215108.7933-1-osmtendev@gmail.com>
References: <20221109215108.7933-1-osmtendev@gmail.com>
MIME-Version: 1.0
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

This is an enhancement which allows to specify the default driver
parameters among the module parameters.

Adding default variables to the speakup_dtlk module
allows to easily set that at boot, rather than
setting the sys variables after boot.
More details can be found here:
https://github.com/linux-speakup/speakup/issues/7

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/speakup_dtlk.c | 50 +++++++++++++++-----
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
index 6f01e010aaf4..fa826568937b 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.c
+++ b/drivers/accessibility/speakup/speakup_dtlk.c
@@ -37,17 +37,27 @@ static unsigned int synth_portlist[] = {
 
 static u_char synth_status;
 
-static struct var_t vars[] = {
-	{ CAPS_START, .u.s = {"\x01+35p" } },
-	{ CAPS_STOP, .u.s = {"\x01-35p" } },
-	{ RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
-	{ PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
-	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
-	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
-	{ VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
-	{ FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
-	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
+enum default_vars_id {
+	CAPS_START_ID = 0, CAPS_STOP_ID,
+	RATE_ID, PITCH_ID,
+	VOL_ID, TONE_ID, PUNCT_ID,
+	VOICE_ID, FREQUENCY_ID,
+	DIRECT_ID, V_LAST_VAR_ID,
+	NB_ID,
+};
+
+
+static struct var_t vars[NB_ID] = {
+	[CAPS_START_ID] = { CAPS_START, .u.s = {"\x01+35p" } },
+	[CAPS_STOP_ID] = { CAPS_STOP, .u.s = {"\x01-35p" } },
+	[RATE_ID] = { RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
+	[PITCH_ID] = { PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
+	[VOL_ID] = { VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
+	[TONE_ID] = { TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
+	[PUNCT_ID] = { PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
+	[VOICE_ID] = { VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
+	[FREQUENCY_ID] = { FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT_ID] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
@@ -376,9 +386,27 @@ static void dtlk_release(struct spk_synth *synth)
 
 module_param_hw_named(port, port_forced, int, ioport, 0444);
 module_param_named(start, synth_dtlk.startup, short, 0444);
+module_param_named(rate, vars[RATE_ID].u.n.default_val, int, 0444);
+module_param_named(pitch, vars[PITCH_ID].u.n.default_val, int, 0444);
+module_param_named(vol, vars[VOL_ID].u.n.default_val, int, 0444);
+module_param_named(tone, vars[TONE_ID].u.n.default_val, int, 0444);
+module_param_named(punct, vars[PUNCT_ID].u.n.default_val, int, 0444);
+module_param_named(voice, vars[VOICE_ID].u.n.default_val, int, 0444);
+module_param_named(frequency, vars[FREQUENCY_ID].u.n.default_val, int, 0444);
+module_param_named(direct, vars[DIRECT_ID].u.n.default_val, int, 0444);
+
 
 MODULE_PARM_DESC(port, "Set the port for the synthesizer (override probing).");
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
+MODULE_PARM_DESC(rate, "Set the rate variable on load.");
+MODULE_PARM_DESC(pitch, "Set the pitch variable on load.");
+MODULE_PARM_DESC(vol, "Set the vol variable on load.");
+MODULE_PARM_DESC(tone, "Set the tone variable on load.");
+MODULE_PARM_DESC(punct, "Set the punct variable on load.");
+MODULE_PARM_DESC(voice, "Set the voice variable on load.");
+MODULE_PARM_DESC(frequency, "Set the frequency variable on load.");
+MODULE_PARM_DESC(direct, "Set the direct variable on load.");
+
 
 module_spk_synth(synth_dtlk);
 
-- 
2.25.1

