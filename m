Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8F6AE791
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCGQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCGQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:06 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694693105;
        Tue,  7 Mar 2023 08:54:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5739AC0015;
        Tue,  7 Mar 2023 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRL047YAbIJguRiFQI3/XABhDSXRrCi4d0RTrfTbjWU=;
        b=XwfFA3HzD7D5w6xV5PE/+L4y9CVoE964mOvQRDJP8t3jXof4NetHFzuu4MqJhbc1ZR153r
        c56UtJ/xP/K42XiVHrrKZ1JcN/z//ubPBIYlX9Px3iV+V3WOQJ0kOunENwqIMPmg3UrbQl
        X0OMcRYYLdYmQKz6zLo9ZzHDoIpxMUmNETjzb0C8bD0ixos9BoOO0uxZSMPDAlc5/t5jnm
        MJudPX2tDOxCVh4q895wJk3OrNo0EePej0noQ32VRF1SRpX1uMpGDR4qCiMW4xbNwD8y2z
        JOBe485b7iUI1KcuOf7aD+hTBshLlpEWL80sLoO9CZCDZ1J8LyQqzEwSe9bqJg==
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
Subject: [PATCH v2 04/21] of: Move of_modalias() to module.c
Date:   Tue,  7 Mar 2023 17:53:42 +0100
Message-Id: <20230307165359.225361-5-miquel.raynal@bootlin.com>
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

Create a specific .c file for of related module handling.
Move of_modalias() inside as a first step.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/of/Makefile |  2 +-
 drivers/of/device.c | 37 -------------------------------------
 drivers/of/module.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h  |  8 ++++++++
 4 files changed, 52 insertions(+), 38 deletions(-)
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
index 2bbb67798916..44f1f2ef12b7 100644
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
 
-static ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
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
index 000000000000..9c6a53f32c0f
--- /dev/null
+++ b/drivers/of/module.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Linux kernel module helpers.
+ */
+
+#include <linux/of.h>
+#include <linux/string.h>
+
+ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
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
index fc7ada57df33..1372f8647272 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -373,6 +373,9 @@ extern int of_parse_phandle_with_args_map(const struct device_node *np,
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
+/* module functions */
+extern ssize_t of_modalias(struct device_node *np, char *str, ssize_t len);
+
 /* phandle iterator functions */
 extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
 				    const struct device_node *np,
@@ -730,6 +733,11 @@ static inline int of_count_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
+{
+	return -ENODEV;
+}
+
 static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
 					   const struct device_node *np,
 					   const char *list_name,
-- 
2.34.1

