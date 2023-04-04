Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637B66D6A69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjDDRXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbjDDRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE14488
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so133617703edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHXEBUu03ZPDI2Y2TmpsJOeJIjzDeMVBiDxI7vjmsio=;
        b=QlvyO1b5i+CWF9n/nzyWW7U8kMHzBMEVcl8Ci8vbS4G00VmYy/XpaV9UY8ZzQP/4NF
         X5UTTTXUaqGGNoOfzVy7w5Ef5kylSUs63+a5mW/svhU1DLiws7xi5YnZ2A2zoH4yWyIX
         yBhNXHAXFdgq60946UP0w1BnOhPIFH4uMjMb6s6q1Q+Qe05Ss73NtnNfum/+97hEyzu7
         Ws2mxuXfyvXlgg8y+sRmaIF+YyywHnNVSpnzHxKnr1Hy2RUylDaphmqcvHIUiSK0M/1h
         K72kYQaDs17epgIT15sck27TxV5ChHNmEYqDbXhhBZzs4z1/C8HOylyso9tIrzr3JtkY
         YQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHXEBUu03ZPDI2Y2TmpsJOeJIjzDeMVBiDxI7vjmsio=;
        b=5iKRLJZo5ZioETkFEmaMqqcae9cgusvlRSYw0K9Bh6MDJGyDmuKaArsWgsdzJRqkfC
         7ObRq+fjkNhUGaOdTKiUXayQGNfr4+uoP0pVt3oGY+iAAW1lZKS57FcvXq4f9gbuI2dF
         591sgYYBNMKKS3Weh0wOf/rUu+hSGsGBnyj41onTbhzUe7pasbgNcUzcK3KbrMri3Mss
         tkizT4yZKDrHrqK4eOOv/gfk7qNRjl/gublgrMBbSMXM2JFUe1RYKPvwamkiL/Seh7EK
         rVJ/W58GToxB0bbvZasjagLcv3ENj86mTgx8c35Nr8y9H+eScXuh1vE4sE1MXfToLtWF
         n0TA==
X-Gm-Message-State: AAQBX9eyYsZGvb/GNQHigv3IT0jjADGuMRzkYX1V7tCTPJm+xhT2zmbc
        xMM1lImSx5r3kOOMpWUro2q7yA==
X-Google-Smtp-Source: AKy350YK/GZj9d6N44hQ/eTmvOypMDIkei2W2xWccEP+HB2eDd1sK/Es/XgfY1iaTzEh7QLs2ntpog==
X-Received: by 2002:aa7:c1c9:0:b0:4fd:20ee:225d with SMTP id d9-20020aa7c1c9000000b004fd20ee225dmr197136edp.24.1680628953652;
        Tue, 04 Apr 2023 10:22:33 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/40] of: Move of_modalias() to module.c
Date:   Tue,  4 Apr 2023 18:21:17 +0100
Message-Id: <20230404172148.82422-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Create a specific .c file for OF related module handling.
Move of_modalias() inside as a first step.

The helper is exposed through of.h even though it is only used by core
files because the users from device.c will soon be split into an OF-only
helper in module.c as well as a device-oriented inline helper in
of_device.h. Putting this helper in of_private.h would require to
include of_private.h from of_device.h, which is not acceptable.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

