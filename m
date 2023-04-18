Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00886E6AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjDRR0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjDRR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:26:35 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C977EEB;
        Tue, 18 Apr 2023 10:26:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id fw30so22381485ejc.5;
        Tue, 18 Apr 2023 10:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838784; x=1684430784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPz8WtlEI8gh8A55a2S3L9Sb0zmAsdXhk6qjgbvuP5Y=;
        b=SP5fFnIhkkvYn/axMr7o5RQnM1jNAkVoCoN3mZsjTqlaXS7RWMEE3HsURMO7m8O9w+
         3nm7imf7vs9zBecUeuyOc7I2SmCgeeUleW+q42aqpvQlp7sbvzl6GedOM7i0he0MEsk4
         6REE0fBnSvpxkrTt70KRmzCito70Zk2coWG3GsC5REQvyC9hKdkuaUwzLr4ixcGbiBp6
         X+R2GvmakOyNypsEqRhyQXym/JmKbneoHbY5vWQ0TAH8KTubH/kjN5eqaaU2VncWMooZ
         32/R3kNwDoCnOVXDeXcmhaS7cIm8Yso60qrpPHK4ziTxHwv21YO0ZWUnbHaCMh1NtjYS
         y0KQ==
X-Gm-Message-State: AAQBX9f+/bw23Z4snnQ+QWDFVwNj8vaI/RMr9xcBzD2KUAva87GHS6Y5
        n0aSz6pwZoMmlJw3BcQow+8=
X-Google-Smtp-Source: AKy350bFkPXuAwDajfP7rLGjTLmIMdsV8tnyaVX3qcv/el+Ok+Ie/aBWLrFQKZ7v0HbM5FTpcIqhLQ==
X-Received: by 2002:a17:906:d14b:b0:93f:9b4a:12f3 with SMTP id br11-20020a170906d14b00b0093f9b4a12f3mr11979429ejb.10.1681838783990;
        Tue, 18 Apr 2023 10:26:23 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id j23-20020a1709066c1700b0095342bfb701sm63259ejr.16.2023.04.18.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:26:23 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/2] watchdog: menz069_wdt: fix watchdog initialisation
Date:   Tue, 18 Apr 2023 19:25:30 +0200
Message-Id: <20230418172531.177349-2-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418172531.177349-1-jth@kernel.org>
References: <20230418172531.177349-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a 'cat /dev/watchdog0' with menz069_wdt as watchdog0 will result in
a NULL pointer dereference.

This happens because we're passing the wrong pointer to
watchdog_register_device(). Fix this by getting rid of the static
watchdog_device structure and use the one embedded into the driver's
per-instance private data.

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/watchdog/menz69_wdt.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index 8973f98bc6a5..bca0938f3429 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -98,14 +98,6 @@ static const struct watchdog_ops men_z069_ops = {
 	.set_timeout = men_z069_wdt_set_timeout,
 };
 
-static struct watchdog_device men_z069_wdt = {
-	.info = &men_z069_info,
-	.ops = &men_z069_ops,
-	.timeout = MEN_Z069_DEFAULT_TIMEOUT,
-	.min_timeout = 1,
-	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ,
-};
-
 static int men_z069_probe(struct mcb_device *dev,
 			  const struct mcb_device_id *id)
 {
@@ -125,15 +117,19 @@ static int men_z069_probe(struct mcb_device *dev,
 		goto release_mem;
 
 	drv->mem = mem;
+	drv->wdt.info = &men_z069_info;
+	drv->wdt.ops = &men_z069_ops;
+	drv->wdt.timeout = MEN_Z069_DEFAULT_TIMEOUT;
+	drv->wdt.min_timeout = 1;
+	drv->wdt.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ;
 
-	drv->wdt = men_z069_wdt;
 	watchdog_init_timeout(&drv->wdt, 0, &dev->dev);
 	watchdog_set_nowayout(&drv->wdt, nowayout);
 	watchdog_set_drvdata(&drv->wdt, drv);
 	drv->wdt.parent = &dev->dev;
 	mcb_set_drvdata(dev, drv);
 
-	return watchdog_register_device(&men_z069_wdt);
+	return watchdog_register_device(&drv->wdt);
 
 release_mem:
 	mcb_release_mem(mem);
-- 
2.39.2

