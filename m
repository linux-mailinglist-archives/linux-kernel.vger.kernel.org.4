Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF2718142
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjEaNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjEaNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:18:49 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 06:18:45 PDT
Received: from mailgate1.uni-hannover.de (mailgate1.uni-hannover.de [130.75.2.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C841D9;
        Wed, 31 May 2023 06:18:45 -0700 (PDT)
Received: from lab.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        by mailgate1.uni-hannover.de (Postfix) with SMTP id C9325C04E7;
        Wed, 31 May 2023 15:05:42 +0200 (CEST)
Received: (nullmailer pid 94466 invoked by uid 20417);
        Wed, 31 May 2023 13:05:42 -0000
From:   Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nils Fuhler <nils@nilsfuhler.de>
Subject: [PATCH] HID: input: Support devices sending Eraser without Invert
Date:   Wed, 31 May 2023 15:03:41 +0200
Message-Id: <20230531130340.94083-1-ostapyshyn@sra.uni-hannover.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at mailgate1
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some digitizers (notably XP-Pen Artist 24) do not report the Invert
usage when erasing.  This causes the device to be permanently stuck with
the BTN_TOOL_RUBBER tool after sending Eraser, as Invert is the only
usage that can release the tool.  In this state, Touch and Inrange are
no longer reported to userspace, rendering the pen unusable.

Prior to commit 87562fcd1342 ("HID: input: remove the need for
HID_QUIRK_INVERT"), BTN_TOOL_RUBBER was never set and Eraser events were
simply translated into BTN_TOUCH without causing an inconsistent state.

Introduce HID_QUIRK_NOINVERT for such digitizers and detect them during
hidinput_configure_usage().  This quirk causes the tool to be released
as soon as Eraser is reported as not set.  Set BTN_TOOL_RUBBER in
input->keybit when mapping Eraser.

Fixes: 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
Co-developed-by: Nils Fuhler <nils@nilsfuhler.de>
Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>
Signed-off-by: Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
---
We were wondering about the reason to keep quirk bits reserved for
backward compatibility.  Is it because of dynamic quirks at module load
time?  In that case, it could be reasonable to revive bit 0 for this
purpose as it was overwritten in hidinput_hid_event() anyway.
---
 drivers/hid/hid-input.c | 18 ++++++++++++++++--
 include/linux/hid.h     |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a1d2690a1a0d..c443f78287df 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -988,6 +988,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			return;
 
 		case 0x3c: /* Invert */
+			device->quirks &= ~HID_QUIRK_NOINVERT;
 			map_key_clear(BTN_TOOL_RUBBER);
 			break;
 
@@ -1013,9 +1014,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x45: /* ERASER */
 			/*
 			 * This event is reported when eraser tip touches the surface.
-			 * Actual eraser (BTN_TOOL_RUBBER) is set by Invert usage when
-			 * tool gets in proximity.
+			 * Actual eraser (BTN_TOOL_RUBBER) is set and released either
+			 * by Invert if tool reports proximity or by Eraser directly.
 			 */
+			if (!test_bit(BTN_TOOL_RUBBER, input->keybit)) {
+				device->quirks |= HID_QUIRK_NOINVERT;
+				set_bit(BTN_TOOL_RUBBER, input->keybit);
+			}
 			map_key_clear(BTN_TOUCH);
 			break;
 
@@ -1579,6 +1584,15 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		else if (report->tool != BTN_TOOL_RUBBER)
 			/* value is off, tool is not rubber, ignore */
 			return;
+		else if (*quirks & HID_QUIRK_NOINVERT &&
+			 !test_bit(BTN_TOUCH, input->key)) {
+			/*
+			 * There is no invert to release the tool, let hid_input
+			 * send BTN_TOUCH with scancode and release the tool after.
+			 */
+			hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
+			return;
+		}
 
 		/* let hid-input set BTN_TOUCH */
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 4e4c4fe36911..7cbc10073a1f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -360,6 +360,7 @@ struct hid_item {
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
 #define HID_QUIRK_HAVE_SPECIAL_DRIVER		BIT(19)
 #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
+#define HID_QUIRK_NOINVERT			BIT(21)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)
-- 
2.30.2

