Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23E6BD63B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCPQrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCPQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:47:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD2227A0;
        Thu, 16 Mar 2023 09:47:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so2128461wrh.6;
        Thu, 16 Mar 2023 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sL7v6vWIbKHGctooUHR0HwyGIzabAjFcG5L+GNX/WqE=;
        b=o1Imx2584lNwRwvD/3BzpcRNmMHJFUOWQPVGk9rgiuci7WNnqxW/qsUSIB59E7a8KS
         /0f1LWhkCG4NxTMR4FF5ZC4uzUl7ztWaIh7AsCbfdI8+to154kOxtLxkuJO91eWRtc/B
         8EC4XSDkPTwGzLY7/s2v3Mb5Iq040mQvTuup11ae4RemtKkGE7wDsIAoeCdaI5Sgz3UY
         QyZKkVGjIPP0gWxTjTPZIaGQnPK+euhFc96eR9ZInXwZlyzV8U/EgccXL6OvLuKjL9a6
         a51AwaMoQlRpMVVHwRCt4P0nKo0WUS0XIpBa4N8cCfzuCK/LpTVFHinfZWaRb2U3fss6
         66Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sL7v6vWIbKHGctooUHR0HwyGIzabAjFcG5L+GNX/WqE=;
        b=BaUTUUCxlw++6HISpBgBibvkW3oauWj3nx+YGNB0ehvfG/4cQsd/qE91qtgQEfPEiz
         H1ATGbRQwQuRlPrpnn+nmqS7eoU5gZZ8HLHGPlGK+yx/U70VMzTUH2waAcNEymjXWfK9
         A2ebFvsZygHJ3oOh4shQ6QSKlXXDPJ+ZglshCP7IBY/he5hYOyWCUgV4U6sUDmy67Jwb
         10qq5MrAhR87XHnYI3cRXIx1jd0R0C/3lW8B98HCxctSb88ZYqm53KFcN7Cewj8gBajU
         wsgXj2RX8BN1DA/qhqVhuYttpAcNrhRBsKASj6/fOL4ZidUrNiqQHYLCwTS5dRUY8Xxq
         2UHg==
X-Gm-Message-State: AO0yUKWl+EZ91LhOG1QsITphOyhuS+v4bBgYk1wSE5Sa7UAoObXdf4Ee
        DLQ41tgFSLxxHlkDAV1CDK4=
X-Google-Smtp-Source: AK7set/7pRkmYqkQ59KzvnaR/T7KBxU7LRrTZNImnqqh0kv8hXZ95qwJuwTdLcwObFxls5T3GK9lbw==
X-Received: by 2002:a5d:534e:0:b0:2cf:f04b:fb23 with SMTP id t14-20020a5d534e000000b002cff04bfb23mr5121220wrv.59.1678985229966;
        Thu, 16 Mar 2023 09:47:09 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b002cfeffb442bsm5754352wrv.57.2023.03.16.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:47:09 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     lee@kernel.org
Cc:     digetx@gmail.com, jonathanh@nvidia.com, treding@nvidia.com,
        richard.leitner@linux.dev, benjamin.bara@skidata.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: tps6586x: register restart handler
Date:   Thu, 16 Mar 2023 17:47:03 +0100
Message-Id: <20230316164703.1157813-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The TPS658629-Q1 (unfortunately the only TPS6586x with public data sheet)
provides a SOFT RST bit in the SUPPLYENE reg to request a (cold) reboot.

Use it to implement and register a restart handler/notifier.
The DS does not clarify if only writing the SOFT RST bit has side effects.
Therefore, regmap_update_bits() is used.

Set an appropriate system_state and disable the IRQs to activate
i2c_in_atomic_xfer_mode(). This avoids the following WARNING:
[   12.667612] WARNING: CPU: 1 PID: 1 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x33c/0x6b0
[   12.676926] Voluntary context switch within RCU read-side critical section!
...
[   12.742376]  schedule_timeout from wait_for_completion_timeout+0x90/0x114
[   12.749179]  wait_for_completion_timeout from tegra_i2c_wait_completion+0x40/0x70

Tested on a TPS658640.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/mfd/tps6586x.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 2d947f3f606a..e40c664b5f64 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqflags.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -22,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
 
@@ -29,6 +31,7 @@
 #include <linux/mfd/tps6586x.h>
 
 #define TPS6586X_SUPPLYENE	0x14
+#define SOFT_RST_BIT		BIT(0)
 #define EXITSLREQ_BIT		BIT(1)
 #define SLEEP_MODE_BIT		BIT(3)
 
@@ -466,6 +469,23 @@ static void tps6586x_power_off(void)
 	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
 }
 
+static int tps6586x_restart_notify(struct notifier_block *this, unsigned long mode, void *data)
+{
+	/* bring pmic into HARD REBOOT state, disable IRQs for atomic i2c RCU */
+	system_state = SYSTEM_RESTART;
+	local_irq_disable();
+	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SOFT_RST_BIT);
+	local_irq_enable();
+
+	mdelay(500);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block tps6586x_restart_handler = {
+	.notifier_call = tps6586x_restart_notify,
+	.priority = 200,
+};
+
 static void tps6586x_print_version(struct i2c_client *client, int version)
 {
 	const char *name;
@@ -559,9 +579,16 @@ static int tps6586x_i2c_probe(struct i2c_client *client)
 		goto err_add_devs;
 	}
 
-	if (pdata->pm_off && !pm_power_off) {
+	if (pdata->pm_off) {
 		tps6586x_dev = &client->dev;
-		pm_power_off = tps6586x_power_off;
+		if (!pm_power_off)
+			pm_power_off = tps6586x_power_off;
+
+		ret = register_restart_handler(&tps6586x_restart_handler);
+		if (ret) {
+			dev_err(&client->dev, "register restart handler failed: %d\n", ret);
+			goto err_add_devs;
+		}
 	}
 
 	return 0;
@@ -582,6 +609,13 @@ static void tps6586x_i2c_remove(struct i2c_client *client)
 	mfd_remove_devices(tps6586x->dev);
 	if (client->irq)
 		free_irq(client->irq, tps6586x);
+
+	if (tps6586x_dev == &client->dev) {
+		tps6586x_dev = NULL;
+		unregister_restart_handler(&tps6586x_restart_handler);
+		if (pm_power_off == tps6586x_power_off)
+			pm_power_off = NULL;
+	}
 }
 
 static int __maybe_unused tps6586x_i2c_suspend(struct device *dev)
-- 
2.34.1

