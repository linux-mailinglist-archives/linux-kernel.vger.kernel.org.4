Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29AE6AE0C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCGNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCGNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA93E076
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:37:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bw19so12117645wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLUnfNdm2yVAS1wkgyhep1P3VK/E8L4MHqepWzvtV2A=;
        b=qKIJrWS9HlseEtztfIrN6k80cK8FLhU5mOoTqsxRKIDDswm6hrdb/9FJXWSrtgL4Pm
         ZymY4A+L/FR0vKcMRpxJnpy3ko7ZviX2L3xB7TSfO4MkZ5K4R5T7I6j2QJO/IV2kfHfa
         xRqWqAfhDP64AdJkXBlw4aRFPruwVqGBE9ynzgRIdvtK8gIYV3EbAI7UtfctX4+wYbIN
         bMGDMVGkXtrCoEnJcQJBTZ58XDpIflI+VbB0IaYvqcKCQ/6UeWX4Am5pQ3QL1N23Kf+T
         qNq7IV3DjqUzZ5e0CsHVPgb0IYpSE/rwbzlDfi4qNQ1X4w8H8QslY8Sjm5y/QHleuooc
         8giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLUnfNdm2yVAS1wkgyhep1P3VK/E8L4MHqepWzvtV2A=;
        b=UCuhCHmgXDRs6BMh+sgyuxB8Hgf1AhG6DZEojsi49XMrMycx03M/B4F3vGBLa/e1L4
         jmFykb/95jD2tXtlVuu4/JkNAufJihURwFkFwJcKMNDVCVtFG8MKP0+spl8Znv3WTZuL
         sNCb9nL+RGgzrAtgjllh4/KXmHCJpnhix4A695RV4TYPI+sLzYJFEoO2Fr4eV9ddGxJe
         boELoqk84msP4hjowvj47jJ76iiYUGylynGjIUCalWsUE1jW5ep+uPeYE+VXEquxMZgq
         +JCSnpZwa5UuzCLBdHHY2rEr/Q8dshvdSwkghJeR+PVHIk1PCcyHM6b/f6aHCj9cZj0k
         tJBw==
X-Gm-Message-State: AO0yUKWkvjik/k+P6OMUlL0UpsZSU0B0imimJZsQq4EanGY2DAbuFQ7s
        oCKU3es0V/klgVR4jQF09gX5fg==
X-Google-Smtp-Source: AK7set+5bl0ivxq0qjIDEGdtaLKiDFJabUVOomnEhZz+7wzT8OijXNC2nxhhd/MkVveZgS5ZEKTF/w==
X-Received: by 2002:adf:e948:0:b0:2c7:478:d1d9 with SMTP id m8-20020adfe948000000b002c70478d1d9mr9055975wrn.33.1678196277140;
        Tue, 07 Mar 2023 05:37:57 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:37:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Sujith Thomas <sujith.thomas@intel.com>,
        linux-pm@vger.kernel.org (open list:INTEL MENLOW THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 03/11] thermal/drivers/intel_menlow: Remove add_one_attribute
Date:   Tue,  7 Mar 2023 14:37:27 +0100
Message-Id: <20230307133735.90772-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

