Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4F64E867
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLPJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLPJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:00:19 -0500
X-Greylist: delayed 1408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 01:00:17 PST
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E64BEE;
        Fri, 16 Dec 2022 01:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=87aWwPPjK19BvtHVTIVboj/uOUAwcf66BPCr/bQAgog=; b=QKCiMpWWv9MV2soRPTwd0LYaC9
        vK8RSvKKzsIDdI65zdjiOLVISol8ouOPP98/y7ENY23IZjuNZjnqAVPEHpxExT4S3bq5lNyJiw5fy
        Cb7Gd+wpo5fLu3aDzFMRaRgVftuVefnRmzit5hblWBuJGYUlSA8nbs0mWkGYBhUwNPJajOBtnbbrd
        C7pATXkK+3PsiupAOEK0euz+6imQU8lkpF2f6S+yKt0HChKRS+MZoLIefN6m3AEkQghPsfPCLpBh9
        AZozyGkc24OPUs5E45kNZPDOY/Wo4tONmllIbmpPtXZTRCbQTfwmbrsGvqV31FC3YdUYP2LEIwD67
        xWCnpRwQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:44022 helo=z840.regau.abatec.at)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <primoz.fiser@norik.com>)
        id 1p66Cq-004psH-2n;
        Fri, 16 Dec 2022 09:36:43 +0100
From:   Primoz Fiser <primoz.fiser@norik.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     upstream@lists.phytec.de
Subject: [PATCH] watchdog: da9062: da9063: use unlocked xfer function in restart
Date:   Fri, 16 Dec 2022 09:36:45 +0100
Message-Id: <20221216083645.2574077-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Machine resets via da9062/da9063 PMICs are challenging since one needs
to use special i2c atomic transfers due to the fact interrupts are
disabled in such late system stages. This is the reason both PMICs don't
use regmap and have instead opted for i2c_smbus_write_byte_data() in
restart handlers.

However extensive testing revealed that even using atomic safe function
is not enough and occasional resets fail with error message "Failed to
shutdown (err =  -11)". This is due to the fact that function
i2c_smbus_write_byte_data() in turn calls __i2c_lock_bus_helper()
which might fail with -EAGAIN when bus lock is already taken and cannot
be released anymore.

Thus replace i2c_smbus_write_byte_data() with unlocked flavor of
i2c_smbus_xfer() function to avoid above dead-lock scenario. At this
system stage we don't care about proper locking anymore and only want
proper machine reset to be carried out.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/watchdog/da9062_wdt.c | 15 ++++++++++++---
 drivers/watchdog/da9063_wdt.c | 15 ++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index f02cbd530538..1ec33b4bd2f2 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -155,11 +155,20 @@ static int da9062_wdt_restart(struct watchdog_device *wdd, unsigned long action,
 {
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
 	struct i2c_client *client = to_i2c_client(wdt->hw->dev);
+	union i2c_smbus_data msg;
 	int ret;
 
-	/* Don't use regmap because it is not atomic safe */
-	ret = i2c_smbus_write_byte_data(client, DA9062AA_CONTROL_F,
-					DA9062AA_SHUTDOWN_MASK);
+	/*
+	 * Don't use regmap because it is not atomic safe. Additionally, use
+	 * unlocked flavor of i2c_smbus_xfer to avoid scenario where i2c bus
+	 * might be previously locked by some process unable to release the
+	 * lock due to interrupts already being disabled at this late stage.
+	 */
+	msg.byte = DA9062AA_SHUTDOWN_MASK;
+	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_WRITE, DA9062AA_CONTROL_F,
+			I2C_SMBUS_BYTE_DATA, &msg);
+
 	if (ret < 0)
 		dev_alert(wdt->hw->dev, "Failed to shutdown (err = %d)\n",
 			  ret);
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 09a4af4c58fc..684667469b10 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -174,11 +174,20 @@ static int da9063_wdt_restart(struct watchdog_device *wdd, unsigned long action,
 {
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	struct i2c_client *client = to_i2c_client(da9063->dev);
+	union i2c_smbus_data msg;
 	int ret;
 
-	/* Don't use regmap because it is not atomic safe */
-	ret = i2c_smbus_write_byte_data(client, DA9063_REG_CONTROL_F,
-					DA9063_SHUTDOWN);
+	/*
+	 * Don't use regmap because it is not atomic safe. Additionally, use
+	 * unlocked flavor of i2c_smbus_xfer to avoid scenario where i2c bus
+	 * might previously be locked by some process unable to release the
+	 * lock due to interrupts already being disabled at this late stage.
+	 */
+	msg.byte = DA9063_SHUTDOWN;
+	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_WRITE, DA9063_REG_CONTROL_F,
+			I2C_SMBUS_BYTE_DATA, &msg);
+
 	if (ret < 0)
 		dev_alert(da9063->dev, "Failed to shutdown (err = %d)\n",
 			  ret);
-- 
2.25.1

