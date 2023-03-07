Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5146AE789
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCGQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCGQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:04 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9F93122;
        Tue,  7 Mar 2023 08:54:26 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 12640C0008;
        Tue,  7 Mar 2023 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1BxK7lQ9engNEKcMZlaGSCrOyuJ60v/1lMB8qEqy60=;
        b=c6i2mro1rqAAHI+67wZ1IUXXHxhvHB2uvzuaqeZqBxOurdJPS1Sd7ix9uiyADZ0VzGddGR
        i9FJfvr4UekAat2PUquaF0AKXkAplOpbF0R+L+22i+1xzgTmOtp9+MVSsGXSf7WmASXyyX
        oh1TIVd7vAwD8osamNFZZwceHF4mw50DStIrZEHD94daF48bnGvRR4h+dIu84KmlLGDOnz
        p73YD3P57BAvCSpofJ1WtoxxiAjSh+v31GmSN8SW3Ce1JM9TZOP6mHUQVdTpOOT7urIM6q
        SKrXe/6b7um8rOBvOLqZzaExX/+jZROqSt6anM7R5h7f5/tVdi6TmuWf6ujbYQ==
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 05/21] of: Move the request module helper logic to module.c
Date:   Tue,  7 Mar 2023 17:53:43 +0100
Message-Id: <20230307165359.225361-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
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
---
 drivers/of/device.c | 25 ++-----------------------
 drivers/of/module.c | 30 ++++++++++++++++++++++++++++++
 include/linux/of.h  |  6 ++++++
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 44f1f2ef12b7..4bbb6e6388a9 100644
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
index 9c6a53f32c0f..0cb3bb83b700 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/module.h>
 #include <linux/string.h>
 
 ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
@@ -41,3 +42,32 @@ ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
 
 	return tsize;
 }
+
+int of_request_module(struct device_node *np)
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
index 1372f8647272..692581486403 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -375,6 +375,7 @@ extern int of_count_phandle_with_args(const struct device_node *np,
 
 /* module functions */
 extern ssize_t of_modalias(struct device_node *np, char *str, ssize_t len);
+extern int of_request_module(struct device_node *np);
 
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
@@ -738,6 +739,11 @@ static inline ssize_t of_modalias(struct device_node *np, char *str, ssize_t len
 	return -ENODEV;
 }
 
+static inline int of_request_module(struct device_node *np)
+{
+	return -ENODEV;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
-- 
2.34.1

