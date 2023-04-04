Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168C6D6A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjDDRXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjDDRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DC4687
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so133632969edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0yKnw9nXKYVaFHn5olSAf00S375pzRbEb0HhrzPylE=;
        b=d/vq4KgvL2/h/ziRCZW1cqyulvHodNQXjKQwHAOT1K76ObCCR5b5FjbqxG8JTUXNFI
         k/FnMf5tNUjxKJQaGuJGhu36t4xYrTFlJkpjpVpdI0e6QPoV28RknJJqDfStpLqVU5JZ
         UAPilvg8Z3+gX3e4zaOy2NjHBS67QwyeehB6bm3i/Rs8zkFESEeplqe3oiwuqI6DoO5Y
         EpukhA2vzPf98mwHtQG3q1fGkZqC+FNNteWf/P3V3sGyzSNN3MPNr4zOHKMmoNRy4LZm
         ePCsbFlBQiiqkU3KMOveRk/460hqLTMOEtyT4DIHnQkRv7HXXIt4spVsiThLgYLZ1okp
         r5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0yKnw9nXKYVaFHn5olSAf00S375pzRbEb0HhrzPylE=;
        b=h2KmgTx0qvISLQjXQlK+tCwF6WFPujI2btbcNFJftUm6poS2yUdiqxCwqp/XBOlrZw
         05d/e68AevSCXbSVEXnEwC1P00JN/c7irKcZMbNCyb+1S6Ju+qXxSQ0/uRuybBxZyV+I
         bjC9WX9F3lQ/Pi70zPdUaA07PxxNK0pH+rVTO4UAQeK17GudrgreFHyRST+8NwaOIxj3
         ikjS34uZ7Ympak4cXvnyEPuOXsm2gsS2ZTDIDsRJUBsIHDdjcOmUcpCr+8ktQAo10+Yh
         UwunEOb4sr9chsCft0cYVl2gKpkMkRcz4uq1/IEyWlQ2MEfw5IIbBkvMXQfEWuBtrpSB
         Rcsw==
X-Gm-Message-State: AAQBX9fcWQMBvsDk3ml2vyd7cEPeIgRmag/rBPksQE/KR0XfMr3gaOZe
        RkE0wvmAtAsuQT/HhfWlWoklCaSMPicPleK0mzQ=
X-Google-Smtp-Source: AKy350YTG31WbJATDfw4xGE11Wbbtm/w2I4xRJabYhCZVBWP8duVGW3AqT/TS57WNnr0MEJiFNX3Rg==
X-Received: by 2002:aa7:c64a:0:b0:4fd:1f7b:9fbd with SMTP id z10-20020aa7c64a000000b004fd1f7b9fbdmr62683edr.6.1680628955044;
        Tue, 04 Apr 2023 10:22:35 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/40] of: Move the request module helper logic to module.c
Date:   Tue,  4 Apr 2023 18:21:18 +0100
Message-Id: <20230404172148.82422-11-srinivas.kandagatla@linaro.org>
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

Depending on device.c for pure OF handling is considered
backwards. Let's extract the content of of_device_request_module() to
have the real logic under module.c.

The next step will be to convert users of of_device_request_module() to
use the new helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

