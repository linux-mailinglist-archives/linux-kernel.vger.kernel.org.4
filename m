Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026656B47D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjCJOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjCJOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:53:54 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948EE122081;
        Fri, 10 Mar 2023 06:49:51 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id p13-20020a9d744d000000b0069438f0db7eso3049204otk.3;
        Fri, 10 Mar 2023 06:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfV4gzY5rpfc2Qz712+xTRFHlXVjQWbTAaAw3EJTm64=;
        b=TOXeGNoKmzjuuqQ4smMMKF959vE3Lvgda0puKIEzIsWLuTOANYkBzDC0/XHWCu8C+M
         sYBLVausqMwQfmMc/uxSFs58uZWe6ETn8WPES1OtiaTGAWaubM4aKiOHnW6acz7nqj9p
         aF8XA3wzDhcj9Kt3vNssmCA27CB1sS4qOR0ObeT1rtie59V3YWsh6MpdlkRHVINfVgk5
         U3aMIDaWfJbHl0iNpbCMMxcvxHq7BdU7Dvngl2HEjF/9XuUqJ7P3iATcj+zUwIl9ug8f
         DuQgaIjQelplUIhfO60a3AL5aS2bZdvWp+x/LkBZkuKWsQdOaQqvS0hketCa32BN5slP
         VB5g==
X-Gm-Message-State: AO0yUKUGGtW7dtnRO8zxHh0AjbTTVHn8dDzAW2sQnKX0MATFYVIEJiDR
        p632ouLRWNhb986mlpuzfhILl5XRZg==
X-Google-Smtp-Source: AK7set+x1B5Ls5AJq8TsT2aj5gKg1Sv320WboPRzNDRlga1lRoBcbV+IU7yIU/44hsQcqEswENhiew==
X-Received: by 2002:a05:6830:44a5:b0:68b:c2b5:b91d with SMTP id r37-20020a05683044a500b0068bc2b5b91dmr12606007otv.34.1678459720705;
        Fri, 10 Mar 2023 06:48:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a9d730c000000b0068bb7bd2668sm97988otk.73.2023.03.10.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:40 -0800 (PST)
Received: (nullmailer pid 1544800 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:21 -0600
Message-Id: <20230310144721.1544756-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/bd71815-regulator.c | 8 ++++----
 drivers/regulator/fixed.c             | 2 +-
 drivers/regulator/gpio-regulator.c    | 2 +-
 drivers/regulator/pwm-regulator.c     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index 8b55046eded8..f4eaea732de7 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -201,10 +201,10 @@ static int buck12_set_hw_dvs_levels(struct device_node *np,
 
 	data = container_of(desc, struct bd71815_regulator, desc);
 
-	if (of_find_property(np, "rohm,dvs-run-voltage", NULL) ||
-	    of_find_property(np, "rohm,dvs-suspend-voltage", NULL) ||
-	    of_find_property(np, "rohm,dvs-lpsr-voltage", NULL) ||
-	    of_find_property(np, "rohm,dvs-snvs-voltage", NULL)) {
+	if (of_property_present(np, "rohm,dvs-run-voltage") ||
+	    of_property_present(np, "rohm,dvs-suspend-voltage") ||
+	    of_property_present(np, "rohm,dvs-lpsr-voltage") ||
+	    of_property_present(np, "rohm,dvs-snvs-voltage")) {
 		ret = regmap_read(cfg->regmap, desc->vsel_reg, &val);
 		if (ret)
 			return ret;
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 2a9867abba20..7c3add05be15 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -151,7 +151,7 @@ of_get_fixed_voltage_config(struct device *dev,
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 	of_property_read_u32(np, "off-on-delay-us", &config->off_on_delay);
 
-	if (of_find_property(np, "vin-supply", NULL))
+	if (of_property_present(np, "vin-supply"))
 		config->input_supply = "vin";
 
 	return config;
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 95e61a2f43f5..7602d48609df 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -220,7 +220,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 				 regtype);
 	}
 
-	if (of_find_property(np, "vin-supply", NULL))
+	if (of_property_present(np, "vin-supply"))
 		config->input_supply = "vin";
 
 	return config;
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index b9eeaff1c661..214ea866742d 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -334,7 +334,7 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 
 	memcpy(&drvdata->desc, &pwm_regulator_desc, sizeof(drvdata->desc));
 
-	if (of_find_property(np, "voltage-table", NULL))
+	if (of_property_present(np, "voltage-table"))
 		ret = pwm_regulator_init_table(pdev, drvdata);
 	else
 		ret = pwm_regulator_init_continuous(pdev, drvdata);
-- 
2.39.2

