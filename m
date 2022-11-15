Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A676294C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbiKOJrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiKOJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:47:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654523145
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so23086551wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPu7bwc+ZranhLPX5AB2LeDrS1+qW0XSqyGwXW15FJY=;
        b=DAERfQFgE3Ib6MPZMtefbIoP3/4Hy6yIUOQdWCUs9y4mIsG4+Is2jzIAfex8nQ2Z2H
         eldnpR4tufY5eal/8gp9G33pu9Nc6lVRU4McHKaHLdFgNwbLvyWSGInhbADt3gCSO6oq
         xPQZQ5PVgwoK6KMYkKRcOTzUUqKZUp+mL7uJpREDyC5qYBT4pljZ7gHRozxxooK5hh0e
         QNMGmBZPWCty+sQw0lHXiZN4jtinhBWgm5H0BErxOnmHKBHny9rbjrSsw5uEVuvOWN/t
         cwy64yZO0sv9az6IR/mXAo4WzEHNKreq6ocb7mLNLZLeousSTPXQ+qrid5eXjYXo9Xwd
         LARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPu7bwc+ZranhLPX5AB2LeDrS1+qW0XSqyGwXW15FJY=;
        b=yn3wVEF47WGR/aj09+zU4yHNyip3gmH7XaZkWjML/g7X7hHXzwERSOnChey2ZBykpN
         mvqGA8lGO+YlhjvvQYsI04oJo7SKmN0WY7eroc3LcmiegcuP2UlzYAo8GNjvmkynK3+M
         MY/0QlCyie+OPSobUUoZB9pv+dh13iL/Io5/S8E4WaE1slJgzibMIqEaYFyI4Lj1T7RC
         IC6zkh3EC+V42sI+hmEmcjQTkV5JhmxpM8MsD35i77LOJHewnQtKhJia/DLfHx27UfZf
         /3saFrcdwVtHjuSUfS+ozc9MlgfdVgkEJhxHNOcztHcbKnkwZA2neX2xmdjRtsUlseJu
         3KdA==
X-Gm-Message-State: ANoB5pn3EIYG1qy75Ot+KvvRERK9QUiNYxuiXJcnyqI5V9npVFdIsM6X
        Qbpe+U9ncDobyJ7Zby6HIpc=
X-Google-Smtp-Source: AA0mqf5YUvRFZykexIik3guOHGeaUQX4gN6mJBq1wrtsSLps+2ApgvYomucoInu0hEQm8sOrxjJLMg==
X-Received: by 2002:adf:f8cf:0:b0:241:9606:1123 with SMTP id f15-20020adff8cf000000b0024196061123mr3898021wrq.537.1668505636805;
        Tue, 15 Nov 2022 01:47:16 -0800 (PST)
Received: from arch.localdomain ([119.160.120.210])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d458e000000b0022eafed36ebsm11904866wrq.73.2022.11.15.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:47:16 -0800 (PST)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     okash.khawaja@gmail.com, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCHv2 1/2] accessibility: speakup: Specify spk_vars among module parameters
Date:   Tue, 15 Nov 2022 14:48:11 +0500
Message-Id: <20221115094812.81632-2-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115094812.81632-1-mushi.shar@gmail.com>
References: <20221115094812.81632-1-mushi.shar@gmail.com>
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

This is an enhancement which allows setting default variables for
speakup module at the boot rather than setting the sys variables after
the boot.

Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/main.c | 60 ++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index f52265293482..2e6e0649fe90 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -1268,20 +1268,28 @@ int spk_set_key_info(const u_char *key_info, u_char *k_buffer)
 	return 0;
 }

-static struct var_t spk_vars[] = {
+enum spk_vars_id {
+	BELL_POS_ID = 0, SPELL_DELAY_ID, ATTRIB_BLEEP_ID,
+	BLEEPS_ID, BLEEP_TIME_ID, PUNC_LEVEL_ID,
+	READING_PUNC_ID, CURSOR_TIME_ID, SAY_CONTROL_ID,
+	SAY_WORD_CTL_ID, NO_INTERRUPT_ID, KEY_ECHO_ID,
+	V_LAST_VAR_ID, NB_ID
+};
+
+static struct var_t spk_vars[NB_ID] = {
 	/* bell must be first to set high limit */
-	{BELL_POS, .u.n = {NULL, 0, 0, 0, 0, 0, NULL} },
-	{SPELL_DELAY, .u.n = {NULL, 0, 0, 4, 0, 0, NULL} },
-	{ATTRIB_BLEEP, .u.n = {NULL, 1, 0, 3, 0, 0, NULL} },
-	{BLEEPS, .u.n = {NULL, 3, 0, 3, 0, 0, NULL} },
-	{BLEEP_TIME, .u.n = {NULL, 30, 1, 200, 0, 0, NULL} },
-	{PUNC_LEVEL, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
-	{READING_PUNC, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
-	{CURSOR_TIME, .u.n = {NULL, 120, 50, 600, 0, 0, NULL} },
-	{SAY_CONTROL, TOGGLE_0},
-	{SAY_WORD_CTL, TOGGLE_0},
-	{NO_INTERRUPT, TOGGLE_0},
-	{KEY_ECHO, .u.n = {NULL, 1, 0, 2, 0, 0, NULL} },
+	[BELL_POS_ID] = { BELL_POS, .u.n = {NULL, 0, 0, 0, 0, 0, NULL} },
+	[SPELL_DELAY_ID] = { SPELL_DELAY, .u.n = {NULL, 0, 0, 4, 0, 0, NULL} },
+	[ATTRIB_BLEEP_ID] = { ATTRIB_BLEEP, .u.n = {NULL, 1, 0, 3, 0, 0, NULL} },
+	[BLEEPS_ID] = { BLEEPS, .u.n = {NULL, 3, 0, 3, 0, 0, NULL} },
+	[BLEEP_TIME_ID] = { BLEEP_TIME, .u.n = {NULL, 30, 1, 200, 0, 0, NULL} },
+	[PUNC_LEVEL_ID] = { PUNC_LEVEL, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
+	[READING_PUNC_ID] = { READING_PUNC, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
+	[CURSOR_TIME_ID] = { CURSOR_TIME, .u.n = {NULL, 120, 50, 600, 0, 0, NULL} },
+	[SAY_CONTROL_ID] { SAY_CONTROL, TOGGLE_0},
+	[SAY_WORD_CTL_ID] = {SAY_WORD_CTL, TOGGLE_0},
+	[NO_INTERRUPT_ID] = { NO_INTERRUPT, TOGGLE_0},
+	[KEY_ECHO_ID] = { KEY_ECHO, .u.n = {NULL, 1, 0, 2, 0, 0, NULL} },
 	V_LAST_VAR
 };

@@ -2453,5 +2461,31 @@ static int __init speakup_init(void)
 	return err;
 }

+module_param_named(bell_pos, spk_vars[BELL_POS_ID].u.n.default_val, int, 0444);
+module_param_named(spell_delay, spk_vars[SPELL_DELAY_ID].u.n.default_val, int, 0444);
+module_param_named(attrib_bleep, spk_vars[ATTRIB_BLEEP_ID].u.n.default_val, int, 0444);
+module_param_named(bleeps, spk_vars[BLEEPS_ID].u.n.default_val, int, 0444);
+module_param_named(bleep_time, spk_vars[BLEEP_TIME_ID].u.n.default_val, int, 0444);
+module_param_named(punc_level, spk_vars[PUNC_LEVEL_ID].u.n.default_val, int, 0444);
+module_param_named(reading_punc, spk_vars[READING_PUNC_ID].u.n.default_val, int, 0444);
+module_param_named(cursor_time, spk_vars[CURSOR_TIME_ID].u.n.default_val, int, 0444);
+module_param_named(say_control, spk_vars[SAY_CONTROL_ID].u.n.default_val, int, 0444);
+module_param_named(say_word_ctl, spk_vars[SAY_WORD_CTL_ID].u.n.default_val, int, 0444);
+module_param_named(no_interrupt, spk_vars[NO_INTERRUPT_ID].u.n.default_val, int, 0444);
+module_param_named(key_echo, spk_vars[KEY_ECHO_ID].u.n.default_val, int, 0444);
+
+MODULE_PARM_DESC(bell_pos, "This works much like a typewriter bell. If for example 72 is echoed to bell_pos, it will beep the PC speaker when typing on a line past character 72.");
+MODULE_PARM_DESC(spell_delay, "This controls how fast a word is spelled when speakup's spell word review command is pressed.");
+MODULE_PARM_DESC(attrib_bleep, "Beeps the PC speaker when there is an attribute change such as background color when using speakup review commands. One = on, zero = off.");
+MODULE_PARM_DESC(bleeps, "This controls whether one hears beeps through the PC speaker when using speakup review commands.");
+MODULE_PARM_DESC(bleep_time, "This controls the duration of the PC speaker beeps speakup produces.");
+MODULE_PARM_DESC(punc_level, "Controls the level of punctuation spoken as the screen is displayed, not reviewed.");
+MODULE_PARM_DESC(reading_punc, "It controls the level of punctuation when reviewing the screen with speakup's screen review commands.");
+MODULE_PARM_DESC(cursor_time, "This controls cursor delay when using arrow keys.");
+MODULE_PARM_DESC(say_control, "This controls if speakup speaks shift, alt and control when those keys are pressed or not.");
+MODULE_PARM_DESC(say_word_ctl, "Sets thw say_word_ctl  on load.");
+MODULE_PARM_DESC(no_interrupt, "Controls if typing interrupts output from speakup.");
+MODULE_PARM_DESC(key_echo, "Controls if speakup speaks keys when they are typed. One = on zero = off or don't echo keys.");
+
 module_init(speakup_init);
 module_exit(speakup_exit);
--
2.38.1
