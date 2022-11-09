Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093556220BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKIA1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKIA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:27:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264B61752;
        Tue,  8 Nov 2022 16:27:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so2323282pjh.1;
        Tue, 08 Nov 2022 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+ottrNj/QWc9Vetbcog1ENbzksG0RcS9PunOwnV9HY=;
        b=ZqBpG8BfUkybUiVdBIKdARy6xeWxswsMIW3yHqDRbH08RNiM+d2EX83oOSpX4MmJFX
         iIOua9nJRgFn7Fk4ICu6AkDl4+Dz0EXfsF1OdMbQgZEAkZb4kD8rxsq1leGQPZXeIiuR
         B9Yr13twNSvLwLKyssTTQDQLg7whFH0NNqlx3aWwnMIEgoLewjNCtNeTuMG5Iq/D9Gbh
         EcQiHDtJV3BsxDXRLmxaKHmuRV6JsnFDdX6hPt/Z/uXZWXDJng70WbWTxrxU70i6qjU8
         lyfd8GNgL9QM43CO8lZg3WfYbd3vgcxUoalYcomPvWtNAbvnAesXa1b+T+JY7R44AqO8
         OELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+ottrNj/QWc9Vetbcog1ENbzksG0RcS9PunOwnV9HY=;
        b=LhJgIfTffIPEdusWpbzU2mR2DgUxopeftKLyFTM0S1WLjXALtCQLNyjqXN850yrkNn
         zNjRGqUV2k7TKspWJ53InyNOoM8qjVOJD8+eJSYGP/vdvlBXAuq35uqyQEHp4WwoGxsw
         tVMyUgAv9NMA1xpnX2G13dU8Ul+0+VJbBMQrlSh+o4rU4nUtIvmZ9RzSMms1G2BVDWP1
         n03KbSL18QFfOZ81eStEyUXI0T0hWPxSMN/cZQB0KFRaS3C/LW2CNrOQKaNpd4akXKf5
         USzmsMSXM3qHPL10kA3xXt5QHF+S9YaP4MUsFWIQVGjl9fPQxa6R7LyprrpEUnQbYbS/
         7P1Q==
X-Gm-Message-State: ACrzQf2VWgBgNuqRsQQ1EJ0KAxR41mSq8eKyz6pfDK0FCyNeCRAn4T1P
        P9NLOvRu8L+2aMl9OuR5UCuSkJVzyqA=
X-Google-Smtp-Source: AMsMyM5O0k8JKg9ogKCre8rCQLaBu01TUUisDKYtJn68jPV5hZp2qSBxSdPupMy/2V8xIdb0ZHzFgw==
X-Received: by 2002:a17:902:c94b:b0:187:3da6:37ab with SMTP id i11-20020a170902c94b00b001873da637abmr39685125pla.50.1667953620830;
        Tue, 08 Nov 2022 16:27:00 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id i65-20020a626d44000000b0056bd737fdf3sm6907324pfc.123.2022.11.08.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:27:00 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
Date:   Tue,  8 Nov 2022 16:26:48 -0800
Message-Id: <20221031-gpiolib-swnode-v2-3-81f55af5fa0e@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
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
