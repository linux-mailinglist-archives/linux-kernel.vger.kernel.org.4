Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317B654B55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiLWCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:53:54 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3292D21269;
        Thu, 22 Dec 2022 18:53:50 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671764028;
        bh=B99KsiMvt1tHeatg1X68sSjUpUUP66/qiYRoMzEGvSg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ed1YIJRuwxAWxH+Jlch5EZIqTvS9nUgRMrj7OWwj17Yrqj1N9Yodo6ryVWSKu83jZ
         7aQlNa3PlMPBz/IY5i3IF57cQPJBETE6NITo/wp5mcJQPxRuJCCqLWTq6AjJMw9MxE
         mK2MHr6RW2mUBT0OahxHXpdYkWA9cfqX5yDUbzhQ=
Date:   Fri, 23 Dec 2022 02:53:35 +0000
Subject: [PATCH 2/2] HID: i2c-hid: use uniform debugging APIs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221223-hid-dbg-v1-2-f641e80263eb@weissschuh.net>
References: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
In-Reply-To: <20221223-hid-dbg-v1-0-f641e80263eb@weissschuh.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671764024; l=1238;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=B99KsiMvt1tHeatg1X68sSjUpUUP66/qiYRoMzEGvSg=;
 b=mQnHRn/UVse5r6MZaKGtGUi7cQMTj6a4EGaSfTS1kuP4EBYXIefrXWIcTajmWpHcC+sSZZliL1Qg
 0wGv6Np5DJrSoVBGM7lynSwM8FGNPYdSsriDIY5K0a+L2M+uy8Zu
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

Only two locations in i2c-hid are using the standard dev_dbg() APIs.
The rest are all using the custom i2c_hid_dbg(), which in turn uses
dev_dbg().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index b4ed21f25600..c83c93716782 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -850,7 +850,7 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 	unsigned long irqflags = 0;
 	int ret;
 
-	dev_dbg(&client->dev, "Requesting IRQ: %d\n", client->irq);
+	i2c_hid_dbg(ihid, "Requesting IRQ: %d\n", client->irq);
 
 	if (!irq_get_trigger_type(client->irq))
 		irqflags = IRQF_TRIGGER_LOW;
@@ -994,7 +994,7 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	/* Make sure there is something at this address */
 	ret = i2c_smbus_read_byte(client);
 	if (ret < 0) {
-		dev_dbg(&client->dev, "nothing at this address: %d\n", ret);
+		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
 		ret = -ENXIO;
 		goto err_powered;
 	}

-- 
2.39.0
