Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5C6FEBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbjEKGxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjEKGxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:53:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7205B8B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f41d087bd3so36655345e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788018; x=1686380018;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KufGNqo65itbtJV3rnh/P/Cd+7Use3BzqsEUJeyfZoI=;
        b=a3p9JbJfiX/nQDvzxZeTxtzNbc2/q9Nx6SwGnAJ3wuAa3s4FnoE17U/75F1Lmd8cj/
         10KRCepQI9tUeWi53VDLI+imYqf69hjkuE304JPI8BNC07hIj98KhK1+W7nwcVAGjais
         3+IWon6P1viLfYOqFlHFdOOUIjAfDIgnR35f1HBYwIKLXAafSN8BaYfAqMsJtgUNY3Vm
         1mrNxcX9IUj5RTK/RA8g2o3XGyJXGuHlc24gIZv7nBjQ/WPKZxsdXDjo0ugg3yxLKbF0
         RG5noc6kUngUXpGbWIvsefweT4ZoFFbb8PdfMqdZJHS5lYjVviP6aR6sPilCkVeGiua0
         5l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788018; x=1686380018;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KufGNqo65itbtJV3rnh/P/Cd+7Use3BzqsEUJeyfZoI=;
        b=cViKjkF8I4DV25nrT/vnoyFgLfPP46USrMMBwJU4i3kXvM0G8S00G1krC9D02jmLuy
         TcXsRjRb1Pd0qq8UyjzBuuiNyZ2d9FmM1v33NIxS4gr2MGdUucC4VLIVPXFzXWpIxyAY
         +yr4/SjuGJ6WXAI3cdvzUY3wnSg/LPBk610oVWPCN5ZsCWDig3XfX5CXPOWFcbYLGRx6
         bJOoCZqwGgtFyfftQcr4osgz7s9oREr3i/ESHhhw1DX/k9RzTTQQwIpCmYMtxk4n9gH0
         picuOcul9WJ2lU9mVZQME9jEVN3DIoA8LhkZlSxeyfDh0vb17OVhvQyP/Qrap537Qqmk
         lR9Q==
X-Gm-Message-State: AC+VfDxhR5496usWaMMe4FNw61uq8ROVT5haifPAeGwGXvf09GwbYFhx
        chw4RcBoBhtGK06PRj48snNH3A==
X-Google-Smtp-Source: ACHHUZ6sLFuUaq1Qt/uxkefsqLLZUmA8Ta5q8GIxJ0EcW8q6bkNZLTmzwQbTAFNNfMMGzhEDAcWlzQ==
X-Received: by 2002:a7b:c8c6:0:b0:3f4:2220:28d5 with SMTP id f6-20020a7bc8c6000000b003f4222028d5mr9949577wml.29.1683788017635;
        Wed, 10 May 2023 23:53:37 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:3110:8b33:cdf9:dea0])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm1038257wml.46.2023.05.10.23.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:53:37 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 4/6] coresight: config: extract shared structures to common header file
Date:   Thu, 11 May 2023 07:53:28 +0100
Message-Id: <20230511065330.26392-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511065330.26392-1-mike.leach@linaro.org>
References: <20230511065330.26392-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract shared user space and kernel common structures from
coresight-config.h into common header file coresight-config-desc.h

Abstract memory allocation in coresight-config-table.c to allow read
table functions to be run in userspace and kernel drivers.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-config-desc.h         | 105 ++++++++++++++++
 .../coresight/coresight-config-table.c        |  66 +++++-----
 .../hwtracing/coresight/coresight-config.h    | 119 ++++--------------
 3 files changed, 165 insertions(+), 125 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-desc.h

diff --git a/drivers/hwtracing/coresight/coresight-config-desc.h b/drivers/hwtracing/coresight/coresight-config-desc.h
new file mode 100644
index 000000000000..4a487743d7e2
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config-desc.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_CONFIG_DESC_H
+#define _CORESIGHT_CORESIGHT_CONFIG_DESC_H
+
+/* Coresight Descriptors common to kernel and userspace applications */
+/*
+ * Register type flags for register value descriptor:
+ * describe how the value is interpreted, and handled.
+ */
+#define CS_CFG_REG_TYPE_STD		0x80	/* reg is standard reg */
+#define CS_CFG_REG_TYPE_RESOURCE	0x40	/* reg is a resource */
+#define CS_CFG_REG_TYPE_VAL_PARAM	0x08	/* reg value uses param */
+#define CS_CFG_REG_TYPE_VAL_MASK	0x04	/* reg value bit masked */
+#define CS_CFG_REG_TYPE_VAL_64BIT	0x02	/* reg value 64 bit */
+#define CS_CFG_REG_TYPE_VAL_SAVE	0x01	/* reg value save on disable */
+
+/*
+ * flags defining what device class a feature will match to when processing a
+ * system configuration - used by config data and devices.
+ */
+#define CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
+#define CS_CFG_MATCH_CLASS_SRC_ETM4	0x0002	/* match any ETMv4 device */
+
+/* flags defining device instance matching - used in config match desc data. */
+#define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
+
+/*
+ * Limit number of presets in a configuration
+ * This is related to the number of bits (4) we use to select the preset on
+ * the perf command line. Preset 0 is always none selected.
+ * See PMU_FORMAT_ATTR(preset, "config:0-3") in coresight-etm-perf.c
+ */
+#define CS_CFG_CONFIG_PRESET_MAX 15
+
+/**
+ * Parameter descriptor for a device feature.
+ *
+ * @name:  Name of parameter.
+ * @value: Initial or default value.
+ */
+struct cscfg_parameter_desc {
+	const char *name;
+	u64 value;
+};
+
+/**
+ * Representation of register value and a descriptor of register usage.
+ *
+ * Used as a descriptor in the feature descriptors.
+ * Used as a value in when in a feature loading into a csdev.
+ *
+ * Supports full 64 bit register value, or 32 bit value with optional mask
+ * value.
+ *
+ * @type:	define register usage and interpretation.
+ * @offset:	the address offset for register in the hardware device (per device specification).
+ * @hw_info:	optional hardware device type specific information. (ETM / CTI specific etc)
+ * @val64:	64 bit value.
+ * @val32:	32 bit value.
+ * @mask32:	32 bit mask when using 32 bit value to access device register - if mask type.
+ * @param_idx:	parameter index value into parameter array if param type.
+ */
+struct cscfg_regval_desc {
+	struct {
+		u32 type:8;
+		u32 offset:12;
+		u32 hw_info:12;
+	};
+	union {
+		u64 val64;
+		struct {
+			u32 val32;
+			u32 mask32;
+		};
+		u32 param_idx;
+	};
+};
+
+/**
+ * Dynamically loaded descriptor arrays.
+ *
+ * For builtin or module loaded configurations / features these are
+ * statically defined at compile time.
+
+ * For a dynamic load at runtime, using a config table, (e.g. load from
+ * configfs) we create the arrays dynamically so need a structure to
+ * manage these.
+ *
+ * @config_descs: array of config descriptor pointers.
+ * @feat_descs:	  array of feature descriptor pointers.
+ * @load_name:	  user readable name which may be used to unload later.
+ *		  Will be name of first config if present, or first feature.
+ */
+struct cscfg_table_load_descs {
+	struct cscfg_config_desc **config_descs;
+	struct cscfg_feature_desc **feat_descs;
+	char *load_name;
+};
+
+#endif  /* _CORESIGHT_CORESIGHT_CONFIG_DESC_H */
diff --git a/drivers/hwtracing/coresight/coresight-config-table.c b/drivers/hwtracing/coresight/coresight-config-table.c
index 0a8f017d76d2..6216dffc9f9e 100644
--- a/drivers/hwtracing/coresight/coresight-config-table.c
+++ b/drivers/hwtracing/coresight/coresight-config-table.c
@@ -79,6 +79,7 @@ static int cscfg_table_read_elem_str(const u8 *buffer, const int buflen, int *bu
 				     struct cscfg_table_elem_str *elem_str)
 {
 	int used = *buf_used;
+	const u8 *str;
 
 	if ((buflen - used) < sizeof(u16))
 		return -EINVAL;
@@ -88,11 +89,13 @@ static int cscfg_table_read_elem_str(const u8 *buffer, const int buflen, int *bu
 	if ((buflen - used) < elem_str->str_len)
 		return -EINVAL;
 
+	str = buffer + used;
+
 	/* check for 0 termination */
-	if (buffer[used + (elem_str->str_len - 1)] != 0)
+	if (str[elem_str->str_len - 1] != 0)
 		return -EINVAL;
 
-	elem_str->str = kstrdup((char *)(buffer + used),  GFP_KERNEL);
+	elem_str->str = cscfg_strdup((char *)str);
 	used += elem_str->str_len;
 
 	*buf_used = used;
@@ -103,12 +106,13 @@ static int cscfg_table_alloc_desc_arrays(struct cscfg_table_load_descs *desc_arr
 					 int nr_features, int nr_configs)
 {
 	/* arrays are 0 terminated - nr_configs & nr_features elements */
-	desc_arrays->config_descs = kcalloc(nr_configs + 1,  sizeof(struct cscfg_config_desc *),
-					    GFP_KERNEL);
+	desc_arrays->config_descs = cscfg_calloc(nr_configs + 1,
+						 sizeof(struct cscfg_config_desc *));
 	if (!desc_arrays->config_descs)
 		return -ENOMEM;
-	desc_arrays->feat_descs = kcalloc(nr_features + 1, sizeof(struct cscfg_feature_desc *),
-					  GFP_KERNEL);
+
+	desc_arrays->feat_descs = cscfg_calloc(nr_features + 1,
+					       sizeof(struct cscfg_feature_desc *));
 	if (!desc_arrays->feat_descs)
 		return -ENOMEM;
 	return 0;
@@ -123,24 +127,24 @@ static void cscfg_table_free_config_desc(struct cscfg_config_desc *config_desc)
 		return;
 
 	/* free presets */
-	kfree(config_desc->presets);
+	cscfg_free((void *)config_desc->presets);
 
 	/* free feat ref strings */
 	if (config_desc->nr_feat_refs) {
 		/* each string */
 		for (i = 0; i < config_desc->nr_feat_refs; i++)
-			kfree(config_desc->feat_ref_names[i]);
+			cscfg_free((void *)config_desc->feat_ref_names[i]);
 
 		/* and the char * array */
-		kfree(config_desc->feat_ref_names);
+		cscfg_free((void *)config_desc->feat_ref_names);
 	}
 
 	/* next the strings */
-	kfree(config_desc->name);
-	kfree(config_desc->description);
+	cscfg_free((void *)config_desc->name);
+	cscfg_free((void *)config_desc->description);
 
 	/* finally the struct itself */
-	kfree(config_desc);
+	cscfg_free((void *)config_desc);
 }
 
 static int cscfg_table_read_elem_config(const u8 *buffer, const int buflen, int *buf_used,
@@ -165,7 +169,7 @@ static int cscfg_table_read_elem_config(const u8 *buffer, const int buflen, int
 		return 0;
 
 	/* we have a config - allocate the descriptor */
-	config_desc = kzalloc(sizeof(struct cscfg_config_desc), GFP_KERNEL);
+	config_desc = cscfg_zalloc(sizeof(struct cscfg_config_desc));
 	if (!config_desc)
 		return -ENOMEM;
 
@@ -177,7 +181,7 @@ static int cscfg_table_read_elem_config(const u8 *buffer, const int buflen, int
 
 	/* allocate load name if not set */
 	if (!desc_arrays->load_name)
-		desc_arrays->load_name = kstrdup(config_desc->name, GFP_KERNEL);
+		desc_arrays->load_name = cscfg_strdup(config_desc->name);
 
 	/* read the description string */
 	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
@@ -195,7 +199,7 @@ static int cscfg_table_read_elem_config(const u8 *buffer, const int buflen, int
 	/* read the array of 64bit presets if present */
 	nr_preset_vals = config_desc->nr_total_params * config_desc->nr_presets;
 	if (nr_preset_vals) {
-		presets = kcalloc(nr_preset_vals, sizeof(u64), GFP_KERNEL);
+		presets = cscfg_calloc(nr_preset_vals, sizeof(u64));
 		if (!presets)
 			return -ENOMEM;
 
@@ -210,8 +214,8 @@ static int cscfg_table_read_elem_config(const u8 *buffer, const int buflen, int
 
 	/* read the array of feature names referenced by the config */
 	if (config_desc->nr_feat_refs) {
-		config_desc->feat_ref_names = kcalloc(config_desc->nr_feat_refs,
-						      sizeof(char *), GFP_KERNEL);
+		config_desc->feat_ref_names = cscfg_calloc(config_desc->nr_feat_refs,
+							   sizeof(char *));
 		if (!config_desc->feat_ref_names)
 			return -ENOMEM;
 
@@ -255,17 +259,17 @@ static void cscfg_table_free_feat_desc(struct cscfg_feature_desc *feat_desc)
 		return;
 
 	/* free up the register descriptor array */
-	kfree(feat_desc->regs_desc);
+	cscfg_free((void *)feat_desc->regs_desc);
 
 	/* free up the parameters array */
-	kfree(feat_desc->params_desc);
+	cscfg_free((void *)feat_desc->params_desc);
 
 	/* name and description strings */
-	kfree(feat_desc->name);
-	kfree(feat_desc->description);
+	cscfg_free((void *)feat_desc->name);
+	cscfg_free((void *)feat_desc->description);
 
 	/* finally the struct itself */
-	kfree(feat_desc);
+	cscfg_free((void *)feat_desc);
 }
 
 static int cscfg_table_read_elem_feature(const u8 *buffer, const int buflen, int *buf_used,
@@ -280,7 +284,7 @@ static int cscfg_table_read_elem_feature(const u8 *buffer, const int buflen, int
 	u32 val32;
 
 	/* allocate the feature descriptor object */
-	feat_desc = kzalloc(sizeof(struct cscfg_feature_desc), GFP_KERNEL);
+	feat_desc = cscfg_zalloc(sizeof(struct cscfg_feature_desc));
 	if (!feat_desc)
 		return -ENOMEM;
 
@@ -300,7 +304,7 @@ static int cscfg_table_read_elem_feature(const u8 *buffer, const int buflen, int
 
 	/* allocate load name if not set previously by config  */
 	if (!desc_arrays->load_name)
-		desc_arrays->load_name = kstrdup(feat_desc->name, GFP_KERNEL);
+		desc_arrays->load_name = cscfg_strdup(feat_desc->name);
 
 	/* read the description string */
 	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
@@ -323,8 +327,8 @@ static int cscfg_table_read_elem_feature(const u8 *buffer, const int buflen, int
 		nr_regs_bytes = ((sizeof(u32) + sizeof(u64)) * feat_desc->nr_regs);
 		if ((buflen - used) < nr_regs_bytes)
 			return -EINVAL;
-		feat_desc->regs_desc = kcalloc(feat_desc->nr_regs,
-					       sizeof(struct cscfg_regval_desc), GFP_KERNEL);
+		feat_desc->regs_desc = cscfg_calloc(feat_desc->nr_regs,
+						    sizeof(struct cscfg_regval_desc));
 		if (!feat_desc->regs_desc)
 			return -ENOMEM;
 
@@ -338,8 +342,8 @@ static int cscfg_table_read_elem_feature(const u8 *buffer, const int buflen, int
 
 	/* parameter descriptors - string + 64 bit value */
 	if (feat_desc->nr_params) {
-		feat_desc->params_desc = kcalloc(feat_desc->nr_params,
-						 sizeof(struct cscfg_parameter_desc), GFP_KERNEL);
+		feat_desc->params_desc = cscfg_calloc(feat_desc->nr_params,
+						      sizeof(struct cscfg_parameter_desc));
 		if (!feat_desc->params_desc)
 			return -ENOMEM;
 		for (i = 0; i < feat_desc->nr_params; i++) {
@@ -421,7 +425,7 @@ void cscfg_table_free_load_descs(struct cscfg_table_load_descs *desc_arrays)
 	}
 
 	/* finally free up the load descs pointer arrays */
-	kfree(desc_arrays->config_descs);
-	kfree(desc_arrays->feat_descs);
-	kfree(desc_arrays->load_name);
+	cscfg_free(desc_arrays->config_descs);
+	cscfg_free(desc_arrays->feat_descs);
+	cscfg_free(desc_arrays->load_name);
 }
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index ea3aaf0d129b..8b298e9a3776 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -10,101 +10,10 @@
 #include <linux/coresight.h>
 #include <linux/types.h>
 
-/* CoreSight Configuration Management - component and system wide configuration */
-
-/*
- * Register type flags for register value descriptor:
- * describe how the value is interpreted, and handled.
- */
-#define CS_CFG_REG_TYPE_STD		0x80	/* reg is standard reg */
-#define CS_CFG_REG_TYPE_RESOURCE	0x40	/* reg is a resource */
-#define CS_CFG_REG_TYPE_VAL_PARAM	0x08	/* reg value uses param */
-#define CS_CFG_REG_TYPE_VAL_MASK	0x04	/* reg value bit masked */
-#define CS_CFG_REG_TYPE_VAL_64BIT	0x02	/* reg value 64 bit */
-#define CS_CFG_REG_TYPE_VAL_SAVE	0x01	/* reg value save on disable */
-
-/*
- * flags defining what device class a feature will match to when processing a
- * system configuration - used by config data and devices.
- */
-#define CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
-#define CS_CFG_MATCH_CLASS_SRC_ETM4	0x0002	/* match any ETMv4 device */
-
-/* flags defining device instance matching - used in config match desc data. */
-#define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
-
-/*
- * Limit number of presets in a configuration
- * This is related to the number of bits (4) we use to select the preset on
- * the perf command line. Preset 0 is always none selected.
- * See PMU_FORMAT_ATTR(preset, "config:0-3") in coresight-etm-perf.c
- */
-#define CS_CFG_CONFIG_PRESET_MAX 15
-
-/**
- * Parameter descriptor for a device feature.
- *
- * @name:  Name of parameter.
- * @value: Initial or default value.
- */
-struct cscfg_parameter_desc {
-	const char *name;
-	u64 value;
-};
-
-/**
- * Representation of register value and a descriptor of register usage.
- *
- * Used as a descriptor in the feature descriptors.
- * Used as a value in when in a feature loading into a csdev.
- *
- * Supports full 64 bit register value, or 32 bit value with optional mask
- * value.
- *
- * @type:	define register usage and interpretation.
- * @offset:	the address offset for register in the hardware device (per device specification).
- * @hw_info:	optional hardware device type specific information. (ETM / CTI specific etc)
- * @val64:	64 bit value.
- * @val32:	32 bit value.
- * @mask32:	32 bit mask when using 32 bit value to access device register - if mask type.
- * @param_idx:	parameter index value into parameter array if param type.
- */
-struct cscfg_regval_desc {
-	struct {
-		u32 type:8;
-		u32 offset:12;
-		u32 hw_info:12;
-	};
-	union {
-		u64 val64;
-		struct {
-			u32 val32;
-			u32 mask32;
-		};
-		u32 param_idx;
-	};
-};
-
-/**
- * Dynamically loaded descriptor arrays.
- *
- * For builtin or module loaded configurations / features these are
- * statically defined at compile time.
+/* common descriptor definitions */
+#include "coresight-config-desc.h"
 
- * For a dynamic load at runtime, using a config table, (e.g. load from
- * configfs) we create the arrays dynamically so need a structure to
- * manage these.
- *
- * @config_descs: array of config descriptor pointers.
- * @feat_descs:	  array of feature descriptor pointers.
- * @load_name:	  user readable name which may be used to unload later.
- *		  Will be name of first config if present, or first feature.
- */
-struct cscfg_table_load_descs {
-	struct cscfg_config_desc **config_descs;
-	struct cscfg_feature_desc **feat_descs;
-	char *load_name;
-};
+/* CoreSight Configuration Management - component and system wide configuration */
 
 /**
  * Device feature descriptor - combination of registers and parameters to
@@ -280,4 +189,26 @@ void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev);
 /* reset a feature to default values */
 void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
 
+
+/* Kernel allocators for descriptors in common config table read code  */
+static inline void *cscfg_calloc(size_t num, size_t size)
+{
+	return kcalloc(num, size, GFP_KERNEL);
+}
+
+static inline char *cscfg_strdup(const char *str)
+{
+	return kstrdup(str, GFP_KERNEL);
+}
+
+static inline void *cscfg_zalloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+static inline void cscfg_free(void *mem)
+{
+	kfree(mem);
+}
+
 #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
-- 
2.17.1

