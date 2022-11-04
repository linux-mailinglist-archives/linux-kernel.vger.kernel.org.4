Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87D6190BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDGK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKDGK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:10:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48128E30;
        Thu,  3 Nov 2022 23:10:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io19so3993646plb.8;
        Thu, 03 Nov 2022 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8by26zBfJpt7L2atZn5FOME6ope8yoyFn+mCDRyv34=;
        b=IVQ81+VemRohBHMazkHsK1zuoXcjUZg9BU1wvONtzW2NM+XC/VQ+nCASVAOOLOEEyi
         Rx9R0wZuZb1/HQn74VuvinoHx2x1WCAK1pvYU7hiNNQnCgE11Z8BUHDtHYKtu/UPsAwS
         IK9pg1t/+eDrYtm+PxdJQ8i2dFJJajnVz9IkL/Ka4A+b42n1AvaUDhHOO8DRWB6/QfyZ
         gq7QOQ+yeQ4Fj8uoTTFaWD8hRj+Qo/mWWLQWxTeN+YBU2TEKl2wF82Nx7Xk6Zk4LgqyA
         ye+Ky1G3pg+X+RcTH3RwQx+lmaIARO6F5uC6147XoPn1zkJZ+thySI9DRFvY5CBz3FZ0
         /0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8by26zBfJpt7L2atZn5FOME6ope8yoyFn+mCDRyv34=;
        b=qdCaktIo+aow54biQhre3wEUrZDk4UgzNz8p7NOHCS/VFbTBFLIL2JBy+xqcJoCXFT
         eKEKCxg3QFDq1/7GsNm/58I/uRoefOxtr5/yl/Ww8DQHxA45jdVjkmpX1moTYdNZyheP
         EaK2CYlBAyiChewFZcEnKghfKV99UFY6GDcQE1MdXhNNfyyrViaB5l+H/zLwQfa/phAq
         AjKXZiZiO2uWJxr4aXPiWcBINOwEgSMDa3OPx6dQkOjoWhvbwtXP63JpZ+VGFLZ6dy52
         mkRl8GmwOIjF1PxbqtYQJG03bGJqSPsnoC4EsB4LVQUayKdRGPeZDj8ic1rardH8UzgW
         7nSg==
X-Gm-Message-State: ACrzQf0wwfoZGz3zUtLFgr2jKRIVUldTh2ZjsmRH3F3E4JdXpOObv8dk
        9M6YxzKq3+anvxOQua90Jds=
X-Google-Smtp-Source: AMsMyM6vzXSDhl7+O55gjdP8y0qvfQ5J4wxmwlw3fbsZLEIbjhT5vfygJnKu5Ds7uhEGzvgvogbzrg==
X-Received: by 2002:a17:903:2452:b0:186:99e0:672d with SMTP id l18-20020a170903245200b0018699e0672dmr34142314pls.95.1667542225831;
        Thu, 03 Nov 2022 23:10:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79ac5000000b0056bfd4a2702sm1791411pfp.45.2022.11.03.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:10:25 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
Date:   Thu,  3 Nov 2022 23:10:13 -0700
Message-Id: <20221031-gpiolib-swnode-v1-3-a0ab48d229c7@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
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
