Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F1639B97
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 16:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiK0PyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK0PyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 10:54:20 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF760DEC0;
        Sun, 27 Nov 2022 07:54:18 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669564456;
        bh=hFVNL9asli5tIDyA3WxJjlkOG1f2F7NESUl0mhNd6YQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OOzbe3dlF1Uxr9eSIlFbZU84yF0v4K1jNDuIEgVUoAqvQpbIUfpRLeBBpvzfde4Uo
         CxMNU8qyRePDw3E7icl5wkBNTOJUezOV77+ie5w2NzfMMAxb0B9pT8L3/JGu9XdGI9
         kJMC++xE2v4RxckNRdI59ScIVKrnVg1SjMkPwlbQ=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] watchdog: core: don't reset KEEPALIVEPING through sysfs
Date:   Sun, 27 Nov 2022 16:45:59 +0100
Message-Id: <20221127154559.80899-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669563958; l=4246; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=hFVNL9asli5tIDyA3WxJjlkOG1f2F7NESUl0mhNd6YQ=; b=aMGG2Q+p8KJE7dtKXkBnNnJl5JcuNK/70jYbUBzbB3ynzcO04qDChCmSESJDF7QwKQVUdSP8wLtJ Zy1JDGSLBn/HciFPOrL/WFhNvBbBCDFS4oBtbI088sEQd0YBeon5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the watchdog status via ioctl(WDIOC_GETSTATUS) or sysfs will
reset the status bit KEEPALIVEPING.

This is done so an application can validate that the watchdog was pinged
since the last read of the status.

For the ioctl-based interface this is fine as only one application can
manage a watchdog interface at a time, so it can properly handle this
implicit state modification.

The sysfs "status" file however is world-readable. This means that the
watchdog state can be modified by any other unprivileged process on the
system.

As the sysfs interface can also not be used to set this bit, let's
remove the capability to clear it.

Fixes: 90b826f17a4e ("watchdog: Implement status function in watchdog core")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

I was not able to find an application (besides wdctl) that uses this
bit. But if applications are to use it, it should probably be reliable.

Other possible solutions I can think of:
* Only reset the bit when the file opened privileged
* Only reset the bit when the file opened writable

Instead of using a status bit to check if the watchdog was pinged it
would probably be more robust to use a sequence counter or timestamp.
Especially as it seems more operations are being exposed over sysfs over
time.

I'm not sure it's worth it though.
---
 Documentation/ABI/testing/sysfs-class-watchdog |  3 ++-
 drivers/watchdog/watchdog_dev.c                | 13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 585caecda3a5..182a8a9e530e 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -38,7 +38,8 @@ Contact:	Wim Van Sebroeck <wim@iguana.be>
 Description:
 		It is a read only file. It contains watchdog device's
 		internal status bits. It is equivalent to WDIOC_GETSTATUS
-		of ioctl interface.
+		of ioctl interface, except that the status bit
+		WDIOF_KEEPALIVEPING is not reset.
 
 What:		/sys/class/watchdog/watchdogn/timeleft
 Date:		August 2015
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 55574ed42504..7e3e964c4d6f 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -320,13 +320,15 @@ static int watchdog_stop(struct watchdog_device *wdd)
 /*
  * watchdog_get_status - wrapper to get the watchdog status
  * @wdd: The watchdog device to get the status from
+ * @reset_keepaliveping: Reset the status bit _WDOG_KEEPALIVE
  *
  * Get the watchdog's status flags.
  * The caller must hold wd_data->lock.
  *
  * Return: watchdog's status flags.
  */
-static unsigned int watchdog_get_status(struct watchdog_device *wdd)
+static unsigned int watchdog_get_status(struct watchdog_device *wdd,
+					bool reset_keepaliveping)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 	unsigned int status;
@@ -345,9 +347,12 @@ static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 	if (test_bit(_WDOG_ALLOW_RELEASE, &wd_data->status))
 		status |= WDIOF_MAGICCLOSE;
 
-	if (test_and_clear_bit(_WDOG_KEEPALIVE, &wd_data->status))
+	if (test_bit(_WDOG_KEEPALIVE, &wd_data->status))
 		status |= WDIOF_KEEPALIVEPING;
 
+	if (reset_keepaliveping)
+		clear_bit(_WDOG_KEEPALIVE, &wd_data->status);
+
 	if (IS_ENABLED(CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT))
 		status |= WDIOF_PRETIMEOUT;
 
@@ -476,7 +481,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	unsigned int status;
 
 	mutex_lock(&wd_data->lock);
-	status = watchdog_get_status(wdd);
+	status = watchdog_get_status(wdd, false);
 	mutex_unlock(&wd_data->lock);
 
 	return sysfs_emit(buf, "0x%x\n", status);
@@ -753,7 +758,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 			sizeof(struct watchdog_info)) ? -EFAULT : 0;
 		break;
 	case WDIOC_GETSTATUS:
-		val = watchdog_get_status(wdd);
+		val = watchdog_get_status(wdd, true);
 		err = put_user(val, p);
 		break;
 	case WDIOC_GETBOOTSTATUS:

base-commit: faf68e3523c21d07c5f7fdabd0daf6301ff8db3f
-- 
2.38.1

