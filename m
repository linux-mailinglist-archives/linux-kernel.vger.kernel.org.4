Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A64654B57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLWCyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLWCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:53:54 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360B22180C;
        Thu, 22 Dec 2022 18:53:50 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671764028;
        bh=tp5IQDd66HLaPMlHoJO8oXKo0WL+92UpGzSydpX6ai0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AMwilpGQDPP/ws734/mKVdWFmLNZ9dK60BkBTUALWMycuOhW3RPwTX+0zqo76hVR5
         5z48pYagnvvB+0M4xqFN7h1GZ9ODLPam/AOVmP+mPnwxSQa365TUKmBYrL9xyZ5LUn
         Q91rAK9QuVW3SSVSNxDzZUpVDtAAs6XPbSws5Niw=
Date:   Fri, 23 Dec 2022 02:53:34 +0000
Subject: [PATCH 1/2] HID: i2c-hid: switch to standard debugging APIs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221223-hid-dbg-v1-1-f641e80263eb@weissschuh.net>
References: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
In-Reply-To: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671764024; l=1216;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tp5IQDd66HLaPMlHoJO8oXKo0WL+92UpGzSydpX6ai0=;
 b=3sQ6cV6Ra3YIWhahC/1T8wR2PjNCVNqOr8YLeqWW4DYvSYvsTtD3JxL3eHh5f5ZK36XfDKb1D8gs
 yKxHy15qBWLs2TUL4hYaU3NJfWuGSnxvHEjTZeIru+R2ipudb/BZ
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

Instead of implementing a custom form of dynamic debugging we can use
the standard debugging APIs. If the kernel is built with
CONFIG_DYNAMIC_DEBUG this will be more discoverable and featureful.

Also the previous module parameter "debug" is read-only so it can't
actually be enabled.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index b86b62f97108..b4ed21f25600 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -67,16 +67,7 @@
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
 
-/* debug option */
-static bool debug;
-module_param(debug, bool, 0444);
-MODULE_PARM_DESC(debug, "print a lot of debug information");
-
-#define i2c_hid_dbg(ihid, fmt, arg...)					  \
-do {									  \
-	if (debug)							  \
-		dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg); \
-} while (0)
+#define i2c_hid_dbg(ihid, ...) dev_dbg(&(ihid)->client->dev, __VA_ARGS__)
 
 struct i2c_hid_desc {
 	__le16 wHIDDescLength;

-- 
2.39.0
