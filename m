Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA776A3523
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBZW4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjBZWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5931A4BC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so2797038wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP9BUpkAAnItZXgZisVn1kO1oz9qmtA+bV8jqWpOtJM=;
        b=xNF00HDit8Cyi0Oy7Ym4GIPyk2UGsV3BL68mxgXoc22L7UD8alc5G6Ga556KC7e1XR
         R2B16kLw4VKmDDtmePz91xiBdYvL11ag+ZZuL5MtrYAKENpv9Dg/oFKh+Rke2nO6aUAE
         OVL2qNQa5GCxSHHxR6HoQiHCPJsrkIBW7QX98P51B+UpYkC3nOqI5pe9lkbpNtq1FA8/
         St07IP5TR7zECP7DRXto6y2rhvcwMuScPZjhXPJl4XDCRc9g/XjR060oVex8dxnu9Gi3
         03rrGV9ZCbF1iImOCrl81nKrjm8xCMcqPzKEZ6/KHLob9r3o/1gk8SwJGQTcZ777zACv
         z2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP9BUpkAAnItZXgZisVn1kO1oz9qmtA+bV8jqWpOtJM=;
        b=VHhjKcBW6mo4jcH01T4HJDvkGl8yBvnfU2wcbq2aYAAq8EgTxjxU8A8UjNbP+YmAgY
         MubEATAz9LQFV24yt33f1oY48jAoC6z0ivrMf3yV8orA3negcswyOQbYqEoc+XY7PqLh
         rasNOK56jsQbenLPsZEp47OqvCBTGfhungzcz/jqnU3wqfNokp/Ij33j8np2BB17BHBc
         2xcAXR4FrscXQWhk2NzuJXb87y95rm4N9yjG8plddjB5WSAJYDHXid4UvHCsSbaPWqUn
         31858nGtxi8kG+xgC2c1p9Mq+fwcTaQTzEuTMy3TIBwSNkMJ2G2ZTni/3cvM4MhEP0Bp
         sfcg==
X-Gm-Message-State: AO0yUKUhQ73rOceN9XrPgXG6GoF7nwdtosAefhippXMHnJ5UEBRMPUII
        m0MM0GWaCORc6jm+H+EJWW8q5Q==
X-Google-Smtp-Source: AK7set/wU0hkiS2EFGpo+/bN0ssaDFfJf9jZphCp98HNiEk1yxLRMYbuP2NDwROuT0mdGZsWp39Mww==
X-Received: by 2002:a05:600c:3416:b0:3eb:3cc9:9f85 with SMTP id y22-20020a05600c341600b003eb3cc99f85mr2580319wmp.26.1677452122423;
        Sun, 26 Feb 2023 14:55:22 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v3 18/20] thermal/drivers/acerhdf: Make interval setting only at module load time
Date:   Sun, 26 Feb 2023 23:54:04 +0100
Message-Id: <20230226225406.979703-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

