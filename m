Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A744D6B0CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCHPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjCHPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:21 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456E7D161E;
        Wed,  8 Mar 2023 07:32:13 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 84E10FF80B;
        Wed,  8 Mar 2023 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCRvTyHEH13tgqdLoox49Vvo8WKTA3FYHLaY4F7HdhE=;
        b=db9WcWXPG0BqmKl4wuY1F5Z4kjpiVeo3v8YcfPKwV9zeS6VC2K52hrg0T+nUulYqH+77iy
        yjtQwYmv1i12pvRf/C80rCLGqVCMaYu6HuRYledmMuyHiiNgkGvLCSeB/2BNOmxh+AGPRm
        JL3P6OdYxV0zHw85EWfPPQw0NELCxioFZEj8zb7amuGKHlZeFDNlndHxKUYYMx6t1YIHIg
        83sqoPPspNsvhRBn4a3ZDeL8hWzgg/mAG0LgY/UoGD5Ip8WCRAMIpy4HBc2Sj04LCRBgNk
        M4Ama5kdLViEPzSK0MzYCDWhJdgHvh09A5pvGksgraPv++7QbbotmdqqwNAymA==
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
Subject: [PATCH v3 04/20] of: Move of_modalias() to module.c
Date:   Wed,  8 Mar 2023 16:31:44 +0100
Message-Id: <20230308153200.682248-5-miquel.raynal@bootlin.com>
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

Create a specific .c file for OF related module handling.
Move of_modalias() inside as a first step.

The helper is exposed through of.h even though it is only used by core
files because the users from device.c will soon be split into an OF-only
helper in module.c as well as a device-oriented inline helper in
of_device.h. Putting this helper in of_private.h would require to
include of_private.h from of_device.h, which is not acceptable.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/of/Makefile |  2 +-
 drivers/of/device.c | 37 -------------------------------------
 drivers/of/module.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h  |  9 +++++++++
 4 files changed, 54 insertions(+), 38 deletions(-)
 create mode 100644 drivers/of/module.c

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..ae9923fd2940 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y = base.o device.o platform.o property.o
+obj-y = base.o device.o module.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 351c505ecb50..7183cfd754db 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -248,42 +247,6 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-static ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
-{
-	const char *compat;
-	char *c;
-	struct property *p;
-	ssize_t csize;
-	ssize_t tsize;
-
-	/* Name & Type */
-	/* %p eats all alphanum characters, so %c must be used here */
-	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
-			 of_node_get_device_type(np));
-	tsize = csize;
-	len -= csize;
-	if (str)
-		str += csize;
-
-	of_property_for_each_string(np, "compatible", p, compat) {
-		csize = strlen(compat) + 1;
-		tsize += csize;
-		if (csize > len)
-			continue;
-
-		csize = snprintf(str, len, "C%s", compat);
-		for (c = str; c; ) {
-			c = strchr(c, ' ');
-			if (c)
-				*c++ = '_';
-		}
-		len -= csize;
-		str += csize;
-	}
-
-	return tsize;
-}
-
 int of_device_request_module(struct device *dev)
 {
 	char *str;
diff --git a/drivers/of/module.c b/drivers/of/module.c
new file mode 100644
index 000000000000..4c59752bc8d6
--- /dev/null
+++ b/drivers/of/module.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux kernel module helpers.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
+{
+	const char *compat;
+	char *c;
+	struct property *p;
+	ssize_t csize;
+	ssize_t tsize;
+
+	/* Name & Type */
+	/* %p eats all alphanum characters, so %c must be used here */
+	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
+			 of_node_get_device_type(np));
+	tsize = csize;
+	len -= csize;
+	if (str)
+		str += csize;
+
+	of_property_for_each_string(np, "compatible", p, compat) {
+		csize = strlen(compat) + 1;
+		tsize += csize;
+		if (csize > len)
+			continue;
+
+		csize = snprintf(str, len, "C%s", compat);
+		for (c = str; c; ) {
+			c = strchr(c, ' ');
+			if (c)
+				*c++ = '_';
+		}
+		len -= csize;
+		str += csize;
+	}
+
+	return tsize;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index b1eea8569043..be26c7e8ef9e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -385,6 +385,9 @@ extern int of_parse_phandle_with_args_map(const struct device_node *np,
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
+/* module functions */
+extern ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len);
+
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
 				    const struct device_node *np,
@@ -742,6 +745,12 @@ static inline int of_count_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline ssize_t of_modalias(const struct device_node *np, char *str,
+				  ssize_t len)
+{
+	return -ENODEV;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
-- 
2.34.1

