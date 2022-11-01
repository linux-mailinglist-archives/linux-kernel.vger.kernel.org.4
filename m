Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5FF6153B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKAU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKAU7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:59:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55645186C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:59:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so72598wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoLdvBrFWK8UZ48oM9I5z3VaqfRmkF0oUoxRbIX+jSg=;
        b=TgQGVSNSdM4AVh8nLG3CFHFp4eRP28nLeZoSXIJTk4mVRy5gv12emXORt+72dDAAyy
         aJqYI+Yi4YVW87/lMBs/DAUzbUt6BrymwWZ0LqQ1wVQ0vDkFsFa7PBBjXVrDGUdEy3ve
         /zZ6/qVsG8wK4/hkBusvGjvnJ+8CQoBtE5Mbna6nXZOdUnjfXwEIk6O2NDCJNJUxNOWq
         xtH4rBBK1eEcmCu/lMRpD00nj0lzJpJIx8VYJtVBb/NOm3lmpsY7q4VdzWGroRxHvvXO
         buBrdLogPLiHf/SPdsK7AGeTKv03xa9fPLWrTPvGboV+yxU/5PP5GnJiMjC7NNyjvFG1
         iOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoLdvBrFWK8UZ48oM9I5z3VaqfRmkF0oUoxRbIX+jSg=;
        b=TPq0s1s8yxYWWmx7fpxUN3VzgbbLoeQHxLv1nLNRlke0GFNlrciIwf4A8jjPNBDuJa
         nPrkZOwHZ0jw9aOcFdjgU/Z2WuUHhktCCmNt3TfnxTAKOwGXzAaB6PG64KeK5CfYVAmm
         i3ZoFw6YwThVOCbqyQawZDqfXIFGN+gs5B7WRkwj1gHjatFMeCru/5I/CUprcZnyEBKk
         5RlTTYn8LFRqnQMgDnFbNjwAUqQbjfG78VLlAx8uRLHebHWjhD/QeYfuSglzOx0grGxh
         EwqSa60B82LWNyOJ8Ni2U/Qv29c15rvNPSUs5hfEQULrQ6absyr1afYEx6j0rWqcjsJf
         5AUA==
X-Gm-Message-State: ACrzQf1NgfHJxC+xi81BsugF+hyazVrOKTkh66I5hZIj4x8WU5+lnnD9
        eJG04IrSsBWm0uMRZFSaW3YwIKbwKsAVag==
X-Google-Smtp-Source: AMsMyM7gvjDY9gfuHktdP51T/gdJSt69pTL3d360YY7DfDnmQLa8Xc1CI2vEn+ezCXjtGyk0yBkKdQ==
X-Received: by 2002:a7b:c398:0:b0:3c7:87f:3b48 with SMTP id s24-20020a7bc398000000b003c7087f3b48mr13272345wmj.65.1667336390888;
        Tue, 01 Nov 2022 13:59:50 -0700 (PDT)
Received: from localhost.localdomain ([117.102.63.160])
        by smtp.gmail.com with ESMTPSA id t12-20020adff60c000000b002366ded5864sm10846566wrp.116.2022.11.01.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:59:50 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Accessiblity: speakup_dtlk: specifying the default driver parameters among the module params
Date:   Wed,  2 Nov 2022 01:59:12 +0500
Message-Id: <20221101205912.10139-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.25.1
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
index 6f01e010aaf4..657cd04de4e4 100644
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
+	[CAPS_START] = { CAPS_START, .u.s = {"\x01+35p" } },
+	[CAPS_STOP] = { CAPS_STOP, .u.s = {"\x01-35p" } },
+	[RATE] = { RATE, .u.n = {"\x01%ds", 8, 0, 9, 0, 0, NULL } },
+	[PITCH] = { PITCH, .u.n = {"\x01%dp", 50, 0, 99, 0, 0, NULL } },
+	[VOL] = { VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
+	[TONE] = { TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
+	[PUNCT] = { PUNCT, .u.n = {"\x01%db", 7, 0, 15, 0, 0, NULL } },
+	[VOICE] = { VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
+	[FREQUENCY] = { FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
+	[DIRECT] = { DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
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

