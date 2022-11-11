Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A13626485
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiKKWTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiKKWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:19:24 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497576250;
        Fri, 11 Nov 2022 14:19:18 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 140so4535398pfz.6;
        Fri, 11 Nov 2022 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+ottrNj/QWc9Vetbcog1ENbzksG0RcS9PunOwnV9HY=;
        b=CZgh+c5tfy8tqroZOZ4cb77e81CfbwKClBlcKvFZkP7r6GtKLCdDGAzaVxCk+WRU8n
         yQDnsulSmwYjbtrJ4r/9yRbU/KGwZNHPJlYW12rbsN9X5H2RKXvcWyUSmFxjYBB9GdFh
         Fz7o7PjX8RZCkIzbsAMgvVNokPhao9L0ZMaAWBOWfKxk51t+usaDCA5i9kMRayeln+Zo
         MHt1l2yD9doGVFDneApwenYkqP7DvPADY6WjUic6d9pFp/DtfiZrsrhFFNIMsgUIngtb
         AXKtt/p2UuRHRO5bK9R6UoIWmzuQ+NFa7kW9qSE41kO4mjmU+V5ucBBielkMkXY1ZtmX
         pVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+ottrNj/QWc9Vetbcog1ENbzksG0RcS9PunOwnV9HY=;
        b=ga1WG0SQfJAbcVfbfmjqVYVPVzQ2qvDcmqCFGF3c+gI2AmGZ+oWkcpGjNe6fQ1VO+k
         OXXp1OcOjlUsrLqIPayclF39Wp+DDwBfxH0E9W1ImnOOsTckkdi1D9iv+gvLFN6GWeRX
         /ndZPEJLvErjp2AHW7OW6yYRJnjrswXQ9LyERzIpTjDVKJuTTY/I7xe09QL0e/cCEqs6
         WNNfzrqtmIawBczTKBVZUmEe7sinNIhovCJqD5VC+ArebK2ZCJF+H7NLR3Bm8k3XN82p
         ufaF0cOzFGjpM1/txdFpnFgiVRIKRi9oJS7yevK2SOwOUG1fdphox/mD5MbA70i18Zaq
         yCkA==
X-Gm-Message-State: ANoB5pkz+gWe/kQfL6hP8/wsKs1PzXLFHGcNG6mpIsCNUpY6cazfnYj/
        WfOvmMnsb/udj/AFezEHzGA=
X-Google-Smtp-Source: AA0mqf5OHgj5yI/Ehwg2iSGL5r9VQsYhj2GT3S+HZiITxe4jUbIwbjW6l1jUQR/Bj66/jhayUPRnTw==
X-Received: by 2002:a05:6a00:1393:b0:56c:318a:f808 with SMTP id t19-20020a056a00139300b0056c318af808mr4744645pfg.11.1668205157608;
        Fri, 11 Nov 2022 14:19:17 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm2201109pls.125.2022.11.11.14.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:19:17 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 3/6] gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
Date:   Fri, 11 Nov 2022 14:19:05 -0800
Message-Id: <20221031-gpiolib-swnode-v4-3-6c1671890027@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
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
