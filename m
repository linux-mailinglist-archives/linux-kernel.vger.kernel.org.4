Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC95639158
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKYWXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKYWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:23:31 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18024205E3;
        Fri, 25 Nov 2022 14:23:31 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669415009;
        bh=NQ+04B6zJQxzHILCfAFkhF13N2/TELUbaH94zEW62cA=;
        h=From:To:Cc:Subject:Date:From;
        b=oGL3K0ftiDi0H3tP1NKq0EhToZqpCPxDfWkxK+snQP0SbS2Z6YbgPIEKrH1XwAbgM
         3GBM/xf75lgSbKmoFcGOI/CtOSqc+txkufagdaEHx5NKcEHmCQoD3Tpw7HssaPMDB+
         TjmQYH5y76RsYzM+kZusZ/GrMisJiPBRbzEAAb/k=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: Report firmware_version in sysfs
Date:   Fri, 25 Nov 2022 23:23:15 +0100
Message-Id: <20221125222315.4925-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669414993; l=1549; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=NQ+04B6zJQxzHILCfAFkhF13N2/TELUbaH94zEW62cA=; b=efEVyF6r8ALLabqaD+48qPvQ0ZPwyjpW7rBNapW//ealEWU/pw+w2BVj8w101tmZmFGGOyWW5dNW DN+TjMYLDnZirs1+g8+4WyrgEjNihcAFyYuGLJUfalO3bzzaFbSW
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

This synchronizes the information reported by ioctl and sysfs.
The mismatch is confusing because "wdctl" from util-linux uses the ioctl
when used with root privileges and sysfs without.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Userspace implementation:

https://github.com/util-linux/util-linux/pull/1927
---
 drivers/watchdog/watchdog_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 55574ed42504..88c76e27873c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -555,6 +555,15 @@ static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(identity);
 
+static ssize_t firmware_version_show(struct device *dev, struct device_attribute *attr,
+				     char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", wdd->info->firmware_version);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
 static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
@@ -618,6 +627,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 static struct attribute *wdt_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_identity.attr,
+	&dev_attr_firmware_version.attr,
 	&dev_attr_timeout.attr,
 	&dev_attr_min_timeout.attr,
 	&dev_attr_max_timeout.attr,

base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
-- 
2.38.1

