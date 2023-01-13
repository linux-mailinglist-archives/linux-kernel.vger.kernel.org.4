Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B704066A18E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjAMSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAMSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:07:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178487D1F8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:02:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d2so1671150wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFbwyqDZtHk6CbeUN6WBPuXKWmMZ6+Pcgb3pZmm041w=;
        b=wO348rhGKSaWdgDdo/1C2+RgiVjwndgu/g2iR6f0b9B8nO1y/H+X+Rut9yZztkgEIM
         E69EC/nGsDFucnQKGrT4XdlPTQE4C1m7hYBvSSebUFUDTjEE+CbtGf99ghWeNrEJDHXB
         JU2c9XdW1pA7V1L2zL3NA3Fpd58gydCjzPTtM79qPynlctGtF5rHZiVgpamuJ/o3NU+0
         D6TP3s/ADo4uXe3adA75P5RsiXwWJCx7/HxTldW8Vg1ZHr24dTSypunjbjnj18P1Kdo+
         Kg2pqkt5uTeGbmUkB8D935zakHiv7gM+7PGgrfiS4WoOqAj6ZVWT1Xs13NWdVplL/21w
         wgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFbwyqDZtHk6CbeUN6WBPuXKWmMZ6+Pcgb3pZmm041w=;
        b=69zJVvVxUkQHmk4uexKJKKU2pZwB0occmKSgWRDZ4Keiz7VfVCNT7ruu9Ln2m11/Fj
         nGXVQg1hOlmQ3O4jTOb1pBdW1BQpak8UTvsdTIu6dgVKgXQKowVL39YZ6qfQ2/nOJ8hp
         eN8HRD3XVRBswcPkCrI6/7Hsj6EN7L7nADEEyA7LSby384ml1uwp+9vC1UCEtLWE2xtJ
         IIcU+fxNxKN5om3xDrsuovFQUbw2kP1CDTnXUQT4+JiV43CaHHrM4JfhNri94mKVbhiw
         KY76o9jQ1eb4nVzVbMVyHELpK1rI07gdOyKKEJBBRsXA8xKjTRnyO6goeHi59MfhECpa
         I6eA==
X-Gm-Message-State: AFqh2krUbl8B8rqMeR4gbofa333jV8VnjkGXglBt4YXPgY3vJ9PGv/30
        OzC3j6tMEaOV6oNu3woBbIUXkA==
X-Google-Smtp-Source: AMrXdXszC5x5hxN5MiQK7Iep9DWI5si79kZcfSpCSPoCKwXaiHfVyhvxgDk5Hao8K0tW+XB83hBcFg==
X-Received: by 2002:a5d:528d:0:b0:242:4697:d826 with SMTP id c13-20020a5d528d000000b002424697d826mr47090427wrv.29.1673632962600;
        Fri, 13 Jan 2023 10:02:42 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b002426d0a4048sm20057227wrn.49.2023.01.13.10.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:02:42 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
Subject: [PATCH v5 2/3] thermal/drivers/intel: Use generic trip points for intel_pch
Date:   Fri, 13 Jan 2023 19:02:34 +0100
Message-Id: <20230113180235.1604526-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert the ops content logic into generic trip points and register
them with the thermal zone.

In order to consolidate the code, use the ACPI thermal framework API
to fill the generic trip point from the ACPI tables.

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/Kconfig             |  1 +
 drivers/thermal/intel/intel_pch_thermal.c | 88 +++++------------------
 2 files changed, 20 insertions(+), 69 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index f0c845679250..7d68c076c23d 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -75,6 +75,7 @@ config INTEL_BXT_PMIC_THERMAL
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
 	depends on X86 && PCI
+	select THERMAL_ACPI if ACPI
 	help
 	  Enable this to support thermal reporting on certain intel PCHs.
 	  Thermal reporting device will provide temperature reading,
diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index dabf11a687a1..8d3aaa467468 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -65,6 +65,8 @@
 #define WPT_TEMP_OFFSET	(PCH_TEMP_OFFSET * MILLIDEGREE_PER_DEGREE)
 #define GET_PCH_TEMP(x)	(((x) / 2) + PCH_TEMP_OFFSET)
 
+#define PCH_MAX_TRIPS 3 /* critical, hot, passive */
+
 /* Amount of time for each cooling delay, 100ms by default for now */
 static unsigned int delay_timeout = 100;
 module_param(delay_timeout, int, 0644);
@@ -82,12 +84,7 @@ struct pch_thermal_device {
 	const struct pch_dev_ops *ops;
 	struct pci_dev *pdev;
 	struct thermal_zone_device *tzd;
-	int crt_trip_id;
-	unsigned long crt_temp;
-	int hot_trip_id;
-	unsigned long hot_temp;
-	int psv_trip_id;
-	unsigned long psv_temp;
+	struct thermal_trip trips[PCH_MAX_TRIPS];
 	bool bios_enabled;
 };
 
@@ -102,33 +99,22 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 				      int *nr_trips)
 {
 	struct acpi_device *adev;
-
-	ptd->psv_trip_id = -1;
+	int ret;
 
 	adev = ACPI_COMPANION(&ptd->pdev->dev);
-	if (adev) {
-		unsigned long long r;
-		acpi_status status;
-
-		status = acpi_evaluate_integer(adev->handle, "_PSV", NULL,
-					       &r);
-		if (ACPI_SUCCESS(status)) {
-			unsigned long trip_temp;
-
-			trip_temp = deci_kelvin_to_millicelsius(r);
-			if (trip_temp) {
-				ptd->psv_temp = trip_temp;
-				ptd->psv_trip_id = *nr_trips;
-				++(*nr_trips);
-			}
-		}
-	}
+	if (!adev)
+		return;
+
+	ret = thermal_acpi_trip_psv(adev, &ptd->trips[*nr_trips]);
+	if (ret)
+		return;
+
+	++(*nr_trips);
 }
 #else
 static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 				      int *nr_trips)
 {
-	ptd->psv_trip_id = -1;
 
 }
 #endif
@@ -163,21 +149,19 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	}
 
 read_trips:
-	ptd->crt_trip_id = -1;
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->crt_temp = GET_WPT_TEMP(trip_temp);
-		ptd->crt_trip_id = 0;
+		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[*nr_trips].type = THERMAL_TRIP_CRITICAL;
 		++(*nr_trips);
 	}
 
-	ptd->hot_trip_id = -1;
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->hot_temp = GET_WPT_TEMP(trip_temp);
-		ptd->hot_trip_id = *nr_trips;
+		ptd->trips[*nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd->trips[*nr_trips].type = THERMAL_TRIP_HOT;
 		++(*nr_trips);
 	}
 
@@ -298,39 +282,6 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 	return	ptd->ops->get_temp(ptd, temp);
 }
 
-static int pch_get_trip_type(struct thermal_zone_device *tzd, int trip,
-			     enum thermal_trip_type *type)
-{
-	struct pch_thermal_device *ptd = tzd->devdata;
-
-	if (ptd->crt_trip_id == trip)
-		*type = THERMAL_TRIP_CRITICAL;
-	else if (ptd->hot_trip_id == trip)
-		*type = THERMAL_TRIP_HOT;
-	else if (ptd->psv_trip_id == trip)
-		*type = THERMAL_TRIP_PASSIVE;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int pch_get_trip_temp(struct thermal_zone_device *tzd, int trip, int *temp)
-{
-	struct pch_thermal_device *ptd = tzd->devdata;
-
-	if (ptd->crt_trip_id == trip)
-		*temp = ptd->crt_temp;
-	else if (ptd->hot_trip_id == trip)
-		*temp = ptd->hot_temp;
-	else if (ptd->psv_trip_id == trip)
-		*temp = ptd->psv_temp;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static void pch_critical(struct thermal_zone_device *tzd)
 {
 	dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
@@ -338,8 +289,6 @@ static void pch_critical(struct thermal_zone_device *tzd)
 
 static struct thermal_zone_device_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
-	.get_trip_type = pch_get_trip_type,
-	.get_trip_temp = pch_get_trip_temp,
 	.critical = pch_critical,
 };
 
@@ -423,8 +372,9 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_cleanup;
 
-	ptd->tzd = thermal_zone_device_register(bi->name, nr_trips, 0, ptd,
-						&tzd_ops, NULL, 0, 0);
+	ptd->tzd = thermal_zone_device_register_with_trips(bi->name, ptd->trips,
+							   nr_trips, 0, ptd,
+							   &tzd_ops, NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
 			bi->name);
-- 
2.34.1

