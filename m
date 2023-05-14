Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC1701C5A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjENIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjENIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 04:37:35 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803401FFA;
        Sun, 14 May 2023 01:37:29 -0700 (PDT)
X-QQ-mid: bizesmtp66t1684053432tce54aww
Received: from localhost.localdomain ( [58.249.112.23])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 14 May 2023 16:37:02 +0800 (CST)
X-QQ-SSF: 01400000000000B0F000000A0000000
X-QQ-FEAT: fmY4SgAPM3uT29x4WrbIg225pQVmtt2NBRaJGUbT6ssQQiZUNFCsyQD7+HhwJ
        yz8Wp4qoF7WsNRt+v3lm5TP/Qmhous3/d1kPnfkDe0DeAMUubGpj6aT7zudZAYBZCHOam0R
        K7+ox1jkdklhs1NIk8KpWGbcfcPfq+Y3hcGjBoAeTM1CEQD9K84RWdv5E+62dG9BZ2bBYlx
        c0miernL/FaGV0HLnBjYGOme8r2xppHFaGmumSUoewHY8AZ/q6xpHfOQEHxomhy02hVuZPa
        Ib7rPmkA+Eej6Q3+fPnL7utUFFUzEEtZn7Ki/y2fTTwCnMpkz94UfkPUm9eTM3ylqu50PIH
        TUvUOXfpv2CMNQMIqJGha1b8LbEY6VG3rGKUKGjUdFCkBpGfFJC94LjAB98IEhBSDIdKIXo
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6169700298678636486
From:   Shang Ye <yesh25@mail2.sysu.edu.cn>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Shang Ye <yesh25@mail2.sysu.edu.cn>,
        Bernhard Kaindl <bernhard.kaindl@cloud.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: atkbd - allow skipping the check of keyboard ID when probing
Date:   Sun, 14 May 2023 16:33:36 +0800
Message-Id: <20230514083336.3811-1-yesh25@mail2.sysu.edu.cn>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mail2.sysu.edu.cn:qybglogicsvrsz:qybglogicsvrsz3a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

It seems that the i8042 implementation on the laptop omitted the `0xab`
byte from its response to the Get ID command, thus making the
`atkbd_probe` function fail for receiving an invalid keyboard ID (should
normally be `0xab 0x83`).

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

This time even the byte `0x83` was omitted, so the Get ID command
failed and `atkbd_probe` tried to set the LEDs on the keyboard, but
failed again for not receiving an ACK to the command byte `0xed`.
However, when `i8042_port_close` was later called, an ACK was read from
the KBD port, which indicates that the i8042 implementation might have
failed to raise an interrupt for this ACK.

And the next time I released the space key, the byte `0x83` was omitted
again, but `atkbd_probe` somehow succeeded in receiving an ACK to the
Set LEDs command, and the keyboard was finally initialized properly.

Until now, the only workaround is to boot with the kernel parameter
`i8042.dumbkbd`, which isn't very desirable as it disables the Caps Lock
LED. I have considered an alternative, generic fix that involves
flushing the keyboard buffer immediately after the Get ID command and
trying to set the LEDs even if the keyboard ID is invalid. This worked
on my laptop at least, but I really doubt that it won't cause any
regressions and that a generic fix is at all worth it for an unusual
firmware bug like this.

This patch adds an option that controls whether to skip the check of
keyboard ID when probing and try to set the LEDs directly. The option is
enabled only via the quirk table entries.

The patch is tested on an `82NC` and an `82TK` laptop and works very
well. Although untested on the other 7 types of laptops, they are also
added to the quirk table, considering the fact that they share the same
problem (inferred from user reports saying `i8042.dumbkbd` solves the
problem and from suspiciously long keyboard init time in dmesg logs) and
the same BIOS firmware (`FJCN\d\dWW` for `82{FX,G2,GH,NC,NH,QT}` and
`ESCN\d\dWW` for `82{D1,D2}`). This shouldn't have any measurable side
effect even if it doesn't fix things.

Part of the patch is based on Bernhard's initial work.

Link: https://lore.kernel.org/linux-input/A3D566C5B262EC0F+4ede8371-9a20-6e5d-6a8c-b44d15634e26@mail2.sysu.edu.cn/
Cc: Bernhard Kaindl <bernhard.kaindl@cloud.com>
Reported-by: Bernhard Kaindl <bernhard.kaindl@cloud.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216994
Signed-off-by: Shang Ye <yesh25@mail2.sysu.edu.cn>
---
 drivers/input/keyboard/atkbd.c | 102 +++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 246958795f60..b4cefa052c9b 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -252,6 +252,12 @@ static unsigned int (*atkbd_platform_scancode_fixup)(struct atkbd *, unsigned in
  */
 static bool atkbd_skip_deactivate;
 
+/*
+ * Some laptops have problematic i8042 implementations that do not
+ * respond well to the Get ID command.
+ */
+static bool atkbd_skip_id_check;
+
 static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
 				ssize_t (*handler)(struct atkbd *, char *));
 static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t count,
@@ -775,12 +781,12 @@ static int atkbd_probe(struct atkbd *atkbd)
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
@@ -1731,6 +1737,12 @@ static int __init atkbd_deactivate_fixup(const struct dmi_system_id *id)
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
@@ -1880,6 +1892,88 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo Yoga Slim 9 14ITL5 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82D1"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
+	{
+		/* Lenovo IdeaPad Slim 9 14ITL5 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82D2"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
+	{
+		/* Lenovo Yoga Slim 7 Pro 14ITL5 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82FX"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
+	{
+		/* Lenovo Yoga 14sITL 2021 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82G2"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
+	{
+		/* Lenovo XiaoXinPro 14ITL 2021 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82GH"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
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
+		 * Lenovo Yoga 14sIHU 2021 O
+		 * Lenovo Yoga Slim 7 Pro 14IHU5 O
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82NH"),
+		},
+		.callback = atkbd_id_check_fixup,
+	},
+	{
+		/* Lenovo IdeaPad Slim 7 Pro 14IHU5 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QT"),
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
 

base-commit: 17caa38a988e8f73e392f1f5ec2afb854552edcc
-- 
2.40.1

