Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0B5BB544
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiIQBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIQBQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:16:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BCBBB68B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h28so17034919qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=u9zxwUyjTnHb6dXIFQytfA/XLHMka2VsioSd5KiJT2E=;
        b=T/Y8ua4PR5ZmLcpi7HRFvkzn7jZk7obT+HVwyyLypu3Z1ZIl0KNujdoZx+z4OmAzz6
         TJQFWdYzFKGCwqKENxHWssZ1PnUs9QDoJ1iorroNn+UAhlCSo7axHpiOVleErxClxdkj
         zqHmSMxa56vFP9BUqzJUtoKsST46cprAjcKIHdnK5B6SotbRg4CKJ6t/0AZ4J7a5wxix
         /C5x7InFB3xbzkY6lhu6IYaExG1dN+d5rSNFufSKyUV1DCOflRlSDCrxLXl37pCDodrb
         PGrYxUXfuoRxQLBl4Zuesq1t4Cq7ZTwU5qTFqX5CLKfax7CUOSlf8DXau8+/ahZGruer
         Vl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u9zxwUyjTnHb6dXIFQytfA/XLHMka2VsioSd5KiJT2E=;
        b=4b+8DoSh2yghLpGpiY/pq6cR/A3+FjkLBOTz9vgJ2Uqdo40o94ShO+Wcf2PLIply61
         Ee3e9dCaQQUJztA22DeDat4eMZG+5xbrv9b95WCJ1ZJuaj1VY3yRUlnZkaUdxUgoMhAA
         xopBwrazIX6/fqoFHDhVTtEUWALMGzXLVKyUG3e6ob96BfQIfsdRV8ehEmzh5/apVq4i
         XYa6y6ZqBOEv/xXJw2bhsEFH7wFv6yMyUrr4iYt6xsmPkbXKifYkN3BTip/ZytTQ5jST
         jrBSNpJobkHSWVMZpOlqAidGZSwcSiCKx0CICfZSl88UlGm2VR/cF8DkxMwwsGxHQsBd
         OKLQ==
X-Gm-Message-State: ACrzQf3N2pvdv20eWr2rq8xwsXOxTXQit7D0Hwh2KUdTqUGGXhbqO1W8
        O39u6293d4Jk78ZLaNx6reQVTA==
X-Google-Smtp-Source: AMsMyM4PhBnQfuUl3GK8Arbg7pQCPy4qG/RQWLpyzNL8rLOEreCkIHmk/WL5P3jjk9yQ2N+MyPcGgQ==
X-Received: by 2002:a37:38d:0:b0:6cd:fd39:10e5 with SMTP id 135-20020a37038d000000b006cdfd3910e5mr5973510qkd.784.1663377393535;
        Fri, 16 Sep 2022 18:16:33 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a440600b006bb87c4833asm8085434qkp.109.2022.09.16.18.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:16:33 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 3/4] counter: Consolidate Counter extension sysfs attribute creation
Date:   Fri, 16 Sep 2022 20:39:27 -0400
Message-Id: <9fa4b496be11ea25aaef2c0515ec80a50827a498.1663372750.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663372750.git.william.gray@linaro.org>
References: <cover.1663372750.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counter extensions are handled for the Device, Counts, and Signals. The
code loops through each Counter extension and creates the expected sysfs
attributes. This patch consolidates that code into functions to reduce
redundancy and make the intention of the code clearer.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-sysfs.c | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 92d3d4f549cb..7ce7c51395da 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -591,6 +591,46 @@ static int counter_comp_id_attr_create(struct device *const dev,
 	return 0;
 }
 
+static int counter_ext_attrs_create(struct device *const dev,
+				    struct counter_attribute_group *const group,
+				    const struct counter_comp *const ext,
+				    const enum counter_scope scope,
+				    void *const parent, const size_t id)
+{
+	int err;
+
+	/* Create main extension attribute */
+	err = counter_attr_create(dev, group, ext, scope, parent);
+	if (err < 0)
+		return err;
+
+	/* Create extension id attribute */
+	return counter_comp_id_attr_create(dev, group, ext->name, id);
+}
+
+static int counter_sysfs_exts_add(struct device *const dev,
+				  struct counter_attribute_group *const group,
+				  const struct counter_comp *const exts,
+				  const size_t num_ext,
+				  const enum counter_scope scope,
+				  void *const parent)
+{
+	size_t i;
+	const struct counter_comp *ext;
+	int err;
+
+	/* Create attributes for each extension */
+	for (i = 0; i < num_ext; i++) {
+		ext = &exts[i];
+		err = counter_ext_attrs_create(dev, group, ext, scope, parent,
+					       i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
 	.name = "signal",
@@ -604,8 +644,6 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -619,21 +657,9 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < signal->num_ext; i++) {
-		ext = &signal->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, signal);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Signal extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, signal->ext,
+				      signal->num_ext, scope, signal);
 }
 
 static int counter_sysfs_signals_add(struct counter_device *const counter,
@@ -718,8 +744,6 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -742,21 +766,9 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < count->num_ext; i++) {
-		ext = &count->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, count);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Count extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, count->ext,
+				      count->num_ext, scope, count);
 }
 
 static int counter_sysfs_counts_add(struct counter_device *const counter,
@@ -849,8 +861,6 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	const enum counter_scope scope = COUNTER_SCOPE_DEVICE;
 	struct device *const dev = &counter->dev;
 	int err;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -887,19 +897,9 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < counter->num_ext; i++) {
-		ext = &counter->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, NULL);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
+	/* Add device extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, counter->ext,
+				      counter->num_ext, scope, NULL);
 
 	return 0;
 }
-- 
2.37.3

