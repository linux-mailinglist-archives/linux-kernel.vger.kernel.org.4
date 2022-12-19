Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611516516D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiLSXrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLSXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:46:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F46411
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx10so10283931wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iie42nHq9k3iFDJfhGcDb8vJSozvH1LIt1oxk0M/6iM=;
        b=kSpyQ5wQG3Vt6TNZUCIxgR+VHFLp97vv9hPSFraKl93PXIyT/X2No7HKKYsStafTZ8
         x1ewaApF9T3m6eQ4/Fgx81guCM8uh/lpgThZ/7tukX9wg636aN/Bzxh1SrF5YMALgZXH
         /5P07r4HzdR9+j2v1fQmGlUnJOqe8/I3M5wtxLnW1HHq3aCpvy0uPEOGLvpYwo881uty
         jCa83t5zooOiRAxWD26TV6f6eYUI3HMzzMbepsR+YfwDxgXPzpGR6YlKt0XBfcw2Nt0+
         3FAbP6t0Kw5GB3E1JDcF+b7ycM0DXA0gdOK4MneGAsU+WcPJxm7NNYORbpRarXK6iez4
         HiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iie42nHq9k3iFDJfhGcDb8vJSozvH1LIt1oxk0M/6iM=;
        b=0B15nqV4dmWGLFtyKH/zmh4fTee48nYjNMGAiIxpW83tohHZUB7rEr0eW+UNemZB9H
         97P9k1uVMpTat4qL7XgJOW6CoPoyhw8P/G/SHokeNWILjJ8uLlZxQrtAiZQOH9fZbKgC
         2ztXTm7pB36uGKDkDBlnUKAQwy4TVeG4WEzyjAPObtnbPJsBcDxK7U2HAMtWIwxM3HJT
         PJuynrKHd1Wwsc6qbpMMK7Z8Sv4KlBgPH2xOzjizPXeFBt6OK7T/J6sHqBHZ8Ph4+sSR
         2Y0DCJdgEjqsMJFzwyBtnb3EMHmW4Js9XiC0cIYKEm8+CYYRABFD+If2sfV0nsYtloID
         hdtA==
X-Gm-Message-State: ANoB5pnrt/DjUbGDfrvuP0hSlybrqwwZQYDurE2QgIGaXS0Lzb0Zie6e
        5cAqLKx42W6StzLBgQLYl+tHfg==
X-Google-Smtp-Source: AA0mqf7Idgbbi7ajeR8KSLJBbFSYaMxVJpltxpnbrJYUkPHJ2ZZAHqin10e9iFC+mVgxAepnHR0xqQ==
X-Received: by 2002:a5d:4c42:0:b0:242:1551:974f with SMTP id n2-20020a5d4c42000000b002421551974fmr25806345wrt.13.1671493605999;
        Mon, 19 Dec 2022 15:46:45 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:bce1:4a06:7ceb:6940])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b002383fc96509sm11165148wrt.47.2022.12.19.15.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:46:45 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 3/6] coresight: configfs: Add in binary attributes to load files
Date:   Mon, 19 Dec 2022 23:46:35 +0000
Message-Id: <20221219234638.3661-4-mike.leach@linaro.org>
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

Add in functionality and binary attribute to load and unload
configurations as binary data.

Files are loaded via the 'load' binary attribute. System reads the incoming
file, which must be formatted correctly as defined in the file reader code.
This will create configuration(s) and/or feature(s) and load them
into the system.

These will then appear in configfs, in the 'configurations' and 'features'
directories, ready for use.

A mutex is used to prevent load and unload operations from happening
simultaneously. Further, a flag enabling configfs load/unload is
provided, along with API calls to allow this functionality to be
controlled during start-up and shut-down, and when configurations
are loaded via loadable modules.

This ensures that load/unload operations are strictly serialised.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 242 +++++++++++++++++-
 .../coresight/coresight-syscfg-configfs.h     |   4 +
 .../hwtracing/coresight/coresight-syscfg.c    | 137 +++++++++-
 .../hwtracing/coresight/coresight-syscfg.h    |   5 +-
 4 files changed, 374 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 6e8c8db52d39..47b3638d8f23 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -5,10 +5,96 @@
  */
 
 #include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
 
 #include "coresight-config.h"
+#include "coresight-config-file.h"
 #include "coresight-syscfg-configfs.h"
 
+/* prevent race in load / unload operations */
+static DEFINE_MUTEX(cfs_mutex);
+
+/*
+ * need to enable / disable load via configfs when
+ * initialising / shutting down the subsystem, or
+ * loading / unloading module.
+ */
+static bool cscfg_fs_load_enabled;
+
+/*
+ * Lockdep issues occur if deleting the config directory as part
+ * of the unload write operation. Therefore we schedule the main
+ * part of the unload to be completed as a work item
+ */
+struct cscfg_load_owner_info *unload_owner_info;
+
+/* complete the unload operation */
+static void cscfg_complete_unload(struct work_struct *work)
+{
+	mutex_lock(&cfs_mutex);
+
+	if (!cscfg_fs_load_enabled || !unload_owner_info) {
+		pr_warn("cscfg: skipping unload completion\n");
+		goto exit_unlock;
+	}
+
+	if (!cscfg_unload_config_sets(unload_owner_info))
+		cscfg_configfs_free_owner_info(unload_owner_info);
+	else
+		pr_err("cscfg: configfs configuration unload error\n");
+	unload_owner_info = NULL;
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	kfree(work);
+}
+
+static int cscfg_schedule_unload(struct cscfg_load_owner_info *owner_info, const char *name)
+{
+	struct work_struct *work;
+	int err;
+
+	work = kzalloc(sizeof(struct work_struct), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	/* set cscfg state as starting an unload operation */
+	err = cscfg_set_unload_start();
+	if (err) {
+		pr_err("Config unload %s: failed to set unload start flag\n", name);
+		kfree(work);
+		return err;
+	}
+
+	INIT_WORK(work, cscfg_complete_unload);
+	unload_owner_info = owner_info;
+	schedule_work(work);
+	return 0;
+}
+
+void cscfg_configfs_enable_fs_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_fs_load_enabled = true;
+	mutex_unlock(&cfs_mutex);
+}
+
+void cscfg_configfs_disable_fs_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_fs_load_enabled = false;
+	mutex_unlock(&cfs_mutex);
+}
+
+void cscfg_configfs_at_exit(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_fs_load_enabled = false;
+	unload_owner_info = NULL;
+	mutex_unlock(&cfs_mutex);
+}
+
 /* create a default ci_type. */
 static inline struct config_item_type *cscfg_create_ci_type(void)
 {
@@ -431,14 +517,154 @@ static void cscfg_destroy_feature_group(struct config_group *feat_group)
 	kfree(feat_view);
 }
 
-static struct config_item_type cscfg_configs_type = {
+/* Attributes in configfs that allow load and unload of configuration binary files */
+
+/* free memory associated with a configfs loaded configuration file & descriptors */
+void cscfg_configfs_free_owner_info(struct cscfg_load_owner_info *owner_info)
+{
+	struct cscfg_fs_load_descs *load_descs = 0;
+
+	if (!owner_info)
+		return;
+
+	load_descs = (struct cscfg_fs_load_descs *)(owner_info->owner_handle);
+
+	if (load_descs) {
+		/* free the data allocated on file load, pointed to by load_descs */
+		cscfg_file_free_load_descs(load_descs);
+		kfree(load_descs);
+	}
+
+	kfree(owner_info);
+}
+
+
+/* load "buffer" as a configuration binary file */
+static ssize_t cscfg_cfg_load_write(struct config_item *item, const void *buffer, size_t size)
+{
+	struct cscfg_fs_load_descs *load_descs = 0;
+	struct cscfg_load_owner_info *owner_info = 0;
+	int err = 0;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex))
+		return -EBUSY;
+
+	/* check configfs load / unload ops are permitted */
+	if (!cscfg_fs_load_enabled || unload_owner_info) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	if (size > CSCFG_FILE_MAXSIZE) {
+		pr_err("cscfg: Load error - Input file too large.\n");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+
+	load_descs = kzalloc(sizeof(struct cscfg_fs_load_descs), GFP_KERNEL);
+	owner_info = kzalloc(sizeof(struct cscfg_load_owner_info), GFP_KERNEL);
+	if (!load_descs || !owner_info) {
+		err = -ENOMEM;
+		goto exit_memfree;
+	}
+
+	owner_info->owner_handle = load_descs;
+	owner_info->type = CSCFG_OWNER_CONFIGFS;
+
+	err = cscfg_file_read_buffer(buffer, size, load_descs);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to read input file.\n");
+		goto exit_memfree;
+	}
+
+	err = cscfg_load_config_sets(load_descs->config_descs, load_descs->feat_descs, owner_info);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to load configuaration file.\n");
+		goto exit_memfree;
+	}
+
+	mutex_unlock(&cfs_mutex);
+	return size;
+
+exit_memfree:
+	cscfg_configfs_free_owner_info(owner_info);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+CONFIGFS_BIN_ATTR_WO(cscfg_cfg_, load, NULL, CSCFG_FILE_MAXSIZE);
+
+/* read "buffer" and schedule named configuration for unload */
+static ssize_t cscfg_cfg_unload_write(struct config_item *item, const void *buffer, size_t size)
+{
+	struct cscfg_load_owner_info *owner_info = 0;
+	const char *name;
+	int err = 0;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex))
+		return -EBUSY;
+
+	/* check configfs load / unload ops are permitted & no ongoing unload */
+	if (!cscfg_fs_load_enabled || unload_owner_info) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	if (size > CSCFG_FILE_MAXSIZE) {
+		pr_err("cscfg: Unload error - Input file too large\n");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+
+	err = cscfg_file_read_buffer_first_name(buffer, size, &name);
+	if (err) {
+		pr_err("cscfg: Unload error - Failed to read input file\n");
+		goto exit_unlock;
+	}
+
+	owner_info = cscfg_find_fs_owned_cfg_by_name(name);
+	if (!owner_info) {
+		pr_err("cscfg: Unload error: Failed to find %s from input file\n",
+		       name);
+		goto exit_unlock;
+	}
+
+	/* actual unload is scheduled as a work item */
+	err = cscfg_schedule_unload(owner_info, name);
+	if (err)
+		goto exit_unlock;
+
+	err = size;
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+CONFIGFS_BIN_ATTR_WO(cscfg_cfg_, unload, NULL, CSCFG_FILE_MAXSIZE);
+
+static struct configfs_bin_attribute *cscfg_config_configfs_bin_attrs[] = {
+	&cscfg_cfg_attr_load,
+	&cscfg_cfg_attr_unload,
+	NULL,
+};
+
+static struct config_item_type cscfg_configs_load_type = {
 	.ct_owner = THIS_MODULE,
+	.ct_bin_attrs = cscfg_config_configfs_bin_attrs,
 };
 
+static struct config_item_type cscfg_configs_grp_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+/* group for configurations dir */
 static struct config_group cscfg_configs_grp = {
 	.cg_item = {
 		.ci_namebuf = "configurations",
-		.ci_type = &cscfg_configs_type,
+		.ci_type = &cscfg_configs_grp_type,
 	},
 };
 
@@ -508,18 +734,20 @@ void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc)
 int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
 {
 	struct configfs_subsystem *subsys;
-	struct config_item_type *ci_type;
 
 	if (!cscfg_mgr)
 		return -EINVAL;
 
-	ci_type = cscfg_create_ci_type();
-	if (!ci_type)
-		return -ENOMEM;
+	/* load and unload by configfs initially disabled */
+	cscfg_fs_load_enabled = false;
+
+	/* no current unload operation in progress */
+	unload_owner_info = NULL;
 
+	/* init subsystem group - with load and unload attributes */
 	subsys = &cscfg_mgr->cfgfs_subsys;
 	config_item_set_name(&subsys->su_group.cg_item, CSCFG_FS_SUBSYS_NAME);
-	subsys->su_group.cg_item.ci_type = ci_type;
+	subsys->su_group.cg_item.ci_type = &cscfg_configs_load_type;
 
 	config_group_init(&subsys->su_group);
 	mutex_init(&subsys->su_mutex);
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
index 373d84d43268..7f5610c1895e 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
@@ -45,5 +45,9 @@ int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc);
 int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc);
 void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc);
 void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc);
+void cscfg_configfs_free_owner_info(struct cscfg_load_owner_info *owner_info);
+void cscfg_configfs_enable_fs_load(void);
+void cscfg_configfs_disable_fs_load(void);
+void cscfg_configfs_at_exit(void);
 
 #endif /* CORESIGHT_SYSCFG_CONFIGFS_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11138a9762b0..aa03e991cd9d 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -554,6 +554,22 @@ static int cscfg_fs_register_cfgs_feats(struct cscfg_config_desc **config_descs,
 	return 0;
 }
 
+/*
+ * check owner info and if module owner, disable / enable
+ * configfs load ops.
+ */
+static void cscfg_check_disable_fs_load(struct cscfg_load_owner_info *owner_info)
+{
+	if (owner_info->type == CSCFG_OWNER_MODULE)
+		cscfg_configfs_disable_fs_load();
+}
+
+static void cscfg_check_enable_fs_load(struct cscfg_load_owner_info *owner_info)
+{
+	if (owner_info->type == CSCFG_OWNER_MODULE)
+		cscfg_configfs_enable_fs_load();
+}
+
 /**
  * cscfg_load_config_sets - API function to load feature and config sets.
  *
@@ -578,10 +594,13 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 {
 	int err = 0;
 
+	/* if this load is by module owner, need to disable configfs load/unload */
+	cscfg_check_disable_fs_load(owner_info);
+
 	mutex_lock(&cscfg_mutex);
 	if (cscfg_mgr->load_state != CSCFG_NONE) {
-		mutex_unlock(&cscfg_mutex);
-		return -EBUSY;
+		err = -EBUSY;
+		goto exit_unlock;
 	}
 	cscfg_mgr->load_state = CSCFG_LOAD;
 
@@ -616,7 +635,7 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 
 	/* mark any new configs as available for activation */
 	cscfg_set_configs_available(config_descs);
-	goto exit_unlock;
+	goto exit_clear_state;
 
 err_clean_cfs:
 	/* cleanup after error registering with configfs */
@@ -631,9 +650,13 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 err_clean_load:
 	cscfg_unload_owned_cfgs_feats(owner_info);
 
-exit_unlock:
+exit_clear_state:
 	cscfg_mgr->load_state = CSCFG_NONE;
+
+exit_unlock:
 	mutex_unlock(&cscfg_mutex);
+
+	cscfg_check_enable_fs_load(owner_info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
@@ -659,8 +682,12 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
 	int err = 0;
 	struct cscfg_load_owner_info *load_list_item = NULL;
 
+	/* if this unload is by module owner, need to disable configfs load/unload */
+	cscfg_check_disable_fs_load(owner_info);
+
 	mutex_lock(&cscfg_mutex);
-	if (cscfg_mgr->load_state != CSCFG_NONE) {
+	if ((cscfg_mgr->load_state != CSCFG_NONE) &&
+	    (cscfg_mgr->load_state != CSCFG_UNLOAD_START)) {
 		mutex_unlock(&cscfg_mutex);
 		return -EBUSY;
 	}
@@ -705,10 +732,80 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
 exit_unlock:
 	cscfg_mgr->load_state = CSCFG_NONE;
 	mutex_unlock(&cscfg_mutex);
+
+	cscfg_check_enable_fs_load(owner_info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_unload_config_sets);
 
+int cscfg_set_unload_start(void)
+{
+	int ret = 0;
+
+	mutex_lock(&cscfg_mutex);
+	if (cscfg_mgr->load_state != CSCFG_NONE)
+		ret = -EBUSY;
+	else
+		cscfg_mgr->load_state = CSCFG_UNLOAD_START;
+	mutex_unlock(&cscfg_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cscfg_set_unload_start);
+
+/* find a configuration owned by configfs by name of config / first feature */
+struct cscfg_load_owner_info *cscfg_find_fs_owned_cfg_by_name(const char *name)
+{
+	struct cscfg_load_owner_info *owner_info = NULL;
+	struct cscfg_fs_load_descs *fs_load_cfg;
+	struct cscfg_config_desc *config_desc;
+	struct cscfg_feature_desc *feat_desc;
+
+	mutex_lock(&cscfg_mutex);
+
+	/* search the load_owner list for CONFIGFS loaded types */
+	list_for_each_entry(owner_info, &cscfg_mgr->load_order_list, item) {
+		/* if this is a config fs owned item, then try to match */
+		if (owner_info->type == CSCFG_OWNER_CONFIGFS) {
+			fs_load_cfg = owner_info->owner_handle;
+			/* first try to match the name against the config if it exists */
+			if (fs_load_cfg->config_descs[0]) {
+				config_desc = fs_load_cfg->config_descs[0];
+				if (!strcmp(config_desc->name, name))
+					goto exit_unlock;
+			/* no config - match against first feature name */
+			} else {
+				feat_desc = fs_load_cfg->feat_descs[0];
+				if (!strcmp(feat_desc->name, name))
+					goto exit_unlock;
+			}
+		}
+	}
+
+	/* not found */
+	owner_info = NULL;
+
+exit_unlock:
+	mutex_unlock(&cscfg_mutex);
+	return owner_info;
+}
+
+/* get configfs config load name from configfs type owner */
+static const char *cscfg_find_load_name_fs_owned_cfg(struct cscfg_load_owner_info *owner_info)
+{
+	struct cscfg_fs_load_descs *fs_load_cfg;
+	const char *name = "unknown";
+
+	if (owner_info->type == CSCFG_OWNER_CONFIGFS) {
+		fs_load_cfg = (struct cscfg_fs_load_descs *)owner_info->owner_handle;
+		if (fs_load_cfg->config_descs[0])
+			name = fs_load_cfg->config_descs[0]->name;
+		else if (fs_load_cfg->feat_descs[0])
+			name = fs_load_cfg->feat_descs[0]->name;
+	}
+	return name;
+}
+
 /* Handle coresight device registration and add configs and features to devices */
 
 /* iterate through config lists and load matching configs to device */
@@ -881,7 +978,7 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
 	struct cscfg_config_desc *config_desc;
 	int err = -EINVAL;
 
-	if (cscfg_mgr->load_state == CSCFG_UNLOAD)
+	if (cscfg_mgr->load_state >= CSCFG_UNLOAD)
 		return -EBUSY;
 
 	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
@@ -1206,6 +1303,7 @@ static int cscfg_create_device(void)
 static void cscfg_unload_cfgs_on_exit(void)
 {
 	struct cscfg_load_owner_info *owner_info = NULL;
+	bool free_configfs_owner = false;
 
 	/*
 	 * grab the mutex - even though we are exiting, some configfs files
@@ -1240,6 +1338,23 @@ static void cscfg_unload_cfgs_on_exit(void)
 			 */
 			pr_err("cscfg: ERROR: prior module failed to unload configuration\n");
 			goto list_remove;
+
+		case CSCFG_OWNER_CONFIGFS:
+			/*
+			 * configfs loaded items may still be present if the user did not
+			 * unload them during the session. These have dynamically allocated
+			 * descriptor tables (unlike the two types above that are statically
+			 * allocated at compile time)
+			 */
+			pr_info("cscfg: unloading configfs loaded configuration %s\n",
+				cscfg_find_load_name_fs_owned_cfg(owner_info));
+
+			/*
+			 * as this is not being unloaded by configfs, need to flag the
+			 * requirement to free up the descriptors.
+			 */
+			free_configfs_owner = true;
+			break;
 		}
 
 		/* remove from configfs - outside the scope of the list mutex */
@@ -1253,6 +1368,12 @@ static void cscfg_unload_cfgs_on_exit(void)
 list_remove:
 		/* remove from load order list */
 		list_del(&owner_info->item);
+
+		/* configfs owned dynamic loaded config, free memory now */
+		if (free_configfs_owner) {
+			cscfg_configfs_free_owner_info(owner_info);
+			free_configfs_owner = false;
+		}
 	}
 	mutex_unlock(&cscfg_mutex);
 }
@@ -1284,6 +1405,9 @@ int __init cscfg_init(void)
 	if (err)
 		goto exit_err;
 
+	/* can now allow load / unload from configfs */
+	cscfg_configfs_enable_fs_load();
+
 	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
 	return 0;
 
@@ -1294,5 +1418,6 @@ int __init cscfg_init(void)
 
 void cscfg_exit(void)
 {
+	cscfg_configfs_at_exit();
 	cscfg_clear_device();
 }
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index d0c9543850c0..73353080810d 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -20,7 +20,8 @@
 enum cscfg_load_ops {
 	CSCFG_NONE,
 	CSCFG_LOAD,
-	CSCFG_UNLOAD
+	CSCFG_UNLOAD,
+	CSCFG_UNLOAD_START, /* unload started by fs, will be completed later */
 };
 
 /**
@@ -108,6 +109,7 @@ int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
 				int param_idx, u64 value);
 int cscfg_config_sysfs_activate(struct cscfg_config_desc *cfg_desc, bool activate);
 void cscfg_config_sysfs_set_preset(int preset);
+struct cscfg_load_owner_info *cscfg_find_fs_owned_cfg_by_name(const char *name);
 
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
@@ -124,5 +126,6 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 				     unsigned long cfg_hash, int preset);
 void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
 void cscfg_config_sysfs_get_active_cfg(unsigned long *cfg_hash, int *preset);
+int cscfg_set_unload_start(void);
 
 #endif /* CORESIGHT_SYSCFG_H */
-- 
2.17.1

