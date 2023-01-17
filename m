Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6C66E31B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjAQQKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjAQQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:10:07 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F05D86A1;
        Tue, 17 Jan 2023 08:10:06 -0800 (PST)
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (1-171-185-203.dynamic-ip.hinet.net [1.171.185.203])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 303CA43818;
        Tue, 17 Jan 2023 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673971804;
        bh=ccFUstwQc0Hww0K4JjiSXVFRIzjCID1ql9cu6Hc1KDQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=FoeGgXVe30mb89rBFt/PZ5eUWf2EQEt2nNfAXqg10nKXu9g2Ah6L8YsTTHt4/jdQL
         5cQI9Ua24aWDXhLy5xR0k6kXr04NpkBdaqv1g7p+oFCYoZCiJeTLqHgN0GlX8d4CVe
         rjatwyI9YMqZOt3z4lJxIxbEaP+YaTemjLxL96tJDy2LR/21EOfwrEGvRKQhHktLIR
         Y+Z+aSwegcYyWDBBzqcu4+D1PPZlr3WlJ709+Zdv+r7Y7QlOV5H3/0kiv5GwOMTOCs
         lpgm6H9l9V41GBGFfBHu91O0oEGJpG0RWuzVylojGlJOlvXcwVOcfMM//FPSQzT8/z
         4jKW232iKglvw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C resources
Date:   Wed, 18 Jan 2023 00:09:51 +0800
Message-Id: <20230117160951.282581-1-kai.heng.feng@canonical.com>
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
address, but the "struct device" passed to PM ops is the first client
that can't talk to the sensor.

That means the I2C transfers in both suspend and resume routines can
fail and blocking the whole suspend process.

Instead of using the first client for I2C transfer, store the cm32181
private struct on both cases so the PM ops can get the correct I2C
client to perfrom suspend and resume.

Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
Tested-by: Wahaj <wahajaved@protonmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iio/light/cm32181.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 001055d097509..0f319c891353c 100644
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
@@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
 		client = i2c_acpi_new_device(dev, 1, &board_info);
 		if (IS_ERR(client))
 			return PTR_ERR(client);
-	}
 
-	i2c_set_clientdata(client, indio_dev);
+		i2c_set_clientdata(client, indio_dev);
+	}
 
 	cm32181 = iio_priv(indio_dev);
 	cm32181->client = client;
@@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
 
 static int cm32181_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
+	struct i2c_client *client = cm32181->client;
 
 	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
 					 CM32181_CMD_ALS_DISABLE);
@@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
 
 static int cm32181_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
+	struct i2c_client *client = cm32181->client;
 
 	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
 					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
-- 
2.34.1

