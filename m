Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D45EADEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiIZRRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiIZRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:16:27 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8B5A00C0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d15so4423730qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B1QW5eCktyNKF1Kabrt/RgSIFVK+r7/SbP4DaTVv7K4=;
        b=d7gn2HAZ+PGb56creHLgYNBjodWdBqZoFgsWTEONx9vRjml/rKhETmKRRDAmLou88I
         c+KiEcxKJB3gTeZ3XMO368gSrI88twp3lo2SzEKbbPAzKQZ4JjMQsucdJIOU0Ym6bbwM
         kk9C4o2BkJsG0L+EgPBXLhQ+VdKxJcmQzwqhHDVtytcNhECCp8Q/1swxaL4KcH5kbe5Y
         J/y5S0YSL31umVAieiyrzWrOOvooNjo3cgng2hwfw/L1vLgDdJfH8CHTF7tqC7RtjM2L
         UQNwRm+ArC/7A4mnDNyWBEV9C5ivsoTg/ZXJ6U4Oo7OWyDLnIaY/3VcqKwc/MZlSdtcu
         1f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B1QW5eCktyNKF1Kabrt/RgSIFVK+r7/SbP4DaTVv7K4=;
        b=MGjGVfO1IG9eqMLiW/AzfXan5tIcr/ssDEWB4DWP9Z0AHyd3om99rH+ZgtyHezQ/Zz
         BG3zeF3kyfEKtrnZSHrDLkWapTMpJB6cOvLrGDalzCOGoA8aes7qBlawOYSOo4TD8tL8
         TIqeGsV5685+HUqnsbtUgrAn5owvp2FkDo3Ek/zLCUzf3wl3sBuVnFizK9ARMsTVgJ5x
         23TOM0j7wAW3Eurp/uK5R8BAkfiTKPf5ncHkM6gGwrRl7UP6Thxl2T674Rf6fxJvMuQL
         OJ8ENpqTZYUFCTTNEFBSsL6xkUK4FS4eTEK/SGCJBjUB323l6r81coIBquF6c+nSdDB4
         ARdg==
X-Gm-Message-State: ACrzQf0fjREVWB6Kf/dw7X1c7X3WWUQR2mExO2ZTjuDtl5A7ItXDlFGK
        NrlpmPC7ShAIMt6EDDSW4yqZxCjwjQzZ4g==
X-Google-Smtp-Source: AMsMyM4mle6RHfPO4aTaKiS0KfOGTfVzwzJ4/kaQ2WeIuoPe7f2QgOeFfdkcFxW6adfRdPXK9jmr9g==
X-Received: by 2002:a37:c8c:0:b0:6cf:1cba:d8ea with SMTP id 134-20020a370c8c000000b006cf1cbad8eamr14449659qkm.762.1664209816661;
        Mon, 26 Sep 2022 09:30:16 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 139-20020a370a91000000b006ce60296f97sm11542146qkk.68.2022.09.26.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:30:16 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v6 4/5] counter: Consolidate Counter extension sysfs attribute creation
Date:   Mon, 26 Sep 2022 11:16:37 -0400
Message-Id: <6f2121cf52073028c119dbf981a8b72f3eb625d2.1664204990.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664204990.git.william.gray@linaro.org>
References: <cover.1664204990.git.william.gray@linaro.org>
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
index e5dd36e1a45f..b393da402e0b 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -592,6 +592,46 @@ static int counter_comp_id_attr_create(struct device *const dev,
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
@@ -605,8 +645,6 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -620,21 +658,9 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
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
@@ -719,8 +745,6 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -743,21 +767,9 @@ static int counter_count_attrs_create(struct counter_device *const counter,
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
@@ -850,8 +862,6 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	const enum counter_scope scope = COUNTER_SCOPE_DEVICE;
 	struct device *const dev = &counter->dev;
 	int err;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -888,19 +898,9 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
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

