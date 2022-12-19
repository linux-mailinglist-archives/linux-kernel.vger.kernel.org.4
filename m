Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923256514EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiLSVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiLSVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:30:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3FF000;
        Mon, 19 Dec 2022 13:30:53 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671485451;
        bh=Fa2g4bN8T2fJYrUVKPR4XgCbGFZG+GXnu+qNhNRb8TY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fpxDsYozRYo3qwQv2CmVeB30VH6EARsb/FDKl7bpuGIxk0QdukCg9yRrE3bw2ZR4f
         7jhvPYHHqr9C03xGUmKS5LPdTJSF449ylieKpqMwqEC5c73AuULQqzAMrdYsZSNg8p
         /sHtgCP0PEniouX/1W5hxUDXPajEP/gtW2e9jnbE=
Date:   Mon, 19 Dec 2022 21:30:39 +0000
Subject: [PATCH v2 1/2] watchdog: report fw_version in sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-watchdog-sysfs-v2-1-6189311103a9@weissschuh.net>
References: <20221216-watchdog-sysfs-v2-0-6189311103a9@weissschuh.net>
In-Reply-To: <20221216-watchdog-sysfs-v2-0-6189311103a9@weissschuh.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Wim Van Sebroeck <wim@iguana.be>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671485447; l=2245;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Fa2g4bN8T2fJYrUVKPR4XgCbGFZG+GXnu+qNhNRb8TY=;
 b=sCZpnkOKFcDJi8tGB+H4kXRfBbuz9WDBTrHxyu3nrYHimprtleLfDr9n0lte5G7aFjVs4R7xAmFX
 fm/6zbqKB45EHzrSZjiObLpAzRr1qgCKLcN8AMMFGum6scfYht2B
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

The file is called "fw_version" instead of "firmware_version" as
"firmware_version" is already used as custom attribute by single drivers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/ABI/testing/sysfs-class-watchdog |  7 +++++++
 drivers/watchdog/watchdog_dev.c                | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 585caecda3a5..27c000238fe4 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -6,6 +6,13 @@ Description:
 		device at boot. It is equivalent to WDIOC_GETBOOTSTATUS of
 		ioctl interface.
 
+What:		/sys/class/watchdog/watchdogn/fw_version
+Date:		April 2023
+Contact:	Thomas Weißschuh
+Description:
+		It is a read only file. It contains firmware version of
+		watchdog device.
+
 What:		/sys/class/watchdog/watchdogn/identity
 Date:		August 2015
 Contact:	Wim Van Sebroeck <wim@iguana.be>
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 55574ed42504..7feeda02a531 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -546,6 +546,15 @@ static ssize_t pretimeout_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(pretimeout);
 
+static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", wdd->info->firmware_version);
+}
+static DEVICE_ATTR_RO(fw_version);
+
 static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
@@ -617,6 +626,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 }
 static struct attribute *wdt_attrs[] = {
 	&dev_attr_state.attr,
+	&dev_attr_fw_version.attr,
 	&dev_attr_identity.attr,
 	&dev_attr_timeout.attr,
 	&dev_attr_min_timeout.attr,

-- 
2.39.0
