Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4471614C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjE3NP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjE3NP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:15:26 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC00A9C;
        Tue, 30 May 2023 06:15:14 -0700 (PDT)
X-QQ-mid: bizesmtp71t1685452428tef2npwh
Received: from localhost.localdomain ( [58.249.112.22])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 21:13:42 +0800 (CST)
X-QQ-SSF: 01400000000000B0F000000A0000000
X-QQ-FEAT: ILHsT53NKPgG+5rRPjqiuO3evje0npZ48HLQI9v8/GFZq0JxmwEJsZV091sRy
        k4YIQzV9hPHcrHZSkwQLnYthg21UXwn6Wg6dLjKk6jt9ezYcLk0dvcVtpIB+gnowa4aAzOu
        ofNirvBB0jkoxPV4sziz3ZprZgJnNPrdpIsVFEH/MNhCC3N2KnHWV9V+2cAWzBSLLxVAK8w
        IgF6xUhnjj/ywTdOCoAuc8mUi4Hyg9UNE304g0GYSCIuq38QFiKeJt2yzElsQJPGfRJsTTO
        pX0cMJeI9cV0g1WIa18A5++/izIp8RSxieXh4AtinS27DAbP98Q0JPyx1oJjqkBUsq2y4n9
        3RYscFVahYQRgA7dmgBtM+DRu6+LwRjQWNd6CAEyQ0VGFz9bG+c5FzN4xAxUjGfCK/vvzR8
        FvWF+XsK/fE=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5297864074693950859
From:   Shang Ye <yesh25@mail2.sysu.edu.cn>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shang Ye <yesh25@mail2.sysu.edu.cn>,
        Bernhard Kaindl <bernhard.kaindl@cloud.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: atkbd - allow skipping the check of keyboard ID when probing
Date:   Tue, 30 May 2023 21:13:40 +0800
Message-Id: <20230530131340.39961-1-yesh25@mail2.sysu.edu.cn>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mail2.sysu.edu.cn:qybglogicsvrsz:qybglogicsvrsz3a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been several reports about keyboard not working on 9 types of
Lenovo Yoga / XiaoXinPro / IdeaPad (14", Intel) laptops. Here is a dmesg
log that illustrates the problem on a Yoga 14sIHU 2021:
https://gist.github.com/yescallop/5a97d010f226172fafab0933ce8ea8af

At first the KBD port was successfully set up by `i8042`, but then the
first initialization attempt by `atkbd` failed:

    [    2.698474] i8042: [17] f2 -> i8042 (kbd-data)
    [    2.698678] i8042: [17] fa <- i8042 (interrupt, 0, 1)
    [    2.698746] i8042: [17] 83 <- i8042 (interrupt, 0, 1)
    [    2.698767] i8042: [17] 60 -> i8042 (command)
    [    2.698856] i8042: [17] 66 -> i8042 (parameter)
    [    2.698951] i8042: [17] 60 -> i8042 (command)
    [    2.699092] i8042: [17] 67 -> i8042 (parameter)

It seems that the i8042 implementation on the laptop omitted the byte
0xab from its response to the Get ID command, thus making atkbd_probe()
fail on receiving an invalid keyboard ID (should normally be 0xab83).

This situation went on for a few rounds when I pressed and released the
space key (scan code: 0x39 when pressed, 0xb9 when released). The sixth
time I pressed the space key, something different happened:

    [   48.188540] i8042: [13664] 39 <- i8042 (interrupt, 0, 1)
    [   48.188658] i8042: [13664] f2 -> i8042 (kbd-data)
    [   48.188998] i8042: [13664] fa <- i8042 (interrupt, 0, 1)
    [   48.709743] i8042: [13821] ed -> i8042 (kbd-data)
    [   48.913069] i8042: [13882] 60 -> i8042 (command)
    [   48.913235] i8042: [13882] 66 -> i8042 (parameter)
    [   48.913446] i8042: [13882] 60 -> i8042 (command)
    [   48.913591] i8042: [13882] 67 -> i8042 (parameter)
    [   48.913672] i8042: [13882] fa <- i8042 (interrupt, 0, 0)

This time even the byte 0x83 was omitted, so the Get ID command failed
and atkbd_probe() tried to set the LEDs on the keyboard, but failed
again for not receiving an ACK to the command byte 0xed. However, when
i8042_port_close() was later called, an ACK was read from the KBD port,
which indicates that the i8042 implementation might have failed to raise
an interrupt for this ACK.

And the next time I released the space key, the byte 0x83 was omitted
again, but atkbd_probe() somehow succeeded in receiving an ACK to the
Set LEDs command, and the keyboard was finally initialized properly.

Until now, the only workaround is to boot with the kernel parameter
`i8042.dumbkbd`, which isn't very desirable as it disables the Caps Lock
LED. I have considered an alternative, generic fix that involves
flushing the keyboard buffer immediately after the Get ID command and
trying to set the LEDs even if the keyboard ID is invalid. This worked
on my laptop at least, but I really doubt that it won't cause any
regressions.

This patch adds a kernel parameter `atkbd.skip_id_check` that, when
enabled, skip the check of keyboard ID when probing and try to set the
LEDs directly, and adds quirks that enable the parameter by default on
`82NC` and `82TK` models, as these are the only models on which the
patch was tested to work.

Part of the patch is based on Bernhard's initial work.

Link: https://lore.kernel.org/linux-input/A3D566C5B262EC0F+4ede8371-9a20-6e5d-6a8c-b44d15634e26@mail2.sysu.edu.cn/
Cc: Bernhard Kaindl <bernhard.kaindl@cloud.com>
Reported-by: Bernhard Kaindl <bernhard.kaindl@cloud.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216994
Signed-off-by: Shang Ye <yesh25@mail2.sysu.edu.cn>
---
V1 -> V2: Added kernel parameter and removed untested models

 .../admin-guide/kernel-parameters.txt         |  3 ++
 drivers/input/keyboard/atkbd.c                | 49 +++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..2a679a81e6fa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -421,6 +421,9 @@
 	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar
 			keyboards
 
+	atkbd.skip_id_check=
+			[HW] Skip the check of keyboard ID when probing
+
 	atkbd.softraw=	[HW] Choose between synthetic and real raw mode
 			Format: <bool> (0 = real, 1 = synthetic (default))
 
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c92e544c792d..daf5a1821c42 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -65,6 +65,10 @@ static bool atkbd_terminal;
 module_param_named(terminal, atkbd_terminal, bool, 0);
 MODULE_PARM_DESC(terminal, "Enable break codes on an IBM Terminal keyboard connected via AT/PS2");
 
+static bool atkbd_skip_id_check;
+module_param_named(skip_id_check, atkbd_skip_id_check, bool, 0);
+MODULE_PARM_DESC(skip_id_check, "Skip the check of keyboard ID when probing");
+
 #define SCANCODE(keymap)	((keymap >> 16) & 0xFFFF)
 #define KEYCODE(keymap)		(keymap & 0xFFFF)
 
@@ -794,12 +798,12 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (atkbd_skip_id_check || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command failed, we check if we can at least set the LEDs on
- * the keyboard. This should work on every keyboard out there. It also turns
- * the LEDs off, which we want anyway.
+ * If the Get ID command failed or is skipped, we check if we can at least set
+ * the LEDs on the keyboard. This should work on every keyboard out there. It
+ * also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
@@ -1751,6 +1755,12 @@ static int __init atkbd_deactivate_fixup(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int __init atkbd_id_check_fixup(const struct dmi_system_id *id)
+{
+	atkbd_skip_id_check = true;
+	return 1;
+}
+
 /*
  * NOTE: do not add any more "force release" quirks to this table.  The
  * task of adjusting list of keys that should be "released" automatically
@@ -1900,6 +1910,37 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	/*
+	 * Some laptops have erroneous i8042 implementations that may randomly
+	 * omit interrupts and/or bytes in response to the Get ID command and
+	 * then cause atkbd_probe() to fail on receiving an invalid ID, or on
+	 * receiving no ID and then no ACK to the consequent Set LEDs command.
+	 * For this reason, we simply skip the Get ID command on these laptops
+	 * to avoid any potential issues.
+	 */
+	{
+		/*
+		 * Lenovo Yoga 14sIHU 2021
+		 * Lenovo XiaoXinPro 14IHU 2021
+		 * Lenovo Yoga Slim 7 Pro 14IHU5
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82NC"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
+	{
+		/*
+		 * Lenovo Yoga Pro 14s IAH7
+		 * Lenovo Yoga Slim 7 ProX 14IAH7
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82TK"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
 	{ }
 };
 

base-commit: b00315628095075da4af8d6d519d85d95117de09
-- 
2.40.1

