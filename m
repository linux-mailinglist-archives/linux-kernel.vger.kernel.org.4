Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF567FDD3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjA2JYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2JYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:24:13 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505222024
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:24:11 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id ZCC00006;
        Sun, 29 Jan 2023 17:24:06 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.16; Sun, 29 Jan 2023 17:24:07 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] misc: isl29003: Use sysfs_emit() to instead of sprintf()
Date:   Sun, 29 Jan 2023 04:23:57 -0500
Message-ID: <20230129092357.3143-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2023129172406d6df5ae4e7120928f8239696f9c78a07
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/misc/isl29003.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index aeda2fa89e61..147b58f7968d 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -186,7 +186,7 @@ static ssize_t isl29003_show_range(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return sprintf(buf, "%i\n", isl29003_get_range(client));
+	return sysfs_emit(buf, "%i\n", isl29003_get_range(client));
 }
 
 static ssize_t isl29003_store_range(struct device *dev,
@@ -222,7 +222,7 @@ static ssize_t isl29003_show_resolution(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return sprintf(buf, "%d\n", isl29003_get_resolution(client));
+	return sysfs_emit(buf, "%d\n", isl29003_get_resolution(client));
 }
 
 static ssize_t isl29003_store_resolution(struct device *dev,
@@ -256,7 +256,7 @@ static ssize_t isl29003_show_mode(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return sprintf(buf, "%d\n", isl29003_get_mode(client));
+	return sysfs_emit(buf, "%d\n", isl29003_get_mode(client));
 }
 
 static ssize_t isl29003_store_mode(struct device *dev,
@@ -291,7 +291,7 @@ static ssize_t isl29003_show_power_state(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	return sprintf(buf, "%d\n", isl29003_get_power_state(client));
+	return sysfs_emit(buf, "%d\n", isl29003_get_power_state(client));
 }
 
 static ssize_t isl29003_store_power_state(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t isl29003_show_lux(struct device *dev,
 	if (!isl29003_get_power_state(client))
 		return -EBUSY;
 
-	return sprintf(buf, "%d\n", isl29003_get_adc_value(client));
+	return sysfs_emit(buf, "%d\n", isl29003_get_adc_value(client));
 }
 
 static DEVICE_ATTR(lux, S_IRUGO, isl29003_show_lux, NULL);
-- 
2.27.0

