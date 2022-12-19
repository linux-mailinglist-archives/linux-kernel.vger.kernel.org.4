Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6806514EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiLSVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiLSVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:30:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FCA65DC;
        Mon, 19 Dec 2022 13:30:53 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671485451;
        bh=0IcN0OcF0xL6oMTvYqLoBEg3dP+mgswr0WrxRfjY0gw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pV+JvrVke0VLSZmn1EquemCvnQURZvEce7oeAIm3vZb01hrYHvAI00uPprb7Au27l
         kcjAfVsLpaSt00SYz2/FY8Ef+EQoXKlQ7IX0qRgk7vMgoEH6rgUOMnqs0DA9WhHXID
         JxlRlu4z8ox5ATmR3RpFGUvqx544MJXzB1SBQBmc=
Date:   Mon, 19 Dec 2022 21:30:40 +0000
Subject: [PATCH v2 2/2] watchdog: report options in sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-watchdog-sysfs-v2-2-6189311103a9@weissschuh.net>
References: <20221216-watchdog-sysfs-v2-0-6189311103a9@weissschuh.net>
In-Reply-To: <20221216-watchdog-sysfs-v2-0-6189311103a9@weissschuh.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Wim Van Sebroeck <wim@iguana.be>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671485447; l=2062;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0IcN0OcF0xL6oMTvYqLoBEg3dP+mgswr0WrxRfjY0gw=;
 b=ylN4XsQM9WROkgQr2OO+yeRu5lAb1bc+2SnOBtHRva136jaCkqG9DXjVsNOuDb3yqb6aaz0lxw/i
 dOzMuSIdCSjA0DRmtkxhskp61P87QugqKpbxImBZ366gpreKEHzI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This synchronizes the information reported by ioctl and sysfs.
The mismatch is confusing because "wdctl" from util-linux uses the ioctl
when used with root privileges and sysfs without.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/ABI/testing/sysfs-class-watchdog |  6 ++++++
 drivers/watchdog/watchdog_dev.c                | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 27c000238fe4..94fb74615951 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -6,6 +6,12 @@ Description:
 		device at boot. It is equivalent to WDIOC_GETBOOTSTATUS of
 		ioctl interface.
 
+What:		/sys/class/watchdog/watchdogn/options
+Date:		April 2023
+Contact:	Thomas Weißschuh
+Description:
+		It is a read only file. It contains options of watchdog device.
+
 What:		/sys/class/watchdog/watchdogn/fw_version
 Date:		April 2023
 Contact:	Thomas Weißschuh
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 7feeda02a531..2b06c179f754 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -546,6 +546,15 @@ static ssize_t pretimeout_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(pretimeout);
 
+static ssize_t options_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%x\n", wdd->info->options);
+}
+static DEVICE_ATTR_RO(options);
+
 static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr,
 			       char *buf)
 {
@@ -626,6 +635,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 }
 static struct attribute *wdt_attrs[] = {
 	&dev_attr_state.attr,
+	&dev_attr_options.attr,
 	&dev_attr_fw_version.attr,
 	&dev_attr_identity.attr,
 	&dev_attr_timeout.attr,

-- 
2.39.0
