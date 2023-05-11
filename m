Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAF6FEBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjEKGxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbjEKGxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:53:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357ED4EF7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3f315712406so271843115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788016; x=1686380016;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNo/unRaEGMgy+WDudBvlLmaOxK4JQaFVhpw20oCbZQ=;
        b=JklId06AD1CoKYJaaeJ9VrVLkezkYR1Zl3lLFJjXdloTBzPrAIyh5BwEEQVXkNzh0a
         txWSnlG7wC8L4HHJXrx6Yn09XY7shZv9EqC3JXxzlbD/f/8PBvMaScqYfA+X3hTvmx5h
         pkpQTokJvf/5eF8lmYfjC8wTO0bMdLDSXIpeT1HS1TIgZz3DGiFYF51ONhKJKg2MGI2a
         FFzWmJg8vhdt87lDNrfxhafnt5ql4snedbHvefcGaKOh+Ako8QjyZeY/wPSR21djJt+H
         tW/c6Ns4unxJG+c5q92osyHIe/qYTqMhgKO+ljt9oz2mSExwW/GGUdJjRJbK6khUl+qy
         Xuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788016; x=1686380016;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNo/unRaEGMgy+WDudBvlLmaOxK4JQaFVhpw20oCbZQ=;
        b=jPOO3iYR4iNS9HhCGpj+oSjBkzSutWZYd27ljXu025+NOUB/UpS2B2jzYtUYBlnz7C
         O3Bte57zKkgBjg2UDx7WP0GoHkrW4S6+q7qS0NongoLpUP486V1EYoTLGV6wLgN6sxUc
         bJnKmhhkSlMdySMuulNKtauf7AdNl3oZm6/Dryzb+fvsoTpOcbRAglig4fba72mlmydW
         2HakBouvlL9WphhNqD5b0fsIO0kycb2XJzpmmuLgqr7WJDLbng5SPk7026oKhP6/UcKw
         fMtLBvMj8d9Gww82Z/W5hREjcQsWgPUZY9dRb05CrHdrqd5dTL2XkPQG/9UU1LUweUJO
         17bA==
X-Gm-Message-State: AC+VfDzRVCcGyTlRyURzec4ufo1NH7/SfJDJuXKMfGNCRTzUhLifZZ40
        WhDDreTb9+QRsaz5QFc3JGOFTA==
X-Google-Smtp-Source: ACHHUZ5t5qh/pO6It9l2E4BQnD5PgKVd5BH8h82H4jFVEBKvN7mbXgZQXOGIYjh8Tt21+uzvx23f+Q==
X-Received: by 2002:a05:600c:3792:b0:3f1:6ead:e396 with SMTP id o18-20020a05600c379200b003f16eade396mr12888919wmr.17.1683788016457;
        Wed, 10 May 2023 23:53:36 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:3110:8b33:cdf9:dea0])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm1038257wml.46.2023.05.10.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:53:35 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 3/6] coresight: configfs: Add attributes to load config tables at runtime
Date:   Thu, 11 May 2023 07:53:27 +0100
Message-Id: <20230511065330.26392-4-mike.leach@linaro.org>
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

The existing configfs structure for Coresight is extended to allow load
and unload of Coresight configurations at runtime. This provides more
flexibility than configurations defined at compile time in drivers or
loadable kernel modules, and allows use in situations where adding
additional kernel modules is undesireable or not permitted.

This also removes any dependence on specific compile time kernel versions,
improving portability and re-use. Configurations are validated against the
hardware present on the device.

The configurations are loaded onto all relevant devices in the Coresight
sub-system atomically. Configurations will not be available for use until
the whole system is updated, and the load will be un-wound if any part of
the validation fails.

These will then appear in configfs, in the existing 'configurations' and
'features' directories, as well as in the perf 'events' area ready for use.

Runtime configuration tables are loaded via the 'load' attribute.
This is a binary attribute - which the configfs infrastructure provides
as a size limited buffer - limited to the defined maximum size of a
Coresight configuration table. This provides a reliable load mechanism as
tables are variable in size, dependent on the operations required.

(note: this follows the example set by the ACPI table load which also
uses binary attributes)

The system reads the incoming data, which is validated as being formatted
correctly by the table reader code. This will then create configuration(s)
and/or feature(s) objects which are then loaded into the system, using the
existing code - which validates correctness for use with the system
hardware.

These will then appear in configfs, in the 'configurations' and 'features'
directories, ready for use.

Configurations are unloaded using the 'unload_last' attribute. As
configurations can be dependent on previously loaded items, the system
enforces a strict unload ordering in reverse order of loading.

A mutex is used to prevent load and unload operations from happening
simultaneously. Further, a flag enabling configfs load/unload is
provided, along with API calls to allow this functionality to be
controlled during start-up and shut-down, and when configurations
are loaded via loadable modules.

This ensures that load/unload operations are strictly serialised.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 394 +++++++++++++++++-
 .../coresight/coresight-syscfg-configfs.h     |   5 +
 .../hwtracing/coresight/coresight-syscfg.c    | 101 ++++-
 .../hwtracing/coresight/coresight-syscfg.h    |   6 +-
 4 files changed, 492 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 6e8c8db52d39..e0eb53afbb74 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -5,10 +5,96 @@
  */
 
 #include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
 
 #include "coresight-config.h"
+#include "coresight-config-table.h"
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
@@ -431,14 +517,306 @@ static void cscfg_destroy_feature_group(struct config_group *feat_group)
 	kfree(feat_view);
 }
 
-static struct config_item_type cscfg_configs_type = {
+/* Attrib in configfs that allow load and unload of configuration binary tables */
+
+/* free memory associated with a configfs loaded configuration & descriptors */
+void cscfg_configfs_free_owner_info(struct cscfg_load_owner_info *owner_info)
+{
+	struct cscfg_table_load_descs *load_descs = 0;
+
+	if (!owner_info)
+		return;
+
+	load_descs = (struct cscfg_table_load_descs *)(owner_info->owner_handle);
+
+	if (load_descs) {
+		/* free the data allocated on table load, pointed to by load_descs */
+		cscfg_table_free_load_descs(load_descs);
+		kfree(load_descs);
+	}
+
+	kfree(owner_info);
+}
+
+/* return load name if configfs owned element */
+const char *cscfg_configfs_get_load_name(struct cscfg_load_owner_info *owner_info)
+{
+	const char *name = "unknown";
+	struct cscfg_table_load_descs *load_descs;
+
+	if (!owner_info)
+		return name;
+
+	load_descs = (struct cscfg_table_load_descs *)(owner_info->owner_handle);
+	if (owner_info->type == CSCFG_OWNER_CONFIGFS)
+		return load_descs->load_name;
+
+	return name;
+}
+
+/* load configuration table from buffer */
+static ssize_t cscfg_cfg_load_write(struct config_item *item, const void *buffer, size_t size)
+{
+	struct cscfg_table_load_descs *load_descs = 0;
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
+	if (size > CSCFG_TABLE_MAXSIZE) {
+		pr_err("cscfg: Load error - Input file too large.\n");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+
+	load_descs = kzalloc(sizeof(struct cscfg_table_load_descs), GFP_KERNEL);
+	if (!load_descs) {
+		err = -ENOMEM;
+		goto exit_unlock;
+	}
+
+	owner_info = kzalloc(sizeof(struct cscfg_load_owner_info), GFP_KERNEL);
+	if (!owner_info) {
+		kfree(load_descs);
+		err = -ENOMEM;
+		goto exit_unlock;
+	}
+
+	owner_info->owner_handle = load_descs;
+	owner_info->type = CSCFG_OWNER_CONFIGFS;
+
+	/* convert table into internal data structures */
+	err = cscfg_table_read_buffer(buffer, size, load_descs);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to read input buffer.\n");
+		goto exit_memfree;
+	}
+
+	err = cscfg_load_config_sets(load_descs->config_descs, load_descs->feat_descs, owner_info);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to load configuaration table.\n");
+		goto exit_memfree;
+	}
+
+	mutex_unlock(&cfs_mutex);
+	return size;
+
+exit_memfree:
+	/* frees up owner_info and load_descs */
+	cscfg_configfs_free_owner_info(owner_info);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+CONFIGFS_BIN_ATTR_WO(cscfg_cfg_, load, NULL, CSCFG_TABLE_MAXSIZE);
+
+static ssize_t cscfg_cfg_unload_store(struct config_item *item, const char *page, size_t count)
+{
+	struct cscfg_load_owner_info *owner_info = 0;
+	const char *load_name;
+	char *unload_name;
+	int err = -EINVAL;
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
+	/* find the last loaded owner info block */
+	owner_info = cscfg_find_last_loaded_cfg_owner();
+	if (!owner_info) {
+		pr_err("cscfg: Unload error: Failed to find any loaded configuration\n");
+		goto exit_unlock;
+	}
+
+	if (owner_info->type != CSCFG_OWNER_CONFIGFS) {
+		pr_err("cscfg: Last loaded configuration not configfs loaded item\n");
+		goto exit_unlock;
+	}
+
+	/* get the load name for this item */
+	load_name = cscfg_configfs_get_load_name(owner_info);
+
+	/* input will have a \n - need to get rid */
+	unload_name = kstrdup(page, GFP_KERNEL);
+	if (!unload_name) {
+		err = -ENOMEM;
+		goto exit_unlock;
+	}
+	unload_name[strlen(unload_name) - 1] = 0;
+
+	/* must match input name to unload */
+	if (!strcmp(load_name, unload_name)) {
+
+		/* actual unload is scheduled as a work item */
+		err = cscfg_schedule_unload(owner_info, load_name);
+		if (!err)
+			err = count;
+	} else {
+		pr_err("cscfg: unload name: %s;  does not match last loaded: %s;\n",
+		       unload_name, load_name);
+	}
+	kfree(unload_name);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+CONFIGFS_ATTR_WO(cscfg_cfg_, unload);
+
+/* create a string representing a loaded config based on owner info */
+static ssize_t cscfg_cfg_get_cfg_info_str_owner(struct cscfg_load_owner_info *owner_info,
+						char *buffer, ssize_t size)
+{
+	struct cscfg_table_load_descs *load_descs;
+	ssize_t size_used = 0;
+	int i;
+	static const char *load_type[] = {
+		"Built in driver",
+		"Loadable module",
+		"configfs dynamic load",
+	};
+
+	/* limited info for none dynamic loaded stuff */
+	if (owner_info->type != CSCFG_OWNER_CONFIGFS) {
+		size_used = scnprintf(buffer, size,
+				      "load name: [Not Set]\nload type: %s\n",
+				      load_type[owner_info->type]);
+		goto buffer_done;
+	}
+
+	/* configfs dynamic type will have all the info */
+	load_descs = (struct cscfg_table_load_descs *)owner_info->owner_handle;
+
+	/* first is the load name and type - need for unload request */
+	size_used = scnprintf(buffer, size, "load name: %s\nload type: %s\n",
+				      load_descs->load_name,
+				      load_type[owner_info->type]);
+
+	/* list of configurations loaded by this owner element */
+	size_used += scnprintf(buffer + size_used, size - size_used,
+			       "(configurations: ");
+	if (!(size_used < size))
+		goto buffer_done;
+
+	if (!load_descs->config_descs[0]) {
+		size_used += scnprintf(buffer + size_used, size - size_used,
+				       " None )\n");
+		if (!(size_used < size))
+			goto buffer_done;
+	} else {
+		i = 0;
+		while (load_descs->config_descs[i] && (size_used < size)) {
+			size_used += scnprintf(buffer + size_used,
+					       size - size_used, " %s",
+					       load_descs->config_descs[i]->name);
+			i++;
+		}
+		size_used +=
+			scnprintf(buffer + size_used, size - size_used, " )\n");
+	}
+	if (!(size_used < size))
+		goto buffer_done;
+
+	/* list of features loaded by this owner element */
+	size_used += scnprintf(buffer + size_used, size - size_used, "(features: ");
+	if (!(size_used < size))
+		goto buffer_done;
+
+	if (!load_descs->feat_descs[0]) {
+		size_used +=
+			scnprintf(buffer + size_used, size - size_used, " None )\n");
+		if (!(size_used < size))
+			goto buffer_done;
+	} else {
+		i = 0;
+		while (load_descs->feat_descs[i] && (size_used < size)) {
+			size_used += scnprintf(buffer + size_used,
+					       size - size_used, " %s",
+					       load_descs->feat_descs[i]->name);
+			i++;
+		}
+		size_used +=
+			scnprintf(buffer + size_used, size - size_used, " )\n");
+	}
+
+	/* done or buffer full */
+buffer_done:
+	return size_used;
+}
+
+static ssize_t cscfg_cfg_show_last_load_show(struct config_item *item, char *page)
+{
+	struct cscfg_load_owner_info *owner_info = 0;
+	ssize_t size = 0;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex))
+		return -EBUSY;
+
+	/* check configfs load / unload ops are permitted & no ongoing unload */
+	if (!cscfg_fs_load_enabled || unload_owner_info) {
+		size = -EBUSY;
+		goto exit_unlock;
+	}
+
+	/* find the last loaded owner info block */
+	owner_info = cscfg_find_last_loaded_cfg_owner();
+	if (!owner_info) {
+		size = scnprintf(page, PAGE_SIZE,
+				 "Failed to find any loaded configuration\n");
+		goto exit_unlock;
+	}
+
+	/* get string desc of last unload configuration from owner info */
+	size = cscfg_cfg_get_cfg_info_str_owner(owner_info, page, PAGE_SIZE);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return size;
+}
+CONFIGFS_ATTR_RO(cscfg_cfg_, show_last_load);
+
+static struct configfs_bin_attribute *cscfg_config_configfs_bin_attrs[] = {
+	&cscfg_cfg_attr_load,
+	NULL,
+};
+
+static struct configfs_attribute *cscfg_config_configfs_attrs[] = {
+	&cscfg_cfg_attr_unload,
+	&cscfg_cfg_attr_show_last_load,
+	NULL,
+};
+
+static struct config_item_type cscfg_configs_load_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_config_configfs_attrs,
+	.ct_bin_attrs = cscfg_config_configfs_bin_attrs,
+};
+
+static struct config_item_type cscfg_configs_grp_type = {
 	.ct_owner = THIS_MODULE,
 };
 
+/* group for configurations dir */
 static struct config_group cscfg_configs_grp = {
 	.cg_item = {
 		.ci_namebuf = "configurations",
-		.ci_type = &cscfg_configs_type,
+		.ci_type = &cscfg_configs_grp_type,
 	},
 };
 
@@ -508,18 +886,20 @@ void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc)
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
index 373d84d43268..a7d1fec967ef 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
@@ -45,5 +45,10 @@ int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc);
 int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc);
 void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc);
 void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc);
+const char *cscfg_configfs_get_load_name(struct cscfg_load_owner_info *owner_info);
+void cscfg_configfs_free_owner_info(struct cscfg_load_owner_info *owner_info);
+void cscfg_configfs_enable_fs_load(void);
+void cscfg_configfs_disable_fs_load(void);
+void cscfg_configfs_at_exit(void);
 
 #endif /* CORESIGHT_SYSCFG_CONFIGFS_H */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11138a9762b0..500af8152769 100644
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
@@ -705,10 +732,44 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
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
+/* find the last loaded config owner info */
+struct cscfg_load_owner_info *cscfg_find_last_loaded_cfg_owner(void)
+{
+	struct cscfg_load_owner_info *owner_info = NULL;
+
+	mutex_lock(&cscfg_mutex);
+
+	if (!list_empty(&cscfg_mgr->load_order_list))
+		owner_info = list_last_entry(&cscfg_mgr->load_order_list,
+					     struct cscfg_load_owner_info, item);
+
+
+	mutex_unlock(&cscfg_mutex);
+	return owner_info;
+
+}
+
 /* Handle coresight device registration and add configs and features to devices */
 
 /* iterate through config lists and load matching configs to device */
@@ -881,7 +942,7 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
 	struct cscfg_config_desc *config_desc;
 	int err = -EINVAL;
 
-	if (cscfg_mgr->load_state == CSCFG_UNLOAD)
+	if (cscfg_mgr->load_state >= CSCFG_UNLOAD)
 		return -EBUSY;
 
 	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
@@ -1206,6 +1267,7 @@ static int cscfg_create_device(void)
 static void cscfg_unload_cfgs_on_exit(void)
 {
 	struct cscfg_load_owner_info *owner_info = NULL;
+	bool free_configfs_owner = false;
 
 	/*
 	 * grab the mutex - even though we are exiting, some configfs files
@@ -1240,6 +1302,23 @@ static void cscfg_unload_cfgs_on_exit(void)
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
+				cscfg_configfs_get_load_name(owner_info));
+
+			/*
+			 * as this is not being unloaded by configfs, need to flag the
+			 * requirement to free up the descriptors.
+			 */
+			free_configfs_owner = true;
+			break;
 		}
 
 		/* remove from configfs - outside the scope of the list mutex */
@@ -1253,6 +1332,12 @@ static void cscfg_unload_cfgs_on_exit(void)
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
@@ -1284,6 +1369,9 @@ int __init cscfg_init(void)
 	if (err)
 		goto exit_err;
 
+	/* can now allow load / unload from configfs */
+	cscfg_configfs_enable_fs_load();
+
 	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
 	return 0;
 
@@ -1294,5 +1382,6 @@ int __init cscfg_init(void)
 
 void cscfg_exit(void)
 {
+	cscfg_configfs_at_exit();
 	cscfg_clear_device();
 }
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 66e2db890d82..530b32956ab6 100644
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
@@ -79,6 +80,7 @@ struct cscfg_registered_csdev {
 enum cscfg_load_owner_type {
 	CSCFG_OWNER_PRELOAD,
 	CSCFG_OWNER_MODULE,
+	CSCFG_OWNER_CONFIGFS,
 };
 
 /**
@@ -107,6 +109,7 @@ int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
 				int param_idx, u64 value);
 int cscfg_config_sysfs_activate(struct cscfg_config_desc *cfg_desc, bool activate);
 void cscfg_config_sysfs_set_preset(int preset);
+struct cscfg_load_owner_info *cscfg_find_last_loaded_cfg_owner(void);
 
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
@@ -123,5 +126,6 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 				     unsigned long cfg_hash, int preset);
 void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
 void cscfg_config_sysfs_get_active_cfg(unsigned long *cfg_hash, int *preset);
+int cscfg_set_unload_start(void);
 
 #endif /* CORESIGHT_SYSCFG_H */
-- 
2.17.1

