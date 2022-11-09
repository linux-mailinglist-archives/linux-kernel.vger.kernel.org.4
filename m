Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C57623386
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiKITbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiKITaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:30:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53F2A94A;
        Wed,  9 Nov 2022 11:30:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j12so18025014plj.5;
        Wed, 09 Nov 2022 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+ottrNj/QWc9Vetbcog1ENbzksG0RcS9PunOwnV9HY=;
        b=dXsJbxpJUyrFJZM3EEuRQCwS21WLv2LyLpUhg2q7f2rwVCvZGjUlnYpmtmxUJ/yn2v
         Q88XgQhMtEcmj1f4UklSYHCIfryKFOd6pnMgNLkw58HA4A6GqwDY+tU1xZeGb/1rZQ96
         j+NOerCW/vLRWsftGVRmoB+H5CO6wMX+qamceBp7N6KnMeGle60u0OfWvLMKo9L5vnEa
         PUlhXKnANVMVdoVF0qGG20JiemK1h4ncQr+eDndGI8uaJfskPng1MotSldOKvSqTfqK0
         IAE7k1Y7zyjlLMQMDimJFEi70tQAFGPR6PWQLRqPISkKpuSuX5GlDi5lSI7cVo+V1evw
         9jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+ottrNj/QWc9Vetbcog1ENbzksG0RcS9PunOwnV9HY=;
        b=UhBx0cp8BjuPWXcaeFDYaXe7Mu2RHmp196UDIR+HNw0rOqsy5EKK2Ew+iKLsatOlNG
         FefB0xqkGRb3JGZQwSjkBHLuw00B0qAwEC+ZpWc4BdGzxsm8Q85sQKRC6uvtnpJdhYK2
         HyAVnTlBhpzqIeQ4y9oa4e9rVawWdYcqJk35Asbzmg6uYITw2K6IjX2mxhabbFr+kHRL
         ZmChfsjIe2Uo6IHP2jVwrUqx2da+Fhm9pHpVsh5DjtK9BjEXqJHg+pDVUbd4pfDsFTaq
         4l2CUBi8DWVQPRZ4aC54LxS8I86D8N4Ugx2vbpwHT7G7w5bzw4YRM2fP26ExGkrcYMSz
         zHcA==
X-Gm-Message-State: ACrzQf3Rv8pn5vzZgJ5yMEjMjTnnImOjyMPc80SY1tw5J98a8ziDueVw
        iFk41Q8+rCTgrjbJDX64xyb2jnuJeKU=
X-Google-Smtp-Source: AMsMyM5vlvQIABT6pNHd8LM51v1gHymO7mkjFg8DGjSyG+RBjHf8El5ChUa95WD0UJtKSdFAJ9vwBw==
X-Received: by 2002:a17:902:e9c2:b0:186:79dc:7d87 with SMTP id 2-20020a170902e9c200b0018679dc7d87mr61784585plk.59.1668022254003;
        Wed, 09 Nov 2022 11:30:54 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186ac4b21cfsm9567462plg.230.2022.11.09.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:30:53 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 3/6] gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
Date:   Wed,  9 Nov 2022 11:30:41 -0800
Message-Id: <20221031-gpiolib-swnode-v3-3-0282162b0fa4@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
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

In preparation of switching all ACPI-based GPIO lookups to go through
acpi_find_gpio() we need to make sure it can handle data-only ACPI
nodes, same as existing acpi_node_get_gpiod().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 76 +++++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index ccb74e208989..d51bf2a3203d 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -864,8 +864,9 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
  * function only returns the first.
  */
 static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
-					  const char *propname, int index,
-					  struct acpi_gpio_info *info)
+						 const char *propname,
+						 int index,
+						 struct acpi_gpio_info *info)
 {
 	struct acpi_gpio_lookup lookup;
 	int ret;
@@ -896,6 +897,44 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	return ret ? ERR_PTR(ret) : lookup.desc;
 }
 
+/**
+ * acpi_get_gpiod_from_data() - get a GPIO descriptor from ACPI data node
+ * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
+ * @propname: Property name of the GPIO
+ * @index: index of GpioIo/GpioInt resource (starting from %0)
+ * @info: info pointer to fill in (optional)
+ *
+ * This function uses the property-based GPIO lookup to get to the GPIO
+ * resource with the relevant information from a data-only ACPI firmware node
+ * and uses that to obtain the GPIO descriptor to return.
+ *
+ * If the GPIO cannot be translated or there is an error an ERR_PTR is
+ * returned.
+ */
+static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
+						  const char *propname,
+						  int index,
+						  struct acpi_gpio_info *info)
+{
+	struct acpi_gpio_lookup lookup;
+	int ret;
+
+	if (!is_acpi_data_node(fwnode))
+		return ERR_PTR(-ENODEV);
+
+	if (!propname)
+		return ERR_PTR(-EINVAL);
+
+	lookup.index = index;
+
+	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = acpi_gpio_resource_lookup(&lookup, info);
+	return ret ? ERR_PTR(ret) : lookup.desc;
+}
+
 static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 				     const char *con_id)
 {
@@ -912,16 +951,12 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
 	int i;
 
-	adev = to_acpi_device_node(fwnode);
-	if (!adev)
-		return ERR_PTR(-ENODEV);
-
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id) {
@@ -932,7 +967,12 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 gpio_suffixes[i]);
 		}
 
-		desc = acpi_get_gpiod_by_index(adev, propname, idx, &info);
+		if (adev)
+			desc = acpi_get_gpiod_by_index(adev,
+						       propname, idx, &info);
+		else
+			desc = acpi_get_gpiod_from_data(fwnode,
+						        propname, idx, &info);
 		if (!IS_ERR(desc))
 			break;
 		if (PTR_ERR(desc) == -EPROBE_DEFER)
@@ -941,7 +981,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 	/* Then from plain _CRS GPIOs */
 	if (IS_ERR(desc)) {
-		if (!acpi_can_fallback_to_crs(adev, con_id))
+		if (!adev || !acpi_can_fallback_to_crs(adev, con_id))
 			return ERR_PTR(-ENOENT);
 
 		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
@@ -979,29 +1019,13 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 				      const char *propname, int index,
 				      struct acpi_gpio_info *info)
 {
-	struct acpi_gpio_lookup lookup;
 	struct acpi_device *adev;
-	int ret;
 
 	adev = to_acpi_device_node(fwnode);
 	if (adev)
 		return acpi_get_gpiod_by_index(adev, propname, index, info);
 
-	if (!is_acpi_data_node(fwnode))
-		return ERR_PTR(-ENODEV);
-
-	if (!propname)
-		return ERR_PTR(-EINVAL);
-
-	memset(&lookup, 0, sizeof(lookup));
-	lookup.index = index;
-
-	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = acpi_gpio_resource_lookup(&lookup, info);
-	return ret ? ERR_PTR(ret) : lookup.desc;
+	return acpi_get_gpiod_from_data(fwnode, propname, index, info);
 }
 
 /**

-- 
b4 0.11.0-dev-28747
