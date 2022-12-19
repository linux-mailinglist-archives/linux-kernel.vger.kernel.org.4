Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87F6516D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiLSXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiLSXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:46:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F9D101FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id co23so10240494wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/nQc9F2ybSBykdgEFS8tw/oKByW2ekwPZG/Qs1Xn9Q=;
        b=ltJXYl+YIy3/3A8vEoRl324rvpU3f7d7jbOPQ2stjQJwr7WggpjpdD20PfJAs02rlX
         J3swFy/xAGIdzI+wfmxmnDALBQeNy9dVZLI79kNsf8umwD9se+Z5vPA8c5WBYm6xiFT9
         vuUqUMJCdUkOvGe0zZgM1FqtLyFZDzclxXSMzrZryDXI+Zb3up+X4CsM9XMJ86sGYC7r
         g230j2JCt8T2b9NysxfNlHnBOJ3KO17BzvKWVx+U6LFe84vZPL3kcwW0oltSLFwrBH7X
         pS4KMl6Ct8t6pVpwpViOg2gr9kqwPu7ZA5Cj0gY0C9kxj8h4h7HMvQ0M0/qimBsvcrZY
         SeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/nQc9F2ybSBykdgEFS8tw/oKByW2ekwPZG/Qs1Xn9Q=;
        b=zriGfoQpElRQc8PZdn/DBvw9fCtve7xeyIs0EvZ8HV+imfRI0xxkfucIr2BjpAQUUo
         ISdoNFzYb/KPHjGf6+020ma7c8+y1QoVei6J+scfEfk+SYy6WpKPBCpb0N0PduiycsvW
         HhAGJu0m+K68xK9u65RClm3II2UeaYLB/MtZk7Frn8KBSrZOsfSIeuXWayrNb/n1k0dF
         Iim+pZQaQr03iFS7hWrP3s4tn5RiTz7tYo8AN30cNgJMH+qSbSoB2bscxlzF4iMh48Zb
         FsWu1hF2/yv6w81haVdjOLJfau1+L5puAgjRvuqNuNwx9IK4aOoPw306bSMUi2NfWSY3
         c+bQ==
X-Gm-Message-State: ANoB5pnwEsYyQEEK6Pq10k1TUfexsD9DEu+odURRCne6p2fy0bgz31Cz
        ivoxZoddy313vVu+mMwpz/Fpmw==
X-Google-Smtp-Source: AA0mqf65WP1GK6vt5nZX2zyXxDUgR+OTJIvBRZXkM5zsNQx9IDFliyP4i6mjtAK29zCC+MsWG19Nqg==
X-Received: by 2002:a5d:4152:0:b0:24f:11eb:2988 with SMTP id c18-20020a5d4152000000b0024f11eb2988mr22617150wrq.71.1671493607092;
        Mon, 19 Dec 2022 15:46:47 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:bce1:4a06:7ceb:6940])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b002383fc96509sm11165148wrt.47.2022.12.19.15.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:46:46 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 4/6] coresight: configfs: Modify config files to allow userspace use
Date:   Mon, 19 Dec 2022 23:46:36 +0000
Message-Id: <20221219234638.3661-5-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219234638.3661-1-mike.leach@linaro.org>
References: <20221219234638.3661-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update coresight-config.h and the coresight-config-file.c & .h
to allow use in userspace programs.

Use __KERNEL__ defines to filter out driver only structures and
elements so that user space programs can use the descriptor structures.

Abstract memory allocation in coresight-config-file.c to allow read
file functions to be run in userspace and kernel drivers.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-config-file.c         | 117 +++++++++++++-----
 .../hwtracing/coresight/coresight-config.h    |  12 ++
 2 files changed, 101 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config-file.c b/drivers/hwtracing/coresight/coresight-config-file.c
index be11261e3a14..cf9f178eef97 100644
--- a/drivers/hwtracing/coresight/coresight-config-file.c
+++ b/drivers/hwtracing/coresight/coresight-config-file.c
@@ -7,6 +7,63 @@
 #include "coresight-config.h"
 #include "coresight-config-file.h"
 
+/*
+ * To allow reuse of this source in tools, define memory allocation fns according
+ * to build environment.
+ */
+
+#ifdef __KERNEL__
+
+static void *cscfg_calloc(size_t num, size_t size)
+{
+	return kcalloc(num, size, GFP_KERNEL);
+}
+
+static char *cscfg_strdup(const char *str)
+{
+	return kstrdup(str, GFP_KERNEL);
+}
+
+static void *cscfg_zalloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+static void cscfg_free(void *mem)
+{
+	kfree(mem);
+}
+#else
+
+#include <stddef.h>
+#include <string.h>
+#include <stdlib.h>
+
+static void *cscfg_calloc(size_t num, size_t size)
+{
+	return calloc(num, size);
+}
+
+static char *cscfg_strdup(const char *str)
+{
+	return strdup(str);
+}
+
+static void *cscfg_zalloc(size_t size)
+{
+	void *ptr = malloc(size);
+
+	if (ptr)
+		memset(ptr, 0, size);
+	return ptr;
+}
+
+static void cscfg_free(void *mem)
+{
+	free(mem);
+}
+#endif
+
 #define cscfg_extract_u64(val64) { \
 	val64 = *(u64 *)(buffer + used); \
 	used += sizeof(u64); \
@@ -80,6 +137,7 @@ static int cscfg_file_read_elem_str(const u8 *buffer, const int buflen, int *buf
 				    struct cscfg_file_elem_str *elem_str)
 {
 	int used = *buf_used;
+	const u8 *str;
 
 	if ((buflen - used) < sizeof(u16))
 		return -EINVAL;
@@ -89,11 +147,13 @@ static int cscfg_file_read_elem_str(const u8 *buffer, const int buflen, int *buf
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
@@ -104,12 +164,13 @@ static int cscfg_file_alloc_desc_arrays(struct cscfg_fs_load_descs *desc_arrays,
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
@@ -124,24 +185,24 @@ static void cscfg_file_free_config_desc(struct cscfg_config_desc *config_desc)
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
 
 static int cscfg_file_read_elem_config(const u8 *buffer, const int buflen, int *buf_used,
@@ -166,7 +227,7 @@ static int cscfg_file_read_elem_config(const u8 *buffer, const int buflen, int *
 		return 0;
 
 	/* we have a config - allocate the descriptor */
-	config_desc = kzalloc(sizeof(struct cscfg_config_desc), GFP_KERNEL);
+	config_desc = cscfg_zalloc(sizeof(struct cscfg_config_desc));
 	if (!config_desc)
 		return -ENOMEM;
 
@@ -192,7 +253,7 @@ static int cscfg_file_read_elem_config(const u8 *buffer, const int buflen, int *
 	/* read the array of 64bit presets if present */
 	nr_preset_vals = config_desc->nr_total_params * config_desc->nr_presets;
 	if (nr_preset_vals) {
-		presets = kcalloc(nr_preset_vals, sizeof(u64), GFP_KERNEL);
+		presets = cscfg_calloc(nr_preset_vals, sizeof(u64));
 		if (!presets)
 			return -ENOMEM;
 
@@ -207,8 +268,8 @@ static int cscfg_file_read_elem_config(const u8 *buffer, const int buflen, int *
 
 	/* read the array of feature names referenced by the config */
 	if (config_desc->nr_feat_refs) {
-		config_desc->feat_ref_names = kcalloc(config_desc->nr_feat_refs,
-						      sizeof(char *), GFP_KERNEL);
+		config_desc->feat_ref_names = cscfg_calloc(config_desc->nr_feat_refs,
+							   sizeof(char *));
 		if (!config_desc->feat_ref_names)
 			return -ENOMEM;
 
@@ -289,17 +350,17 @@ static void cscfg_file_free_feat_desc(struct cscfg_feature_desc *feat_desc)
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
 
 static int cscfg_file_read_elem_feature(const u8 *buffer, const int buflen, int *buf_used,
@@ -314,7 +375,7 @@ static int cscfg_file_read_elem_feature(const u8 *buffer, const int buflen, int
 	u32 val32;
 
 	/* allocate the feature descriptor object */
-	feat_desc = kzalloc(sizeof(struct cscfg_feature_desc), GFP_KERNEL);
+	feat_desc = cscfg_zalloc(sizeof(struct cscfg_feature_desc));
 	if (!feat_desc)
 		return -ENOMEM;
 
@@ -353,8 +414,8 @@ static int cscfg_file_read_elem_feature(const u8 *buffer, const int buflen, int
 		nr_regs_bytes = ((sizeof(u32) + sizeof(u64)) * feat_desc->nr_regs);
 		if ((buflen - used) < nr_regs_bytes)
 			return -EINVAL;
-		feat_desc->regs_desc = kcalloc(feat_desc->nr_regs,
-					       sizeof(struct cscfg_regval_desc), GFP_KERNEL);
+		feat_desc->regs_desc = cscfg_calloc(feat_desc->nr_regs,
+						    sizeof(struct cscfg_regval_desc));
 		if (!feat_desc->regs_desc)
 			return -ENOMEM;
 
@@ -368,8 +429,8 @@ static int cscfg_file_read_elem_feature(const u8 *buffer, const int buflen, int
 
 	/* parameter descriptors - string + 64 bit value */
 	if (feat_desc->nr_params) {
-		feat_desc->params_desc = kcalloc(feat_desc->nr_params,
-						 sizeof(struct cscfg_parameter_desc), GFP_KERNEL);
+		feat_desc->params_desc = cscfg_calloc(feat_desc->nr_params,
+						      sizeof(struct cscfg_parameter_desc));
 		if (!feat_desc->params_desc)
 			return -ENOMEM;
 		for (i = 0; i < feat_desc->nr_params; i++) {
@@ -515,6 +576,6 @@ void cscfg_file_free_load_descs(struct cscfg_fs_load_descs *desc_arrays)
 	}
 
 	/* finally free up the load descs pointer arrays */
-	kfree(desc_arrays->config_descs);
-	kfree(desc_arrays->feat_descs);
+	cscfg_free(desc_arrays->config_descs);
+	cscfg_free(desc_arrays->feat_descs);
 }
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index ad212954f99e..58d4f179ff0d 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -7,7 +7,14 @@
 #ifndef _CORESIGHT_CORESIGHT_CONFIG_H
 #define _CORESIGHT_CORESIGHT_CONFIG_H
 
+/*
+ * Filter out kernel only portions of the file to allow user space programs
+ * to use the descriptor definitions.
+ */
+#ifdef __KERNEL__
 #include <linux/coresight.h>
+#endif
+
 #include <linux/types.h>
 
 /* CoreSight Configuration Management - component and system wide configuration */
@@ -100,6 +107,10 @@ struct cscfg_fs_load_descs {
 	struct cscfg_feature_desc **feat_descs;
 };
 
+
+/* remainder of header is used by the kernel drivers only */
+#ifdef __KERNEL__
+
 /**
  * Device feature descriptor - combination of registers and parameters to
  * program a device to implement a specific complex function.
@@ -274,4 +285,5 @@ void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev);
 /* reset a feature to default values */
 void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
 
+#endif /* __KERNEL__ */
 #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
-- 
2.17.1

