Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612A6B0CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjCHPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjCHPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:22 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2243D6E90;
        Wed,  8 Mar 2023 07:32:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0F9CEFF811;
        Wed,  8 Mar 2023 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSIaLowzQOIsdvJKYrUeSvZLlLef3hpg/zogwF151qc=;
        b=jjiE7Y9mibAmaq9V923vzVBEc+jLOeK2Tq4IM56MhMTpU+O1HQbiNMAqIwySROQPValvvm
        +6yf07XU5n9z/JcLm2qUGbIMV+qtC7Y9xI29SCaZdK9s7Tt9eqY3c/qgSFIr39FAMtIkwT
        ldRUp786l0VI0Hj77w7eDGCCeq7NJJW9ZiGg0tzATXv8lBftQldzULD92fMF/4vzp7BbrC
        Jr2jSkabfdYmujBQSwn5ISurJfBb6Rx/+vN88OOCMDw5c/99NWkRxJ7sn8OMeZlps1NixO
        DytCnuTMVk6Z+DO676KxbrLZnqg2B6XTaUUcDDzmCvvJonveOC7e15vKfPrAVg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/20] of: Move the request module helper logic to module.c
Date:   Wed,  8 Mar 2023 16:31:45 +0100
Message-Id: <20230308153200.682248-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on device.c for pure OF handling is considered
backwards. Let's extract the content of of_device_request_module() to
have the real logic under module.c.

The next step will be to convert users of of_device_request_module() to
use the new helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c | 25 ++-----------------------
 drivers/of/module.c | 30 ++++++++++++++++++++++++++++++
 include/linux/of.h  |  6 ++++++
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 7183cfd754db..874a2e1f6308 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -8,7 +8,6 @@
 #include <linux/dma-direct.h> /* for bus_dma_region */
 #include <linux/dma-map-ops.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -249,30 +248,10 @@ EXPORT_SYMBOL(of_device_get_match_data);
 
 int of_device_request_module(struct device *dev)
 {
-	char *str;
-	ssize_t size;
-	int ret;
-
-	if (!dev || !dev->of_node)
+	if (!dev)
 		return -ENODEV;
 
-	size = of_modalias(dev->of_node, NULL, 0);
-	if (size < 0)
-		return size;
-
-	/* Reserve an additional byte for the trailing '\0' */
-	size++;
-
-	str = kmalloc(size, GFP_KERNEL);
-	if (!str)
-		return -ENOMEM;
-
-	of_modalias(dev->of_node, str, size);
-	str[size - 1] = '\0';
-	ret = request_module(str);
-	kfree(str);
-
-	return ret;
+	return of_request_module(dev->of_node);
 }
 EXPORT_SYMBOL_GPL(of_device_request_module);
 
diff --git a/drivers/of/module.c b/drivers/of/module.c
index 4c59752bc8d6..0e8aa974f0f2 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -42,3 +43,32 @@ ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 
 	return tsize;
 }
+
+int of_request_module(const struct device_node *np)
+{
+	char *str;
+	ssize_t size;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	size = of_modalias(np, NULL, 0);
+	if (size < 0)
+		return size;
+
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+
+	of_modalias(np, str, size);
+	str[size - 1] = '\0';
+	ret = request_module(str);
+	kfree(str);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_request_module);
diff --git a/include/linux/of.h b/include/linux/of.h
index be26c7e8ef9e..9b7a99499ef3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -387,6 +387,7 @@ extern int of_count_phandle_with_args(const struct device_node *np,
 
 /* module functions */
 extern ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len);
+extern int of_request_module(const struct device_node *np);
 
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
@@ -751,6 +752,11 @@ static inline ssize_t of_modalias(const struct device_node *np, char *str,
 	return -ENODEV;
 }
 
+static inline int of_request_module(const struct device_node *np)
+{
+	return -ENODEV;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
-- 
2.34.1

