Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB26A7516
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCAUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCAUQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D4515E7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so14524375wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+RTeMjiH2Yk42W57PYAK6Mb85gdhTfPcaFRy4giwH0=;
        b=oq9JmkyeN552QfxOHHg4bR675vpphKbJsVoET11pinW7JQA+jqNXdJAr4H1KeeIZLU
         quTT2XEFLZfpGXGmqt2GO3lv4+gc2zqQ+Ojc2d/tm27K8VJztJR335Qr8mw4MzS/E9Mz
         AJxjpbRQ0bAh0BqAwgG6cJqrC/+/3jeTdI2v4aL/EnfGrdR0xf/9Ro7D9XB3rCMkF5/m
         smlEDf+3lK2/eNKbRQDrxdiOY9HCMyhT32kugRCJAZ2370lxSv0oxFzXGWMtal4bHE+Z
         OWGL81xIsLH2AKPqAwerfg+8F5V55ajFRIivK0ssQ7qKldceNtaF/Bs0K+He2rMYwu1I
         DmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+RTeMjiH2Yk42W57PYAK6Mb85gdhTfPcaFRy4giwH0=;
        b=giZ5nk4HW71goFre8cnLJdU4xIcqJtQS18MpLuc8GjUDUkp4W4LdvkXcOShas2lXhd
         0umg2evydPHE5gyWskowk/B05YPLg/PEODzDgPy6gVWmSGmt7LrwU3Q9JAENissuFFvb
         ODJvbaVysgPmKHW9kE6lUhjTatji1pBGT5rDQZISgxaUtcVIaLAu9keI0e97zsbfV6f1
         701cdGsp5q32lllBa2/W9UO72J/z0oH9AKUSAjpSC+hb0ZiejeM0Jnb7fL+QnfmPpBRi
         fZH2V9I2F1Ld0I0gRf1DLHOAUYyHsJAAQ9wWtSxPgZFOqVf95cMvaMNCuHhPWENUocI1
         W1Fw==
X-Gm-Message-State: AO0yUKVhqbn9zj8qgOtl1gIQVaBMHyYEVZWyaZiDpceIr6G69tATSz+X
        J4e98hsI/pKGcHHgmZ3i07IX9g==
X-Google-Smtp-Source: AK7set/ta+emcyYFeYNSomT5+PEoW2hHSBBrGWkfa4OG0hChcsGtB27pUUXj1KAZ2oYslu7puUedzA==
X-Received: by 2002:adf:ed82:0:b0:2c7:a39:7453 with SMTP id c2-20020adfed82000000b002c70a397453mr5688650wro.54.1677701747255;
        Wed, 01 Mar 2023 12:15:47 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:46 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 14/18] thermal/drivers/da9062: Don't access the thermal zone device fields
Date:   Wed,  1 Mar 2023 21:14:42 +0100
Message-Id: <20230301201446.3713334-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is reading the passive polling rate in the thermal zone
structure. We want to prevent the drivers to rummage around in the
thermal zone structure.

On the other side, the delay is what the driver passed to the
thermal_zone_device_register() function, so it has already the
information.

Reuse the information we have instead of reading the information we
set.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
 drivers/thermal/da9062-thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index e7097f354750..2d31b1f73423 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -41,6 +41,8 @@
 
 #define DA9062_MILLI_CELSIUS(t)			((t) * 1000)
 
+static unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
+
 struct da9062_thermal_config {
 	const char *name;
 };
@@ -95,7 +97,10 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		thermal_zone_device_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
 
-		delay = thermal->zone->passive_delay_jiffies;
+		/*
+		 * pp_tmp is between 1s and 10s, so we can round the jiffies
+		 */
+		delay = round_jiffies(msecs_to_jiffies(pp_tmp));
 		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
@@ -155,7 +160,6 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 {
 	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
 	struct da9062_thermal *thermal;
-	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
 	const struct of_device_id *match;
 	int ret = 0;
 
@@ -208,8 +212,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev,
-		"TJUNC temperature polling period set at %d ms\n",
-		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
+		"TJUNC temperature polling period set at %d ms\n", pp_tmp);
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0)
-- 
2.34.1

