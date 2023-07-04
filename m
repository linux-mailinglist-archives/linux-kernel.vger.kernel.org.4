Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45710747964
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGDVDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjGDVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:03:34 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713210CF;
        Tue,  4 Jul 2023 14:03:31 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688504609;
        bh=tqVMOqnScNJRf+yfQ7pzLwp2YiCvgJ89KjSrmIHLwWk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ToeldVGrLtFw8nRWOaPDTwRkrN5E8HCbuT3XQhj69oloyQq442KVByovPBcl7O0//
         FqgEcNpyBTNAYxSPHWdqHuPACVFfBVreLMn/GhceYweTMXUJ46MjGWApk0clt6GgR4
         TSDuWJ/6fx4LzTV4wZIQEIAnpr62v/0ij/lFWAgk=
Date:   Tue, 04 Jul 2023 23:03:18 +0200
Subject: [PATCH 2/2] platform/x86: thinkpad_acpi: use lockdep annotations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230704-thinkpad_acpi-lockdep-v1-2-60129548a738@weissschuh.net>
References: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
In-Reply-To: <20230704-thinkpad_acpi-lockdep-v1-0-60129548a738@weissschuh.net>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688504608; l=5236;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tqVMOqnScNJRf+yfQ7pzLwp2YiCvgJ89KjSrmIHLwWk=;
 b=/UndyHBCWnp4fW8/n+9txbeHsGAoayOqy6iWCd4af/oEiTNa6NZ1fkYnCwmtJ2QoPvmdcDNUX
 PTUKWyroPukANN/R+6M7nNGrjl6mTkKj41d018RTC6oBJHOVEQoSbx9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on free-form comments to document locking
requirements use well-known lockdep annotations.
These can also be validated at runtime make sure the invariants are not
violated.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 41 +++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b796e65c99e0..25cc86a4a36a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -50,6 +50,7 @@
 #include <linux/kthread.h>
 #include <linux/leds.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvram.h>
@@ -2071,11 +2072,11 @@ static int hotkey_get_tablet_mode(int *status)
  * hotkey_acpi_mask accordingly.  Also resets any bits
  * from hotkey_user_mask that are unavailable to be
  * delivered (shadow requirement of the userspace ABI).
- *
- * Call with hotkey_mutex held
  */
 static int hotkey_mask_get(void)
 {
+	lockdep_assert_held(&hotkey_mutex);
+
 	if (tp_features.hotkey_mask) {
 		u32 m = 0;
 
@@ -2111,8 +2112,6 @@ static void hotkey_mask_warn_incomplete_mask(void)
  * Also calls hotkey_mask_get to update hotkey_acpi_mask.
  *
  * NOTE: does not set bits in hotkey_user_mask, but may reset them.
- *
- * Call with hotkey_mutex held
  */
 static int hotkey_mask_set(u32 mask)
 {
@@ -2121,6 +2120,8 @@ static int hotkey_mask_set(u32 mask)
 
 	const u32 fwmask = mask & ~hotkey_source_mask;
 
+	lockdep_assert_held(&hotkey_mutex);
+
 	if (tp_features.hotkey_mask) {
 		for (i = 0; i < 32; i++) {
 			if (!acpi_evalf(hkey_handle,
@@ -2152,13 +2153,13 @@ static int hotkey_mask_set(u32 mask)
 
 /*
  * Sets hotkey_user_mask and tries to set the firmware mask
- *
- * Call with hotkey_mutex held
  */
 static int hotkey_user_mask_set(const u32 mask)
 {
 	int rc;
 
+	lockdep_assert_held(&hotkey_mutex);
+
 	/* Give people a chance to notice they are doing something that
 	 * is bound to go boom on their users sooner or later */
 	if (!tp_warned.hotkey_mask_ff &&
@@ -2519,21 +2520,23 @@ static int hotkey_kthread(void *data)
 	return 0;
 }
 
-/* call with hotkey_mutex held */
 static void hotkey_poll_stop_sync(void)
 {
+	lockdep_assert_held(&hotkey_mutex);
+
 	if (tpacpi_hotkey_task) {
 		kthread_stop(tpacpi_hotkey_task);
 		tpacpi_hotkey_task = NULL;
 	}
 }
 
-/* call with hotkey_mutex held */
 static void hotkey_poll_setup(const bool may_warn)
 {
 	const u32 poll_driver_mask = hotkey_driver_mask & hotkey_source_mask;
 	const u32 poll_user_mask = hotkey_user_mask & hotkey_source_mask;
 
+	lockdep_assert_held(&hotkey_mutex);
+
 	if (hotkey_poll_freq > 0 &&
 	    (poll_driver_mask ||
 	     (poll_user_mask && tpacpi_inputdev->users > 0))) {
@@ -2562,9 +2565,10 @@ static void hotkey_poll_setup_safe(const bool may_warn)
 	mutex_unlock(&hotkey_mutex);
 }
 
-/* call with hotkey_mutex held */
 static void hotkey_poll_set_freq(unsigned int freq)
 {
+	lockdep_assert_held(&hotkey_mutex);
+
 	if (!freq)
 		hotkey_poll_stop_sync();
 
@@ -6664,12 +6668,13 @@ static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 
 static struct mutex brightness_mutex;
 
-/* NVRAM brightness access,
- * call with brightness_mutex held! */
+/* NVRAM brightness access */
 static unsigned int tpacpi_brightness_nvram_get(void)
 {
 	u8 lnvram;
 
+	lockdep_assert_held(&brightness_mutex);
+
 	lnvram = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
 		  & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
 		  >> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
@@ -6717,11 +6722,12 @@ static void tpacpi_brightness_checkpoint_nvram(void)
 }
 
 
-/* call with brightness_mutex held! */
 static int tpacpi_brightness_get_raw(int *status)
 {
 	u8 lec = 0;
 
+	lockdep_assert_held(&brightness_mutex);
+
 	switch (brightness_mode) {
 	case TPACPI_BRGHT_MODE_UCMS_STEP:
 		*status = tpacpi_brightness_nvram_get();
@@ -6737,12 +6743,13 @@ static int tpacpi_brightness_get_raw(int *status)
 	}
 }
 
-/* call with brightness_mutex held! */
 /* do NOT call with illegal backlight level value */
 static int tpacpi_brightness_set_ec(unsigned int value)
 {
 	u8 lec = 0;
 
+	lockdep_assert_held(&brightness_mutex);
+
 	if (unlikely(!acpi_ec_read(TP_EC_BACKLIGHT, &lec)))
 		return -EIO;
 
@@ -6754,12 +6761,13 @@ static int tpacpi_brightness_set_ec(unsigned int value)
 	return 0;
 }
 
-/* call with brightness_mutex held! */
 static int tpacpi_brightness_set_ucmsstep(unsigned int value)
 {
 	int cmos_cmd, inc;
 	unsigned int current_value, i;
 
+	lockdep_assert_held(&brightness_mutex);
+
 	current_value = tpacpi_brightness_nvram_get();
 
 	if (value == current_value)
@@ -8208,11 +8216,10 @@ static bool fan_select_fan2(void)
 	return true;
 }
 
-/*
- * Call with fan_mutex held
- */
 static void fan_update_desired_level(u8 status)
 {
+	lockdep_assert_held(&fan_mutex);
+
 	if ((status &
 	     (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
 		if (status > 7)

-- 
2.41.0

