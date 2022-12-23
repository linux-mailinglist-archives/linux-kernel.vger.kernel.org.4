Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A226554BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 22:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLWVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 16:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWVa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 16:30:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002511EEED;
        Fri, 23 Dec 2022 13:30:24 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671831022;
        bh=tHIlOjWM7+q2TmrVuJ0sxPOrXr74jY1VNP1Ju2+Hm3E=;
        h=From:Date:Subject:To:Cc:From;
        b=LXyApAhMiMmMwB72WkKpU8JIk1f1ZJl5mXGfL8OlyL1xog3GIFkS1NGS/0O9l+hpV
         9HunEQxHFRkVFMqBsxhdPSMcRNEAIxel9Qd3BFxv+RUVaM8xG8QypRvvQbur8HJy/O
         7A58a2f9KfdYP+7Dm5PyUOY/qcxPfz4F6fF25omg=
Date:   Fri, 23 Dec 2022 21:30:19 +0000
Subject: [PATCH] HID: use standard debug APIs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221223-hid-dbg-v1-1-5dcf8794f7f9@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOsdpmMC/x2MQQqAMAwEv1JyNmBTvPgV8dDaaANSpUURxL8b3
 dssw9xQuQhX6M0NhU+psmUF2xiYks8Lo0RloJbIEjlMEjGGBWl2zPFb50Dt4CtjKD5PSf18rKue
 e+FZrj8/jM/zApifyUJuAAAA
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671831020; l=2844;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tHIlOjWM7+q2TmrVuJ0sxPOrXr74jY1VNP1Ju2+Hm3E=;
 b=SwAsw7VOVSn0nO1bmIYtkjFtd0frpslEZB4ejwJpvuJLlrqRbkhSXVP7JaFcFrOCpUFgDYq9Rihs
 N//M5SNxB9XvChGLd8Q1bjtLdB9flN/aSexIAPpp/9OguFxmY1ru
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom "debug" module parameter is fairly inflexible.
It can only manage debugging for all calls dbg_hid() at the same time.

Furthermore it creates a mismatch between calls to hid_dbg() which can
be managed by CONFIG_DYNAMIC_DEBUG and dbg_hid() which is managed by the
module parameter.

Furthermore the change to pr_debug() allows the debugging statements to
be completely compiled-out if desired.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

Note: This removes the possibility to enable debugging for the HID core
and all drivers at the same time.
If this is still desirable it could probably be implemented with the new
DYNAMIC_DEBUG class feature.
---
 drivers/hid/hid-core.c | 9 ---------
 include/linux/hid.h    | 8 +-------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd47628da6be..4facfb446986 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -41,11 +41,6 @@
 
 #define DRIVER_DESC "HID core driver"
 
-int hid_debug = 0;
-module_param_named(debug, hid_debug, int, 0600);
-MODULE_PARM_DESC(debug, "toggle HID debugging messages");
-EXPORT_SYMBOL_GPL(hid_debug);
-
 static int hid_ignore_special_drivers = 0;
 module_param_named(ignore_special_drivers, hid_ignore_special_drivers, int, 0600);
 MODULE_PARM_DESC(ignore_special_drivers, "Ignore any special drivers and handle all devices by generic driver");
@@ -2909,10 +2904,6 @@ static int __init hid_init(void)
 {
 	int ret;
 
-	if (hid_debug)
-		pr_warn("hid_debug is now used solely for parser and driver debugging.\n"
-			"debugfs is now used for inspecting the device (report descriptor, reports)\n");
-
 	ret = bus_register(&hid_bus_type);
 	if (ret) {
 		pr_err("can't register hid bus\n");
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8677ae38599e..676f501507aa 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -882,8 +882,6 @@ static inline bool hid_is_usb(struct hid_device *hdev)
 
 /* HID core API */
 
-extern int hid_debug;
-
 extern bool hid_ignore(struct hid_device *);
 extern int hid_add_device(struct hid_device *);
 extern void hid_destroy_device(struct hid_device *);
@@ -1191,11 +1189,7 @@ int hid_pidff_init(struct hid_device *hid);
 #define hid_pidff_init NULL
 #endif
 
-#define dbg_hid(fmt, ...)						\
-do {									\
-	if (hid_debug)							\
-		printk(KERN_DEBUG "%s: " fmt, __FILE__, ##__VA_ARGS__);	\
-} while (0)
+#define dbg_hid(fmt, ...) pr_debug("%s: " fmt, __FILE__, ##__VA_ARGS__)
 
 #define hid_err(hid, fmt, ...)				\
 	dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)

---
base-commit: 51094a24b85e29138b7fa82ef1e1b4fe19c90046
change-id: 20221223-hid-dbg-2f3eeddddd53

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
