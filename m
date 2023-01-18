Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925C8672468
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjARRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjARRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:05:19 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4063A46D68;
        Wed, 18 Jan 2023 09:05:15 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E3DC04380B;
        Wed, 18 Jan 2023 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674061513;
        bh=8C8DkVQ2gQHEAlCG1z28SbrUvr9harQd3HM2fc4Ri0U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tp8C1A9YqPwvyGlIkzPyTp6A17m/TQBE6HaR7TQMNpFzJp7gOiSyLsrnhOY+YqqJ1
         +wf6DkU43RtGg2cD/ksyixp0cL0JwVE76rPFzMCdPYHQxkSyE/meNGuDJXr7rj6lDC
         6PcJ/6G3i1wLoX2nbMEgYqgHngOvtW9/AJYTOghwZfc1DjPsw/rEd//WH++2Dcai0+
         hB0CT5IqLhoOpLLLk9VnqMH7/OK9xSBI86d7gllXjQdiwll48he3fD2cR8jey0lXSz
         EUMLzEe7inzqd4APT7mduN78Ss6o7zd/xVZzAmmqbbcoPlVzSpVMuhZOY0NNjN16Jz
         pVEE55LLJxhuQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: cm32181: Fix PM support on system with 2 I2C resources
Date:   Thu, 19 Jan 2023 01:04:22 +0800
Message-Id: <20230118170422.339619-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
with 2 I2C resources") creates a second client for the actual I2C
address, but the "struct device" passed to PM ops is the first I2C
client that can't talk to the sensor.

That means the I2C transfers in both suspend and resume routines can
fail and blocking the whole suspend process.

Instead of using the first client for I2C transfer, use the I2C client
stored in the cm32181 private struct so the PM ops can get the correct
I2C client to really talk to the sensor device.

Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
BugLink: https://bugs.launchpad.net/bugs/1988346
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
Tested-by: Wahaj <wahajaved@protonmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Removed setting drvdata to the dummy client.
 - Added bug links.
 - Wording.

 drivers/iio/light/cm32181.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 001055d097509..b1674a5bfa368 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, indio_dev);
+
 	/*
 	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
 	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
@@ -460,8 +462,6 @@ static int cm32181_probe(struct i2c_client *client)
 			return PTR_ERR(client);
 	}
 
-	i2c_set_clientdata(client, indio_dev);
-
 	cm32181 = iio_priv(indio_dev);
 	cm32181->client = client;
 	cm32181->dev = dev;
@@ -490,7 +490,8 @@ static int cm32181_probe(struct i2c_client *client)
 
 static int cm32181_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
+	struct i2c_client *client = cm32181->client;
 
 	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
 					 CM32181_CMD_ALS_DISABLE);
@@ -498,8 +499,8 @@ static int cm32181_suspend(struct device *dev)
 
 static int cm32181_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
+	struct i2c_client *client = cm32181->client;
 
 	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
 					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
-- 
2.34.1

