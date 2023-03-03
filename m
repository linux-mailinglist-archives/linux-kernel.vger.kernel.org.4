Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431576AA060
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjCCUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjCCUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:00:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9060D44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:59:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso1902724wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 11:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677873594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLUnfNdm2yVAS1wkgyhep1P3VK/E8L4MHqepWzvtV2A=;
        b=MBC/2e6spG09Ct78cOKn1e0fkmrSqTbFZ2xtNWbYj1zEb7Se2lGIOm53y56wKcgxe6
         8l1aZnZO3mgbCTYt59U9p3DpPkAgE7QconRUjGP6igfhETLdKSyonZ+LFHH6s3fqlOnr
         P5N7qHPtbImyQpSMm9Yagg+ysLv0tB4aZqLnex48Qrm5lyxRxz1SxNu9/LBanVHyLQqM
         MdUlXmegugeeuH3yWUy6u11YRAY2E4RPK7yRpr6ctRREIAKUTGfuaiySOdgs9Ph/WlCE
         kjtSjfgWVXxBswox1pTReeblQ1B/tkwVUOUKKdXKvtEcNxhh6dPS9m2t3qV98pJoMzM3
         kHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677873594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLUnfNdm2yVAS1wkgyhep1P3VK/E8L4MHqepWzvtV2A=;
        b=h7q4yEC+UiGbfIlv+yFoSzWUOsmqi1Yt5pC4q8mqkLJY4Ur+OcaOM0tg1CF3eIuHhz
         xxKdzIJuidaZMBVHmcT2SaC6GWZn2Vta85IQQVS4tBRXolaRLsqKjvAoK9FJLwigcy65
         Ejq+h92rjMLBDroouYs+TiQJG6Mv+ObjQp2clZ7FKZQ1jgvYf/rJNOl52SGakn/tZ67d
         Vv5d1btuUGMyWk0Ww0LMHDDdj4jNMWJzDAkWQV/sWphU+v64PgkM+vwobUvGxu0Wdlaq
         XS7tRhlsY8Oo0WBC7ujP6tNfvaXAKiNhfI6JGvzjGwKikc4/ufyQkjW4th1mcBRW39fi
         h2eg==
X-Gm-Message-State: AO0yUKUBou6FUUY3XqGFmD2BvgZ9Yny2kt5N4sXJg9mmnBox5rfl2sPJ
        BBNe0rRgAYsuvLBR35Y3QDXXNg==
X-Google-Smtp-Source: AK7set9uJQopjHXkyijTJljvqFIZIUUrbVSev/wCZaH98Lu1febNf3+LDhmdz7htTAl/Fh5ZBxFjHg==
X-Received: by 2002:a05:600c:1990:b0:3e2:20c7:6553 with SMTP id t16-20020a05600c199000b003e220c76553mr2721780wmq.13.1677873594171;
        Fri, 03 Mar 2023 11:59:54 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:e474:bda6:c260:d90b])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003e91b9a92c9sm3210862wmg.24.2023.03.03.11.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 11:59:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-acpi@vger.kernel.org,
        Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTEL MENLOW THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] thermal/drivers/intel_menlow: Remove add_one_attribute
Date:   Fri,  3 Mar 2023 20:59:37 +0100
Message-Id: <20230303195937.1835735-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The driver hooks the thermal framework sysfs to add some driver
specific information. A debatable approach as that may belong the
device sysfs directory, not the thermal zone directory.

As the driver is accessing the thermal internals, we should provide at
least an API to the thermal framework to add an attribute to the
existing sysfs thermal zone entry.

Before doing that and given the age of the driver (2008) may be it is
worth to double check if these attributes are really needed. So my
first proposal is to remove them if that does not hurt.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_menlow.c | 193 ---------------------------
 1 file changed, 193 deletions(-)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 5a6ad0552311..5a9738a93083 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -230,174 +230,8 @@ struct intel_menlow_attribute {
 static LIST_HEAD(intel_menlow_attr_list);
 static DEFINE_MUTEX(intel_menlow_attr_lock);
 
-/*
- * sensor_get_auxtrip - get the current auxtrip value from sensor
- * @handle: Object handle
- * @index : GET_AUX1/GET_AUX0
- * @value : The address will be fill by the value
- */
-static int sensor_get_auxtrip(acpi_handle handle, int index,
-							unsigned long long *value)
-{
-	acpi_status status;
-
-	if ((index != 0 && index != 1) || !value)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
-				       NULL, value);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	return 0;
-}
-
-/*
- * sensor_set_auxtrip - set the new auxtrip value to sensor
- * @handle: Object handle
- * @index : GET_AUX1/GET_AUX0
- * @value : The value will be set
- */
-static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
-{
-	acpi_status status;
-	union acpi_object arg = {
-		ACPI_TYPE_INTEGER
-	};
-	struct acpi_object_list args = {
-		1, &arg
-	};
-	unsigned long long temp;
-
-	if (index != 0 && index != 1)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
-				       NULL, &temp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-	if ((index && value < temp) || (!index && value > temp))
-		return -EINVAL;
-
-	arg.integer.value = value;
-	status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
-				       &args, &temp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	/* do we need to check the return value of SAX0/SAX1 ? */
-
-	return 0;
-}
-
-#define to_intel_menlow_attr(_attr)	\
-	container_of(_attr, struct intel_menlow_attribute, attr)
-
-static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
-			char *buf, int idx)
-{
-	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	unsigned long long value;
-	int result;
-
-	result = sensor_get_auxtrip(attr->handle, idx, &value);
-	if (result)
-		return result;
-
-	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
-}
-
-static ssize_t aux0_show(struct device *dev,
-			 struct device_attribute *dev_attr, char *buf)
-{
-	return aux_show(dev, dev_attr, buf, 0);
-}
-
-static ssize_t aux1_show(struct device *dev,
-			 struct device_attribute *dev_attr, char *buf)
-{
-	return aux_show(dev, dev_attr, buf, 1);
-}
-
-static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
-			 const char *buf, size_t count, int idx)
-{
-	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	int value;
-	int result;
-
-	/*Sanity check; should be a positive integer */
-	if (!sscanf(buf, "%d", &value))
-		return -EINVAL;
-
-	if (value < 0)
-		return -EINVAL;
-
-	result = sensor_set_auxtrip(attr->handle, idx,
-				    celsius_to_deci_kelvin(value));
-	return result ? result : count;
-}
-
-static ssize_t aux0_store(struct device *dev,
-			  struct device_attribute *dev_attr,
-			  const char *buf, size_t count)
-{
-	return aux_store(dev, dev_attr, buf, count, 0);
-}
-
-static ssize_t aux1_store(struct device *dev,
-			  struct device_attribute *dev_attr,
-			  const char *buf, size_t count)
-{
-	return aux_store(dev, dev_attr, buf, count, 1);
-}
-
 /* BIOS can enable/disable the thermal user application in dabney platform */
 #define BIOS_ENABLED "\\_TZ.GSTS"
-static ssize_t bios_enabled_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	acpi_status status;
-	unsigned long long bios_enabled;
-
-	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
-}
-
-static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
-					  void *store, struct device *dev,
-					  acpi_handle handle)
-{
-	struct intel_menlow_attribute *attr;
-	int result;
-
-	attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
-	if (!attr)
-		return -ENOMEM;
-
-	sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
-	attr->attr.attr.name = name;
-	attr->attr.attr.mode = mode;
-	attr->attr.show = show;
-	attr->attr.store = store;
-	attr->device = dev;
-	attr->handle = handle;
-
-	result = device_create_file(dev, &attr->attr);
-	if (result) {
-		kfree(attr);
-		return result;
-	}
-
-	mutex_lock(&intel_menlow_attr_lock);
-	list_add_tail(&attr->node, &intel_menlow_attr_list);
-	mutex_unlock(&intel_menlow_attr_lock);
-
-	return 0;
-}
 
 static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 						void *context, void **rv)
@@ -420,12 +254,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 	if (ACPI_FAILURE(status))
 		return (status == AE_NOT_FOUND) ? AE_OK : status;
 
-	result = intel_menlow_add_one_attribute("aux0", 0644,
-						aux0_show, aux0_store,
-						&thermal->device, handle);
-	if (result)
-		return AE_ERROR;
-
 	status = acpi_get_handle(handle, GET_AUX1, &dummy);
 	if (ACPI_FAILURE(status))
 		goto aux1_not_found;
@@ -434,27 +262,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 	if (ACPI_FAILURE(status))
 		goto aux1_not_found;
 
-	result = intel_menlow_add_one_attribute("aux1", 0644,
-						aux1_show, aux1_store,
-						&thermal->device, handle);
-	if (result) {
-		intel_menlow_unregister_sensor();
-		return AE_ERROR;
-	}
-
-	/*
-	 * create the "dabney_enabled" attribute which means the user app
-	 * should be loaded or not
-	 */
-
-	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
-						bios_enabled_show, NULL,
-						&thermal->device, handle);
-	if (result) {
-		intel_menlow_unregister_sensor();
-		return AE_ERROR;
-	}
-
 	return AE_OK;
 
  aux1_not_found:
-- 
2.34.1

