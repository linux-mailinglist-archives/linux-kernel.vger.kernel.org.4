Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189269F8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBVQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBVQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:25:05 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EF3647C;
        Wed, 22 Feb 2023 08:25:02 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4425A3FA87;
        Wed, 22 Feb 2023 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677083101;
        bh=6PZoDVXhrOY89Anuzhd0k/e1jCsb5iCwDs2AL131Olw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Kpqz86SwHgCXxRYK2e7aTn45rpRE8l/VL/7Rgpsc3xqXvBcgruRCQ/O02OLyUtsn2
         dAd9sIDbubB2oS4Ff5/f38lU5xq6hKvSglGwS5HGf6AN2cNQxt1Y+Is6gLZ15hLFRO
         pJ0Njha8NZ1KcOpS3/Ka1Ysdo7P4cZeh9kmG6uSODtHK2W+9iqW+6SA5YjvSbqs316
         y4sacGb2tWq42kJZ3SEeyIHMpCWPcyPq3M7JxcAmEOSyz465nMuHyY6VmxscBO5+/b
         vE3LYRZbFrC48LgXq1xZiCA6B4D3MPGmoLDGYtuW68ntN/Y8lrAIYp3PTMyyjxi9T+
         9QMBcvZC2BRSA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: light: cm32181: Unregister second I2C client if present
Date:   Thu, 23 Feb 2023 00:24:08 +0800
Message-Id: <20230222162408.1996023-1-kai.heng.feng@canonical.com>
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

If a second dummy client that talks to the actual I2C address was
created in probe(), there should be a proper cleanup on driver and
device removal to avoid leakage.

So unregister the dummy client via another callback.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Use devm_add_action_or_reset() in a correct place.
 - Wording.

v2:
 - Use devm_add_action_or_reset() instead of remove() callback to avoid
   race.

 drivers/iio/light/cm32181.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b1674a5bfa368..b3da7a517aaea 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -429,6 +429,14 @@ static const struct iio_info cm32181_info = {
 	.attrs			= &cm32181_attribute_group,
 };
 
+static void cm32181_unregister_dummy_client(void *data)
+{
+	struct i2c_client *client = data;
+
+	/* Unregister the dummy client */
+	i2c_unregister_device(client);
+}
+
 static int cm32181_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -460,6 +468,12 @@ static int cm32181_probe(struct i2c_client *client)
 		client = i2c_acpi_new_device(dev, 1, &board_info);
 		if (IS_ERR(client))
 			return PTR_ERR(client);
+
+		ret = devm_add_action_or_reset(dev, cm32181_unregister_dummy_client, client);
+		if (ret) {
+			dev_err(dev, "%s: add devres action failed\n", __func__);
+			return ret;
+		}
 	}
 
 	cm32181 = iio_priv(indio_dev);
-- 
2.34.1

