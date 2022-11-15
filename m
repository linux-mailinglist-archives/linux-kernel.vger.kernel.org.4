Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0462954E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiKOKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiKOKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:07:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2773205F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:07:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w14so23346976wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPu7bwc+ZranhLPX5AB2LeDrS1+qW0XSqyGwXW15FJY=;
        b=B0M+xp6e67sZ2f07FTofWGuU2cuPrpvpOkA8ld1p02KEmalD04xPWLOxvcY4d6k+Ud
         YCDnc1st2zHdvvmXsCzeqaHz3a2CJxU5DOhF7WFWOCCoD7XSYCiSRPFe2LqgCWn5gcLN
         FqGEsDn9tcc6T5A5ty7JdTEgHXDbfqu1ch0SoGhOx+wqQhLHrYQNoaSRt+sxI0ida4lp
         UHVY4tpWZg7izsiUgKgTnAQGQegqrkm82gfW1ehlLkkuurC4ngitjHVWsMbhMEEiQTfR
         wiAUbPaHB6hJV1FZ24NwNURiAsNy2HSD6t7AlldPKjxSgt7zvB7MgtQhtjpO5RUiGquz
         EDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPu7bwc+ZranhLPX5AB2LeDrS1+qW0XSqyGwXW15FJY=;
        b=QXZrrEznaHKH37qpF5vXLDpueaOqI8mLcDF9pqcqaPpc+Rlk+9FgGVeJkRF/acTLGW
         0E4xUSkJaSf6IWlhK+RJ6NAQ5YqloieDlfBaCiURPjNTTpTwLYzBOORTODRS06/bZzMy
         NdM8qCUCHQeGjgroxKda23y4aenTn2h9PenBhj4VQAlgSqn3CB5/MZ5zGVgfm7xye4CA
         VO17gTFBMYeXoQBkz1Z3e3bXGhhfr4m3MPWxGrsp3HlhOz4XZXihoGHSTR9GlB76eL8X
         UPvxZ4kRq/1qmj+Ae2XKfaDR2kOH21zCitnb+tEgi5dJOBQCBmgfEavzI8psevRQqH42
         MJgw==
X-Gm-Message-State: ANoB5pnCcIFGhLwTF3Ijv7HExdff+yPdWpzBNsMD62xqHqo2DUHsGooK
        ISdGfX7V0fX8gldtdrcVVH0=
X-Google-Smtp-Source: AA0mqf4R/x/n80rD/XYttwZg5yBjNpOQNn8RcsMSg++0FvfG66itcVzgKOBHcg0STDusYt2pvzBvyA==
X-Received: by 2002:a5d:42c7:0:b0:22e:35c9:fce5 with SMTP id t7-20020a5d42c7000000b0022e35c9fce5mr10196528wrr.534.1668506871535;
        Tue, 15 Nov 2022 02:07:51 -0800 (PST)
Received: from arch.localdomain ([119.160.120.210])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003a3170a7af9sm16577154wms.4.2022.11.15.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:07:51 -0800 (PST)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCHv2 1/2] accessibility: speakup: Specify spk_vars among module parameters
Date:   Tue, 15 Nov 2022 15:05:29 +0500
Message-Id: <20221115100530.91174-2-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115100530.91174-1-mushi.shar@gmail.com>
References: <20221115100530.91174-1-mushi.shar@gmail.com>
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
