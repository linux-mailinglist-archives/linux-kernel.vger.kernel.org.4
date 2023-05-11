Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F26FEBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjEKGxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbjEKGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:53:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F474EEB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so14026635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788015; x=1686380015;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVN6AgfRQ9JB5xb8lTlVzU3nqEsQK95Vgz2t3dnIbI4=;
        b=GWnAUiuMAyQ3vhuczplkyUK9hkjarHhKn92pktjUO2edc1aly6Kve5PT1niMSZ0cyz
         Rh8uywRvpab3kS7wQsfqHTm1hB/I4vbqq6BfwtfISE4H0lGnpuT64h9RzAYi7tud8/20
         GqEAedC+MQx8QYb07fCxJLYlhl7G8rhp9VLuskFLOhgoTfs+hkkC8St47uVHuUPHoTNz
         wKTG81jjK6CicEkqxoeDG/lVxZmzhAEyOHjUIKfsDOR5HMilJegkIGhkh6Ip9hMHCXGi
         Lglx3eECZiCig5EJghEQ6OW/CpGGQrpkHiZi3GJ84OcXslJWG0rSe8AOGclJAPh4sXoj
         vDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788015; x=1686380015;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVN6AgfRQ9JB5xb8lTlVzU3nqEsQK95Vgz2t3dnIbI4=;
        b=ggEIB5ta6/8yAw0bbEi3dvPS2jp+RI/0C7Z/1SqBBc5i4CKs9hFwZw+aiah1/c+8Ld
         7N8p6rkn7x4cx08eZC7xHamKlH4kT0SXii8p+qIuGsyGlWfEV8qaJNy8u5MXzsi9eT9x
         CiTegrCT7Qw3nyVzvkiLf6ZsF6YyhcsfGj5zKZ2ImrFbKC52eK4Bqx8FdQESreTWbtRW
         f4Ib+WFGisdDUb/9ZAnCg23Voua9YLFGM9RVqyp2zjwQ9En9aVNU2lsnl73Y50OYm2ol
         OEJOhxk94dMDEeghZGHAoGocqaCD6WIbhCqVqiRtCr9Exx8Ls6v85kJ2vCylNRh5thZV
         hcDA==
X-Gm-Message-State: AC+VfDw+kzsFeHWGmpeAsFrgSjmhzY4He/OvwW8ZYNkzJh0Zqgt1DSff
        8u2kOrKPpEvMGmCf0cC9Dl8aYA==
X-Google-Smtp-Source: ACHHUZ5cT3ZuXjOkVkWSEM+SyenAkD+07ZXtO7suuzEOzUAJYkpBPBRZgCWyFaL8ROk/RQ3cPUFSNA==
X-Received: by 2002:a1c:7c10:0:b0:3f4:2610:5cc1 with SMTP id x16-20020a1c7c10000000b003f426105cc1mr9329850wmc.1.1683788015372;
        Wed, 10 May 2023 23:53:35 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:3110:8b33:cdf9:dea0])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm1038257wml.46.2023.05.10.23.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:53:34 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 2/6] coresight: configfs: Update memory allocation / free for configfs elements
Date:   Thu, 11 May 2023 07:53:26 +0100
Message-Id: <20230511065330.26392-3-mike.leach@linaro.org>
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

Previously, the objects backing the configfs directories and files were
created using devm managed memory on the coresight device.

Now we are adding configfs load/unload, configurations can be loaded
many times over the lifetime of the device, so it is more appropriate to
use normally allocated and freed memory.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 119 +++++++++++++-----
 1 file changed, 88 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 433ede94dd63..6e8c8db52d39 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -14,7 +14,7 @@ static inline struct config_item_type *cscfg_create_ci_type(void)
 {
 	struct config_item_type *ci_type;
 
-	ci_type = devm_kzalloc(cscfg_device(), sizeof(*ci_type), GFP_KERNEL);
+	ci_type = kzalloc(sizeof(*ci_type), GFP_KERNEL);
 	if (ci_type)
 		ci_type->ct_owner = THIS_MODULE;
 
@@ -175,6 +175,19 @@ static struct config_item_type cscfg_config_preset_type = {
 	.ct_attrs = cscfg_config_preset_attrs,
 };
 
+
+/* walk list of presets and free the previously allocated memory */
+static void cscfg_destroy_preset_groups(struct config_group *cfg_view_group)
+{
+	struct cscfg_fs_preset *cfg_fs_preset;
+	struct config_group *p_group;
+
+	list_for_each_entry(p_group, &cfg_view_group->default_groups, default_groups) {
+		cfg_fs_preset = container_of(p_group, struct cscfg_fs_preset, group);
+		kfree(cfg_fs_preset);
+	}
+}
+
 static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
 {
 	int preset_num;
@@ -186,11 +199,12 @@ static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
 		return 0;
 
 	for (preset_num = 1; preset_num <= config_desc->nr_presets; preset_num++) {
-		cfg_fs_preset = devm_kzalloc(cscfg_device(),
-					     sizeof(struct cscfg_fs_preset), GFP_KERNEL);
+		cfg_fs_preset = kzalloc(sizeof(struct cscfg_fs_preset), GFP_KERNEL);
 
-		if (!cfg_fs_preset)
+		if (!cfg_fs_preset) {
+			cscfg_destroy_preset_groups(&cfg_view->group);
 			return -ENOMEM;
+		}
 
 		snprintf(name, CONFIGFS_ITEM_NAME_LEN, "preset%d", preset_num);
 		cfg_fs_preset->preset_num = preset_num;
@@ -204,14 +218,10 @@ static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
 
 static struct config_group *cscfg_create_config_group(struct cscfg_config_desc *config_desc)
 {
-	struct cscfg_fs_config *cfg_view;
-	struct device *dev = cscfg_device();
+	struct cscfg_fs_config *cfg_view = NULL;
 	int err;
 
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	cfg_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_config), GFP_KERNEL);
+	cfg_view = kzalloc(sizeof(struct cscfg_fs_config), GFP_KERNEL);
 	if (!cfg_view)
 		return ERR_PTR(-ENOMEM);
 
@@ -220,12 +230,21 @@ static struct config_group *cscfg_create_config_group(struct cscfg_config_desc *
 
 	/* add in a preset<n> dir for each preset */
 	err = cscfg_add_preset_groups(cfg_view);
-	if (err)
+	if (err) {
+		kfree(cfg_view);
 		return ERR_PTR(err);
-
+	}
 	return &cfg_view->group;
 }
 
+static void cscfg_destroy_config_group(struct config_group *group)
+{
+	struct cscfg_fs_config *cfg_view = container_of(group, struct cscfg_fs_config, group);
+
+	cscfg_destroy_preset_groups(&cfg_view->group);
+	kfree(cfg_view);
+}
+
 /* attributes for features view */
 
 static ssize_t cscfg_feat_description_show(struct config_item *item, char *page)
@@ -314,6 +333,17 @@ static struct config_item_type cscfg_param_view_type = {
 	.ct_attrs = cscfg_param_view_attrs,
 };
 
+/* walk the list of default groups - which were set as param items and remove */
+static void cscfg_destroy_params_group_items(struct config_group *params_group)
+{
+	struct cscfg_fs_param *param_item;
+	struct config_group *p_group;
+
+	list_for_each_entry(p_group, &params_group->default_groups, default_groups) {
+		param_item = container_of(p_group, struct cscfg_fs_param, group);
+		kfree(param_item);
+	}
+}
 /*
  * configfs has far less functionality provided to add attributes dynamically than sysfs,
  * and the show and store fns pass the enclosing config_item so the actual attribute cannot
@@ -322,15 +352,16 @@ static struct config_item_type cscfg_param_view_type = {
 static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
 					   struct config_group *params_group)
 {
-	struct device *dev = cscfg_device();
 	struct cscfg_fs_param *param_item;
 	int i;
 
 	/* parameter items - as groups with default_value attribute */
 	for (i = 0; i < feat_desc->nr_params; i++) {
-		param_item = devm_kzalloc(dev, sizeof(struct cscfg_fs_param), GFP_KERNEL);
-		if (!param_item)
+		param_item = kzalloc(sizeof(struct cscfg_fs_param), GFP_KERNEL);
+		if (!param_item) {
+			cscfg_destroy_params_group_items(params_group);
 			return -ENOMEM;
+		}
 		param_item->feat_desc = feat_desc;
 		param_item->param_idx = i;
 		config_group_init_type_name(&param_item->group,
@@ -343,27 +374,22 @@ static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
 
 static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc *feat_desc)
 {
-	struct cscfg_fs_feature *feat_view;
-	struct config_item_type *params_group_type;
+	struct cscfg_fs_feature *feat_view = NULL;
+	struct config_item_type *params_group_type = NULL;
 	struct config_group *params_group = NULL;
-	struct device *dev = cscfg_device();
-	int item_err;
-
-	if (!dev)
-		return ERR_PTR(-EINVAL);
+	int err = -ENOMEM;
 
-	feat_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_feature), GFP_KERNEL);
+	feat_view = kzalloc(sizeof(struct cscfg_fs_feature), GFP_KERNEL);
 	if (!feat_view)
 		return ERR_PTR(-ENOMEM);
 
 	if (feat_desc->nr_params) {
-		params_group = devm_kzalloc(dev, sizeof(struct config_group), GFP_KERNEL);
+		params_group = kzalloc(sizeof(struct config_group), GFP_KERNEL);
 		if (!params_group)
-			return ERR_PTR(-ENOMEM);
-
+			goto exit_err_free_mem;
 		params_group_type = cscfg_create_ci_type();
 		if (!params_group_type)
-			return ERR_PTR(-ENOMEM);
+			goto exit_err_free_mem;
 	}
 
 	feat_view->feat_desc = feat_desc;
@@ -373,11 +399,36 @@ static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc
 	if (params_group) {
 		config_group_init_type_name(params_group, "params", params_group_type);
 		configfs_add_default_group(params_group, &feat_view->group);
-		item_err = cscfg_create_params_group_items(feat_desc, params_group);
-		if (item_err)
-			return ERR_PTR(item_err);
+		err = cscfg_create_params_group_items(feat_desc, params_group);
+		if (err)
+			goto exit_err_free_mem;
 	}
 	return &feat_view->group;
+
+exit_err_free_mem:
+	kfree(feat_view);
+	kfree(params_group_type);
+	kfree(params_group);
+	return ERR_PTR(err);
+}
+
+static void cscfg_destroy_feature_group(struct config_group *feat_group)
+{
+	struct cscfg_fs_feature *feat_view;
+	struct config_group *params_group = NULL;
+
+	feat_view = container_of(feat_group, struct cscfg_fs_feature, group);
+
+	/* params group is the first item on the default group list */
+	if (!list_empty(&feat_group->default_groups)) {
+		params_group = list_first_entry(&feat_group->default_groups,
+						struct config_group, default_groups);
+		cscfg_destroy_params_group_items(params_group);
+		/* free the item type, then the group */
+		kfree(params_group->cg_item.ci_type);
+		kfree(params_group);
+	}
+	kfree(feat_view);
 }
 
 static struct config_item_type cscfg_configs_type = {
@@ -403,6 +454,8 @@ int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc)
 	err =  configfs_register_group(&cscfg_configs_grp, new_group);
 	if (!err)
 		config_desc->fs_group = new_group;
+	else
+		cscfg_destroy_config_group(new_group);
 	return err;
 }
 
@@ -410,6 +463,7 @@ void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc)
 {
 	if (config_desc->fs_group) {
 		configfs_unregister_group(config_desc->fs_group);
+		cscfg_destroy_config_group(config_desc->fs_group);
 		config_desc->fs_group = NULL;
 	}
 }
@@ -434,9 +488,11 @@ int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc)
 	new_group = cscfg_create_feature_group(feat_desc);
 	if (IS_ERR(new_group))
 		return PTR_ERR(new_group);
-	err =  configfs_register_group(&cscfg_features_grp, new_group);
+	err = configfs_register_group(&cscfg_features_grp, new_group);
 	if (!err)
 		feat_desc->fs_group = new_group;
+	else
+		cscfg_destroy_feature_group(new_group);
 	return err;
 }
 
@@ -444,6 +500,7 @@ void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc)
 {
 	if (feat_desc->fs_group) {
 		configfs_unregister_group(feat_desc->fs_group);
+		cscfg_destroy_feature_group(feat_desc->fs_group);
 		feat_desc->fs_group = NULL;
 	}
 }
-- 
2.17.1

