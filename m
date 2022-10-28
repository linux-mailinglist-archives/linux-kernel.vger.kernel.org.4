Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7602D610B92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJ1HuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ1HuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:50:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DB558CD;
        Fri, 28 Oct 2022 00:50:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p8so6935727lfu.11;
        Fri, 28 Oct 2022 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzApucCH/+hZ0NSjSIByv4uO01lC/jRamcHK2nza1G4=;
        b=abGOI7RHWXO9MxRjGi1+vyUVAN3PF5JRkoV0aluuCTgUkPW4DD9fDuJFYdsknuT5Sq
         1TjjHNEUO+EmXIlslhCcDq9mANft/gP1r+eHAeWM12eWjLKP1ZXRxWYMW2cOC5UYiDCy
         HXaJoKWsUzDhdHHSOtmLlgbj2bXxHfkaofkrtJDCzWGJu9pJAAIMcjh9AUmb0zJWHs7V
         9NaCD4WSSqedgpxk/VtMHV3OEINwrfhm5vTczApMDVzpqkdYlofnVfqSOfzPHRvf+XN4
         iiDAbEaokOXvMOEnLymgVu5N05A25sOLeKL9L7jDQynQ/NExEE4n1/zlL+9cJKj8k6e0
         ROCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzApucCH/+hZ0NSjSIByv4uO01lC/jRamcHK2nza1G4=;
        b=0zZ0t1Kpn4nCrDpPE7R3u/nMCyh72lEBMnm/RjIqvQoLFcWRH0p8fXpcRkKo0vMlQ4
         aRx0Tmo7tjYFemspAXYXfqABVFVguXXPzxC0NE7yR6Aab4SOt280zTohFmQN9Yi1v5Zr
         cts78KJ7Q5IX7C4yxERVa0QIpJoXz23udNutAeNEQwraOVc9xiiaFWW5Twqa5EquBD6I
         TwjGiq0PNQ3lgyw5PB81OsX8YPnu7dLThTbbm+Iym/QxwaaEsksNqBvI0GseeMb8ps/N
         VrEfO6vCpkRT6gOxNsUUApX57cCjNpTJ2+o8fQRz4ZQMKXcp/fCH3tXqdWgHunwJYfYp
         4Z6g==
X-Gm-Message-State: ACrzQf0cBH7mJME3JmTxwtHKKdmSh0mFBxIp4hVI7Kx99vsHKMXVu0Ul
        E/BEgFX/l2y3LbH0kacaphY=
X-Google-Smtp-Source: AMsMyM4541cTqT94evjudMNB20g+LXL/OK53ZeqSdt+A2bTJoIKgrIE9PLmZojJBM6GYNs4Tf/4W5g==
X-Received: by 2002:a05:6512:3502:b0:496:8e:9307 with SMTP id h2-20020a056512350200b00496008e9307mr18721208lfs.504.1666943402586;
        Fri, 28 Oct 2022 00:50:02 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id bk9-20020a05651c238900b0026befa96249sm539476ljb.8.2022.10.28.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:50:01 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] watchdog: rn5t618: add support for read out bootstatus
Date:   Fri, 28 Oct 2022 09:50:19 +0200
Message-Id: <20221028075019.2757812-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC does store the power-off factor internally.
Read it out and report it as bootstatus.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/rn5t618_wdt.c | 12 ++++++++++++
 include/linux/mfd/rn5t618.h    |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index 6e524c8e26a8..40d8ebd8c0ac 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -144,6 +144,8 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
 	struct rn5t618 *rn5t618 = dev_get_drvdata(dev->parent);
 	struct rn5t618_wdt *wdt;
 	int min_timeout, max_timeout;
+	int ret;
+	unsigned int val;
 
 	wdt = devm_kzalloc(dev, sizeof(struct rn5t618_wdt), GFP_KERNEL);
 	if (!wdt)
@@ -160,6 +162,16 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
 	wdt->wdt_dev.timeout = max_timeout;
 	wdt->wdt_dev.parent = dev;
 
+	/* Read out previous power-off factor */
+	ret = regmap_read(wdt->rn5t618->regmap, RN5T618_POFFHIS, &val);
+	if (ret)
+		return ret;
+
+	if (val & RN5T618_POFFHIS_VINDET)
+		wdt->wdt_dev.bootstatus = WDIOF_POWERUNDER;
+	else if (val & RN5T618_POFFHIS_WDG)
+		wdt->wdt_dev.bootstatus = WDIOF_CARDRESET;
+
 	watchdog_set_drvdata(&wdt->wdt_dev, wdt);
 	watchdog_init_timeout(&wdt->wdt_dev, timeout, dev);
 	watchdog_set_nowayout(&wdt->wdt_dev, nowayout);
diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
index 8aa0bda1af4f..aacb6d51e99c 100644
--- a/include/linux/mfd/rn5t618.h
+++ b/include/linux/mfd/rn5t618.h
@@ -227,6 +227,15 @@
 #define RN5T618_WATCHDOG_WDOGTIM_S	0
 #define RN5T618_PWRIRQ_IR_WDOG		BIT(6)
 
+#define RN5T618_POFFHIS_PWRON		BIT(0)
+#define RN5T618_POFFHIS_TSHUT		BIT(1)
+#define RN5T618_POFFHIS_VINDET		BIT(2)
+#define RN5T618_POFFHIS_IODET		BIT(3)
+#define RN5T618_POFFHIS_CPU		BIT(4)
+#define RN5T618_POFFHIS_WDG		BIT(5)
+#define RN5T618_POFFHIS_DCLIM		BIT(6)
+#define RN5T618_POFFHIS_N_OE		BIT(7)
+
 enum {
 	RN5T618_DCDC1,
 	RN5T618_DCDC2,
-- 
2.37.1

