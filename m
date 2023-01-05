Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76165E644
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjAEHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:51:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0A3E0F7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 23:51:13 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 18so12561106pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 23:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ohiE9fg/YmJyloLDZ4x/cahWGOvJ6DD66/fJFJqCKg=;
        b=CAb0Q6uGKu6IOMmryDbj7OUjJ6wQNikYrhBGFjKs+IdgdnsCQgB1jYji6e4FvB2hib
         BNqYy378sq00EZVxgL5CRhCv4olroZFbklBCnhvjg0bCNgYJ4bBHBigroP2m1/F1/c49
         xtAC26swM8uc6DYHspV7zK9xDZwF3vv6Ax3NIZkarnrXOzRop2i4bTqgVnzJMCYEqLcW
         rvPhQRSUZBwwNQHOj1NpXukENXI/V3RBexDf8UQyu8n/F0lhdD1PBoxWeT12S3y+cb8g
         lHV088pT4w5X6oltYqZ6l6SzXN1F24a6tFNZ5xlUv13YAunfvQPalSSEVgPLWWYk/LlJ
         d24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ohiE9fg/YmJyloLDZ4x/cahWGOvJ6DD66/fJFJqCKg=;
        b=OwE5pjMrQq/Kiv72odE3JRL43xBu68mxNmT6TAf4SH3Dml45E/VnPP6LBPlESq0KQ8
         hyGlzzvUGTFKFQYuE8AigOi2YaH3C0Dv2/GQgorNjKScjIVfNT1XFI9f7aP1Z0OBpFsP
         3jdMpZg/rGZxjo39NjgU8xA2ZkbpCUywDhLqwwGiT2DiipKNwYhl3QYfvrBTAd/mpmUS
         QNQXN6AU0vKwvps21PJ4rtMFKXAEJWB/gG2F5SgMKhNNvQYgQvEb08lP5NygX3Yxm43b
         62IisUnXE4grHr87j3HuO+hQBLkSZdT2uldOqMrEdPR70K//hUWvrMWPg/y+6bj/YwIb
         tWnQ==
X-Gm-Message-State: AFqh2krK//T70KgqInsl2E+hS2WjDWID3OTPh3y3wZUqZZcirI/PtxU9
        TNm0Q+In6K13Eim1/ETEy+w93A==
X-Google-Smtp-Source: AMrXdXszN76bSIXwIGY/Qa3ikTZynfml5rZXe+3P+nK+pNyrNCvLuvtCV0bcoaDPCfNrEGQOv4IU5w==
X-Received: by 2002:a62:e911:0:b0:581:579d:5c44 with SMTP id j17-20020a62e911000000b00581579d5c44mr31980759pfh.5.1672905073357;
        Wed, 04 Jan 2023 23:51:13 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g130-20020a625288000000b0056c2e497b02sm24513555pfb.173.2023.01.04.23.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 23:51:12 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Cc:     sven@svenpeter.dev, shawn.guo@linaro.org,
        bryan.odonoghue@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 2/2] usb: typec: tipd: Support wakeup
Date:   Thu,  5 Jan 2023 15:50:58 +0800
Message-Id: <20230105075058.924680-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105075058.924680-1-jun.nie@linaro.org>
References: <20230105075058.924680-1-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable wakeup when pluging or unpluging USB cable. It is up to other
components to hold system in active mode, such as display, so that
user can receive the notification.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/usb/typec/tipd/core.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 46a4d8b128f0..485b90c13078 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -95,6 +95,7 @@ struct tps6598x {
 	struct power_supply_desc psy_desc;
 	enum power_supply_usb_type usb_type;
 
+	int wakeup;
 	u16 pwr_status;
 };
 
@@ -846,6 +847,12 @@ static int tps6598x_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, tps);
 	fwnode_handle_put(fwnode);
 
+	tps->wakeup = device_property_read_bool(tps->dev, "wakeup-source");
+	if (tps->wakeup) {
+		device_init_wakeup(&client->dev, true);
+		enable_irq_wake(client->irq);
+	}
+
 	return 0;
 
 err_disconnect:
@@ -870,6 +877,36 @@ static void tps6598x_remove(struct i2c_client *client)
 	usb_role_switch_put(tps->role_sw);
 }
 
+static int __maybe_unused tps6598x_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tps6598x *tps = i2c_get_clientdata(client);
+
+	if (tps->wakeup) {
+		disable_irq(client->irq);
+		enable_irq_wake(client->irq);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tps6598x_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tps6598x *tps = i2c_get_clientdata(client);
+
+	if (tps->wakeup) {
+		disable_irq_wake(client->irq);
+		enable_irq(client->irq);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops tps6598x_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
+};
+
 static const struct of_device_id tps6598x_of_match[] = {
 	{ .compatible = "ti,tps6598x", },
 	{ .compatible = "apple,cd321x", },
@@ -886,6 +923,7 @@ MODULE_DEVICE_TABLE(i2c, tps6598x_id);
 static struct i2c_driver tps6598x_i2c_driver = {
 	.driver = {
 		.name = "tps6598x",
+		.pm = &tps6598x_pm_ops,
 		.of_match_table = tps6598x_of_match,
 	},
 	.probe_new = tps6598x_probe,
-- 
2.34.1

