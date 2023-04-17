Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDEF6E549A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDQWQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDQWQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:16:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD15279
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:16:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b73203e0aso4190745b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681769776; x=1684361776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HX6x50X1I0Zl7KqrE4lTGH4kDeVIRVgagffI4hk1W4w=;
        b=BAQM/Qj6aW6qQVkNxEdFfvp4L2v43/c1sWfOR0aw0h4Q4QXr91VuuUfUq4AAd0INWD
         YwUAjIo/zgar/4MiknTnJOhzPmBP5cT+Eq6J5LrcP/OVrQBjHwp8yuW4S91pa7GLFw/S
         ao8TZKF4rpXW4x3pxnaWwY/z/1I9ZK3fC7dSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681769776; x=1684361776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX6x50X1I0Zl7KqrE4lTGH4kDeVIRVgagffI4hk1W4w=;
        b=TOG1ZPiPSJU7HmAEv7wYecfj3iVmzAjwEkj/6NqMWluQ8v/WMTJpcAqtfUrZ+KSFFn
         pncmhFu74PAqM+oJtH6kTBf7YSa1WusYJDx+xteKODpnAQX1GuokMMCNGxV9dy4Z1rLw
         AEKi+czvmlxEuKSVqWtqJfKgCrs8xQbAaw+5TdpEvIpntRioHEDvBCV5gDUMz0ljD+dz
         gcEJC5+OZu2ulaWeVJOZ+6jJrX5NwRS8suy307FtC5NDO15qfZ/H99ydVitusy9Lwmwj
         2xOO4rqb77ceZzLo6FLQWr9cqLnx7MBSmharWXH+55XBvmrTQVf952f+0XNkFFHR+evx
         fQVw==
X-Gm-Message-State: AAQBX9dDFi7E4Tx4nHFgGO/gQdRFZ/gxPV2wneIOHN98jcSgxyvpuX99
        HOnPhf7bB7sKnFk6SL1Lvuqi15BoVNZ1oVjE6p8=
X-Google-Smtp-Source: AKy350bt8N4R7lILLMHSaYdSwchsR8TA9GZ20EO9f7pWWrbydsPpvy5sU2/JHpVNhYZRSgP0t7F50Q==
X-Received: by 2002:a17:902:c405:b0:1a6:3630:16e1 with SMTP id k5-20020a170902c40500b001a6363016e1mr50164plk.13.1681769776269;
        Mon, 17 Apr 2023 15:16:16 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:8021:f588:5cf5:d9b4])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902b60f00b001a27f810a2esm8139061pls.256.2023.04.17.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:16:15 -0700 (PDT)
From:   Daisuke Nojiri <dnojiri@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daisuke Nojiri <dnojiri@chromium.org>
Subject: [PATCH] cros_pchg: Sync port status on resume
Date:   Mon, 17 Apr 2023 15:16:10 -0700
Message-ID: <20230417221610.1507341-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a stylus is removed (or attached) during suspend, the device detach
(or attach) events can be lost. This patch makes the peripheral device
charge driver retrieve the latest status from the EC on resume.

BUG=b:276414488
TEST=Redrix

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 .../power/supply/cros_peripheral_charger.c    | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 1379afd9698d..a204f2355be4 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -227,8 +227,7 @@ static int cros_pchg_get_prop(struct power_supply *psy,
 	return 0;
 }
 
-static int cros_pchg_event(const struct charger_data *charger,
-			   unsigned long host_event)
+static int cros_pchg_event(const struct charger_data *charger)
 {
 	int i;
 
@@ -256,7 +255,7 @@ static int cros_ec_notify(struct notifier_block *nb,
 	if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
 		return NOTIFY_DONE;
 
-	return cros_pchg_event(charger, host_event);
+	return cros_pchg_event(charger);
 }
 
 static int cros_pchg_probe(struct platform_device *pdev)
@@ -281,6 +280,8 @@ static int cros_pchg_probe(struct platform_device *pdev)
 	charger->ec_dev = ec_dev;
 	charger->ec_device = ec_device;
 
+	platform_set_drvdata(pdev, charger);
+
 	ret = cros_pchg_port_count(charger);
 	if (ret <= 0) {
 		/*
@@ -349,9 +350,27 @@ static int cros_pchg_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused cros_pchg_resume(struct device *dev)
+{
+	struct charger_data *charger = dev_get_drvdata(dev);
+
+	/*
+	 * Sync all ports on resume in case reports from EC are lost during
+	 * the last suspend.
+	 */
+	cros_pchg_event(charger);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cros_pchg_pm_ops, NULL, cros_pchg_resume);
+
 static struct platform_driver cros_pchg_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.pm = &cros_pchg_pm_ops,
 	},
 	.probe = cros_pchg_probe
 };
-- 
2.39.2

