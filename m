Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6C68E8DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjBHHWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBHHWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:22:33 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE620CDDE;
        Tue,  7 Feb 2023 23:22:31 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 435493FD97;
        Wed,  8 Feb 2023 07:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675840949;
        bh=Mavv5hLg9uxOVvBkQuQSXrZ8rXvqW5vmj4h9iT5B1Rw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ygy8MBwuMZe59ty5RLOVYAdUmy6DZ4dzwkFqJwTxI93lqEiE6YAvp9oEE99fplhwl
         jmnW/QJRAO2Es41Y8QGpGNPxZ8J9wd0T1ihgh9iORijDvZwofLD6yNkOVTVE+fwZxk
         KlDTOPkgoBrs/6q/RDHE6W1/7MHYkx8QlvJGEFFGVSENpTtPNAlrT4k7sXZrXdk9fY
         nY0ONXd7lMbbT9poLJUHiNXeP+n12GtNZcapLQi6o1ydWjECv1Gud77CgIJPAUsczG
         IZMqrii5XWunOqUJzQCnS8NI84pcSXVLmco+h/Q6y1YisBmmC1bCBmXx1sA3A2tIfS
         aTKH7oMrXzMiw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: cm32181: Unregister second I2C client if present
Date:   Wed,  8 Feb 2023 15:21:41 +0800
Message-Id: <20230208072141.1103738-1-kai.heng.feng@canonical.com>
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

If a second client that talks to the actual I2C address was created in
probe(), there should be a corresponding cleanup in remove() to avoid
leakage.

So if the "client" is not the same one used by I2C core, unregister it
accordingly.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use devm_add_action_or_reset() instead of remove() callback to avoid
   race.

 drivers/iio/light/cm32181.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b1674a5bfa368..a3e5f56101c9f 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -429,6 +429,16 @@ static const struct iio_info cm32181_info = {
 	.attrs			= &cm32181_attribute_group,
 };
 
+static void cm32181_disable(void *data)
+{
+	struct i2c_client *client = data;
+	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
+
+	/* Unregister the dummy client */
+	if (cm32181->client != client)
+		i2c_unregister_device(cm32181->client);
+}
+
 static int cm32181_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -479,6 +489,12 @@ static int cm32181_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, cm32181_disable, client);
+	if (ret) {
+		dev_err(dev, "%s: add devres action failed\n", __func__);
+		return ret;
+	}
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		dev_err(dev, "%s: regist device failed\n", __func__);
-- 
2.34.1

