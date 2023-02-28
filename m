Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC06A5800
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjB1LZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjB1LYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:24:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0222E821
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:48 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e37so6856384wri.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP9BUpkAAnItZXgZisVn1kO1oz9qmtA+bV8jqWpOtJM=;
        b=SauDXJNkgfwQ1ggwYxd3HcJ5q2YHnt2xK5twAXslHbZRS9MM/k74NroFLzymffLQUg
         /8Qo+sDoEPUr1cSGopMkHV3jf8uF4DS6dqFujIxwlA8wzFqlH4j/oBWz2vvSMQ3I3H+1
         HBdWJlW1shUTK/+vTRiVKqlNYiL4iqNmuARgw3QYABI3N26BEUtlFSfTQoZTtckw3F+I
         HEe0axve0k3LS4JYeh9NfoN7qd9Ml3FjmJBG4gHNagPr33+DlbXBFWUf+9bPM4h46vaQ
         6O039a1e6OZLPfxDNhYDltwXd81IWKEHJCatF56nZixI8AIWl8WznaGgK4jZHB5F8UDh
         n3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP9BUpkAAnItZXgZisVn1kO1oz9qmtA+bV8jqWpOtJM=;
        b=aNR3QuNtxd5Yb+HO8NtiVsrNs2mvwUBNLuotemHBAK1WdnjZtflIXN1r1yjeXzKU6L
         3RTnQ9aPnX+Ov5HySjnYIVmmMBDmde0569msErStAwQpfq9Usl7AWI5tJ/eTfxnWnexj
         3bmXpKakFtNKiJzPevuNmLLst8zfVlf1BvjWCFF94vQo4OqPMQJyAQFDWjoL6WKjgfmS
         f8aI5kJjLf5SDH2BzvxWz18QIuntqbcUyLfSWBr/D82AGJC7uWsS+nbvJWL/9tDQK/i7
         f5OsIYZ0Iosgv6Kuj1NR51kIUR3CsARrn8+UsbB0+Cnt3lCOI0h8izebx/IxQaBoyHiS
         PUHg==
X-Gm-Message-State: AO0yUKVvZsMRGecVS2gt2q9b3N/EpfclODg5t0u8Tgk+k7LUQ1apQuqz
        ZfRRsMUXnXt/G8BxRq/FrIgGWw==
X-Google-Smtp-Source: AK7set9i/mwZgbAPgu+X/cynENy84FA1SS6MIzTypXhdCG9UMMwqugEI9Tp+wf0Io245/ZW25ZRlfg==
X-Received: by 2002:a5d:5651:0:b0:2cc:459b:8bc8 with SMTP id j17-20020a5d5651000000b002cc459b8bc8mr1651726wrw.6.1677583422037;
        Tue, 28 Feb 2023 03:23:42 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v4 18/19] thermal/drivers/acerhdf: Make interval setting only at module load time
Date:   Tue, 28 Feb 2023 12:22:37 +0100
Message-Id: <20230228112238.2312273-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
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

The thermal zone device structure is in the process of being private
to the thermal framework core code. This driver is directly accessing
and changing the monitoring polling rate.

After discussing with the maintainers of this driver, having the
polling interval at module loading time is enough for their purpose.

Change the code to take into account the interval when the module is
loaded but restrict the permissions so the value can not be changed
afterwards.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Peter Kaestle <peter@piie.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/acerhdf.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 1956469c3457..61f1c3090867 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -79,7 +79,6 @@ static unsigned int list_supported;
 static unsigned int fanstate = ACERHDF_FAN_AUTO;
 static char force_bios[16];
 static char force_product[16];
-static unsigned int prev_interval;
 static struct thermal_zone_device *thz_dev;
 static struct thermal_cooling_device *cl_dev;
 static struct platform_device *acerhdf_dev;
@@ -346,20 +345,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 	trips[0].temperature = fanon;
 	trips[0].hysteresis  = fanon - fanoff;
 
-	if (kernelmode && prev_interval != interval) {
+	if (kernelmode) {
 		if (interval > ACERHDF_MAX_INTERVAL) {
 			pr_err("interval too high, set to %d\n",
 			       ACERHDF_MAX_INTERVAL);
 			interval = ACERHDF_MAX_INTERVAL;
 		}
+
 		if (verbose)
 			pr_notice("interval changed to: %d\n", interval);
-
-		if (thermal)
-			thermal->polling_delay_jiffies =
-				round_jiffies(msecs_to_jiffies(interval * 1000));
-
-		prev_interval = interval;
 	}
 }
 
@@ -807,5 +801,5 @@ static const struct kernel_param_ops interval_ops = {
 	.get = param_get_uint,
 };
 
-module_param_cb(interval, &interval_ops, &interval, 0600);
+module_param_cb(interval, &interval_ops, &interval, 0000);
 MODULE_PARM_DESC(interval, "Polling interval of temperature check");
-- 
2.34.1

