Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC76FEBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjEKGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbjEKGxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:53:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CD4EC6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso37403165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788014; x=1686380014;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpWMvThlfNIMaMhl/rPa62rSrEhuyn8IMP1y7eIgCPE=;
        b=szB/3Odl4sPY8015upRVgMz7tptrckYPyYL3yod3kM6N4U9eYAEOKR24mif050F1db
         JoMTXCd17qAmFhr7R+9gqMcL/iBQscleyIt0K7w3siAPOro/V82kZgyGfWaaefR9T5H4
         KH52Jz5kwBihddvj4UTD3IYlIvKng+VSFnjDqwQZvTTaA8lYU1qrFe+CHBEOJBxJpRip
         kxjTwdHDOHxvNbQrr1RfNa+LReHC3rHJVv1NNiDrqQuJMowE9yuhQAIYcsCJSMTcl9BV
         2SOo9LZQn1zDpq1B7Ov0YXHkfk4vtKoc3oRNfH337MIv6msVfxn+LrXlz1xhaQ/f8zSb
         eevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788014; x=1686380014;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpWMvThlfNIMaMhl/rPa62rSrEhuyn8IMP1y7eIgCPE=;
        b=QtGetbMz/ymoDasrm8Z2Um3WDFNke28KO8Rx5PyUeT7tZrmtm2oB7h5V++TYG/WYjF
         YgVccPz0wzSmnBUF1KGKXvJr88oJOpeCZ7nAqKLHvb+1Z0fWG8fQXoUAGGtjaD1QLgkX
         AJVJ9cY/aWI1xpzh+AeyZ2lvNpGfZa7D1b+U6DcFgchkZEGMeV5YFqx3Ml6ue6dBYQEN
         JN1Ef3hqEGyeDDkOhw9Q/E7yGJQ5ITzDfApU7YwfpqKA194vpkyKuoOdb0V4n+LPDTgE
         qeu8UFxVL0pGTrdwJXDCm2eNbCuC7f2ohmQfMLVSgvLQzd/rTYBPL8OvOEsD9n29x/Qg
         ULRQ==
X-Gm-Message-State: AC+VfDw1SMkfF2Cs3hzRZvMwAVTSRTCGU6ipgoi00IJUDjuIOmqUKNwo
        uZ/MQodBFsW94Tl1ZFIPf1Mvaw==
X-Google-Smtp-Source: ACHHUZ5M2I1MOhdhpSQ48XObwTRgCsvKPl0r1AJjBKrUtZuwHoJ9LSy1YXPovfjHMFsCTCIVGYmWjA==
X-Received: by 2002:a7b:cd11:0:b0:3f4:b6bc:bd93 with SMTP id f17-20020a7bcd11000000b003f4b6bcbd93mr2992004wmj.35.1683788014222;
        Wed, 10 May 2023 23:53:34 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:3110:8b33:cdf9:dea0])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm1038257wml.46.2023.05.10.23.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:53:33 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 1/6] coresight: config: add config table runtime load functionality
Date:   Thu, 11 May 2023 07:53:25 +0100
Message-Id: <20230511065330.26392-2-mike.leach@linaro.org>
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

Introduce a CoreSight configuration table format to allow dynamic
configuration load at runtime.

Define a binary table format and provide a reader for that format
that will create and populate the internal configuration and feature
structures use by the driver infrastructure.

Adds API to access new functionality.

Functionality to be used to load configurations from external sources
at runtime, such as configfs.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../coresight/coresight-config-table.c        | 427 ++++++++++++++++++
 .../coresight/coresight-config-table.h        | 146 ++++++
 .../hwtracing/coresight/coresight-config.h    |  21 +
 4 files changed, 596 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-table.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config-table.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 33bcc3f7b8ae..b282f123582e 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -6,7 +6,8 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
 		coresight-cfg-preload.o coresight-cfg-afdo.o \
-		coresight-syscfg-configfs.o coresight-trace-id.o
+		coresight-syscfg-configfs.o coresight-trace-id.o \
+		coresight-config-table.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight-config-table.c b/drivers/hwtracing/coresight/coresight-config-table.c
new file mode 100644
index 000000000000..0a8f017d76d2
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config-table.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include "coresight-config-table.h"
+
+#define cscfg_extract_u64(val64) { \
+	val64 = *(u64 *)(buffer + used); \
+	used += sizeof(u64); \
+	}
+
+#define cscfg_extract_u32(val32) { \
+	val32 = *(u32 *)(buffer + used); \
+	used += sizeof(u32); \
+	}
+
+#define cscfg_extract_u16(val16) { \
+	val16 = *(u16 *)(buffer + used); \
+	used += sizeof(u16); \
+	}
+
+#define cscfg_extract_u8(val8) { \
+	val8 = *(buffer + used); \
+	used++; \
+	}
+
+static int cscfg_table_read_hdr(const u8 *buffer, const int buflen, int *buf_used,
+				struct cscfg_table_header *hdr)
+{
+	/* table header always at the start of the buffer */
+	int used = 0;
+
+	if (buflen < sizeof(struct cscfg_table_header))
+		return -EINVAL;
+
+	cscfg_extract_u32(hdr->magic_version);
+	if (hdr->magic_version != CSCFG_TABLE_MAGIC_VERSION)
+		return -EINVAL;
+
+	cscfg_extract_u16(hdr->length);
+	if (hdr->length > buflen)
+		return -EINVAL;
+
+	cscfg_extract_u16(hdr->nr_configs);
+	cscfg_extract_u16(hdr->nr_features);
+
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_table_read_elem_hdr(const u8 *buffer, const int buflen, int *buf_used,
+				     struct cscfg_table_elem_header *elem_hdr)
+{
+	int used = *buf_used;
+
+	if ((buflen - used) < (sizeof(u16) + sizeof(u8)))
+		return -EINVAL;
+
+	/* read length and check enough buffer remains for this element */
+	elem_hdr->elem_length = *(u16 *)(buffer + used);
+	if ((buflen - used) < elem_hdr->elem_length)
+		return -EINVAL;
+	/* don't use extract fn as we update used _after_ the comparison */
+	used += sizeof(u16);
+
+	/* read type and validate */
+	cscfg_extract_u8(elem_hdr->elem_type);
+	if ((elem_hdr->elem_type < CSCFG_TABLE_ELEM_TYPE_FEAT) ||
+	    (elem_hdr->elem_type > CSCFG_TABLE_ELEM_TYPE_CFG))
+		return -EINVAL;
+
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_table_read_elem_str(const u8 *buffer, const int buflen, int *buf_used,
+				     struct cscfg_table_elem_str *elem_str)
+{
+	int used = *buf_used;
+
+	if ((buflen - used) < sizeof(u16))
+		return -EINVAL;
+
+	cscfg_extract_u16(elem_str->str_len);
+
+	if ((buflen - used) < elem_str->str_len)
+		return -EINVAL;
+
+	/* check for 0 termination */
+	if (buffer[used + (elem_str->str_len - 1)] != 0)
+		return -EINVAL;
+
+	elem_str->str = kstrdup((char *)(buffer + used),  GFP_KERNEL);
+	used += elem_str->str_len;
+
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_table_alloc_desc_arrays(struct cscfg_table_load_descs *desc_arrays,
+					 int nr_features, int nr_configs)
+{
+	/* arrays are 0 terminated - nr_configs & nr_features elements */
+	desc_arrays->config_descs = kcalloc(nr_configs + 1,  sizeof(struct cscfg_config_desc *),
+					    GFP_KERNEL);
+	if (!desc_arrays->config_descs)
+		return -ENOMEM;
+	desc_arrays->feat_descs = kcalloc(nr_features + 1, sizeof(struct cscfg_feature_desc *),
+					  GFP_KERNEL);
+	if (!desc_arrays->feat_descs)
+		return -ENOMEM;
+	return 0;
+}
+
+/* free up the data allocated to a config desc */
+static void cscfg_table_free_config_desc(struct cscfg_config_desc *config_desc)
+{
+	int i;
+
+	if (!config_desc)
+		return;
+
+	/* free presets */
+	kfree(config_desc->presets);
+
+	/* free feat ref strings */
+	if (config_desc->nr_feat_refs) {
+		/* each string */
+		for (i = 0; i < config_desc->nr_feat_refs; i++)
+			kfree(config_desc->feat_ref_names[i]);
+
+		/* and the char * array */
+		kfree(config_desc->feat_ref_names);
+	}
+
+	/* next the strings */
+	kfree(config_desc->name);
+	kfree(config_desc->description);
+
+	/* finally the struct itself */
+	kfree(config_desc);
+}
+
+static int cscfg_table_read_elem_config(const u8 *buffer, const int buflen, int *buf_used,
+					struct cscfg_table_load_descs *desc_arrays,
+					const int cfg_index)
+{
+	struct cscfg_table_elem_header elem_hdr;
+	struct cscfg_table_elem_str elem_str;
+	struct cscfg_config_desc *config_desc;
+	int used = *buf_used, nr_preset_vals, nr_preset_bytes, i;
+	int err = 0;
+	u64 *presets;
+
+	/*
+	 * read the header - if not config, then don't update buf_used
+	 * pointer on return
+	 */
+	err = cscfg_table_read_elem_hdr(buffer, buflen, &used, &elem_hdr);
+	if (err)
+		return err;
+	if (elem_hdr.elem_type != CSCFG_TABLE_ELEM_TYPE_CFG)
+		return 0;
+
+	/* we have a config - allocate the descriptor */
+	config_desc = kzalloc(sizeof(struct cscfg_config_desc), GFP_KERNEL);
+	if (!config_desc)
+		return -ENOMEM;
+
+	/* read the name string */
+	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	config_desc->name = elem_str.str;
+
+	/* allocate load name if not set */
+	if (!desc_arrays->load_name)
+		desc_arrays->load_name = kstrdup(config_desc->name, GFP_KERNEL);
+
+	/* read the description string */
+	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	config_desc->description = elem_str.str;
+
+	/* read in some values */
+	if ((buflen - used) < sizeof(u64))
+		return -EINVAL;
+	cscfg_extract_u16(config_desc->nr_presets);
+	cscfg_extract_u32(config_desc->nr_total_params);
+	cscfg_extract_u16(config_desc->nr_feat_refs);
+
+	/* read the array of 64bit presets if present */
+	nr_preset_vals = config_desc->nr_total_params * config_desc->nr_presets;
+	if (nr_preset_vals) {
+		presets = kcalloc(nr_preset_vals, sizeof(u64), GFP_KERNEL);
+		if (!presets)
+			return -ENOMEM;
+
+		nr_preset_bytes = sizeof(u64) * nr_preset_vals;
+		if ((buflen - used) < nr_preset_bytes)
+			return -EINVAL;
+
+		memcpy(presets, (buffer + used), nr_preset_bytes);
+		config_desc->presets = presets;
+		used += nr_preset_bytes;
+	}
+
+	/* read the array of feature names referenced by the config */
+	if (config_desc->nr_feat_refs) {
+		config_desc->feat_ref_names = kcalloc(config_desc->nr_feat_refs,
+						      sizeof(char *), GFP_KERNEL);
+		if (!config_desc->feat_ref_names)
+			return -ENOMEM;
+
+		for (i = 0; i < config_desc->nr_feat_refs; i++) {
+			err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
+			if (err)
+				return err;
+			config_desc->feat_ref_names[i] = elem_str.str;
+		}
+	}
+
+	desc_arrays->config_descs[cfg_index] = config_desc;
+	*buf_used = used;
+	return 0;
+}
+
+static int cscfg_table_read_elem_param(const u8 *buffer, const int buflen, int *buf_used,
+				       struct cscfg_parameter_desc *param_desc)
+{
+	struct cscfg_table_elem_str elem_str;
+	int err = 0, used = *buf_used;
+
+	/* parameter name */
+	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	param_desc->name = elem_str.str;
+
+	/* parameter value */
+	if ((buflen - used) < sizeof(u64))
+		return -EINVAL;
+	cscfg_extract_u64(param_desc->value);
+
+	*buf_used = used;
+	return err;
+}
+
+static void cscfg_table_free_feat_desc(struct cscfg_feature_desc *feat_desc)
+{
+	if (!feat_desc)
+		return;
+
+	/* free up the register descriptor array */
+	kfree(feat_desc->regs_desc);
+
+	/* free up the parameters array */
+	kfree(feat_desc->params_desc);
+
+	/* name and description strings */
+	kfree(feat_desc->name);
+	kfree(feat_desc->description);
+
+	/* finally the struct itself */
+	kfree(feat_desc);
+}
+
+static int cscfg_table_read_elem_feature(const u8 *buffer, const int buflen, int *buf_used,
+					 struct cscfg_table_load_descs *desc_arrays,
+					 const int feat_idx)
+{
+	struct cscfg_table_elem_header elem_hdr;
+	struct cscfg_table_elem_str elem_str;
+	struct cscfg_feature_desc *feat_desc;
+	struct cscfg_regval_desc *p_reg_desc;
+	int used = *buf_used, err, i, nr_regs_bytes;
+	u32 val32;
+
+	/* allocate the feature descriptor object */
+	feat_desc = kzalloc(sizeof(struct cscfg_feature_desc), GFP_KERNEL);
+	if (!feat_desc)
+		return -ENOMEM;
+
+	/* read and check the element header */
+	err = cscfg_table_read_elem_hdr(buffer, buflen, &used, &elem_hdr);
+	if (err)
+		return err;
+
+	if (elem_hdr.elem_type != CSCFG_TABLE_ELEM_TYPE_FEAT)
+		return -EINVAL;
+
+	/* read the feature name */
+	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	feat_desc->name = elem_str.str;
+
+	/* allocate load name if not set previously by config  */
+	if (!desc_arrays->load_name)
+		desc_arrays->load_name = kstrdup(feat_desc->name, GFP_KERNEL);
+
+	/* read the description string */
+	err = cscfg_table_read_elem_str(buffer, buflen, &used, &elem_str);
+	if (err)
+		return err;
+	feat_desc->description = elem_str.str;
+
+	/*
+	 * read in some values
+	 * [u32 value: match_flags]
+	 * [u16 value: nr_regs]	    - number of registers.
+	 * [u16 value: nr_params]   - number of parameters.
+	 */
+	cscfg_extract_u32(feat_desc->match_flags);
+	cscfg_extract_u16(feat_desc->nr_regs);
+	cscfg_extract_u16(feat_desc->nr_params);
+
+	/* register descriptors  - 32 bit + 64 bit value */
+	if (feat_desc->nr_regs) {
+		nr_regs_bytes = ((sizeof(u32) + sizeof(u64)) * feat_desc->nr_regs);
+		if ((buflen - used) < nr_regs_bytes)
+			return -EINVAL;
+		feat_desc->regs_desc = kcalloc(feat_desc->nr_regs,
+					       sizeof(struct cscfg_regval_desc), GFP_KERNEL);
+		if (!feat_desc->regs_desc)
+			return -ENOMEM;
+
+		for (i = 0; i < feat_desc->nr_regs; i++) {
+			cscfg_extract_u32(val32);
+			p_reg_desc = (struct cscfg_regval_desc *)&feat_desc->regs_desc[i];
+			CSCFG_TABLE_U32_TO_REG_DESC_INFO(val32, p_reg_desc);
+			cscfg_extract_u64(feat_desc->regs_desc[i].val64);
+		}
+	}
+
+	/* parameter descriptors - string + 64 bit value */
+	if (feat_desc->nr_params) {
+		feat_desc->params_desc = kcalloc(feat_desc->nr_params,
+						 sizeof(struct cscfg_parameter_desc), GFP_KERNEL);
+		if (!feat_desc->params_desc)
+			return -ENOMEM;
+		for (i = 0; i < feat_desc->nr_params; i++) {
+			err = cscfg_table_read_elem_param(buffer, buflen, &used,
+							 &feat_desc->params_desc[i]);
+			if (err)
+				return err;
+		}
+	}
+
+	desc_arrays->feat_descs[feat_idx] = feat_desc;
+	*buf_used = used;
+	return 0;
+}
+
+/*
+ * Read the table from a buffer and create the internal configuration and
+ * feature descriptors to load into the cscfg system
+ */
+int cscfg_table_read_buffer(const u8 *buffer, const int buflen,
+			    struct cscfg_table_load_descs *desc_arrays)
+{
+	struct cscfg_table_header hdr;
+	int used = 0, err, i;
+
+	/* read in the table  header */
+	err = cscfg_table_read_hdr(buffer, buflen, &used, &hdr);
+	if (err)
+		return err;
+
+	/* allocate the memory for the descriptor pointer arrays */
+	err = cscfg_table_alloc_desc_arrays(desc_arrays, hdr.nr_features, hdr.nr_configs);
+	if (err)
+		return err;
+
+	/* read elements */
+
+	/* first elements are configurations */
+	for (i = 0; i < hdr.nr_configs; i++) {
+		err = cscfg_table_read_elem_config(buffer, buflen, &used, desc_arrays, i);
+		if (err)
+			return err;
+	}
+
+	/* now read and populate all the feature descriptors */
+	for (i = 0; i < hdr.nr_features; i++) {
+		err = cscfg_table_read_elem_feature(buffer, buflen, &used, desc_arrays, i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*
+ * Need to free up the dynamically allocated descriptor arrays on unload
+ * as the memory used could be significant if many configurations are loaded
+ * and unloaded while the machine is operational.
+ *
+ * This frees up all the memory allocated by config during the load process.
+ */
+void cscfg_table_free_load_descs(struct cscfg_table_load_descs *desc_arrays)
+{
+	int i = 0;
+
+	if (!desc_arrays)
+		return;
+
+	/* free up each of the config descriptors */
+	while (desc_arrays->config_descs[i]) {
+		cscfg_table_free_config_desc(desc_arrays->config_descs[i]);
+		i++;
+	}
+
+	/* free up each of the feature descriptors */
+	i = 0;
+	while (desc_arrays->feat_descs[i]) {
+		cscfg_table_free_feat_desc(desc_arrays->feat_descs[i]);
+		i++;
+	}
+
+	/* finally free up the load descs pointer arrays */
+	kfree(desc_arrays->config_descs);
+	kfree(desc_arrays->feat_descs);
+	kfree(desc_arrays->load_name);
+}
diff --git a/drivers/hwtracing/coresight/coresight-config-table.h b/drivers/hwtracing/coresight/coresight-config-table.h
new file mode 100644
index 000000000000..2cd8fb0630e2
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-config-table.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_CONFIG_TABLE_H
+#define _CORESIGHT_CORESIGHT_CONFIG_TABLE_H
+
+#include <linux/sizes.h>
+
+#include "coresight-config.h"
+
+/*
+ * Configurations and features can be dynamically loaded at runtime
+ * using a table format that is converted on read into the internal
+ * structures used by the cscfg infrastructure.
+ *
+ * Table structure - for loading configuration(s) + feature(s)
+ * from configfs or other external sources.
+ *
+ * [cscfg_table_header]	- mandatory
+ * [CONFIG_ELEM] * [cscfg_table_header.nr_configs] - optional.
+ * [FEATURE_ELEM] * [cscfg_table_header.nr_features] - optional.
+ *
+ * Table valid if it has both config(s) and feature(s), only config(s)
+ * or only feature(s).
+ *
+ * Invalid table if no config or features.
+ *
+ * Structure for [CONFIG_ELEM]:
+ *
+ * [cscfg_table_elem_header] - header length value to end of feature strings.
+ * [cscfg_table_elem_str]    - name of the configuration
+ * [cscfg_table_elem_str]    - description of configuration
+ * [u16 value - nr_presets] - number of sets of presets supplied
+ * [u32 value - nr_total_params] - total of all params in referenced features
+ * [u16 value - nr_feat_refs] - number of features selected by this configuration
+ * [u64 values] * (nr_presets * nr_total_params)
+ * [cscfg_table_elem_str] * nr_feat_refs - names of features selected by configuration.
+ *
+ *  A configuration must reference at least one feature.
+ *  Referenced features may be in this table, or have been loaded previously.
+ *
+ * Structure for a [FEATURE_ELEM]
+ *
+ * [cscfg_table_elem_header] - header length is total bytes to end of param structures.
+ * [cscfg_table_elem_str]    - feature name.
+ * [cscfg_table_elem_str]    - feature description.
+ * [u32 value: match_flags]
+ * [u16 value: nr_regs]	    - number of registers.
+ * [u16 value: nr_params]   - number of parameters.
+ * [cscfg_regval_desc struct] * nr_regs
+ * [PARAM_ELEM] * nr_params
+ *
+ * Structure for [PARAM_ELEM]
+ *
+ * [cscfg_table_elem_str]    - parameter name.
+ * [u64 value: param_value] - initial value.
+ */
+
+/* major element types - configurations and features */
+
+#define CSCFG_TABLE_ELEM_TYPE_FEAT	0x1
+#define CSCFG_TABLE_ELEM_TYPE_CFG	0x2
+
+#define CSCFG_TABLE_MAGIC_VERSION	0xC5CF0001
+
+#define CSCFG_TABLE_U32_TO_REG_DESC_INFO(val32, p_desc) \
+	{ \
+	p_desc->type = (val32 >> 24) & 0xFF; \
+	p_desc->offset = (val32 >> 12) & 0xFFF; \
+	p_desc->hw_info = val32 & 0xFFF; \
+	}
+
+#define CSCFG_TABLE_REG_DESC_INFO_TO_U32(val32, p_desc) \
+	{ \
+	val32 = p_desc->hw_info & 0xFFF; \
+	val32 |= ((p_desc->offset & 0xFFF) << 12); \
+	val32 |= ((p_desc->type & 0xFF) << 24); \
+	}
+
+/*
+ * Define a maximum size for any configuration table.
+ *
+ * Use a value that will reasonably cover all the usable & programmable
+ * registers in an ETM, the most complex device we have.
+ *
+ * This may also be used for the binary attributes in configfs which need a max
+ * size, as an internal buffer is declared, and will not be exceeded to prevent
+ * kernel OOM errors / attacks.
+ *
+ */
+#define CSCFG_TABLE_MAXSIZE	SZ_16K
+
+/* limit string sizes - used for descriptions and names. */
+#define CSCFG_TABLE_STR_MAXSIZE	SZ_1K
+
+/**
+ * Table header.
+ *
+ * @magic_version: magic number / version for table format.
+ * @length       : total length of all data in the table.
+ * @nr_configs	 : total number of configs in the table.
+ * @nr_features  : total number of features in the table.
+ */
+struct cscfg_table_header {
+	u32 magic_version;
+	u16 length;
+	u16 nr_configs;
+	u16 nr_features;
+};
+
+/**
+ * element header
+ *
+ * @elem_length: total length of this element
+ * @elem_type  : type of this element - one of CSCFG_TABLE_ELEM_TYPE.. defines.
+ */
+struct cscfg_table_elem_header {
+	u16 elem_length;
+	u8 elem_type;
+};
+
+/**
+ * string table element.
+ *
+ * @str_len: length of string buffer including 0 terminator
+ * @str    : string buffer - 0 terminated.
+ */
+struct cscfg_table_elem_str {
+	u16 str_len;
+	char *str;
+};
+
+/*
+ * Read a configuration programming table from the buffer and create the
+ * structures needed to load into the cscfg system
+ */
+int cscfg_table_read_buffer(const u8 *buffer, const int buflen,
+			    struct cscfg_table_load_descs *desc_arrays);
+
+/* on unload we need to free up memory allocated on read */
+void cscfg_table_free_load_descs(struct cscfg_table_load_descs *desc_arrays);
+
+#endif /* _CORESIGHT_CORESIGHT_CONFIG_TABLE_H */
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 6ba013975741..ea3aaf0d129b 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -85,6 +85,27 @@ struct cscfg_regval_desc {
 	};
 };
 
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
 /**
  * Device feature descriptor - combination of registers and parameters to
  * program a device to implement a specific complex function.
-- 
2.17.1

