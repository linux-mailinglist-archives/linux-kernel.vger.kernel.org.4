Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577472E738
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbjFMPce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbjFMPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:32:32 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 08:32:29 PDT
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E57122;
        Tue, 13 Jun 2023 08:32:29 -0700 (PDT)
Received: from lab-pc42.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 21089FB0;
        Tue, 13 Jun 2023 17:27:10 +0200 (CEST)
From:   Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        Nils Fuhler <nils@nilsfuhler.de>
Subject: [PATCH RESEND] HID: input: Support devices sending Eraser without Invert
Date:   Tue, 13 Jun 2023 17:26:00 +0200
Message-Id: <20230613152559.108594-1-ostapyshyn@sra.uni-hannover.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at mailout1n
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

